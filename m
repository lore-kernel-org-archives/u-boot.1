Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8E1C197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 12:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E0B5874BA;
	Mon, 20 Nov 2023 13:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700482562;
	bh=wbsFnCsp44d09f9wwWpCoRJesUP2HPRp1f1psdsNUxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=duWmTEtxzBLk/gooQ1ukXvUie/Fg0NAuZDOqEOQ+NgFdI5+C1s+5vwD+NKINxBEKu
	 cJE4z5W/Wvy3FAiCAHkxmVx7UPXXgH9pMwTu0lVUKv7zB1nmzF+H/RVj/1mgmCkFJq
	 6tCCdq4FitS40uTnrNGNFRy7mLgj+jhF9UUUmut3esRtSxFDG6rxn1D2eCJReD6l45
	 9qBqsUKp9fJHfyOMe01s3qIXWMADnYb8LmfGoLaHy5/FV+O36ivR0wWfBJCV2i/YLb
	 YR+//KLuf0G1gpZlW9GZPAdOjYWb2UQHO4uCmd00KZOdKPntksU/P5G7yu4+9S4CRi
	 +T/zdkoq2/RDw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6B22D8749E;
 Mon, 20 Nov 2023 13:16:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700482560;
 bh=wbsFnCsp44d09f9wwWpCoRJesUP2HPRp1f1psdsNUxs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CeJ4XBTNQrq2sGU1cXrgDUr0V8zE6CtnLqLby/y9Wf+yTzkEysOHPA97l+dbW4OCR
 vM7qthLRZjrTxkC3S5THJ6IryZ40nWIa+UVa5aMwMFvjwEWzgu0/vVgGWevZJ4VviZ
 86koxyKd2nvU435otbS6XrVfyAOgn5xvU6RGMadSkz6HFZcEQQqTOgg2tFRRh7BQty
 B/ypMSB1mCKjKlih4c0Nm2Zqz/zn5FpJAig0XFDNusY6MqRwcYmMx1YqvAShp9Agys
 6Mf9Z9MtZ0+JrprFR+t+WW36q2hPY6+ju3Rnd7u/x8vzHW/P1fCZLZIdEc8UsmnrLQ
 EZJ3yIrFPFUfg==
Message-ID: <51d7ba01-bb22-4246-b67b-675511ca0be2@denx.de>
Date: Mon, 20 Nov 2023 13:15:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] USB fixes: xHCI error handling
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Shantur Rathore <i@shantur.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
 <fe844c63-0c44-469c-a4e0-f0e1f2ac63fc@denx.de>
 <CAHc5_t2WFZH65MJENGvC6u21ETcRn47ceQd8jrHV9DVmmM10Vw@mail.gmail.com>
 <3b662808-e047-4023-a00c-1b6728bd5c86@denx.de>
 <cdb3df49-1ba3-4b87-bc2e-57c71a7ce725@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <cdb3df49-1ba3-4b87-bc2e-57c71a7ce725@marcan.st>
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

On 11/20/23 11:45, Hector Martin wrote:
> 
> 
> On 2023/11/20 11:09, Marek Vasut wrote:
>> On 11/20/23 00:17, Shantur Rathore wrote:
>>> On Sun, Nov 19, 2023 at 8:08 PM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 10/27/23 01:16, Hector Martin wrote:
>>>>> This series is the first of a few bundles of USB fixes we have been
>>>>> carrying downstream on the Asahi U-Boot branch for a few months.
>>>>>
>>>>> Most importantly, this related set of patches makes xHCI error/stall
>>>>> recovery more robust (or work at all in some cases). There are also a
>>>>> couple patches fixing other xHCI bugs and adding better debug logs.
>>>>>
>>>>> I believe this should fix this Fedora bug too:
>>>>>
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2244305
>>>>
>>>> Was there ever a V2 of these patches I might've missed ?
>>>
>>> Is it this one?
>>> https://patchwork.ozlabs.org/project/uboot/list/?series=379807
>>
>> I think so, thanks.
>>
>> And uh, my question therefore it, is there a V3 which addresses the 3/8
>> and 8/8 comment ?
> 
> Not yet, no. Sorry, I probably won't have time to work on this in a
> while, currently busy with other stuff.

I can probably fix the patches up myself if that is fine with you, I'd 
really like to get these fixes into the release soon. Would that be OK 
with you ?
