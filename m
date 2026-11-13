Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6960A3826
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r0N20NzC;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=YrwUX6ot
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E17D40E5A;
	Fri, 13 Nov 2026 12:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ngfwOtG31Ejk; Fri, 13 Nov 2026 12:00:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65B7D40E48
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794571245;
	b=kLVrG+v2A7J9svM1ibNcHKZQFsIlGw3tES2bOyadVvHWKxSu7OIW+rWcligJUVV4Tgz7
	 msfgNUYrEytXyPDdyLD04r5t2r+bW1cR6hQgPOPTX3hUIqWaEhUYJgyw5l3+WqxxxD1WW
	 vGZpz4orAHLrrCCCIQB//Kxqodg7r0BiWfzX6GrKYQSE1TCca0J7goG2vFZBTLn6fY/Jl
	 dOKzhGe7WoYwRFobwbDtZ/qrHQYhBn34OpauPbEQgzlZRGikUb4guUaKJzg2WoC2vpUVQ
	 ISsDtFx7MBQE1/sQHho4wsstmblvAbOW45vUmnK2ThXsXEEKJ+A+HhAjuhcoIEgwzXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794571245;
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
	bh=cqvjsJ2hag2ENDy3JgeWMY+m5/+CZDQeaV/Ff+SJ9sM=;
	b=joxPkEaYH0tSMBmVsNF7zqFjVNPm+IZXXZ3EKDWIr+QcVOUrNCunUd78xAM2rwSELAtf
	 YZef3tD4Y2uUsYGZje+E1JLNSopXkUmHp7mHW+sRI9FtHOw45BQgf1YRuXVwbFzv1iJXe
	 nwR0ZNbVUKiIcWL2tI+9JW4TOI4oGtEfZVtHpcYDjicEHN8iSwDZzyGDfyKeY9UGFMtZR
	 7suOqKXli3F+ReUhfhJ+adDH4MKCu8vSWnZPaLJ8XYc6Z8erE/o+pdqXbwnAF5AgzL1rY
	 ig7RcFvrqxLeXFpfhMZlrvookEiAwMW3DPR/JkOZSSdHijQE0vZ6B99BFL0E6EIdiwg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794571245;
	bh=cqvjsJ2hag2ENDy3JgeWMY+m5/+CZDQeaV/Ff+SJ9sM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r0N20NzCgVTfo7vDSlSMrw73dAMTShqQm9C8SY9gXiJAxmYSurI9MlRr4FzQikjZM
	 KM57brIHcmzWhlGabRlvbW7cvCwwjz8hCvYFuFzejuIAPFKSqZKSvJ7uNFkKIdF1MJ
	 6qBFuSO0ibZ/aJoyzKfM1TGNmzmNwzb96Uzo9GZVbUQSWne+YzO6FZsAi3l1MlVF7T
	 o6z1iMneoKhd+DWtE/yu+3d+ev48ubmiULM195Iq+yg+NJMG8rbMaYZxmgei0tmGdd
	 yQWCru+DGtaZwUVBopV9Gcl8WSj3eDi2zw1EhwZ0fMPW5hH94dv9Al91NzwhnitlHA
	 /q6WHWU7rhXuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65B7D40E48;
	Fri, 13 Nov 2026 12:00:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AEE1628C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9503940519
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LHvhNBd3MZjJ for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 12:00:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A8214404FF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=YrwUX6ot
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8214404FF
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:43 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so1850795e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 04:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1794571241; x=1795176041;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cqvjsJ2hag2ENDy3JgeWMY+m5/+CZDQeaV/Ff+SJ9sM=;
 b=YrwUX6otpIg+vv1o6MXd1vSDR63OM3hUtW9BIXg7/Iy2xbzMkZ+OnZsqK84jgSEbkd
 7TKPnDiRk58npcxlrlQilcawZfhBFIh5Zn2i3cDAkd5eauvRpYR1gG860Qogvtnil+rn
 J24OX32AGhGVHVHDtXmSG/AHFc/76DVwXzSuCtj/NARsAeJyizo2HvjdIGKTSRn4DZ2X
 LDVAZ0QsThI3xhifNtuDhTNezUKtIRCR4mdThvx1ZwTixt0sS6DBjgmwW3fzPguigCJJ
 xE2ju1OrC6Slf/vVU3OT9lkQZ+GijEQuMhd/oLHWf4UIG9JhEIrvkeGkb1EE2cKfWvxj
 4Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794571241; x=1795176041;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cqvjsJ2hag2ENDy3JgeWMY+m5/+CZDQeaV/Ff+SJ9sM=;
 b=Td//NWXJmm4cusFH4GnlI1OJRyF6L+b6F0O77cMag7I3buCIt48kii+deeS7ZTGisj
 cJ3/tbJROkkUCXhYLarWMfPdgRPrgXPfd2TH7KCSB8URVu8a2tXuNhhjaXjtRpfCp2l9
 VjS3HgTrUWOifIrUo7jka17kYIwxeFEW2hd4JT/pFhIrTH6AbdX4758udBjoiLuYS+oX
 nlDJg7EX/YQMWO+8z1yWQG+1f30lnoonaELGTsCuG+IcKU+4Dz0GhpMOAst18cLHP6Ur
 z1ixG29JE4o21HtBCmymk0NyHCYa3nM+mTY1/9S2xgLBMKUzzcH4GWaudaaIt+xMLqVW
 R72Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFuM5b9Xy+uSxGps7Juzo07xKdJKH9WmSYC+RdhY3jfdDJ7ZqzxreE6DSeDR7R4DtFq/CUWFVU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ZS8UvhGh/pZz2VSCEslCLZBDQS4akN6shx1Qczo5Sqn1JIOL6
 Kkc84oRo2A7jkeF7q318gvucSHfMBgk7aS3CoV67TuV1ODrh+P/Y0hVPMs1CTYNFoRA=
X-Gm-Gg: AYBFou2+D1M0h3OajNn8+IhNt0BFJzzi7GJzOgszerCUy7+9Ke0dK77IWg3dppUtzK+
 onDowHD4SS2ZKpEqQnlO7w0KhowcBgjmixCLpqB/Ycw/rutcmgZMP6+bY4rTzhZNkd3n2mbQhEL
 9R8l4yD65Ki8fA9wXerCLQKp/XaotBF/wcItC8pS+pRiv8wk5HIjE2tFjxBWfUplgnESfvdPTHw
 +s+gDJb+Kzj/Oj4QudN+rjDvgon6xam0DioxxQZGvLiXvqwG9gyzcOeYhbLmsRd8NXTdJKxlKkj
 e64r7yFw14RBNgIwS2+xw9JxsmrJmntYLjMvVSzAUrz8dr/6hidKSxveWBe/zsZL2Zt14u7uc1x
 k1ufLYeGh8cI61NC5jEiVrCadlVKAVKGWM2W283DzoMQkVsHv2YgKYl6jpUHKRs6QG29KODyK8x
 zeDNk4k1EQrvQO14gFkmkWOkJJBrRcH6BHwTJ7ggvAIRBgnDVkLYH7aoiaQKJpBSgtQe3j9zqbx
 ZElypRVTnN7pG13U8viQhkjmdfb7o9orDzjmLlWVM5X8tnu73dqKY/N08+Z8emzyiX0C+23k8q8
 kIXQaRHxO4iFq9ehyjEcDN3WcsLjeqIZPf6AQpx2rWQx/I353v2zENmLsSFCX7SZRqymHU7XIuf
 98qzbD/x942e3nmfMET0Z/jgaN3NzodDV
X-Received: by 2002:a05:600c:698d:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4bb55a3e341mr44998505e9.5.1794571241070; 
 Fri, 13 Nov 2026 04:00:41 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac1159sm52314195e9.4.2026.11.13.04.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 04:00:39 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 13 Nov 2026 16:00:15 +0400
Subject: [PATCH 1/3] nvme: Wait for commands in seconds, not tenths of seconds
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-nvme-fixes-v1-1-a181c72f40e7@flipper.net>
References: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
In-Reply-To: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org, 
 Zhikang Zhang <zhikang.zhang@nxp.com>, Wenbin Song <wenbin.song@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Prashant Kamble <prashant.kamble223@gmail.com>, Torsten Duwe <duwe@suse.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=alchark@flipper.net;
 h=from:subject:message-id; bh=hypikaTr31Eeby42GF7aAjZNTurYk/WiGpff1xtLJVE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9+/1gy/ormv7qDJE8Ji3OKt3LZZwkZ/rdnfnEO+Rt8
 iaOKH3WjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKbaeyfDX8mnWhuaY6dkTdx/z4PnywOhX4oz37DnLrNbkhd44pRNkyfD/9Qgayt
 jfY3T3Av7JonHeU1aVvpbeNNTmeOZSd92W7gq8AIA
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

ADMIN_TIMEOUT and IO_TIMEOUT match the admin and I/O command timeouts of
the Linux driver, 60 and 30 seconds, but nvme_submit_sync_cmd() scales
them by 100000us, so commands time out after 6 and 3 seconds instead.

That is too short for some drives. A Kingston NV-series disk on a Rock 5B
takes 3.1-3.2s to complete its first read after power-on, so the GPT probe
of LBA 0 times out, and the disk is never seen as GPT and offers nothing
to boot from.

Scale the timeouts by USEC_PER_SEC, so they are the seconds their values
intend.

Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/nvme/nvme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index c815a9671374..2063c73f9d85 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -15,6 +15,7 @@
 #include <time.h>
 #include <dm/device-internal.h>
 #include <linux/compat.h>
+#include <linux/time.h>
 #include "nvme.h"
 
 #define NVME_Q_DEPTH		2
@@ -23,8 +24,8 @@
 #define NVME_CQ_SIZE(depth)	(depth * sizeof(struct nvme_completion))
 #define NVME_CQ_ALLOCATION	ALIGN(NVME_CQ_SIZE(NVME_Q_DEPTH), \
 				      ARCH_DMA_MINALIGN)
-#define ADMIN_TIMEOUT		60
-#define IO_TIMEOUT		30
+#define ADMIN_TIMEOUT		60	/* seconds */
+#define IO_TIMEOUT		30	/* seconds */
 #define MAX_PRP_POOL		512
 
 /**
@@ -191,7 +192,7 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
 	u16 phase = nvmeq->cq_phase;
 	u16 status;
 	ulong start_time;
-	ulong timeout_us = timeout * 100000;
+	ulong timeout_us = timeout * USEC_PER_SEC;
 
 	cmd->common.command_id = nvme_get_cmd_id();
 	nvme_submit_cmd(nvmeq, cmd);

-- 
2.56.0

