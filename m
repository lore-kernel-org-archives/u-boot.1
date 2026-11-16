Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0130606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l3CV9CyY;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1DeCXK/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78348606F7;
	Mon, 16 Nov 2026 10:49:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XfIPQzS_iFkl; Mon, 16 Nov 2026 10:49:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BCCB6605EC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826165;
	b=aJgub/pJpPbWiVQgFOZxKuxHsE7LyE8pHxNv/iUQg3JlB6fvgICTSich9+dryEweIPAj
	 rMu7o90iIWiW3UjsATU6gVWC5CNlEBsrMVNZUSiLFyIGEbjrJr/CP0WGC7gArR1j4xYvk
	 5dEQ8hP57Xs6DXXU9HUBpwZRWc4kHnTOsvzAJ505I8yANcVpC3cqzsCO1sn23YJ5KwzeZ
	 xkkVUO0/XSuJfBfT7kUapXuCYzW6CIZV0ukzonZS7aVO0uz7zpG+afQ8RrX9OnIk3/yLI
	 8XxzAVuzJ9GVzlOKC9HenoEikn0kOJDCrisOYHK4CT3uHqXQ7MaunrxbKhxneiRws+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826165;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9Wp+MSJsJx1oOG00S8HiZEA7JnLHZ4UjOsKUPSYCu+E=;
	b=FRANYJO3WoAxftwpGRMazBcZhuwH4Ty0WeYNstB2mOSKqD8yCzoCknAmx0Cyg5JBqLIf
	 oztEv9g18SyMGM58iTuaOHSi1Qso/gbX1+W5wahpqbrfQV8Oks80HOZCa/QxHvWoq2zfr
	 mYzDM+UfQJJpCTw1K5llRUFpUqtEtATSnA6wQwGESImRDXuMmRl4BLoet/nNz9dvYJn91
	 NvW/+p7TBP1ai97BqJ3kVs0SONxDd+j9wwEI7vGUzU+95fa1iyMXgmYhsrvBK7fSTPwZg
	 EKVkxmHk5VCse5z62GjdazMfvK4lQ0cqgsZZS1SjI7icUOzaQcPLyBxF+GGNReFyWWQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826165;
	bh=9Wp+MSJsJx1oOG00S8HiZEA7JnLHZ4UjOsKUPSYCu+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l3CV9CyYw4wq7e8wTpc+59VGsYWO3R5OwzhGfgh6Ft/LfVnTil9ZLT7vLY3yKlq/o
	 aNcknwkln1lYb39y70T5D1qpdYZhNUhkQiYP00H0Gy+u4azqGNmhjYE11ipEwqCbUS
	 mT99zk3TbDvopNBp+NfO/RFBFKRYWaPIudEanXUIm/xHcMyjTeAEZFD4RVFTRzE9pT
	 9vluOwjkPw2sONXZutuHJMEKg2ZFwiX9rw5D1axcmQuZwbY/IpPpd49bkuxfeS4Sn1
	 mVn2p49zdXAsRL3VzTvbLFlcOTB+Uu+219EMWSEg8m8OVjw0Q44boq9XXC0Zqw36RS
	 yl/BL6bsej43g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCCB6605EC;
	Mon, 16 Nov 2026 10:49:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5533E1A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B903401E6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:49:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_dCBPa1geWp for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:49:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CF2AF400FB
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=P1DeCXK/
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF2AF400FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F3CA4237A;
 Mon, 16 Nov 2026 10:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165A41F000C4;
 Mon, 16 Nov 2026 10:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794826158;
 bh=9Wp+MSJsJx1oOG00S8HiZEA7JnLHZ4UjOsKUPSYCu+E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=P1DeCXK/S0n3c3mvZGzLExMsA7vLbi7fmtLZUowZMIAmVYnIwc0xFEE0EDV+LWrdG
 6xgXSmXSEjsmm00WD0yh390KaTJv7aDxTYYcPjKVr57vkCURcmB+XZ6yAw11XdFxBy
 yCH05gnLNbRHZ4m2uJwSMhMKY8m1ZY1MsbBNsIdhLWLi/NpuQ5d7iC72EKeQ/LYW4h
 7ca4XW7HyfBrEAOBqaDEFAkSTAzjGlHUIzCZjNewFhuCiK345TEYFI4Zf21OQwdJ+h
 Aaj8/8W24CUuR2r4MZLk6rkrhoMz2+xmxJcjJCho9JV4PXqMHBRBsQubhz0YdFz68k
 zMn9/HjtUTiXg==
Date: Mon, 16 Nov 2026 10:49:13 +0000
From: Yixun Lan <dlan@kernel.org>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: spacemit: k1: drop Huan Zhou
Message-ID: <20261116104913-GKE100523@kernel.org>
References: <20261111-01-maintainer-spacemit-k1-v1-1-2b3de5f34954@kernel.org>
 <20261116071338.2637100-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116071338.2637100-1-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hung-Chun,

On 15:13 Mon 16 Nov     , Hung-Chun Tseng wrote:
> Hi Yixun,
> 
> On Wed, 11 Nov 2026 11:01:09 +0000, Yixun Lan wrote:
> > Have talked to Huan Zhou offline, he was not active to review
> > patches for K1 and wont contribute in the future, so adjust the
> > entry to reflect the status.
> 
> Reviewed-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> 
> I have a Milk-V Jupiter on my desk and have been testing K1 patches on
> it. If it helps, I am happy to be added as a reviewer (R:) for the
> board.
> 
I assume you would like to help review patches for K1? as we do not have
per board entry for Milk-V Jupiter.. From my side, I have no objection,
please feel free to submit a patch for it.

Thank you

-- 
Yixun Lan (dlan)
