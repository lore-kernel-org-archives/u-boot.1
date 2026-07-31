Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19B7C5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6920E60825;
	Fri, 31 Jul 2026 08:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dSaLHQcCPISk; Fri, 31 Jul 2026 08:30:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 220286081D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785486605;
	bh=NK6eAEtaEJd/XFJHN0UdHjy86pWHL83vQxZit27WHHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VTxYO+BdG9S2tp3fRbl9g9Q4v3p1dMn9jIS9NpGpzG1VMgHKiNa71kWK+wig33o28
	 2XhbRYwHXYOb7TcrdZ8XxmDUokUmIRucBgfaq9naE6Czu65cNOt2u4o6cedazpVcoc
	 pP0cSZvm2tFX95WeuOdIjdt+8SnuSDqz/IgiJTMQ1b8XKQWIT5xRr/excC4Hfqdn6m
	 /dXAoy1uIXYqlbSPvBSOWJrFTrxV+msd+OEzf+zGwkTa5AJSCCT19TGwj9+xcjyXca
	 gQJXzSRvG4Pz5MFwUF4xb4o7fx/8WIGo2OPUc2fom39d6cEr2kz5dJTzkkdLJOcL90
	 KH0zoduAlbx+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 220286081D;
	Fri, 31 Jul 2026 08:30:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 179BC26E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 151DA80DEF
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AeL4E4wRDv7G for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:30:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 220AE80D47
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 220AE80D47
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 220AE80D47
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:29:59 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a09ba1ab24so392058a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 01:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785486598; x=1786091398;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NK6eAEtaEJd/XFJHN0UdHjy86pWHL83vQxZit27WHHc=;
 b=q/RTSs80uDdXwZgLILD4Y81OcRRLpJDl3flQRXG3o1pcdAImqVplh0z3ZG5yLq73lm
 yV2kOWvSrL9UjhEayj4Ts83UAX42RB0J4MomjWlOCVeQzJ6Pe6qsyTZzdHiQkzddn5dJ
 Cl+2wUZwZZ8yuQq5756wCfvAeUujF9l4G7s2Wlmn3XgkXEXf3CC8V0UbTsWMmjDRZh0j
 HEPcIw9PiQIYn2rnX0HUghXR2cSVP3MPGiYcG/N93tDrBvuZz1WOzfyPfWi1R/367/hT
 qTAWqhWLtEDHpKMRwjjTz8p6cdZ8p3Lj47jaEp4lqPupxFpCKyD9IoZcgs6FTeduERBm
 ki3g==
X-Gm-Message-State: AOJu0Yx7ZBSIzMEWX2A1g4Am8bVdjmsTGom69JKPxoGa4OMXEX2CUoVe
 XYgT8s+wTSCH2CqAjFQVse/CCxw7R/8gaxjjfBL/JlthXvNgJ1KkF+kYI6LFEhR/e+0=
X-Gm-Gg: AR+sD116yugraMPzg0b2Pua2MAlyM13TTYAAFV8CYRZi9pxtCXwvuHWXsQsJmfLWz5N
 Fu81y8xHVjpLLOJhnmIaLjKfBuuatUkB8CAqQAdMVWWd+5By0mgLEGiIwCRER1JWmEsvx0x8kXH
 +2Q7grIQGOaeWYgC7xzWm4fJhvfpvv/nZRpAG105g3M3HJpdESGURIfPEcU68j0jt0aSZ+cSiL9
 Q+AOfF8Bvaa07Yx7DXBXSSvcldF3aGd9iowB25txgQxZ5d6s4RPbchfD4GpiccCdKbliKd6a6Dc
 k7dgIligDftT0A2civ8UJFbMakUikp70orTOWUl3cQXV6ECGysyFJMZa8xdkbxopORqCKkV1dhr
 yxshkFC80tRnZ+VOvMgdB4bU779BdIV2tlNocap4yBtI4325tNrjy9m7z0AOLd8Q0uUxj9JaVnV
 bMjjkyqz5uNPv9S9u6+9JT447M5edYYE4AuPBUoBPTQupUY1z+HUHuYLJlYg91ma7K18+3+/BzV
 PRkdraDN20kwJEL0N4EP2v1+kYfySqUwUmfhumg50wAviMNwnI9sFED2JEgq20LCncZf4zOonVW
 WDl3RtwxtjY=
X-Received: by 2002:a05:6402:4008:b0:6a0:79eb:2e3b with SMTP id
 4fb4d7f45d1cf-6a098d033c8mr479847a12.40.1785486597832; 
 Fri, 31 Jul 2026 01:29:57 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c661641sm583646a12.29.2026.07.31.01.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 01:29:57 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 31 Jul 2026 10:29:38 +0200
Subject: [PATCH RFC v3 2/5] fastboot: use the common handler for USB reboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ccaione-upstream-spl-fastboot-v3-2-dbea3ff4529e@baylibre.com>
References: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
In-Reply-To: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785486598; x=1786091398;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NK6eAEtaEJd/XFJHN0UdHjy86pWHL83vQxZit27WHHc=;
 b=RvkPIxHY04ocutYJarireTd6TF7/zfDPtsYifHkCgedhpCXQd0fwlv5DBWlFI8lddh
 xAs5zXWn2az3jVJp/ijO6LomUc1FJOj5kGi3bLLWgi70X3F9m/EUhWHbm2/kyNSrp1Ub
 bjuhCibXdllBV7EmmAkPRArna9kg+R3JbkdJHrkuLjnvtOxxRKViF5MEjizpn3DLM8se
 ieKcGKoUktAfVqrgjlv3sPyp6i4Hy+2vLEkUb6tXXmeGLkqndXlZyLJXg4IY5fDlo0P5
 sw9rAM38jGmjv6BZKmsbCLFy3pNJsuiLmQelbKXTsDHUhqU5r2mg63Lef/CMSgEK63cz
 VLhg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RvkPIxHY
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

USB fastboot resets the device directly from its request-completion
callback, while the network transports route completed commands through
fastboot_handle_boot(). Keeping reset policy in the transport makes it
harder to support callers with a different reset interface.

Send the USB reboot completion through the common handler as
well. U-Boot proper retains the same do_reset() behavior, while
execution-phase-specific policy can be contained in the shared code.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/gadget/f_fastboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 8df0e3f331d..471c0e87042 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -422,7 +422,7 @@ static int fastboot_tx_write_str(const char *buffer)
 static void compl_do_reset(struct usb_ep *ep, struct usb_request *req)
 {
 	g_dnl_unregister();
-	do_reset(NULL, 0, 0, NULL);
+	fastboot_handle_boot(FASTBOOT_COMMAND_REBOOT, true);
 }
 
 static unsigned int rx_bytes_expected(struct usb_ep *ep)

-- 
2.55.0

