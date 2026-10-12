Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BA5CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 21:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B24D606F7;
	Mon, 12 Oct 2026 21:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1dJcvRaQCkxg; Mon, 12 Oct 2026 21:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B576605E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791839133;
	b=NCdTGIRh2SSAgqlDr+eWdmhr9wVdc8eGD87mAXMgdTFfpCmaLXk7KFYE/rkV0he+6Oc2
	 kDj2EuwDqd235hgayyAsGdv+GH2PhSjDbDrEqAzIYuMtoa3e4iKUqrYTI7jZ9BCLm13Mu
	 fr1qayYfjXOsHMROf6SCUdmZLqwHi67tv5kicJKGEdAgo48+ZDAp0372D/oXlQx/tdTlf
	 py3Sl0f4QyEeS0nZT8ELrdjWFCgIr5tlC3TohsydK4rWECK4kRQdOvuGjtZXnLZJL8QYh
	 ABT7wxwW0+qOZe75LOZFiDBXv9l8PU264v0T3y786OAPMo53EgvLdk5qIwN7QVTwo0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791839133;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZKFb7bltnKP8c1CUcmLgkeytxPlWYe1ZLbOMCIznOPY=;
	b=MMs6/jVzCqGY3EqyK7GvDDCmyz6Nu+dpS2LqrXH3yt3ydPNmYhBrr+TJESB45/kIYd1x
	 vsBCo7YaGPl/MhTAS+hzqKL3P94TDOCOs9oqVVedSw8WmJ2iQLFBY6uvagyfmEWZSyJc3
	 fLBTL1IIjITqe6mqvZM5wCV3+mEoNfd4EkjRw9z0JjIgy8z8/kb5aiLQQbtv9C2l8lAO6
	 KN/OzffevyvnZw+/wJ5liB+xlNpG3Fb8Tybj4MTZ//lAQwsehau5BJb6JkDCfeXsdqoZ6
	 y4wh+kQZhchUmBIf8ezb2QQAeKVvFioYQD1aX7pxJGR7TXGaT6Tg+Kd+X79cpUZzKRQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=BtEzmRSV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791839133;
	bh=ZKFb7bltnKP8c1CUcmLgkeytxPlWYe1ZLbOMCIznOPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mrrc2b68S67+6NBUcXNQI4k4zvyjGM5JrYj4JiJmMxV9ujVCI/2dU6yJ1skhcRpgP
	 20QU49MUtmDSuJPMR0OJkEPkURQ1v8VdOls56aq9xNU1fYB4UBt2z/g+Io0v+WxmDj
	 TfNcTLUAaXgnnAmZTQAX/x0o4i/Uc/cJkr3DjHJGBXhaWmoF7o8kHQ99Y/CYni9Bmy
	 cTD1E/w3zZ1oOiKrGaxuCcKc14cvN93tIQvQTz1PNHHiZBPjwhfTNn+a03l4MFjcnT
	 1P5JMV0JBFlq3mlfoSEnkKR1njGvTtv+H5A8iPI0CPkFKTfxDOZrkBYkb7B9/zOdA9
	 Nd6CoZL6en+vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B576605E8;
	Mon, 12 Oct 2026 21:05:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF6B52A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94CDE605E8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fS7Tc5RHFZvj for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E52C2605E1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791839132;
 b=shJmkIno1RxVhZj3/SYVc5FvsfJnxR7TqqniZ0t9ZhvDttIUA3UXEXBVm4SapNnt83uj
 EmyKbZaYgatf07KeGY1bcSoL7qbbnZdJEUEc29iCR2rxyRwWGXqnkrTaDmmHJL38YtCKO
 bVYzJE2pWekTI7fFZPuAPm9IJkMqTXhr0vMlGDwpSQpvTKYOPYvbIKy8VQGEvLM6ft69M
 VLDWwSP32dLkOAotNuqKXSqWsEEID6NxO8OfcJEHB1e8Mwhp0ULybaGvoNrHuvoPe7FSB
 AvvqWMIu7hV27S5PWRSSpmpk3pCWScqTUXl4cqLq0JqersDH4UO3lFbr/vX97YwYCOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791839132;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=ZKFb7bltnKP8c1CUcmLgkeytxPlWYe1ZLbOMCIznOPY=;
 b=TEvJOGxrrljgqg1ov0jN4I9tw/zPawppbofJiBCsi5z6lNcKBcOPo95sRXHQqRZ3/Lsy
 m1D42C5WAUfz1225MUI6Plm4hCT9OcV5uNK9e5GgW09fi+og1OA3/DEsrJCG/nuW2ldNL
 gKv3XvFlEzqY9+PUKGiO3vHpJTEuLv+BREPRvv8MIYJHAs8z7bm0S5Qoco8lbpUZjjkYV
 kfGBduQ2DDgwzzH04oF0JW3LnJGhrRuLCUgUZNvKzBVaadkMrQaOMc5xNtxGqDHcWrY7g
 lyAq+f/Ui4S3Wlz5d2nMElandxCYSXe7l1BNa6M7LwkFifi+1oFRHKAprc0Tocp9Y2w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linux.microsoft.com;
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=BtEzmRSV; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=BtEzmRSV
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp3.osuosl.org (Postfix) with ESMTP id E52C2605E1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:05:31 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id A3EF720B7166; Mon, 12 Oct 2026 14:05:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3EF720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791839126;
 bh=ZKFb7bltnKP8c1CUcmLgkeytxPlWYe1ZLbOMCIznOPY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BtEzmRSV4PnVffKsQhZ3jI4cHxOua8ccbtB8XKYKCOhanzjED2Rf6iX6XXxMKZwV5
 5LnckUaHHKUtCZY9hjOrpfmJ5kvawmGnyCYzwwFlPApJIL8Yn5rQwqexuENlcM8bhr
 R7ChLE512u1jSws1zViHJZvgmHnNdbO/rDWiiT08=
Date: Mon, 12 Oct 2026 14:05:26 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Tom Rini <trini@konsulko.com>, jerome.forrisier@arm.com
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>
Subject: Re: (subset) [PATCH v2 0/3] Bounds hardening in NFS, TFTP and ext4
Message-ID: <as1Llpz//mM2B8Gc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
 <179081761139.570197.9802971587834247609.b4-ty@konsulko.com>
 <ar6Ag0tw4KYUrgev@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <as0zB9XpmfOK7CtP@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20261012200131.GH3722450@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012200131.GH3722450@bill-the-cat>
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

On Mon, Oct 12, 2026 at 02:01:31PM -0600, Tom Rini wrote:
> On Mon, Oct 12, 2026 at 12:20:39PM -0700, Sriram Sriram wrote:
> > On Thu, Oct 01, 2026 at 08:47:15AM -0700, Sriram Sriram wrote:
> > > On Wed, Sep 30, 2026 at 07:20:11PM -0600, Tom Rini wrote:
> > > > On Tue, 15 Sep 2026 13:52:07 -0700, Sriram Sriram wrote:
> > > > 
> > > > > Three independent hardening fixes found by internal static analysis and
> > > > > code review. They do not depend on each other.
> > > > > 
> > > > > Changes in v2:
> > > > >  - Dropped "boot: image-fit: add overflow guard for FIT decompression
> > > > >    buffer" (2/4 in v1). As Tom pointed out, max_decomp_len is used both
> > > > >    as the allocation size and as the unc_len bound handed to
> > > > >    image_decomp(), so a wrapped multiply cannot leave the bound larger
> > > > >    than the buffer, and image_decomp() already fails cleanly on a bound
> > > > >    that is too small. The claim in that commit message was wrong, so the
> > > > >    patch is withdrawn rather than reworded.
> > > > >  - net: tftp: replaced the four bounded strncasecmp() comparisons with a
> > > > >    single check that the packet ends in a NUL, per Tom's review. It is
> > > > >    smaller (+16 bytes of .text on am335x_evm_defconfig instead of +24)
> > > > >    and it also covers the dectoul() calls, which v1 left unbounded.
> > > > >    Retitled to match.
> > > > >  - Rebased onto current master (a44f46af0aa).
> > > > >  - No change to the NFS and ext4 patches.
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied to u-boot/next, thanks!
> > > > 
> > > > [3/3] fs: ext4: widen ext4fs_update() block-group loop counter
> > > >       commit: 1c1b6c2b2ae03912007ed2ffd361f43b7c2e5401
> > > > -- 
> > > > Tom
> > > >
> > > Great! Thank you.
> > > 
> > > Regards,
> > > Sriram
> > >
> > Hi Tom,
> > 
> > Just following up on the other two patches. I see that Jerome reviewed
> > them on Sep 17th, but they haven't been applied yet. Is anything else
> > needed for those patches?
> 
> Since they're both networking ones, I'm expecting Jerome to pick them
> up.
> 
> -- 
> Tom
Thanks Tom.

Hi Jerome,

Anything else needed for these patches?

Regards,
Sriram
