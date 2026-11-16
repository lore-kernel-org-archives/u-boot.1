Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6B606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ls8Fu4Ru;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Of1hSEIe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C250981005;
	Mon, 16 Nov 2026 20:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LwnFj_pfrfiK; Mon, 16 Nov 2026 20:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0095380FAB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794861937;
	b=tIUsNDC3hBi3nlhh7bxJvKZcP8t+7FiS5LaZUh1rbXC1Jfgnyhhph0gZBrJLHqyzMraz
	 LV8+S2+JZkuo4xdmUxgS0OIpwjSwsZCJBJ3h2TpChbsVsaQK7v4yE3ecFqxwEsC19EoQk
	 b13I2GGNm4aRQPQfbbPy1fjaLszLIaiCr/K+xaLayM8iu1jOuCcMY+f6bUFvNVY9kJbM3
	 kM1h43VDHrcsTJ1ePM2d+WYlNXwK7PXlpHsoinGgVX/69odUa1BgkXaDJip40nZVxFcXe
	 18EFskPoHH/DUgSwgK0mQ1+ct8ePxZfQ95dQJk57GqswKKyNa5Zm1uA8sPyWG6sF4mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794861937;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OG/jFZVAiaF1mkN6+CeQaXHRODn6hi/FAdGbtixxif0=;
	b=j8x1EW8uMw/uPsGTMpPuXp7D2yi4suVJ+b3pCwmGAJKVUy1lOiHqj70eftGvlg1MdXLm
	 fo+ItikMu0pKOj8kmfsWME+mvjMTdIqr3QY5LazzCZp3AjlwHW7crfOH4wab+dw6YEZQ2
	 rqyq1PakcB7BsLuLA7MadqrsgnfDJrDMHjUsDr1/kq2sWp4BxAS4GiGzVtPaQTO9WzOqH
	 cEWLYwCMbZbEgH34q6iuJgUFYJ89qL4DFqoD+D/OM3Szf0nE3Ths5dDjsd+vshftfJTxJ
	 1rpcMb5DCkHRomM83YsMDXo74uBvn2MADe+IkBcFrXMh0ONb+kyzZrqWHJap8DnHhVw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794861937;
	bh=OG/jFZVAiaF1mkN6+CeQaXHRODn6hi/FAdGbtixxif0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ls8Fu4RuSPX4yk63m7lcdH70Bd/UoHZR3AWWIJKQpP0qiibfjgJhYRn5bXAdaHtq6
	 YEmQDHUmY1aLnOyF2pujBryd7VM01bLvl5OgdutNBLNOxzbxH/BB7qKRxCFumhMELZ
	 SuIk9F2hQYND0WVZPcojU8L9zCZZV2qPFFrtEYsEMtC64hhWm80TklM+cVSaOxcbUq
	 evCyfJatitunFnMs9tjQcIi9Xg3+Az8funXhlV0CP1Ug89lzYNsb14UluSzbpr8Jot
	 yqexVkO/JYknnaJjz7Wf7qo8stT49p6cCTjNb87RL4BkL5zdKkO4uiCKWb1RQd2B3J
	 Whr5Ev3p6yZ3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0095380FAB;
	Mon, 16 Nov 2026 20:45:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A2F74DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 501E840670
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EMI09LVZjrv5 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:45:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 659A040644
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Of1hSEIe
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 659A040644
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:32 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so24946095e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794861930; x=1795466730;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OG/jFZVAiaF1mkN6+CeQaXHRODn6hi/FAdGbtixxif0=;
 b=Of1hSEIezOEmAadLi6ozKqSUKOgl/WmKdJ48PHNDCaTkF/+AP6mECGq6viQfcObVZ/
 K4H61m9eBLupysEbKLhhBPRflRF/pISF2YJ8ToVggTi2UC7OIzDfGOJPoBN+r3DnIPuO
 izUtIjzCtNk0AmmzHxIcel7EL5evnzde5o8I25ntss0KUrdyiZ5XKeVy7362oAI3dHGo
 B1zp1zKn/FXiN2ZDDkR4HuJIlm0cHlSDw9KYjS529w7R8sAA71LWKI0Pcw6bkVTsiGLQ
 hzY5PRKGcJjDaFhE/a8EYuuWzEiBd/T9JNfm6sfRXLwwf6F5I/VjMzw7n1gM2PGvCrhV
 dWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861930; x=1795466730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OG/jFZVAiaF1mkN6+CeQaXHRODn6hi/FAdGbtixxif0=;
 b=NPzJFLdBTlL2A6Q4e5oICTRRjXcY10jBfDRkPTbcDYEOcaTfiDq5YAy7v+JoNFJxZ/
 EDtu3EormQh9MKcvyY7GWIgvnednANjEk5bsKEZt292zHPfOq5h0molRJyMz3S0WwllZ
 cXbcNSAytBiWY8xh2wcpwyL+f6ZV/bI/HlZM1K82c9e5udWai0+a2nZPyAj7ysTGuC+9
 qCR/U8Zo/S4a8YzLbxlX4GI0W2ZWdchw4DfL55LiS35LG4OxIpZha65TIxGJv0+t0CaB
 4NeDrxXyB8s+gyRXyOCQ7zHh5xXGVDWPjwvZCeclhbcd1al75AudiD302iXe4Mm71PDP
 TFLg==
X-Forwarded-Encrypted: i=1;
 AL+hErFG1nGIPwMYm1pETv4G91r/P5g6d1tmU7SG8tGVpIIQ//wfSuRPf4LaAsaa4x10kUgF8p61ENA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9ie1RX+Vk4PmCNn5GcgVkxng01NIr9E17+l4I7tNU3mTWK0HIa
 UA8Q1BR5b4KFyH3Id6pOr1e5CgDHeXII5mEjImRLAjgLodh7/PhXskcW0Txo2xRjYH4tESGNLSB
 pHeCD
X-Gm-Gg: AYBFou1B0nscIeh9IsMCW1o3aEWu51EQ6Ky03K3rUI3vPFY9XnSKDt4u33U3QqOhoFg
 DjVkW08VzK3sPYbZYG0QJtplauHqYhp4gr+ZXxHFbmmHT/uBq+hy6XGEO5v1LSL+kSuyMhvYl6g
 2WI7EgVSiDIJxixuk26R/HWhEJFTEWrSNDLwA/xEq9Bn8LSv9vgAO3DQ/3XAa/5JPcGj6K6p7DQ
 dm1+VHIqVpoTz0Hu/s+LXFuhK/LE8FrEy2pWw7H4Q3wpgEf9Yrw5oD9q5q/ReSRuKXsPOR8xeVn
 bq6xTe6+LveKtM7Ge221sWdTMLGuYmK/CjsRG1ZRqjIn5UUKw+8MERUGwwjsP08Ly4uXmj/y9vZ
 0PGOZv2rdnlCy5xhocs8RzgOADhDDG44PXWF9R0Ol10hCqwpKFALVWH1H42dEDuoLxc7DPbl2ES
 +kV/h6FxY6bNirjq50mQfRqH9xE0lTl7ePNNIDrtSF1j7zRTBodcPPXZoGclo6GNxtm4H7lrtfR
 eDsQzWOV6hHcLAXYT3Lsl0vq/0kqujl8cvNWo+uXInKcc3JwdJNoWIua7OyBHk6X1vwGGneDvDZ
 E6uW8JWcxQR+V3jbJWA0xbOwa25nLnx78Wim2MHHBWUii5aUK6CtipzedeRYg034OMy8SJS1lDz
 GkWKfzT6/wHhqpbjY9g==
X-Received: by 2002:a05:600c:3509:b0:4a1:fc98:1cb1 with SMTP id
 5b1f17b1804b1-4bb55c5f579mr255876095e9.2.1794861930319; 
 Mon, 16 Nov 2026 12:45:30 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78386902sm16855545e9.1.2026.11.16.12.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:45:29 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 21:45:04 +0100
Subject: [PATCH v2 1/7] ufs: rpmb: validate requests before issuing
 commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-genio720-ufs-rpmb-minimal-v2-1-b64eefcfb0f6@baylibre.com>
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

Check frame counts and response space before issuing any commands. A
malformed request must not program a key or write data and then fail on
response validation. Use Linux's request shapes so surplus frames cannot
be sent or silently discarded.

Fixes: b3cd7ddbbdd5 ("ufs: add RPMB transport over SCSI SECURITY PROTOCOL")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/ufs/ufs-rpmb.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
index d9d35a06439..508eb74d976 100644
--- a/drivers/ufs/ufs-rpmb.c
+++ b/drivers/ufs/ufs-rpmb.c
@@ -157,16 +157,25 @@ int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
 	int ret;
 
 	if (!scsi_dev || reqlen % RPMB_FRAME_SIZE ||
-	    rsplen % RPMB_FRAME_SIZE || !n_req)
+	    rsplen % RPMB_FRAME_SIZE || !n_req || !n_rsp)
 		return -EINVAL;
 
 	request = get_unaligned_be16((u8 *)req + RPMB_FRAME_REQ_OFFSET);
 
+	/*
+	 * Enforce Linux's frame counts before any I/O: a key-programming
+	 * request and a write counter read are a single frame answered by a
+	 * single frame, a data write may span several frames but returns one
+	 * result, and a data read is one request returning several frames.
+	 */
 	switch (request) {
 	case RPMB_REQ_KEY:
 	case RPMB_REQ_WRITE_DATA: {
 		u8 status_frame[RPMB_FRAME_SIZE];
 
+		if (n_rsp != 1 || (request == RPMB_REQ_KEY && n_req != 1))
+			return -EINVAL;
+
 		ret = ufs_rpmb_send(scsi_dev, region, req, n_req);
 		if (ret)
 			return ret;
@@ -178,20 +187,17 @@ int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
 		if (ret)
 			return ret;
 
-		if (n_rsp < 1)
-			return -EINVAL;
-
 		return ufs_rpmb_recv(scsi_dev, region, rsp, 1);
 	}
 	case RPMB_REQ_WCOUNTER:
 	case RPMB_REQ_READ_DATA:
+		if (n_req != 1 || (request == RPMB_REQ_WCOUNTER && n_rsp != 1))
+			return -EINVAL;
+
 		ret = ufs_rpmb_send(scsi_dev, region, req, 1);
 		if (ret)
 			return ret;
 
-		if (n_rsp < 1)
-			return -EINVAL;
-
 		return ufs_rpmb_recv(scsi_dev, region, rsp, n_rsp);
 	default:
 		debug("ufs-rpmb: unsupported request 0x%x\n", request);

-- 
2.56.0

