Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165C5606D811
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L7l9J18B;
	dkim=pass (2048-bit key, unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=iPsAI58H
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D380E80F95;
	Fri,  6 Nov 2026 13:20:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lING92vbRa7A; Fri,  6 Nov 2026 13:20:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2827180F58
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793971246;
	b=jbSAN0jbuSo6o4KvByk+OQYHJTk7dPCUbjMOoW+YgkT2IeBYbs1r7QvX4wb9FpDYvfof
	 5PsTCbB86S9Jc777NQ42kYFbwjm2NdbVfKFqSdA4Kf+Pns6qNUwSfDcIBMewRDx9+Uwvd
	 mWkUwncN3DbDSXn29LVw49FCx/TrT+uDeXvz29qh/IFyxAyLgIuV7R7vy1mKaJh7CeFtY
	 uXc519TAnX5V7gx66/wRYYiCrAsGhLU7qy/OGZOzkTC+z0JhTxEQi5EiWZT7bd4MdNjNG
	 vJAy9wIfopzyw0Ywx/bRdmsBowh7s8ZHebpUExayQSWRd/OOzjvs16ON5GBmNKYX7lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793971246;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2gpHYyOL3kCZEtEsgpSM9aUt/4RQIAmRdzdASqP6FhA=;
	b=f9l6TVCiJzFvZo9qUi4WlJAZLRhSt1lXp+bMvhajvRpQ/88bP3VOiCjXvyCmJGJfsAAC
	 cJmIi0qT1cuISCHEL+wBzFsjs2k63HDSATaZ4rAPrFlNAGpS3LofOsJZpHCAiKfvNCjJo
	 FPdJLZ5QxztYjWqi/9+uBqySetAUJU7BhiLwyXWpxiW7EvqtOVC9qfqPt8wv04FBTOov+
	 JCPX71M2tTWajN34AbsJQl8tynTd+qoR2H34z9/HmfIw9NLnNVy6iGSD2sKC8k91/ekRa
	 9Vs9KxaUzYqUUD1QcviWiO/V6SJtTHxS1xMMTr2qqn+8GMrmZZ2sxT85+t28XIkqoLA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793971246;
	bh=2gpHYyOL3kCZEtEsgpSM9aUt/4RQIAmRdzdASqP6FhA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L7l9J18BMTV67TnyOK3s6C7iCRX2H82K9PDIFzFhkGG1G1d2GaeW+D544hHJ4tJcS
	 eg2jWFsNxJyN0Crk41d9BeGl6F1ZbGsS4ozCJqxsNOyFTTAEKguM4r5Z6jjMtRsqg5
	 vLBs8n5g6vxWWXXfktcktkZ1ftlQ0jTBEUN8kdNC79INnlc4ld9Ae/u9MOEbjYFe02
	 AhOZJHv8mJ1v6wJOXIB2jf/OGdZXpwWT64xzmW/AKczXKq1DYy1cJAZXzyDIjeMrv/
	 Suqohnbt9DM7Xu/1MQY5HisgRl3aT6ys1gvwtYHXCEYFTmKc7oIdbN5W9Enfkvu0UG
	 HGfeb8H0OlZWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2827180F58;
	Fri,  6 Nov 2026 13:20:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DADA31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:20:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43F9B607C3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:20:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xEjj4C5wCEez for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 13:20:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 427326085B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=robert.marko@sartura.hr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256
 header.s=sartura header.b=iPsAI58H
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 427326085B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:20:43 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so6716185e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 05:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1793971242; x=1794576042;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2gpHYyOL3kCZEtEsgpSM9aUt/4RQIAmRdzdASqP6FhA=;
 b=iPsAI58HVwsr3Q/gcqXqKtDosL0+MJQEF1xb1OwFBCKSiDtJ36ojrmdPCB4or/2o1m
 FE8Jtat0ocRiL4VdK4NN7PBVBdpttFGSCOV7SYVgZu1Nta1wuyVe0fd/FFhEgLkIvdG1
 AKbKQv7qW/mbB/FzySe8+gEO94IYNoISjzyWlFxD8JGdleCJB4Z9CJ1ZJOJ7XID58WGR
 WfUSmOmWPMKH+mVZH8pa5OloOvGJMh3nnJASEj/orh7mJ3oltLFksWIqW776MFWaxqI6
 UNO1dzMUYLSeByf2LidgDA+1vRJjXQbQUOQAWg+jNEpdh+PUMZYJsRGzf5xm896I+da2
 JsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793971242; x=1794576042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2gpHYyOL3kCZEtEsgpSM9aUt/4RQIAmRdzdASqP6FhA=;
 b=zGRYRQju8auIniHnilsNcOHwTV463YsvYm1ti7lYOIe77EPS1nrIFF6CavO/HNokR/
 mzMfxjagvQ9sI+y17IPDE//HD8QJTZoWgxyeYB6f6TH/AUB7XdZD1IhgEVVMPdhB75m4
 NVkmkaYVOqcktzwahOPwhjVWoV2kqil0cXDYHXI8h3F6WTM7JA2Auom3fc+EWe4PL/ia
 KqOoqrDgklQBW1x5Jh2Mh/8dfu/M8l7zkVuGIQrJVBI/EzQGUveeBBAQogGURidX7Jq2
 z4YUld55J8I8XpwSBNCsutro3Y+9JEvJ9PZBGIC/ayBJudKyE7fEGG5HWkD4/WJlFlaU
 pHkw==
X-Forwarded-Encrypted: i=1;
 AKwUvByY+1Hroqx5a/pNuYuhdHerqLv/oJE2sm0OHEygGAtVLTeWc6T2fIVYy7g5l4q47avF73rDJvo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9tyVFisUvgzUTDtSVG0AMB4OF/YHt7M/Mbqyuobsr9G1AiAN7c
 ijfHj6Irj65heBqAV5p4608ccOEb6/TPx7CU7YjEgFiw2wAsF5f1kvxo8Okz6Nkz2zw=
X-Gm-Gg: AYBFou3+NC141yaiM5/lmx5ttTMzSEOANTVK53I13URzrsnycaI1HYm6NxfhwVhxjHA
 2VwLaNFtHVZyMMQ9c3VSR/EbW9Lp+uSS2374DqIhDoM7l2JUdOMCze80O0+OWO2SqwYjHZNjX68
 V3OMjsnmxzQyJ1SygD2rfUJ8T5pLLr0QdzPPoo6oxS2BO0wULFiPCpTVSPtuu61H6hVMjVTQHaq
 FSGvsAvjPJQiozPq/0QGL5ZjOT9xoj+ihk39ptPczTdbsU+Emf4cC/YEI4nY8b0g/PTLJ52j1vM
 UFONp25RfN6ps9oeFdkFkSyu+6X2ccPQ+VNR2qzRTI0gdaJfmPWuojrcgXUolcfkSSXUdk8k+xR
 LtvMVKYLUxcnxGXZ3l36Hgr9bJefnvav4OzOqjnpRHN8EaqXb80h8x9wrZmyfiZN4nzGoS2xqKG
 rbXO11g7is7K6U2+IwJ65WaPnG4QNCsWVXMMJWBj92aO+nj8zV9E8C4dEGRz+PVsJDO0J9THUhT
 dVqDQwIpXm13nKSCqz7wXqurjEHlseD1/E5MyPGgxWj9rPdAj4+borO8oNYreakEwZ0CE8kPBYR
 cyz+5LVxLOICkKzSFnPRJBWGf37UkmSr565tEKnFA+T9Rx/Gv+wVpzAAK/2sun6fP9e+Fk1qFVg
 jU4snJl/BZ/e6XlwC8nJPHGKdKnBCFK2u+0ZDB/VMF4TiPVK+S/CYrOu+kI6NEGqRegzy06K3kz
 zSDHQ=
X-Received: by 2002:a05:600c:64c5:b0:4a7:4697:dae3 with SMTP id
 5b1f17b1804b1-4b6dfca2330mr45186455e9.24.1793971241857; 
 Fri, 06 Nov 2026 05:20:41 -0800 (PST)
Received: from threadripper-fedora-workstation
 (cpe-109-60-83-229.zg3.cable.xnet.hr. [109.60.83.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b73ee651b7sm26664115e9.0.2026.11.06.05.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:20:41 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: hs@nabladev.com, ehristev@kernel.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] i2c: at91: Probe with an SMBus quick command
Date: Fri,  6 Nov 2026 14:20:17 +0100
Message-ID: <20261106132031.966174-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Zero-length transfers currently return success without accessing the
bus. This makes every address appear present to i2c probe.

Issue the controller's SMBus quick command and wait for completion so
NACKs are reported to callers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/i2c/at91_i2c.c | 9 ++++++---
 drivers/i2c/at91_i2c.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/at91_i2c.c b/drivers/i2c/at91_i2c.c
index cfae36c74d1..7a9e9c4d4e9 100644
--- a/drivers/i2c/at91_i2c.c
+++ b/drivers/i2c/at91_i2c.c
@@ -50,9 +50,12 @@ static int at91_i2c_xfer_msg(struct at91_i2c_bus *bus, struct i2c_msg *msg)
 	u32 i;
 	int ret = 0;
 
-	/* if there is no message to send/receive, just exit quietly */
-	if (msg->len == 0)
-		return ret;
+	/* An address-only transfer must still check for an ACK. */
+	if (msg->len == 0) {
+		readl(&reg->sr);
+		writel(TWI_CR_QUICK, &reg->cr);
+		return at91_wait_for_xfer(bus, TWI_SR_TXCOMP);
+	}
 
 	readl(&reg->sr);
 	if (is_read) {
diff --git a/drivers/i2c/at91_i2c.h b/drivers/i2c/at91_i2c.h
index 3915af83723..4b467c441aa 100644
--- a/drivers/i2c/at91_i2c.h
+++ b/drivers/i2c/at91_i2c.h
@@ -6,6 +6,7 @@
 #define	TWI_CR_MSEN		BIT(2)	/* Master Transfer Enable */
 #define	TWI_CR_STOP		BIT(1)	/* Send a Stop Condition */
 #define	TWI_CR_SVDIS		BIT(5)	/* Slave Transfer Disable */
+#define	TWI_CR_QUICK		BIT(6)	/* SMBus quick command */
 #define	TWI_CR_SWRST		BIT(7)	/* Software Reset */
 #define	TWI_CR_ACMEN		BIT(16) /* Alternative Command Mode Enable */
 #define	TWI_CR_ACMDIS		BIT(17) /* Alternative Command Mode Disable */
-- 
2.56.0

