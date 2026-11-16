Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582EE606A331
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fzF2Xhwz;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Z1dMPgyT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55D0580FAB;
	Mon, 16 Nov 2026 20:45:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wG5imkbpGy_t; Mon, 16 Nov 2026 20:45:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 21C9781021
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794861939;
	b=sqQc/tiYEBPH8BdJ1PyqxU/imGbYkpeD5iKpZte3uYCGwO5THHmeFqfQ80nXXAgixW2P
	 iAIRAYXOOPLdHtHwKNzDpj5hDLlRrM+17YNOPk0ymkgVYGtTFlM17dI5EUJjq28JIAPxO
	 tfhE3/nb63Fj6ZDlTMUkEqhgq9exk7JQaqh5UXOSpP1HpnjZLXa2FuqWEkUouZbd4Ere+
	 52vcJ8Gd6aMBGQfbcdMcT/nFX6784Ps03hnBv6CGGelICLfpBWedn1PGzOQJxvxVT1OSj
	 tu+tLmZ9O3v/i2G6IBFJfxSx+IhUBPu7ls8IBMSveAErLL3xcAkD1YUno8y46pLn82w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794861939;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OXLNtdF0c2uSWhKBVQGWWi/rsP5LYwzoSdSz9o7MoBA=;
	b=mHje2ai+SJaImc7wkqg/q2IJ4T/APC4cWRjZIZmBB5GOMmfTlNDe2tmtlvUgeyCHQ4Cv
	 DhogsTFzy5HclYxIinD0biQlQwb+Jjju5iL8m9YJYdzKpYknL3Ls+XHVhCgt22ayVs3fb
	 /Rl98zdBt3jXxGEXiU0yQKchm1fZOq5mCqOUkL8CQWJLcgzkKqA9qkY4Ss+GwG5SPuDYR
	 5KEa1kl8XCKZUoqd73N7c4z3ITgoeukkPIt09uw/O6PAqMgU7J0w+YmBz1mPZf751jaV2
	 BxjCQSZ3VLkL3TR2i282Xf53t22rjALDUjkhoouPB/sLih8NpmvT9Y/DPWdHs572Wgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794861939;
	bh=OXLNtdF0c2uSWhKBVQGWWi/rsP5LYwzoSdSz9o7MoBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fzF2XhwzENlFmXjfLLlGd4sI/YnXzeu8zaZgtCmeIpqcE7eY5GlTRscKFx+rcrseZ
	 N+FLNXzJ6PgleD5VNvYNTogxsDfkPHbW0I9YCGsfUCz+rX/5d2nH2No5q2u4rPMQme
	 5IeecP5utvd7VpFDDYMQ4PYZEhlv1mDEjDvKF8KblknJPF3jaSLeTtiNBQRi2W2rhM
	 RSEjCh9LzUcjyrZjiggbDWjI0RKSdZMmiAEBvuWFB5XEtw5R3ngpoKNjzNVrkyu+Wh
	 JFxx9FdgQHddO2StmxiUcKdOMCx/qfaxYiQlu1fT+eJwgVDc72Zut5sEA2vIbN/nWo
	 E0CINr1y7Kf2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21C9781021;
	Mon, 16 Nov 2026 20:45:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 20580109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 123BF402DC
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WpUi7pm61ile for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:45:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0864F402CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Z1dMPgyT
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0864F402CD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:34 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so1944745e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794861933; x=1795466733;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OXLNtdF0c2uSWhKBVQGWWi/rsP5LYwzoSdSz9o7MoBA=;
 b=Z1dMPgyTBsvAcmOUEraKOKkp0IwEGS0sSP/6r5wp+uJyb5mkPwImQVPtktaiJgXvVT
 VkmrP00QPw6oZzE85jgi6MpejexfnB2NwwhCDVbLTU4eLBdTyhsnUOyB9cOuFAS0Uf+l
 N6hZCGLZs6sQYJoZNgD12srjCvgAxTBp4P0cWKUDbaZ1NSxQDamgTWwHKjaMtS9H83Ku
 yxNBO82F7l5FPOcyqUx4OasLgMaAHPcL7B2LoMQwXIy25T4F1a98bgOH19ch1RsmHiyi
 N2JNUfgywrp63F2DfpY393KF7tyjcgxdqStb5ayFp5u4rdKCs/eWVvEl4sHL39GvkW1u
 XCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861933; x=1795466733;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OXLNtdF0c2uSWhKBVQGWWi/rsP5LYwzoSdSz9o7MoBA=;
 b=1tdRw0wnh+/0KmEzIsFXz+S3HiM+tBisZBMhPzcLhZnqjCbAw3fZh0LLKRjpE3SOTx
 JnxhhQnFwkmGuSabi5Vu/PuCslLni2Hz6AXcpU41yP7d5tYL5wcGpLv1kHuPCbnesJuj
 RsS1M96EQXelIdOtDNQTf62FsOVMeb2DDJ1phAA31UPDIpKUGaYJin90PsAlZcFkhg+u
 UvCeT0V6z4PPE4MDtgHD6FyOW6SMBaWgHZscwdU4AP7P10ZAC8l5A7NSisDjL9clyw0r
 0qVAuVGmoaqfNBKkoUAENuBilxKdtpDgOmprIlFMHCtF4RcHcAddRSGi6YD2nGJ2f9FV
 ulUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF3WZGmjd02ncY4u9anNbg4fM6dd4P6gnE+TzuSdhaOIeiGxvIaOQM16BMChdw9Y2zsYjDxm9M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8jIK1FBo1J0QNvaKjCyNTxRobO9INmqQt7xLTGq8hEK3b5hE7F
 /Kul6KqdmdXcB7l/LLsMRV4mxHKvWxST/h0UYTeEESgAz78JT420cLlq7CIdQHgmats=
X-Gm-Gg: AYBFou2o8Vjs+Ycq2Bcf2kqxbji16GugZhzTTZ5GKHL+67+71C/fn7iWYeKKYzszPeF
 rVNl02PRhNJ0TtvsTMUS+JZl0vOApPKXon4KCo7Fgx1Jf2XIJVEiRE+4FNldgWYct2qHCfeWS6i
 pix/N8axmyD0elVao/lsGbbiFwrv4nJUeny4VAhhf5j0cRu21ULw7WG32MZ902b9ZUX2VyGU4vo
 GSBHl5Hm1CxX0+CAlCcFR/7vxfFqMkYvTOew2zkdYTFkO73GvD4gXmsSzbHymQK9qWGUJWMif1g
 e7+6+UhBEDfhaEVpAAI0909sohn6DW1jifiWlRgS4hW8SMEFuZPEV+no/7IC3YjCY5d74jv9TTm
 n8WnDXDb4ACk4a9hRnOWKM9uDO7EVv8p5xluUOTRLXeJf51CKZOqRdhw8QfuazrlvbmLZPMlOHn
 2BeRZUKe79pEOky4jkFbihft/Uuy+HpRZMbJakWidcD3ZJRYn5/2O6XkPSdWKyipzAv+4Y0XqN0
 X6GuR1KG1/rVKeUQj31ZrtPdDR+yYhgqc+ghaHexGzj9kfkUI+2aOyX+t7No8WNBMdKPQQl72XD
 rueyqYfcikT7lUlY3C9M2fR2u77CEJhDW5+2SEgtFzxYmipLd59z2ik6/kl+Rv/KhqfPuPDXkzo
 v+ViJwI10SaBGgNcG2Q==
X-Received: by 2002:a05:600c:1d04:b0:4b5:d95c:2380 with SMTP id
 5b1f17b1804b1-4bb7838594fmr14846995e9.11.1794861932956; 
 Mon, 16 Nov 2026 12:45:32 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78386902sm16855545e9.1.2026.11.16.12.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:45:32 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 21:45:06 +0100
Subject: [PATCH v2 3/7] tee: optee: keep UFS RPMB discovery state
 consistent
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-genio720-ufs-rpmb-minimal-v2-3-b64eefcfb0f6@baylibre.com>
References: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
In-Reply-To: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RPMB_FRAMES relies on discovery to select its target. The initial and
reset state currently select region 0, while a failed PROBE_NEXT leaves
the previous region active. An out-of-order frame request can therefore
reach a region that was not successfully selected.

Require a successful probe before accepting frames. Keep the discovery
cursor on metadata errors so retrying a failed probe does not skip a
potentially usable region.

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

