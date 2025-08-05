Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3ABC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 15:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85B23838D5;
	Tue,  5 Aug 2025 17:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xIRYkOgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FAC838BB; Tue,  5 Aug 2025 17:45:53 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80F3838C5
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso23543225e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754408751; x=1755013551; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IK3BEPYH5OOu4Mxmw1dUh9/vd9j0VXhDt2Ge91sl5qM=;
 b=xIRYkOgUtTSjL2iMoS+wA2JrvQcebjZjCn3NOxn52RpbpA2fu2plJgtZt7jJ0uFV9y
 AO+RVzCuuJS2JI18i/og7ZlPEmq3Yk9T1EFYZ1EoAtNIIlZj53+AqnS4808j9XwBWyiT
 lol4WWtffXuIYQPWAHahOpcrtfiKPec1QdXnVUuKIrgiThGbgGEWV7Mo9KumE5r3GzdR
 l1vyvjXPvKSmtqBF+7S4H/jCXT6/uA25gZmgdmcFRGDLNmDQzSKusWfG4qBPnTADKdz/
 EJ14TrnhwBQkcjUZEkkJjTXza/UjERXZBAo9asZR2Nf0edzZhJMw1HqICR6bbq2ewttS
 bEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754408751; x=1755013551;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IK3BEPYH5OOu4Mxmw1dUh9/vd9j0VXhDt2Ge91sl5qM=;
 b=OH2tari3sR4pnNhu0PwD09n4CguEvSkkikL48AvmazmmhpdZme6HqFLI8PdTk3c91u
 lihMKBgAsTq2YK2DeEsAkaAFnM6/1H45mgxPVdO16MRWZcnFS+Wl9ijlIrpReKMbdAsj
 HswHkVBYA74uk30/rE2dDUcpzB6utnVMW3Bx9kIUdokYBdcJmv9/Rlqg3ygFzcumDw2Q
 TS1JE3OI4xCL/VcTHaX9vQWr19b8Cqe0iOZIQ+T9Cw6dhOKgHH50HM+JMvfQc5b/GVtm
 DVIo2Lhdz8xlorQgK3a24fPDcqB7mwDam6BLjm+b8RazTv4E2r2HcyKs9efmLeyElNwD
 lXmg==
X-Gm-Message-State: AOJu0Yy41oNBv0ufL4OiY92kfoWRZKPFfGnvE5ga4Eutm73bRfPBhMjm
 teQ0FGVvyWvUN+hNneqJ4fJdWwwm3pTaYWhUkyaR7QgP5PzitCMj7Yfzm+0w0+ZH97c=
X-Gm-Gg: ASbGncuy4IguyHUtb8VrPHYv2Wslfbo/XbS959w1WGEUpyfsod4/ihnShyTP7yntnxw
 LwPo6ZYOcuYQyZ9IvvXEcSjavwwhpRUZXH7DSY4zG1jQ8YCYHVjcKARH3/AjV8fcEmiATZ8Pp0+
 ZlRt2nbyWapkEoIKnwmtIKJuEj6uisrECK9ELTuGSAupdGyylYLfZt9bazw5pGCocrEdpu+9FJB
 L3asCP63S8AgZ+3mYmdF6voxnh5YwqCRD+rbj3ee2bvrQT9gv7aZ3qEFUZ0ZuhGfMTMHDcwmFor
 oXI17gCEQS3+Dmklzj1FPUXQ992KjfbROCsUmkDOoUyPNw+3jwCVaApoGcpKmswLhB2nmd+L6GT
 1cWQNRonBcPnciQdDvxe0MpYqP2qR/+UuLK5zJ0W8RWjLnG87bDo=
X-Google-Smtp-Source: AGHT+IFmHZr6z96xKRDY5E7aIaiKTPKP5Tld1aBuDemo6VdoknxhxSQAtOK2+e1YfyCB4irM17dJrQ==
X-Received: by 2002:a05:600c:3591:b0:456:161c:3d6f with SMTP id
 5b1f17b1804b1-458b95b7ca2mr104063925e9.11.1754408751173; 
 Tue, 05 Aug 2025 08:45:51 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5852e28sm9007255e9.9.2025.08.05.08.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 08:45:50 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 16:45:48 +0100
Subject: [PATCH 2/3] net: octeontx: Remove unneeded test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-net_octeontx-v1-2-637095d82265@linaro.org>
References: <20250805-net_octeontx-v1-0-637095d82265@linaro.org>
In-Reply-To: <20250805-net_octeontx-v1-0-637095d82265@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

In nicvf_cq_handler there is a test for !cqe_count which will return if
true so it is guaranteed that cqe_count will true after that point. This
makes the later test for cqe_count redundant so it can be removed.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/octeontx/nicvf_main.c | 46 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/net/octeontx/nicvf_main.c b/drivers/net/octeontx/nicvf_main.c
index 8021cd752b5..94e5d827614 100644
--- a/drivers/net/octeontx/nicvf_main.c
+++ b/drivers/net/octeontx/nicvf_main.c
@@ -273,31 +273,29 @@ int nicvf_cq_handler(struct nicvf *nic, void **ppkt, int *pkt_len)
 	cqe_head >>= 9;
 	cqe_head &= 0xFFFF;
 
-	if (cqe_count) {
-		/* Get the CQ descriptor */
-		cq_desc = (struct cqe_rx_t *)GET_CQ_DESC(cq, cqe_head);
-		cqe_head++;
-		cqe_head &= (cq->dmem.q_len - 1);
-
-		switch (cq_desc->cqe_type) {
-		case CQE_TYPE_RX:
-			debug("%s: Got Rx CQE\n", nic->dev->name);
-			*pkt_len = nicvf_rcv_pkt_handler(nic, cq, cq_desc,
-							 ppkt, CQE_TYPE_RX);
-			processed_rq_cqe++;
-			break;
-		case CQE_TYPE_SEND:
-			debug("%s: Got Tx CQE\n", nic->dev->name);
-			nicvf_snd_pkt_handler(nic, cq, cq_desc, CQE_TYPE_SEND);
-			processed_sq_cqe++;
-			break;
-		default:
-			debug("%s: Got CQ type %u\n", nic->dev->name,
-			      cq_desc->cqe_type);
-			break;
-		}
-		processed_cqe++;
+	/* Get the CQ descriptor */
+	cq_desc = (struct cqe_rx_t *)GET_CQ_DESC(cq, cqe_head);
+	cqe_head++;
+	cqe_head &= (cq->dmem.q_len - 1);
+
+	switch (cq_desc->cqe_type) {
+	case CQE_TYPE_RX:
+		debug("%s: Got Rx CQE\n", nic->dev->name);
+		*pkt_len = nicvf_rcv_pkt_handler(nic, cq, cq_desc,
+						 ppkt, CQE_TYPE_RX);
+		processed_rq_cqe++;
+		break;
+	case CQE_TYPE_SEND:
+		debug("%s: Got Tx CQE\n", nic->dev->name);
+		nicvf_snd_pkt_handler(nic, cq, cq_desc, CQE_TYPE_SEND);
+		processed_sq_cqe++;
+		break;
+	default:
+		debug("%s: Got CQ type %u\n", nic->dev->name,
+		      cq_desc->cqe_type);
+		break;
 	}
+	processed_cqe++;
 
 	/* Dequeue CQE */
 	nicvf_queue_reg_write(nic, NIC_QSET_CQ_0_7_DOOR,

-- 
2.39.5

