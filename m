Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F96C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 11:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C04281114;
	Fri, 24 Jul 2026 11:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jor4EcaTgtHu; Fri, 24 Jul 2026 11:00:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E0C880F93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784890823;
	bh=b75rh3/GKvt06u/kwaMdR3+bi17X3G5OU2aVqAOC25Y=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=BoCKP5KArq7ZhaWA0P5ZzO4EzaCKiaZIdNF4h6GAUxt9r9OVH440b+ir7ICDHpY31
	 c1doNYSuCCYVr2reOjozhusAsf0DKBt+51h1ZmYIwcgQA1rPP/Mw2wKbqLpBPqoEct
	 Hp9QeINJYkAx5AX5tJmw+/Ap1hRFPKL2ClbMQ2m0uJ3ZENIUoaRMM1w41/GaSCXpFd
	 1UyICscOgGMxBfdqST4074xbCDdKKt3nle+p+81qx1G9eXlz66QQ2kjeLsCf3BtD0F
	 UPf6WvJxa+rAIw5BrLrrayXDtVUlLY1ksQNRMquEGnDAvl/FKLlKvO9adUPubxRiel
	 jH/RlM2eQFv+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E0C880F93;
	Fri, 24 Jul 2026 11:00:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 05E41347
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DFCAA80F93
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Rw84VNmd5Tm for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 11:00:22 +0000 (UTC)
X-Greylist: delayed 318 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 24 Jul 2026 11:00:21 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 04D1580F79
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04D1580F79
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::bc0f; helo=smtp-bc0f.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::bc0f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04D1580F79
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:00:21 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h64dK4lL2zLXF;
 Fri, 24 Jul 2026 12:55:01 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4h64dK00RKzLjt; Fri, 24 Jul 2026 12:55:00 +0200 (CEST)
Date: Fri, 24 Jul 2026 12:54:45 +0200
Subject: [PATCH] .mailmap: map the old U-Boot mailing list address to the
 new one
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-new-ml-mailmap-v1-1-b65a436e23a1@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMT3bzUct3cHN3cxMyc3MQC3UQLy7QUy2RT00STNCWgpoKi1LTMCrC
 B0bEQfnFpUlZqcgnIFKXaWgAJx22ocgAAAA==
X-Change-ID: 20260724-new-ml-mailmap-a89fd9c55a4f
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1784890501;
 bh=b75rh3/GKvt06u/kwaMdR3+bi17X3G5OU2aVqAOC25Y=;
 h=From:Date:Subject:To:Cc:From;
 b=lLZqgln5j4r0NDriLh+IjKCv8yGGnXrBYrQ7srTEcp3BUPXKWs6VxB0qin7UQ47YX
 09BlDa63S3Nd82vg7IWfJ8/FPaEYaP5FierRIUrftRkGEbnoBOlLUnsEc2aLtlL2ob
 Ekh05UWmuz1IF8zik8sgu1WOj8kUy1n/mRgw3CBdDiH6xfZSvwowo4RnvVguEbqbpp
 3m+++W+f/f9Dq2aOl4A3NJfcqTunyqZl/HfymwheJ0XmLeyxuZlfa+qFCRUj8GsdJ7
 0Id0H+o3hkHq94dR31tXpNSw+jZ1B+qeVvWDUfO8zRYxb479wexreeYVeQnBsPvqzl
 CcBZs/WPY9fKg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=lLZqgln5
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <foss+uboot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Quentin Schulz <quentin.schulz@cherry.de>

We have a new mailing list but the old one still forwards to the new
one, although some people (including me) have issues with the forward
and their mails to the old mailing list being dropped due to SPF policy.

Add an entry in .mailmap so that Cc: u-boot@lists.denx.de in "old"
cover letters and patches use the new mailing list address.

Tested with b4 ty --dry-run on a series from the old mailing list.

Tested with a Cc: u-boot@lists.denx.de in a commit log with b4 (b4
send), git-format-patch and git-send-email somehow don't seem to be
respecting this mapping. At least one tool (the one we now recommend)
does the right thing, so it's progress :)

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 76ba0a7fea30..3e8822703f30 100644
--- a/.mailmap
+++ b/.mailmap
@@ -16,6 +16,7 @@
 # Proper Name <proper@email.xx> Commit Name <commit@email.xx>
 
 <duje@dujemihanovic.xyz> <duje.mihanovic@skole.hr>
+<u-boot@lists.u-boot-project.org> <u-boot@lists.denx.de>
 AKASHI Takahiro <akashi.tkhro@gmail.com> <takahiro.akashi@linaro.org>
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com> Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
 Alexander Graf <agraf@csgraf.de> <agraf@suse.de>

---
base-commit: d7ef23c07b8e34f65b3e15e3b4e7f58d074923c8
change-id: 20260724-new-ml-mailmap-a89fd9c55a4f

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

