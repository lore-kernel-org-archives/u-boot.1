Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C727CC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E97780D1E;
	Thu, 30 Jul 2026 13:24:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tsf47aWegMgN; Thu, 30 Jul 2026 13:24:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82EEB80CA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785417868;
	bh=Cpqe6bmLvtGMtnA2gxaDjRNQH/XCKiHSTGo4Czoyi9E=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HP5MYbb1CJiMMui3vD7INUVJKtd0lyH0aqHMJRd93W2LdLYyhSfoTwTTZFi9cQWDZ
	 8kBJbeNTR0fI9RSivs33s/KvRI3MFSiMaW2ScAPZPz7FuXulvgr5SYwgvflh+gFuJL
	 1hJD6LkOrJZ8zFTBHVyxxCgAEknt2VVxuESQzxeN2x7bKyVJKXVi7eA/OpCNEvWk8t
	 0RyUdpX0yfIJlvac1Zd5PaMQ/TRp6XeAEmTAUJ8aTIas/83RS7WaD7H6pSwCMTNBeT
	 0Wnri6otnpvebC/mwxCrRLOswN43ZO/om06LaaHOHQgq2Vy24N2kQdUaEVjupewEku
	 JGj/jwZUzxx4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82EEB80CA4;
	Thu, 30 Jul 2026 13:24:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C818F27B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9F20401A3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:24:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IwQ1nQ0J-9R9 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:24:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A0DAA4008C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0DAA4008C
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0DAA4008C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:24:26 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47de008b020so509667f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785417864; x=1786022664;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Cpqe6bmLvtGMtnA2gxaDjRNQH/XCKiHSTGo4Czoyi9E=;
 b=qRx1Xc2Av9+c0+BjUHWv+HByWw6B+mO8AmhzRrAh4+t1J/lnYQ6rskbXHJh0cLkCQp
 WZ1zGTLLu+PxQn9tnJCSWn4l+y0oEwhJMq6HQ0p8sajPLO4UdRdDHfwW7954ByUaLh0i
 rXCOEv9OEQe6AfNiLL7kc7g7QWhEBxy7JvaSkwQJdOE3o1tbs4AeuAN+7oEqLzy5vcbE
 dsdvdZ/W9N+UQMQ7g3wTp3/0uD4SwO0RdHJ9ZtI0IQy2pSkUphxX7y5Wxb13JziIXdYN
 BGKiwrEf8F6SSoST0zE/JnZbWGzZ8ZYEeMzF4UMRQsf724ldqHzbQVZNXx2TqH1hrw/u
 OdhA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCi3MZBEXK59XK9bf2ERmLHieuG6TiW4MRle6sVt8IsRB71bN3sl0lBiGQxvR391ZTCYMF0h0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YymXWM08bre75bgA/iUjWUJ1cj9rLBu/Bra5UghPqfrFupdME99
 y9vDIBdHVEt7lYC3XEEZA0AgK/fLgJon1KpSmKmt6KLOmEBlxJspGbBCE9H2dDGkxW4=
X-Gm-Gg: AR+sD10QvcSLv52tvgOT1MqZKpY3XujT21iYckHXBsuIIc7X9klwJCZKUWcCrRl91J/
 4bHqUS6fLZNrhcl9TRCj57JL32oV4EBSEVmYF69x57lOYxYk1ps9C613BoDtL1Ynb/qyiuwnQBI
 tThHYQU2k5nkGximybn5DUa/3sQfxV/U8vrXRYTalW0LLR0zilOyL69ILuTCSV3KJ5C7zW2uE3p
 GsEvzrkr7yUvRuGq6VJ9CiQdmMAt04N7+t7frOfIIk/M0+H3Xk/Jxqo8pDML6HGg31sG48avVBd
 /1bVD7T/qdkgVKdwy5CvwLmh2ZlUlfMAMIrcPveSMepgefoYsoVJamKe7hc38+KX5xqMSt+cs6G
 U8X4PldO78UKcEP6D3lyEusUpuXRI0ItlSyrP0BP6TCa58GhZRyXAAfcljICz296WnLXJoc1gYG
 jZm3x2vFOVzMLj1wS3yAVCWHyuSWOT9koL3AhdIwrmqh7s5dYviA6zIxlIc7ZdV79A/GnVS0hDw
 AVW/EjfcAb6p5pcGiO1ANppzLQxyMzYQ/bInTT/fQ==
X-Received: by 2002:a05:6000:2702:b0:47f:8b0f:7172 with SMTP id
 ffacd0b85a97d-47fcbc814a0mr547762f8f.6.1785417864274; 
 Thu, 30 Jul 2026 06:24:24 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc89418c5sm6520093f8f.33.2026.07.30.06.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:24:23 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 30 Jul 2026 17:24:10 +0400
Subject: [PATCH] spl: fit: Fill in the image descriptor when skipping a
 zero-size image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-spl-fit-clear-loadable-v1-1-6f10c724f2b5@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAyA4VchPdtkborEVzEc2lGwZgGyAjEhv
 LtTj9/h/3cwySoG92qHLJuaTmPB+VRBfNI4CGpXDN752t2CQ76gzQl7XTAmoYxpoo44CYbQNFc
 iYs8OSj9n6fX9ez/av23ll8TlO4Tj+ADn28KAfQAAAA==
X-Change-ID: 20260730-b4-spl-fit-clear-loadable-33885aaab2b0
To: Nishanth Menon <nm@ti.com>, Aswath Govindraju <a-govindraju@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Francesco Valla <francesco@valla.it>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3421; i=alchark@flipper.net;
 h=from:subject:message-id; bh=G76JMWrfG+6zEG4V7OBaoLahBOCRbofwrY3HT2a23bc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRlB9TJ2XhfmXVlg3jD9gu1TJtnqws8ttV9+dBe82rp1
 m2HJ83s6ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqG54z/GbZs35z9FzeK4FSPYG+l8JnaV0z3py7Z1Z1u8oGg1ox7ypGhuNGUzZ
 t+d1/ftvlYB87v0+bfqZ28AhOvmGe9k3smXPBDmYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785417864; x=1786022664;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Cpqe6bmLvtGMtnA2gxaDjRNQH/XCKiHSTGo4Czoyi9E=;
 b=J6OtynYkmLvRiOgX6IJOXrOWRtZSKKhlhuwoUfKfpwFlbMxBR6XUjTRxof7+rI2jBh
 zku27bwXi44qVnHDDotV+us0lX4F/4WWDx6bSTLDFVIO5fd27LSTBUSSow/mLBYShtUv
 WXRerqbOjhj0p25BdrNw1OwZ8pLXgXLksR/byDRaXAeGci/5/UwI1N0rgc97PshOMOKG
 XRRAycPd8xnnR0Eu53jmc9CDNOF8XuuB5x7chS3PSE++fcJOKdroAy7QxMSTAqSPHN00
 RNxUV/MrH2yW4/QkWMOCaIIWpL7HzmQBBtPzkJ2wrxEpTSpyM429kzrOzPHF7cJjQDtB
 auGw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=J6OtynYk
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

load_simple_fit() is expected to fill in the image_info structure it
receives upon successful return, but the path which skips a zero-sized
image returns success without touching it. The result is that
spl_fit_record_loadable() then publishes whatever else the descriptor
happened to hold in /fit-images under the skipped image's name: the size
and entry point of the previous loadable, or - for the first one, since
image_info is declared without an initialiser - uninitialised stack.

This is reachable whenever a FIT carries an image node with no content,
which binman produces for an optional blob that was not supplied, such as
an OP-TEE which the build did not provide.

Ensure that the image_info structure is filled in with a size and entry
point before returning, same way as other successful paths do (but
skipping the actual load).

Fixes: 6d99f866952b ("spl: fit: Skip attempting to load 0 length image")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/spl_fit.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 18bff7b8d4af..0dbc0ba81535 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -193,6 +193,33 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
 	return ALIGN(data_size, spl_get_bl_len(info));
 }
 
+/**
+ * fit_fill_image_info(): describe a loaded image to the caller
+ * @fit:	points to the FIT image
+ * @node:	offset of the DT node describing the image
+ * @image_info:	filled in with where the image ended up and how big it is;
+ *		ignored if NULL
+ * @load_addr:	address the image was loaded to
+ * @size:	number of bytes loaded, which may be zero
+ */
+static void fit_fill_image_info(const void *fit, int node,
+				struct spl_image_info *image_info,
+				ulong load_addr, ulong size)
+{
+	ulong entry_point;
+
+	if (!image_info)
+		return;
+
+	image_info->load_addr = load_addr;
+	image_info->size = size;
+
+	if (!fit_image_get_entry(fit, node, &entry_point))
+		image_info->entry_point = entry_point;
+	else
+		image_info->entry_point = FDT_ERROR;
+}
+
 /**
  * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
@@ -291,6 +318,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		if (!len) {
 			log_warning("%s: Skip load '%s': image size is 0!\n",
 				    __func__, fit_get_name(fit, node, NULL));
+			fit_fill_image_info(fit, node, image_info, load_addr, 0);
 			return 0;
 		}
 
@@ -385,17 +413,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		memmove(load_ptr, src, length);
 	}
 
-	if (image_info) {
-		ulong entry_point;
-
-		image_info->load_addr = load_addr;
-		image_info->size = length;
-
-		if (!fit_image_get_entry(fit, node, &entry_point))
-			image_info->entry_point = entry_point;
-		else
-			image_info->entry_point = FDT_ERROR;
-	}
+	fit_fill_image_info(fit, node, image_info, load_addr, length);
 	log_debug("- done loading\n");
 
 	upl_add_image(fit, node, load_addr, length);

---
base-commit: 44f0dcf476140c1077ee3dbe16a80fdb6f8265c4
change-id: 20260730-b4-spl-fit-clear-loadable-33885aaab2b0

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

