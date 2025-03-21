Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1126C36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 13:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E7A806D8;
	Fri, 21 Mar 2025 14:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TAo7eAn3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nYd08jDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39FA7807D7; Fri, 21 Mar 2025 14:59:52 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E7D803DF
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 14:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZK3wk0MMXz9t1c;
 Fri, 21 Mar 2025 14:59:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742565590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aQzphmpocqJKNo4J1ppkexicPK/ymEWFWn6nZEwj9k=;
 b=TAo7eAn3+Hs9xzbeFTFBZzUq0KKqN6lejYQQ1n02RhpHNQGwl4HxaZ324Z7cOrEfnJiXqF
 rJ9yCxNvGK0pco5KCPSGpn/20CRkCoOi8u5/kKJ6DU3g+gMCRD3YeDjWoHCd/tqU4DvYzE
 enVdWCgAW8EkBah479+Q1WH+ZmNfisQcYyw2olrriayUD1shSI8TIIrJTLjZ2qiXZLAgso
 hs/+5iJBdF3xnQy8UKw/QeUk36CommueYda+RKNlgdWHeXcQUGSKK8lN0gLzdx7IiOJwkw
 5TRIStHvzjnPCxTVqGmH0LwdlZEBaQtwczEXWDrtWHHdmjIXnj8SBRAZyvtljA==
Message-ID: <7e3b3474-d3bb-4d9a-b427-c6137d8d9531@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742565588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aQzphmpocqJKNo4J1ppkexicPK/ymEWFWn6nZEwj9k=;
 b=nYd08jDgYbFk/ClzCaiumAr64Mmlmf1BP7U8np8Ps4SchPtvARFFmSR+CQsN0pMayYhQOn
 DjQrtEL4/9HFZpPMcKw3XLStKdPQB45ex0+Bi8O3Rlo3ZmjO2fm2D7Mx/BVIS+Ig2RWi7f
 CAbPReemPKT+tcAOqfk/pFSpifL4msc/FnGbeqYEBr67Ayb9tP2CyGgVsurd45kyslu8ju
 SACD6Kovgd2Aq4NqsHciGCN7X1xr1Q2nDn/hgBs6NOWZMS1jaTVgUXluUmCZ1rePKutqiP
 QDy5ClYmxgAAeZAB+2sdQzbeQMDRzhtGPWWh+sS8gvYjIZZRhA6tUvFtpjbTVQ==
Date: Fri, 21 Mar 2025 14:59:44 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V2 3/5] arm64: imx: imx8mm-beacon: Enable CPU_IMX
To: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner
 <c.stoidner@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sumit Garg
 <sumit.garg@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250321013109.709431-1-aford173@gmail.com>
 <20250321013109.709431-3-aford173@gmail.com>
 <7592b048-da30-4512-b6a3-f435b6f3bc3d@mailbox.org>
 <CAHCN7xKStps4Cyr8=WaCU5bUY_doeh4jcUHv4XFUm7CLjq2JWg@mail.gmail.com>
 <2d30bdbe-ff01-42e8-bdfd-0748e0546240@mailbox.org>
 <CAOMZO5DqTbRdeL=h69wSNoMfCFLT9KGUGz7S4R67hoaB4nOZ1g@mail.gmail.com>
 <CAHCN7x+Acbwgo-Dm3fmvat=keEhwW-r5JLNn5AkXFGAaRDAa7A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAHCN7x+Acbwgo-Dm3fmvat=keEhwW-r5JLNn5AkXFGAaRDAa7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ee742cac0661cd6b7d5
X-MBO-RS-META: qkzxbnooreaqh6tds981bku5sczurk3t
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

On 3/21/25 2:27 PM, Adam Ford wrote:
> On Fri, Mar 21, 2025 at 7:10 AM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> On Thu, Mar 20, 2025 at 11:27 PM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>>> Yes, I know. But then, I can safely say it is desired on hardware I
>>> maintain, I think we could try and run a quick poll and see if others
>>> see it the same way ?
>>
>> I think it is a good idea to imply the thermal driver at the SoC level
>> instead of per board.
> 
> OK.  I'll spin a V3 which implies the respective thermal driver at the
> SoC level for IMX8 and 8M families, since those are what are supported
> in the CPU driver.  Should I expand this list beyond those?  I am not
> sure how far back to go.
8/8M and newer seems like the right way, thanks !
