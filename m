Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1899BC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 23:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9A5940B5D;
	Thu, 30 Jul 2026 23:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id djrr_Po3CYWf; Thu, 30 Jul 2026 23:01:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3D0840B75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785452502;
	bh=xSdtTGQ1r/Xm7vWzWK0CxdhmHc3jr7z7daRnX8D4a1U=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=te+DttezECFDE2tjsysSTGm9rMKZ740VP3KKpprIq/l31TXQdc25Xe5s/RIfzAyDj
	 6gQgNfyEWN+xCkQnczh6/cabuPDDbme1RsRetq2orqGZAN2pppa1Gjmw441Ka6M0D0
	 s6nn8WrpdbjkZhPn5o5jFZdEz1v0rQSZs4MSMO5oGobr8n7Xwtc/sE6EVVqjSxrKcy
	 mRRkZyQjAigcfp4pfV6UiStkP8IMBVcTrhPC6aWIYTMEzaUuteYdmjWv3w9slVsO4q
	 8xkP2ix8q1Yto02BaQq84UKbvEzgcen6hNlJT0NJQrxfYlPsehTcQCK7W5+1oi/erB
	 UV1Q2MTVt0fuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3D0840B75;
	Thu, 30 Jul 2026 23:01:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 115B42CE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 23:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB80D60667
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 23:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NNRQ-Oc7-yjk for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 23:01:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.137.112.168;
 helo=mx0.gmx.wtf; envelope-from=u-boot@vicb.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CBC056065E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CBC056065E
Received: from mx0.gmx.wtf (mx0.gmx.wtf [203.137.112.168])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBC056065E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 23:01:39 +0000 (UTC)
Date: Fri, 31 Jul 2026 01:01:33 +0200
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Subject: Re: RK3399 TF-A hash verification failure for atf-3
Message-ID: <amvXzWK9xzUEFIxV@localhost>
References: <alujuCnNh13eRfdA@vicb.net>
 <56c497f8-4109-42a4-95df-7c0e0b6277e8@cherry.de>
 <CALeDE9N1GUu7z2vL4SG+JNyA32Ro207P1QQCPUuxz6QycJ-dGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9N1GUu7z2vL4SG+JNyA32Ro207P1QQCPUuxz6QycJ-dGA@mail.gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vicb.net; 
 s=f747d04263f05989; t=1785452497;
 bh=xSdtTGQ1r/Xm7vWzWK0CxdhmHc3jr7z7daRnX8D4a1U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FjDgDfZmS4gCf/E/1t009+n4IhslQogAwBrt0pf+otKLIEWMLtRzpwG0pk2Qsi+sc
 CA2Qatl9WBwBx8CcZSWpC3EcnIvV8pSDCRqf5fYiDtkxJFzQjloAu0rUl6wIaZSvjx
 JqtzeeKFy/HwGnov9D+VaY1n/bqy9wicPDU2u93gJ0s6c4us6PVFQ8vmcxwgXlkmeK
 xwUH4BECtUFZt0yfbP6traQdZ+BbQGiann+eRkmF0mOm59sEKgr8P2FwXatgfWrh8r
 yqWoqe4EOpJbiexhC4usYH5vRUvV1CiiyyA+7rjuQ/HzhtI3yfcHOprm76rejGJRXR
 pBjUElIg2R4fw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=vicb.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=vicb.net header.i=@vicb.net header.a=rsa-sha256
 header.s=f747d04263f05989 header.b=FjDgDfZm
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
From: Vic B via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Vic B <u-boot@vicb.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Jul 30, 2026 at 02:59:05PM +0100, Peter Robinson wrote:
> > Debian toolchain issue, reported to TF-A last year, see
> > https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/36981/comments/877be809_5abf10d8.
> > We wanted to rely on Debian upgrading at some point their TF-A, hitting
> > the same issue and working on it but it seems they are stuck on
> > lts-v2.12.1 (which is slightly concerning considering we're at
> > lts-v2.12.12 already) so this hasn't happened yet. I'm building on
> > Fedora and my company's CI has lts-v2.12 pinned to avoid this issue, so
> > I'm not going to be chasing this myself. Can you try to work this out
> > with Debian maybe? You're not the first, not the last I suspect either.
> 
> The distro team got to the bottom of the problem, it's an issue with
> the TF-A linker [1] not getting that CPU errata may well be enabled by
> default in a compiler options. The patch I think should apply to most
> branches of TF-A.
> 
> [1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/53010

Works like a charm, thanks!

Vic
