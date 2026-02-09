Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1324E81BD3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22A4F83D3D;
	Mon,  9 Feb 2026 18:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DqunRZqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1415580325; Mon,  9 Feb 2026 17:40:32 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E884D839A5
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 17:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45f04f1348cso1970035b6e.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 08:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770655229; x=1771260029;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ysez4mjIcacL5smGfWDwG6K4xMdDeAvaN0mKE37f1lQ=;
 b=DqunRZqxtjIU+TByRjm1gQosFFQ99EbSBamvKfPn9AxlLyKPoIY7G6mIEJVvK1zFPZ
 fRALar/Ys5XeZv1bg3EvVd8XphMG98GavRpnYvJ+8sc0u68nKBTt9UR4nIFYnO77A0C1
 BJwKPmWQNjGt0P13Xi85ejbkz7q+bk+nnaQj/02svhDQZrzD6ptZY8HtS96ut/3djMVl
 +82cveKquBvomSe76eTJtgcf7RwLTBQ425M3eNuR+zp2FiNO1N3GkrlxYX48Hs8Aes7B
 DzilwlGosHbCIj47K4WvtJnu5pxeT/av5FFRapdyCGnK7Lnmos3unwUzukkWrjrOmvU6
 mBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770655229; x=1771260029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ysez4mjIcacL5smGfWDwG6K4xMdDeAvaN0mKE37f1lQ=;
 b=UqjEKwa9aiuA1g5ylB2mIteGtnm0EKB4/L+9/UMeiS9ZcqKIybmbaFQBIkRj6x+jk1
 9xjkPZgIFj70iTuUP5SCcgiUSY8bEInq+MYjMfg5GW9NNas3cnG4m7G9NyEyHiMX0Wfx
 T6YYvAnblU00zOYNqPiOz3vZ6PNE5d0x3oIUK6gWmV14u72Pqh9vOu+eKwGjnjMBzR85
 JRSidPXDLfQjUkn30WbMfX4NNw6PVYDxhSHceOWhqgJjGuzv7sXWratnG1X/QPvLnylY
 FY1h5HRgp4vXuFy34ZQrahEfo/TO9kDTSWmPnKrNMy+wiy/6V342VMB2QMhw9DOFjFdX
 KuAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGyUMFwztUihGyG7WcH3umYnhpFo+l6C4T1Mzi/TRIvOTLi8fdFPWjeWZ4LSzsZZFQHPXyxEY=@lists.denx.de
X-Gm-Message-State: AOJu0YwN3SFVrWmZyo8h4RBr2AceDi8lin6Uakovy0zOqgUGZrrQZcT1
 T/xh3pV3bTj6rxOSZOJyYkU+I4F5QyIcO+EUPcuhhOp+0FjbGvAvZuPRiRaTUirT9Q0=
X-Gm-Gg: AZuq6aLZAANDpL2uvFDnNT6KHM7WUIjt4zzIUSLNwP2g9fKAeeA+0vFgKAmYA4Gt7cm
 R906aX8xg78yKyRwfEbdbZdmKuKBgtbKUSdoDeJreP2nw2XSzO5fmtdpOtUwtxNdQUntgSEbS+o
 gZvYFW1LjvS2yY8rAsSOHsurWByn+jsVRH1U3I5mcE8qoXKvlFf8snWPwugkF7tScy+WqyJzO+N
 /c9ZLRUaJXL88lXM8AU2iB9Qw2Hh5RLQrmRx/lmRbj4ja/WeN/p4sXVYUwBTZcnTD4VBD8WsxQK
 0rF9QfYSdfaPjSRy3Uz/ZQIqbk8a4l6QtEg/fEaHzAaE/zn73lYAUatwEReqYuXiNfBuwGJhhlv
 CzKNQxmNqH8Puvk6SrSiVckAun0mgKCnOYJ7Bvw/1tEF3vrwSTH1fAEh9e1sJz0JS9oH7zEuU+v
 QBk19n/UKRM4Zklig=
X-Received: by 2002:a05:6808:13cc:b0:45c:9486:5d70 with SMTP id
 5614622812f47-462fcbf5edcmr6699651b6e.63.1770655228689; 
 Mon, 09 Feb 2026 08:40:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464785d7esm7731139a34.15.2026.02.09.08.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:40:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 10:39:32 -0600
Subject: [PATCH v2 7/7] arm: mediatek: add CONFIG_MTK_MEM_MAP_DDR_BASE_PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-mach-clean-up-duplicates-v2-7-e3b22282c74d@baylibre.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=HkF14Fa02l4ZmhsBmnQ9PKhpWT9+tS8BVY88dTx+ubs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpig3vYk4DCDlKVOO5j/UD+w9Iv8WMWQzvv92nt
 e1v+kCu3UqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYoN7xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AcdkH/iX3eJ8LJI/7sLVDFqxQwIfpB0VVWsBpWYKWKT2
 I2nhjBKTNGv5gSwKQy1XzToOFln2w52PZvFxPCdbJ95klaAqVoF1r19Ef2LKOVoKnILmXxZSRsP
 EQapOtnjHHl7Z1m6LvYHM4iIN4+/hNgbHZNNX5l2kVAWb+L7LOQOUeF0deCyqgFIb4FIjdLAp9W
 43CQK5vqzIo6UPzNev1Q178qm6B0oOWxOuHcz85PRA6vEEFSUn+BWnX7pCB/3kBACo6fGLZJbF/
 NfmNM8zwaYRsyU/juayJRaHLmw7yQ5CeEPzKd8YPFSrxJ0GKgrXmpoLKuNDoJzmSLVKI4f0Gomp
 bK5U=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:12:16 +0100
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

Add a CONFIG_MTK_MEM_MAP_DDR_BASE_PHY variable to specify the DDR base
physical address for the Mediatek ARMv8 memory map. This will be used
by MT8196 in the future which has a different DDR base address than
other Mediatek SoCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes: new patch in v2
---
 arch/arm/mach-mediatek/Kconfig         | 6 ++++++
 arch/arm/mach-mediatek/armv8-mem-map.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 33717a1864f..d10aedc303b 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -132,6 +132,12 @@ endchoice
 
 if ARM64
 
+config MTK_MEM_MAP_DDR_BASE_PHY
+	hex "DDR physical base address"
+	default 0x40000000
+	help
+		Target-specific DDR physical base address.
+
 config MTK_MEM_MAP_DDR_SIZE
 	hex "DDR .size in mem_map"
 	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8188
diff --git a/arch/arm/mach-mediatek/armv8-mem-map.c b/arch/arm/mach-mediatek/armv8-mem-map.c
index 3587a2a9dd2..cbaa9b4c267 100644
--- a/arch/arm/mach-mediatek/armv8-mem-map.c
+++ b/arch/arm/mach-mediatek/armv8-mem-map.c
@@ -5,8 +5,8 @@
 static struct mm_region mediatek_mem_map[] = {
 	{
 		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
+		.virt = CONFIG_MTK_MEM_MAP_DDR_BASE_PHY,
+		.phys = CONFIG_MTK_MEM_MAP_DDR_BASE_PHY,
 		.size = CONFIG_MTK_MEM_MAP_DDR_SIZE,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
 	}, {

-- 
2.43.0

