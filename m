Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA73C88E6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 09:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F02314061A;
	Mon, 14 Sep 2026 09:16:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uiy6s_EpIIJg; Mon, 14 Sep 2026 09:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 47D6D4061F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789377402;
	b=szPSVMy3RyfQf1BJB6yKAPeoOj0vNPCjZFVBv9n8PeuQH2hzr+rpSFon5Pir1Divag57
	 PMzPC2H09EevGJcuQS+5tiD6mNAuAAYn/17BPcc7XhxN+I+UNJqgnx9BZT69zjZ6UWNqN
	 LywBoKSSyu5pU19aj5XZslqmwXE33L8qZdbXUMq8Zs5RANG89EO/CtnJCY8FtUsq1tGcV
	 CyZdDIj5cm4tQ1fB9Ba3ZjWekNWanCUoBYgOW9vuCuZ3pqW7rucEnpVA0hNYn2nYev87Z
	 BMq2d08ibRtYq/0MdBERcYlL5i5O+opElmamOQhBPGUgo6n0EON91irU6VbsOMGFkPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789377402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=h3HqiKXMIVJJ00q+1rNymeM0lmw2QDa2lKUEj8uD/Ic=;
	b=W70feNmlC6pA4yFOGxSDr9wXo1osy2vnFF/edebRAO/qRbQC/qSNSDeE+W6VtFHIZDZP
	 ljaz8ym8Fd23ZD+vT6jgQngTPB7quqLH9io6jJIT4Ljx7a7AiPuSQhcKpPqBKngpalEj6
	 SCoVH7tDjnlPh7q6WIKRLLXv95AiiQc4AJ+dy/Yjhs0OrwKAvdcuEnZDR2f5oJ6wDSwBV
	 p0BcDuzX4izQSDZLvGhmQF+kegsPP+9DG2JT8Lo5BiqEeynaXEYwRcjfMy5L7XldyvMfL
	 q/BoM1PaGLOqnX72HybVwnby0EFAT5DC0NihGQ03w8gr/Jcd4kE5WvuHs+8uzByCjfQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789377402;
	bh=h3HqiKXMIVJJ00q+1rNymeM0lmw2QDa2lKUEj8uD/Ic=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qyA6+u2FGIkZMGsJM2lU59qOXXRYZlJ/VKhqjAp/cL4bY1nhUs1EWY1W7dtqziGQ6
	 gBJQ81icYEv99CprHFxodd48K/MKSopYRdDevn12Wh5BevvUpJffZpY4KU/SftH5ut
	 caiKkC3ptipnqeDCRFPGQhPRkubysCb1Z4SrsGpkYGJxnDbPnJi/HphJ7ElKQLUiML
	 IqYZERu3uT+WwB6ted1TjZ37fPV69QwCoGYyamC23fnVKWF1GowbPbFO/H/iywDgFp
	 55rXF2rgwc3XqEEqg3cxNta3XpH1ItuPLEZxTeWh9ESYX19zpyu1tiyXbneFnoetaY
	 9Z5zUfHt+rxVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47D6D4061F;
	Mon, 14 Sep 2026 09:16:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9BD22D0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 09:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD77760684
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 09:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BkfHAbSEUyFx for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 09:16:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0AA72605FF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789377400;
 b=qubyMRkhcGFhY/jq1zKTj/OLAGvPR//cncImojGyIJ2MabSpea/Winib5f7NEoDDo4kj
 JIf5CGEcT0Wz1rZlTOaYOjydHM8nYoFV2aZLotNnSW21G+cecVDZuGG/wIoUN2QAxCwsz
 nSRHk7izmBlESKQakD4d+jZrWS5VMqn3koGuql2Fl0WJ0ujiv5ykWpgLvn7iaOvY6m8Gj
 iAMhl6IYyxnpe13Y09uhIBVfxVsgVEULrPHJPTvRqjxvCKzzt57gDhH7LmXyzlpPa/ZfQ
 n7LlNs7vMvERY3aR9PUXwSh6oZaKtognmoQGm9wUox+yFh+3nCJ3u01Al5z3+NpRnrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789377400;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=h3HqiKXMIVJJ00q+1rNymeM0lmw2QDa2lKUEj8uD/Ic=;
 b=JIBx9FW4IE14Wbtm/ydshVfmOGzfSbM55ncKrFEaxn7OlVD1ORZPJ+i7HpxAx2avwWIy
 zestgTtaI16FLVYwYTesQt0mPjLkgIT+7okW8mUQsT1b9JrcAn9LSDffUkSBYrboEDxHc
 plvZzVv8U1iIE/vCU2SDnfVKRubMmBZCBReNz32ABAYFVlRlR9NMibdoqXZVjabigskwE
 3slDkMPEEL5DAV44Wi26bvrLDVP0QQrUEmlf7cAoxT9ttQfgkAZ2Ehbx5h0ls/1N+Xv8d
 odpbCMpYnvzjz1TQiJatQ12FD2QHHIwpM8kOzttezD2R187ksQRJ1DKFZ/0df5NobLA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PxgqESLr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PxgqESLr
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AA72605FF
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 09:16:39 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so1288717a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 02:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789377399; x=1789982199;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h3HqiKXMIVJJ00q+1rNymeM0lmw2QDa2lKUEj8uD/Ic=;
 b=PxgqESLrs/4p8LEmj+zG2Sg7BpMuccujBEwcGjEQ5bPhuy1XJ8ISYWSgIrrOl2VIYr
 vH5YALcS7PgTe5sLdsX6P103fFZSJFs2V83Z/AyE3PWz1H+GW4dQcS7gnYgb/VhILh95
 XHaqUJu8fUByu5FHG7+ckIc8cnu6MElQEkGxJSRuCcN141tRGqHdLoUer0z+XdnPX9zn
 daKPc60OTYTMozyGOkamxnQpWsSrMs47hlpwfxOzxpJ7NdYvttG6F4nyipV9Facw5zoz
 NmYiUTanLbRBTjvF2kNFXaYeGdHEMh2gcYSRyyjAIwJVwOgrfl2U32cmDeDcyTkg+Baa
 ahIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377399; x=1789982199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h3HqiKXMIVJJ00q+1rNymeM0lmw2QDa2lKUEj8uD/Ic=;
 b=lzCVtpgVtMnrO93+PG47JF/2pdbeSSU/TldpZofNG+J/TIf2i2OBnB0yFt/dhefe/P
 F0XtOXistKVKpg19O3P30q7fy2PtpYexwQDpckr5JVRdIFPFo1mXADoBXp05sHzMWQJN
 Dy4aBlU3f4526za7/lhBnWmLWZX4oyRp2KsCKehLtCMmilE8hue5oyMlRhbIjKbVCQh8
 EIrYcR2/xQ5RpGKypxzS10zuJNxOdH9HMTeFptdvuWfQZB7X8BYrTpfecyQmAarxvarq
 dB/Jp3F1nd/hT9HsNG2gd1IqQR46uvwq0zLBmV3EwdFDHTgJMLFHk5Q8VspBtr2VFAKC
 IGdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBys9iWPCwnouWxpGv6n+1JsBhnTBwgFkuEqZ/IOuXvAZzgPfOvP/ykH2pY8YohN/S7s5DYZVXY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ktRe36hN9uC3DXwOtFLp+0PeVsYXECddO2aYtZJh9TiK3220H0
 246rNsKWV2MPxw7thQjzxXQw+AeNIllwvRuCwEJtnL8MOcT5nHDP6j60
X-Gm-Gg: AYBFou3ef+iWxPIWw1vBEgFbGrM1V81JMX6kzb9hHJK8l7ZFEieaiJ4Ec7qEDBG7JBj
 2g7mXHcwz07da178S9kUIGO2yv43zDLNdbwlGaaCMZ7ddityh5s8ZLjewIr89DxHi7oqRysCmMx
 qlWml/0i0JIjoLD/qVaHKBDaGUolrDaTUxf/5aQTSk4DmahFyCsewACBdnjHV55R8tOZ5i8NWqV
 b8wfq9LHjMND94FVjZ7qA0uxQ5vxtCLVvwTl/vNu3WCdr5Jjuhvc4fd+RSF9/8NBQaj7dxLXv+0
 4+VbX4/mWoDw2LkUqCiXx+J0eGzmyLUy0QsTVsrUlHY6wDwAqvGvq7krtx8s3p0HHoP1SkRaLt/
 pThaFkrsOy0XSPrg7TFLMjY9f9pXhq7nVyLDD+VyJfmWA1jXzB9UsIOEdUvGxp0IAI9BIc8Tnfs
 APpWB7qeWXxSQSDcq2x0adA4HyP3Nd4yhu7dRejbIsGbQsM6jCylxW7X3/BeiImUVADOVZs0E4v
 XuVZaD2
X-Received: by 2002:a17:90b:2803:b0:39d:f253:5fc4 with SMTP id
 98e67ed59e1d1-39df253b354mr1507511a91.17.1789377398806; 
 Mon, 14 Sep 2026 02:16:38 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:139d:9738:fc3e:7a6f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95424fccsm19613387a91.10.2026.09.14.02.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:16:37 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	trini@konsulko.com,
	jerome.forissier@arm.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH] net: designware: Disable SGMII auto negotiation on NPCM845
Date: Mon, 14 Sep 2026 17:16:13 +0800
Message-Id: <20260914091613.1194020-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Stanley Chu <yschu@nuvoton.com>

Disable SGMII auto negotiation to avoid link-up timeout on NPCM845.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/net/designware.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 6ed9c6d538a..5ff84c13bf9 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -498,16 +498,33 @@ static int dw_adjust_link(struct dw_eth_dev *priv, struct eth_mac_regs *mac_p,
 	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
 		ulong start;
 
-		/* Indirect access to VR_MII_MMD registers */
-		writew((VR_MII_MMD >> 9), PCS_BA + PCS_IND_AC);
-		/* Set PCS_Mode to SGMII */
-		clrsetbits_le16(PCS_BA + VR_MII_MMD_AN_CTRL, BIT(1), BIT(2));
-		/* Set Auto Speed Mode Change */
-		setbits_le16(PCS_BA + VR_MII_MMD_CTRL1, BIT(9));
 		/* Indirect access to SR_MII_MMD registers */
 		writew((SR_MII_MMD >> 9), PCS_BA + PCS_IND_AC);
-		/* Restart Auto-Negotiation */
-		setbits_le16(PCS_BA + SR_MII_MMD_CTRL, BIT(9) | BIT(12));
+		/* Disable SGMII PCS Auto-Negotiation */
+		clrbits_le16(PCS_BA + SR_MII_MMD_CTRL, BIT(12));
+
+		switch (phydev->speed) {
+		    case SPEED_1000:
+			/* SR_MII_CTRL.SS6=1 */
+			setbits_le16(PCS_BA, BIT(6));
+			/* SR_MII_CTRL.SS13=0 */
+			clrbits_le16(PCS_BA, BIT(13));
+			break;
+		    case SPEED_100:
+			/* SR_MII_CTRL.SS6=0 */
+			clrbits_le16(PCS_BA, BIT(6));
+			/* SR_MII_CTRL.SS13=1 */
+			setbits_le16(PCS_BA, BIT(13));
+			break;
+		    case SPEED_10:
+			/* SR_MII_CTRL.SS6=0 */
+			clrbits_le16(PCS_BA, BIT(6));
+			/* SR_MII_CTRL.SS13=0 */
+			clrbits_le16(PCS_BA, BIT(13));
+			break;
+		    default:
+			break;
+		}
 
 		printf("SGMII PHY Wait for link up \n");
 		/* SGMII PHY Wait for link up */
-- 
2.34.1

