Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC50FC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1E08007D;
	Fri, 18 Apr 2025 16:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744988013;
	bh=xYZEF8wwCmOkQd0LwySA5Rmjk9hSWC1I68aeuJgEmB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w+SCyx3var0YjMTx5Lau/bV43JpXdDkpZLiP/vP6ZF5VAKWX2ebZOKP4SJsDNrOA1
	 A/TaQ3+Ku1bpfPjN3eYK6jzl5LYWMQCw5PQ1ofgJha2saPo6VPm7HWOAdGcLNZkyhO
	 AMnLGO4YxxhMrOyHy2dsAxwcVb0F6ltM8mmoLdtxf/hDi3BO4PSZ35PG2hVyLOv4Ta
	 O11mbwM/mIO3l+omobr1Mz9L/MIxq820OQdQZDY/SzSIFcQEfGfzjkPSr+MHJqQ1wF
	 /VNR4wbzm3GUueOsKb6bt/gzMzuBq3QPfIoJZCpsCa/d+Fa2jTi5eYMZbGNt4xBnQH
	 Dcn4KObm51QMA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 702A082EBE; Fri, 18 Apr 2025 16:53:31 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B49F8004F
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="WwuafUa3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6CFE0102E6336; 
 Fri, 18 Apr 2025 16:53:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744988007; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=xYZEF8wwCmOkQd0LwySA5Rmjk9hSWC1I68aeuJgEmB8=;
 b=WwuafUa3hkMhMMIUgqSyjaBympEtsG87Htiem3Yp9BAqAACzdgCqmPbZpgqioe1/vv+akx
 BuNytdpdma0wBZR6Sds09An3K0Pi2avngQO8mQzYzRSm6ZTwU5Q6HzikAnugF/IyG2Hpj3
 HhsKDqRmAcoJP6Wmy8xbmdjC16XCZDGaLbPxrkWpdpcbqSzAH5MSFAvmWqWzGrl1aJrSt5
 94Xh5cWyxeoUPRojOTiqOzMfQF4xKkFf85fK7noAOSI1GSUDg1PaE5vLkaLQVM9jeTQUfu
 PMUOazNzHSh8i8J1LuW2g9htmZNIcx9eIZIUyiHExj3K80Elr5cf49aGBt+tJA==
Message-ID: <9ad16a12-016a-44f4-bc6c-f4f6c1126b7d@denx.de>
Date: Fri, 18 Apr 2025 16:49:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Adam Ford <aford173@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>,
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
 <580024ad-b22e-424c-a1a2-84dcdc6d24ff@denx.de>
 <CAHCN7xKvdKCnU-PRuGiNuDG9hGuk1Ea=jGtsuGaHd4CCxQximA@mail.gmail.com>
 <6040628f-8463-4f56-8395-9c4a509d3b18@denx.de>
 <CAHCN7xLYWOiT94xcXmN=oRv8_e8nh0JVu6OJmnm=n+ZU-Hx08g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7xLYWOiT94xcXmN=oRv8_e8nh0JVu6OJmnm=n+ZU-Hx08g@mail.gmail.com>
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

On 4/17/25 2:34 PM, Adam Ford wrote:
> On Thu, Apr 17, 2025 at 6:31 AM Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/17/25 12:51 PM, Adam Ford wrote:
>>> On Thu, Apr 17, 2025 at 2:24 AM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 4/17/25 1:58 AM, Fabio Estevam wrote:
>>>>> On Wed, Apr 16, 2025 at 8:47 PM Marek Vasut <marex@denx.de> wrote:
>>>>>
>>>>>> You are not supposed to use "clock-output-names" for clock look up.
>>>>>> You are supposed to use "clocks"/"clock-names" DT properties and then
>>>>>> resolve the remote clock from information in those.
>>>>>
>>>>> What do you think about registering the osc clocks like this?
>>>>>
>>>>> https://paste.debian.net/1369857/
>>>>
>>>> It would be good to include the patch inline in this email, not in a
>>>> link to some paste site which will go away.
>>>>
>>>> This also does not work in case 24 MHz or 32 kHz clock are provided by
>>>> something else than an xtal , and it will also lead to instantiation of
>>>> the same clock twice. The clock are already described in DT as
>>>> fixed-clock , there is fixed clock driver which binds to those clock
>>>> based on their DT description , the problem here seems to be related to
>>>> the look up of those 24 MHz or 32 kHz clock, not their (re)registration.
>>>
>>>
>>> Since that patch changed the lookup of the clock name broke USB on
>>> multiple boards, I would like to recommend we revert it until a proper
>>> solution is found.
>> This would also re-introduce the bogus clock-osc-24m look up, which
>> requires workarounds in DT, so no. Let's actually fix this instead of
>> reinstating broken workarounds.
>>
>> Does clk_resolve_parent_clk() in clk_mux_fetch_parent_index() not
>> resolve the mux index correctly or something ? Do you by any chance have
>> some -u-boot.dtsi modification to the clock-controller@30380000 node
>> which changes clocks/clock-names somehow ? Which mux does not get
>> correctly resolved here ? Is there a simple reproducer ?
> 
> I am not modifying my clock-controller node, but I did spend a little
> time looking at how Linux reviews the parent clock names.
> 
> In Linux, of_clk_get_parent_name() will look for 'clock-output-names'

This here is not about finding out the clock NAME, this is about 
resolving the parent clock driver instance .

> and return that value if it's present. If we go with your proposal, I
> feel like we'd have to traverse to the top of the clock tree to get
> the CCM's clock associated with osc_24m, and then compare the clock it
> returns with the clock we want to see if they match.

Have a look at my reply to "[PATCH v2] clk: fixed-rate: Use 
"clock-output-names" to name fixed clocks" , maybe that clarifies how 
clock resolution is supposed to work. Clock "NAME" does never enter that 
resolution, except for mapping of local "clock-names" array offset to 
"clocks" array offset, the rest uses DT phandles to other clock nodes.

> If we follow the Linux method where we try to fetch the parent clock
> name and use the name associated with it, we could simplify this.

Linux does NOT use clock names to resolve clock in DT, Linux does use 
"clocks" and "clock-names" properties and phandles.

> Another possibiltiy, is to change the name of the clock at the of
> registration to match the name returned from clock-output-names.
Sorry, but no, this is plain wrong.

... and let me ask again, how do I reproduce this issue you have ?
