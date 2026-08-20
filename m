Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5757C5DF89
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 18:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7495E80F70;
	Thu, 20 Aug 2026 18:09:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 692CNIibEcE8; Thu, 20 Aug 2026 18:09:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787249353;
	bh=gQUvq7qZRCoNoSvwxhzDAa8pwiL9AbewkUqVMLF4mYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a6mVisPrCdblcfMNLIA/UGri/TRZX6LGVzkWOc8U3bR3Z0aMVBfs7wzKe0g2h6L2i
	 Y9pJkIA3up55gcIAgBVEBbB35gwnsiBI0TQDOmPd0BY0apAGoLDeBRFk/f+CI2xWuz
	 nmOBkhRpCeolvmj9FWl6jzvwb2ufE9axwrvd4svmqic6LfRPUoU4Zt0QKxi3gJH/+R
	 akcbx02QXH4F5VA7aWHl3FsPSQNWeUhe0RzpZqixvoejkDNh+FRNGrS4SvgjRqnGg1
	 fsC7BjWbty8le480tli0T5TJisYptebiJf2VSjcpRsOwF6DhDlh0fUQPnJluTC3RfO
	 PD8mDzWFujwxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9947980F5A;
	Thu, 20 Aug 2026 18:09:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FC9439E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7032160871
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dTqMRxOOTnf3 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:09:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NYSje726
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F5F9607A5
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:03 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49557167508so1214085e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787249341; x=1787854141;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gQUvq7qZRCoNoSvwxhzDAa8pwiL9AbewkUqVMLF4mYQ=;
 b=NYSje726xXR2vPXy1ixcb5LkUlxbvHdcRIPj3TNZtxRddevrK0aYNHSF1iadVRcAvp
 FausO02c/iOarEa+Q3W2Ur6SI+w2yN8qAllE5s9QHBZl617FA3IWMR+pjvdBZTuozJWb
 +dfL2Ipf6a2fCl4igKEJ1TvwfEG7zoPVnPUI2NnuQvYpj65IaoU8z7Iy3wT9hYRNIgMn
 LS3/+VC9ThmaH6aUOVN1h6Byh/VfrDVd4i3YQzDvnqeJuy7UFM1DtFEYsDt6Suq6YGo4
 MGj7lJ40EyrcYBZ6AiLJURia7aAJZ5w6eBshJ3G9pdLmrfcB/Lqxo716aYaLmN17oB0/
 EdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787249341; x=1787854141;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gQUvq7qZRCoNoSvwxhzDAa8pwiL9AbewkUqVMLF4mYQ=;
 b=grq7PAzu615glBaznoVEZBUT2XNPDEUdSy2Mv66Eq1Fz0UQjy1mXk+rxk4wi/kz2hA
 ELTlSn+OiW1X9qxXd9NGevhakcLjNXuy2gN8vfDkr/PSJVhktyTeqLu/0ypjwNaGwEAI
 udWq964n2DC5/DaFByPIrxVFtDI5uxf1jkV7aIfgX62L+qxYjDovVht6qfc9/W4SlVVx
 IUn5OhvxQJVuMi1ETMYDZUCDMlX4Hu76axGLZrNZm6eKknxE7vLmj3B0Cu6lwMXoyLsi
 IgiEWhxA+m6yjk3sBZISGH2my8CYNEmQG3GmnpwecPzuTw5XNU9luJvC3d1E+e/ZepEj
 eJ1Q==
X-Gm-Message-State: AOJu0YxpEs2DasCYdrSgC/9NAlZh/xqQAbN6MitMGRdGY180w92xLgf7
 aL8LrZ9dqB/8UUUCrgfgUI5ftPuZSf5rMdPft854Rqxv7nPkC9lfd14jAiwChcxoy/Q=
X-Gm-Gg: AR+sD11pbPPlCoXJv+x0PKapIM9HnxLZtGkDHEyr5fkdI8qYHUDnVzQDj3flirYOATO
 s+vRE3cwu9Vz5xSZwFtnGFK3X6Cna+9lzF44vFccXjQbMdgugGnMKyziSITjF8CKEVlLQnQPnKG
 N6TJ2W90YN4HZ97xgo/73/35YyYS35hTK33Q/Avp9GF71k0L7MZaWzF8Y/jmhdLUopc2F0h7nnz
 oPvpJXTJlpvqY/Ovh+6knWhYsPY5rR+zKPbINGpaZjarwuLtRt+D0lPjp6MjNQ7mx4Glgdjvf1x
 /gSC+fM7aek7XT9AxDi52UW7UntM/7UmvCqFsguvhX3lLr05vtHqK1KFRISnzMOPDtYD0Flgg/g
 oiQAa57bw3nnKmjATeYkogT6vSz7ShzgV0D5RAbRlXvjTbYKKFEgXEZSAv0YbUT7BQQDJqXvTMr
 UG/7OlRlTHFw5cNOGQBxCQmZUECabF3PbfAPeCYNpcR3E/sITQZLGJ71oNHksHQ23cVXz11PRYW
 twwHa+Q3skyXdNo2QAAdeth1Qn8XeTSdnh4AOPsf5FSiru9ztkslEyaJy1eE1DIk0ernVvneywq
 9olHuQ==
X-Received: by 2002:a05:600c:e549:20b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-499b8343decmr11673975e9.10.1787249341117; 
 Thu, 20 Aug 2026 11:09:01 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c33b3sm13443810f8f.27.2026.08.20.11.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:09:00 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 20 Aug 2026 20:08:28 +0200
Subject: [PATCH v4 4/5] image: sparse: add phase-aware SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-ccaione-upstream-spl-fastboot-v4-4-57e5ef71c74d@baylibre.com>
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
In-Reply-To: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
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
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
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
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

