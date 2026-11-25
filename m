Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2973606A333
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ja//va+k;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=N71iH9If
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C290608B3;
	Wed, 25 Nov 2026 11:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zr5G71f3Dada; Wed, 25 Nov 2026 11:31:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14F08608B7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795606262;
	b=HwQagZhIyoEB1iFbKHzXNDYc6+V4QSiF5B6jtRN+CFtJKM8KxJYGCTiRCObi6kEBgPT1
	 Ei9iJGq30JHlmDck82RGFhFap4Cphwi+tZKQhM5VH+vQVgcGc/mt/To4TJUtYDGn7qYt4
	 Z0qg64v6uk8VrTjfh47LRV2LxOLrgYiPgBcl29myJrH7L1Id8ZbdySy/HEXPvG+/ggS3P
	 vO7E/BxrxIm055sgMkHme0Q01jQcMhBa8MEY2xZwXj11HmDHOrTZ43Ni44RjBPS5nO05G
	 DncEDyKKXrWS+czJoxHnhSMUSrlBvsAbJcGXxgyUeISqLvkJ1qFxXoec6UOc1emO7Rg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795606262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SwtJQGVjCihIMFLRs4pA7dKqyJWdG0GHnRlyT8qJiJk=;
	b=Qvuzh6aA/MdRgwla955wp7yr5NLWRwjGU3tj4hAaUR8Aeso2YfC1F1OkqEvxeD44a3iC
	 wpce8OQR6PWu4jLzW6UhJCY1ZF209Qtp+bzVU/sLAMbQSdKUMTsPRnBumw3d3ISl2ep08
	 Wlw45vjhR8kpFW6b2JUvVSl6eBmUpxUsoJDt3ak2l+Fu2Rtxb9O3+wfsCDdLkPjKSWdXC
	 oTRvH+lTPdFQ4pPIGdGXcX9nHm+x5tnE+lbKwr+joBdP2oL3qT/mGEHCEcPLx5JNro82W
	 JYg3IhuO0pSv20jrOVq7/kfjzw++DPyA8911rcy87HU/hKPowESOBp1aORf97uoe7pw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795606262;
	bh=SwtJQGVjCihIMFLRs4pA7dKqyJWdG0GHnRlyT8qJiJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ja//va+kmLseFuJmyGpkHoOJY3Nq7WxxF9DAByZReqI1wwIUHhURAnBg16eLZgeuS
	 xeyRfLNxsQ9JeHPBpmbz73/exJtogulvgDl1Z+UjCF2zSB03FhHa5XtdCv7uGwWQZl
	 uCKEv4rN1/mVZEfBHltyzTvtsQh4axSsmMzBH6IVhF8keIcOB21sYMRRYcrF4AvaSK
	 2UpI4PmJNTNXpk/UxF4pjbESC7kCHfWLw+Yc2FDZ2X0Jzpm0Otue8pRrJBLRAlG1dM
	 Db0D2+vEZeRrUH8rMo8xZfuEsQLCzA0czTySn36Dg1X3fpVCvwrWLMwLxq487PNvFn
	 95XMl2DgFVkmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14F08608B7;
	Wed, 25 Nov 2026 11:31:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3ED862DF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 309E880CA8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V605SpFjzFsz for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:30:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 39138807F8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=jpanis@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=N71iH9If
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 39138807F8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:53 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so4627423f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795606252; x=1796211052;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SwtJQGVjCihIMFLRs4pA7dKqyJWdG0GHnRlyT8qJiJk=;
 b=N71iH9IfD5C1XFU9dHr7wAyi+4nprJ6+FXLJUbqukfWf1Rta/Ub9llYzQd0FfReJZW
 4vQPv+WrV6abnoXX8iHw1C0NAVo2hKyOL8/qvQ/2Ao2w4UyxcwMH6tJx5dAaxvHnFnKQ
 I1p+tv8xJTO5YSBySNPIm+M7M7phi+0uNriXmHN8phqn03Lo91O4UvpiEPVnm1YPKMlK
 01/UrxSxH8wM0FpsiuhfgPzHj9rrp6qwp+Y90GJEI+fIkV+NRle1oIfAgOrzy7jm7Pql
 NV2ycESNZAxzSTJf8G3BTNZIPdNL6hDDVd1v/q3zPRH0AewI04MlS8IZ3ApwaAz1uQGI
 TB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606252; x=1796211052;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SwtJQGVjCihIMFLRs4pA7dKqyJWdG0GHnRlyT8qJiJk=;
 b=N7DEDp0qMnvk/C5oSsEp57fm/joS0O1Vn4lfknbrBcLbL18kng0u1cAjy45vwGkrZe
 CPa9X919HeJsjeQOSCKf+PWWczB+Qhh2haihriQt7tFcp6bWQ/ESrs9zTsl857nRhMHO
 siI9LfLDZ+XnsEuQVROhEEuGGn/bdg80b9A4bHihwfKPc5zfLHOjVmStYQH89Xq5qJlZ
 SbHgW5EfCRx7phYHagF0NpjNjOsO3creMjpDX7Cs0Gp17KkOscGdjbQMSNBrqb1PDEgS
 2J2Wn3mTa660R8J0w4bSiPbIFqL66ueN7TD61JSYE7tut5YmeRN0xeCIi92P5VR3kWNp
 ORhA==
X-Gm-Message-State: APuU4Z/6Qc3swk5/zRHmIjBJWd3gzEQIp0yi8/3z4M60sOBxlp5kj+3d
 p2FjqOsiluUtCVjYi+58sJxUBzd4xx6M7rfLdpIbjyl26UHDemiNn5GV6CqpvmYSQ1c=
X-Gm-Gg: AZFdTZd6zk4K+kbbojVKaF+LArOA1DIlhsIvXPazaOMSbbOj3OlDvPArNSQXryFudYC
 efLmAK+9VyipCgYuObXleXAjOELSa39KKodLGC0ZvzrraW32a/8d8jNrNK2dgTolFZoFTiRqCIq
 TmbDOiFMkOQdJuPw0CMQDD39dtG9PiQtDRVAcnY2n5GOoiSNEQ9/V88OhSgIIcDDdJ/ia1SjKPM
 FcMrjigdup9QrJzA4Ch2I+mrGZhpqhegz5yo+1jmXFlQW+uO6BnF1fqgMkSUCQ0DdfcDWGUjq45
 3ZQYfWsbhi+dVtTDRhGU2/xneVn3+r33W4KsvcpP6DvE7fWNjEbCpAl3I8VHe0hl9uXxCOr0zi/
 REEq/go5yuZsEIXzTRff4+4GRjFh/H3aYp5M4G7GJUmw84Injo6KccJRd/E386D7cI/TeSzZzQ3
 MIVE/qF9gOtF76tOikB1jTLxLHb1mi1PYrtN7yATbd2O0FrYrUJSXTJc9PjVu/0PBIME8cnI7hY
 stL04qsI2Mp9Skfn+M6Xy+kGnYFCf3iXME2rwOvdW9sGh2DMqX1nONKvT1unTXlbyGyIGAFQKbP
 jrAvLA2PWJhsnhqBrjJcYJGmtjtq+v8KWaxj8d4RC6b1CbllhZQWzeaglGmITag27p/yQ2ODXyD
 Hucov9EaMwSZ3/KC/g02OhNjk4tIoladLQG8RDQ==
X-Received: by 2002:a05:6000:2dc7:b0:4a5:bb9f:9c3c with SMTP id
 ffacd0b85a97d-4abb4c7ac0dmr42218202f8f.53.1795606251927; 
 Wed, 25 Nov 2026 03:30:51 -0800 (PST)
Received: from [127.0.1.1]
 (2a02-842a-aa82-f701-cd04-e538-7ddd-cfa8.rev.sfr.net.
 [2a02:842a:aa82:f701:cd04:e538:7ddd:cfa8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm39870905f8f.21.2026.11.25.03.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:30:51 -0800 (PST)
From: "Julien Panis (TI)" <jpanis@baylibre.com>
Date: Wed, 25 Nov 2026 12:30:31 +0100
Subject: [PATCH v3 4/7] configs: am43xx: Enable PHANDLE_CHECK_SEQ
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-4-7f5c72c1116b@baylibre.com>
References: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-0-7f5c72c1116b@baylibre.com>
In-Reply-To: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-0-7f5c72c1116b@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 "Julien Panis (TI)" <jpanis@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Andrew F. Davis" <afd@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Nikita Kiryanov <nikita@compulab.co.il>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795606245; l=3106;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=4tHQglmZkUrUsx4rx/5IrbUfs+U8JMIN9CtDHxXGIM4=;
 b=FeM00jxJHM4mRpiWlAd8TpYt6IdJGG9U4WLXCeDW2B7Hwr1qkXqlvIqUzwbxFj1jLZp0WiedR
 oR18XJMU+hADMIjdb/4EjTCU6Xlfpn/hSrIUzyOwsGpplctAUR7/zS7
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>

In upstream am43xx many of the actual devices are embedded in ti,sysc
nodes. This leads to them being for example i2c@0. To avoid conflict
PHANDLE_CHECK_SEQ needs to be enabled.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Signed-off-by: Julien Panis (TI) <jpanis@baylibre.com>
---
 configs/am43xx_evm_defconfig              | 1 +
 configs/am43xx_evm_qspiboot_defconfig     | 1 +
 configs/am43xx_evm_rtconly_defconfig      | 1 +
 configs/am43xx_evm_usbhost_boot_defconfig | 1 +
 configs/am43xx_hs_evm_defconfig           | 1 +
 configs/am43xx_hs_evm_qspi_defconfig      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index 741f8f85f801..743ef0a88f2b 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -102,3 +102,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index 817b97b4b277..e612dde93ee0 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -68,3 +68,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index 11310935e7e8..e4102c902485 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -84,3 +84,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index f2dfb79802f1..bbf57a8ed797 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -104,3 +104,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index fca9ea21a778..af93fecc8e9d 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -101,3 +101,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index 715e2ac4be21..ad84ee36cc48 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -70,3 +70,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_PHANDLE_CHECK_SEQ=y

-- 
2.43.0

