Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2315EC982C9
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 21:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E6B880E2A;
	Wed, 16 Sep 2026 21:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGWerae_ESlX; Wed, 16 Sep 2026 21:41:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8AC8B80E13
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789594880;
	b=q+f1QaTh1fA68sx7nNN+R4YonSdw91HmOCLgiBi//zpgz4aVXplFPnTEicdlteu8sXa/
	 6lczExBTTbdMc64awIKpG9Br6RB1/6ZNcNh15i+bSqAc2RBz8Ld8lK8LfFh/KOjqqe0KM
	 3md7qZ/oX0HuCnC1eXey3d2A5MlJ3AKf1q2rHYZda2Fn0AIgl4AjH20rsjq/p5Scsu3hD
	 POZVYmk1zi4VwB4QMY9dQFXIuUPrKo0bqMRYWtAdomQBAGOxAsaj7+0zFuWdm/6GTVrvY
	 vn6jUG3voMkCiypJdKmm7qet/ExuR21bYCLB2B1RwDqU7NpkT9s1olHuXykfgosuSng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789594880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DRBxeXrgJJvkAZxXrpbPo5nTzDDNQzH9+qdFVAJKkAc=;
	b=nz2gOS9cLLOCbefwF8HAMkQJEwAf8m/ghnkJKZs5D++y/BNBYBA4KfkYDtWNHFuG4zUm
	 uvVgsjql9UxU9TMZYClyWWnBY+CW+Dkp0bNCTOnKMtC84Pd7eLgfcEDl/2h9mdj0xjptV
	 N3ekSXYQlmqnV+lBFo+AuID9RNH5wR72srNiLROn9GG0LN0XBYZgQn8oWXu84+Sv81d5l
	 yrmOacCOJYnyrX2eFnjX5d70/SgORaN24Z9M0jQyEr1QLuytWCBqbvevyRkV2/G4TMIoZ
	 CtU1+Nn25K79FuoldBFJRisHKLOYUnaSi+99ZN2maek9/m6PPjT6V3OAejn8exSf2iA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789594880;
	bh=DRBxeXrgJJvkAZxXrpbPo5nTzDDNQzH9+qdFVAJKkAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XYDhWVY2be6hGwBV6Z5n60ZmdZvznGpM8itMPbpZ+q68p3IOFg1l3obKCgAsdhPkW
	 iurddQHOQhvCQ9/zZ+o7mYOaI73k5O2FmLwoSZe/3nu3P++Zu8neBM+gofBxawlZC6
	 IxqJeWQC1JeVfBeRA/bBHxgPdB0gEuIRQsRNdRMgu/kxNf/EmDzkyNBcAf7Wqd0IDr
	 ADZVubcMtmAmJPAoDdpDi/WC08mWQfFtXEhW+mPIqcubf0lanAE57VfNEfXPrMyojp
	 g6u50ldMg5AYBBHkym4O1kzneT6HLac+GUP+C+xQi8KyrZf1HTMVL03GZ8QFr33Xf7
	 ge/aG07jIxv/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AC8B80E13;
	Wed, 16 Sep 2026 21:41:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7EAC2EB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BDEE8403EB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:41:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PYn49e4SUJ-N for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 21:41:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AE9E9403E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789594878;
 b=cmNf1hi61HvGOxMOvsShvS4wurwgA2/HLDR170dSUXZiHNx1bYNUeeRJnfDvisyLFEpH
 ZcZI6lG6oWhTO2z0VYyy3qoZ72DacWqKxGh/BHwUQ5X6OAwGOfsPtEfS1QFHOu1d4k3DR
 BWEgoT6H666tblyvOEzyNxCSbSHKlBrHTUVaP4Lq2zY21lzdq1nY/6CRhNX7k5O/Ob1rf
 8yCaQyHrbZIMPiNfJp1Uc11WLYcnnDhRjxItk1MUsyRF7fQR6IM+S2lWWWIhbXqGtxW7K
 DYiYISsRnKLt1wszxTtWLkP7DtFrcPwUjC6W3GUxCtXh/RlTf4a4a5xIl/g/2CRl+iA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789594878;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=DRBxeXrgJJvkAZxXrpbPo5nTzDDNQzH9+qdFVAJKkAc=;
 b=KAUNvv7nfIV8O9TS07XltVcssveKcmRgt2RSskyqhpfzEJx58N4vK/h61d0WwXEMyGbR
 Tf2ITJGOmbVyDRZafC0178Bo4on+GQjruIeMJK4dcY3JCUtaAzENZC9OAJbwp6VqmPzMd
 WkWkKR3IlJEqAP/WoxKg+lXrpDl1IYRHbFBZ6jc6ENNGkH7/mMMSrRjWnTusyKZW75mUm
 lZfHTgkBxUTY5AQ/+HpC+gTSQoB0KLSDYEDUEfMHb9chwMEDsx24A10JLp4m3YI76lgs6
 DdQUdDR1XlmTv0M1/RZJrQJvHCjT0OJ5QmfP7T2CaNz6GSFQRmrQ61M2e79a9PYam7Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=bGTwzL4X; 
 arc=none smtp.remote-ip=212.27.42.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.6;
 helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=bGTwzL4X
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE9E9403E8
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:41:16 +0000 (UTC)
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:ac2:22b0:7873:8bc6:6408:8ac1])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 61B3878035E;
 Wed, 16 Sep 2026 23:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789594875;
 bh=mM7Tng+F+kMbbWtwR17RrOiASsZVZwcRW6MYobOdtbU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bGTwzL4XA+B5H/sVGH/Xk9RHbte/gpaEID6W1yW+iK+EyaSf4mhqM1i0s20LqNh4e
 YB5wOfSz4e1Gm90rT+Dv1yzc4iEz0kgq7S4P3pb1DDPtRVuwL0kCSoAXYUnvSIsMwg
 whJmtfBNaOYdk0XP8jmSrRcT0prwEK3aTTioEqPMXtwikoAZP84cDYo0UxKz9DmLJH
 tIfy0Yugx9Jj8ICWdzdFF4cNH3+gECsoXAmb6Dzmbf3rnYKTYIyRqXhiJYJsSUJbVd
 KT+Ud+BE4qmHzYfODVLuuK9MClSrBVDe+u08ytGMip6AtpDpaeEcsMFl0d84wh5iu6
 SNbG6y+15V7yA==
Date: Wed, 16 Sep 2026 23:41:05 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v2 0/5] board: lx2160a: runtime SerDes 1 lane grouping
 for LX2160A boards
Message-ID: <aqsM8WGzqV3Rzjtt@L30177.local>
References: <20260914170417.3052423-1-vjardin@free.fr>
 <20260916171208.iygunxmqpy335wl3@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916171208.iygunxmqpy335wl3@skbuf>
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

Hi Vladimir,

> I'm confused. Did you send a v2 when v1 was already merged?
> https://git.u-boot-project.org/u-boot/u-boot/-/commit/035d68fc36b55e3d180d73209beab15a5b988215
> 
> If so, I think you should submit incremental updates.

Yes

v1 was applied to next the same day I sent the v2
(fsl-qoriq-next-2026-09-14 was merged few hours before I
sent it), and I had not noticed it.

I have just sent a v3: patch 1 is only the delta vs
the merged v1, then the patches 2-5 add the other SD1 modes.

Best regards,
  Vincent
