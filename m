Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE045C54E68
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 14:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5C9B87DEC;
	Mon, 18 Mar 2024 15:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710773214;
	bh=CkAvUmYBbKm/DWaWi0rad5Nl3/1FHr8z3fOtLhMArEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NmF/rusATGlAR4hCOdgsttuURX3pZ/yjWi8yC6tVc8T/Xnpa1yOVSL3jNC8XsLVh8
	 NFOlS8Eww6oLpf2r0ysu0ZdmXmKLlDwU7qURtcfelunmNMexaWedFWGYHXgGIhzxRx
	 /ARKbgC7/ahuozdNttMU1xgsq2T4gqJanBcfIEdDUZ5GvxqoXP+b5GensedO+7TA2w
	 bAmm2ZUoaBfelBSWjnpLGPD19nFAhXgSMydiIExJu6ym01LrT55Mi4CtEhTac9DIgj
	 BvNeXOSO7ACgyT7SK6i9D1WTVzMF2vYaad8wIBNRRSPrPMaXGWsWCYq2+ZzWJ2Kdel
	 jLShAUuyB27Pg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9E10787BF1;
 Mon, 18 Mar 2024 15:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710773213;
 bh=CkAvUmYBbKm/DWaWi0rad5Nl3/1FHr8z3fOtLhMArEE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=afv1sMTu2TPa6IgpOX3LlLIzWAbM/TIbypHh6AEEFG8Unho6eCUSJoK2danRLcbq5
 eh7+shce2WlBrbaBwX1ixUGfTNrZsxYmnhZHyA3yFhUPiiH+PE17rON4Repk0/axMj
 RoRiCi9BApqQiIkzSNTr4vs+ikn/A/844WSAucmsARCI0qNoF7KG9O9zZ/i9QtaD6x
 /Gm0DP4YlFNamHTuC1hhkRVg6cGYp41rmtNKwKph9QI+TNf+vJaPnRbOtjxK0NCKiP
 v+bRj1xs5luaQL+UUhhsFevBM4WTggVG6xSFDGIQDnmimADWnJl9SvfGA2efWO6QPg
 Em/Wi7ioyNUyA==
Message-ID: <3f609051-4925-464b-be57-b1a64e5bf861@denx.de>
Date: Mon, 18 Mar 2024 15:17:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] usb: Add environment based device blocklist
Content-Language: en-US
To: Janne Grunau <j@jannau.net>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
 <22be2258-ff20-4e62-a169-4748cbba4904@denx.de>
 <970e9686-4bcc-4cda-95b7-e5cb470682b0@app.fastmail.com>
 <540cbc3f-a9bf-467d-8aa2-c56e53cd7123@denx.de>
 <e73c0c71-070b-438c-a9e0-2e5ee586d99f@app.fastmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <e73c0c71-070b-438c-a9e0-2e5ee586d99f@app.fastmail.com>
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

On 3/18/24 8:33 AM, Janne Grunau wrote:

>>>>> +static int usb_blocklist_parse_error(const char *blocklist, size_t pos)
>>>>> +{
>>>>> +	printf("usb_blocklist parse error at char %zu in \"%s\"\n", pos,
>>>>> +	       blocklist);
>>>>> +	return 0;
>>>>
>>>> This could be static void without return 0 at the end.
>>>
>>> the return is there to break out of the while loop on parsing errors in a single statement. This probably won't be necessary after using strsep and sscanf in the parsing function but see below.
>>
>> Ahh, now I see it. But then, shouldn't this return -ENODEV here already ?
> 
> It returns 0 so that parsing errors in the blocklist do not result
> in blocking every USB device. That looked to me like the
> less bad error behavior to me.

In unix , 0 is considered success and non-zero failure .

How about this:

- Return -EINVAL here (parsing failed)
- Instead of 'return 1' in usb_device_is_blocked() return -ENODEV
- In usb_select_config(), check
   if usb_device_is_blocked returned 0, no device blocked OK
   if usb_device_is_blocked returned -ENODEV, device blocked,
     return -ENODEV
   if usb_device_is_blocked returned any other error, parsing error
     return that error

What do you think ?

>>>>> +}
>>>>> +
>>>>> +static int usb_device_is_blocked(u16 id_vendor, u16 id_product)
>>>>> +{
>>>>> +	ulong vid, pid;
>>>>> +	char *end;
>>>>> +	const char *block_str = env_get("usb_blocklist");
>>>>> +	const char *cur = block_str;
>>>>> +
>>>>> +	/* parse "usb_blocklist" strictly */
>>>>> +	while (cur && cur[0] != '\0') {
>>>>
>>>> Have a look at strsep() , namely strsep(block_str, ","); This will split
>>>> the string up for you at "," delimiters.
>>>>
>>>> Example is in drivers/dfu/dfu.c dfu_config_interfaces() .
>>>
>>> strsep() is probably a good idea even if it alone won't make the code that much simpler for strict parsing.
>>>
>>>> And then, on each token, you can try and run sscanf(token, "%04x:%04x",
>>>> vid, pid);, that will parse the token format for you. See e.g.
>>>> test/lib/sscanf.c for further examples.
>>>>
>>>> That should simplify the parsing a lot.
>>>
>>> It would but sscanf() is optional and is only selected by CONFIG_XEN so I assumed there would be concerns over binary size increase if USB_HOST would require sscanf.
>>
>> Good point, lets postpone sscanf() . Also, looking at it, sscanf would
>> work for numbers, but not for the special characters. So ... do you want
>> to try tweaking this further with strsep() or shall we go with this
>> implementation ?
> 
> I started converting it to strsep. It makes the intent clearer but it doesn't
> simplify the implementation much. strsep() has the disadvantage that
> it can't work in place and needs to copy the string. If we go with strsep
> I would look into parsing the list once at USB init time and use a list of
> numeric vendor, product ID pairs at device probe time.
> If have a slight preference for the current implementation (with ignore
> or deny instead of blocklist) as long as the list remains short.

OK, we can always improve this later, I would also like this 
functionality in soon-ish.
