Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD150606A339
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rV8i2Aks;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HhbrGj5A
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98F56409C1;
	Thu, 22 Oct 2026 19:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tgLZPsEal3x0; Thu, 22 Oct 2026 19:41:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B2FD2409C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792698081;
	b=rjQIJJNhLnVSr9psgLezIIimoxCcfNesxYOiYPnKKLWRflV3Jby4K2jFO2pNWW75XkeF
	 4yt9TEMrKWHl5pXrXMmHubgol+MFYT+jfxrHHGyxWwck2FJlr6s+4OHkVjSrNghf7MVJ4
	 Tid9tdKxqGdiqNgLmihQe2WFZPMK2W5BYb+7wTGPJTBEEnfqFHMtT0B7Z1uD3xsNHFktT
	 q5eFfA427H1QsiEVVRl2p0tnT32um5XfhKV02pkhgt1ZgGLp20ZI2DuOhuvjb5Kz996k/
	 a3TJFWZ3sKhEBDdALRNxa85dLP5pO54JwB6oBQ5GLfozZv7SobaUxs2+fo8x1iD6Mkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792698081;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6O2TaTxezk/xeKLsE0GPimsl5fRqKlG85DVBD+fHP9w=;
	b=ZZs5dQSQ7cqcSBb6u6nngDLQDSvNuBU6mQnMdlXZtHRngQ80g1oqODnW28ggMu9jS9YN
	 T4mI4HSAjUrdkBPGnNKvrOFwWEmMGw4Mg3I3aVtQgnDmq9T5g//heC+IGLDunkRDWq/LZ
	 jggh8G3jiQGSdxuaLQHWhe19PX+93d+sXML6mhd9GLTOVyZem7exP0WzU/plVAqZkpZ8L
	 WNI46gWfBI10VjWgsMI2+VQcWKXrBXtTCy64zmergQjkT4KrCWMonnw7UzrBKvF10DOl6
	 IJHrwjmhvFETbr2IwzFB61Fdz8Z65JX45Z8ZbMUOhcxpYomGj9ivicN44qrd2QvSNAw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792698081;
	bh=6O2TaTxezk/xeKLsE0GPimsl5fRqKlG85DVBD+fHP9w=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rV8i2Aks+TpNLwDfTfpFhU2UYSW7+vadD+HoCpfXzMlyX3Uvez/buCgRUs0tBwTuT
	 U5j0QjRmby3DGNXcasEkBtaQ5mOk2p9f8FoRgbmq/Tq5F8QUKMu21DWQ2rHksiCgdG
	 kO/Cp6zR0mMCKVKntB3gcK1hDF6KQphmUFn8bAoPSDOfCp79RhIs+vu3J2xlfkQqVe
	 Sgzwf0hejcfuNjRY/hbjBrpRA7ZQA62RRLnhDi5P+/zgQDlOkie1AJ9SZ3dGkkGwE8
	 O8t8aVlJYr2oKS3C4lNHmY1IafgHN3GkR6c65dacmoNNq0JeRDcnx4w/PoEo811yKw
	 AMpY+spdsjD2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2FD2409C3;
	Thu, 22 Oct 2026 19:41:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E96DC3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD735607E7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dKw8NRFIGjJR for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:41:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C660F6062D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792698074;
 b=gIsz6iK0+0PDE9AFuUZLoojOCcANwysKbr7HgSuamx9Cf3ceE8mYUc2UND0H0EV0GrF8
 f9/nHBkiFk2B7NlNBscM518fCiqtNS6jf7/cZ8UfrqqVqPQAMhCOXhpy/RCHGBECtP/RU
 Vr5FwnONSelSD/w3MRw4fnrIIlKCTJHbpusyUyaoAHuG6XcUDkct9qUN3lBGlA5fTqmyX
 6A24bpQYOuYrecv3iylF2Vb1+oSdS56OnNnb/OaRJS0xkOGubWVgDcoGdR/SN3i0EQO2c
 /CTrxVSBMUPdOnkHm2rlSrxcwE+o0rvnJzI9YuqbsSBcUYtx7nm7G0Ll2fMbTzv+3kQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792698074;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=6O2TaTxezk/xeKLsE0GPimsl5fRqKlG85DVBD+fHP9w=;
 b=gnOoP4+w5MDlUGJQd2LyVtf6T4fW7crgcIf8+d85O7cq/ctKqbf2xSeTddYMwlzPZcHo
 K2NKEy2xf+xKaH0NNs9nE/R/+m0HiC/OIhEsjdQwKNayoiSzHmK5YDYGbHNOssL3ji3qq
 oTaIzjdJqXmZX65TQXfTop+yOighD6+7TZJ8aKTEHstmbzv/70+W2TAmf035J8Ikm6/hT
 4qS4Zg3Q+d5otXOQjBpFZ20AZMNFd5eiGXdvRt1ZD/7lYV6q7/hKzVIFCUamh7jUsMTGq
 IenjTckq2JMQUG+8Zv+tphray9gCHQBOEKxasnCFCNf30OP8IPtafpB7xoLgnGajYBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HhbrGj5A; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HhbrGj5A
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C660F6062D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:13 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso1686595e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792698072; x=1793302872;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6O2TaTxezk/xeKLsE0GPimsl5fRqKlG85DVBD+fHP9w=;
 b=HhbrGj5ADEcQ4Bh8w8sj40VCrrPBS//G+rxOuNSPSBs9uwmfkd6xq1PA0987b+Js4R
 3gFN4T5m9ZESCkj99YJnX94MwuKn8PgYBMYBPGj3Z+Ac1vTbbI2HLJqYmxu/BrRSWFr2
 tbfVL5HxvBSICDsMjWFK55ag4adaETaQkMd0i2SYwAP3EJ9EnNn6K7A98KW+K3LOG3Mk
 yslRllcPGC3prxCPjvbjQXJrbOQ1tGicmkU5Ev4QkI6MPJdXq7YUVR4MLONS0wTjcRIB
 aIhwETssnVlVTSGbR6spQ6aX605t2F0MK02SlpWFWCXKKC/e+X0PE7IPhiHAAk10fDwc
 ecqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792698072; x=1793302872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6O2TaTxezk/xeKLsE0GPimsl5fRqKlG85DVBD+fHP9w=;
 b=htyyY803Y0Qz6DgvhWSPcwbKV04h95OYl/hijfl6ysePkbGuHLOghsLsXCW0llVf5u
 R1dfI4pGbLKx8pdqtqB4dXVcycQzXACYTLc4QkUiyNGzXQXxXZZMfAMTZs/d5ZSP9f+B
 mJ6yOXHlkGi8MWrCKUUck5CHfGzZk1Pw2V28ksgOTHd/GJJVOycXgpFTJ4On3kMNaOoX
 5GPaCPvO5cnV3mnzVBjejbg8+3rkvcmoizPtHTXZRgHLsuveHof9RYSwycQXuDVi6mfS
 yZs8nH4y5bSfOuj1cm8cRwLIhfcQk/M0sz3keu95uEagIIdt7UeHpf+BA+CV3MxCb3YP
 ejrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5bqfYFLzqUzEatwMiwwj0HfyoRNvDlm/JoZlWbCJ8NbDWySxHcaZbfFIz0AStkw+Rx/dRfQc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKKCylb1Hq1xxZjtasFJ52wRWGSty/q5SvnxXEG4xvv7K1Rb3UD
 OEaPQuCKsLMjLYjxeGOVVAuwsn8OX+JYMRm4vUg/6stCESsxzj6igpsO
X-Gm-Gg: AYBFou0QahoD19XyPIOOHsJoGRTnI/6ZpjORgG1j3DdJDJanOT6LO0/X3Uguprfcw4d
 5aFOtfInGPSpjEBZoKPQ8z6uKbWM7j114M56bF3/pWRiOawaLUKmggMkbEDDRMck7CBa5x4Cuxp
 BRT9hwov5sAMINSdZTyTucdfbfd1fR5gBUhcMDTL3nonb+Ivi/JRlf3d3Xl/jHaztVcYQ0WeOd/
 N/iGBtYGUh+otZPuCG4QJ/GpEer67y/6ngThH04o6RYnQBl00BU42HEZZkbtleasWvkpB6FZ6WP
 304xBFjN/Z0NHAFifgcSzv71CxQUM8lvpAwGkwE5GTuqk6i+Uk5mmM0ptPFeKTNvqRnf/sYzP14
 VkG6PcSqS28Xu5ZJzKPlQl0CpT4F/XDQF9nbhz+xZNardFZ8Iw8gC9cpCtDJ5h3Bw6oIP6rFF4O
 PVyGlznDP3p55FawXycfEPNZmBcYE8EFtvUiA8rDrLJPZSsD8gF3kE9TviO8NEzT91Rx5lPSRqE
 xE/Rpn07a+6hMYdlmI+v1IwPNNxLSsd/qwV8V7YfZjCfSMxaZ2lhK6TGb3Bw+sQHOL4us41VXm9
 StO6px7wR4WbQ4ih/+DBYX+EokVxrUO4jstCy1fM5em4ZOebHclJ6Q+knqkx
X-Received: by 2002:a05:600c:3b07:b0:4a1:d087:f6ab with SMTP id
 5b1f17b1804b1-4a211cbb062mr1471915e9.18.1792698071792; 
 Thu, 22 Oct 2026 12:41:11 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a211be8f79sm3185715e9.14.2026.10.22.12.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:41:11 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v8 4/7] misc: fw_loader: implement request_firmware_size() OP
Date: Thu, 22 Oct 2026 21:40:39 +0200
Message-ID: <20261022194049.670889-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022194049.670889-1-ansuelsmth@gmail.com>
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It might be useful to get the firmware size before reading it to allocate
the correct size. This is needed for case where the firmware size change
across different firmware version and is not always the same. In such case
the only way to handle this scenario is to allocate a big-enough buffer to
read the firmware.

To better handle this, introduce the request_firmware_size() OP to get the
firmware size before reading it. This way proper buffer can be allocated
and dynamic firmware size can be better supported.

FS loader is updated to handle the new .get_size() handler.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fs_loader.c        | 68 +++++++++++++++++++----
 drivers/misc/fw_loader/fw_loader-uclass.c | 19 +++++++
 drivers/misc/fw_loader/internal.h         |  7 +++
 include/fw_loader.h                       |  9 +++
 4 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index 9923fb5e123d..c7aef99be8bb 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -80,18 +80,10 @@ static int select_fs_dev(struct fw_loader_plat *plat)
 	return ret;
 }
 
-/**
- * fw_get_filesystem_firmware - load firmware into an allocated buffer.
- * @dev: An instance of a driver.
- *
- * Return: Size of total read, negative value when error.
- */
-static int fw_get_filesystem_firmware(struct udevice *dev)
+static int fw_get_filesystem_prepare(struct udevice *dev)
 {
-	struct firmware *upriv = dev_get_uclass_priv(dev);
 	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
 	struct fw_loader_env_info info = { };
-	loff_t actread = 0;
 	int ret;
 
 	generic_fw_loader_env_info(&info);
@@ -114,6 +106,29 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 		ret = select_fs_dev(plat);
 	}
 
+	return ret;
+}
+
+static void fw_get_filesystem_release(struct udevice *dev)
+{
+#ifdef CONFIG_CMD_UBIFS
+	umount_ubifs();
+#endif
+}
+
+/**
+ * fw_get_filesystem_firmware - load firmware into an allocated buffer.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+static int fw_get_filesystem_firmware(struct udevice *dev)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	loff_t actread = 0;
+	int ret;
+
+	ret = fw_get_filesystem_prepare(dev);
 	if (ret)
 		goto out;
 
@@ -128,14 +143,43 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 	}
 
 out:
-#ifdef CONFIG_CMD_UBIFS
-	umount_ubifs();
-#endif
+	fw_get_filesystem_release(dev);
+	return ret;
+}
+
+/**
+ * fw_get_filesystem_firmware_size - get firmware size.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+static int fw_get_filesystem_firmware_size(struct udevice *dev)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	loff_t size = 0;
+	int ret;
+
+	ret = fw_get_filesystem_prepare(dev);
+	if (ret)
+		goto out;
+
+	ret = fs_size(upriv->name, &size);
+	if (ret) {
+		debug("Error: %d Failed to get size for %s.\n",
+		      ret, upriv->name);
+		goto out;
+	}
+
+	ret = size;
+
+out:
+	fw_get_filesystem_release(dev);
 	return ret;
 }
 
 static const struct fw_loader_ops fs_loader_ops = {
 	.get_firmware = fw_get_filesystem_firmware,
+	.get_size = fw_get_filesystem_firmware_size,
 };
 
 static const struct udevice_id fs_loader_ids[] = {
diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
index 7f19d6c4af4c..4e67f2559fa2 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -210,3 +210,22 @@ int request_firmware_into_buf(struct udevice *dev,
 
 	return ops->get_firmware(dev);
 }
+
+int request_firmware_size(struct udevice *dev, const char *name)
+{
+	const struct fw_loader_ops *ops;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = _request_firmware_prepare(dev, name, NULL, 0, 0);
+	if (ret < 0) /* error */
+		return ret;
+
+	ops = fw_loader_get_ops(dev);
+	if (!ops->get_size)
+		return -EOPNOTSUPP;
+
+	return ops->get_size(dev);
+}
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
index 9ff43e872554..1abe7504a81e 100644
--- a/drivers/misc/fw_loader/internal.h
+++ b/drivers/misc/fw_loader/internal.h
@@ -32,6 +32,13 @@ struct fw_loader_ops {
 	 * @dev:	Firmware Loader device to read firmware from
 	 */
 	int (*get_firmware)(struct udevice *dev);
+
+	/**
+	 * get_size() - get firmware size from Firmware Loader driver
+	 *
+	 * @dev:	Firmware Loader device to get firmware size from
+	 */
+	int (*get_size)(struct udevice *dev);
 };
 
 #define fw_loader_get_ops(dev)	((const struct fw_loader_ops *)(dev)->driver->ops)
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 99c47380a172..01f242dcbefd 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -38,6 +38,15 @@ int request_firmware_into_buf(struct udevice *dev,
 			      const char *name,
 			      void *buf, size_t size, u32 offset);
 
+/**
+ * request_firmware_size - Get firmware size.
+ * @dev: An instance of a driver.
+ * @name: Name of firmware file.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+int request_firmware_size(struct udevice *dev, const char *name);
+
 /**
  * request_firmware_into_buf_via_script() -
  * Load firmware using a U-Boot script and copy to buffer
-- 
2.55.0

