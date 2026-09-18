Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FD5C88E75
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A2EF60BFC;
	Fri, 18 Sep 2026 06:36:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYBOxWm5xx8E; Fri, 18 Sep 2026 06:36:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5B1E760BFD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713374;
	b=hcDL59qIjlod6tUzCXdYj0VX9hQNawGdGgre5JMvbhW+bV5dm0M22fLFIRw1T4WGibJi
	 1Gccyi6118xhnwOaPyUByP4OYYyy8od+Jux5+46XDAVJR8AmRwvynvNrF4ZB8eVpLio1R
	 1qEGom1IFf4SXC4ChnpuYon3XfSb5srXY26Mi4c1iMolj6vMk7BDqMJSjV/PA9VXKNHcc
	 9G2i0vdrQnYPJSxnWfJrJKGdf98iewvoFbje3TX0BL5tpWia/O7MkrI48TLbBRAnAIx2d
	 VRHy/A0865MF7ytMUyPYoD1XIoYPaY9IG7QG4tNGVpVH3fRKnaKFZtUSsWo0P3k79xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713374;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JFS0IrYhZFFNhtbdrLM8h23//ixpGVDOvazr8gdcXT8=;
	b=hlpClPjWUlZkYb/WkgzBw6PDlbt4xezE8gwpyMAZvSfoE7WBnqjhAAdwSCoCQnSs5sjL
	 DPpNPg6YaV8YCBMdsvLcfDIcu+ynFT+lPrLIV5csZNFgNJJS746cEmdUBNdQO9mU49Hxv
	 t8pPutaXzr1zg7j6nJ9HgBStq3hVpsktYqZa09TucE39ZClFHw/f2V/8fTOkJrvv6gbUz
	 IMgFuWBGqYGiaiSWaAjW4DdEgEafYPEJ8vl+/ZrfjFCd6cg2yWMQz5U8JMSLT8OuGFm2i
	 WY4PlKUbwk/MW9v6xtFoOgQtfFkCJmZ1jF/PgTzN2yOOxP1IndC3Xzq4fjy2YVBIrUw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713374;
	bh=JFS0IrYhZFFNhtbdrLM8h23//ixpGVDOvazr8gdcXT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nrb1Jea7Z+yxaFoa4jovJUc16Ws3mw7lrKz8X5D0Vo011gwPaI0taNUGNXBSzvTul
	 iUhBD7pINe59M4Kp3NCd7NGGPKrmbXGhWRi4OrjpFxekUvor6gdVzQLRj0AmSWIfNr
	 k6X3KkZGIWg8LlDbIVdaJjDI+phhDcJNswQjqVcQNR0REnvbvBi+9u7VVYUCZiAgvH
	 zEcytwRE077KwbYEF7vDjJLtzxx1RkoK10AZ1XrLtjoamgZZALWfwnDePVvU/nWdBi
	 Pai7Q2hIvAupteFHDicAoHj7zBSQKokiq6/DEbJIhwKSZZz3QuRnLQudNSBd6DqYpx
	 kKGBmV7M7A0lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B1E760BFD;
	Fri, 18 Sep 2026 06:36:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 45D7E29B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C03040AF8
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pYjjU57lhVPc for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:36:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 24AB840AED
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713372;
 b=R/sfrybSC3GeT56mYTSWxmhpRQz0QZ6SnSovLrEakzwRJ12NotP46MZ2aUCOogWbqc60
 CHLpFjhF2ObJ8E1G2bXCBrlCAp9pVoGEiYayTzMkC9BnX0Rxf69q0owKi1it9ZVV97Vg8
 F6GLTsUwzjdutTRy7s/qHM/M46AqNUNx8S7iwbidMdo7IINYWlgBMn2S+L3TitdmHuM85
 eK9G3HR6BWCa51PNVcn03oItJ9kifdsf53QfwF6iVzGmxemctgCent8eoPLyOd3VKJrxb
 mcjE8XgYLE/ZNmvdFeLn5TnvcuhDo5Qit0q1VPrU+bBH5+wxuXoUgCiCjcILb52affQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713372;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=JFS0IrYhZFFNhtbdrLM8h23//ixpGVDOvazr8gdcXT8=;
 b=I5Pmr4B6HZxCPGwXPGYR0urUeISVYbh2vnKVv3DfTz1pHu6XniPOcYccr0QU5yRhzzmk
 dvBpX6alUzM5ULj+KcLhYNGrcusGeCif9xeLpStCFZ0ZUDTCjG7R5TgpPH9cQwBAYNwV7
 bqAuh8MjMzRB2zf8qE630PZxKsk4q4Lzbpa3scNOGa8S9LmCvT7/fmY/vSxaIlLFWTMuR
 +DbV4PEoI84wseb80oN9Yp1S6oBZzAaW2BvoO2JvcuPRWB/5+hrv7VROxxuCh8e+yiNU9
 hHwzfCXLjHtWve9wsUb2nWise7e16BkR/Ax4SDCq2St1rK5LxUcLKjWvgrSDOWuDrUg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=xVp7aGHO; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=xVp7aGHO
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24AB840AED
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:11 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso897475e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789713369; x=1790318169;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFS0IrYhZFFNhtbdrLM8h23//ixpGVDOvazr8gdcXT8=;
 b=xVp7aGHOO+ZyHOd4TTNc9LyxGdLW7r9EDsF8cN73ktxtiOJ+PgSxiooj7RpZwvzCnB
 Knrq4PjnDinMWqNHC9RFqHE3vJWrCNq/oPuBf3HeIWHMgGOpgl2B4eaHXjasV+MQJ4u7
 hVivdet9k4HHXWVY1O4k8EKCdX5QvFRoroiKeQT4sipAewf9wwgjYZ0c9M6lxuchna95
 E5REz47u9HmmrC05D5FMEptdpT+etw8x+01CMag3CeeN0250obZR3UoTHFln72J6lMj/
 wooJTNPhayPQosGqT6QtPMsosAi0gfuId9UVbIU7311FC207QMJBzKQqq2jE0FE/8gVK
 VhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713369; x=1790318169;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JFS0IrYhZFFNhtbdrLM8h23//ixpGVDOvazr8gdcXT8=;
 b=AMOfsHoAAwb4zjd6srEJ/5ObFgOYglgiDcK6UsOWPVr36/A6/X25GlBncclfavPx3n
 QzhtYCJ69Dx22kbrnnTOUPGNDXIDA7ucue/Tfqdc7nUeFbCQ27sxSaTaIquGS2MrrwzB
 LdyH8j4EoGFcSysaTUpkAYqaGzB1MnE3Zhv3J3ucejKD8P670bBUAOPzn+LiOYaeAHYx
 Mz8ExLfIcsLNvcJFvA9HffwBNzWs1aqIE0ZzaIFZKksw4EceevtPVUn0sAWbytGqxnbH
 y3hDQPyjOwvIUjK+Jeuq17QpoTb66yj+IhhSrDwX2M3zwUOYvyXoKKvz0xxWtbCdPxV0
 eREA==
X-Gm-Message-State: AFuF++nYAM8RCHhv+jmu1EIcD6xj/fx0kNuruPE7hykzHpbQYSXpt8nY
 FkxKvU7KcqCO2DvGdpbxVUpuexiXX0Mi3F3gFbVt9DCTfKTa7DMwhKTgCCz5cR/M36Q=
X-Gm-Gg: AYBFou00M6lplXDqGAd/qY0Y08bFolqPwzT6XfdomckZSBZghRJznq6tIGS8hJMK9xT
 UthdQ0mO0gpbvooGbEzBSVqyoMmmF93w5Ovpf89RDCMJmdFSsoLVPYCTd+dthbSbwVmlhFrTEn6
 +NurqbPr3uXVyCsiZbABObMyNdGH8a5513TZobgXEq22zr6dFLK4czvVj3YBfqoqrG/f6XMSffw
 l/0wqr3cE8GrpK7CDOUbJeqCIajVQIJ+NXtGE8fzB5daLQHwDGpjJBpESnDJPSSEVhpOPu//Vuq
 LB1jiZ5cBaxrLhZT6DSWOviBxBey/EdVANFycu2kVIiDJfCRdLXnUrxl1XrDxxxMDPHDlsq/VSD
 oC9gRiTOLfOO/3DFlLmFctDIDgzzeqmEmTzc04admfwfKgWIM7IT1EFfMIzKSN8SLyu3ff2KNbd
 DbWgxhm2vaZddkSmglUeGY7+rIvytfkPcqqGXPbCgcMKRcJq9RpJOm5EQCXQ70pmGmbJJFuNp2O
 E+VotOiPfjXnibbLinn++yrT908BoBHtssx7R7gEYSDtxJP5Uk=
X-Received: by 2002:a05:600c:8a95:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49fc52783f3mr14402095e9.3.1789713369258; 
 Thu, 17 Sep 2026 23:36:09 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cba562sm17725845e9.2.2026.09.17.23.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:36:08 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:35:43 +0400
Subject: [PATCH v2 02/10] scsi: repeat an INQUIRY that a unit attention
 interrupted
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ufs-spl-boot-wlu-v2-2-8a63e372bb6e@flipper.net>
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=alchark@flipper.net;
 h=from:subject:message-id; bh=BWlwjn39BjisHH9Ht6yOl9c4w70JMI7cpQzJ6hNY7q8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStuX1x+cI5364btc/rj6hYMFNts7JvfklkeU8N2w6+P
 TnSJQe/d0xkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVwQsYGVoc/kqvPSjEsfn0h4eak7yWR/LVt//YeLeg1p83k7/kbw4jw5tNAZ8
 MX1c7PP19fdEO84AT/04HxZ1M9vOSrPe1WtRoxAwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

A unit reports the power-on unit attention to the first command it sees.
For an ordinary logical unit that lands on the TEST UNIT READY, which is
already retried, but a UFS boot well known unit reports it to the INQUIRY
and so was written off as absent.

Retry only for a unit attention, since a scan that walks a wide LUN range
would otherwise pay three times over for every unit that is not there.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/scsi/scsi.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 50e7d7499212..aa7f9f1004d0 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -467,6 +467,38 @@ static void scsi_init_dev_desc_priv(struct blk_desc *dev_desc)
 #endif	/* CONFIG_BOUNCE_BUFFER */
 }
 
+/**
+ * scsi_unit_attention() - Did a command fail on a unit attention condition?
+ *
+ * A unit attention is a notification rather than a failure, and is cleared by
+ * being reported, so the command that collected one is worth repeating.
+ *
+ * @pccb: Command that has just failed
+ * Return: true if the unit reported a unit attention
+ */
+static bool scsi_unit_attention(struct scsi_cmd *pccb)
+{
+	u8 key;
+
+	if (pccb->sensedatalen < 3)
+		return false;
+
+	switch (pccb->sense_buf[0] & 0x7f) {
+	case 0x70:				/* fixed format */
+	case 0x71:
+		key = pccb->sense_buf[2];
+		break;
+	case 0x72:				/* descriptor format */
+	case 0x73:
+		key = pccb->sense_buf[1];
+		break;
+	default:
+		return false;
+	}
+
+	return (key & 0xf) == SENSE_UNIT_ATTENTION;
+}
+
 /**
  * scsi_detect_dev - Detect scsi device
  *
@@ -490,11 +522,19 @@ static int scsi_detect_dev(struct udevice *dev, int target, int lun,
 
 	pccb->target = target;
 	pccb->lun = lun;
-	pccb->pdata = tempbuff;
-	pccb->datalen = 36;
-	pccb->dma_dir = DMA_FROM_DEVICE;
-	scsi_setup_inquiry(pccb);
-	if (scsi_exec(dev, pccb)) {
+
+	/*
+	 * A unit reports the power-on unit attention to the first command it
+	 * sees, so give it a couple of chances to get that out of the way.
+	 */
+	for (count = 0; count < 3; count++) {
+		pccb->pdata = tempbuff;
+		pccb->datalen = 36;
+		pccb->dma_dir = DMA_FROM_DEVICE;
+		scsi_setup_inquiry(pccb);
+		err = scsi_exec(dev, pccb);
+		if (!err)
+			break;
 		if (pccb->contr_stat == SCSI_SEL_TIME_OUT) {
 			/*
 			  * selection timeout => assuming no
@@ -504,6 +544,10 @@ static int scsi_detect_dev(struct udevice *dev, int target, int lun,
 			      pccb->target);
 			return -ETIMEDOUT;
 		}
+		if (!scsi_unit_attention(pccb))
+			break;
+	}
+	if (err) {
 		scsi_print_error(pccb);
 		return -ENODEV;
 	}

-- 
2.55.0

