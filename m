Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC25BC28B30
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 02:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0FC803CC;
	Fri, 21 Mar 2025 03:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ihdEvxNK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="m5Yshpsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10BDF80756; Fri, 21 Mar 2025 03:27:32 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC028003E
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 03:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZJmYp6nrSz9sw8;
 Fri, 21 Mar 2025 03:27:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742524047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIU92wtG+uwkAuzQSIWzoEx/hy6LeUkeMTChU0kr7xA=;
 b=ihdEvxNKku783rQ6Jq5JHWezkvTZwBxw5KrNyofT4Ax7be1UbnspHQ/mNA+AjmwsAKS/dW
 Fcl23/KRNusFxm7XzoB4INgGa9QuNQgMIGsBNK9Jj+e4nXWJYF/tbhe6cEdWhHQ1weWq/N
 tFRdQZSu9qA5WxCon+XyC+jY+RJJD7oDYAa1+fU2XDyyCnbF2q8yy06z9aBYUdxZhA9skT
 +c2jacpbtpAFaJXFSbyark/u31oCoSFYCJ++AqgLzxR6eKj/2dwtTVhSy3sQ+z3mOTtw7c
 Hee21hbh+UwxtzH0A7K1L95XanlVyhmwfsKGOLEbeONwkqQsTHR4eQyX3OICWg==
Message-ID: <2d30bdbe-ff01-42e8-bdfd-0748e0546240@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742524045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIU92wtG+uwkAuzQSIWzoEx/hy6LeUkeMTChU0kr7xA=;
 b=m5Yshpsznd6Supb968zvWbFjPOBtVja/Wm3yKaZJT9AHK/pNBCMAWq5NjHKVchDgKqbFMy
 ME7gU44iZ3kQHCel99UAX8Ce0nPLotRDnFToDHgBXQ0Yon0E74IMEs4AnE0Qqy9bkhocS7
 PS93GqHtuiaYwfV5TVRArkn1bMQnyHhuuhgSPC5HvLh3dBJ91RoNxMb1TZeqrYueGsCxUF
 sY/TfwgR0zqg659Fi/Lxuh0TtYWj+soZH4M2GnteqbFlWqAKdRN07JwTwYfLDfCdF22lgK
 eXlEwbDWZLJP0WvEWNMaflx3T3X5YTMgbha63EOjsx4yNjEdZRRzTs36jn1kbQ==
Date: Fri, 21 Mar 2025 03:27:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V2 3/5] arm64: imx: imx8mm-beacon: Enable CPU_IMX
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, festevam@gmail.com,
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAHCN7xKStps4Cyr8=WaCU5bUY_doeh4jcUHv4XFUm7CLjq2JWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e4fef8f6041d64404c1
X-MBO-RS-META: sy4a4zut5nz7jzzruuoqcr3pzjors94o
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

On 3/21/25 3:00 AM, Adam Ford wrote:
> On Thu, Mar 20, 2025 at 8:55 PM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 3/21/25 2:31 AM, Adam Ford wrote:
>>> Enable CPU_IMX to register the ARM core and identify the
>>> speed and temperature information using the driver model.
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>> I am tempted to say, imply this for all iMX8M and iMX9 in arch/...
>> Kconfig , so it gets consistently enabled for everyone .
> 
> I was not super excited to change the behavior for everyone.  Since
> the IMX9 always displayed it, it seems safe, since there would be no
> obvious change in behavior.  Making this implied for everyone would
> result in a change in behavior.
Yes, I know. But then, I can safely say it is desired on hardware I 
maintain, I think we could try and run a quick poll and see if others 
see it the same way ?

Either way is fine by me, feel free to ignore this suggestion.
