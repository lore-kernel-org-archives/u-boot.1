Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D67C982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 08:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 050EF60685;
	Tue, 22 Sep 2026 08:07:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id teVqFZpDwvSe; Tue, 22 Sep 2026 08:07:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 468F86062B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790064455;
	b=RSeiaS0gbXDbHXm9UbfAHalkWDORQB2GO+0GPYOnpPgmo5dY+CYgm5ieeef+N9bQ3Dn+
	 dCyjxL336q8zTRSGznZxoNg6/biYe3krFMIRnYJw5rIIfqpJjeFEafHgUnmDkj6FBIo4O
	 jIAmbZkmwFkE3JTk19ts6ctmofMXB9HTiiI4PmPijx1eJbAEYavJF6vNDI47BHCDWDljW
	 Izl/PhwzNLDKadVdh1h6OKuNvNrqTMqjCigImAMutJiwX2E9KqWDhEe2JKmRerxvMhx0N
	 22arktqgYjn5QR41hkMhOr+2HYT2fPx+FC2Rnyz/kUDzgSZVBV0UfxOX81hw/XJXMIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790064455;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dnyFPyJdN8Nc1wDDyfz6z7k3no+0e7x8oA81sGkfSFM=;
	b=hfWe+/6vJ8mFfeYmw8uIfSDZHbuFF8uz2+zR0nrefXwENQyx1xUYgKjWBRMplq9b30w0
	 D54tibf6+9Ho4bbH7YQP/r6c84ycxfvtRLXa9Wdlw/anCVo50xQwITa/qLkwEJO9lF+yJ
	 c8moqlMYDprov5TGKzgeu29HdgyHmBj6xLez5j1XXOIw/cApdnOQ/ZHw2Lsg8w9kNnzud
	 ooZMn9+YBSbdZF6KDU+qTmsFArP1nwI56t69sMH3w+kkNdt0f6QmVxGTBfTdUjtrqrP8O
	 cUnJcmwtXSQ/VEYudqfR2J8QmD3t1BA31HZTDyopj2IBq/PqwjzFwsW3IJECVH1SZxQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790064455;
	bh=dnyFPyJdN8Nc1wDDyfz6z7k3no+0e7x8oA81sGkfSFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SY3R8/aylFTxxNTEGxq5vhOo+/qiWuR2HYdcJcPcWggJOMldDVXer7aBUH1/w0CtI
	 d8EgfhkZ9DhzkVqk7DGEaKuzQysv42NOD1Iqmab7Rw6Jfx3pfonNH47MFAA0MPK02Z
	 MXUvIafEywpvVpvHNHTJ9agguTmw2L/oS4v7+ANihAGVgtKuTmItL8TauyZ41mQ+Kg
	 Y9JL4ob0SC8LYgevcdyQtJVtXksXPhcCEDUAbRReYYTkGQuF00aya+n5dIfczGkgHj
	 9Ox46E/WvksFzBG+vZ3tD2mr/9d7i7NfAhty0pCCt5SfWGKmjSmMDtbjeQ7UX1Kv92
	 ZFTHWvaqzO9RA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 468F86062B;
	Tue, 22 Sep 2026 08:07:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E4EB194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E885F4076E
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:07:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pJ5tnL2dNYrZ for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 08:07:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4848040765
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790064453;
 b=DSqehZNHbYUSY28tiMYI8r8riK31BfF5HgSTmgPvX+s3kSLF/QyolHqdDVYLWlsI84bN
 9cV8qq0//LIDFsNgXkI19Ttizw7nXs2OrAkgi4COoYEo9evjFLUCVFft/dVxOtdVTRUv7
 50weRqM0AE8DIE4iryOHg0hPhguoe+NQufV0RfH1BEEBF8MiFH7Gq1Nk0Y9Rrnvqfwl0V
 aKqgcopazQ/nThQV73nyRkxbOaP2e7G8fTiJZxBhWjAQT8diYbrleF61y0ail/af5IRz2
 wmfaUwJQqyXctDOsGHgbE2dWbykt6TFL35p0owQfgqJ6pIdFbzaoFPXf0h0/7OYIXeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790064453;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=dnyFPyJdN8Nc1wDDyfz6z7k3no+0e7x8oA81sGkfSFM=;
 b=RlGaX2MmMl2buBg6PqfpHvdDZYQcqfVdUq/l017aP3+IAs7VZgu3zh04pMiIPYyFV0yT
 mp3orc8BMeQshRHzzneivoPatPPUQ057f+ZjpQNRHvziUmerev1L+/tdEos8fis+7P8Un
 zrja1JyIffEf/sFbq1BZNjHjtz6cRap9m21WKaqpXaHTaBo26njUD3DWcRU9ku6Vn9FIB
 8sealQR1WysGqq+hL01O4EN4taxHcElM8IqCZxYbOiBti16xK+qrWqpvtgsD8uANc+Ovc
 XykPnjFwBVbOya/4Ae9laWC7kKZtc3RcJuG9GK8tqzOqBEbb8pVhJVTQ3Ge5xGGfX+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dmqH5KHO; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=dmqH5KHO
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4848040765
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:07:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 037D660DDA;
 Tue, 22 Sep 2026 08:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1961F000FF;
 Tue, 22 Sep 2026 08:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790064450;
 bh=dnyFPyJdN8Nc1wDDyfz6z7k3no+0e7x8oA81sGkfSFM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=dmqH5KHOVVuKEVQzJhx2KNeteFzKzRH0lJTvJVCVLtXYebgDvbwR6/RMUYcF0Mfks
 lL3VmyFj4d47bcQi0ng4PeKQ2EwSW7MDVijD9eWSQOsDKl/stsk6Kxw5J+RvXKdLr6
 7T0zf7VB83UvyFCtnLeTTHPVJIwtyZZpv4+Zvvc/w+zgiSSvmZ4OmQu+LzO09zcCZx
 ZMH14HSiyVTpHuX86OBgxZ1TFLxpWldxsXBHXQ+Xl4ncPQD+FoMnCaljfAAqfc0aXS
 MDN3gbJLS9iIwaFCxko/D6klIuSWTXLUA7znIH4UZTTzMtE6FIz2lh0Fe9LBD5ALos
 06z4S0jj90h1A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, stevenjoezhang@gmail.com, Simon Glass
 <sjg@chromium.org>, Eddie Cai <eddie.cai.linux@gmail.com>,
 u-boot@lists.u-boot-project.org, =?utf-8?Q?=C5=81ukasz?= Majewski
 <lukma@nabladev.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: gadget: rockusb: terminate full-speed descriptors
In-Reply-To: <238ceafc-beef-4594-b626-99bb37a13692@mailbox.org>
References: <20260918-rockusb-fs-descriptor-terminator-v1-1-144ffc0f3d33@gmail.com>
 <180d8edd-2743-47ad-9904-866d76bdceef@cherry.de>
 <238ceafc-beef-4594-b626-99bb37a13692@mailbox.org>
Date: Tue, 22 Sep 2026 10:07:28 +0200
Message-ID: <xhkdbbj9pso8v.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Sep 22, 2026 at 00:01, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 9/18/26 3:50 PM, Quentin Schulz wrote:
>> Hi Shuqiao Zhang,
>> 
>> On 9/18/26 12:11 PM, Shuqiao Zhang via B4 Relay wrote:
>>> From: Shuqiao Zhang <stevenjoezhang@gmail.com>
>>>
>>> usb_descriptor_fillbuf() expects descriptor arrays to end with NULL.
>>> The high-speed RockUSB array does, but the full-speed array does not.
>>> Full-speed enumeration therefore reads beyond the array and treats
>>> adjacent data as another descriptor pointer.
>>>
>>> On a Luckfox Lyra Ultra (RK3506B), the adjacent interface descriptor
>>> started with bytes 09 04 00 00. They were interpreted as pointer
>>> 0x00000409, causing a data abort in usb_descriptor_fillbuf().
>>>
>>> Add the missing NULL terminator, matching the high-speed descriptor
>>> array. After this change, RockUSB enumerates at full speed and
>>> upgrade_tool can successfully read the eMMC.
>>>
>> 
>> usb_descriptor_fillbuf() iterates over the array, but so does 
>> set_config() in drivers/usb/gadget/composite.c.
>> 
>> I've quickly checked other drivers and it seems they all NULL-terminate 
>> also (either explicitly, or in the case of drivers/usb/gadget/ether.c by 
>> having an array of static size with fewer elements than the array can 
>> contain (and thus they are NULL)), so they should be fine hopefully.
>> 
>> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
>> 
>> At the organizational level, who's willing to take it through their tree 
>> once reviewed? I don't mind but I'll be waiting review from Lukasz, 
>> Mattijs and/or Marek before doing that.
> Wait for Mattijs please .

Unless requested otherwise, I'll pick it up through u-boot-dfu-next. I
have this go through next as this bug has been here for some years already.

Thanks!
Mattijs
