Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40998606A339
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g3xMgXJn;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ct+n/RpM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A52EB40A50;
	Wed, 11 Nov 2026 10:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8dEh1icbeDoK; Wed, 11 Nov 2026 10:21:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BC8A640882
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392517;
	b=CQC1vgFSs5pKvurNKSr3Fp7FVH+CJ12OVO/8vd2gqqr+SN0rx/BMa5sXHO0x4pczS3K8
	 6NXZPPdQ0UdiW3vVTAiD1AriZ1nGI++LvJiuyhu1L/O5OGXGgsXdqymQjdv5a+0HBdUgh
	 M0484I5dAyQoStQYr8rlp6XW1cZvMuW8XyV7Ihb89s/mxZ+Td/PZd8+H/uYme70dICtOo
	 3kbG8c97qKUxwgpvc9qu+HT90LayermXOAt0z6zyDiRk8VAwJm5UKeZGK8c5qNeaNFJW0
	 OwKhoNoVekP01jqdipexT7JNAqwz40JhveNCl4yxItDdIRl2sJpj4GPfeHhf45RvmjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392517;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SYrOIG5iSfMy0g+mwPRz6ZTePqj8BhWolAbZOqq/t08=;
	b=WXWXHOeBBQSGCht2xrM33dg3wkSUyRs+7eYAzv7PDFkpqMwRbcBJ4Q8jvPxp7eHRFuAG
	 5wM2r8dbFgFT6dc4E0s0IwIE/n7bf5hUYNNxfjsE1f6OLaq69BA03gDzuShkgjIC6AcLy
	 I9wtgRazbNFDZ7ZI2aEDY46U1ndp9Q8qZPBFSjXmtLA8hGe0ckWnH/up9z0lLCaKTxD0K
	 uKjEP//azKETdm+3FIo+50xOvMaNSCrdEA7lTCuo+Cr3jbKASrclHG/jFzHM4IUXK/C67
	 IMYxzswN55/PcJtOBHTRWwX+xOXzsR7FDf6UwYVwhFthVwR4rQvF5piB35yZkiPGEnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="ct+n/RpM";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392516;
	bh=SYrOIG5iSfMy0g+mwPRz6ZTePqj8BhWolAbZOqq/t08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g3xMgXJngCUoBADoy8ZaEJoiTVTAvv6sUVQImMydJ9YqFgXLUEGZeOvuAPOkNJh1B
	 Mu02IDdH7JeDlF8PkwrxTcqVmN8aFGJniO0tvgS3TC3zC/LBceWPSdb2N2DV25kQr0
	 T2Uadvf6YIdeeX4xPrE9T2TF5Rmn7NDITqIuLICpQJLT+v3bpqQ2NEJqTy120poGN3
	 JuNgGRKTmrNZzWbKwMZnKPnZFPi4VFQUIkq+Udn91PO68hOb5d/J8mxZspnI1iYjPc
	 HDqRnl6et/rxOQUEIomBozxaVfnUrKY+4bGCUl3usphfvtiCZqSe2Id6YzMX2YuCIj
	 DCpGM1kPiP+KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC8A640882;
	Wed, 11 Nov 2026 10:21:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B345F731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FEC240871
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YpBfaAjqF5KY for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:21:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 339A840873
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ct+n/RpM
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 339A840873
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:49 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso30315365e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794392507; x=1794997307;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SYrOIG5iSfMy0g+mwPRz6ZTePqj8BhWolAbZOqq/t08=;
 b=ct+n/RpMmoRopyC7jfGHlySQwYfR+dJ7eKLkn8qTEca3HNgCfOK3Cr8Th5+rh1Qeb1
 awBkJlmrgI44BgjHV02C/Zjl7y13Ajr+cuhJsot3WsP+RqNiufmaWdzl11XKD+RcC98Q
 wjAJ5oQ3cioUIKU+I05aNVqraDgBZ2ogddXqbvJRn33Ja2tgTSt3bYjG+ShFghrHJJeK
 GZe9G05r+iN1euVkjiWHCh91MUuPX9BtjgIUYtR0zXqQXLHSCYwZvXavwI3ZC2Cm9iI7
 +bv43G29Ocq0/2fhD8dbxvZI2isB9P+f5FMQ9i3QW0yo81YxmjIGbh7cWzcYLjzFXqZq
 TZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794392507; x=1794997307;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SYrOIG5iSfMy0g+mwPRz6ZTePqj8BhWolAbZOqq/t08=;
 b=YDSL/FpaDg30+hOeHJQ9yjniB2Qyp+62J4htmkzwjXZ3EZ7Y8JhPr1tOmqnroUXFZ2
 BSaZkm3k3MUrPwH+l/8T5SGUvvx+BJ941Ikq4tMKKUavoWP5SyfXlE2+HAmWXBL8fr8Z
 s6BuPgMf0b8d3LKwTLhZOYxEfwWWLPVey96LUSZdzgO2tbCI1Tm01FHamgUHDui2UA1W
 i0Q+Qy1LTF4H/vt8t7avR/7M5CHv/nVL8CQMCqS3mCkz85ONd9mBYSVy8uQT/UVdswZ6
 jP5LuSXDdOL+Aa4Y8NVbqyZaVE+/koS7moDHAnR6ibDlGFrUbirbiX4Dhe3JAL9zqDxW
 8YPQ==
X-Gm-Message-State: APuU4Z/iW8GVPtxCPnOdBzfngxYgr0Y86SlGZ8FTp/iQYEaCv3V6CK4W
 CSsd8fyq4RjUdtyTvk+B3XwIEYFkUSwfkU5EhEVWt6uRGLS8wvRVQfoXYCAGqDqcG9g=
X-Gm-Gg: AYBFou1ko8HPrlp4vwYBa/AR1KwgmxdTyRhXda5ooO5u6i7y4sg3ONHAmhLjX4GJG6M
 LOpupCGGJ3VNjhAS5ESfDCr1vqcXsBBzi72wLKHfLOydRUScq+mHEIQLc2SQeWQipQl4MuQAd5M
 45RAFYFNb08hm0/jPo7+ZJyiQ5/lMIZjgRkT/DQN6Pxq5xJw/lSz5kA8PVs69Pl41229hTNDCnM
 HVt2ivuyb98/JMYzpgpnjgKvva/YEs5Dmy/gsAxDUPhrtHIG2agmCi4o/qS4rpsYhp+wPfInLDy
 BNfKOzgGPogj8kgz3mgph1rN7okPpNOXFXMrG9c+IdwdMfB7ztJIef7+DkxmwDgUTJPG05j3RaG
 iltYKtJMubVkvBMb50yw+lwv0/3tnq6wDOPH4jDOTulgmTVrm7+HcP3J6+k82zCTm2Gcp1R/Zmp
 iQnm5ATi7F9yPZT90rQQJGNUT8Gc1v5VVRqIrj4JRYy3a0IbUSnJRb+k1xbC0KQetxHkLv1SdaI
 s6VX6XWU3vp28HMOMowjcXWXTrOuVIFv71CUFYDeE/sK9XJCgCE/k0iPWCmawjDKa57UhjHp1sC
 pG6nJ3zEveUkQpWlw4TCDg9w6ni9iTtosUtM+gvTXzRLrPp91CP5zLuVCW0TyZa5Y5jDC57KApS
 wMfgsyJ6jFvf+DPnyHFX6nTg8+5cf6XZ7mXkMLbV7FpYPDg==
X-Received: by 2002:a05:600c:4f09:b0:4a2:d99:3171 with SMTP id
 5b1f17b1804b1-4ba09383b92mr34700425e9.23.1794392507522; 
 Wed, 11 Nov 2026 02:21:47 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm10550001f8f.18.2026.11.11.02.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:21:47 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 11 Nov 2026 11:21:36 +0100
Subject: [PATCH 3/7] tee: optee: keep UFS RPMB discovery state consistent
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-genio720-ufs-rpmb-minimal-v1-3-701a62dfa034@baylibre.com>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
In-Reply-To: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.16.0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reject frame requests until discovery selects a region, and invalidate
that selection on every discovery failure. Keep the cursor on a region
whose metadata read failed so a retry does not silently skip it.

Fixes: 3b39df3bc540 ("optee: implement the RPMB subsystem interface for UFS")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/tee/optee/core.c          |  2 ++
 drivers/tee/optee/optee_private.h |  9 ++++++++-
 drivers/tee/optee/rpmb_ufs.c      | 18 ++++++++++++++++--
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index a47c76811cd..2abdfd99e5d 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -829,6 +829,8 @@ static int optee_probe(struct udevice *dev)
 	u32 sec_caps;
 	int ret;
 
+	optee_suppl_rpmb_init(dev);
+
 	if (!is_optee_api(pdata->invoke_fn)) {
 		dev_err(dev, "OP-TEE api uid mismatch\n");
 		return -ENOENT;
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 5c72b280058..3f9fea532e4 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -34,7 +34,8 @@
 /**
  * struct optee_private - OP-TEE driver private data
  * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
- * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
+ * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT, or
+ *			UFS_RPMB_NUM_REGIONS while no region is selected
  */
 struct optee_private {
 	unsigned int rpmb_next_region;
@@ -97,6 +98,8 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
 #endif
 
 #ifdef CONFIG_SUPPORT_UFS_RPMB
+void optee_suppl_rpmb_init(struct udevice *dev);
+
 void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
 				      struct optee_msg_arg *arg);
 
@@ -106,6 +109,10 @@ void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
 void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
 				 struct optee_msg_arg *arg);
 #else
+static inline void optee_suppl_rpmb_init(struct udevice *dev)
+{
+}
+
 static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
 						    struct optee_msg_arg *arg)
 {
diff --git a/drivers/tee/optee/rpmb_ufs.c b/drivers/tee/optee/rpmb_ufs.c
index 0c820e9595d..fbb56305609 100644
--- a/drivers/tee/optee/rpmb_ufs.c
+++ b/drivers/tee/optee/rpmb_ufs.c
@@ -8,6 +8,13 @@
 #include "optee_msg_supplicant.h"
 #include "optee_private.h"
 
+void optee_suppl_rpmb_init(struct udevice *dev)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+
+	priv->rpmb_cur_region = UFS_RPMB_NUM_REGIONS;
+}
+
 static int optee_rpmb_get_dev(struct udevice **scsi_devp)
 {
 	struct udevice *ufs_dev, *scsi_dev;
@@ -32,6 +39,7 @@ void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
 {
 	struct optee_private *priv = dev_get_priv(dev);
 
+	priv->rpmb_cur_region = UFS_RPMB_NUM_REGIONS;
 	if (arg->num_params != 1 ||
 	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT) {
 		arg->ret = TEE_ERROR_BAD_PARAMETERS;
@@ -39,7 +47,6 @@ void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
 	}
 
 	priv->rpmb_next_region = 0;
-	priv->rpmb_cur_region = 0;
 
 	arg->params[0].u.value.a = OPTEE_MSG_RPC_SHM_TYPE_APPL;
 	arg->ret = TEE_SUCCESS;
@@ -57,6 +64,7 @@ void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
 	ulong cid_size;
 	int ret;
 
+	priv->rpmb_cur_region = UFS_RPMB_NUM_REGIONS;
 	if (arg->num_params != 2 ||
 	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT ||
 	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
@@ -78,7 +86,7 @@ void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
 	}
 
 	while (priv->rpmb_next_region < UFS_RPMB_NUM_REGIONS) {
-		unsigned int region = priv->rpmb_next_region++;
+		unsigned int region = priv->rpmb_next_region;
 
 		ret = ufs_rpmb_get_region_info(scsi_dev, region, &size_mult,
 					       &rel_wr, cid_buf);
@@ -86,6 +94,7 @@ void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
 			arg->ret = TEE_ERROR_GENERIC;
 			return;
 		}
+		priv->rpmb_next_region++;
 		if (!ret)
 			continue;
 
@@ -120,6 +129,11 @@ void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
 		return;
 	}
 
+	if (priv->rpmb_cur_region >= UFS_RPMB_NUM_REGIONS) {
+		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
 	if (optee_rpmb_get_dev(&scsi_dev)) {
 		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
 		return;

-- 
2.56.0

