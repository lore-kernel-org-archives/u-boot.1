Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EEF606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GSMNm3KC;
	dkim=pass (1024-bit key, unprotected) header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256 header.s=20240131 header.b=aMw00hfe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 265E2816F6;
	Thu, 12 Nov 2026 10:08:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tr-ukJ-yeOBC; Thu, 12 Nov 2026 10:08:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 806AB81706
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794478126;
	b=r68/AKNadJ0i/bNWQ5JV15sMglMIDuddNIYT+jQWz/czDmVHXByrvaVClTHkbtoil2oV
	 8kBYArTTK863FggEqwQekaTUM6QE6eInD8JdAZDH/VTlAL+6A7ZViinJRNib0KuI1khMH
	 Cpiwjk50822eoLsVGxCN7PIJsLwEXXKJlcKvWYT2bzzcpM8rk2XG5MsdDemzL5msc2TGs
	 zwZUJ1g8jgy10vmXBghAxVPm78UWzEFKIsXdAfKM8qXmdufAP2YyMi+EYneROR35qkvMp
	 NftpgQ7Qr+TWHfhe7cJU/vxInzZsX6/00uzL2xu8nNVo/VB7F2PWC3Rjox5W0DNdvJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794478126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qmxWpzvKWFSUgaPAShtCiKNdoPOkcP0oB9KQZ85pUpU=;
	b=pI9MdwfFWvslsDk36IBTwJVfhy1ycHDOBimtfWZ4aOkKMg96PSX90et3rW5sDVNm17/k
	 hrw6xqgOzcLtQPOaHGo/zqwj98YY3WpBawwZii8/UXrYlBfI6LSMF3vJpUwG4qniQLZ8D
	 Raq4P5uJl9wFZGtzUsNCwkMttN+VRQn7u/XVFKxpUmQcYwXK2vQGwIOdDuses1Y3nWNOk
	 Ra5NijjhbvsymsdDCdY+weR8DUiLoiCfUnirkXJ98DLhWfZI+VHuaLmWk1QNCHN//lgcD
	 jIGwKV4VqXteCJedv0+3DfJFe5QknQk1K7EqSQ+A1+diie3kY4DSvTCf42BVTczCzYA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=NetBSD.org;
	dkim=pass header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256 header.s=20240131 header.b=aMw00hfe;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794478126;
	bh=qmxWpzvKWFSUgaPAShtCiKNdoPOkcP0oB9KQZ85pUpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GSMNm3KCUK47thb8VtnAw91TTcYFiFxjK2ic93oN8brLNkGPCeUDgAmHwTtYykgsO
	 Vc67QwOkwevGVG3c83F5Y84j04+UJ2Fx46+SmAgrKYq02Up7/L2Yat+Hy4X8cXXm82
	 wDIHtlmsA8mJw5N1NRP+xOPmG4tby6I4oCa8qew/nkELg8+gHcXGLgCYtf1i6Lnwu4
	 m92PkXb1GdRUvWyEkdsl+8ZAOCdIlnerq50AIS6klfinV1MfIFAyBRLMQlnyI5fCp+
	 9PQRLgQMa0YIfx1aSqag6NXnnrRTYXY5/Ta5IBHlkqmT8oNpMkQcMZH6N0k5tQXDj8
	 IXZvLMEFNL6bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 806AB81706;
	Thu, 12 Nov 2026 10:08:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CA2B1399
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A340815D1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wiy0Slulaz3W for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 10:08:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BDCFD81213
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:470:a085:999::25"
X-Greylist: delayed 70361 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 12 Nov 2026 10:08:36 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=NetBSD.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256
 header.s=20240131 header.b=aMw00hfe
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:470:a085:999::25; helo=mail.netbsd.org;
 envelope-from=martin@netbsd.org; receiver=<UNKNOWN> 
Received: from mail.netbsd.org (mail.NetBSD.org [IPv6:2001:470:a085:999::25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDCFD81213
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:08:35 +0000 (UTC)
Received: by mail.netbsd.org (Postfix, from userid 1214)
 id BBE4784D37; Thu, 12 Nov 2026 10:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netbsd.org;
 s=20240131; t=1794478112;
 bh=qmxWpzvKWFSUgaPAShtCiKNdoPOkcP0oB9KQZ85pUpU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aMw00hfeB+9/QKJX7MyksTOcgZyifuQy3qh+rkRoISWGKeByaCklB1leTDe6A8rSW
 w9x3ih2Bfc7lSrPexN1D0b8hUr7mVoVPS7+N/98GQsS/ltGha84vk59oMXc89bp0BI
 WwXDjZ9+W+9ZyJGDLEHYAN4DR57yP/C87m7+C4tE=
Date: Thu, 12 Nov 2026 11:08:29 +0100
From: Martin Husemann <martin@NetBSD.org>
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: RiscV SBI incompatibilities?
Message-ID: <avWQHauj-I0ZSuk9@big-apple.aprisoft.de>
References: <avR9RCMQHL8TZIAR@big-apple.aprisoft.de>
 <avSOoJFxsR6hDuUd@pie>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avSOoJFxsR6hDuUd@pie>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 03:49:52PM +0000, Yao Zi wrote:
> I had a brief look through the changes from v1.4 to v1.5, and suspect it
> has something to do with OpenSBI commit c5be0e1ed1fa ("lib: utils/ipi:
> Skip initialize ipi when dt is not enabled")[1], but don't confirm it :)

Thanks, indeed with OpenSBI 1.9 it works a lot better.

Martin
