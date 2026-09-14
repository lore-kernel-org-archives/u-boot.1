Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB60BC88E78
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78B3380E38;
	Mon, 14 Sep 2026 14:17:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nB4FnFJvfpAV; Mon, 14 Sep 2026 14:17:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5C10280E35
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395445;
	b=gLi3FKnvZpLkaizxFuAJowSfoobU2PV9otOSfOt+diQ0Iajfdgh8jATjEOdjk1nrYmRy
	 IFGhOqphPsEAd/wuyDOTfmy1fJUHMQatArAM97xdZuCN4FapnCxDSuRlkLFC8wW1xPM9U
	 ROTozTau20m+up0NPaRx/3XOJC1ou7Z5tFm8FwbU0sYq4wYEke3Mb7RwSd6JK+kOm2rXq
	 6kZiynSDOT3MasHxFqaGkmpbO3OkrGEUywX+iiwEu44IRWItsyvOuIT4h6p6Xx8iwbk4F
	 C7kBCUJIPxSyogDk1oKWhcWsWgUUbQhJ82s+HdBKJcxFyY0OVFCSnk+Y+jw3XMxbX2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395445;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5Fi6EtlAhHiDMqr+M8aQsEKWI8vjqBM2xzw8lGEgpvQ=;
	b=G/BI+HkJ9bV03KQzaHCFbLiUwqngEDKGpQdU59uT4kVTgWR71+ltQ/GDbZO4r6ikETJT
	 Id8MwTEXX6Cz2EypY9uDWAvsoEyHQEZSj1+cZ7/H0YRxr4cZqKpbG3wQpTqkp6ghKrmjD
	 WxT7MAq4suUGkM8jU2OaIBskWA6TtqRa+eNRZZcQ4Na2Epdtby/l4Gdem2CxUOxGPbCgH
	 qLT8T9bytitN+mvrV1PettI4Q1FEsz/qrIv4ERZ3T6mvsJbBYaDHFwnLkLO6L0OmJFOLg
	 3/kxYhwAOw0cliMv9oFk6EAIbRm0KtQX59ZK/uHcAd2DwHB7erFFpqUeHKR6rXxo6TQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395445;
	bh=5Fi6EtlAhHiDMqr+M8aQsEKWI8vjqBM2xzw8lGEgpvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iV+CDGKWqDWtl68uA57ugtvCRBB+KhKFcCaXjeanJDJzt7htHtsxrg5Y78d4t6QcD
	 7srse63NX3R1jduxx00VOUAAVggE3LHST7ZFK2SLJPRrCjvtNIoOppvMiFoJwdVAPx
	 qNNosDLj5cSyUks7Hup5FaSazycoIg/GYzOa4WYqzEuBJFBkZFZA9lryxOESGKfUDB
	 EZ8mfFMTPfiB3kJxFhiyJtl6cgJlT8adOZ/utRUm4idQEZ7PgZ/Q3mulIClPwPSSN0
	 EbFeDS9xTIAnWRn4sWDZLiYcIoT3dhRjz6xmGK8hUy+2CsLpEmZSwUpcHCuenBheha
	 vWgDCu4YSxgeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C10280E35;
	Mon, 14 Sep 2026 14:17:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F41BD224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA8CB400E2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GiqDsmCj8qQX for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 07:43:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 00C694007C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789371810;
 b=PuJJcDIwJ2DDjGRpk8aBCn6qBLfghV0eJR0eyUyOaQxK/9nG/mWYkWsgaPheTP7vfFKh
 L3GTE8QzZl52RB8XYNBjHChs3jTiZjcH0vllMJoUcZxf/QzFxUWgve7nbXm3WENSe1f0d
 vFjdMlClpyA/D9car6WNtNTCD9oD4p9rHiAoiEJ265XWwSUUZl5ZnbQVtUYVW2qvzqiO8
 JVrlaJWBjfWwcS4nSwXzfBvQI0wEl1T+0CcO5/JhdMBzwu/8oE/Td8qI1nKmDh8l4Wiwv
 Pcfvoep9kn7apMY+q+iyZjTytvd9FHZLN6vj1yasjtVNbtcNrgyITRm96y++KuqvAhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789371810;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=5Fi6EtlAhHiDMqr+M8aQsEKWI8vjqBM2xzw8lGEgpvQ=;
 b=sXOGv/+dg1zbHhsgpvFHZj0TdjXRzo7ql3/1680SIrlqo0Oq7AmWydzeYQpUxn/FYUgh
 LNnfoHL1pMEF6pJY5cuOgYJdcaKnVlD/5Xq/G6zFBVY5/mdpatl//OJi74e3MnvhyWKZI
 hrNbDjh20RRcz8JkWy2TMbXp/PNXEtixzI+tXbDqkAfEAd7LMQvGAM0u9ad1n3NjGw0s2
 Dm0ey9+SFLV4WZat5lKFSOdhLIAOuszWGASfa9E+YjJLn6foTw+pRBOwTxXagoRB8GSBI
 i3p+IwAF6CZeOLA0NBytT9aBCG6XpOz7XNTStCNiEsO5+LP/ZqKIBrX14TxjV0EHNzg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hsW8LmXA; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hsW8LmXA
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00C694007C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:29 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so8498455e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 00:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789371808; x=1789976608;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Fi6EtlAhHiDMqr+M8aQsEKWI8vjqBM2xzw8lGEgpvQ=;
 b=hsW8LmXAHFsBmKWnVB1SkKjirxqW64JnpzCNCTRN30e4vVcC2KlKAwu5gHy2rHc18I
 i51AXp7S/jlWSrc0+NQTvErYLMkfo8Q2k+MM5TRjr4uHYE55mm8yFLcVriEu+/jJt3si
 z8GtKF0td+ZCoJ7UTa5VdTsU8HcW7/lKWJcDGD6H2sqoMn1CDL8D2OFBOzdrckQhPYAw
 UYgorU3NMLMv6gEODgCG2vKFgFTozaHdKXDOtTWn23ghlg0r6QjnkMOhcnzNV3J5weKM
 m1VXoA8ZRiGMOmswGNR+uEnSvpITX5/t8DLnRlv8btxVuMuXrKpT2er+xnpGXrM3H/MV
 WhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371808; x=1789976608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Fi6EtlAhHiDMqr+M8aQsEKWI8vjqBM2xzw8lGEgpvQ=;
 b=BlwaU+Hj+1U7j0IzfcuFeNWSD2QM99s2mi+FTqt/2x2kYNdCOAAKjTphrdVzkmsF+k
 seOc4obZ3rrUZV/H93298WCrIteS6hfU3IlHpOeB6pydsWfz3K1+sbW4YyHYm3qBlaNu
 MpkZk7/4ZBR8Sqay/3GD7hvExemoM/AGOOQlddvoQmK9NDY8w0C4jNa5ziOgdsQ9/BIY
 Qw2ReF6svLPKC4k7/eKl9tDX/C4Nm2iWB4+KTKriq6mIthNryPrJOGcJXnv6oPepxeyD
 JVPWpfYb4aKHRMlp1rRrpUeHszrbc/cZo+KS7W2w4ajxAVmzAR2F5eDbLsTO8m/VeNBZ
 +MVA==
X-Gm-Message-State: AFuF++mOig4/FF0j25925mvy4XaJbtnsFTI8v3io7NZtZFEoVzIL+8tA
 8PIcuciBLrXEOwDZadxsCiNWNVaCi9hEmDved7CoeZLnE0WDxX+9fTIT
X-Gm-Gg: AYBFou2PEAg5VUKKk+sJSF3Gyc0Xl5zjWDBLQe40NeDiTp7YG5SQKq4bNN4AzCGr6mu
 6+xxNUajbqJql1aalsAuMfrRK+Yut1p9JcmxESXR9VTnO09kxYoo8g2zdunIvg9eYM+C5FCJCig
 0urpSza4kJPtPxPAYj1+tZGRoBfhRlhnxwEPRJCfW7yXELC5xtn2ZIF0iYXrdlDAxpyM4Wl21Dx
 Zv10tVMmBmYT9dOuHMtTdcVo6sh+/yh0LgYsAMi6KP0UNexFaEyBQUcVDMUpkRW1uXY7ltpSs+C
 0C4HwlCewkJgAqYt9AB9bHVT4yj7v8poLFnC9QZxxoADr9DgH9EEfLenddYlpMH9P6F+RgXn6uq
 21u5jKw2nfhIPKUsCYkdQSxDT6sPwOIDjVRF+itJCE21rJcS36K1DrkkvIwAI/HsMjrHRbXSHVM
 S7yxZ6jRUA8Xm83m4fBFX8PmhszL/ud+XaZm4TibcqXohxBJg1SF/V6Dn3qHb/0tfB
X-Received: by 2002:a05:600c:3e0d:b0:49c:dca2:ac47 with SMTP id
 5b1f17b1804b1-49e7a63784dmr13982345e9.2.1789371807705; 
 Mon, 14 Sep 2026 00:43:27 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02c92sm184611495e9.2.2026.09.14.00.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:43:27 -0700 (PDT)
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
Subject: [PATCH v2 6/7] toradex: verdin-imx95: enable DWC3 USB controller
 support
Date: Mon, 14 Sep 2026 09:42:48 +0200
Message-ID: <20260914074314.12522-7-eichest@gmail.com>
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

Enable the DWC3 USB host controller on the Verdin iMX95. Enable the DWC3
driver support by enabling the wrapper driver CONFIG_USB_DWC3_GENERIC
and ensure the device tree nodes are kept enabled for U-Boot.

CONFIG_USB_DWC3_GADGET has to be enabled along with it. dwc3-generic.c
builds its peripheral driver whenever DM_USB_GADGET is set, and that
driver calls dwc3_gadget_uboot_handle_interrupt(), which is only built
with USB_DWC3_GADGET:

drivers/usb/dwc3/dwc3-generic.c:220: undefined reference to
`dwc3_gadget_uboot_handle_interrupt'

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi | 8 --------
 configs/verdin-imx95_defconfig                 | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
index 8ab70cf7399..ab6e1054a9f 100644
--- a/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
@@ -90,14 +90,6 @@
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
 &usb_recov_ctrl {
 	bootph-pre-ram;
 };
diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
index 77b22a2f8a5..e49af4a9861 100644
--- a/configs/verdin-imx95_defconfig
+++ b/configs/verdin-imx95_defconfig
@@ -172,7 +172,7 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
-- 
2.55.0

