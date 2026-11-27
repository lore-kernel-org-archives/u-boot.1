Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2F606A321
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ml/kaz0h;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=OOiDAe7+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24D8281177;
	Fri, 27 Nov 2026 15:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UpKFk54tgOWB; Fri, 27 Nov 2026 15:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66A1D81178
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795793724;
	b=gH8Ly8rxGMQGY5N5fT+36XoMfaBGRlUSrUheJc72kUHcc20ZHSIR1Qmd74KZRmMtJzCQ
	 nW6cRX5+I4k/1nG785WenHS/OnqCiqmYj01v7XR2GzyBMJ2N7HOAsrIslB7E0FC+P6L6p
	 CDhmSGtljU3myaBakS+OI4RAy3CDU+ox9XFzyRK0r4CFxdcdsTMbP5zdfc5rV3QqUXg+F
	 g8QV+849vFfrf/9iav7iX8hOA+REWl/P90VwwNn0qLtOcUu3wxOC6VjPFnyVM55HcBEOI
	 uk1Q6jza+5ecikOU2uG310Yfme7j46U0BolcRLseQothha0blMboqsSf9H3XaejshKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795793724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=awIws59zlUC7LjHxWnlmFEiq7EDtjz/Q36hBhcOYoOM=;
	b=gtSGW5Dc4GNS1AhA0ObEif/dNbx7TWvCuR1cBCGE4DVtgN1xeRBsRzjWi/7HaUZRVCYh
	 9yO21bpfGPCCpvD1vAf2eCkbUwRwmRzD4FfDt36k3+m8XkbW0w1G2oF2iwY+Djcs09Kgl
	 Y8tNdGx4Lk9jvjvf7UN9WTDZgCVg5DkV0NvvBtjI6FTmFj85jaQVsxOJWOtsp9DZtifL4
	 /v55NF4p9886ohkgO60XmCoYBAPY7DeUMZNDyug/wPfQaZR/+KGYwpJHDN/ow19ZCTPhl
	 op4aErHOCfrYxBtvse0xQfi5asDzwT7bU/MerhrRrdWTCV9uWS9LhRutjxJ044J7iLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795793724;
	bh=awIws59zlUC7LjHxWnlmFEiq7EDtjz/Q36hBhcOYoOM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ml/kaz0hTdRfbglcx2DifA/JLKY4FjsRbgXq+SzJxrY3SWeDhMgRGTjsbUIV/H1tw
	 S4+OoUW1N9OIzziYhgUSnO8hlWewglMjri0vr9egYthoUjALuzDCeB1uD34r+KAg8s
	 Wu+1sa7QkBU8HVnFzsmSrgwz019wVZ8l9sfXoCzyWixjNNXY9/t4GOVzW75+lAY9gM
	 lRdJVGUFKWHK2fHR/xSB60nhzJi8rZaMQ+44IIbw+NaxFBZh1MJunS2+arFmXT6hWB
	 cEn63MPf9b3PxJzbx0v8A3lpXrfRLUFpeLzjY/u0Fzh2YRk010z6SksqUzoL+Jr9R4
	 d1kqMBLQ76UoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66A1D81178;
	Fri, 27 Nov 2026 15:35:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 262C82BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 175F6608B5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ymij_9fOpqEr for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 15:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 153C2607B0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.stein@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=OOiDAe7+
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 153C2607B0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=awIws59zlUC7LjHxWnlmFEiq7EDtjz/Q36hBhcOYoOM=; b=OOiDAe7+c4E6RIhnVm9RMAfcLb
 lp4ni0xnN37/A+sYc7JgK09anxB8mjdsj48VSaFq14L27M8CVlzqqDT9cVJ2PoAVqNZSeCxpl5b2t
 Z7vfr0VhPJNwzgEGc/Y1zCq+HlC2MwAfZKncl/HP1jftu5KnQ2ukLwM5Yh+usNYpz3Dhf1S4CIh4r
 Rbp+++zmvpSsUtIQ7Egcdbp2ljP55Y6+JfiNRn69Bm4lk0+QOuIY/x2u8XNfYSSMYvmqee4XapeTo
 Q5SAzMtpNgEkVbSDvSqoKniOnz4ovX5XB/6T/DuT/8z5NibC8UWM4DJER+cRi0lznzvRmLcSTFpA2
 IK7HkSow==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xWxyp-000D2l-1F; Fri, 27 Nov 2026 16:35:19 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xWxyp-000PON-0T; Fri, 27 Nov 2026 16:35:19 +0100
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 1/1] bootflow: Fix error message when flags are not supported
Date: Fri, 27 Nov 2026 16:35:14 +0100
Message-ID: <20261127153515.2355053-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
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

The compile condition is CONFIG_CMD_BOOTFLOW_FULL, not CONFIG_BOOTSTD_FULL.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 cmd/bootflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 081f64e12ce..e5c24f5c7de 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -183,7 +183,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 			dev = std->cur_bootdev;
 	} else {
 		if (has_args) {
-			printf("Flags not supported: enable CONFIG_BOOTSTD_FULL\n");
+			printf("Flags not supported: enable CONFIG_CMD_BOOTFLOW_FULL\n");
 			return CMD_RET_USAGE;
 		}
 		boot = true;
-- 
2.55.0

