Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0825EC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B173860BB2;
	Fri,  4 Sep 2026 07:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eXh7tsR19PIV; Fri,  4 Sep 2026 07:13:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E257560BB3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505982;
	b=Hv9Ouemq1AINSvQxbJnUFMAr5bStY6jvnAIU+BQ3fygUTvOnCpBdnukq/GpK2Ov1hmYh
	 mLpUEaC0dAZac94CMCA7HAuZFTRLogxcoaAmTbVxHTVUPnexJJE1pmHxvdAuUw5TjlmX1
	 hWWGfZfDrTv6WdL2tEhUQ6wd95VWeEeCW3SHBI1snW7GxZrVEYpymNsz8HEahn0kiDTVt
	 txznRtbHsR0hejEAkU6qFZ2pnXDasx1uQ/Qz2PxRFHea42rr0gtrA7s/hNlDifq7gTK7i
	 WwuP3B8m+q3+VDOPjZBXbApSsa47TDT2ahuEBzA9Z9qdoh11Wql1FhmBNPNTn7QjNPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505982;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DSIIRR81McUDehViZVnsNnqR9mO1RRkvsd7/UoZZqgg=;
	b=nk8P2dvUmlyQBAH/NTjhZxFMcqMQRPdK5bKLfEbT5H3mn9x3gXb8T4ovlLtIHbcqTdVc
	 o96hBU6maXjKV1XgLF8p0YZzMfHFy46OjXFt/0yatT0t2A5NxPggbz/wj+sVTzde4BwlQ
	 bfh+rvFrMCkAe9AWcz55ASa7c/OyfX8KI3cE7sbNrwipuOM6ioIvhm6/QdEjL25zsago5
	 cy/sLBRNXQEVdy0XIyVx8RDzWxZeJJjHQGkRzBCta1AVya+vug8O/0n2KlPGSaf02ww5c
	 PZ27JQQHxnRcXehXcW+mBvg2Fy+mapDWbWuZBP3RUARVUim7RjvRr6gM74BPXuTDFxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788505982;
	bh=DSIIRR81McUDehViZVnsNnqR9mO1RRkvsd7/UoZZqgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DVeOH3AuwPajJEAoWXWLUIbNgbQUYc+rk4SZDA8Ci4xtGwUJGQkNMF6hRfZI66Phe
	 YbmuMS8Ub5kmdtZGEGQZBgpoaj++yh6qIDknvk6ZCNQ3bgKRKJQ0MURw4rtlItuww0
	 mBFE+KHVn49YMNqxS4rJ29bwJNaf3IvbveeKsfh7Ybb921NAmmNACa2nlJV+1OhtJk
	 AWlP4DWehbL/O7k2R51z7kkJPXh6BN3l4wjaXF6bIFQXnN8AoXrkzWQq4Aj4j25iS1
	 JkYrs5VLc3cNXaayCBwK9ChIqMxV17zI/aNEqnzFEIZllbcK8K3Q71OZVksBRFc177
	 2OEzL2O76BFog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E257560BB3;
	Fri,  4 Sep 2026 07:13:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE55334E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D81A34008A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dS0TIC5JfBX1 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D772E40080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788505980;
 b=oTZcXGGoTGi2y5WAp30RQeS2KZYtcaqW9inhLMjLgPZKGmBuIjYff/Bj6mAM0ZlyjZ9f
 lnv5cUG2x9cug2jvgrqZiBfQ6q1rOhvbWDVzsW70Y/nv4/Udbtg5bFh5jd5z9+0kXBiyq
 +k4eys3X2kRrDY8c6Q3zn+aTLaUzQxXa+19RCN0XwZNf69T2EOETQX+ORKyiVUJuPrMmI
 kJ1Yg6Y1sQjuxYW+F2CaZXq0YrKgMXcAz1lHwJXFbFKa+b4pftJkCkI79R6gY9nzdDW/j
 K6rtcguAILY0mjqqBjLdFYjIbHv3rwYEkd8eUMBcHf0Fx6l3R/M53dKD/T2BxCJE8KA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505980;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=DSIIRR81McUDehViZVnsNnqR9mO1RRkvsd7/UoZZqgg=;
 b=PJl6yUlFixR1jFLICmCnb0HHmZcimZe21nR4gKXA9hpW5sv6Ksc3knfFmggdSEhh+Hz3
 M+mumxyxNMvaAGDpkp4qT6+8oJxg6jpcdLtPI9O1/PiAeFfN1VZHeG7Mr8MG8hefPITxn
 eVUd3EviFkrzGXa2tu/xZNhD0e38d+JAB6Y7cA54utvlV6+ZZMRpQUtfGuLuyI4lrerAS
 z85iHcInr/bfxz9bluT+Gy+qZRjMmbEIzhbAMOnsUbMaWBVp3tHx2STO4Aj7JySX7Rhjn
 9yDGLVRy1g9OJRLuzNC/3BOtnObWmgGFylUJ0fS1dlswmo+/kHgi74A3biIbkL2dTNw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=kj9pDp04; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=kj9pDp04
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D772E40080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:12:59 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso6423025e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788505977; x=1789110777;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DSIIRR81McUDehViZVnsNnqR9mO1RRkvsd7/UoZZqgg=;
 b=kj9pDp04cD/OapkO4yHO0bSwTTp0oWcKvq8EWjmguFpBGo2teLpB+wNi6ImlwYUNw3
 Nnj9GLCFzV0//7oarq6dVGAQOxhi3G4qtuZT8bbhoYnYdwAOEXtJqgoEbfmrXIVJ+loM
 7YF3k4Kvn72XFbK+6wnjXCZEJShuNXc2qSkSLwG9BqsEAfw9iD2McCSl6ZhN2D6QGdhM
 5TTS7KynlxxgP0kYPzMVT8NPu1XmUpyf2cB9DonRMbO7s+KfCBWa99UN+7c3o5RRp1+O
 cG0z4y0GkvJp3RF2FoBhLyVgk0Y1BQtqqIKGyjfBqBCsg/sdB+S9vKlOwXb4e01cCrFK
 bXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505977; x=1789110777;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DSIIRR81McUDehViZVnsNnqR9mO1RRkvsd7/UoZZqgg=;
 b=KjhaoeR9NQ6JKRECQv+4arD80pYphnq6GCu6BkRcPHFyfFiXELTluWSkTFcMhWaNJa
 zYe9TqKYu4eIF5MagKnwKEauq3NwEuay4sJiT3oJISyQucS6zjCRHa2+Whtrn16CM/US
 8uR71M4VgAlmvd1mrEOHSBvt+yk2+1F7ekjP60qHXkiuJqNYKBP60NDuV3kYXdKDQ6cs
 QS5QcOOVRlaKS2Iw6Y2qXntF4AW0BP1096ImW2r+RB+NIdDdAfo14qNqjNbAkK2gTSl+
 ytbOUOC0R8vv3QNnzYXDAiP6KLiAH+a1LyEsktyA7zE4JYVTqEAcI7BBthVCdUkZ3gFe
 MxSA==
X-Gm-Message-State: AFuF++kuTBN4JYI/Um1Qc98f+m25i4e58wu8x1YZs2t1lVmGJqa/xX5V
 zXqwNQIbqe/7IfKZyGr1lvJHJnwT5CIDa255jh/werVrKy5m5GplqKB192pnA9h2ai0=
X-Gm-Gg: AYBFou0rNKc4KrUp51GOq4DZ4xPZ0e9I7law+8vSw9NSpwxAeje8jtuSoTAW0D6LyAP
 8eV5eEwd7pDmxioBWiOZZNiYyltY4gJNexnXDqTmqFdJ7SFCDsnjOjpvOEgpDRn2i5MR6v9SZeh
 qIAEBgRFalJFm5Wzl22rykMd37g3TFuJNvMC0hS7/hyrZYukDa+1fowwpJeW+zfMfSXShnWO7NF
 T6ZjtmNjuUGwdfhOORhJNkzy7phBrvse8yNMttY87xYpiGmN5fS/QkSr00NVvCqm27RRImSmTyc
 EbDdg0wb3yZ2zGEn3aNKN17YZUO9HYgrSeutGgYTi6tWoWxDFhDmJqVFwB886zPapEOMTLel7GP
 E0yj6nwhJB99HBf3BuODNThCvB1fu/gV+4+C41+/omuLrMiYrWQOrf9X+vI6hheZIGFnJwc28bT
 hkKcm0vwKkkTA31KKdOQ535PdFK2eBhMFbXH4aOTxdm5Y9MJfWHd9jzvPm32MgZLY9oE5HYV/rZ
 KDt1IuB54UZsDNVFic1qLDQZBg9dLz77AfiUoCR
X-Received: by 2002:a05:600c:8708:b0:49c:fa21:1c83 with SMTP id
 5b1f17b1804b1-49cfa211da2mr19267645e9.24.1788505977040; 
 Fri, 04 Sep 2026 00:12:57 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm4261923f8f.8.2026.09.04.00.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:12:56 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 04 Sep 2026 11:12:37 +0400
Subject: [PATCH 02/10] scsi: repeat an INQUIRY that a unit attention
 interrupted
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ufs-spl-boot-wlu-v1-2-59aeea16c4de@flipper.net>
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
In-Reply-To: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
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
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=alchark@flipper.net;
 h=from:subject:message-id; bh=/ejYRdXMv0Ud3Fz9nu/QqOE0zIVK+2c7r1ASWLYjxjs=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNyi8U+rvENnzv9fU9p6YoSsxbWask8s/fbsnX5OezI
 +4xrhHJ6pjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqlbYx/A+cXHJIIuy5qXjZZ/t+k03m+1YJPFmdcEopkP9DrI5UZSQjw4NSK/k
 Z16KnpFu1Zh8xaL8f5P29RW9vQfyf852h8Ws38QEA
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
2.54.0

