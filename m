Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD107606A32D
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NQY7t7LG;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ezBkqqkp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84222406E5;
	Mon, 23 Nov 2026 18:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v7mcZUZSAOBc; Mon, 23 Nov 2026 18:19:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C80124071C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795457954;
	b=h//cjBIgImoEUY/dLtT1SBbItap18XXUMddswLsoKh9NE9WCd0oWfFlnSubtf+6Qv1ZW
	 w/W54eGEMbueI/QqYyq8lqfwLULdPEc/1h+t/W9HRj9CeYKjA3DliiuE3ao6Pe6r27iCq
	 7Nq0olozpoZWRLYVcffj8+h32SF/PCHTSfP+pi5DqoMOrUBd3SIzKn3vGR7W+Mf+ceMdw
	 MXVtROvqfQGryU/5+pR94GL8Et7uuXuQdWA7LmplWG4p7cylw7KSdslDwjZK+fkfxt9Pi
	 UANsWT+4/4DZj7H2R54gv3Qn7pC2H/MgYAo/NFJQkVO+qkmQh4SlrIrQifzTiAH0bwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795457954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yxPwlWc+5gGWdABYsVepW0CLObmyZJo4iIs004BJFHU=;
	b=Ilt0VOxs+XcZ0ppCfEIRXrzLgyIISnFp6Q3U6Y/2tNxX67uUR9Wr/QAXlf9x2nyLOqOG
	 8NU9ln/gylvCnegfDcYNRk52w2zSr89baS89qPKJ6IDlkGVaXle8Q3cgBHdfEh6n5HUzp
	 3n2rdD6b9lU51ey/LrZD81xbSl43GLnuutz0FCuewQ+fh2FJcOtwmrvaSGsnC8e+mHcD3
	 0SLvYfZgSeTzw+8hvF+5HQ54Eb0o++M7//Yx/o9Yc9tTabol0MhteupSaAb3Ty2CcyiqZ
	 3Z70LGd/PQwiw2qf9NCNSTYDOVgPyXgObH/xCpii03ulxpgrjg8OwnsL+1EnfwYapDg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795457953;
	bh=yxPwlWc+5gGWdABYsVepW0CLObmyZJo4iIs004BJFHU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NQY7t7LG0DzJpjVJQoR3Xx3uk6QWa8/RyqudEKhbVpA7Vxq6VEnfonpHeUWbPoUOI
	 ZCfSzVCh8kA0V+X1QuMQ+cOIfdw2t1+rXZ2woPaTATTOwGmcwEkWBzkZFN5dp+vNk1
	 YzzOmV6WL4OG4SBNXZhGdMshblnAE9jd/ZortOjJw/yWw5urM9Gxn4/oUsSpVoy0z8
	 i+x4jqlkch/danwMz6nek0TCkHPhBLMcT+g7jN+NSju4ToRIWeNyPzuLTPzb/fpc9T
	 zwTqiDS4RBzY3DiWepYz+5e1mc4ZoeI7pxIHeEocZRN79Z3zvNSrh06tnFPYn8r93K
	 +HvM9RqHMBK2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C80124071C;
	Mon, 23 Nov 2026 18:19:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 45BDF3A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38116605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FWph6dUgdCFz for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:19:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 292D4605EC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=ezBkqqkp
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 292D4605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:19:10 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jYDjR56pjz8sxs;
 Mon, 23 Nov 2026 19:19:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795457947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yxPwlWc+5gGWdABYsVepW0CLObmyZJo4iIs004BJFHU=;
 b=ezBkqqkpeaDCAfcuY0wVrClW9SCFH7bbMke7p5K6F6IbYHoZDOUasHd1dEWh7Q/bMHnZhx
 KzpZ+ivlWTCxgTfvGw+1zdUHV/AiNcpXHb0KAySqQ5FcFvDxG/zE7r0cDe+aSaY/UBUOQz
 1fe2eBuXwcc5mlR3ClAqMZiheK5lo/cy2RQpixmbG3J0Zi7jJEeeygXxDPak3XRIhaiRKM
 UajNCXZq7q0oGYoxLx1hE2LnQturADByRFvR/0T+cUw6YVGAdRSFm+lEJwTloIJXwP8UaZ
 hSYvnA107r8YMduR9EkGfZF3L9y0DBYYsApLdTVu8gixsTV4rerFYPkPthc9ng==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] power: domain: renesas-r8a78000: Add SDK SCP 4.40 map
Date: Mon, 23 Nov 2026 19:18:58 +0100
Message-ID: <20261123181906.168871-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b7528db50bfeb387bc2
X-MBO-RS-META: pm9t9ybpx6ho867u1gw96ftxu9sywdij
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SCMI IDs did not change between SDK SCP 4.32 and SDK SCP 4.40.
Add SDK SCP 4.40 as supported version and reuse SDK SCP 4.32 remap
table.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/power/domain/renesas-r8a78000-power-domain.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/domain/renesas-r8a78000-power-domain.c b/drivers/power/domain/renesas-r8a78000-power-domain.c
index fa22a37f77f..d0e066ee5ad 100644
--- a/drivers/power/domain/renesas-r8a78000-power-domain.c
+++ b/drivers/power/domain/renesas-r8a78000-power-domain.c
@@ -169,6 +169,7 @@ struct rst_map_in {
 #define GEN5_SCMI_SDK_4_36		0x01100000
 #define GEN5_SCMI_SDK_4_37		0x01120000
 #define GEN5_SCMI_SDK_4_39		0x01140000
+#define GEN5_SCMI_SDK_4_40		0x01150000
 
 static const struct rst_map_in gen5_rst_map_dt_sdk_4_28[] = {
 	{ SCP_RESET_DOMAIN_ID_UFS0, 202 },
@@ -226,7 +227,8 @@ static int gen5_reset_of_xlate(struct reset_ctl *reset_ctl,
 		   priv->basever == GEN5_SCMI_SDK_4_32 ||
 		   priv->basever == GEN5_SCMI_SDK_4_36 ||
 		   priv->basever == GEN5_SCMI_SDK_4_37 ||
-		   priv->basever == GEN5_SCMI_SDK_4_39) {
+		   priv->basever == GEN5_SCMI_SDK_4_39 ||
+		   priv->basever == GEN5_SCMI_SDK_4_40) {
 		map = gen5_rst_map_dt_sdk_4_31;
 		map_size = ARRAY_SIZE(gen5_rst_map_dt_sdk_4_31);
 	} else {
-- 
2.53.0

