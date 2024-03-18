Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59168C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 05:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7466C87D66;
	Mon, 18 Mar 2024 06:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710738366;
	bh=3INEeR1iqovwSX+ssDowiNk4M79NIltIjZ+lX28kkC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PTylpzCpd63oJ2Qb/fkDnD2Yn1l5wondXN9C2NjwpEDryDBMubulQZD8J6IKiy0tV
	 0vUugUTRVbCJmkYNcrealaOGeFf/BUifeRPrBDyGbxPjVv4ggZMtMMwSPNrugPOZuz
	 0+p8HtZMCl9mbyQus48bo3hJYzw0RAm+AgsbL7K38x/gWrbdPMAvGqyZLckfrjKAPw
	 XO//Je94/Wpo445RvgsV83F4azie1DTQK7VfFvh6MgF6O0ZilwNAzt82arZ5FpIJaH
	 Xq212WTPKuH4LsRX7JCeiAfkRWP0MJVaKbyUZF1Xjh4zeRE6p68p4JC4euldYoQSaz
	 UhTgbFapcVXPA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6F6BB8752B;
 Mon, 18 Mar 2024 06:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710738366;
 bh=3INEeR1iqovwSX+ssDowiNk4M79NIltIjZ+lX28kkC4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AxuBuPNea/oZfQ5pHoJ7urc7cYY57p54mG69Lio0O0MVgVDiw7Ho0C0rJZMg5aPfo
 rlPh2Vei0Uao4kbCUr4NQrgwWsseE3ysOEI4KWL4bCHhjU4yIwlCsi7pQj8/WtVdeX
 orBzN7N1aX6VN0NYwfZCf/NhQTc5JAbKe00TI1dmoCJB+lQ6zOUaFGEixe4JXA/STa
 O4IaxXIS0adBeAX2IuKqNvnTVuyeiQj55m1TNmIspxGvUvpHCkWI/zurq0H+9ubSqY
 KkmVNLQuWjn+31cBwYvDDqbKyOEZBzRywqsN+34Qi2IkWc3O7/OS6wkpB3kTdK52NQ
 TWYqnbmRzBctw==
Message-ID: <540cbc3f-a9bf-467d-8aa2-c56e53cd7123@denx.de>
Date: Mon, 18 Mar 2024 06:06:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] usb: Add environment based device blocklist
To: Janne Grunau <j@jannau.net>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
 <22be2258-ff20-4e62-a169-4748cbba4904@denx.de>
 <970e9686-4bcc-4cda-95b7-e5cb470682b0@app.fastmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <970e9686-4bcc-4cda-95b7-e5cb470682b0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 3/17/24 7:15 PM, Janne Grunau wrote:
> Hej,

Hi,

> On Sun, Mar 17, 2024, at 17:18, Marek Vasut wrote:
>> On 3/17/24 12:07 PM, Janne Grunau via B4 Relay wrote:
>>> From: Janne Grunau <j@jannau.net>
>>>
>>> Add the environment variable "usb_blocklist" to prevent USB devices
>>> listed in it from being used. This allows to ignore devices which
>>> trigger bugs in u-boot's USB stack or are undesirable for other reasons.
>>> Devices emulating keyboards are one example. U-boot currently supports
>>> only one USB keyboard device. Most commonly, people run into this with
>>> Yubikeys, so let's ignore those in the default environment.
>>>
>>> Based on previous USB keyboard specific patches for the same purpose.
>>>
>>> Link: https://lore.kernel.org/u-boot/7ab604fb-0fec-4f5e-8708-7a3a7e2cb568@denx.de/
>>> Signed-off-by: Janne Grunau <j@jannau.net>
>>> ---
>>>    common/usb.c              | 56 +++++++++++++++++++++++++++++++++++++++++++++++
>>>    doc/usage/environment.rst | 12 ++++++++++
>>>    include/env_default.h     | 11 ++++++++++
>>>    3 files changed, 79 insertions(+)
>>>
>>> diff --git a/common/usb.c b/common/usb.c
>>> index 836506dcd9..73af5be066 100644
>>> --- a/common/usb.c
>>> +++ b/common/usb.c
>>> @@ -1084,6 +1084,57 @@ static int usb_prepare_device(struct usb_device *dev, int addr, bool do_read,
>>>    	return 0;
>>>    }
>>>    
>>> +static int usb_blocklist_parse_error(const char *blocklist, size_t pos)
>>> +{
>>> +	printf("usb_blocklist parse error at char %zu in \"%s\"\n", pos,
>>> +	       blocklist);
>>> +	return 0;
>>
>> This could be static void without return 0 at the end.
> 
> the return is there to break out of the while loop on parsing errors in a single statement. This probably won't be necessary after using strsep and sscanf in the parsing function but see below.

Ahh, now I see it. But then, shouldn't this return -ENODEV here already ?

>>> +}
>>> +
>>> +static int usb_device_is_blocked(u16 id_vendor, u16 id_product)
>>> +{
>>> +	ulong vid, pid;
>>> +	char *end;
>>> +	const char *block_str = env_get("usb_blocklist");
>>> +	const char *cur = block_str;
>>> +
>>> +	/* parse "usb_blocklist" strictly */
>>> +	while (cur && cur[0] != '\0') {
>>
>> Have a look at strsep() , namely strsep(block_str, ","); This will split
>> the string up for you at "," delimiters.
>>
>> Example is in drivers/dfu/dfu.c dfu_config_interfaces() .
> 
> strsep() is probably a good idea even if it alone won't make the code that much simpler for strict parsing.
> 
>> And then, on each token, you can try and run sscanf(token, "%04x:%04x",
>> vid, pid);, that will parse the token format for you. See e.g.
>> test/lib/sscanf.c for further examples.
>>
>> That should simplify the parsing a lot.
> 
> It would but sscanf() is optional and is only selected by CONFIG_XEN so I assumed there would be concerns over binary size increase if USB_HOST would require sscanf.

Good point, lets postpone sscanf() . Also, looking at it, sscanf would 
work for numbers, but not for the special characters. So ... do you want 
to try tweaking this further with strsep() or shall we go with this 
implementation ?
