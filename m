Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651EF606A88F
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lClBvtUl;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=amKkvUMl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4331081D46;
	Fri, 13 Nov 2026 12:00:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IYNFuEhmUvFb; Fri, 13 Nov 2026 12:00:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DF3681D47
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794571252;
	b=PVHj2hTtXVHfjlh4FkOA/0bLhRk+/MGV+0D3pI0P7riKRQci9jv/NVCEFe99TMyydAcp
	 WrCAYoz72dFuo3aGeXX9CVEliIDAtZAKlhaET/+0iRUn/mpSkf5wQyvJm5bcHoK4ySpnM
	 2aQHItPRX1LvWggl+H5wpP2gJ+DaEhaQsmX6rR+ZQ36gsNxQnM/E+JqZdcgvQCMfSrHTY
	 LvVPVaPC3WNT385h3ENTwkLS76t220h+55fZcWj2FR3pj8rcybgUs7Ew6brXG/padCbRw
	 n7UnTPpjKzJQwrGl/3ou04feo2Zz6/Ziny2rWqR7dVmdBqRc+uVj4p9MaBKxIkfunXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794571252;
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
	bh=ShcVgasx0ZwIyboDuOPf4Up8mYU/voHCuf8wqkEv4UM=;
	b=Nkq19DQSoyGboUw/ohg4xeXZpHOKtl07zYWZoMY9WwOF16lqATAopC/Lg+Q7DQFvdyIh
	 IQGAFG6grjFvQi6dk4gqrkFNtqMDfTxC9Pyd3xq75dU3Tu4qzTWlSW6+2ulfjktDRd1YD
	 KVgL2TXIhLSR+tWwJycQ1Fll5GVLnAymkpf3I6BfkyFdU5M/iifzYqI6EE33pqQIbX35o
	 6iqOqLzpXAhpNvMZVT4Dt2HYrpu1qDdfv8ieqFcWxM9nks4sU8VyYm96xkHYiASqxfW+X
	 I03knPJzwKEHP5rdQ1Mlq6YPY+O5FGoh23n7KJo+C1AYspI07f6OeVbHGRHix08GYSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=amKkvUMl;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794571252;
	bh=ShcVgasx0ZwIyboDuOPf4Up8mYU/voHCuf8wqkEv4UM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lClBvtUlgUItcjLjE/2Oa3cbhHcM28wB6FQQdIMRV8OzHm599BhXy9K+3OO611dRT
	 c5LYiwOsViqi9dUbg6b52LmCAEyq73SgdoyVmYz0YixNSoySsIZ2pqhx94L6xbaeAz
	 goccUHJBxlew5NeAoA8gRswAgYdQ4TWPTSl+XX0NXn7pbcXEWSLfrx2XSqTc9l5gA0
	 HM01m4suAJYWmxLRqIR7dtVPK0eTZjbD2Ayb1YHkyXzblcazMwy0byi+o97w5XV7SM
	 WN1OUIQ6hUq6u9f/FTi6PBBw3VFUVcT64RX9Eon97MYDVAlXCWNjTWtGnx0h0v0jI6
	 Zh5u9w5L8Bpvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DF3681D47;
	Fri, 13 Nov 2026 12:00:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 26F3EF46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18ADE81D47
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nhEAWIUZSOoF for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 12:00:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E96E81D46
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=amKkvUMl
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E96E81D46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:49 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so12440635e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 04:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1794571247; x=1795176047;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ShcVgasx0ZwIyboDuOPf4Up8mYU/voHCuf8wqkEv4UM=;
 b=amKkvUMl+cLUUnRcdGf9K6O+pIGcsOrFqp1D07sYYN03W2N8nRi45e2uYieHL6jZ4r
 ViDsm1KWgs88BAVRwfc+3MUvxWbTkINLQ2fsksNhEBdMstgKeZwkAJOO1/PteDrZrHVE
 E+XgrLTHqOtl5F4gVSY+70ST/a3qZSVpvnvZ/MrTB2kzfr5OUMEwLuDOSt69KIzHSaUx
 Yi8JMp9ozCATego0fCjzrX8d6YB+/SKNu7/VYzMtjnN/gV+e6CG5xV+0MygOERgUUHXi
 KM5OMbA3X/q23VpVDdrwHn3CZAKEnY5CeTaYstqaC76eHH1woZPINDWiy8FCouwA2asY
 JvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794571247; x=1795176047;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ShcVgasx0ZwIyboDuOPf4Up8mYU/voHCuf8wqkEv4UM=;
 b=yykN1bm0zZDNFQxYYWMxfZ7/QuiMwe/O7ZzaX2YzFjkEd3YCYS9+8FHZweoXaggSbP
 H0LZQwZdBMEEWEnKV9Wz4PtRzePiH8kA6feBWZZVDhJq+TFgAV5SyYcdQ4ffQI4lYzY6
 ACK4WjCiNo5EZWoUca/Rh4cVu2/Dwvzj27xRAx2w39x+vDD2n7BDpR3jvTdPwjJZ/x34
 4hhJh/XjanzYYuZNHD08k9dyMWNPCbet2sOWdPMEWi7EnFW5Z4SvHT82h3nuujwyDX3m
 jQd1YvggTxITs/oREm048oj+rIGqJXGdEIsNylRlganVuOywsGRf6+jzSP5tZmB3Paec
 yETw==
X-Forwarded-Encrypted: i=1;
 AL+hErHEWqelt9rUOFHCQQpWN6CwmznwZEuniUjO4egCYScTGQfZG59dhBJQUdVY8vrUC6xSF82Aw2M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/MWDHT5VVIg64cQHyeY4VZehP2vIoEKQiK34KWs9pSaTi2xlXw
 WRNIk4sjweVnBwMVfy3oEciAm98dzY6i4cxFpYSs+95/bgfpXpJxuC/7HkhLufLzeos=
X-Gm-Gg: AYBFou3479t4V/VW/JhDUqCm8IUUV//BqAveCeFRT9Kb3mkbIsenWesaIMwbffX1SEV
 hzBs+QpM6TGdZceasdwSojC1LfIYO32jJgzAI5nWlttzeZiSQkXHZMTq85IgiykaQu9/Qm/+U/F
 WJFII3Pm4JL0TzZvMHvLpim0bRPyKCh9Q3fDqEYwlacOJV6eCVDpcGC4U2lnodaNdFem4hJI8z6
 HZykM/O7SAOtHN+28Je23vFtBZJbzmPFIlARORxiYF6Kl1GBtYGI6/eTDq4ctNc8SzsQOpX1YTC
 E+dTrTMo0gIRSCBvcax81aHQmoT5yKHFtEBfj8R7NBdyc67YmTUBqzGXMl3MuhzrPvbdqlaEPdq
 fJVZVZ6MifPYGm9lsyKTGG7hH+jLkEy9oLr6dQcHu31hAJgWYY8jjDsd9DT667+qED8vbYg3uSB
 SmDDrvjOH2Sc2guLQ8COTOAniN4lVntYN1btkxGnERXzc258bzYGsfqO+Ncp8owDDqzJgJieCFI
 npagPqrZ0JCfbi5IdMfV7OKrFdBgdVxuvGz/D0u5a8TAfjY7o++YhVZKsLSprn514rGL8IX0IXF
 jxYGW3L6zFXSxGsY3q4+SBDXr1Xyq62gYkyeo8b88XBgIUSnwKSMAKj81AWbqxRK4gZXFTa2nKC
 cx6E67vm7Ug==
X-Received: by 2002:a05:600c:8b0a:b0:4a1:da58:1ee with SMTP id
 5b1f17b1804b1-4bb55a95dbamr44639445e9.31.1794571247565; 
 Fri, 13 Nov 2026 04:00:47 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac1159sm52314195e9.4.2026.11.13.04.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 04:00:45 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 13 Nov 2026 16:00:17 +0400
Subject: [PATCH 3/3] nvme: Drop late completions of commands that timed out
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-nvme-fixes-v1-3-a181c72f40e7@flipper.net>
References: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
In-Reply-To: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org, 
 Zhikang Zhang <zhikang.zhang@nxp.com>, Wenbin Song <wenbin.song@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Prashant Kamble <prashant.kamble223@gmail.com>, Torsten Duwe <duwe@suse.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=alchark@flipper.net;
 h=from:subject:message-id; bh=yb8r+ISZ6p31Ul7cHDQif4tRfGaAHARjn5lal+eopq4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9+/0wTKTxc15L7ewvhy4+/yW7yF9Iplx68dcLuy9dl
 rINEnj1omMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICp1q9hZDin9Okgz578qQauvTdaPD6IXPl413HJwdYH62JnbTqUp5PEyPA8l2X
 zgoLyaAXReb2PJxvzbdrg6ONb9eb5i60aMz22fmIGAA==
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

When a command times out, nvme_submit_sync_cmd() returns without
consuming its completion queue entry, so the entry posted when the
command does finish is taken as the completion of the next command.
That command then returns before its own data has arrived, and every
later one stays a completion behind for as long as the queue lives.

On a Rock 5B whose disk is slow to serve its first read, this turns a
failed GPT probe of LBA 0 into a successful DOS probe, which consumes
the late completion of the GPT read and leaves the disk recorded as
having a single whole-disk partition of type 0xee.

Check the command ID of each completion, and consume the entries of
other commands instead of returning them, so a timed-out command no
longer desynchronises the queue.

Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/nvme/nvme.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index a7950227abb8..37f5a3ce4b10 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -209,8 +209,22 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
 
 	for (;;) {
 		status = nvme_read_completion_status(nvmeq, nvmeq->cq_head);
-		if ((status & 0x01) == nvmeq->cq_phase)
-			break;
+		if ((status & 0x01) == nvmeq->cq_phase) {
+			u16 cid = readw(&nvmeq->cqes[nvmeq->cq_head].command_id);
+
+			if (cid == le16_to_cpu(cmd->common.command_id))
+				break;
+
+			/*
+			 * A command which timed out earlier has completed
+			 * after all. Consume its entry, so that it is not
+			 * taken for the completion of this command.
+			 */
+			pr_warn("nvme: dropping late completion of cmd %#x\n",
+				cid);
+			nvme_consume_cqe(nvmeq);
+			continue;
+		}
 		if (timeout_us > 0 && (timer_get_us() - start_time)
 		    >= timeout_us) {
 			pr_warn("nvme: cmd %#x timed out\n", cmd->common.command_id);

-- 
2.56.0

