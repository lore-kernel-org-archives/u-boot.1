Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B5CC54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 18:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05AC587E49;
	Sun, 17 Mar 2024 19:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="b5nr8hp+";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="RbG7DBr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E1B83348; Sun, 17 Mar 2024 19:15:47 +0100 (CET)
Received: from fhigh3-smtp.messagingengine.com
 (fhigh3-smtp.messagingengine.com [103.168.172.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CFE787D87
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 19:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id C7980114009F;
 Sun, 17 Mar 2024 14:15:42 -0400 (EDT)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Sun, 17 Mar 2024 14:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1710699342; x=1710785742; bh=w1fwjkNziD
 4xEBR+Pb5UnFJ4ELEgg23YqrQzysmRZ90=; b=b5nr8hp+BwpQ2OBlrvnDnxO9CJ
 S1HdjtzchbPACi6pBl84MI9mMkN/du05RNKpOii1NO4kFvuuRQaBRnXt1l4vwVdl
 h0b9hozEiSt//uNADWbugr/r8VmYkx6tVLP/Y+lX5tzQlk2UuseQGWXzc7tfeSMU
 aIYdcxsUujvBFkxeP7tjpz9hGAZsf9kEl6dlokg6VIbewEjr5pBJeTlYvXQrto+b
 39A5WIFx/IeJPS9iuj2+/WldoDOzapUVPL5c8IxE9bFmEI0SxI1YFKqcYEbeKfpR
 bt/AjzVo0HVh40kfouryPG1SCCVNc8IvvOryg0cbWI6I+VUzzVq778VP9coA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1710699342; x=1710785742; bh=w1fwjkNziD4xEBR+Pb5UnFJ4ELEg
 g23YqrQzysmRZ90=; b=RbG7DBr9gQL3qGYsinHbNngoi8EIpniSoNTgJV6m2QWU
 CDUw0rXjw96Dw/9ZgSijG9p6RAAqxyDEHj8tkj1DM6MUs9PrDnxlHumJN9fpAj9B
 SH4s78THll/6ZpQwXIi+H7w7MSzSV6zHEiiThai+dV0rgzRaLvU7iNFhljQlLSLW
 h7ROf0EwAGjH1wS2pNWGUY9rI2N8oXV+uT90zFY1v8ImIdifrKVFM80eVWEINcWZ
 ZK4tvdlB1aAznZYtivnMxfsOoK3OG2iZvaEG4Qc2TFEz1g9TlbZbBZhlAif5H1GJ
 xcHjjLpIsKd9zsd7Igp6Ge6+4BvrJNhiVsCno1RYpw==
X-ME-Sender: <xms:TjP3ZfJ1-wtbo4DDawZZSV_ahgx91biTOum-bxvVdRd1NB0D2ar8LA>
 <xme:TjP3ZTLAFuW2z8UyXH6VgAcxb4Zr36aXrBEyj5z_kd5VVUXDfHASfVF12H1tusyG5
 wb4BXQuYLzkQysBiKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeehgdekjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflrghn
 nhgvucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrh
 hnpefhheeiveffvddtteeugfeuudekfeetudethffhfefhfefhkeeuhfeffeetjefhieen
 ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:TjP3ZXsZ1XwBg5No7yNuq1ObbNU_ft2I-Wfk5qlISUbyTzb-1_1B9g>
 <xmx:TjP3ZYbH5wf-Q1EEEkBH4UHyLAh76OpQSyoTjvr-0-6U0M9HiCvMag>
 <xmx:TjP3ZWYcvvpX6W_7DT6oWs3ZY4NUzjbdDvrmjcn02mb5bOsuGutOVg>
 <xmx:TjP3ZcBXZLPYnjfK3ltnZxZa1_demDMYhM7ITJJrrVTCPKZiIhKWoA>
 <xmx:TjP3Ze66WCGWHEJhxmSv_oBfVjIyHZFx_0rf7qseZjtc1a43cFVhNg>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 67B7D36400AB; Sun, 17 Mar 2024 14:15:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
MIME-Version: 1.0
Message-Id: <970e9686-4bcc-4cda-95b7-e5cb470682b0@app.fastmail.com>
In-Reply-To: <22be2258-ff20-4e62-a169-4748cbba4904@denx.de>
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
 <22be2258-ff20-4e62-a169-4748cbba4904@denx.de>
Date: Sun, 17 Mar 2024 19:15:22 +0100
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

Hej,

On Sun, Mar 17, 2024, at 17:18, Marek Vasut wrote:
> On 3/17/24 12:07 PM, Janne Grunau via B4 Relay wrote:
>> From: Janne Grunau <j@jannau.net>
>> 
>> Add the environment variable "usb_blocklist" to prevent USB devices
>> listed in it from being used. This allows to ignore devices which
>> trigger bugs in u-boot's USB stack or are undesirable for other reasons.
>> Devices emulating keyboards are one example. U-boot currently supports
>> only one USB keyboard device. Most commonly, people run into this with
>> Yubikeys, so let's ignore those in the default environment.
>> 
>> Based on previous USB keyboard specific patches for the same purpose.
>> 
>> Link: https://lore.kernel.org/u-boot/7ab604fb-0fec-4f5e-8708-7a3a7e2cb568@denx.de/
>> Signed-off-by: Janne Grunau <j@jannau.net>
>> ---
>>   common/usb.c              | 56 +++++++++++++++++++++++++++++++++++++++++++++++
>>   doc/usage/environment.rst | 12 ++++++++++
>>   include/env_default.h     | 11 ++++++++++
>>   3 files changed, 79 insertions(+)
>> 
>> diff --git a/common/usb.c b/common/usb.c
>> index 836506dcd9..73af5be066 100644
>> --- a/common/usb.c
>> +++ b/common/usb.c
>> @@ -1084,6 +1084,57 @@ static int usb_prepare_device(struct usb_device *dev, int addr, bool do_read,
>>   	return 0;
>>   }
>>   
>> +static int usb_blocklist_parse_error(const char *blocklist, size_t pos)
>> +{
>> +	printf("usb_blocklist parse error at char %zu in \"%s\"\n", pos,
>> +	       blocklist);
>> +	return 0;
>
> This could be static void without return 0 at the end.

the return is there to break out of the while loop on parsing errors in a single statement. This probably won't be necessary after using strsep and sscanf in the parsing function but see below.

>> +}
>> +
>> +static int usb_device_is_blocked(u16 id_vendor, u16 id_product)
>> +{
>> +	ulong vid, pid;
>> +	char *end;
>> +	const char *block_str = env_get("usb_blocklist");
>> +	const char *cur = block_str;
>> +
>> +	/* parse "usb_blocklist" strictly */
>> +	while (cur && cur[0] != '\0') {
>
> Have a look at strsep() , namely strsep(block_str, ","); This will split 
> the string up for you at "," delimiters.
>
> Example is in drivers/dfu/dfu.c dfu_config_interfaces() .

strsep() is probably a good idea even if it alone won't make the code that much simpler for strict parsing.

> And then, on each token, you can try and run sscanf(token, "%04x:%04x", 
> vid, pid);, that will parse the token format for you. See e.g. 
> test/lib/sscanf.c for further examples.
>
> That should simplify the parsing a lot.

It would but sscanf() is optional and is only selected by CONFIG_XEN so I assumed there would be concerns over binary size increase if USB_HOST would require sscanf.

Janne
