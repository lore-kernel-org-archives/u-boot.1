Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CCFCC6B16
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 753E960786;
	Tue, 13 Oct 2026 15:10:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9SZ0H0psDSha; Tue, 13 Oct 2026 15:10:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7444860737
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791904244;
	b=VQayIWEGypkL3dAcAIJ1FmCa4X2SNULf0znVHbgXEcn8Cpg1GtlrtgltWdFUIhRXb61w
	 An6RjZVxjEEThRJ1cvVHNKzrqpGaY9D8oVAjm6Ins/hwpSl8f19KBt81lzTkmUteMm90C
	 I9k4Gkz1ksUPAblKBFD+DXV7NDs0soNF/j6yQg+XMTDonXZg7WF33xKEMU0LbhjPeUfRI
	 qOdpSoIk2mR8ZmmNaCPUUcYL5F6Luhw0z1UoFEyjJwh3zYrPN4dfRMxpuzTVMayJeyXZw
	 1QQO0fJGWCdSaAJ3rTrQqn4Bi3uobBKicKndqHEfKNoKtwLJZqsw+s9JYEvDFD+veRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791904244;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xbBR9v746fm/Wl0It2Vp6eDmpLP3oAwwlDtL6uQMoUU=;
	b=nrMC3a49pkBdEJMmO5kmhMLZBaBeVo3PXm5iDOoVp3bYnXQRu72J3y+nxQtBv1T35mIK
	 Oj4c8D66OK6H7uFvauGpX+QAC+aGwnKc6YKHqxjCY30HACe7KQY0pmKQ1N76/aFOkFge5
	 m/fXh0xo4fNHpjK+pv3TCTPl+mQmYUGfww9MTD6RSdXQpRbeCWhZLoMPQTCKnUh3OwbW2
	 8Mq9sdWwKp1WSf8gZY3JPf5O2mJ099SeDBKUlOV5KAKFrNJbqBzkfWuAhuiDb8y0U6aAH
	 u4az7BuRd9vlf40GUpxG1R3SvS9u2kGE3kxuY9y95mVMaOSNkc23kRN4sAa0EomD2pw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791904244;
	bh=xbBR9v746fm/Wl0It2Vp6eDmpLP3oAwwlDtL6uQMoUU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oqkgp1nmCpqxaY8Hdx3+4RSHUesaUeIcx4LQ8MkzN/Zxa6IzOfCGD53E0PekWgQ6h
	 GDWZbeKDWr8uov2TF1htfZQG8DLWbWlqi0WUdhowdQQB49xoittRVIe/ZHADT+iArK
	 42hxGM54c0ACcBIA5ffqvMW1Eb9CoZN3Gfhq3RxlnoARD0xSVMkuoCWVsVcqFp6SxA
	 3X1KiZUPzzFVOPn1anDocGr35MCB7+sJ/4S3GIkRug+rWENujw+0aQ+Li/LKNsufUe
	 MLqBeOD+ETW+1k1S3BHH2Ig9Qlp1NYYCqlPpAHmTzL4mqf3a13p8amD09zq0o3u9Oo
	 qq3Hf680K6viQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7444860737;
	Tue, 13 Oct 2026 15:10:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 496D2362
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FC84402AA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:10:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TcCvZ0WT1jCc for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:10:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5F9344010F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791904241;
 b=CcGH7DbhyEfdeDKK6MrG+ZfeDkSbUBTheO+BlYxJ3mvyTt2/46+ePvGR3zlK6cpyzkEd
 IbfVRyyXpgLwE1/xR+IwPdKkzagywvhKaIulBUdE+f3dLdotgrtjDUR51N+MMwpydAvik
 nzu1nAL+8srQejyim2FLBK2qRCXqkfdZCehnQNhlVLcFPhahh00G3VLvjh6C9SSzM2pma
 wsGDRdVKRAkxmln7RlDajUYQRWvr1tvpGiVeDp8T0CgLGI8aR/tcNUscdyYSRxBjQeaNs
 4QNv/UbJ2MQkCpoMmuGbERjXyr50bP+QAKSwclAylRuK1sB8IBQyJOAwvSeyUQgY0pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791904241;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=xbBR9v746fm/Wl0It2Vp6eDmpLP3oAwwlDtL6uQMoUU=;
 b=el38Yrjrx1L1LXsdUmCqCd/A8tVUkt81aQCKdfpvZtf4yiD4GAXqY5vhuAofk15CW2Ux
 ZJS0zkMUAIOUbMOmX5i8NgMcavVYl52rt09fYP+hE+IXtlSemyPhMalwEydd0bKQn6ppZ
 3q5ZzWEiKQYGA5DpRT7yEuEZ7YCquVwfgCjNdQyHdQ7KINDuOCwo7wt5McoLvqfYnQ28+
 /+ZgjpS5+cinQSdX+QOuBtHF17zoSPlGfeChiHanBo4rbxfCl6tgAIpco29S0lEMQpGZI
 8R+TYbfV7BJAKzVUg8d127A4MC+V4gJIRUDkN14xZipsavLOSlDQrd5bb5sY0DViwOA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=L6HmgoUy; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=L6HmgoUy
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F9344010F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:10:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 121D942DC4;
 Tue, 13 Oct 2026 15:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BA91F000FF;
 Tue, 13 Oct 2026 15:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791904240;
 bh=xbBR9v746fm/Wl0It2Vp6eDmpLP3oAwwlDtL6uQMoUU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=L6HmgoUyHeCFPLMV3zQszOr4QCYDNZ7PSU4CpThhzoQS6GguJz1eHmZshvYMnGdba
 tf+UVu91rgUT+mWbkcmZ/MTtNG19FoUXOh0SLCzqKu5eyU2WcaraErNRlZgA2YdzNF
 50odG7Ki2RPx2ZI+8rbOIz3Q+9Qe+xMJ0g+Zmyc8mMAg0f2oLcZHa0AC4SktI9uVxw
 ZHzAR33F7XBxz7e29V4xlOd5HssCCjdhkCaPw8hutcWUtH6ck/JsJH0nX3a4K3OfRi
 Hz8oK8DSNca8bt7MIFC4JnMjpDMI3RgwvQ/T8+IyMvaij0Q4Od6d4FXjUhiHIB13bY
 ZF4G7C6cmtSFA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, Jan Kehren <jan.kehren@emteria.com>
Cc: igor.opaniuk@gmail.com, sjg@chromium.org, trini@konsulko.com
In-Reply-To: <20261006092732.3577974-1-jan.kehren@emteria.com>
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
Subject: Re: [PATCH v2 0/2] avb: Support verified boot from non-mmc storage
Message-Id: <179190423794.327417.14672541022250043617.b4-ty@kernel.org>
Date: Tue, 13 Oct 2026 17:10:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Tue, 06 Oct 2026 11:27:29 +0200, Jan Kehren wrote:
> Thanks for the review, and no worries at all about the delay.
> 
> AVB in U-Boot assumes its partitions are on mmc. bootmeth_android accepts
> any bootdev but passes only the device number to avb_ops_alloc(), dropping
> the uclass, so an Android bootflow found on nvme 0 or usb 0 is verified
> against mmc 0.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] avb: Drop the mmc naming from the block IO helpers
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/addda49825e13de708f8b8af61519cc4a465f6c8
[2/2] avb: Take a storage interface in the AVB operations
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/ba044ad0c14b84b783387b22e488166828ea70f4

--
Mattijs
