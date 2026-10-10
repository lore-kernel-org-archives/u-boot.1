Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2711CCA9ECA
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 23:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 271D460720;
	Sat, 10 Oct 2026 23:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VkkDDT5t35ig; Sat, 10 Oct 2026 23:55:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 49251606EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791676549;
	b=fIeyCvh766MGokjm9AFAOLhNOFE2XdugR9N0+HrBbPODyPvYd/Bv9bSo5QObo1RaWrMf
	 F51Vh9YfupbnEGkQ60AowQarH6XKLOSNAPuHh05UODU5+RK+cHBvQ5xXiGwT4Jh+pA8Cg
	 BzuE9SUGcpF8PJd1xE2ofMg7UT3tfzfd5My23FUh240dtrlY/oUty4Y6mBkah4YgHXnV4
	 rH/eyFH4u1cfYpNBCkgegLAA12HDnsOlb/l1FYEZwItoPo9WHZPmYNaFy/sBgNnMVaTm7
	 wq1doDARjdevscUlOtcxH4kGOl+D4OAQgl52CvQ1Ay9rnr4eekTFO81ck6Nb58ej9lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791676549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=csrUBGp5zX54lk6K94qRmn9VpVkf5skFcbmvFegr6Oo=;
	b=qv+xZsOKjjh7PwtHqW56HW5VQmYx/X6OQmMJkPk0O53CvQECK3NDCzD3Rv1nje3t5IeQ
	 VtRfFtMiZCNhftnfXSMA1jD3/sRN4I3rje+nvXvrx/fQPTrTVb0sgJth8NUvzaDOs/xo/
	 A8vr//kcAR0U6Khfm3sM4A90vJ7iS+mBVMisB0wwnp7M/d1yxJyAjqvaVGvFjqoKJ6vw3
	 ImKZz35ogIoCqbrSVonn/N4NcFnYQcjWIhzOpHT9sAnJEVOBcxWnHx9hccP/S/Gn/9N0I
	 ZJ/xlF5WsvWmpPceJ7xTSlZs565QM30dnq5dyxc3KSyo5xzopXk7h67vZ/a7pHNn3BQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791676549;
	bh=csrUBGp5zX54lk6K94qRmn9VpVkf5skFcbmvFegr6Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h8TibK/l2lX4mnGjvX6pe/s88bXDeK2IsbmAmH1hTNMmp7F+7g1t3YnqzDCR2UUZo
	 4QFbwc7Ed3iQ4C/n2TRx4nEoxAAu0+U84YRbaM1kuAxopJhMuz0Ed9NFDfVi4w12fS
	 7QNa+esWvO60JRr+l2ffGpu3IQgxGu5b6lCIK/h8rebeb3MFMeqmHus5a1SaXOW6nD
	 nOmA8RYca/8IK4Ox5V6Jl8fhCvU8qes9KtHScRZjH0JZBSRKQxmel7Hv/EKsoaQWiu
	 LcY8WApahC9oc5h3/dxKVQ1tHkABVDaoPgZIM1xTYch3w4b2cNU0Q+qA73dHKyqofP
	 XpdBgafKN0HbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49251606EF;
	Sat, 10 Oct 2026 23:55:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F15B322B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 23:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D784D80F72
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 23:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ExAvG37wPx1L for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 23:55:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F029480F5F
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791676547;
 b=ZRL8tcpKUcC6lBXQ+Ts0DMs8jM4zww2v4BkA/ZVx8LmsJF/o9XXefuyZA8yBEJTAd4vs
 3ygX8DmFT+ijCY2qMpDD3+KWxz7HNRcI9WAwNIpHut33K+vOq4hyI1XICeiEozFKr51T4
 +Iqm0bJN+zhKXfVo0PuRESMGCEYUhmfnz37IXlvOqBj1R+Su+DVZ6iLcfA/2nVw4tJ9lY
 tdw4Ko7+SXkWHsdCoJgFC300J0NkZa9P8zc5ZPkEM0AmjkWM0fYPFpPzzhYflPJ164ZJa
 1QjkYxuOhI/aQ0G2a7vDujK53iA5FMJhrmH4kM0z74FAdPNIx3yGz6hCfkIKZtlXqAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791676547;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=csrUBGp5zX54lk6K94qRmn9VpVkf5skFcbmvFegr6Oo=;
 b=Oa81bSJC5GyqkNIYRTiA2JM3knW1nbAaGGOmtYskMJ49VcvPnJayFfPzuilE3rQla651
 O45Z1WGpZ5zWmVvKgL2/m6ZzDP+wkh9ok9gzCZsVsK/7HQ8jZeKy1QjwAdCToIFXJJJXX
 rR8pF1YeORqOLdhkBmNsBZ8IHBcC055Xohzeb/MMBHpwonKIQWGr5gNO3BYb5rh/vQA6D
 sO/FzXK1n7e0n/jFSG7VnMSVEmqfk1tjBsRApCN+9sCZIE/FGDLTAdDSiqYnTZoN3x872
 hkElVBHaU1nt+O3GmZXDogvAXLL0OhbcX5ckVaNu8q+faGM6GSAYNfwwcraSVELSAFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JiD2kzdH; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JiD2kzdH
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F029480F5F
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 23:55:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C6BD940596;
 Sat, 10 Oct 2026 23:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326A11F000FF;
 Sat, 10 Oct 2026 23:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791676545;
 bh=csrUBGp5zX54lk6K94qRmn9VpVkf5skFcbmvFegr6Oo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JiD2kzdHTVSkyzfHwnvDFNiSadhb+1ZLmhjydMjGs0+K6zNm9GPcIqLGwFZzME8eD
 0ZnOjUdr5AWXCbwTozwNk88CSAEwXld8lKRIfmCH3te9lebM+8jhJN+B5Sdoti4q5t
 YnFNf2FZhbRZrEX00hrds5THnZVRz26n8WWBXZAlnU/+8oJ4+PuuvSLGV0f6cHjuT5
 HjvXpSPr5lFCgRPG6hcqspmp+g4I1TlM3a2H9fwSUv3KXjlO94qKT1UerF8ygS2Egy
 eSFAck0XE2n6rgxy3WgZHc0S6BmN1hFMniWulmoVDS0DHEukmlqr6fPTe/WcR4HOuO
 ynpl1E7MMsHYw==
Date: Sat, 10 Oct 2026 23:55:43 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [GIT PULL] Please pull U-Boot spacemit-main-20261010
Message-ID: <20261010235543-GKE26088@kernel.org>
References: <20261010043056-GKA26088@kernel.org>
 <179166878504.3219985.15506887187282237548.b4-ty@konsulko.com>
 <62a524d6-4693-413a-a704-da8e83a98ed9@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62a524d6-4693-413a-a704-da8e83a98ed9@freeshell.de>
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

Hi E Shattow,

On 15:57 Sat 10 Oct     , E Shattow wrote:
> On 10/10/26 14:46, Tom Rini wrote:
> > On Sat, 10 Oct 2026 04:30:56 +0000, Yixun Lan wrote:
> > 
> >> Please pull from u-boot-spacemit into main, thanks.
> >>
> >> CI for this pull request is available here:
> >>   https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/pipelines/1535
> >>
> >>
> >> The following changes since commit 0a55b098d6f5f6bafa84fc2f18b433dd167bf729:
> >>
> >> [...]
> > 
> > Merged into u-boot/main, thanks!
> > 
> 
> FYI to any future versions of ourselves wondering why non-existent
> symbol CONFIG_DWC_ETH_QOS_SPACEMIT is enabled in this PR, this was
> applied out-of-sequence due to a delay with the networking custodian
> tree PR for the merge window [1].
> 
Right, I thought about this before sending this PR, but didn't consider
it's a problem.. for building and testing, there is no error with this
single PR, yes, will result with no network. Besides, I also trust net
maintainer whom will send the PR eventually..

> 1: https://lore.kernel.org/u-boot/20261009172150.GD769217@bill-the-cat/
> 
> -E

-- 
Yixun Lan (dlan)
