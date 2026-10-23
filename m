Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF6606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BIuTw2Tj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ubfl/+vr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B839C81266;
	Fri, 23 Oct 2026 11:16:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4DhUmENb1d-7; Fri, 23 Oct 2026 11:16:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2665781201
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792754171;
	b=ERP9fx3RW21Eq0pjiQMqeQ/NL6gtn6qd3T6++p8vHsL50qncGOKWDDE2xfS3PNzGNly+
	 oSkKopmhMbZLvewYu2pK/8J57cLNmFqfwGvVwxXOlreNQ3IeuBZ1oW0QACfoUW9c3RoLm
	 +5LHbNZTvpEXEXxkvTqZ3wMoP+htTTGmiaqNKov2ThCw2Fyhr2NCqYZdkv8/Sot85o3sg
	 i0Jg8tGI3boxAB4OhPdjc4IjgT26kptO8IXxQYf+rfrltrqG7y3gezKn83jwKDaZkhTvW
	 T8E6GvUUryGgEALoueJCbjMhtXM7JXv8hglPqmth9vXozTq3+cOq1Zs8CqUnKUvJDZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792754171;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/wuxQvYn6re14lkIuIK+4pWUz1i5LIz5NOq5VLoewc8=;
	b=pdaQnJaMmkbd/5e3ykcTQZXruKvLTcpohJ0PVhJPBc4DLqqdaW3jGRJj687Qg2JIgak5
	 WA6mRkRW3MUD0NehktZiukQM1gq5mk7Zf+CXXpAou/OV8wxJ4jnQk/wNfvT6311ThIFXD
	 FEe/r5V8pOpjxOq0vU/rn+cZ73ymsLCWv+RMJVCpsyWMOJyZuYjZwp+NALyQaDg55Q4FC
	 WdVxSRnYuWd/US7qLqxeKsVBGfioZ+hiPJTqUQ19MLu3cXSQjeaIJpBRrVcoOL51kgtUq
	 Tp6/bQ1M0cJvY5D790XNtzlmoNPsh2nH3JhWOOzhGrekIZaPQW7kZUQdr3JpCmyUEOQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792754171;
	bh=/wuxQvYn6re14lkIuIK+4pWUz1i5LIz5NOq5VLoewc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BIuTw2TjQIgj/Gmk1M3ARcrI1N4BEJWzh7XztOAl+eSaeqFhUVtwHwxhBf0kns+nM
	 JKq19jycPQukSELdVK4/tRMjIBFpUPjygy1QwIFllyIWww95pjpVA9Otw6oRjaM6s7
	 CH8ERa/YoRdShvWemWNcTsBTQYlVNjqnROc5xAC2T9ebUavqo9/XVSnogvSoiPc37S
	 PqysiB1lUdH+yoIVMxj2IQPcpzy89w2Zeps0BxhwNM093MwmkR1LrAbXurC4BoNmNA
	 80E3gueX5fLZt8IKxNOkssxzkt7CLdlZu5yXJ3wuYicv3MH4KlwyQX63fn2lySYQBq
	 uWgs0oJrW+vQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2665781201;
	Fri, 23 Oct 2026 11:16:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5E5CB02
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BD3E60675
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2htO6vxdSWDV for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 764B460666
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792754167;
 b=BbzzZDzumV8riKgu+2PG/ibpqR6tQl5AiQr/V/+S8OMqoZHyiLbmvjMVFkA7Asx0stPm
 YgzZ3HJ1gNRGKELVvy1RdUtL0Fw4jGLOlRoMsP13avs5auZxOIOSbc4Z6STklQVaNLMX8
 lBufvQeycrV946oe+llQV+OpZ1Ftg7xjPoNOIFjJWKUCJHny/MVOKpKZ9lfFKY5gNb96N
 vttcJmUKoYJwE0Jei12mXT8y6yydnTm+Se9ZtIePMInnIGnRrUTbtHblpQM/0OVYA6Eg0
 Cmk7d0TT2QdKnv7+WW9QdkDpuW1mPKJ61N9JUelqqzDzfeljrUn/BUTEYEmFFRXCZFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792754167;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=/wuxQvYn6re14lkIuIK+4pWUz1i5LIz5NOq5VLoewc8=;
 b=Gq0o1otK7AskDAskCO4rMyT9OWrqzKkt6ikffS7SI8YDJmiiU5+N2gXUtSbsmsbozH4N
 m4h3zdRpDseodscFOmGTQtSC8zqS6TD/0KF+SHzwt+NnLEAU99sZQR1oma3nY2sx+gyQL
 gPAPHsaQ6I1n0Jh7Mit88drT7p5D5BYpwxEJXNrSHVa7o/5iJYnCqDyH+0NuUtAjUmlvy
 v7A9RuNSrPDRxsi7+iWafw93tBHfUePQQiXtfi6nO/JcHPgcRCQ6iPAo1+tFsFO66rsxE
 +niI8MLbztVnJUoOI7+7Yda9RnutuRgXvWV6BvxKu9rRcuGF9piDbJgKq70ngSaW+SA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Ubfl/+vr"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ubfl/+vr
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 764B460666
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:06 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e04773687so267542f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792754164; x=1793358964;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/wuxQvYn6re14lkIuIK+4pWUz1i5LIz5NOq5VLoewc8=;
 b=Ubfl/+vrxuwcXvo1VO7sW1B2KvD283ng7JVs1QWb8wLJyYxRt6QgUXbvBhptxAtTAb
 CRnawKUc9H+jBrAo0Yf6KvFKjFOiM0Q4MEXS/00zOG8RMgNx2y/9GMaNqkoIuN0Q/Xax
 bDyKEX489mi7CAMToHOdCRNpJ/wtv4fQAjiRk1PH+QL2jaHjiLiIZXLZC9FDM2abO83T
 cxldCdRjBVZkNGNlpk1quVbRYAi/u4z4DMPqBVqt07XOYAGRE90T6tyMnRTlf8Ukxb0S
 uQYkACrYaYuiu1l6H0x6U7YchJSpdxfsN3ENIR7euRbZfXaTZPIAf95Mgjgc0C5xAX2g
 u7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792754164; x=1793358964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/wuxQvYn6re14lkIuIK+4pWUz1i5LIz5NOq5VLoewc8=;
 b=g+Eh9oBa2e1WjNPDqm2I+mZsbCwpaO5uelgwlhleEyt28HbbDpEF9kdTQFlEV0C7rL
 0iTT31On0UJYVbFAPsX2IW5LU/XTOxWrcKn8/aoo+aFsVk9DkLN3Ulgv4jmsEaw79a1R
 3QrZ4Sdt5ro93eglADbDuc7oA3ga+z3xEmx1nwYRSJu69vcS22IWmGz0pEWUMobpJ3ye
 peeiV22CorKvzzkkgTF37qIE6lm6/VNnvcsgKNpnHeWpKjepTUWMIeIDgGucc1kW22n1
 RXZMFIr6W2wEhxoELgi9EWVDjN0hpmD71zBYBrYCYXjJK5TuwUBcjvcWl05ulGBUwsne
 qpeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0vTuRQryGKxL0CGUeIBm2VE8gMIPvC03lo6kSMmRtzNxFHwLFe7LM4HlIJ1+EOleb/65uY+8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYILleTHpnlXKT5gsejlLZ0oiiCOJT+0PhtEvSttIv93TpeQjX82
 PdMstFjRtLe9cf8OPkX3LGXzd9QLuUKw+qXUPWz2vLUWvZ3BdLIY0rMI
X-Gm-Gg: AYBFou3GqGySDSx988u+d3XItwnOINZ0lQuz3D+wPNCFxru8O/tK3yP0BhJQ7TgMhTd
 UnVjArQ44VtNYWU03UWu1Y0faIylJqncRwDDxcR6QVASkfoK0zRBbzhIkVgPwTM0oNbRw1Nz1ux
 zA3oH3lIkfDugpAXy+35KIXrWeKEgHMtIIYkZ+xXfC1qkFH5+/g9E+TZqvNtijwoeQ0OD7Cv5ap
 Ln0+BIeaLoPW3kZy9P0mTSVGU+oR5bR3YPgGjSDTQUbp+2GBRnPu8oDg5EleFnI3uIci0RDmeWC
 SMWNLtJeYLvv+9PqpcomyPmTyNVPlywzhRc209pbCRqjSt6P+pbrOC3pEEZL5l+nq7H/LYA+xm5
 NkdEyoedX9BnN52yoVxup9xhde2CrpR4EBjFOnB6RsTLfdTS+/i4HzVgo4ANnQ9aBMUYFi5dSva
 UJK+zBmhjvbNXjV/kqK08NJs2DImSSildEI0F3HxryxI029Nk9unx9oRzKM5fGsT4ZooCVl2dAX
 co/Dk7QG1fokf+bAcLaHHp7CqHddUuLSMrbNs4oV4MP8n6H6YGm/fZpAqYl2g==
X-Received: by 2002:a05:6000:4552:b0:48c:6955:a603 with SMTP id
 ffacd0b85a97d-48e385ac49bmr1920802f8f.13.1792754163889; 
 Fri, 23 Oct 2026 04:16:03 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edcf9csm4596141f8f.4.2026.10.23.04.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 04:16:03 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v9 2/9] usb: ehci-vf: take the controller index from the
 device tree
Date: Fri, 23 Oct 2026 13:15:52 +0200
Message-ID: <20261023111559.4081795-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023111559.4081795-1-mehmet.fide@gmail.com>
References: <20261023111559.4081795-1-mehmet.fide@gmail.com>
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

"usb start" on a Colibri VF50 or VF61 ends in a data abort and a
watchdog reset.

vf_usb_of_to_plat() takes the controller index from dev_seq(), but the
usbphy0 and usbphy1 aliases count as "usb" aliases when the uclass
numbers its devices, so the two controllers get 2 and 3 and index past
the two entries of phy_bases[] and nc_reg_bases[]. usb_oc_config() then
writes through an address read from beyond the table.

Follow the fsl,usbphy phandle, as ehci-mx6 does, and map the PHY node to
the index of the table instead of trusting the sequence number.

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v9:
    - none, rebased on main
    
    Changes in v8:
    - none, rebased on main
    
    Changes in v7:
    - the Reviewed-by moved above the Signed-off-by
    
    Changes in v6:
    - Reviewed-by from Marek and Simon
    
    Changes in v5:
    - none
    
    Changes in v4:
    - sent alone before, now patch 1 of the series
    - reworded the commit message, no code change
    - the test note moved here: on a Colibri VF50 V1.2A on an Iris carrier,
      "usb start" brings up the controller instead of resetting the board

 drivers/usb/host/ehci-vf.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 96d1363a76e..32fe05920d0 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -221,8 +221,23 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 	const void *dt_blob = gd->fdt_blob;
 	int node = dev_of_offset(dev);
 	const char *mode;
+	fdt_addr_t phy_addr;
+	ofnode phy_node;
+	int i;
 
-	priv->portnr = dev_seq(dev);
+	phy_node = ofnode_parse_phandle(dev_ofnode(dev), "fsl,usbphy", 0);
+	if (!ofnode_valid(phy_node))
+		return -EINVAL;
+
+	phy_addr = ofnode_get_addr(phy_node);
+	for (i = 0; i < ARRAY_SIZE(phy_bases); i++) {
+		if (phy_addr == phy_bases[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(phy_bases))
+		return -EINVAL;
+
+	priv->portnr = i;
 
 	priv->ehci = dev_read_addr_ptr(dev);
 	mode = fdt_getprop(dt_blob, node, "dr_mode", NULL);
-- 
2.55.0

