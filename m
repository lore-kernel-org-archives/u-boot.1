Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AC9C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 07:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 821B580842;
	Wed, 12 Feb 2025 08:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="EA83tvko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBB9809D0; Wed, 12 Feb 2025 08:01:31 +0100 (CET)
Received: from mail-40136.protonmail.ch (mail-40136.protonmail.ch
 [185.70.40.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B58C80824
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1739343687; x=1739602887;
 bh=iTJ6UbLH4HeckzUFtm1hdyy0Ny5PGa8F9F5rhe1vwPg=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=EA83tvkoN2dU+4DIZGnyCNB5//2j3eylUNwrYTY4perqqzM7ybaf29GxNT/9Ec6xS
 TisW7xQUN1bUBegP8Ohrvx7Q7RFX+LGA66+1IsbfWwagVj7L8x1/rmUqW75lKGfu8+
 fZdkdZoGfe1CraoX535vPMlTRy09Q2FLx1oZK0H5Vw1OU/psoGW6SDlWEKgOejQaTG
 iJqIYWR58mMjYoA2gqCA0VSYYMQO6rZ9duR1yn+aloGxdtdgjNRMe9Fsou49zsE9jL
 laRz/b79ZW1PDjdgOU/mOZ29E8ABhcLDiYpfRgFIMIwpU0kWdQ98F2+7KkX6+2Zs8p
 UUk3nex0+gn7A==
Date: Wed, 12 Feb 2025 07:01:20 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH v2 0/5] rng: msm: fixes for MSM8916
Message-ID: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 47298484261599bd4b872b1fefd504a513d5f75e
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
Changes in v2:
- split hunk changing clk_ens of existing clocks into separate patch
- Link to v1: https://lore.kernel.org/r/20250127-msm-rng-fixes-v1-0-00f5d22=
84314@samcday.com

---
Sam Day (5):
      clk/qcom: apq8016: use BIT macro for clk en_vals
      clk/qcom: apq8016: add PRNG_AHB_CLK
      rng: msm: don't enable PRNG if it's already enabled
      clk/qcom: apq8016: improve clk_enable logging
      rng: msm: keep core clock disabled when PRNG not in use

 drivers/clk/qcom/clock-apq8016.c |  9 +++++----
 drivers/rng/msm_rng.c            | 13 +++++++++++--
 2 files changed, 16 insertions(+), 6 deletions(-)
---
base-commit: 636fcc96c3d7e2b00c843e6da78ed3e9e3bdf4de
change-id: 20250126-msm-rng-fixes-f5a722a9492c

Best regards,
--=20
Sam Day <me@samcday.com>


