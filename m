Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD06D1359F
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44885890A8;
	Mon, 28 Oct 2024 13:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730118512;
	bh=TOCDOsIVsI/BvxDdVACKbIiUQfk/ZNUd6OIvOvkFi0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eNAFGmynMWGm2gZ4lhz+7ai0bgRAdNwOKG1nB9iJzu3kYDSwbHtpi+W7Fe3yDBGzQ
	 klVsTE7rtLs5aXIOnj0EhLWHE/6krmKKIUGAtCgH4KP7is/o5owJLzfhWSgIcVVnO4
	 GqvRl2e1dP9urnU4gGzivowillqBBqwshKqBgFIfGGWQFca2nc5t9qkLLD+YFOGC2z
	 Se8Ktx2rdi7L5syCKs9gWqT99QHh93qKgUoF+UdMvRVEhmFlkQ2VUVTQRofQmumT/s
	 yo3zKj0eONdAcvAiuxqEur8fhum9+VCKX1NGyuRI3XtOndSx8U2IPmO21WJW9Wa0qb
	 gZ4aZpAjfh5PA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0958A88360;
 Mon, 28 Oct 2024 13:28:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730118510;
 bh=TOCDOsIVsI/BvxDdVACKbIiUQfk/ZNUd6OIvOvkFi0s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QnMk3udsVHnOy4VG5NUIkTgCwcV+DNUyTya613uWmVidCpsI16aKi2P6l4ew2ZSu+
 6ABSHTU9urKN70uRNmnGy4b7qdfL7N98lCebPaNGRGM2Hqnkc3qB/jRaf0XfQQxqC2
 oGn6qbTd1mvdlB4DYIWI6nrPBtp5qNcyEaVH+wO6L08dWaDlPIutHHwXjcJ04LAAym
 PL3k7aHeW5bXkl9+MNZ4GFhJZDWj4+CKEmqY2FDPDa/lJx20eqxQDqwlzxfze0RDy+
 PNY2I0n0fMlc+PkqWKznEzA4rZM1K1vZXwei6262/2KxkHgnIN7BoQ5PydY2zgAMks
 uGBTHTcwtoenw==
Message-ID: <7689808d-e061-4f69-b3e6-42fa709e1d52@denx.de>
Date: Mon, 28 Oct 2024 12:57:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
To: hs@denx.de, Fabio Estevam <festevam@gmail.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
References: <20241024122735.893319-1-ravi@prevas.dk>
 <3606fb53-c36e-93c7-6ff9-9947ae43c408@denx.de>
 <CAOMZO5Aae_0cDXX-E9syhVPwMF7_NVu2__40m6Tmi7daePyVbg@mail.gmail.com>
 <CAOMZO5DNQ6cKyNqsQaU8CE-FwoOQdgaf99S8dQ4_FE9XZDvmCw@mail.gmail.com>
 <16b090de-2fbb-4905-909d-0da92cb1946c@denx.de>
 <c4a248da-6e16-708f-abf4-b89422076466@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <c4a248da-6e16-708f-abf4-b89422076466@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/28/24 6:13 AM, Heiko Schocher wrote:
> Hello Marek,
> 
> On 27.10.24 22:01, Marek Vasut wrote:
>> On 10/25/24 5:09 PM, Fabio Estevam wrote:
>>> On Fri, Oct 25, 2024 at 11:51 AM Fabio Estevam <festevam@gmail.com> 
>>> wrote:
>>>
>>>>>> Heiko, can you check if this works for you?
>>>>>
>>>>> Works fine for me, thanks!
>>>>
>>>> Applied, thanks.
>>>
>>> Sorry, applied it too soon. I see there is an ongoing discussion.
>>>
>>> I will wait for more time.
>>
>> Go ahead, nothing to add from my side, but it would be good to get a 
>> TB from Heiko maybe ?
> 
> I tested it already, ah, and forgot the TB, so
> 
> Tested-by: Heiko Schocher <hs@denx.de>
Understood, thank you. Nothing to add from my side.
