Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B36C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 07:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD3580BAA;
	Wed, 12 Feb 2025 08:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="bQf9QRcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3AB180BAA; Wed, 12 Feb 2025 08:01:41 +0100 (CET)
Received: from mail-40136.protonmail.ch (mail-40136.protonmail.ch
 [185.70.40.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8E180C6E
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1739343696; x=1739602896;
 bh=YAuLFJCGZMg5OhKLCR6w9B+Y3vD03/FNjOSI2DhD95o=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=bQf9QRcdNBLqoTv1y14toh8AiybeQZD4MLFG7nit8A15ejMygARnGiZ2bBqSc/icm
 4QLT0Z/TKK8uSlzm+uUwE/G4qpY9d9ADflvCTlojGIQgMgeiTli3uxnWL+o/yulNSj
 rlGKHQNenErbbK3MqWwB5YrzcSlV80msDJHAV7h4OW0tv3NU3N8HoXFbdydxfk/Wph
 2SpAbLUFyr7rLGFqt7/42aN2GE2k+sVphs83L+ITj5+7F0oMIzePm2GAhgWVjv7pu5
 PqJTNQsRVI/W/k4cf6WFWkR/pimcpT6rigPFx6i+TUO5YkOG/xlH9RNFpCSWYf6IDi
 KwIFIn31T682g==
Date: Wed, 12 Feb 2025 07:01:33 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH v2 2/5] clk/qcom: apq8016: add PRNG_AHB_CLK
Message-ID: <20250212-msm-rng-fixes-v2-2-645cf8d3fd3c@samcday.com>
In-Reply-To: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
References: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 3a2c8c3b24563aefc382356825cf9f6a5833730f
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

This clock needs to be enabled for the msm-rng driver to work on
MSM8916, otherwise accessing the PRNG register block causes a data
abort.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/clk/qcom/clock-apq8016.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8=
016.c
index 0c247250bd92b2bc888ecb7dc0a06e808e087fc0..ff5e7ca6f02148427240b80fb08=
efdd356934cd5 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -54,6 +54,7 @@ static struct vote_clk gcc_blsp1_ahb_clk =3D {
 };
=20
 static const struct gate_clk apq8016_clks[] =3D {
+=09GATE_CLK(GCC_PRNG_AHB_CLK,=090x45004, BIT(8)),
 =09GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, BIT(0)),
 =09GATE_CLK(GCC_USB_HS_SYSTEM_CLK,=090x41004, BIT(0)),
 };

--=20
2.48.1


