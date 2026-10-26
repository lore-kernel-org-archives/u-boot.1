Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49D606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xoj47/kJ;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=GzT7fBUh;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=oMEHWkNb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B64BE80963;
	Mon, 26 Oct 2026 22:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sFdMC-cSGenF; Mon, 26 Oct 2026 22:55:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0EE9080C0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055317;
	b=Jpb9g0Q7z8z4onSmu2ul5q/cOfH6p+5e8wpSAQHU3TccNXq6mfyAwF/6ZvtFuljaV/Av
	 eqm8N+idfuWCS4BfI1BCAbMDNDT5x6uvPIR+r+lNcy5+iS1ffD2UoVhLS0lL0LjlHtASy
	 6btPUm0aDYwRscQyADTI/ik4sZ+NsBlkwcyE6j8//1Lz2NdWGYnyRxFUwYJhvsYmCoByp
	 STCNyU8UDEkVfagydyxSkcDA14joN1VWp+bNJZ7u9rZqRX5X6QFCX+/r6kka8gdxGudos
	 +cXCTUeSmK2R7tWUuQT2HGBAVyhvpYVFlZgyNMPoT9K7Er88tFxzYjxhaCKMg2l2UAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055317;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iNrnDuupsXnvwxz6415IOR50Vf4aFrV07Iafxs/k1h8=;
	b=tBy6CkcLQ2585z2yqq09gz3+RTHgTEOTv2wncL60a5dS0FTplzOisiwWYJ5y3fqQS4Dt
	 bk5/Umgt1DxmShygIb7fbsPB8JC+pKujfPfs+bvbJpvmuhbI39Rto50CsIv/4utgbACiL
	 CLntEjTk4LIvwZh9dx8fbVCjfCvT23hJD6WnVn/EbPnoCMfTmLkmabI2P7HJe2NpNeyGz
	 9Hjgpxgi0NHdIBAfWzFsyeIAv4Z3c9IiYuZyJJZ2SB6Q0pKeYviA4gZi1XVQm3cSqO/yO
	 JbQE6XfbAehl17YFY96gyCkRgSdrLOGLFjalQp8cNTzLkRY5DftwI1ln2o7eE7bTr0w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055317;
	bh=iNrnDuupsXnvwxz6415IOR50Vf4aFrV07Iafxs/k1h8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xoj47/kJg/QdNfRX/SBYNNeFWl/ssFHWc7tVTKtpXH11mzOzBmT0VqwSNYSEQJMNq
	 RvAKpfPDxGl1tqokYAz5qBmAz9eFh4Qs0oJJMa393rKkQakD8DU3x2wZaqcZgqteJL
	 JN8vXuIBIsj1zE2LhP50m1WMaJVJ3tZJw1xVC8Bjb+oEg+2wwbQGFhuHGmRwHiHd3H
	 t85LaoG1SRbgUpBnTAU1k2XLYdhJ04mwOUdFIwuH06fHsSO/RZ2j+OScE3vqSREHJT
	 V5tejHe7qLjpZFYWwjiHjmuktqEDwM1QkJDob889Sen87tR2De+4lusNmvcepw1cV3
	 dS6wnW3vEo7ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EE9080C0D;
	Mon, 26 Oct 2026 22:55:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC4FA2AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9DFDF40075
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7BVXqQoH47Ge for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0F80340062
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=69.169.224.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055308;
 b=WcawIwNkuFCT2LptujOfQPEHD7wId9s6qaT3ZOMfHZlcNqvhnQ8IL60RLnYJevDYR9LE
 9k6dW1TGkQiGw3zsvniRB6sbDTHfUwIxzR4pgLRvTI/a+XfyUC5H9YzIFM/CduPfk2poj
 yOUF7ip55PglfVZfTsmOb0rFFhg15RHqzmINbrNp5IQa6PYvzxpz6OmhIgZGfZdVSIsUt
 nZ9zRAQ1fik2hWaYFOiRsZAOX2udYP8htq7tHCfd6GFv2DGfZcAW5TzU8qXs44QLJduvA
 4et+DL0xdgVfL0OSsdwSzS1QvAEBtBDLKccA/K03yvXosBxP14aqk/qXsJqYIb4MQgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055308;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=iNrnDuupsXnvwxz6415IOR50Vf4aFrV07Iafxs/k1h8=;
 b=bBCINLh1lrq2XH84T2/jOBuE2zpp1/hXwSDr/tQDhv/Gd2LeEWPJNkqq8iai7B0iyPIW
 DVM5NITaHciIhj+tAxcWsGf+0dnDZwV95kgSks9t8Mqb1ZT0r6QCQh1GKngoV+Wf5rLip
 mKHDLRuQ2VhmhHHmgjfRVRWgAQYOR5TsmVWC5N3VZCOWMGK9hOdQfQhodsFv5pHY2FzXq
 99LoBBPrjowvuK9yeCRxbWpbRtW0DNWq6qQxjcCr5EKpU7c4ZV1WlDidRU+jPg0d3HPM4
 REheU6gXqnpg0sHl0CNt7gokLbqVCpHgGU50oTXNeYoQ+5+biM7w1a9qYR0IHq2L5qg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=GzT7fBUh; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=oMEHWkNb; 
 arc=none smtp.remote-ip=69.169.224.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.7;
 helo=b224-7.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6cac1f-c5bfbcfc-71ce-4b69-bcc0-042fe21042de-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=GzT7fBUh; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=oMEHWkNb
Received: from b224-7.smtp-out.eu-central-1.amazonses.com
 (b224-7.smtp-out.eu-central-1.amazonses.com [69.169.224.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F80340062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055304;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=83BC8P3/S4yjsomALlL8VfbHLNZQM26EYLfEOoFqzq8=;
 b=GzT7fBUhX7BOLVji9fC8ahfiJpiCQJgyBBzakWgOg1A3NFP2jDkALCJmZgWP2zAb
 rzjXW+nUUERW1vE1HSbVzF4AKBHc1zFlxC11fPjqUPmE/tVMOQnoq0rimUE2KvS4Mp8
 m8S1HYEkxPdjzdHRltjl0gKi6JQzcab/euOPXpHdMYezv0Ky5q+4yLLkAOTW/w2mCSM
 bhHm9Pw+4Ion7ltXcmtCau77FSHnfJlJg8YXIaDSc5eFq5JMX5LGASZUemBOYqZZXjY
 l2FyYIg9jF/qUyt08oSS3xlIUnZ5IZs4WfpuIUYHsFr/JiOJgd55r7knWmSKsz7qqtH
 PzT8ajCAhA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055304;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=83BC8P3/S4yjsomALlL8VfbHLNZQM26EYLfEOoFqzq8=;
 b=oMEHWkNbeQV5p56c4Br7mFXMGS34e+ETFjP7djJ/GJbmjMq38yjB6+tb8n2tjFyl
 l03vX21sr9EIGd70wOIdTneHeQCJDAKGPWoutGstMqQcc0UeoPOWi+Z/XvMSrHLNdC+
 wAXHwaup33+O7RVw9KGJ3a0gxaZ4PFaiZrsI0tS8=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:04 +0000
Subject: [PATCH v2 03/14] ARM1176: Add support for
 SKIP_LOWLEVEL_INIT/SKIP_LOWLEVEL_INIT_ONLY
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6cac1f-c5bfbcfc-71ce-4b69-bcc0-042fe21042de-000000@eu-central-1.amazonses.com>
References: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
In-Reply-To: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Vencislav Atanasov <user890104@freemyipod.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=1006;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=83BC8P3/S4yjsomALlL8VfbHLNZQM26EYLfEOoFqzq8=;
 b=abIUGROsjR/76TEUWCFhPyrsJkPuDfXhINvZzQkBjR+c+3EN4SUsm8Ge9VuCnT9ZBtSiHjn1+
 PnzwQMGrGpoDNhzRk1p/DTZXKPeuo/jojL94tds+3QGOXmuv2asft52
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.7
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

Boards which don't need any init code can define it.

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/cpu/arm1176/start.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/cpu/arm1176/start.S b/arch/arm/cpu/arm1176/start.S
index 7bdcb5fb97b..10f5706ccf1 100644
--- a/arch/arm/cpu/arm1176/start.S
+++ b/arch/arm/cpu/arm1176/start.S
@@ -91,6 +91,7 @@ pie_fixup_done:
  *
  *************************************************************************
  */
+#if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
 	/*
 	 * we do sys-critical inits only at reboot,
 	 * not when booting from ram!
@@ -136,7 +137,10 @@ mmu_disable_phys:
 	/*
 	 * Go setup Memory and board specific bits prior to relocation.
 	 */
+#if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT_ONLY)
 	bl	lowlevel_init		/* go setup pll,mux,memory */
+#endif /* CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT_ONLY) */
+#endif /* CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT) */
 
 	bl	_main
 

-- 
Git-157)

