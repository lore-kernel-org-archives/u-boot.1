Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5B8C0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 07:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B80BB80FF7;
	Mon, 27 Jan 2025 08:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="tLxk7pqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42051810FC; Mon, 27 Jan 2025 08:48:55 +0100 (CET)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E088780FC4
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737964131; x=1738223331;
 bh=nv8DzlBVltsO4qe41eyvtEyo3pVB+ny0fvYs1soafgk=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=tLxk7pqmb7Fg92BEeCFsJLZQmNX4AMToOkPJ1MTBnGupHO1tmXNJmbsMfQOwpCj3e
 fGwnE1P5j19lHcr1KU0IeqCpxax6JJmvnnab3E8iBEwa8TLp6sc797hrp6MmkVV/Jt
 jAucbsFPc6vHCTp8Zi6hoYwv2VlmyRcyIC+zWTKmuHu6Rs1nUfA/KrOKgt18hPtxVs
 2BoNb7Eto4ZQtBdIG93WjX3fk2TpQVyH9lhcdvvveo6atTZgC8sLvSESZqc4gKy/6R
 HhxGaTeK79oQl1hZGAGDzE/NPzVVqol0tuFTS0bi2aLMgAUMH9Glcnyt7W5jTl9imm
 6LyuC5kdWV7UQ==
Date: Mon, 27 Jan 2025 07:48:45 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 0/4] rng: msm: fixes for MSM8916
Message-ID: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 814504299c6992d1fa0b31198a695ddfaef9e947
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The msm-rng driver is currently broken on MSM8916.

The first issue is that the core clock isn't defined and thus not being
enabled before registers in the PRNG block are accessed.

The second issue is that the enable method is only initializing the PRNG
registers if the block is *already* initialized. This would have likely
caused issues elsewhere once the driver was in more active use, but the
problems on MSM8916 are immediate: trying to modify the state of LFSR_CFG
causes SErrors, presumably because this register is protected by TZ.

I also included a couple of extra patches while I'm in the neighborhood.
One is to improve the logging in apq8016 clk_enable (which would have
better surfaced the first issue). The other changes msm-rng driver slightly
to only enable its core clock when it's needed (similar to how the kernel
does it).

Signed-off-by: Sam Day <me@samcday.com>
---
Sam Day (4):
      clk/qcom: apq8016: add PRNG_AHB_CLK
      rng: msm: don't enable PRNG if it's already enabled
      clk/qcom: apq8016: improve clk_enable logging
      rng: msm: keep core clock disabled when PRNG not in use

 drivers/clk/qcom/clock-apq8016.c |  9 +++++----
 drivers/rng/msm_rng.c            | 13 +++++++++++--
 2 files changed, 16 insertions(+), 6 deletions(-)
---
base-commit: 8a2a71a4eec7afdca6377ee46b1ed7e78ec692c9
change-id: 20250126-msm-rng-fixes-f5a722a9492c

Best regards,
--=20
Sam Day <me@samcday.com>


