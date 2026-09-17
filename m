Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1163C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 15:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3FE480F21;
	Thu, 17 Sep 2026 15:19:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IkeB7urJ4Srt; Thu, 17 Sep 2026 15:19:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D359580F23
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789658388;
	b=ozZaXRt7WzgCiuEWJVL6eAmO/alsjvAhL59AwL68RR631M/t99jDGpg5q8LDOK2yLIW2
	 MYfQrDT1ORyqwDCnEJ5uozRQkM7LNJR2qisHOrlMN1tlXhrPB70msF+YntWdnIMcpdVUM
	 VnjmxXri5bIATOPhw+07ZWFcPz+sTmLHGBzckZ0m4mM4vmvoAf/afynp0U97+3FcE+/e0
	 OTrSuM01G/WB7vljpPn6+CuraA5+97R2WY1KJaVz2U6gHBMF5LvhHhE7TJLi6xQHELcKT
	 QROst0OH2YJCg3/YmsvDnRuP2bThweUfAVnkqya69Kd/xTdtIi94L5Qc+cF6MANMfrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789658388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QMe2HOzK4jP7Dypo3+vZ1TvmOtdaJulUIIUwRQfiyQw=;
	b=jyTkFzAEpZz/RHfeBOWlvKd3ih4Eti7jwK7PHIZWXKsNN50wdOZAemhAmNeR63zNGs8f
	 V+82y+Xn4zwhztduMH4kwwj1z8GM0KCkjW1cKyVQAfy4hSLmEvCCyvL3IQdSKBz+bUinI
	 LXBiotRQP/FYXLtTS/lWLxKAnr17+V7T1nafwq0JCjCaoaaALzIPEZHJTHb5hs9YoeGB4
	 d/r/dBEpdh3fU35gdD23csK/mG93ro6aTQrhMERcHPLx4Gtgwgf6of7cLfUR3+FNBwXvk
	 FWNJ/Xtq/tuWgNWtG1GkcdDHvz4NcLCNPyqgHMCfRwI1Hx76hCV2gi+j+bdkE8Bq5+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=K5mDOwOI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789658388;
	bh=QMe2HOzK4jP7Dypo3+vZ1TvmOtdaJulUIIUwRQfiyQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jxGo2Ei21C7XN2ZdIjuG2YVFDNhej3b2B9hffDfeOVJeq20zBHDLXlVhIHXvkOF/0
	 Dn7LLDRAAcIoj5LJxlCSSyhqAN9/IQFZ+r8bzNs6o787BwNdoHjbUeLCYs5YBu1KWS
	 0MXKdbuC61hJmoFCq16lM2ZEjr/fOOKU/V7RCd6uh8PL6VLbkLQrAadqk1OFf/KvlO
	 G3/NA/jObV35+RtTi1rq9ut8h20WrIUGlqUbN67hYh3GJBfY9qQ7US2xwJbdCNWnT0
	 KQ302OTj44n8Ctvsu+yubm4gMGntLs7hGnPMCdKZv/JrQg5pzTjI/JpQ86kwlF+MWe
	 CfY8Tphb33mcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D359580F23;
	Thu, 17 Sep 2026 15:19:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C079D3AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A660B80F23
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:19:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6NSuw4Gezo2Y for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 15:19:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 94BFA80F21
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=45.157.188.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789658385;
 b=LPOrgHsHqqg1Ps5vKZ7O2SNuezZN3yMNY3SVFKKMdXFxwLh9z33Ve6k+EuwpRCxRs7ok
 L+il6yM0gm93R43Zgn43T4PPolTch2z+CtDVOgWrKdYPCHCDQZ2g0KrcxESM3cCP4j31m
 Gr/PhoeP23CuBVjF+g6QLuczLYibZt1K1eIsnlec2ojy9psGve7MJgBk3/o8Rlzg6hTF4
 kMoG96zwGtVnOtBr5rD7Krt04hLEMoeceLv58b+X53+WuZcc1Zu5ecbh1H5ZHRl9gsAQe
 bZKnCJnwpxkAm1L2h065j67W/NbrhI8Xfjmpn5/S7VOop9qYJqghVdE85QIRshpndsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789658385;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=QMe2HOzK4jP7Dypo3+vZ1TvmOtdaJulUIIUwRQfiyQw=;
 b=YNRRbK5mC0Zyo8Ih/HqR0BdCbFUV922gaSXCAMIsHohafmBE99yVaKwxaHlHmROuBuOS
 RNslOiAjqtmvggnMhaLyJK1WnSxrn2swdaF9gVD494KWPESc3LF/bF+jlzmHi93hoEdIC
 EZJJVwfJvPf517a5AM0aIhKMELNxcjj0cjpBvROQ3vFKN9CDdaivrxkzWYSF1IOsEdVZt
 sr1Y7aW3rGrFcEfVCN9t/dypx6HY2i91gvgCSgook2MuYLsdzchlzbqytzpHVfjFl7dZG
 ahMtm5SVXAmRYPV+Uro7VkmFmX1bn4yQHXZMnsVnDaoNLQ10UI88f+ceu9Yj32JCc6g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=K5mDOwOI; 
 arc=none smtp.remote-ip=45.157.188.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.9;
 helo=smtp-bc09.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=K5mDOwOI
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94BFA80F21
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:19:43 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hlzkH1w4gzl26;
 Thu, 17 Sep 2026 17:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1789657911;
 bh=QMe2HOzK4jP7Dypo3+vZ1TvmOtdaJulUIIUwRQfiyQw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=K5mDOwOIFsCERelrf7FTkQr2mF3YekM/CcQnN79yjluwFyNlODj67pVYxNWftw4zU
 /wgiylIXxnYTaiaiyB8lC8c9FpC/qB19NoBqwyaWp8ptEnhObhtguKE84vwGJ2Ilbb
 eJTI+/VlI9/O8ncYOGiiqTkCUoEiz/yJvueT+NXSVz7mjj+lHpZYlxb3jsazaodEcn
 LWPt2ynSlWqL6YD0tTXSdX3LJnEwgLfS5oH5/qSowQk3fTr/4RbNuEH6MkrSkjWxmo
 vAPGYjBguvfdL0dAsL07NSLnSWNyvWGgs7I8ZXMXJ6hmu7p4+avLTz1KtgBCAQuQ2+
 d8+gfWNREq0kg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hlzkG1GyTzK6d; Thu, 17 Sep 2026 17:11:50 +0200 (CEST)
Message-ID: <a634939e-d34b-4119-8856-c75740b33014@0leil.net>
Date: Thu, 17 Sep 2026 17:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rock-pi-4b: add config and fix dt
To: Jean-Paul Etienne <fractalclone@gmail.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
References: <20260917-rock-pi-4b-fix-v1-0-1b3b52c38ed2@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260917-rock-pi-4b-fix-v1-0-1b3b52c38ed2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Jean-Paul,

On 9/17/26 4:04 PM, Jean-Paul Etienne wrote:
> This series add a defconfig for rock-pi-4b and
> fix rk3399-rock-pi-4b.dts to account for SDRAM LPDDR4 params.
> 

We already advertise ROCK Pi 4B support with rock-pi-4-rk3399_defconfig, 
c.f. 
https://docs.u-boot-project.org/en/latest/board/rockchip/rockchip.html#rockchip-boards

Can you try that instead and report whether something's broken/not 
supported?

Cheers,
Quentin
