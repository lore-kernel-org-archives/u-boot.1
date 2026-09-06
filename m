Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015D5C79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 20:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A36F0405E2;
	Sun,  6 Sep 2026 20:02:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2omeuSW34BW; Sun,  6 Sep 2026 20:02:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A9E14405D8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788724942;
	b=fDll8oKYSqNZXczD9fafQi6z1bRnYpDPQuaiSKUWJRhGlIBoTq0M5MMxO8UJ0SB12x/x
	 R/XFlpmExMHiIL56aLbUomVqiAvJYOIwpMwemK4fhgJdwHXahna+Gz+UKHfb+qyPl0i/U
	 R97oxnDYlOetdkxLI/E8r0zOBd05+81Rq7yOjsDK/zAwrARJ1isYfLUuf7gyG2e7On8X1
	 B7YQ+ZKet252aWWCvnRSQzgavlvG0wTQX1S5+JBmg6fDJ0vosfBA0rnlPGqgKZ7KKxoaK
	 Y2kSHAHEUcvWFqGmgDcgbF7o6sJWBVj4CcGlEBvtzFK3sOFUzYFLo0t9BghCS23ZoRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788724942;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=avvaW1LrbYyD+QlETHjYRU2+J2UAcot1Vkb6VIryOVY=;
	b=khBe6gE2Ot/jw/velplbBNNKagDc/ZHSg/MSi4gE73VjKT0l0txcUtZtrhS/vwzLds6S
	 AwSkvadfCm07KxMuSyZDk/MXSAbnwObIR5awt33SGlqcciRG85eHLcIdwBQzjLVwF2ein
	 +t9w24K8+eEBeURm8EIYb3E/ZuqIhvrnx3CESkqvMgRjqB7y7ZkSq6/kh8qlIZ4ZQvOn+
	 RhdegtP7OxHaOyLAJFNMOFVxrW3KPB5Yp9K/vGrwk2YByJNweuW9/NpvevkKJJ/frqMne
	 DaxMyNmWiA87t1+Jt10/6JX0RCnW0A0DxmgFDaskgooJs1LTHmo73Fq2pz1RgaOYvhQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788724942;
	bh=avvaW1LrbYyD+QlETHjYRU2+J2UAcot1Vkb6VIryOVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SpYuahm1M5RIlv8plN5rD5o2xl6RWUpPQfPaU8C2azACaXC6W+bKadmFjfFvzxZjC
	 /0s+/pQTJhb7OE4BZKsayC5os1I+5YoBmzuiZqqChvxuLwMpq9Kzqar05MrGNIX8AB
	 N8dm7zAE023bIaRxhOJ44ejvO5P/7dkCx3yM1WUS1Xc7xluIFqK0MNbbt9v6mmPXyO
	 4EEaakZhGN1ROeq0wucXz/FS78K3MEE0vAOZvz3dyIJhs17LdSZhIQERZou54uozpf
	 qvf3qRzp4LXqGrznPsNKJHDPVe7KvctTtBugSC5+s4uvoQiWEXEpu2Ux88uE5ZAGH2
	 5KmJ6gJ8MuAgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9E14405D8;
	Sun,  6 Sep 2026 20:02:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EF03970
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30F046063E
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:02:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P6uyVylpJjXr for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 20:02:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1DF5D60634
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788724939;
 b=eFd1B8T4rl4rDTJew9zufXVs9VRRq7299r+BuiYrYSLo2+FidRFEFbbdap19Ys0L8B/z
 dqaiWCwNK32VXTpRPPUZVYJQ5kybn377uiHqZWS23saepAB54FpLeFqqtw/b1DWVoAEX3
 UfjxkmtDAq46fUnPHEryahb19zHcETQs12O4k+sqzbddPxVssY7ykoLoj0ZyQmSMu6GDN
 2ZsV34osv+Ukfrr6RJrQT/uJ1Jzl3oVEj4OkUqkyLKKzPsLpJHj9rdJ1nCqNjh126HdbA
 rg8Njt5zweEqdfKr2YsMFAyL1M2EyYQUzWyVM+w/ZNnVgbJeRbCij3Binrn7Z59jBKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788724939;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=avvaW1LrbYyD+QlETHjYRU2+J2UAcot1Vkb6VIryOVY=;
 b=B4JDo2bxGml1B6MV0VBLn/xSF3WZ+SRXBnAsza08GEB0vQ6X2zbcrYV1DmLqTWIT4ZDh
 zRFxNG3IubZ280TAtvl+mVDr9V8VaTI00ql3h/1AI/OEOYzEu93m0BSOWO8DkHBPL9Y1Y
 18c3kZvCgME+VXagvNEL1ywIB2UU6M2wS7WmGaCowTboA7N7ydmIQpF4xLW/zX4GWugLp
 Jl+3iwCk9uqjYczSwoVIoON8FmX3U16bh+VzJ8YNfofTxHlGBNQTAhpbTQ6qEf8FGcIzg
 JmD5yvR51M/5sQ6rN9H/vyXKO8fsPVZjyRPWy4aSXpPUD+edUNsAcCxOINaplrudaEA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pn8fkPCk; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pn8fkPCk
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DF5D60634
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:02:18 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-484374f54d0so1589942f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788724937; x=1789329737;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=avvaW1LrbYyD+QlETHjYRU2+J2UAcot1Vkb6VIryOVY=;
 b=pn8fkPCk29kYA6x5l6n2GgHBIbL7fpBdL5C829UfYOXwHg2r3Iq/kfqadTf9zttlhl
 8ZUZ13RkgSV+J3L9+9Kv8ORcQu9A0iw2tVP3ZRfu0ouVeKtxqjbzoNEeyN+o+EeYkMWA
 Pxfd3LZI1oTTQ30A0f8HKf2FahFzIC0zgN7iF4/vnRZcCtgIonsvittzILEOC/RgCB7R
 4gvc4K24+tFuUeRvGCrXz9FwG5mUbbFodCMmbWdxf1h+t0gjl9FI6V/EAr5o/k8bHAR3
 YTMeRzLu83MXhP4r1Zy5qxT5Zdt3PInnlVjERpB5HRNSCL2clsFhL1UWo4Uq7qKSbKUL
 LPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788724937; x=1789329737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=avvaW1LrbYyD+QlETHjYRU2+J2UAcot1Vkb6VIryOVY=;
 b=R5XLNhkfGTbsDQiaQBAe4vuBTHTeBNdwcL+W3UmYgc6xIalPNzNj1rOPnRcDaeWL3d
 imhZoIt7Azx5FdUy+6O7bMxlh1MBgmRQSsBAJgE8PMMOKUlka8xIqX9rZrxIy80WeTcd
 nbKpZ1iSgffU2WLpKVOpxBUt6pwJxb7OFEstmFZlb/tyBawAMbRJlDe8nCfjKSHBzB8d
 FKRVEf6+BSztdwOKbE6/wqQoj0jNpmgGca3CbUaY4wQp6oaeI9JlcBMpXuOJ1Ir/ooso
 2RSEi4rQ1/LcgtsQVW29oWMv8K89JGxfWRA8jA4QAMPFWDBrSmfUfFnfgpzv70VDgo7K
 iVlQ==
X-Gm-Message-State: AFuF++kekrJxBn/Dd/rVWotBvPapIkNE/hL5E4XeyDLXVd4eHz2qnQKq
 7rgHwSxPNUQdU3j79Ohi9JJOfo10eNZl3YWGfEA54jPtMccPhg4ZDsY1r92wO538r0clYYlatNc
 uKl6+9ZE=
X-Gm-Gg: AYBFou2gJXTC/dkOdsvKB/v6/oj0Ag4UBjLL6F2RhX7nMQzhsxTbEU/hgCP/Qc39SgO
 zp/EoY4S3UONnOqDJ3S26CFC28tRvF3r6wsBx5U8dre+A5sQP8aO0EvCCYR8UzO7AvKB68ZzSK+
 OX8XDOQRo1mtdBngqVvd2g9puzNBJPBaASAec+81qG4jo7zQbc+z+s5j70GgP20TXvvqcVuimS8
 K58DlPDpnWq+z2IwUsIqc/bqEAYtneb9NTZz2K1rsgVpd/Ik4+XGkL1PJ6wX0H7jVUnONH0IqVz
 yuE98yidAtfhd++UzytjD4KMbHNc0Tza6kIywtOAopK2Zu5kQ50nhYYnbhlE22jyvdrEyCfwlRi
 +tcqzI51hW0oCZt4W2+b1uwWfhC9P5XrghnykfcH0wTAnWpkUMzxFI7lfCAG2k1mWlH0vHUFV+N
 67Ujqygcy46lbd/9pQg/4ITblo6eApXctbXUnaq+QAKfBNmHTHdRI+HuREs26pUFrexYHaUjT6V
 3u602cZa9rOyQZtf7UT/GQpB2VPOx4xqzMWIi2o8/bzh6pK5eeW
X-Received: by 2002:a05:6000:26c4:b0:485:847c:4c64 with SMTP id
 ffacd0b85a97d-4858729b6f7mr34767623f8f.28.1788724936503; 
 Sun, 06 Sep 2026 13:02:16 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfdf6sm24592173f8f.34.2026.09.06.13.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 13:02:16 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 06 Sep 2026 22:02:02 +0200
Subject: [PATCH v5 4/5] image: sparse: add phase-aware SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ccaione-upstream-spl-fastboot-v5-4-023516e77321@baylibre.com>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
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

Require the reclaiming SPL allocator because the sparse writer frees its
temporary buffer after each image. Use a 64 KiB SPL fill buffer by default
instead of carrying the 512 KiB U-Boot-proper default into SPL.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 lib/Kconfig        | 13 +++++++++++++
 lib/Makefile       |  3 ++-
 lib/image-sparse.c |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 24e55ade4d3..fc8ba70c7cd 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -205,6 +205,10 @@ config VPL_STRTO
 config IMAGE_SPARSE
 	bool
 
+config SPL_IMAGE_SPARSE
+	bool
+	depends on SPL_SYS_MALLOC && !SPL_SYS_MALLOC_SIMPLE
+
 config IMAGE_SPARSE_FILLBUF_SIZE
 	hex "Android sparse image CHUNK_TYPE_FILL buffer size"
 	default 0x80000
@@ -213,6 +217,15 @@ config IMAGE_SPARSE_FILLBUF_SIZE
 	  Set the size of the fill buffer used when processing CHUNK_TYPE_FILL
 	  chunks.
 
+config SPL_IMAGE_SPARSE_FILLBUF_SIZE
+	hex "Android sparse image fill buffer size in SPL"
+	default 0x10000
+	depends on SPL_IMAGE_SPARSE
+	help
+	  Set the size of the fill buffer used when processing CHUNK_TYPE_FILL
+	  chunks in SPL. A smaller default limits transient heap use in the
+	  size-constrained SPL phase.
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

