Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F79C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 21:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C415608BE;
	Wed, 22 Jul 2026 21:36:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x1Vit7R08egP; Wed, 22 Jul 2026 21:36:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C59B608C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784756208;
	bh=RsBXVWxr1E6IyC/zDoul7GGRaNZqLkVMV6DTp2+z3bY=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LI6gjMRkHauV24DLpR7BEh+38YGtXqcz8TxpgjlvDnY2gcAhHEeqjKM4VbH6R9a/c
	 IY7+OYtypxm7gbj4ygC8YrsVvaxV1v367CV4cHKcsRPsqiUSZ6S4Cm+p+0L/aeOqNT
	 gF6ZYoFjnPuH1q5kpGXv2bi8kdPVsx9pZ3QG7ekGWHs/v+w4hEI06RmCsFQReh5UeN
	 bHa7cBckdwYSwsSodjMxk/jNSz+ciRGy/FpNrXsHprDNJC/Gv3HnhX8Unv2UwnL6Bk
	 cVqdev5TZWwHOLaOvyatdcFdALNcGXxAdCDTpfUBhC89X+GUFrtuxyXx6jE2hMSu+p
	 vAwQeIfphl96A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C59B608C1;
	Wed, 22 Jul 2026 21:36:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C1BE224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6DB7980F4A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u7JlFD1zuq9F for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 21:36:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 85F7D80F41
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85F7D80F41
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85F7D80F41
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:44 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f707e5d75so2846485f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784756202; x=1785361002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RsBXVWxr1E6IyC/zDoul7GGRaNZqLkVMV6DTp2+z3bY=;
 b=Y0NAmImTbcBAvVF0RSQBEqz3tXcc0QckObA06QDzkd91moVTCNColvSgHeFy+wwkYF
 OA65xJj2hteusJyxGs8CLmvFAMOrk2h35UA9GmSpEmU7W84LaYMOn7CTM0fVoYVysT5P
 XS6Wu5fNgbfDN+qciHHcrkFsYivKyq4bHQYQySp1gO5BkfXv3Pe/tv6jvWQHPUVnoawc
 4PphwQlQjbe/llhjismSrozgDMSZpGdKmnF70IhtKhh3KQHJvmrECe2zcC0qNdpW7Szr
 fJusW+RsdafayG1QYi3cp3bpmo0FoEqDPzCvDDsMRg6dsZfsThlXpGYHIKv4QaFkmt0C
 NKXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFUXIU0pAVLC0WDQae2O1I1jhLnNpPvivF1dyIE6uxruvqBMUg4zxioxeq7dmEAkGQp72OnhA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzP9VZ98gDenRcD4bPpTXfwAQcNqsrffBiYqPLkja+kZoQad5fu
 u5b2d4b3VW9A2NsnH3O+boJqgf/3rPYCV1M0uZCkQkEIyx7DmNTHoRWJne5VMgExhAs=
X-Gm-Gg: AR+sD11Vef04whVI2wsPsNxBC9jMmO5w+YSlDmui4PedrfWcA0KAL7o5CqmcLQippTG
 5Y2rkFfanduQAjh+9hkRnBktxyer8S8C0ezPhFdi1Bpv2BzfBW3aRzOukwIhco8Y1VFMdgJ3yyN
 MrieRckweqgUBP9T+iCQb9dfIIFo6S4xqo62T0E42CAQJNuB1wQ0gCtS5eyzIkliPYquqP+UAnL
 OfeCZXZEvIvBDEaWmIhulZ5OBOODeNGjcn7MSwQgysZuEH+Nk1K6CsduDwfKEeTNCHdRSNglIov
 tMvjuA7AeYgbC7HOJBi3SjdBm5Tq7DDe1pOy/5XTciOo+F3LkTXZyn8ypHEpcB7AjGB7K2nERzM
 NvDUb0EnT34nXjqxBx88Ct3LLLSi+gvKep6jezPubBgNIk4+GZ249V88DjPFpW7fpe/fvuzDPLg
 mRwV2eD/pdwA2mvnUgeYbWkyFfINtPfk2ANzN6e1BXkkhqgoKG15gUdylNiyk=
X-Received: by 2002:a05:600d:8443:20b0:495:5365:c0d2 with SMTP id
 5b1f17b1804b1-49573c9d18amr3012005e9.14.1784756202344; 
 Wed, 22 Jul 2026 14:36:42 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a509901sm174954605e9.8.2026.07.22.14.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 14:36:41 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:35:49 +0200
Subject: [PATCH v2 2/4] configs: mt8390: enable eMMC FIT boot from SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ccaione-upstream-mt8390-spl-v2-2-7aa005345711@baylibre.com>
References: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784756202; x=1785361002;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RsBXVWxr1E6IyC/zDoul7GGRaNZqLkVMV6DTp2+z3bY=;
 b=fONUEdubUaEyYBByMt/8KmnBqZqJtLxMs5fUmWUy70uS4R7LJTxWr+lTm88QEX0Xun
 3ruCtCj+1uMLsHN03g1b/9zkj9/Y6rRGDdg09rrLqfd/j2y3BR/NkE3kqkWxaMVXuVg7
 xzzLeHsdcGQoDEz0iU7/3RhB6ybTcjaFka1tptNAwYpj6XL9tA+VDQ/NwKTsxWiBdgS3
 01XCIWEIoMJ/KFWrjOhPxJDRaU4fqhM3Oru8c33CtadnHtcZezrxJHSsuNK/4C1DddKR
 gR9tEp/1b3+zevbSvhorTI3ZPBZy7UeOalRG1aHQg7fuDvguJIs2z1IsbaqL1EhBBL27
 GuMA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fONUEdub
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable the normal Genio 700 SPL path entered by the external DDR
loader at 0x40000000. Bind the raw SPL to the loader's 0xaf000-byte
copy window, place BSS separately in DRAM, and retain the
non-overlapping SPL malloc region.

Use generic SPL MMC, GPT, FIT, and Arm Trusted Firmware support to load
the firmware FIT from eMMC partition 1. Keep U-Boot proper at the shared
MT8188 CONFIG_TEXT_BASE of 0x4c000000.

The MediaTek BL31 used on Genio 700 stalls when passed the runtime
devicetree as its platform parameter. Enable SPL_ATF_NO_PLATFORM_PARAM
so SPL can still use the tree to locate OP-TEE and U-Boot while passing
NULL as the separate BL31 platform parameter.

Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/mt8390_genio_700_evk_defconfig | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configs/mt8390_genio_700_evk_defconfig b/configs/mt8390_genio_700_evk_defconfig
index fe4f6ad9016..5730b056e29 100644
--- a/configs/mt8390_genio_700_evk_defconfig
+++ b/configs/mt8390_genio_700_evk_defconfig
@@ -1,3 +1,30 @@
 #include <configs/mt8188.config>
 
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
+CONFIG_SPL=y
+CONFIG_SPL_TEXT_BASE=0x40000000
+CONFIG_SPL_MAX_SIZE=0xaf000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x400bb800
+CONFIG_SPL_BSS_LIMIT=y
+CONFIG_SPL_BSS_MAX_SIZE=0x100000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x5c000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x9000000
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_SERIAL=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCONF=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_EFI_PARTITION=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=1
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y

-- 
2.55.0

