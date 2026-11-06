Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47861606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ivXiasqU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=TgIDOeD3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B81F1608EB;
	Fri,  6 Nov 2026 22:40:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Hl1jX-kEPeL; Fri,  6 Nov 2026 22:40:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D74CE608E2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794004855;
	b=ADjgP7BgUObrSHiIz5hOOG7BZQ0vagUzRS6l7F1b6wjUqKtdBfD6+PiKNwAe4akpQ54h
	 WPegkZT7nCpdw1bO5L/LgPFH4GnlmB6uonvNQl1UlrRtix1WpGihlyPDPe1FaGhoKPwuC
	 EIGV/xFtvmxrZP6uoWCGabKTFDXhksdZOtFFR6BfVHBa+YexR7o0J26+0lbwjbkWKMe9H
	 t/eajyy+IEcLbUKwmyKSQiXrsoX7WQq7LOQINFqGVITOrLfkJF47n9d4nc0p19EWaJHSZ
	 whEgDJkHsuqFF6CZKieq9CNQSFGbg9UjVvqyRiu5kOOMTTpmT+qQxAQq5/NoDKw87FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794004855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DKXxm/xsTb3YVa9x34NlbGPXNCAyuNKU0Vc53vJ3Gp8=;
	b=GhZ11aHmvrbYIdaN4z4myXWFNoxa0q6U4zux2ENn2tuBFlyAlJiji0Fexi2o8MylcGXz
	 a/bxWrObEb+q3nXzm+lGCPyxVa1MjOs24cyiIY3jwa6a7p99jQSA+S8jNgW7sDRigQ6ni
	 Vi6qB4ARf7ne+3quh7SwPcwZuZ4YYrYMoZz7f7k2e2rA0I9yW0cRUjbZFuZRM69XqfgQ3
	 ZPaLmNz4n00yeqTHrb886o70cx+IEETcx1UdzK3igQh1W8gTvDuPu8WNlEKc1A6N+UD3g
	 CsUgNOMEM9nX+920cB3k1wzMEI4yk7yUbFBaedRRRwEUlbw2I9JbytHeNAheJN7yU6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794004855;
	bh=DKXxm/xsTb3YVa9x34NlbGPXNCAyuNKU0Vc53vJ3Gp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ivXiasqUSE9bY+h4k7pAHMPiptwreb3T1Jfo5NIhR8qE6dsZbZiIQnqCk6opu9EKq
	 bViD1OinvOz/oog0WBPWtKY0SHmkDRq27WWYZ8EWjdmGR9bSyL10iS3R9YvWtbGBCv
	 5NCmM+wWld+g8lRxhbh/OlEoZmYhtLWCe6KeKg4iRsOnL0uzRoMlo+Wr+Zl57bljxw
	 i3UrAK44e8lz5NnndxDVygtDFGBRl52xB9scpVCb53GKvwQMytKuBN9xg+scZ/TJdC
	 01l+FDd3t2bgB9La0+vmw04us+6pfbO57VRdX26LvLDiAz+ZliyrLVIcfbmGOxP4XV
	 BoSEjRVUIDgmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D74CE608E2;
	Fri,  6 Nov 2026 22:40:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9941B31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96A7C40907
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:40:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yCLVi1hHlPnE for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 22:40:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3673F408FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.17;
 helo=sender-op-o17.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=TgIDOeD3
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3673F408FB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:40:49 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=TgIDOeD3q7viQ8i6tMtmGjTK16MXCTC00g8ZsotViEu1BkOw1b/lIhlrdWORh8WK2yZAJUBZt5JGOuX7hJA9KREpYFdS6z3Arp0OIrJv8+Y9vb+qvDyHvKQFH4eQOwUonZalQGUaEll07um4z8XeUywsIeBiSEHmVEMx5xNlMbI=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=DKXxm/xsTb3YVa9x34NlbGPXNCAyuNKU0Vc53vJ3Gp8=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794004840719345.4815333423769;
 Fri, 6 Nov 2026 23:40:40 +0100 (CET)
Date: Sat, 07 Nov 2026 00:40:39 +0200
From: Igor Velkov <iav@iav.lv>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: iav@iav.lv, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 3/4] lib: add a stream sink for block devices
Message-ID: <20261107-re-heinrich-wget-blk-3@iav.lv>
In-Reply-To: <8dbe616a-cc57-4697-af04-c36ddc26c79b@gmx.de>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <20261101-b4-wget-blk-r4-v1-3-e27a009e4043@iav.lv>
 <8dbe616a-cc57-4697-af04-c36ddc26c79b@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 20:18, Heinrich Schuchardt wrote:
> U-Boot runs single threaded without interrupts.
>
> Don't the TCP timeouts caused by writing to a block device make this
> streaming highly inefficient?
>
> What throuput do you reach on an embedded device. Not the sandbox.

No timeouts: wget calls altcp_recved() only after the sink returns,
so the TCP window holds the server back while the card is written.
ROCK Pi 4A, SD card: 9.1 MiB/s with a 4 MiB buffer (1862270976 bytes
in 3 min 16 s). Download to RAM (22.5-27.7 MiB/s) plus mmc write
(16.1 MiB/s) would take 174-189 s on the same board.

Compressed input is not in this series, but whatever replaces it
should leave room for it, and there timeouts do matter: a small chunk
can expand into a long write, and the server may drop the connection
on its send timeout. Two ways: reconnect with a Range request from the
received offset (simple), or buffer the input and reopen the window
in small steps while writing (much more complex). We'd prefer the
first.

Igor
