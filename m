Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E402CA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 19:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32906606F0;
	Mon, 12 Oct 2026 19:20:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DLTZ_frpPmwZ; Mon, 12 Oct 2026 19:20:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B72C60680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791832845;
	b=nHdpEKVOyh0WkXzRfeJogx0sgkOkKmzaoek6l+c4AbEkmLQ4xPSy4k6J5dePLYADdjIy
	 rZMh0xk1AzLPUxfyL2kNUFbJldcSbCXvFxWiFbACQEiuW/WxHmTg5ulgTcok/pXeSOnjy
	 j1kYGxysXc3UCqvMvrdJg/nVT33R6P+mfhKJk94e+xnMN+J70h3XRZMiGyICxzqoT7tyc
	 x8eCUZitNT9+KRBjpNG8RAhDEXSMZhz1eWeu2dMnqBsYU574vHY1A8f5osEOwZ3HuIVgi
	 VPDXs6Q3PLG1zLil+61VyqPVK0LE5PHpaPX+5vQ3859z0C4vaqQoO8ewmUQ2A7IJm0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791832845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6Ednm0BZPeDXz66sZaYUun+CuCH7wdMQtcPxFcuIATY=;
	b=moW3l/uHfnqH7sAox91X0CCNmOApy7qobdfSSYnB+UqSvztW2bdMO4ik8NChiUX3at4o
	 6Hdpclwe0bzFJN9+iHuXNyN2ZY76abyjAiqJ+u5ELY6rdf18vOrKD2rM5l6ZziJ6Ep/sr
	 IZ9LBI1Nh506zD2EyARQr6coRxDyFXFKLPk0U0voyV6X7d7bZ4d3XnPA8+oUL5Td8j6sI
	 ScyNpDFulkVg2aCGK/rqAEhHuzL5rptiPPHy9thuJBP9Qr8OYDdA1uDb115dukqcvJm0S
	 ec0dfWrJIdRFk5WRfWXaRYnVSRPA5qnhhL2iAa4mwVMP24UFtgp5SMjiiPLyP5clCMQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=LMSZRgeT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791832845;
	bh=6Ednm0BZPeDXz66sZaYUun+CuCH7wdMQtcPxFcuIATY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZrQy0BuVM/e4QNtz+vYrEJZ5/VMjEpDrqP8NBQ24tlUYSwHQp+gP5yQ2oqSRTEGhB
	 qM7CIftVj+hmuZaiflIJon0fKyGq5pZyv/FqhreaJje8aCo2W8UJ/KU8qvTpvvYol1
	 BsfhMGuvHzBmVsPQaO/ycinPYhdOD8Ck5h02k4rlG3EV4t3UlN0sbeGGp1ZU94ODKB
	 nb4icw6KsVZxA31aszsHJZNdc2HgEfqhj1r3qaqpAiyJzlY34jDTJHJVLFxijI80gW
	 pQMuNOQbk+fQK6PYu09z5Mp8k6EAh54XAznZPbA6mekEaQb4po21qp3+VgZmx3Mg+x
	 at7WuByYl1keA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B72C60680;
	Mon, 12 Oct 2026 19:20:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 01C972A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC6B860680
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:20:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4OV3B-yhZUqX for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 19:20:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C63F60667
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791832843;
 b=qnr9Z2iPiv/fFI8DxJ5wc/ecYeLO2i436p9zEftf5wHI8a3sk60Gh8ArYVWQtwxzLRa9
 SvEkTzPCAOSu5jEG6xJiOYF4PbYRTJ5ExZ5GWWKLJ+2SBsJkxS7fEfJ/wd4Z1JG+dY+ua
 9h3X/Sl7JEWIUQA/K35wEVIEC3kLl/bKpNmhFPEOeSCmnfvDt6qizj/iC2Q6GLjgPAHOf
 KgwIhQHuwdX/6SCiimoHE0wOYLJvILJMKzamdTFajqHeCvZ76zk3vUCx8x3SSdlJwQGv6
 Hr7FQzHxkDZBhKMqT9sShi3OMVjaJ8SgCJclDwmi7gIA13EJjXzt3A+Zi7zKSxoOboA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791832843;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=6Ednm0BZPeDXz66sZaYUun+CuCH7wdMQtcPxFcuIATY=;
 b=jZ99k3+NNHTWNditE9uxr/hpjvocPyfVYIOIfCVMZx9jr2XQUg8WfNJwYT9Tfb5IFyl1
 hZvKQPDrKTwulDqkAJLHg90axnRtWKn583C8p7EuTTcILYTE+YE4IT25fv8MCJJvLZS/u
 h8bMRQD8l7+6zmJOApD/dxYRY6/V0sgRxfiTd42ZlkeUL1TRpa+wiXDirtxKhhzP6MuvM
 dZ9b/TJlSJIT9CPzwmddVF0q/TpNAsqqlmNtXhfo9mIYsr6VPuv8Xz0bJS8+OpnqlXH8a
 5oSagqah5Ii1WCUJCG0Q+7yGUe4RI6ZwGJSvlMiCw+9hIOpEmZoDtt0nRKPcMuUvxzg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linux.microsoft.com;
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=LMSZRgeT; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=LMSZRgeT
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C63F60667
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:20:42 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id 360D420B7166; Mon, 12 Oct 2026 12:20:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 360D420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791832839;
 bh=6Ednm0BZPeDXz66sZaYUun+CuCH7wdMQtcPxFcuIATY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LMSZRgeTyvfO+RZN2m333YgBBSVl29bTTCTRBZZXFeUgYl+hGTLyHmJ66xmwX7bu5
 cMV6kORhTXQvQeTXxBQAOuPWIiiogvqqZgeIXnTlO9anyrrHYtev3PWAZGUpTId5K9
 0+fkrDykLqBOKAQkcjL2byvFOUkjavMSXHEMTiO0=
Date: Mon, 12 Oct 2026 12:20:39 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>
Subject: Re: (subset) [PATCH v2 0/3] Bounds hardening in NFS, TFTP and ext4
Message-ID: <as0zB9XpmfOK7CtP@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
 <179081761139.570197.9802971587834247609.b4-ty@konsulko.com>
 <ar6Ag0tw4KYUrgev@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar6Ag0tw4KYUrgev@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

On Thu, Oct 01, 2026 at 08:47:15AM -0700, Sriram Sriram wrote:
> On Wed, Sep 30, 2026 at 07:20:11PM -0600, Tom Rini wrote:
> > On Tue, 15 Sep 2026 13:52:07 -0700, Sriram Sriram wrote:
> > 
> > > Three independent hardening fixes found by internal static analysis and
> > > code review. They do not depend on each other.
> > > 
> > > Changes in v2:
> > >  - Dropped "boot: image-fit: add overflow guard for FIT decompression
> > >    buffer" (2/4 in v1). As Tom pointed out, max_decomp_len is used both
> > >    as the allocation size and as the unc_len bound handed to
> > >    image_decomp(), so a wrapped multiply cannot leave the bound larger
> > >    than the buffer, and image_decomp() already fails cleanly on a bound
> > >    that is too small. The claim in that commit message was wrong, so the
> > >    patch is withdrawn rather than reworded.
> > >  - net: tftp: replaced the four bounded strncasecmp() comparisons with a
> > >    single check that the packet ends in a NUL, per Tom's review. It is
> > >    smaller (+16 bytes of .text on am335x_evm_defconfig instead of +24)
> > >    and it also covers the dectoul() calls, which v1 left unbounded.
> > >    Retitled to match.
> > >  - Rebased onto current master (a44f46af0aa).
> > >  - No change to the NFS and ext4 patches.
> > > 
> > > [...]
> > 
> > Applied to u-boot/next, thanks!
> > 
> > [3/3] fs: ext4: widen ext4fs_update() block-group loop counter
> >       commit: 1c1b6c2b2ae03912007ed2ffd361f43b7c2e5401
> > -- 
> > Tom
> >
> Great! Thank you.
> 
> Regards,
> Sriram
>
Hi Tom,

Just following up on the other two patches. I see that Jerome reviewed
them on Sep 17th, but they haven't been applied yet. Is anything else
needed for those patches?

Regards,
Sriram  
