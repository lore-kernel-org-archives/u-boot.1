Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DAF606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 05:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qjyAyGjK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=cCKFObL0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D2D940DBF;
	Fri, 20 Nov 2026 05:19:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IsPTAmUsISCu; Fri, 20 Nov 2026 05:19:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 972A740A29
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795151997;
	b=cDZgrhEyFGmlJJQIXcrEEUWmoFuR8xsqsz9+E9LxhM7OZZmbbSDrqk01kZD1Vo2Lgm0z
	 rMKixmxuUxe5LO40NP/CnN+Y7vpF74QrQ0Y342EEAjPgaSuDQDLYZTEdJRUUAbEF4Et6o
	 UQh3DAUoqxzBz3AUZMcE7t7wc1tYRSoOuudebI2HVM7m6xiQ/v08/zU9587gxj3Lxcw/q
	 yGZl7oMO/yi6MtnYbQ6qAL38nJgDn74ixcpoSilajeBYU2WGJOz/VcJjZD9sDAABiUrjZ
	 bH40yJVrHUCN3gJRpurgbqGZfH5hwSZR9pFGotxRTd6kWnLhM/+FJgWswNB2nEHvLUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795151997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f/i/o58Trbpe7nE2l8xNoJ24j+r6MH0VI7QMlYbT/ck=;
	b=Ak+GCdEANd+Jy5B9sosd2tXxNQa6BzFa5JDb2NpPo6mOPQh+4Wa6qmvyr/z2izGRyabD
	 hqIQFymBNZyAvJX598viscfg6lUEB0nU2WEw3/Blba8unn3iAhkIybNlyGH/beoLZzhKz
	 gWZ8SmnhfwzRmH5FPQTov3ZPh1a1rIwLLcAygqt0GpwCfb1SCQ4KrD1uy/8s3NIewcr7l
	 eaQBDS3WZOYCJOIGXJZC34/xM0yScoXrS1U4wyNBQD8IeIRHEyiqSX14+pWrqevjLXkih
	 UlUC3G6NaBeFPB8NZIzqHak7Ht5iRUX13Odjz0QVqDSQRwX2OaPTPokYGth/T+cJraQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=cCKFObL0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795151997;
	bh=f/i/o58Trbpe7nE2l8xNoJ24j+r6MH0VI7QMlYbT/ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qjyAyGjKItu96U7+aoEIJQiwoCGdziBHuaXr1jyUIsymvd6bqaLJ9M1eMjPKppSAz
	 3DlDr/CwuNCjm/ofA4fUxSdIyQMEr6dDfAm3TpXWQrcHelUcQmjQl+1tNZULGAAS80
	 ZlZEaoSDgoeACWpJ2BsZ5o02dLAkLXAiF+SoSUpVt5c3rkjX1AYblxT4pNVryNfFh1
	 TCE35POBWwOfRCLO8b8vXqBnox6LL8ZTJO5VjlDL3nV/a6DWdHPFQ8anV9qDx10+/j
	 Z3yjZzO4zj9bQbVQv1hbOXR4J6JkdlDHaZNyBaf3N0e5ZdjDAhK3jtrVNjTdbas7Ec
	 TP03tB5+5jVXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 972A740A29;
	Fri, 20 Nov 2026 05:19:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AE47D260
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B51540A29
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:19:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PXM-h6abIn6O for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 05:19:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E4B6D40757
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=cCKFObL0
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4B6D40757
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:19:54 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=cCKFObL0upl7m7vUG5zdcDuvMtE4KJ0IKkT7SA0pfahbPwo3+fjdvAw5iPp0sRd5dW/JBytKKcWMY/rmi5UpaONWkzRAFqN1StVWj79Tw66pCYaoQ8Nu2SjhsAEshuxbFWYy6r7QgGUY2+WwcIY5cWjAsKpsvid+QUdGqlmUiIk=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=f/i/o58Trbpe7nE2l8xNoJ24j+r6MH0VI7QMlYbT/ck=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795151983848925.3027650034192;
 Thu, 19 Nov 2026 21:19:43 -0800 (PST)
Date: Fri, 20 Nov 2026 05:19:34 +0000
From: Yao Zi <me@ziyao.cc>
To: Martin Husemann <martin@NetBSD.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: Re: StarFive VisionFive 2: NVME not responding randomly
Message-ID: <av_YZuRD4BW2Qvrz@pie>
References: <avxWs2PzYcvPidNw@big-apple.aprisoft.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avxWs2PzYcvPidNw@big-apple.aprisoft.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.7.7.1.5.4/294.473.96
X-ZohoMailClient: External
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

On Tue, Nov 17, 2026 at 02:29:23PM +0100, Martin Husemann wrote:
> Hi folks,
> 
> I boot my StarFive VisionFive 2 from NVME usually, but "sometimes"
> (which is actually qite often) u-boot does not recognize the NVME
> and can't read the partition.
> 
> Full boot lo of a working boot below. When it doesn't work it
> says:
> 
> [..]
> USB XHCI 1.00
> Bus xhci_pci: 2 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> Working FDT set to ff6f4430
> Hit any key to stop autoboot: 0
> Card did not respond to voltage select! : -110
> Card did not respond to voltage select! : -110
>     <------- all normal untill here, now the difference starts:
> ** Invalid partition 1 **
> Couldn't find partition nvme 0:1
> ** Invalid partition 1 **
> Couldn't find partition nvme 0:1
> Cannot persist EFI variables without system partition
> ** Invalid partition 1 **
> Couldn't find partition nvme 0:1
> ** Invalid partition 1 **
> Couldn't find partition nvme 0:1
> ** Booting bootflow '<NULL>' with efi_mgr
> Loading Boot0000 'nvme 0' failed
> EFI boot manager: Cannot load any image
> Boot failed (err=-14)
> 
> 
> I tried everything obvious: software reset, reset button, removing power for
> a minute - nothing made a difference. Sometime later it just works again.

Does this series[1] work for you?

> I can build a debug version, but would like to hear some hints what
> debug stuff I should enable for that, or any hints where to look.
> 
> Thanks,
> 
> Martin

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.

[1]: https://lore.kernel.org/u-boot/20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net/
