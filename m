Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685A3C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 20:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FBC7608A5;
	Wed, 22 Jul 2026 20:43:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-WOEopttXdO; Wed, 22 Jul 2026 20:43:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BED45607A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784753025;
	bh=iMCl7FaYSyFbgY+7BIIss/f845I/l4vDHOVNjlDTuV8=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0xpNc3XHW8KuK1dPGpv2HJT0SaUDeg6gy1eSO0POq7QzcmIR0c4w7h7NWCdp5ygUQ
	 w2Z+B7ZWowejnPXd4KPEia9ijws2w8rFWUFv9fN5XGx16lnKlpEyA5BiYK4K7cK8mM
	 5yAS7ByLHhvZHwzlgpBDCtM96DJlTAy14SJZzMZFl4Oy5+2Ni0CBWxDLrrPVZVLRmh
	 A6Ee9A8YA7Qw0i4V8cyCPiszLSpAGsQ+psYSSt7wnUeW40Wj/eIjiYwCMWSv6Darj0
	 oSqCRDM1pZ0AQ+tqcC2AyQQEwx5UTzGSdeGduq0QtFt0uT/m3bOm9EtDEUHV4W9I/c
	 mxszRfLMoEQUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BED45607A3;
	Wed, 22 Jul 2026 20:43:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ACEF8224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EB9840A31
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gbvDWDrlJlhY for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 20:43:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B732A40A34
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B732A40A34
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B732A40A34
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:40 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso52209505e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784753018; x=1785357818;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iMCl7FaYSyFbgY+7BIIss/f845I/l4vDHOVNjlDTuV8=;
 b=PhGMbDalbZYrFuaBGhbgvmTes1CYgDnLzbGw4Hwamun2KotN9WXXez47CT78XlF2dq
 5cLLd8bepJ59sy4Uoa+DN2AZ+ZNUnWBWa4+gteWrQWZ2p+9+D2tKaZDLZnMqnYlAx/6R
 fMJDZNW957IUjCIxRq4JGCREKtsWgnMpbRuDLwgTj7rYztHbF3QomyLGFcx7HqCl9tCe
 xBv1+E74b0rwJg+nxCWDJ306iAlFhut0FoQ2ThOiSgbQsl0xFwE30fEe1JFD22Zu4wPA
 ERf6XfyfNhepSwecEtbPKaKPX7VytBucDnpqpfdPWA0fNdxMeIfhVEToLBrSf2cg+/u+
 7SWA==
X-Gm-Message-State: AOJu0YxQOkdp4hBzppCMDVzpGqV3V42HK51rh+wdF/sBSsgafjC+68Ws
 R9+3/tVzVQc++YWH2adhEvVkpOMXW1krssBC+bLRgGXW3ujzkV0A8tNerqNCWGNS6UU=
X-Gm-Gg: AR+sD13Ek6btQTztWL8q+74vgANA8ohSXvXYmcAdcVEch/C0qW1mI7kZlzgdbmustdm
 y6Bl7ZmF9QQDv6U2PgmQEVJ6SHP8LMYG4jwKmMsD2p4j9DmdszrCfxTSaKYL2Tycy6cTbOTu01Q
 DhX2XiiOExECA+NAPXTPwNlZenkoPErgQ85tlCS9CVB50etO5VLcQziyzcr4lOPl0BrbBLkx6a4
 vLccylzjJ9LoKvjwa0TMyj6LBcIWIypyipy4/VHN2xyRRIbvCsr9fOAgwjuHWrbnhsvGJfjn7+j
 R5ATGwsHOZ0Mhxg1KlIFw33YQgehHyTVuvi0x44Bqwaypuz1Cnju3YNgzWHdc3MjontNtN9WMJu
 Xa4Nu7QIfdUic6KJLqux64Jq7ttRtmeN6I0EFz4ku1+YEzEMpsm4mA+iMYGJqohpDkI5o2Ob3zi
 gfIfLDjYnpsQFAP3FBXuJrTPl2oRPtMzbtlJREz1NG201flXEHgPYUf45nHpMGzYMQGuUAUw==
X-Received: by 2002:a05:600c:46ce:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-49573cc9704mr3027025e9.10.1784753018492; 
 Wed, 22 Jul 2026 13:43:38 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b4e8885sm60775195e9.0.2026.07.22.13.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:43:37 -0700 (PDT)
Date: Wed, 22 Jul 2026 22:43:06 +0200
Subject: [PATCH RFC v2 4/5] image: sparse: add phase-aware SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ccaione-upstream-spl-fastboot-v2-4-2ba3f71c42bc@baylibre.com>
References: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sam Day <me@samcday.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784753018; x=1785357818;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iMCl7FaYSyFbgY+7BIIss/f845I/l4vDHOVNjlDTuV8=;
 b=ONN3pkD309Pcs+EMICCFY8cCnFlMojrS6LPRtTUdIcHwP3sOYRlts2xHqGZfFH67yO
 V4iLKl12BbUA3i9ciAsHs/gKWKr16nSbT4P6idF+EryZ/faxYowtOC5PcI4K2WHanM//
 9Z623B/b+yqhSuJtIthsZ+V5wnEJwBnekjKvaOb+lNDB4W4DLWVa88S6wJsdhyBm/7e/
 LUrYqCfYK3TUWFNY1PfUgB8H6MkAUOh68o0e7TedqYG+gv81fyzaJo/wM5D7x7O6N2mT
 rxKTY9MlM1W6PnAoXiJOTexvPhk/uh9t/LTnSDwW9voSsN/JTgpoGeMclJPC5XzEdYJA
 KEXQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ONN3pkD3
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

The Android sparse-image writer is selected and configured only through
U-Boot-proper symbols. An SPL storage service therefore cannot reuse
it without either pulling it into every SPL build or interpreting the
U-Boot-proper fill-buffer setting.

Add opt-in SPL symbols, build the writer through the phase-aware object
rule and read the matching phase value with CONFIG_VAL(). Existing
U-Boot-proper builds continue to use IMAGE_SPARSE and retain the same
fill-buffer default.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 lib/Kconfig        | 11 +++++++++++
 lib/Makefile       |  3 ++-
 lib/image-sparse.c |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 24e55ade4d3..07ee3c88fd3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -205,6 +205,9 @@ config VPL_STRTO
 config IMAGE_SPARSE
 	bool
 
+config SPL_IMAGE_SPARSE
+	bool
+
 config IMAGE_SPARSE_FILLBUF_SIZE
 	hex "Android sparse image CHUNK_TYPE_FILL buffer size"
 	default 0x80000
@@ -213,6 +216,14 @@ config IMAGE_SPARSE_FILLBUF_SIZE
 	  Set the size of the fill buffer used when processing CHUNK_TYPE_FILL
 	  chunks.
 
+config SPL_IMAGE_SPARSE_FILLBUF_SIZE
+	hex "Android sparse image fill buffer size in SPL"
+	default 0x80000
+	depends on SPL_IMAGE_SPARSE
+	help
+	  Set the size of the fill buffer used when processing CHUNK_TYPE_FILL
+	  chunks in SPL.
+
 config USE_PRIVATE_LIBGCC
 	bool "Use private libgcc"
 	depends on HAVE_PRIVATE_LIBGCC
diff --git a/lib/Makefile b/lib/Makefile
index 222378a8531..014fda82860 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -44,7 +44,6 @@ obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbios.o
 endif
 
 obj-$(CONFIG_SMBIOS_PARSER) += smbios-parser.o
-obj-$(CONFIG_IMAGE_SPARSE) += image-sparse.o
 obj-y += ldiv.o
 obj-$(CONFIG_XXHASH) += xxhash.o
 obj-y += net_utils.o
@@ -56,6 +55,8 @@ obj-y += list_sort.o
 obj-$(CONFIG_PMBUS) += pmbus.o
 endif
 
+obj-$(CONFIG_$(PHASE_)IMAGE_SPARSE) += image-sparse.o
+
 obj-$(CONFIG_$(PHASE_)TPM) += tpm-common.o
 ifeq ($(CONFIG_$(PHASE_)TPM),y)
 obj-$(CONFIG_TPM) += tpm_api.o
diff --git a/lib/image-sparse.c b/lib/image-sparse.c
index 09225692e9b..48e5d8ee869 100644
--- a/lib/image-sparse.c
+++ b/lib/image-sparse.c
@@ -125,7 +125,7 @@ int write_sparse_image(struct sparse_storage *info,
 	int i;
 	int j;
 
-	fill_buf_num_blks = CONFIG_IMAGE_SPARSE_FILLBUF_SIZE / info->blksz;
+	fill_buf_num_blks = CONFIG_VAL(IMAGE_SPARSE_FILLBUF_SIZE) / info->blksz;
 
 	/* Read and skip over sparse image header */
 	sparse_header = (sparse_header_t *)data;

-- 
2.55.0

