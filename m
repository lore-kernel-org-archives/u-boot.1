Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8215CC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 15:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC900880D5;
	Sat, 20 Apr 2024 17:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713626079;
	bh=pd0qYJDNEPClVEKwn0qZVBcfEvj99sLFgvROdKvqQVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rnfbgIcJia5NybJBWemqa2NOWJy2CFEd5psd+VXxlTp2AiyvG6sjA3eX/jDaONujO
	 DA/GzI/HD41dQKX8uIiiE65kNxYhPfpcE6MdToaJRTHZxE9R9fW2kt4gW1HADCpHXG
	 9Z0wCfctP7zcOAPixsvBOQRfqEQmIjJFTYmEhKte9TdCXf1lEcK8DipQvI4Q6HnE11
	 AUOLzJfbF6XGurQBYW7NB4IAT/cngXv3+7VrioIaxjd6gVhUASK8MmlCUM0tLMNVat
	 bSPLADrDz/wKaI97F19QMujyQshupjoo8GYYMzCsc98dZSxNGLb1wZfF1w8SeOywdA
	 UrMGppW0u2oLg==
Received: from crub (p508b6ab0.dip0.t-ipconnect.de [80.139.106.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 88AC0880C5;
 Sat, 20 Apr 2024 17:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713626077;
 bh=pd0qYJDNEPClVEKwn0qZVBcfEvj99sLFgvROdKvqQVU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mmEg7J1AiYZ67JoyjzqCTaZHI9YF7M7qbobhQsB3BNOb4HOdUiJOTTNmCGZcgTShf
 0twmeM6aepxSAP8mEnBd2BM63v98axjom0ZH3eJtErdVmNVPCWnK7Y83dP7H/8KNTp
 RB8/WgZ21HAO6hZhSojO8qNnsg3uU87b14PDDIS3YdQq52+VuaGIknGxDju5C91vLW
 QwWEplhMl37VWUOhXQw8nYWiJKJEQGvVOIKZpGZntn1wHHM29VfrUchJEwuw/jm/0U
 5mdS/K+3o4zLuo1cG8CbXz0lKZuk76cE/R6GL9xsFJij1nAAmokFo3dbhp2MEXkflB
 0yEL+oSY5Zj9g==
Date: Sat, 20 Apr 2024 17:14:17 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Jonas =?UTF-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/7] Tegra panel improvements
Message-ID: <20240420171417.6c7a0781@crub>
In-Reply-To: <20240419140522.GL1054907@bill-the-cat>
References: <20240131065721.4245-1-clamor95@gmail.com>
 <CAPVz0n10Fb4H-Haj+s-Jjt_UgpWXSSWOFdJVeJATwTr22Do5_g@mail.gmail.com>
 <20240419140522.GL1054907@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 19 Apr 2024 08:05:22 -0600
Tom Rini trini@konsulko.com wrote:

> On Fri, Apr 19, 2024 at 02:29:20PM +0300, Svyatoslav Ryhel wrote:
> 
> > Hello Tom! This patch set is hanging in patchwork for 3 month
> > without any comments. If no one has anything to say, may you
> > pick it into master?  
> 
> There's a number of video related patches outstanding currently,
> Anatolij will you be able to put together a PR soon? Thanks.

I'll prepare a new PR today.

--
Anatolij
