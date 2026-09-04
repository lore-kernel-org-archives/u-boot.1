Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09250C79F8C
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 07:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB0D780DDC;
	Sun,  6 Sep 2026 07:09:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fsro6h_Dsh9g; Sun,  6 Sep 2026 07:09:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5AC0780D98
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788678572;
	b=FS4rAPCoM+yEOE+isId6YKLWbXHhlM0YW5eGYKXjTcFzsDd5LYuSaqVIytZ+FHvxZ8li
	 f54VZ6/u1HaylZ7fi+k81d1SeJ9v5ezCL54+T9VISC2YWZaViXIcDJSc84noN2IGXkAxz
	 jCOBcBdgHAWclsDb4rbPD5nDRceNHznXTeJbAZSN8rLMJsyomfJzyDT9cQTivqzalZ+Nr
	 E4NEzjONwU58a8Fbr/97+G7O3VVymV332mxnsXnd6+odMqm/Bk83deM1SspSQ6q3piGty
	 xwh3LRdQo8Ri5rkYfkoQkM++OAj6ZmE2K8UzTJvVWvQW2kqKC+cgBm2FP6EV4xSwE2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788678572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Pkc40kp6ZAbot0I6BIsu+FZVXKLmr52qtB0P5P65HVM=;
	b=Cno9awTvvmGJZK0jLSh0XcCtiga3Bv0RXQenFRrn/iEfNns98j+75EMJV9HVRk7fGCd4
	 ZYeii1GUxY2Wyboxxef01w1g/CEECFKVH7rG9d6khZRDmTr3aOt+f9Cgdkw6MD+APN+FA
	 TqSjB74Pya0VaclXFHjVKpntj6bE0c4ZEOmdxbGAOnG4fwObOoRClTsCgn9aov9NmyWt4
	 IoamJtyUlr24s9h+xW35CEgKrB4rFeLSyIMDi/0js3SbQsr3TBxgxtyS2uyRfL6Bk4Moj
	 V6Ag2VHKfZOW5KY1/HQX3NSL7hiIoJfwLNgOAVvY/DMjQjEvJmsV7a2+6EW42Ay20nw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788678572;
	bh=Pkc40kp6ZAbot0I6BIsu+FZVXKLmr52qtB0P5P65HVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EeNfE/bb9YaXKDQK7+cpy5valUCeE5dHo4qmVImXjq++pW1HXwnqtg4Uww4v/A1YZ
	 WTDJfhShp4BjODD+VOgWCRnu31Qxn5fGBZkahc0JXLIQZP6xsvLdI8WfneZRL5yC8q
	 qVyWqJcXRK2KXmbmRwylQnIlI0+wyfwLmSeJdemn89RbH8m+hIPlWOxUGK4Oi3Vnvw
	 O9kmZzx6dr36JtnC7+LQSBEieyoUvusvtF36JEIqlyI/6oZw05Bypyew9wTeLUSs8u
	 a8MHcFh6PBiVaOyP4cuo2veVR3FKnIMSQMQPkWNcngEHHAxlvTP0/z+kTftV2//XXH
	 omdhDjPbIe64w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AC0780D98;
	Sun,  6 Sep 2026 07:09:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A2A372C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 07:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B1DA605F1
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 07:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9KSxrOehe0C9 for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 07:09:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 65442605D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788678569;
 b=ivHj6NDy6gpAdMkOgjfJHOwkZ6OqvlhS//o0dTN3ab8iFeQBk7eBoYts4GeSXzoJkWWE
 in00/hmKw2SUSvLW31zICuyzsv8i1Sc8VWvNngIFUC/Itk/SgKlI87Ysi4fq1ezld9gfN
 iLonOx+1W6BgXW2lRJGof1jjZ9cedtkM/ZIg2iNuLejVHld3hNKORFai9+Qk6gMvJ56ra
 gG040kSTKeGOsAmquLjPtGP4+8xZV+2MpNejfGF8mD0mqkz/Wa/phWxfivBi/JeWrFCx4
 y+iaJ/wcbLSfmVnnQXgcURKcxM0OyNDr6CpI1hS8D+SAPd/YlIpysLCVdP+9O6R0Ipw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788678569;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=Pkc40kp6ZAbot0I6BIsu+FZVXKLmr52qtB0P5P65HVM=;
 b=Wp6dAvSLIAxcBSfh/XBHFsQN5fdhF3cpl4L8FnhfVe06P0VmlyQSFB6RiT4ihdUYgFSs
 xuDGncGg2IlAQbWVzfmlqfOdS/tbMIJPRbbcz78mLamcUZ0I4NOqZ6Vl3aOMs8PrBTjwS
 SorMj0GVUV6v115az0ytdBkTpXomuF6keip3anxkR97FpwvnbSRe9Z4ROOfILbfEAalIj
 bNwtzmFnkZUXZoZYtlUej0MIuT3t7JQwYjVSS8YDpFirXCTGGx6g0MkOd14rfZ1KuU/Wu
 23OMdakQM0Q0wvwrFZD3ENNlKtgXdKl1YwjnDQ4t0nBTam+wzuFI7TSAHpwf5fsc+1g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="fOTLDi/I"; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=fOTLDi/I
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65442605D2
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 07:09:28 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hd1Xj3CQRz8t1X;
 Sun, 06 Sep 2026 09:09:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788678565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pkc40kp6ZAbot0I6BIsu+FZVXKLmr52qtB0P5P65HVM=;
 b=fOTLDi/IAIaMuX+SztoqaB0TAhpAAI+H1E/rdd2rDXZfqELattvH5ysshwWbVc615nP2zd
 8AS94v+bvFmvxbmCxSKCtFRltjftEOKjM2PhuQNXunX8/YwIcBoIh8drOOlkcfhJI095c9
 A8qcwqgWWDTqMCsjaIFTe0IlkUVo5/lo29HhVqPzad2vj4GreJkJKMbbSopqF4wSurEUHU
 pJKCaH7kmorx9aQzRYPcUdz51xkUF2x5OfpyyLoWXnz+a50ZWbWEhOvCvtPQXPKq9Hv7lG
 ayGTE+qtfO68hs1B1boQWPNk8S3Q2eQ6xrlz4G69zE+IeM9eyl0sqN8hF/AlfA==
Message-ID: <cd41d9f4-667a-4b3e-9e61-a9c46cdff64d@mailbox.org>
Date: Fri, 4 Sep 2026 19:33:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: dwc2_udc_otg: translate DMA addresses via
 dev_phys_to_bus()
To: Levi Tomes <levi@userdevice.net>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>
References: <CAG7BTaqzj4Z=LM8E6U+e8Rz531Pf0BvFEB8nnSWvz9BE2e3tRw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAG7BTaqzj4Z=LM8E6U+e8Rz531Pf0BvFEB8nnSWvz9BE2e3tRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d30ac9c00b921f7f77a
X-MBO-RS-META: ss3sox43566mqmtc7xxfsusnbm3ndbfh
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/4/26 7:12 PM, Levi Tomes wrote:

> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c
> b/drivers/usb/gadget/dwc2_udc_otg.c
> index e475b14b9a..3835244cca 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -168,6 +168,15 @@ __weak void otg_phy_off(struct dwc2_udc *dev) {}
> 
>   /***********************************************************/
> 
> +/* udevice of the probed controller, for DT-aware DMA address translation */
> +static struct udevice *dwc2_udc_udev;
> +static inline unsigned long dwc2_phys_to_bus(unsigned long addr)
> +{
> + if (dwc2_udc_udev)
> + return dev_phys_to_bus(dwc2_udc_udev, addr);
> + return phys_to_bus(addr);
> +}
At minimum, run checkpatch, the patch is clearly malformed.
