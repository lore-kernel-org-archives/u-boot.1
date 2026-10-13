Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB861CC6B12
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 16:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD70C404F8;
	Tue, 13 Oct 2026 16:04:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8bh-FkUNGcRy; Tue, 13 Oct 2026 16:04:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 15965404E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791907480;
	b=dhKNqe+fWXUhPrvh6S6cukfCkMIHXehGp+tsBTmue0RKrk1JE8Q35QngxG4ShN2mOjV2
	 HsNqc+R1lA6copE7r47R6shnFAGSViHq08w0nvYpBMtaaW3Vkn8MJ+ia682OuvepilNOJ
	 yANNuLOxT3fFrzUNamNRL75vJFA3N9I4oSvD9+IgvaSAs1DxjFZgcEy1ukvmg3VCfT7Cj
	 sJgfmkIaK6TSGJI9Mf+KPpcW8jPr+I15lUxFGJ/ELcy64M8n+XmBz4k5Zf8QhNAz8LyF6
	 Xd56KOdtOMJfqtGKdS0/4IFA7xtyeUo9uEWFDtEXLAgWo/jXqEbe/9maNrp3X/NKI+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791907480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pic7+l9+skW0Ye3Opqu0eFMHc1tSa2y7IY1uUIpQ7Xo=;
	b=QbwN5IT6BfiFnqhuxVZzPFA6WYzV81WzVYOy3QbniDatNz+dUyEEqBE6Tnvk2oy6jGih
	 l8cNwZVVWxGL6AiOnh3gGP4S4/oFuTfSKvcycZ51cE9OMcqU57KVZM+HStSYPkqHThav3
	 ega0wvwEbNauy/XexWzdC2GjYlo0zaicDSamkapNVCvNftOlinnmTCqUfRW+kDz3pj7eu
	 0Hpi/+WkBRcc0G+Tllz48nRaiNfSaybhOjaYsJw53ByD6xL3VWMb2Qf+3XpXXK6cUR/MH
	 pbnJxhSwPwcQXhCNyUZQ6xGZaiifPSq97HxWBq452ndWndkqF2h4jCfJryBV5zoz0TA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791907480;
	bh=pic7+l9+skW0Ye3Opqu0eFMHc1tSa2y7IY1uUIpQ7Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MOS1gN9KsMWUCjwj3dDfJQJZykX49YM605dqS/GNibA8r6VstcZQQbr+sIaACGsOD
	 Nd0FchRI7GCTaZyOqTX+/cJtMPLG8ZgIZoLAszzw7CwyVxUY1fX2XRxapeauYkzPsu
	 z++ZNvxwdx+ZvAttVr6pP4UndMdLBX8Py1JeFGXn/fnq8Pfzxd4paSY7YfC+CXUHDU
	 ux1/yqWVALxFo8uTlh8kcSTANFByINvHz/6SwWwpHeq2WqPap9S2be13W0YlVoaN/S
	 r7AwRJK1tGh2tFHqzDWYDTQqpJBjlNlYDnPf1XhpRGMevwqwwkRybPqav23SBlVIDy
	 hBOK+OFCIeM0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15965404E0;
	Tue, 13 Oct 2026 16:04:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A78D75
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C81F80D2D
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:04:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufkYxGogTJTu for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 16:04:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD97F80C98
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791907478;
 b=gDUuS1vmCdNKm1CnY3lZHLdWOH6GXUONOY5X6PPrwJhLsE3qZwN0MxFDlzyyqNeSZMkq
 RK4hUwtUqaSaDyuRvyte7gOamTb1YrwhZblYv2PaSvvXwSBHh2EJt1He/01Rr4rn7QnzQ
 Wou1gWfdxFgIIMO9Dqn2E8y4Yf1tZWqHAzezjz2l/Q+RXDy2UPCG2O/1JL5JMt6BAC7wS
 wi3ryFBNUzgMOeai1O2xOfYriqH4AjNE+Vs99hb2il1LNjevWExLKNWAo5WGEFC/9sW0h
 JggdqPNm0VgybOAfeHHNUwmgf0/fUxzsC37ZCxClvleQrmWeptOlkgzOPlxflnfG8EQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791907478;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=pic7+l9+skW0Ye3Opqu0eFMHc1tSa2y7IY1uUIpQ7Xo=;
 b=XIzGCoHoMsxK1B561sxj22vI01+9NMNNd17XAug8Joe5HcUNrcz4lSoar23nMoFkOwlK
 jUk+yZ6/CZ06u+tWKkOy2UlbMOsqK9cmYgZOVGt5rX1sOkN+qvCEKIb2dDFSwYe7WMHyB
 Y5VmT3TalV1JCsfGt/GSZ0SN2bf9HZ26bwPa4402BxsFx3x+ZSzsEUNID+vFlTUQDGUy2
 pxOsaGUNnfaJA+TZ6vhyW4+D85UbfiYe4hbkxzyAdXOMCLKaVbrEs2J8WMEz0Aq6dvX4E
 iT0WQcp9pCbqknsETjuZFIADG1J7iSNF79/PucTDjGyxR+mGqOnenCoMyQ6O0HXhRKg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linux.microsoft.com;
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=db+dcnwJ; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=db+dcnwJ
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp1.osuosl.org (Postfix) with ESMTP id CD97F80C98
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:04:37 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id D64AE20B7166; Tue, 13 Oct 2026 09:04:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D64AE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791907473;
 bh=pic7+l9+skW0Ye3Opqu0eFMHc1tSa2y7IY1uUIpQ7Xo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=db+dcnwJbT9zGBchr+qu0DrWeddgGNq0HtMxSxOXY5D3qsEHYUT25AZ/IXIP4ZMLL
 ur4tXotVI9oKOY0dxZB4UaXiqqwn1LZATJVuUV5T700bmzlUDBNQlyiYrlSyWhNfkw
 Q4KDqKHu94lr/NCKY7pMI+Jm08dys5axVIKzD30Q=
Date: Tue, 13 Oct 2026 09:04:33 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>, nd <nd@arm.com>
Subject: Re: (subset) [PATCH v2 0/3] Bounds hardening in NFS, TFTP and ext4
Message-ID: <as5WkeAMk0RoXUpD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
 <179081761139.570197.9802971587834247609.b4-ty@konsulko.com>
 <ar6Ag0tw4KYUrgev@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <as0zB9XpmfOK7CtP@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20261012200131.GH3722450@bill-the-cat>
 <as1Llpz//mM2B8Gc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <as1PAnqpeFKZddk2@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <41c99e7d-f228-4551-af6d-f2e761c612dc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41c99e7d-f228-4551-af6d-f2e761c612dc@arm.com>
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

On Tue, Oct 13, 2026 at 01:23:10PM +0200, Jerome Forissier wrote:
> Hi Sriram,
> 
> On 12/10/2026 23:20, Sriram Sriram wrote:
> > On Mon, Oct 12, 2026 at 02:05:26PM -0700, Sriram Sriram wrote:
> >> On Mon, Oct 12, 2026 at 02:01:31PM -0600, Tom Rini wrote:
> >>> On Mon, Oct 12, 2026 at 12:20:39PM -0700, Sriram Sriram wrote:
> >>>> On Thu, Oct 01, 2026 at 08:47:15AM -0700, Sriram Sriram wrote:
> >>>>> On Wed, Sep 30, 2026 at 07:20:11PM -0600, Tom Rini wrote:
> >>>>>> On Tue, 15 Sep 2026 13:52:07 -0700, Sriram Sriram wrote:
> >>>>>>
> >>>>>>> Three independent hardening fixes found by internal static analysis and
> >>>>>>> code review. They do not depend on each other.
> >>>>>>>
> >>>>>>> Changes in v2:
> >>>>>>>  - Dropped "boot: image-fit: add overflow guard for FIT decompression
> >>>>>>>    buffer" (2/4 in v1). As Tom pointed out, max_decomp_len is used both
> >>>>>>>    as the allocation size and as the unc_len bound handed to
> >>>>>>>    image_decomp(), so a wrapped multiply cannot leave the bound larger
> >>>>>>>    than the buffer, and image_decomp() already fails cleanly on a bound
> >>>>>>>    that is too small. The claim in that commit message was wrong, so the
> >>>>>>>    patch is withdrawn rather than reworded.
> >>>>>>>  - net: tftp: replaced the four bounded strncasecmp() comparisons with a
> >>>>>>>    single check that the packet ends in a NUL, per Tom's review. It is
> >>>>>>>    smaller (+16 bytes of .text on am335x_evm_defconfig instead of +24)
> >>>>>>>    and it also covers the dectoul() calls, which v1 left unbounded.
> >>>>>>>    Retitled to match.
> >>>>>>>  - Rebased onto current master (a44f46af0aa).
> >>>>>>>  - No change to the NFS and ext4 patches.
> >>>>>>>
> >>>>>>> [...]
> >>>>>>
> >>>>>> Applied to u-boot/next, thanks!
> >>>>>>
> >>>>>> [3/3] fs: ext4: widen ext4fs_update() block-group loop counter
> >>>>>>       commit: 1c1b6c2b2ae03912007ed2ffd361f43b7c2e5401
> >>>>>> -- 
> >>>>>> Tom
> >>>>>>
> >>>>> Great! Thank you.
> >>>>>
> >>>>> Regards,
> >>>>> Sriram
> >>>>>
> >>>> Hi Tom,
> >>>>
> >>>> Just following up on the other two patches. I see that Jerome reviewed
> >>>> them on Sep 17th, but they haven't been applied yet. Is anything else
> >>>> needed for those patches?
> >>>
> >>> Since they're both networking ones, I'm expecting Jerome to pick them
> >>> up.
> >>>
> >>> -- 
> >>> Tom
> >> Thanks Tom.
> >>
> >> Hi Jerome,
> >>
> >> Anything else needed for these patches?
> >>
> >> Regards,
> >> Sriram
> > Hi Jerome,
> > 
> > Sorry, there was a typo in the previous email. Anything else needed for
> > these patches?
> 
> No, that was an oversight on my part. Sorry about that. I’ll pick them up
> for the next net PR.
> 
> Thanks,
> -- 
> Jerome
> 
> > 
> > Regards,
> > Sriram
Hi Jerome,

No problem. Thanks a lot.

Regards,
Sriram
