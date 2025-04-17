Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31B3C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 07:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BC6382FEE;
	Thu, 17 Apr 2025 09:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744874656;
	bh=bIsSc+2KMkby039wHfF7wGeUv0iu8QUVPCFpM86iLAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f7BGqQ5sApztOdBeAiLq9mtdNb9FBn4p1+fgPtE242YLOkLCqrNgdqVWDtWk0e1s/
	 XA8BoGhnQBC0L8VzMp1l6sVBj76baaiCYze84NnBD+ZNhFdYA1z76WV3PxoY+/wDJ5
	 5dyYzg+ica4Lm5+o0HPODlsck44v5PsuAqE9xvhD2zuxHQnohIbNbtZsBxxrDwn0ea
	 56qXhl6XSm26JAWVuEkdzOHd90pjObeof4Tt0kg4O3U/TagrCWJ74Jp56DuOFBOvFU
	 /GPwG0ht8s88moRAINcdyc8Kgg1A9xNh9Lu3/uIziV1r0MEcGqF9n9A4MYckqWSFf3
	 96tq29BseMfzA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E0682FEE; Thu, 17 Apr 2025 09:24:15 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89F482FC7
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 09:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ha10gE3L"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 467FD1039EF2C; 
 Thu, 17 Apr 2025 09:24:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744874651; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=bIsSc+2KMkby039wHfF7wGeUv0iu8QUVPCFpM86iLAk=;
 b=ha10gE3LWotXTkIBhBvm/VciVvbWdUR+9l+hZMpYFZygQRh/oDitSvzV/35NsfxLc0ESpj
 TpyVIGdnkDhR+xC8NfX7aJBymxbSfo6/SbNrdahFLVsiQOYNoDL+86KxlWWxGMxBTN4KdJ
 Drvm2akrJ+baD4OYSTx1Hc5501PJZNqa/h5xIsRY1f31gW0wfdMDXtTN0v2W8qK+Dqpi+3
 Uh6mlAGJXaznNQKVfVLDP4lH7brc+eASiKYJm3QU4YzDz7lf/H2Wth7YAITB2m/7VQuDrP
 wiyzsLIwBBc5Vvq6vY8jm3/LNtHVD1oUfI5LtWfn83NQycs/rI/ML+eipmZGHw==
Message-ID: <580024ad-b22e-424c-a1a2-84dcdc6d24ff@denx.de>
Date: Thu, 17 Apr 2025 09:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Fabio Estevam <festevam@gmail.com>
Cc: Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Francesco Dolcini <francesco@dolcini.it>, Fabio Estevam <festevam@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
 <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
 <20250416092639.GA24345@francesco-nb>
 <db2d623afd944df2bca6d1e4657d4031@dh-electronics.com>
 <CAHCN7xKyoBQPeXDA90-kcBTw7BhObvn6PVzreoUQ5+GjiCewyg@mail.gmail.com>
 <CAHCN7xLgS7FZ4ajbBa+p-_w_s6oHnfMYcZEMsNBNkqkgAG-7Jw@mail.gmail.com>
 <b35218ca-df17-4423-9932-a2ad0ba14e50@denx.de>
 <CAOMZO5CA0_GUr2uQtQgFHe-9wVDCOQwo5HZzZ4sibXEPMpe8cA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5CA0_GUr2uQtQgFHe-9wVDCOQwo5HZzZ4sibXEPMpe8cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/17/25 1:58 AM, Fabio Estevam wrote:
> On Wed, Apr 16, 2025 at 8:47 PM Marek Vasut <marex@denx.de> wrote:
> 
>> You are not supposed to use "clock-output-names" for clock look up.
>> You are supposed to use "clocks"/"clock-names" DT properties and then
>> resolve the remote clock from information in those.
> 
> What do you think about registering the osc clocks like this?
> 
> https://paste.debian.net/1369857/

It would be good to include the patch inline in this email, not in a 
link to some paste site which will go away.

This also does not work in case 24 MHz or 32 kHz clock are provided by 
something else than an xtal , and it will also lead to instantiation of 
the same clock twice. The clock are already described in DT as 
fixed-clock , there is fixed clock driver which binds to those clock 
based on their DT description , the problem here seems to be related to 
the look up of those 24 MHz or 32 kHz clock, not their (re)registration.
