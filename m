Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194B6C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 17:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5A9D40651;
	Tue,  8 Sep 2026 17:05:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pj0gvf1yel-E; Tue,  8 Sep 2026 17:05:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E9A9C4055F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788887112;
	b=nZiluPT/OwX+m9zys0KZ7b3sq2EIHSP8+3Nh1Es5/UabN11QqXoDtuaDNmfaafpHXAyE
	 ZCuVJ2P7wYDKk9Epap4pZWY7ZmZTy3LhXtzMuoCnF2ZJCFftvFoa/YUOc/TeXXn8oVRYP
	 PbyhtsVrCmWmmiQfqD4VulnnJU/32WISsXUInoiA0u/YHXxqxyw8A1fjQDnJFC1qXHmr1
	 k0DwyuveY4Q4AhZMvAk3YksKPm0GvPhJ9dZ1ci6Xxz1JTWXX0ZpnisGmoZQtucVTUE/f9
	 SfYAbesMnBBO3dKi7wOnW2CT3tUCnRmEC3LP2CumxogwMkiZ+KaX9jhwULgwfqGL++w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788887112;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UufuQkMmjlsfyVqLLhHMO6WKC0JDPBhZxmbT4XAMQ5s=;
	b=YMwcYW5mqUy0Wya+y8QxlfQBjmR3x428OC40nRc4NWq+VlySrDzs/1WsWsIFpJmDZkR/
	 Ea1jIJ3Bg356aAob++iwbh1ei9jQL0Reeb0bkerxZGKvqBTaQJTPZPYSWRTNEaYzmk20K
	 2DUJaJj8lhM1EvsvaUZcV91CE4QzHyc7V3aZLISge46xDhZUrHCTp3L47ZBeTRqYDn9tw
	 jVuWDz40473457yuQ612/hFjdKtWDe5CcItiUzy6ywDAFzng/PbyG1bcs/rA/HtzKzbZY
	 CbBudHN+Ve/K8ASIPh9wYIzFb/riXFxdOJHaX4/FKPxzMWPgCIPxqUCL6yr0slBbV/A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788887112;
	bh=UufuQkMmjlsfyVqLLhHMO6WKC0JDPBhZxmbT4XAMQ5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vrndyMebUUuqVQFMytswtNw5DF4xGLX1ZV1By0r2z5CM8VwhjXFKfCg6nj6ZqcJhl
	 sL3abi5rnKK8EEBNn/1qWk4II4AcPUQFY4YOWdnF34Ubm8JJj4246+gupg9dx5pd7k
	 s0uO57L7yyWDsTKWj5y4L6wz9wu5UUNtV+xvShBjlFN6S63tTqDTXvwRPOKbjSP7xI
	 j+SlYLnKWkp4QenUK4KI7dGnMdwaEmhP0adSf5RzXB+EB5N7CuLL5ZoowHChoZm3Kq
	 V9Hr5FDHisQX4ZABC5Sv6ocjliKcX3IAsoWI2qn0Hye6uHd48TATVUQt7Dci/Mj69m
	 YeWuT15evxiBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9A9C4055F;
	Tue,  8 Sep 2026 17:05:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 771134CC
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 17:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D85D80C8A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 17:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xfTCI1Eq3Q1X for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 17:05:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 717F180C6C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788887107;
 b=EuoCTuSj1jwCIpS/VBDEo2lrc72Ob5qrPH0xcDdJbEYtAC8c8Kf9zMw+iKIJsXmnUhXs
 WdF4YOM6IYYi9t2lGK0UdnBkmYVygxJnX21NCKn7ci68w3YivK4SqziDBt9hrKXhH9Mxz
 SIrEKWJgziTlYshLfheRdN+DRmm8BX3rX/SqIzE1k0xvI+ljS5KijLMeyIWQLSibNHIwX
 ydHu9pb+n6a1QZUI7wQz/ez1PTE0BvC86uN5D+b6yRQ7/VQwEZiWntVmlD7U3DbsvPJcO
 lgUwCvheB+racJ9xrKEPP7KGa0OmvWmdN2Nno36BHzADFhZBv5F+TfTla2Icq7NvXaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788887107;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=UufuQkMmjlsfyVqLLhHMO6WKC0JDPBhZxmbT4XAMQ5s=;
 b=E6sVNMDqbi19H9f9JO/ATXe2dPqqrFpLrEbl1Gd0siU9ZZvM8THpHNcmcRsGFYM3bOKY
 sdPf8+Kn4m9A7nDrofCf2CKxSHCXcetwnzVbWGERv/byww9iTL4I9aQ+5Qg10SbYgyoVL
 fCsEVgf/rMf/ZjFey7vD3KKQWLkVjA6tikvOgvCpZozKmBYNXOaYVUNq8D1oGc/gy9kjM
 YbLj4yEy51/d5/nl9b7SkwRenKsvFAevqgeimJKXRlpoMnDjuzjeFIKHkJOIcFNueBCOx
 pKgSmZtwdmIg2LSudhq+0UpKZQbGE6L/qyvY6r66a7RDacjCRiwZO4xorLDneiu6xgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="etup2J/9"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=etup2J/9
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 717F180C6C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 17:05:07 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49ccfbe062eso47253175e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788887105; x=1789491905;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UufuQkMmjlsfyVqLLhHMO6WKC0JDPBhZxmbT4XAMQ5s=;
 b=etup2J/96HgxQq/dNKKkVKb2zm8t38Y42YThjONShIMiWk7zqoy6AvJh394Sd8uajG
 90HoISXjLVOaGzE5f8xXT12kjR6CRtlVElGFkkxJA/4qXItAhjRjDhHD1ahoAqHXQFbN
 Fi8szguyud1cgZBLogAiRvPj3Ea1t2uQgTwYoNB+1MOsWnKN/ZGhSmwgsNVvQOg9PN1z
 WqmUndPrw3qRPKMLvVypN8jLLwaZbe4AD3TClTceKIrWOGGdxMU5PmjpCt8wz1Gj/fec
 5ZgudorjjFPlM+0MXGJAkdNpRPZq4sDtsYQcvyS92DtyTjwNrVK9hHIzT/TGNo0MVmsb
 SVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788887105; x=1789491905;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UufuQkMmjlsfyVqLLhHMO6WKC0JDPBhZxmbT4XAMQ5s=;
 b=k7JucjgF9P0259eHhGfcNBZboTLUDIPY0wdzLc9lQ6mmVaw3K1brKcUJE9nSvjTbsm
 V1iOCuTvKMDnEbzLg3vKe6biBq2y2FBUPnUhI9lsO1cy4cXbztNhVj2hlnOayfuiOg+q
 Thy+TuPDMcH4GmHV0u15iAsTfW79Fd84t7y4jzhUn93ncXcdxWqaM3VfJsE/6fMwquup
 TCs1s3xUm7lP35/nh2m9f6Md+OfsakelK0AiIk29oFTSAkN0LcAQu6dNRYWANaNvOSKO
 SLKLJizPiNqSZoS39l2yddYoOSfgOuSHEIicjBfofJWyzLytWezfH+dHxiRkj2zNvmLO
 XtpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBymLKEvI4cRRQuMLSGKNDU6mdMW3P1JRHisAuWNRQC4TfM5okQgcNMcpsz9ps0m+SSEns/sYC4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++khVxism7GBoAJNmCkNIK5Tuvm9lBQEJS2ugWkx2RlNybVoONLv
 +arSRMyFzfg2SMn99cwvUDErd6YYhdRvv39sqFYl6wObacy2s+bwxGzg
X-Gm-Gg: AYBFou0aGPmCgAXATGeJZ1dBXC/2HM55EIr/haDofcYJ2VenqLGYfNhy7tVByX9ZoJA
 0Qk5C1/rq+oWTL5mgWH6R4au0vvUVIM1YpH41JgeXt8vWGCgHkguSxtK8qcdOhq7QL2ZgJXTxMN
 PcbkMPskIyebx6yYFOj4AhiEDyzThIF1d3MC5oDwtDIreuktirqK/7poX2wCVGFrW5YceNWIKgG
 6r8RxNHpLoaSvyc57xfO14CBSl0oQYe8qwgoqUUqiI7gG7oNfQ6/Ku3qFzZCYTutS9hWvltC3T3
 u05VUWm2C6F1tZE42plfpn1JvpmtaPvd31rhiUnIkUHpSQ3HF460Dp3G1Ujm/xQUPWzpIhrn7h2
 0+usBju3mX+I7kytjK6CQQ7Gu/NiXA7tozz3cxcT8vlm+eP6lvrgSpAxjd20V+yhiZNOnnNpXpg
 UqYuuZH4GcD5WOW+7TIqNqkbmz9TDuoHX/yhdx2Mf8WlhWRmcw6Mqo97ERziI37KQZnp481s4=
X-Received: by 2002:a05:600c:190b:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-49cfa20cd63mr288108695e9.20.1788887105023; 
 Tue, 08 Sep 2026 10:05:05 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.150.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d04fe7f9dsm306863755e9.0.2026.09.08.10.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:05:04 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 08 Sep 2026 19:05:00 +0200
Subject: [PATCH 2/2] drivers: Skip needless CONFIG_TPL_BUILD check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-xpl-v1-2-58e9e5248c29@gmail.com>
References: <20260908-xpl-v1-0-58e9e5248c29@gmail.com>
In-Reply-To: <20260908-xpl-v1-0-58e9e5248c29@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 =?utf-8?q?J=C3=B6rg_Sommer?= <joerg@jo-so.de>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
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

Just check that CONFIG_XPL_BUILD is not set to select files for U-Boot
proper build. Indeed, CONFIG_TPL_BUILD being set implies by design that
CONFIG_XPL_BUILD is set too, therefore CONFIG_XPL_BUILD not set implies
that CONFIG_TPL_BUILD is not set either, making its check needless.

Fixes: 371dc068bbf5 ("drivers: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD")
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/Makefile          | 2 +-
 drivers/bus/Makefile      | 2 +-
 drivers/mtd/Makefile      | 2 +-
 drivers/mtd/nand/Makefile | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 269c3db12e8..da37338fe1f 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -87,7 +87,7 @@ obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) += ddr/fsl/
 
 endif
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 
 obj-y += ata/
 obj-$(CONFIG_DM_DEMO) += demo/
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 2d242bc2886..239d9a35fe4 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the bus drivers.
 #
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 obj-$(CONFIG_TI_PWMSS)	+= ti-pwmss.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS) += uniphier-system-bus.o
 endif
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index ce05e206073..e204f19ff8b 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -16,7 +16,7 @@ mtd-$(CONFIG_RENESAS_RPC_HF) += renesas_rpc_hf.o
 mtd-$(CONFIG_HBMC_AM654) += hbmc-am654.o
 
 # U-Boot build
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 
 ifneq ($(mtd-y),)
 obj-y += mtd.o
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index c8169cf7390..cf53c5f601e 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 nandcore-objs := core.o bbt.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/

-- 
2.34.1

