Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B6EC88E7B
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18AA9405AB;
	Tue, 15 Sep 2026 12:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wL9KBrKHlgAQ; Tue, 15 Sep 2026 12:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 57B534050E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789476816;
	b=s+d5LeSk59EjNJXd9y/HFYugMdvDs9hP5LfAcGytp7ByQkPbOcNj8Ts9jyBuUcScLGxF
	 LOwj2HeDLCYIDwNzFU1eFw4xUQEChHSnfqp8knNWRAH5mLZvM8+nAlLZNvE+kV3epOhac
	 b+mhDSsp4E39CIBXvcLzUuFzVtUjxeb0aoA6TOLbKh6Ls1KNaXwSNyI9I1F6lP6ktRrex
	 sy8txYg1h1HQcMjep4nac49yWRhqAarQgUd+4cNTwRpm6Cw1NMyV1kzwQrm/w1xlH5nAW
	 KEqoFSSksgkMoCSeGCmHwXjMuNGpkDXiGbMFaxrTC/7LBYMvQaxsSJ46oKHws1p4Klw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
	b=cmG7oE9toB7SxcAiBPbs2xYq63/fueqMh7Yapq/glKW7DmHtsmW5oxBcGDYK+u/X0iDO
	 MoHbzcvRiXu3hKsXL43EcEoIwO1SpAhkXIuaeYF9fh2lSCirWkHD9PAEJKbFofETW0Qjd
	 PGwnBmIYWPnZwhDgWAU82b+xloxsKBE8AEnjB9QKyYdlQdMQpk3BBaELO6pDL6y3HZFRy
	 /gIJ60j9IxvtkFypJ5+lHrIC3GFaN86Kyg4iBXvKbe+tcJ/nclkLVVovLMErKSFWLLYjK
	 A+28KjNVhT60KnBnbEfJBtTMrNO7FLYUBGFQ6uRJFjxIUwv3GSFazgaCL1jdvjczOzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789476816;
	bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lgtcQH5617SUE00okL0krlLUqf01y6hX8dSlZF7qj3BtXOXL7pOxPwTIyZriV5nQ9
	 sZycpI53FXK0Fto6BT9yiEIT0EVYXsOGWHscpsg1o/pizU7vXEY5IfzDMSqQaMXUDu
	 cbU51oj1F/hZZ3RqW0DLkDcZgE2EmyYXe4qYdm4D2ObNWIZqYAP3ptlgVwFiSMM2u/
	 jjx3IS3AAloLsY9nv0LjHAzKfqnTj+rllWjYYhpJ0ZiXyYG0m6VVndhb3MOIWjO4V5
	 82EW/qFAAVZMcIGaU/LB4EEd7c0AzjP3j+ol2bbTHTpzwtxH3fSbBd7v5GPX7X/tDX
	 pXl4tGgQlQRmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57B534050E;
	Tue, 15 Sep 2026 12:53:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A85BE259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A65506074D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kF7XYWPI3RFX for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B42EC6075A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476811;
 b=iPc2nJA5A+bcIqrA+Mehoxh1jXIsYtpsozNbDeXB0KUuAIpFSjJxdC45FkGB7C0qZUvC
 O6w0CJs+6BED+sllJ6g6yP3vDQSJq+LXoX4UQL77mozGBB2eyDbWG6RrT77Es23LvOwwQ
 ZCpr4H1hwzIHMrTgiIuttCU4N9sCECLzW81J9e0J7h60RefOIFP6A5i0RjjjJBQpeFmnw
 wS2NpCsLO20kxH8hw6PBCJlSHuLOGdy4W5jOb5lsoUXaYAR3KqcHQj4hjz33e0YU1XT8R
 Y8o0k3gHJ1epbLdzdB3PmbmCeyO081MjuBaJINNONviOd/89OQAFqy3HfbaLfgPFGAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476811;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status;
 bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
 b=L5Gh9Lk2oAGrErhnpmJPoInRyO7tqgU+FuwPWSP11hZrjifdrXXZMAHNwb+EH321hV9y
 0VYvGachz2HAh10VBYqD4kB7XfzSWBPwQZCdibgpXfRgEEbxPIW2+GnoCn6HRRQLb2ChO
 +/ICqDPiVT31XM7ZS7kArhKsvo+U7pmOB6VTWk/TbU1eqPMmS2prFX1xlOIZPw0EpzFeG
 OgQK7BHigQV/P0wknH6uEZ54PbLp3N0QYWhpIqWwrTpcAAoU2R1+YdCxBBXOfsMB8PTlH
 UdQMo2oAFxXly2YkDpPsN0nGE1Kv391FwHQg+XFuES1lTC2zOAKuGbsdIM2OQ9VNqCQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 spf=fail smtp.mailfrom=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=elAdJnhU; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ludwig.nussel@siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=elAdJnhU
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B42EC6075A
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43465847EC; Tue, 15 Sep 2026 14:53:26 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B88B0847E5
 for <u-boot@lists.denx.de>; Tue, 15 Sep 2026 14:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.b="elAdJnhU"; dkim-atps=neutral
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20260915125323f3316e015200020768 for <u-boot@lists.denx.de>;
 Tue, 15 Sep 2026 14:53:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/mjSAG7FfxXr94Nc/5mjzDI9tmaoX7hWq0Fdk8OcwXg=;
 b=elAdJnhUI0uzzXvECMC89Z3EML59ueGBU2i3kQLKHTAn8bObKEIMkkPaRDBTPnbpvgzGEq
 WmDK4YYvgv8oAK5H3vRCHKseo7rGuXRO65fS1BFAmdjblHg4ZimiQeu2wFbOJtToxlm++4j2
 S2QpwN+Qf0RvGlHM0VhUCB+PI4hfJGKdFFZLhXFt/UXic31MLuu7cLD3hKdkTTWIGabBu37p
 kkEvJU/70ohGOpnlQ4rq8+aQZL+coGECZFFL+bUWOX+g0tQaBWeLaM73dTkBjjdyxd7ay61U
 fXiJoQJYKUT0iGUxd/3J8lmWgHhfCqAjCFeU/PYsWRexb5k1NfSYKT4w==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v9 3/8] mkimage: define log_err and log_info
Date: Tue, 15 Sep 2026 14:52:14 +0200
Message-ID: <20260915145217.v9.3.2405ba52fddd2e9ff1bbc24585e1e3140f660637@changeid>
In-Reply-To: <20260915125317.180911-1-ludwig.nussel@siemens.com>
References: <20260915125317.180911-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

Define log_err and log_info centrally in mkimage.h so any file used in
this context benefits from it.

This patch is in preparation for a change in image-fit-sig.c in the
next patch.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v4)

Changes in v4:
- fix and reword comment

Changes in v3:
- make log_err use stdout too

 boot/image-pre-load.c | 3 ---
 tools/mkimage.h       | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index 2f851ebb28c..cd319ddb777 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -35,9 +35,6 @@ ulong image_load_offset;
  */
 static struct image_sig_info *host_info;
 
-#define log_info(fmt, args...)	printf(fmt, ##args)
-#define log_err(fmt, args...)	printf(fmt, ##args)
-
 void image_pre_load_sig_set_info(struct image_sig_info *info)
 {
 	host_info = info;
diff --git a/tools/mkimage.h b/tools/mkimage.h
index 5d6bcc9301a..d8d292a8098 100644
--- a/tools/mkimage.h
+++ b/tools/mkimage.h
@@ -31,6 +31,12 @@
 #endif /* MKIMAGE_DEBUG */
 
 #define log_debug(fmt, args...)	debug(fmt, ##args)
+#define log_info(fmt, args...)	printf(fmt, ##args)
+/*
+ * Use stdout rather than stderr so error messages stay
+ * interleaved with normal output in the order produced.
+ */
+#define log_err(fmt, args...)	printf(fmt, ##args)
 
 static inline void *map_sysmem(ulong paddr, unsigned long len)
 {
-- 
2.43.0

