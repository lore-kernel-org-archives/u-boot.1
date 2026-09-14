Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7D1C88E77
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 900FC80E21;
	Mon, 14 Sep 2026 14:17:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SqlyCKQsB7g0; Mon, 14 Sep 2026 14:17:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A7EFB80E40
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395448;
	b=gqQPjgjZWycHFc8yPQzc2OUTPyUOhlsadIYxI6gSE30jJHCjCk0bnF7j6mxhkk0qFkIK
	 dCXQxu66c+uj792ObhQqaggBX+2nJ24a1iI5YULw6CasLvzcuCBb8CCOuHF6fsbNy+tu1
	 B+zVHMkQky9jyNo7oetBq9ReBmAbASAGb/+zbvz5opqKqj+lPpGtzrucs0P/bNjx28R+F
	 qUfTfn3E9v1m1WjNFL57my42KYvpwlXCb/rQ27y4qvJJX3qC3UqyvT3kUZRIllq7eHNGM
	 UynsBMgLCgUT8cAKElrevNJQAkE66x+gHpfSwQ+1m0vJG+KCOf4hfNFtyHunC67d9ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395448;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AZQ1Z4cPMf/cWPnmDg2nJtP10hEkAj2u1x6SCgR/RG4=;
	b=FEa3Nrpf76Zm2fswTY9cxWPsYpIJL4Jdd5oO50RmtvIwyjih6LXIwi0FUpb4kIVmwYey
	 J1vQif7LyLTZQAssNeQY9/zc0xLoH5h1b+bcmkF2Zdl17tUB7kNv7WntjoON+mJcI3I2z
	 x5CPsZN2R1x9dIcRZ7TrWi2WFZIzvUxezXi0atqh1qwxzxz20AhmHBbHNC1/H/lpXDvjp
	 Gk+cXcq0MVZkosVbXN4xDpYQxfCwOkKUIUSResqTef2v4/xofZusyeiJvoeOB5fF5amvn
	 3us/ZGdcDgUYZydbFRTD0LiEt9YpOcumU5mM+udJNghTCsQXj/W/WpVbn6YkWzOXnGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395447;
	bh=AZQ1Z4cPMf/cWPnmDg2nJtP10hEkAj2u1x6SCgR/RG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nV+4yJuGI9BS/AkpOvD2IHDLIONEUkWyGkbC22IbebhAG23TArdgK+PgHvF7zk0BQ
	 IaygYQU1lPygoOe3BJ1+YiJCDF4IZuZF5Hq6TY6XKHPxURI3pdknNZqigoYKp7KT0M
	 8aFdHnqJNJ9+EztX676bxeDG6M8ElHKEux/yRbiUuiY6F312lVLp7lI/iio87M1MlU
	 r0qlTGfZGC8kQrbnXfKrT5sM2g7e4LXSaXDD2FHmMl95wun9bnGMNz2B8zvWL9ZpMh
	 Tv+ja6bODpnVnu/ogH+7wwWYDIrFcjM5xtrT0FgMVAFafD7mPjktJpeRmYXxnCiLQM
	 ZL4G5OErPwRRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7EFB80E40;
	Mon, 14 Sep 2026 14:17:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 66961224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4CFCD60664
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tpna9bFkzSg4 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 07:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6769560650
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789371811;
 b=bKqCpbdPZfMS98+X+yJw5dnUsIX7uXQaFkPK/ugZXRIAmJonbDk4Cvq5QxXES2HzRu4S
 cosqjG+PcJdaE/fwXNFc7vFn/q/Td7vK98Fc2/+4hHsrZ6IhVnKp2xnyDBROF81kesLta
 gb4nF/lFO7tn4Mc43b5K+z9kJhOEwHTM4TZ3VvvBDAykNVV9CW19qtqhTCsAvXpS0wQt2
 gVpvPF6Z+sKeEMx1G/BcwEXxf59KnAi/XS7K4Ttv3ZcQMoMwO453fwnXyvNnIDe3gE/63
 SUju/VnYWOGIKWm1eiCy7MZ2XmquPINMAHzCpjFd8QCsi4UC35mc73USRB+2fMR0Yyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789371811;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=AZQ1Z4cPMf/cWPnmDg2nJtP10hEkAj2u1x6SCgR/RG4=;
 b=qJZC+6FJ3wfq6CpnML4b2Ibcz/ZgSwZgFLy2Z/74NiWagG2bm1UwEVIOJgw6eSYbraIq
 aHiu7B+aZP2S0PNhbHNaby3AKJCYNvgmtrZZth7wnED9toRaQbsY90x2IgSmkHMwhhW+H
 M1YiCU3fLB68A1xfi6HLfF7Cjq74VFOHnc8KSq0ZaIoPbdegmEpgUkbsqWaPFtI6qtO5j
 MSoO9t0f/NaM7vE6zZ1Ts6luf7DaxjxFpeVCcYalIUbQ7PjcgLWKehuqXAhd6yiCf21A8
 fh6FgVd0TVR0XU93ferQsLZWOApQAkfjHRr0gYV8s3ASegY/UuS3f9WgECngfN1BjHg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ChOLwjcO; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ChOLwjcO
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6769560650
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:31 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7acdc816so837095e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 00:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789371809; x=1789976609;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AZQ1Z4cPMf/cWPnmDg2nJtP10hEkAj2u1x6SCgR/RG4=;
 b=ChOLwjcOC9evGMMjH52ObSoxPNtGHK8xlPMII9wlqrUPsc5pkI1/1lG/EaXoHE/yGu
 JOFVuSTFSY0usDQsYfgUtvZCORQ5W++8cKcRabEKU66XSqbgHA8l+5e3KfOi+t0Udryy
 SX/JakSGiLuwltXFGPRclZGJfpqzDyH6o+lAraNfIh5cloA7Nvvu0JY6Rd+eG5Jyn1CR
 G2/eYQ3MhqmNr6zGIJ8PZ1o7PuWiS+fRLdy1RgS+ILa3ilUi/BhkbDxDMfAIvnm1AFzI
 8TSBpIY/HDkvWTN8dknCqXsW4CX7X+L+U3ExEVmgIvJ3/5TYw4Kxt5ZlSH39uDhg5GSe
 3HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371809; x=1789976609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AZQ1Z4cPMf/cWPnmDg2nJtP10hEkAj2u1x6SCgR/RG4=;
 b=YOOdAeUKoNRPLFbk4oMtVAdcERBN0uBH1xMqxLWJaNy88+wHSQDbw7xjG1chqxbKgP
 /TX7Alhif8sQ/yBebk+ra0IoD839Jm6N6XtV1YqeDZpSRVT3OSlJ38mSZom6teoS/eQZ
 l8WQUd4T1dqPfHH5Smv2rikJ74qSRUSm0xG5QxYGaA5SyEhOeN0edgbn3X1kNHdu37pt
 /WpOhouPG4wfznhO+wI4QhcJlYylrdMbhR4NP82BlRHbpzY+bkjLKB6j4bFfxzoP+W8x
 /xXvRpGAGeRgpoSQNIAfsOXX/LQIyEx/YdZbN7hDdkU/vkKuMUHm+YgrsCEu4QjakvXR
 dx2g==
X-Gm-Message-State: AFuF++npHkveIK0Ofqn+US/0Ff54SlhkuAI/RgxJbPIzqsThPuOZQGXt
 yXMlhsGFYKCDcNSKCZ5xP91aTXfoNDLOGYeeh7lBdJrZA9bOBkR4GiWk
X-Gm-Gg: AYBFou1g3akt4jpYKFHOuo29TpC0IenHCy+a+hY8I2Pb0GIOVypiXbaYyAlqFmGLsgk
 E78QjscmPQc7ms0e7fUM2lLRDOnThwuRhrvLqeL5zsySCs2+utfz4zMxYFeylel+CHQ3IJ8CZSj
 AImAUWGIsb33mVrwMdJHX970/eH1rQuRMHc7vy7bz23MfQWqi7RFZBtQ1WrimcSfHye590L4CQJ
 KsFrF7lvwRCkC/zkuhXmdlK0RHX9qm/NuXXZQ9sGiSj/xCZg5YEIkk+gNJH7v2UvlQf6XYlWwQo
 a0jRDXxYLRp0l+T2vF4t1MWTpe1XM2QYJdPLQTQNr+mAvYb0giQkmsjS7OWUr6WLnpDbnKKQRdn
 1c0bnke6aEgm4M+hZllEBMMZ/ciIzipH71rmFaRJC3ukjglW5Pp9d9LH3HCFNyx2Sp7PMje3FQe
 RoxAwIOEMuUobvAcNtKD9hDjtsKDB+LzHqUlEmTDqX6ya+DYVesA4vVOSyaHltb70OM8aGY3coS
 gE=
X-Received: by 2002:a05:600c:1387:b0:49d:1916:2133 with SMTP id
 5b1f17b1804b1-49e7a65d32cmr14113775e9.8.1789371809049; 
 Mon, 14 Sep 2026 00:43:29 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02c92sm184611495e9.2.2026.09.14.00.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:43:28 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, lukma@denx.de,
 mkorpershoek@kernel.org, antoine.gouby@toradex.com, alice.guo@nxp.com,
 stefan.eichenberger@toradex.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 ye.li@nxp.com, xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 7/7] toradex: smarc-imx95: enable DWC3 USB controller
 support
Date: Mon, 14 Sep 2026 09:42:49 +0200
Message-ID: <20260914074314.12522-8-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914074314.12522-1-eichest@gmail.com>
References: <20260914074314.12522-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The iMX95 USB controller is DWC3 based, but the DWC3 core/glue driver
was never enabled for this board, therefore enable CONFIG_USB_DWC3,
CONFIG_USB_XHCI_DWC3 and CONFIG_USB_DWC3_GENERIC to enable support for
USB in U-Boot for the Toradex SMARC iMX95.

Remove the dwc3 nodes from the U-Boot device tree to keep them enabled
now that the driver is there.

Also enable support for DM_USB_GADGET now that the ui_udc driver
supports the driver model.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi | 8 --------
 configs/toradex-smarc-imx95_defconfig            | 4 ++++
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
index e4eda61e5c4..d9fe4abe877 100644
--- a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
@@ -88,14 +88,6 @@
 	/delete-property/power-domains;
 };
 
-&usb3 {
-	status = "disabled";
-};
-
-&usb3_dwc3 {
-	status = "disabled";
-};
-
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 9abadb0ed1a..0da5fd8407d 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -165,8 +165,12 @@ CONFIG_FSL_LPUART=y
 CONFIG_SPI=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
-- 
2.55.0

