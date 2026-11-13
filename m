Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CB606A89B
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zPcrnsgh;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=W2VD/kry
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6C7F61039;
	Fri, 13 Nov 2026 12:00:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6zKmJo7rhyWj; Fri, 13 Nov 2026 12:00:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E44C460FEE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794571249;
	b=EMAmJE43GvfSvcjCfyE7ABFR370uRoMWxdvo41MVKm37dl5LXyE7ULxJmU1CF/f6jWrK
	 LxvntoBapI7S9hls/PGrSugHX50pbsAMcM8uMEjPn1YthliMpTsuM+eNSQv1ATVVv8LgC
	 5ZFfpYKf5FNL6oBn/q1x7P19nr2PEWzUij2fLbi3h0rCwW2B5Z2ofal0v3QEiUVnsK7oY
	 /Ynj/PMbatuZ1RpJEGYKVexhluYs6f0EhGim9JTHldfmWRK5Q5DEw5MX5l0n+vY3v8OV8
	 1DcAzlaZT0/0Yc+DKyyoHt6LgTGQ400dFJWG+hYMJ8NJ/STRAi7roG+QUXk4e/L4+Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794571249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1hZuJPUX367bdSycCJ74iygxf162hT4F8Ey7U/zRKas=;
	b=capljb1MEv8eWpu5Od2vPoRTET8nsr6oG89eCk5tKOUm63l5y4R1xraXp1rr5ACGq3zS
	 U0PQ9VJ1izJjQ55SJ1kKtdwb8qEjV2U7mnttuY4Q6iPoUT2yFXjv/kf8SEqjoyYOejnVo
	 sPa2VpvfG+wbasy7ujcy3q5f6GkJC6PVtx1B1UvC0X1LHErqXGfjjpm02vKh22OvhOM5u
	 IWAkg3VUlh3pJCyKxSX4dk7BwnB8as7vB3BT40CERFQ6GwR88b2EmiZKgCY5nv2ey1R6q
	 jfEwjPXGfNfqfTwIQjwVzPWT/SxbB3oLNbYca95knU7TboVl+XpfJd9kUtX3LHJ7niw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b="W2VD/kry";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794571249;
	bh=1hZuJPUX367bdSycCJ74iygxf162hT4F8Ey7U/zRKas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zPcrnsgh2f/MdXyWCSENukD0g62npAU8CUUVyJNNyn2VESdfAydhFD/c9MXSqiBB+
	 g28BdghejrAbw53QNyeaBjnZm3Uax4TKO3iEk0/X6+P7XRRsaDdNKnsTvaRZTLoe1G
	 U8ApUxDmZE7k6rENFRJNfPVS1++u1GstGDX5qXDQmUnwsLueyPr/X4GKLSyccaQXaz
	 nghRJAk2q5xZuTw2E6KHhinSrpgZZ/h+w6knfrUPxwv1bbuue14f+KTLURv/7DIakm
	 w4XdWrGMCnySpr4OJYD4n8bEYJ7yyxNo5OHqIoj9qeJUsJ45x/MyT51qsBnfUSkxXQ
	 jfC2LbMhi4mJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E44C460FEE;
	Fri, 13 Nov 2026 12:00:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 82CB6235
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7479660FEE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aO6VD9S1gTDA for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 12:00:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D3F660629
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=W2VD/kry
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D3F660629
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:45 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so4430875e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 04:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1794571244; x=1795176044;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1hZuJPUX367bdSycCJ74iygxf162hT4F8Ey7U/zRKas=;
 b=W2VD/krysizgtTFttQAjQr37ThOsb/GMvNrY2s0v/5o+9LrU4RCwfMFeZy753OCSyG
 fNt9qvvFpIEDsm6aaizUoB78TAPtScQx53Vo2tM1qRTRoiW2tjBUkGkg+29eUQOYlxcX
 87K72pSrGpga2k5PVCDNexAn/jI/SSXXiDcz2+gNln31+Cs0Ngvv7Q/+sZUMohqCB0tA
 f5+LgNFiGVZ436XYoIM94fjZz09n3oQK7/sVV+fD9YtigPlo5XhYrAwJnAdcJna4vlqL
 jyyWg5dkcPVRo1Vf8B5MWreseDraBrtUV+jh1nDOHTm2zvrNl8JmhPRimEa6ZF1dap6Z
 6Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794571244; x=1795176044;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1hZuJPUX367bdSycCJ74iygxf162hT4F8Ey7U/zRKas=;
 b=G4ksCZR/thbStoUpdxyOafWHlLsj9vu/2psZ6s54jFn0m359H+5zzojrQ6fvW2TC5C
 DmhnkiJyMuOB+XRWEJqNIIUz8jamcQTUHTvLGiLpGlk4HFyhKSG630q0scmt7jyu+feb
 kFWkh5GyMCbMplUZZj6Gu9Za3bud3m/FDdrvr/0bvQKU1EA5KcLlVF76H7QcDD8NQ/Dl
 4lpxSkhGE84Iw4N6sVQuVoTvnawkZtzfTkMeR49kn9gdGvO2W9ysuO+vatL4J5AxahgP
 Zon/NCZGbJ1Z5+xFcWHI15KdHj5UGAxkV02V7RAL5PGAT9uFfktq8TTL2gX6OctLT++P
 BcjA==
X-Forwarded-Encrypted: i=1;
 AL+hErF7uLvTMrip4xrloF3nB5lVzvRKXCR2xxZmkN/sTbITCHa2/JEFJ+uNnsoBETEyPAYl+ar8ad8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8bLMgnKO3VZgj2pIYI+nGxjPpwTqvDRzT+g+lJzoJOA12VhtG8
 zA7l6ifB4Ryxo7bQy9KAg5VdUMAoI9Eye85D2PlEikJ/VcSCe8be+5Rh6gXwt/VoT5RU8MSofOi
 plE2XNzNgeg==
X-Gm-Gg: AYBFou0Lh9y3HJi6hi0NP0F57Smlt4tMk322nOtxreP6cUd0AjWaaS6fG7/osBvLf9x
 9biDN/N2ClG4XYLUWtvdGgdDHQkyxyOiYpjmrcd0l8BSIuJ28dPPnMGDP5EvSqHZZRPGJt9zi5m
 KZrlM0RDWLLXLknfeOlXyxTSEg+p6Owbbm/F6eLhFzNxcMMfKXbeVOfMa9QtganmXtwgbj2Odq8
 t+6KVomAh05G9/wuvV7+w+gN/9hPsrVXdfSK7NTUjjCqeoK9IWLJQiganDIh6CTg26U2oMeh0AG
 Yx9F4PlHQfhxHL9E8l6xs5yQ1zSJ/aWEOWTFZxEGpLee3BKtPBLN83+fETtz4POjITW9CAUOa0E
 rSqcJG5sgq6XrD0EE6JLdZU7L5R9VtZqB0NVHGmsuRGTNq8YM20jBvreAhrjL2nan1jygFBNIG8
 1D3zGJ78rY8Qz+trjOLnN80TmbQiuXZ5bLh8HVDxDrNwv7GeP9IolXSMVlK9APH7ygBzKqB6Jwq
 36JAOXLMYFfsGqYrMEbTUejSiUxQuHv5YwSWj8U6cnp7SynWQB8sK1s40A/vYU3YAB8KALWMQtf
 wjT3Svhj4V0AN8JCARU/sz85GXcbjjaZF6xBOHW5ts4o2AvQluKd/Cq+z+vbtmPd5RL0c9KG
X-Received: by 2002:a05:600c:8905:b0:4a3:5a98:c279 with SMTP id
 5b1f17b1804b1-4bb55a57c66mr31111165e9.8.1794571243281; 
 Fri, 13 Nov 2026 04:00:43 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac1159sm52314195e9.4.2026.11.13.04.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 04:00:42 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 13 Nov 2026 16:00:16 +0400
Subject: [PATCH 2/3] nvme: Consume completion queue entries in one place
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-nvme-fixes-v1-2-a181c72f40e7@flipper.net>
References: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
In-Reply-To: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org, 
 Zhikang Zhang <zhikang.zhang@nxp.com>, Wenbin Song <wenbin.song@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Prashant Kamble <prashant.kamble223@gmail.com>, Torsten Duwe <duwe@suse.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=alchark@flipper.net;
 h=from:subject:message-id; bh=fdOJO1WclifeHqq4YRk7vP+ZrvpQaHjKMsQDUFvvbp0=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9+/1AT/p/7Je51+UcxFtfnapnWTzFoDYuoefYvj9ZJ
 5/tWPG1vGMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICp7lFlZLiw++f0c245rZWCGR2zvFd8/scVM3FV+y0m71wBtR/cJYwM/91VfHU
 y2HSEbxYKHf9y/uMOVeuXju0nphfcWB3mMtlSkhUA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

nvme_submit_sync_cmd() advances the completion queue head in two
places, after a failed command and after a successful one. Each copy
wraps the head, flips the phase, rings the doorbell and stores both
back into the queue, so a change to one has to be repeated in the other
by hand.

Move that sequence into a helper, and keep the head and phase in the
queue only, so there is no local copy left to fall out of step with it.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/nvme/nvme.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 2063c73f9d85..a7950227abb8 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -183,13 +183,21 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 	nvmeq->sq_tail = tail;
 }
 
+/* Hand the completion queue entry at the head back to the controller */
+static void nvme_consume_cqe(struct nvme_queue *nvmeq)
+{
+	if (++nvmeq->cq_head == nvmeq->q_depth) {
+		nvmeq->cq_head = 0;
+		nvmeq->cq_phase = !nvmeq->cq_phase;
+	}
+	writel(nvmeq->cq_head, nvmeq->q_db + nvmeq->dev->db_stride);
+}
+
 static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
 				struct nvme_command *cmd,
 				u32 *result, unsigned timeout)
 {
 	struct nvme_ops *ops;
-	u16 head = nvmeq->cq_head;
-	u16 phase = nvmeq->cq_phase;
 	u16 status;
 	ulong start_time;
 	ulong timeout_us = timeout * USEC_PER_SEC;
@@ -200,8 +208,8 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
 	start_time = timer_get_us();
 
 	for (;;) {
-		status = nvme_read_completion_status(nvmeq, head);
-		if ((status & 0x01) == phase)
+		status = nvme_read_completion_status(nvmeq, nvmeq->cq_head);
+		if ((status & 0x01) == nvmeq->cq_phase)
 			break;
 		if (timeout_us > 0 && (timer_get_us() - start_time)
 		    >= timeout_us) {
@@ -217,29 +225,17 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
 	status >>= 1;
 	if (status) {
 		printf("ERROR: status = %x, phase = %d, head = %d\n",
-		       status, phase, head);
+		       status, nvmeq->cq_phase, nvmeq->cq_head);
 		status = 0;
-		if (++head == nvmeq->q_depth) {
-			head = 0;
-			phase = !phase;
-		}
-		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
-		nvmeq->cq_head = head;
-		nvmeq->cq_phase = phase;
+		nvme_consume_cqe(nvmeq);
 
 		return -EIO;
 	}
 
 	if (result)
-		*result = readl(&(nvmeq->cqes[head].result));
+		*result = readl(&nvmeq->cqes[nvmeq->cq_head].result);
 
-	if (++head == nvmeq->q_depth) {
-		head = 0;
-		phase = !phase;
-	}
-	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
-	nvmeq->cq_head = head;
-	nvmeq->cq_phase = phase;
+	nvme_consume_cqe(nvmeq);
 
 	return status;
 }

-- 
2.56.0

