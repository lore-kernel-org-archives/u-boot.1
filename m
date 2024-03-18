Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A5CC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 07:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E999C875E9;
	Mon, 18 Mar 2024 08:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="nxhR7EZQ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="LvPoqZFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3058587572; Mon, 18 Mar 2024 08:34:05 +0100 (CET)
Received: from fhigh3-smtp.messagingengine.com
 (fhigh3-smtp.messagingengine.com [103.168.172.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D93D875E9
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 08:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 1F42811400F6;
 Mon, 18 Mar 2024 03:34:01 -0400 (EDT)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Mon, 18 Mar 2024 03:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1710747241; x=1710833641; bh=pKkahW0F0S
 JOsmb/hEPbDqyD9drdKgSPJ3I4m85SKu8=; b=nxhR7EZQUz2zm4gvpVYr+WWR1u
 f83PVtoAhBo9XC1MK6+lOMf5QIKkEG48Ir1IYdw8cypqx4WsYqAxZ5PFSyVCoa1D
 t8oUHEjcenVPXV+PUoCMPkVrJ4Ds7IV3iCQVHV5b3+Wy74WkIsjwRUvPIdkmE7Xp
 4v8QUMb5xP/iogtfAZcRTedjJoyrDhH30AmbzgMdTTMSnR+bQvPMcS6vOY6gymKr
 UYFX/5SLVbBqrmRTQ5j8P33DUXU6r9uFqepI6slHuerSD51mqEv1KeZGGJYtyNU/
 4DpW2GFeeCQJ+Wdy8hN/LgyoeZcfS6/JxctpFAL6kgkDhvdvXQGXaHCDicPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1710747241; x=1710833641; bh=pKkahW0F0SJOsmb/hEPbDqyD9drd
 KgSPJ3I4m85SKu8=; b=LvPoqZFbZu9w/K3yN2Bc9p8jZx0JyFCItlFotqADVUgL
 MtSpH4LztN9AxZ7O/JyDbJ+gLackBJRSoxovr/ZeY69qJlz5ztr8SlTQe33g1eai
 T9CbgsFoSonS/2+KmNurHOlOlxVgJWf8P4S9CdV5JFdFGPm2sJ72Fm6UxBZiFcQB
 Rkf5YVFRfJ5m60lnRZCyIGMI5Sn9TtgkWUCyGGCQWn5g4GOSO/7V/i4pePy72J6S
 ya01oeCe1mWssEjOJ9V2qffIlcIDFN+MMVNvtEFducUfoOuhUtsztizGMVv6KqMk
 HvP0Z0cJ0O1m/y9kRvLPTYhJU3vXIKZnvMm3U2XGDw==
X-ME-Sender: <xms:aO73ZSrGMSCidz8z2H6bOXt4zIf8wBKpUXZQI4GMgOB8Y4GRKL623Q>
 <xme:aO73ZQo46c8taqmRaG6dM2mLGpz1EF_51qr4xQc-ybAFkVRY32iEhDwUUaryzM1JT
 lUoJGF9n7y3PYR_QLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeeigddutdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfgr
 nhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvg
 hrnhephfehieevffdvtdetuefguedukeeftedutefhhfefhfefhfekuefhfeefteejhfei
 necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvth
X-ME-Proxy: <xmx:aO73ZXMwPltxYn6bTRV1p7Cg5SvftsaQbxudhgYWgtXod_j61gvRyg>
 <xmx:aO73ZR5f6WEGXqITi_Vjy-_YzLW_RFX0LujfaM-HFKqnl54AZRz_6w>
 <xmx:aO73ZR44vktWdNjZaLIO36VJMTbmiaTdxvJnmUhkjSqNwUMwDNopQA>
 <xmx:aO73ZRh192Zgzv1g3DHePrr0c440yCkL0HM2dGcXV_RDFX48hUodNQ>
 <xmx:ae73ZcbYmLP3phyCkTASP2HyNnzOHvRDA7H0fe_EblsfCMQkhgwbtw>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C249D36400B9; Mon, 18 Mar 2024 03:34:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
MIME-Version: 1.0
Message-Id: <e73c0c71-070b-438c-a9e0-2e5ee586d99f@app.fastmail.com>
In-Reply-To: <540cbc3f-a9bf-467d-8aa2-c56e53cd7123@denx.de>
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
 <22be2258-ff20-4e62-a169-4748cbba4904@denx.de>
 <970e9686-4bcc-4cda-95b7-e5cb470682b0@app.fastmail.com>
 <540cbc3f-a9bf-467d-8aa2-c56e53cd7123@denx.de>
Date: Mon, 18 Mar 2024 08:33:40 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Marek Vasut" <marex@denx.de>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Tom Rini" <trini@konsulko.com>, "Simon Glass" <sjg@chromium.org>,
 "Joe Hershberger" <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
Subject: Re: [PATCH v2 4/6] usb: Add environment based device blocklist
Content-Type: text/plain
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



On Mon, Mar 18, 2024, at 06:06, Marek Vasut wrote:
> On 3/17/24 7:15 PM, Janne Grunau wrote:
>> Hej,
>
> Hi,
>
>> On Sun, Mar 17, 2024, at 17:18, Marek Vasut wrote:
>>> On 3/17/24 12:07 PM, Janne Grunau via B4 Relay wrote:
>>>> From: Janne Grunau <j@jannau.net>
>>>>
>>>> Add the environment variable "usb_blocklist" to prevent USB devices
>>>> listed in it from being used. This allows to ignore devices which
>>>> trigger bugs in u-boot's USB stack or are undesirable for other reasons.
>>>> Devices emulating keyboards are one example. U-boot currently supports
>>>> only one USB keyboard device. Most commonly, people run into this with
>>>> Yubikeys, so let's ignore those in the default environment.
>>>>
>>>> Based on previous USB keyboard specific patches for the same purpose.
>>>>
>>>> Link: https://lore.kernel.org/u-boot/7ab604fb-0fec-4f5e-8708-7a3a7e2cb568@denx.de/
>>>> Signed-off-by: Janne Grunau <j@jannau.net>
>>>> ---
>>>>    common/usb.c              | 56 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>    doc/usage/environment.rst | 12 ++++++++++
>>>>    include/env_default.h     | 11 ++++++++++
>>>>    3 files changed, 79 insertions(+)
>>>>
>>>> diff --git a/common/usb.c b/common/usb.c
>>>> index 836506dcd9..73af5be066 100644
>>>> --- a/common/usb.c
>>>> +++ b/common/usb.c
>>>> @@ -1084,6 +1084,57 @@ static int usb_prepare_device(struct usb_device *dev, int addr, bool do_read,
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +static int usb_blocklist_parse_error(const char *blocklist, size_t pos)
>>>> +{
>>>> +	printf("usb_blocklist parse error at char %zu in \"%s\"\n", pos,
>>>> +	       blocklist);
>>>> +	return 0;
>>>
>>> This could be static void without return 0 at the end.
>> 
>> the return is there to break out of the while loop on parsing errors in a single statement. This probably won't be necessary after using strsep and sscanf in the parsing function but see below.
>
> Ahh, now I see it. But then, shouldn't this return -ENODEV here already ?

It returns 0 so that parsing errors in the blocklist do not result
in blocking every USB device. That looked to me like the
less bad error behavior to me.

>>>> +}
>>>> +
>>>> +static int usb_device_is_blocked(u16 id_vendor, u16 id_product)
>>>> +{
>>>> +	ulong vid, pid;
>>>> +	char *end;
>>>> +	const char *block_str = env_get("usb_blocklist");
>>>> +	const char *cur = block_str;
>>>> +
>>>> +	/* parse "usb_blocklist" strictly */
>>>> +	while (cur && cur[0] != '\0') {
>>>
>>> Have a look at strsep() , namely strsep(block_str, ","); This will split
>>> the string up for you at "," delimiters.
>>>
>>> Example is in drivers/dfu/dfu.c dfu_config_interfaces() .
>> 
>> strsep() is probably a good idea even if it alone won't make the code that much simpler for strict parsing.
>> 
>>> And then, on each token, you can try and run sscanf(token, "%04x:%04x",
>>> vid, pid);, that will parse the token format for you. See e.g.
>>> test/lib/sscanf.c for further examples.
>>>
>>> That should simplify the parsing a lot.
>> 
>> It would but sscanf() is optional and is only selected by CONFIG_XEN so I assumed there would be concerns over binary size increase if USB_HOST would require sscanf.
>
> Good point, lets postpone sscanf() . Also, looking at it, sscanf would 
> work for numbers, but not for the special characters. So ... do you want 
> to try tweaking this further with strsep() or shall we go with this 
> implementation ?

I started converting it to strsep. It makes the intent clearer but it doesn't
simplify the implementation much. strsep() has the disadvantage that
it can't work in place and needs to copy the string. If we go with strsep
I would look into parsing the list once at USB init time and use a list of
numeric vendor, product ID pairs at device probe time.
If have a slight preference for the current implementation (with ignore
or deny instead of blocklist) as long as the list remains short.

Janne
