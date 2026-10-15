Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49966CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 07:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DA19608A8;
	Thu, 15 Oct 2026 07:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OgXAbu-fNx5a; Thu, 15 Oct 2026 07:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6BD5F60787
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792049682;
	b=oYurE5cRLyqHPuTox6fx476l4D2CWycXa7czVHa830CC+ib7BMvkyRVvXJEYid9ZoF96
	 lILFbl5pRBrgLFUPM18g8YEgJEyw+KTrvj8WY27CgBgWZQwedN+8B/W26/ZFBV40Ig0Xf
	 QwzWuz7JqOinTiQJpzRtr/bXzBaJLCWIWLmwR1c8QH6KCnZk0IXUgQ4e+5DGJ/7YqgBjs
	 QEeg7+VKCs1UdmHehTvn+L/JCEs4TVJ8Z+140fbVazmFwMdnMOg7xNaejeSQOsThYr+xL
	 yiRfX6Kh0nHnMXdugJN40+W5UhJqUS6F0jCpDys7X/OPsJGLKoRx2kf3kaTkkOExfeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792049682;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jtu/ef/O+jluoDkpNtV8x1rvTCzEpQX6DzlneP6bBKI=;
	b=eokmrme0Bp2xYHFKpfvPGAj4mpF3heJ54PWDZ7q/RCxIQ3tMUNdZH4kDlkcEcShgUabE
	 exe/DP8jQ6tWxLYLl35jKuB7sZcIMGB4O3GI1feZ6ALnve66764c4WrysFon2w5Ob9A/I
	 tMfQ+q/+11+QBKM18xtMBpOvEdmnIShFIl8UWgmoPKHPZoINRhKlDeQ26098VCjjqpDq/
	 04iFHwCvxqgj4ofWqybmE/AT4r3n91XbIkV+s/3CoADUJ3Cgzudqb9GVnyvoHzfgE7DDF
	 2TV2bjp6k7B3nh30ICIn/3whFHkTZJHTVD6OHSFNtBW/OAA8KABGWfazMxgD7MckqfQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=ASZIQu2D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792049682;
	bh=jtu/ef/O+jluoDkpNtV8x1rvTCzEpQX6DzlneP6bBKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hC+5B/txweQJX+fDLVfGW1Qg9IVd7jrOABV86jEAFhYQ0FVGUnT4B4AZh7jGAG0St
	 3NT3f3BYVw/hmNhYK1ubSPpNmsKGCIvUKSkoNFAthHJ+pOySXRsIEI7ZfO6UxlwthH
	 j/Ts92ly1ErxOy1DVOlnIKEgUNwF2gK4o1KW4ZfjQfCEKEhu8scks5rj99a9U5MEw/
	 198TrluPWZpV5yhgRv4imW4NZwkAF3tOZkW8ES9aGDSU1JiLtziAtyr7zIToQBsa6J
	 15e5phE1r2nKVHkb9G+y78wnseUwrTBphuarQkjE2mE2nZjWFsKYxyjc39hOK1Nl2s
	 bsjDcNYKC+hyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BD5F60787;
	Thu, 15 Oct 2026 07:34:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F3328769
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E541560745
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8MkpQdQljmLl for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 07:34:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3C92B60787
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792049679;
 b=SKwauaRk1weG2eClYUqVq5mgI7AsXc6xtbfJbBcE8/o6+WXegea67j5pywuINXmLYKJz
 Sak8Wt+bDhH20CIIVaLDbkcYWNy96O8eH0URjZRpHrh4arfqAq1JA/j3y0HS1OfkxXz0n
 MnYUPg6VAWGydqqTCzQ3f+wplO0I1LXdli/m725sMtCHLqN09cCbB41Vb9oo7d+PXB2W1
 PCWG/ng7NRq8uwLa2A7hmCvCmdXKQnYrY6YFMpqxzfTNCTnkC+1WJ5kuG2+l0tOHjHU6O
 WzIRAtpnpTt21mJevVLxTCsmvBm86pDJn6i8bzDwko8m31EoYmXZRfdUGuDpKlrmkpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792049679;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=jtu/ef/O+jluoDkpNtV8x1rvTCzEpQX6DzlneP6bBKI=;
 b=DqxH+Gb/eYrcyuS4159aGazQQiDB77+GBDsaY3WUn+FdWwtR10D2r6glm5oigOyngIH4
 fHU57tOBTl5yX7Q/al0CSkmoHHZNKJSTCLh0DTjJzVnayqzNzOw91N5TSuI3f8I1/kqOK
 JFVtWiXpbnh/5EqC1zKuv7sgO9bsIabcQzOw+HH/z+6uS5MR3wzonwqfRLhLWkZYnvpe3
 5AfbVdzgnL7lMC7mfMyBLPplUT5aeefJF66Tr3R3Lpm4LD0jSQvuHXE1BZa/gTcOlikXT
 cP++mZEPAOhr4JouTM4ImvkKBPkZ3N+w2nt+LvDvkSbXDPbfF/PxqriJS9Z/2aiDS7A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=ASZIQu2D; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::11"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::11;
 helo=smtp2-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=ASZIQu2D
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C92B60787
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 07:34:38 +0000 (UTC)
Received: from L30177.local (unknown [78.240.198.129])
 (Authenticated sender: vjardin@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id BA4DE20039F;
 Thu, 15 Oct 2026 09:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1792049676;
 bh=BjYPns6zm2EzJujSCrkDevgIfw2IcNyT8YaSVGOaLkM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ASZIQu2D0pqGxlOeopsSmb7D44BBfOl3XON6Ce+SuH3W5MhI4u29NApoJc9nBturl
 YngO3yG57gAJ8eE9YhLMvA9P+PGxGQy7wYxTac1Iycu0lNRstcYHQLjCJ1yH6RLg+z
 8WpxvQRHQVwPNefxTOJ3nkqTNyjUNZb52SOEbc680CuLKTx+eWNq8Y8pIzuSckCA+l
 68nRyqHKYqODVK3761r2ZikbmGyRa7D+wTMxkpBn6TFT4WtJuYDilnI4LO3XKXy8X1
 /xCLa6FABTsB7ifQ7k8GuBjAwOB75cfJn6GzQ+0MpWpRD0DY9mS+lrYRH4Do+90sDI
 iha8g23b9BBRA==
Date: Thu, 15 Oct 2026 09:34:24 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v7 00/13] board: lx2160a: runtime SD 1 lane configuration
 for LX2160A boards
Message-ID: <atCCAEjYE5zyCTqW@L30177.local>
References: <20261008224228.512353-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008224228.512353-1-vjardin@free.fr>
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

Gentle ping on v7:
  https://patchwork.ozlabs.org/project/uboot/list/?series=527129
patches 01-09 and 13 have your Reviewed-by, but 10 to 12 are missing
your reviews I'd like to get when you'll have time ?

- 10 and 11: only the lanes E to H are reset now, as you suggested.
- 12: 2x40g from protocol 13 or 20

Could you have a look when you have time?

Thank you,
  Vincent
