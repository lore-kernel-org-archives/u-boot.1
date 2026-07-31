Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983A1C5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62F5680EBE;
	Fri, 31 Jul 2026 08:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id InNRuh6OW2mB; Fri, 31 Jul 2026 08:30:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 033D6810A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785486611;
	bh=iMCl7FaYSyFbgY+7BIIss/f845I/l4vDHOVNjlDTuV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cYjqWUUvN0bd+wJIYzGT8s6acfsSFK5TVCpQjbO2e5XTtkchF87mViwp6Vu2F76cT
	 S+0HSjdgkfZA9PcpKGqlf6LxjAO/4J3jz3pgKlMZWu0RU12Cw9Qa8QlUiTpKWDCnQ3
	 5jlPG/wiOtCTwFwoU/U5VzvmlNU78WvVZM3ipb/FqoLjc4H/2m6dElMa7wMeaxsTJ9
	 wIeJ8zwTBzqs6qqtNoh0Z9mlt4RwDkr96n3uyzxuHSAPnsmSK+MLNX0QhpNPSvS0L9
	 X1n2qVzq3pLNyiFsT/9TdxpfN262hwoL9lH0tljUvO1BJbu7xfcei0sf0vvtggmhuX
	 HXNfeEoYFeE/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 033D6810A0;
	Fri, 31 Jul 2026 08:30:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E622F2E9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD31740F31
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ubMKzE91h66z for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:30:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C7AAA40CA6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7AAA40CA6
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7AAA40CA6
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:02 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69ea0595598so836777a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 01:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785486601; x=1786091401;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iMCl7FaYSyFbgY+7BIIss/f845I/l4vDHOVNjlDTuV8=;
 b=ls+2dSucuc2AKLHK6o7i1IMQ054vn0HkMsaaxOEBy9+u3Gqu9jUgRBCoazEv6xdWR5
 QATX79V7JKZ9B9W2t2zJFfFZkDxNhY/NelxcvbmLoUxJScxtwUOE65qydPYYjvaXtGyn
 iUexMSfC/QAQ2Cc94+zPzOG1Pwk+tvChM8OzaiBOKdi38H1Bb+DvaLs+O9xwaM6YG4lp
 8iM9vHaCxzrOiq6XoI7iKoy+RcaVVVEvAf8n//ofzqCO2tDhryF0cTvXrCkbiyadNY5Q
 nNznGyXRAU//DlZ4qSszrqckdYwyOCLwB3Fe0otx1cn6YCWc3FlS9mMJnEuMFVJ4v2Me
 z4oA==
X-Gm-Message-State: AOJu0Yym2pD4+RaQcfpuN1jY5pB+AAQXm62AGoMNIvMDpsLcPeMXR/OJ
 5IvaKy20/eqpVZCKVLlPzSPZJyjQx4sNZHKXPbups9AC3WH5wAiNsdUTvAvZE55j00A=
X-Gm-Gg: AR+sD10ec7DqqieHfElaH67k/lG/kIL8UTHm7XI4N8h9foHEUswP+8Iegz2vmL9g4Lc
 1O98QMuLB4HD/uG4JEbFN0lFIuyKD8HGodAg2revu0cTnzrRNZ183LQR3bvcRIbVLLjXBVnyN7n
 quV1dKr7tUFbWtyJ7TKdMPvbOVUC1PQ2+4H0oqTxVxLNI5W7KycRj52n697U2NQcBkhLhEEgSQ3
 i/mlE9rg4+oGfHvf5Jo0fRuyTZC0qJ1TTzXfI3DCg+YTjmIJdzDLJhncGJ2XPsS64kEhxUJnmA+
 JQm/qnhzkPN8tuzv2PEmNwO+ZjHA5l7f7icQhD/mapoBpwBMEBn3RB7xBo9u5Z0imdMCsdhjFfL
 ZK4o1q6qwk4A3x69hNPTPcodz6sYHZKSnqdKvG3gKQ59rRhExthctkWUdMhOGTY6+RuMtPd4xvG
 hLfKclCDpiAjl+z+V2Ff+BMB3qgGtM4MJeo1TIWgYxOsIVLDDnPP6VrmYhHoBcLM6dFfOq9/dz3
 C2UoPN7SKBbZyk308vaZN1x3s3hKoa00+hr/OsMw5FtGfUmgGBhqDj/8Maxywwp54JCWFbbr/pl
 PRLM9I9FVXY=
X-Received: by 2002:a05:6402:1ecc:b0:697:f70f:8238 with SMTP id
 4fb4d7f45d1cf-6a0984e895amr598457a12.4.1785486600714; 
 Fri, 31 Jul 2026 01:30:00 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c661641sm583646a12.29.2026.07.31.01.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 01:30:00 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 31 Jul 2026 10:29:40 +0200
Subject: [PATCH RFC v3 4/5] image: sparse: add phase-aware SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ccaione-upstream-spl-fastboot-v3-4-dbea3ff4529e@baylibre.com>
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
 d=baylibre.com; s=google; t=1785486601; x=1786091401;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iMCl7FaYSyFbgY+7BIIss/f845I/l4vDHOVNjlDTuV8=;
 b=PvDLe6/7sghak0HPCdyRi8iWmZmlxJ3iYIPg64xhjxdwz3JInSdKiI8U1RdEGACq3G
 ER7Kh+NSb7LJoihzjCHzfl0HTlQyYg8oYCPkv6pYNc2+UJgE+4UVKnPIxjubb0q6w9bP
 IP1Rse45yl/I1FS2Qrz/tke6DOjJI8NB3+6VqNSF+emk9Mm3NLgfzdCS9BAoLa/gWfAO
 WS7LtkcgK4uTU2oREVZT2bUgzLUamXqe7wwu0B6Y513jWlDfCOqR0lhaK45q5bmDkIBR
 inzGnpnZ0reJpaWx8zsuk4VExyXj/KU+5qEiu88UMTtG8AT7th/9AVmUz56mQey6TH0d
 ZgPg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PvDLe6/7
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

