Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29C0C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7507486FB2;
	Thu,  2 Nov 2023 15:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698934002;
	bh=JusO9bzSa1PVFf7lxV9toV0slGKEALNOKRDsbo5z28s=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=eM+LIzUhhJujVJGMOJpw+hvOFTnw5a1vIXYrwJX8apU/5afZvEhEVqxpfwEChgdAY
	 mnl5YBPx7Y6HgXpUC43y0Tk6T+5sCtPy6RqkEsi6k+neP2iknkh67n3y/7ZLvXwjsN
	 vRv8BtaJSDUgUyzgQyZKzfGTOH6jcxnfOnvmG4mCCufmUC0hh+Z9Xjsm3Fi4ZxtDVp
	 EgF61MT++N3CLr5QaOSfx2CkX5akRQgoWys5RwoGokuPfQZ5txPRmzDH40HEPxwJ+O
	 qmZ7asagDDajCS2I83XOMBi2YENfdSxbGitoYkPJmFXnXEc07cFwV2GFQw1CIq0cmZ
	 /wOVPiW+TjmMA==
Received: from [192.168.1.107] (82-131-157-32.pool.digikabel.hu
 [82.131.157.32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 691DF8701E;
 Thu,  2 Nov 2023 15:06:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698934001;
 bh=JusO9bzSa1PVFf7lxV9toV0slGKEALNOKRDsbo5z28s=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=N4UffkiD9hx9SfFPe3oODdZIbBoYZwsYLYtsNwrJlr1NCZvsXVQj7F05hxeUtnIk3
 E348qnSH+oLbdZ2TttkUdfDpmH6m/HEJMDd3OOieKxDiv7/3vWiJvP3AyG17kSnOSf
 9b8kUwHOLcEioTFlgcat20sI5inI5BhPG1bOP74dP9VQbvsv/KW4cNOBV3675xN+pr
 nF3ds9+TpM56USdSmA5xn2VRL8Ye8RrEJw/vERsjYQXsWV9vBLs0dOO0EHetYwNlbr
 6lmYchq0Icd8Wbpf5gCh4tPoLYlPvVholAheXDD4LSOozQiDZYlBdnhq1eElL/s77y
 D/jz/Aembhi1A==
Subject: Re: [PATCH v2] i2c: nuvoton: remove standard mode only
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, YSCHU@nuvoton.com,
 KWLIU@nuvoton.com
Cc: u-boot@lists.denx.de
References: <20231004013558.2828546-1-JJLIU0@nuvoton.com>
From: Heiko Schocher <hs@denx.de>
Message-ID: <30b596b6-feeb-128d-37b7-e6e213811e77@denx.de>
Date: Thu, 2 Nov 2023 15:06:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231004013558.2828546-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Jim Liu,

On 04.10.23 03:35, Jim Liu wrote:
> first version is only support standard mode.
> remove this judgment to support standard/fast/fast plus  mode.
> 
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> 
> Changes for v2:
>    - add commit message
> ---
>  drivers/i2c/npcm_i2c.c | 5 -----
>  1 file changed, 5 deletions(-)

Applied to u-boot-i2c.git master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
