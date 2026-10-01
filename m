Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A89CA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 15:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04CC660894;
	Thu,  1 Oct 2026 15:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VdJlEKTRjd3y; Thu,  1 Oct 2026 15:48:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 61744607E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790869691;
	b=pxWMvsi+SE/iibmXfxykmeVwhZANSlRU1I+dC1pxBVpLN9bJBoGxF9imkqV6rq8HObxa
	 bpz8FhCCmA4j4DlxFA7Jw5hnWhlz2woB2WQn7DRfvhb7aXo0xKuBU+pjcgf3ez2Oolv2b
	 wFXY6Far6DN1OSJc42QojyEtolGLSyoAlivBRCWjbCxLqCVUAM6HE+h6w9cKiOCxn1Keq
	 F59KJ2hvbgsxhAMMzBbYJ9rxBhOBEg1dIB/4J3WMwbFeoYqzfzKvYzr3SjG1wy4G6thpl
	 //AiL1sxc+WNc8lN+H/lTDQ6SyiENRVtJ3dqGwgUSpeCl2i/TfH9yeTs5MYSKM+H8Eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790869691;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q/8k5T0G9QUfn5022mSWPuKXXQuxR/pqq6eVRaovgOg=;
	b=nqjA6aql/FE+pBGNIcAjTUgbts9H1WLWX1e+O0vL10TVyXEov/DfUqMl9E70FG6nfXKE
	 wkTNAmsR6lMZJEfaaX7MxqXA17VdzfSJT8lEsnumDoLFkgVno8qOolskL0GqwX9uEFLZS
	 LxUrMl9XNhCp8pbNExDBmbVrcaYxjG9fc9cRRE8KaGtWmL3kSJOJuhI8R0rtGXBsLBo/0
	 fJPfUXmGVBlZ9nnTofRHDd5CLQuONbVW55XG3MoFZaTKSGughhxHpIEVGwWzWoi0e3Hcu
	 SZuDH6/BWq6f5ahpJH5xCl91VHxZIbtLs+tX0cyi/7tHc89I02ynt5WSBObR074AKyw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790869691;
	bh=Q/8k5T0G9QUfn5022mSWPuKXXQuxR/pqq6eVRaovgOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UX8g6zxWQCTjQMu9df15eGaTeV6Wy3hUbjf7qqJB77j7ZK5xfRPIPbiaYj1ySeLeO
	 PIk9byaKPr7pvHkMi2ehEz5s5n0efzy0anoeqIiMch1XuUV/+c4YEIM6O1gXRA96BW
	 jlTLnDP0xmPW0hkl+/glN3UOAUSa5cjM45tjh8rbvpI6uCNg1/QiOD6y05ixF6xQBi
	 hzlCuhV5HTomoyXQP78sZAp1YVTIEiYyCB2U1SBBifLZnBp3jDgUEZPrvp8yhe7Y4X
	 BTrTw8Yaf66S3OcS7t0Y1CG8WJZKnADBujDKgetDfYuOGCKyCoiAGNce6EepHh8SHh
	 r24wH8NoOC2uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61744607E7;
	Thu,  1 Oct 2026 15:48:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AFC91A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 509E040B9A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vBzFujyybDkc for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 15:48:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A814940B98
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790869689;
 b=bndTrnQcqtDxsUEhBi6o3MW0JNCgRtFZvYhb88hqKl2MLgc0PBNstdYgXaYBcKrl/SJO
 J7E7uaz64eb3ZUOAWcudrsgGQoxfeoyLpMv22dJLpHFb1DH/mw4VhbOm7nQK0qOC3OHJi
 a7GUx+sd0UveBHhtEWtrPNEZ9lykn8QdfGOWp6lvpIHNAcpavbHWNZ+dC3yumcT0cRNAP
 c1qYgv++Xm54han3RCOTDL3CEooPoZQNZEH3kgF2qc36rsyVfN/5DQU+CnFpLPsOTjjBU
 PivChaCHrals+cAi7AtNOrZJQ+GcCzs1WPkeXbJiA2j6y4LqU6pyKt7+3bo723Ais9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790869689;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Q/8k5T0G9QUfn5022mSWPuKXXQuxR/pqq6eVRaovgOg=;
 b=chmshW2lG/5ebwRhmn8Rnrm0BexxuFrEh7HEJX1nG7zQ3eTObYB27oqDqVFDBCMR13HR
 8NIaDt9zCIH1SJnhqenz+2kFyJz9yPpUNL0140YisNsJmBCU5Js40VN8MHMQeQoEOiCXK
 6MI+HQQmnZXpsWG0sLbmizweJvVe/V74ibtTjQfaG9q6Kh1ReOJr/+2TVUuTIaN6FpUkM
 uck558BO3aCroLBSm2+GWoaXS8QMk4rCH89xW5ZiMj4ThZuotWxKsbxYnr46zRar2xutQ
 YrwjJA7D7ZLycD7V0bBNk9QaWOCCWkAts+wUsYe4emDwtN5D9gTJYDl9zeeJoQlOOkw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=UTEpDynQ; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=UTEpDynQ
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp4.osuosl.org (Postfix) with ESMTP id A814940B98
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:48:09 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id 828EB20B7166; Thu,  1 Oct 2026 08:47:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 828EB20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1790869635;
 bh=Q/8k5T0G9QUfn5022mSWPuKXXQuxR/pqq6eVRaovgOg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UTEpDynQ22WYpsBTmM8NyIk8OgSo/tThGqQORql2ayB/rp2ReX7OW1iDEtXpEJ7y3
 V5t2yNSR2kiUniBgJJ2Ic3bYDCx0MGFayRdbnfOJgktS79w+9nWEXZeMoWYMIGuC0n
 bH/xbxWpVdM8GBxIOvOHjYGMmAX5dJGI78B1ghWc=
Date: Thu, 1 Oct 2026 08:47:15 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>
Subject: Re: (subset) [PATCH v2 0/3] Bounds hardening in NFS, TFTP and ext4
Message-ID: <ar6Ag0tw4KYUrgev@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
 <179081761139.570197.9802971587834247609.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179081761139.570197.9802971587834247609.b4-ty@konsulko.com>
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

On Wed, Sep 30, 2026 at 07:20:11PM -0600, Tom Rini wrote:
> On Tue, 15 Sep 2026 13:52:07 -0700, Sriram Sriram wrote:
> 
> > Three independent hardening fixes found by internal static analysis and
> > code review. They do not depend on each other.
> > 
> > Changes in v2:
> >  - Dropped "boot: image-fit: add overflow guard for FIT decompression
> >    buffer" (2/4 in v1). As Tom pointed out, max_decomp_len is used both
> >    as the allocation size and as the unc_len bound handed to
> >    image_decomp(), so a wrapped multiply cannot leave the bound larger
> >    than the buffer, and image_decomp() already fails cleanly on a bound
> >    that is too small. The claim in that commit message was wrong, so the
> >    patch is withdrawn rather than reworded.
> >  - net: tftp: replaced the four bounded strncasecmp() comparisons with a
> >    single check that the packet ends in a NUL, per Tom's review. It is
> >    smaller (+16 bytes of .text on am335x_evm_defconfig instead of +24)
> >    and it also covers the dectoul() calls, which v1 left unbounded.
> >    Retitled to match.
> >  - Rebased onto current master (a44f46af0aa).
> >  - No change to the NFS and ext4 patches.
> > 
> > [...]
> 
> Applied to u-boot/next, thanks!
> 
> [3/3] fs: ext4: widen ext4fs_update() block-group loop counter
>       commit: 1c1b6c2b2ae03912007ed2ffd361f43b7c2e5401
> -- 
> Tom
>
Great! Thank you.

Regards,
Sriram
 
