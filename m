Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC12C54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 21:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670A087E3E;
	Tue, 19 Mar 2024 22:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="ZmzdARsB";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="tyaR4ecx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C454087DC8; Tue, 19 Mar 2024 22:17:50 +0100 (CET)
Received: from wfout7-smtp.messagingengine.com
 (wfout7-smtp.messagingengine.com [64.147.123.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A14287E3E
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=janne@jannau.net
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.west.internal (Postfix) with ESMTP id EF8861C000E0;
 Tue, 19 Mar 2024 17:17:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 19 Mar 2024 17:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1710883064; x=1710969464; bh=MDA9qibaHS
 Bw6/cmxc9OFDDsFLNcwyDCu+rWAVaOol8=; b=ZmzdARsBANeKeSIvo//ZHg3400
 VSadJ88Hwlichm4WAYT62GnbI55HVHcsXgGJLg+jY+QRAc+l/lvJafKJEN0Qvgkx
 fnqEKHcmH17JeQ+HQaGhDfmi1huZN7UvQQC7nhQlapLy1+dGWis2aum5EEkrmH+A
 X7tcSIYIVlpiFToaP7FpsQlAGp60lUpc6QGKn6W6QEMvDVtbxGJlQ0fN/Bb5wb8R
 uXviC6OTjRziPRZ5FyEZo8XivLDO+eGCwb5n8Mk1FznECpXZ8yfR+Eo6oVEB6fwf
 As29LHAchQlDJb/E5rYUts+pz7H7Qv0KmzxQXAmC0vU3tAZkOze+dYdFFH2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1710883064; x=1710969464; bh=MDA9qibaHSBw6/cmxc9OFDDsFLNc
 wyDCu+rWAVaOol8=; b=tyaR4ecxkDBgBaJ6235eY7h0V+QrlSBUOTQi0N0FQDCb
 2Jog8hhS/FgHrxzBzlmLLmQNJKUmLXAYOlLGASVrxcWerjbBCrHlblIbH01wf3wW
 Jgt1pqN6OECq58Lg2PZuPJ/mr8CXR5YZ7YMt1770tEtgSwaxHTm1EtFoHTAmQ28J
 thh9nL6TZGyiKTvpu0cOLD8KkfVUzP9Nvx7TWtU4mJmuzoAakmVBhQ0hVIwpWGaj
 PaXLihRxHIhwKbxfuIe5SZhrKMaa8Evd5u+2axbsW7XfTIC3zIg1WXYZ5kLNydaS
 w+vfgimRAHHlpCggdWTxwIs/qlHGi5B9bYBDQ4b/Gw==
X-ME-Sender: <xms:-AD6ZWHsGGi1FqPKjiRC1YGJKTVvfJwFBWUAahGCTmbCOJYeZa1AZw>
 <xme:-AD6ZXXnXQaX9QSbQrCIB4vosDJWzXXYYPYmlASvziOjZ9yJkyhl8QJzfnqugIF1m
 jXH9t3GX7IKAKpGhsY>
X-ME-Received: <xmr:-AD6ZQIDK-G9hEgMEH0URrJAxfmm0XB0sBfq8v55p17DUP28HM8ruqbiiJtwfE9yef4oduSDm36izIimkX1yv67DH4X-yRjUog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdduvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhn
 vgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpe
 fgvdffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrghnnhgvse
 hjrghnnhgruhdrnhgvth
X-ME-Proxy: <xmx:-AD6ZQGAv0rinBW0JcYIlk2m2unuxUDgKQMatidShLr6dTQcTLXoVA>
 <xmx:-AD6ZcUquvsGBeUMeGqlpwENojmv4tH-dRFcEToO2f6sXGMx74F8hA>
 <xmx:-AD6ZTPQMzVX2Ek7ggdV00X358kuVRt0C0Y3F_uos6yqFCyGJ_E09Q>
 <xmx:-AD6ZT0Jv88ZTUgKdQi6bE1uF-vyaTOzYYO3X1kUTjgqHWXxHABGfA>
 <xmx:-AD6ZQqwiNYrhu2eIYERFLK0vq0Rb7szjM_laxQODBS30yf_wZ0wnQsFtkk>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 17:17:43 -0400 (EDT)
Date: Tue, 19 Mar 2024 22:17:41 +0100
From: Janne Grunau <j@jannau.net>
To: Marek Vasut <marex@denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de,
 asahi@lists.linux.dev
Subject: Re: [PATCH v2 4/6] usb: Add environment based device blocklist
Message-ID: <ZfoA9VDRwaZYzd0i@robin>
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
 <22be2258-ff20-4e62-a169-4748cbba4904@denx.de>
 <970e9686-4bcc-4cda-95b7-e5cb470682b0@app.fastmail.com>
 <540cbc3f-a9bf-467d-8aa2-c56e53cd7123@denx.de>
 <e73c0c71-070b-438c-a9e0-2e5ee586d99f@app.fastmail.com>
 <3f609051-4925-464b-be57-b1a64e5bf861@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f609051-4925-464b-be57-b1a64e5bf861@denx.de>
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

On Mon, Mar 18, 2024 at 03:17:33PM +0100, Marek Vasut wrote:
> On 3/18/24 8:33 AM, Janne Grunau wrote:
> 
> >>>>> +static int usb_blocklist_parse_error(const char *blocklist, size_t pos)
> >>>>> +{
> >>>>> +	printf("usb_blocklist parse error at char %zu in \"%s\"\n", pos,
> >>>>> +	       blocklist);
> >>>>> +	return 0;
> >>>>
> >>>> This could be static void without return 0 at the end.
> >>>
> >>> the return is there to break out of the while loop on parsing errors in a single statement. This probably won't be necessary after using strsep and sscanf in the parsing function but see below.
> >>
> >> Ahh, now I see it. But then, shouldn't this return -ENODEV here already ?
> > 
> > It returns 0 so that parsing errors in the blocklist do not result
> > in blocking every USB device. That looked to me like the
> > less bad error behavior to me.
> 
> In unix , 0 is considered success and non-zero failure .
> 
> How about this:
> 
> - Return -EINVAL here (parsing failed)

If we return 0 / negated errors we do not need this function and we can
simply report the parsing error when usb_device_is_blocked() return
-EINVAL.

> - Instead of 'return 1' in usb_device_is_blocked() return -ENODEV
> - In usb_select_config(), check
>    if usb_device_is_blocked returned 0, no device blocked OK
>    if usb_device_is_blocked returned -ENODEV, device blocked,
>      return -ENODEV
>    if usb_device_is_blocked returned any other error, parsing error
>      return that error

I think the preferable option is to ignore parsing errors. If we
would propagate the error the result would be that every USB device is
ignored. 
 
> What do you think ?

Fine by me, -EINVAL makes the parsing error reporting less awkward. Only
open question is what should happen on parsing errors.

locally modified and ready to resend once we agree on the behavior on
parsing errors

Janne
