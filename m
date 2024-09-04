Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0791ECA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 04:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E8A88C63;
	Wed,  4 Sep 2024 06:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="BAvqOs9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBFC488C7A; Wed,  4 Sep 2024 06:56:49 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF01F88365
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 06:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1725425795; x=1726030595; i=smoch@web.de;
 bh=/O478IHut3oHCm0fZUleBcH7qVlnnzSYyLE98Bh987w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BAvqOs9XJaQGFgIglMkCv4Rw/X7jGxkcFBsv9rLugL/j7Dlj5U4C+j+i82DekYdj
 7bLdxgIJg4UV0A6bwfSaQ5hSJClIlP9DXPV6DNEyPrD0LBQmQQrFfQqgOw1DnmZjC
 DGUBnJZUttRhFeVdeCnPUbkS59onCExSt1lk5A3ALHtffPYxNVx1ztmaMg4aN8N8y
 YIsDG8ygVq7uAtNIBLNUuyJJXguiLfv78PhxieltGqyptscHS+717yNDZnrM8qjVS
 Gsunq1EbEFQGhtVpa0FAPjRfUXkFA4EjjtzOql/El+jo6McZC+KL+IMZN/g7FCwgd
 X4/YBOsATUo9i+vGHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([89.12.137.104]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6pZ-1rqb9B3tfj-00xo71; Wed, 04
 Sep 2024 06:56:35 +0200
Message-ID: <fccbf9a6-b27f-4dae-813c-5f045bfe829b@web.de>
Date: Wed, 4 Sep 2024 06:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Eugen Hristev
 <eugen.hristev@collabora.com>, Tim Harvey <tharvey@gateworks.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20240903182136.153196-1-sebastian.reichel@collabora.com>
 <d17f96a6-8e24-41e6-900e-1e546b6bc42c@web.de>
 <01020191ba57e28c-d386c206-8177-45b4-b573-a1abdf6e69c9-000000@eu-west-1.amazonses.com>
Content-Language: en-US
From: Soeren Moch <smoch@web.de>
In-Reply-To: <01020191ba57e28c-d386c206-8177-45b4-b573-a1abdf6e69c9-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:aVAKD9WeYqYgQYpjZEdqkr+KG/30QmIrpB7by+zGT9aZ4NkxKk1
 yExLsttdjcGlODC6dT234TVeNsfkGpkL+kDFQm3lUjInMIy3o9nRjRXZ27NRalOyNLUD5Pu
 EBD7cl6O0/BGqnAK4/7MbzEpG5BPtEBdWwv5LJL4xtpH1TZ3/K8n3mKiSWV8vRbECUUYYsu
 ilkF/BvKg/8RvyNQBzjSA==
UI-OutboundReport: notjunk:1;M01:P0:SAL2Mvfi7ck=;K1StW6cMKc6piE36JZLXDjXo5VJ
 oop0qYiwuy61syS0bO1B5V3JZdvQJOyhY4d9tdbjDbN6hgwrf25oxkzXFcXe1XCKuD0FQBnh0
 Oi0+QIS3ZAEfh1LYfzkIjrx8Wn+LzT/EwiFhAnMPRCe2lrdB/ButGE+2iltzgq/gMRztjf55I
 JvsGDC7nehf+nGvQ5sv53k6qchAnXT2iLkUqWrP+5+eT0loY+2yvdwcI+T2TQkfcKUkt9ssee
 tLkOnBGwm5ClZ/xg63Ry7TZJyPn01OuvMlHImugNuQKQSPU4fIxJPfsJvsPYApxubPTJWJiTo
 c3iNT1sCwnQxPQz+BsJvMUM1UXB8gh+Tzf4UnRbjS+jUg0A1OKqRS1PWcEYfx+b0DgIgMBCCr
 J6iavL/AqeAV9v5UuATqLLcMHbl1iDGMDz8FQbEwC9t7WQtoyfl4a729WQEN2Oo5jX38XzfIy
 O4mmeg/afrmAkDA61coPRvuGArQxTCHK31iKCcj7d09/kaODLfTBdGPVqMYKQy4dIMrYM9+Cf
 nDeTu3jxDVV/aAwtlKe1wi6RuwnAgw8PNs92sq3E/zlHR0dulDANvj8rZtJ7OuFyv9P18ImC7
 +0/ypWVeaHrsNidVK13pmuBwpKzFvHyxfB75jbDIX4xt3eSSXGyrw6LKH5jwcw+E+HHh/bplv
 bLOzSbc+7/XhORp18iCxQr9cB5IJyVX7pL6d04TXDxt6KuU5J6/MugLUTWghluXLNRqk8Bpnk
 zIqwB8uJWf5FJQ5HyWgSGOuStyAZANbJfjt8QSz36ntkQ5PlTuVoZbZz9VUBs7PM36pXyWT02
 3WRLLOyNaknt4hvKsO+YCAuA==
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

Hi Sebastian,

On 04.09.24 02:03, Sebastian Reichel wrote:
> Hi Soeren,
>
> On Wed, Sep 04, 2024 at 12:26:43AM GMT, Soeren Moch wrote:
>>>    * non PD capable (reports 5V 0A)
>> With a dumb power supply (actually 12V w/o USB-PD) I see a error message
>> (not really sure if that makes sense, but no strong opinion from my side)
>> and 5V/1.5A reported with 'tcpm info', see below.
>> Can we expect 1.5A as fallback supply w/o USB-PD negotiation? 5V OK, but
>> I'm not sure if USB2/USB3 type A to type C cables are allowed according
>> to the USB spec, with lower possible currents.
>>
>> I'm not sure what the 'right' thing is to report in this situation
>> (also cable orientation makes no sense).
>> Just want to mention that I see something different here.
> USB-C sources, which are not PD capable can use pull-up resistors to
> change source advertisement as follows:
>
>      | advert.   | pull-up to 5V | pull-up to 3.3V |
>      | --------- | ------------- | --------------- |
>      | default   | 56K           | 36K             |
>      | 1.5A @ 5V | 22K           | 12K             |
>      | 3.0A @ 5V | 10K           | 4.7K            |
>
> default means 500mA for USB2 or 900mA for USB3, which is reported as
> 0 in this series.
Ah, OK. Thanks for your explanation. This makes sense now.
> Your setup seems to have pull resistors advertising
> the 1.5A profile. If your setup includes an USB-A to USB-C cable the
> pull resistors are in the cable, since the pull resistors are on the
> CC pins, which do not exist for USB-A.
This special setup is non-standard anyway, with 12V only save to use
for rock-5b.
The "3A-Cable" is advertising 1.5A, OK. Similar to my "35W USB-PD
power supply" advertising 12V/2.5A, hooray.
> The same pull-up resistors should give away the cable orientation :)
Should have tried this.
>
>>>    * RavPower 90W
>>>    * UGREEN 100W
>>>    * Anker 45W
>>>    * RavPower PB
>>>
>>> Changes since PATCHv4:
>>>    * Rebase to latest master (v2024.10-rc4)
>>>    * Fix regression introduced in PATCHv3: The exit code for fusb302_set_vconn()
>>>      when vconn stays the same should be 0 instead of undefined
>>>    * Fix regression introduced in PATCHv3: tcpm_set_polarity() needs to update
>>>      port->polarity when there is no driver specific set_polarity function
>> I can confirm that these fixes indeed fix my reported regression from v2.
>> Booting to Linux works perfectly fine when powering from simple USB-PD
>> supplies (12V, 20V), as well as with power from my notebook computer.
>>
>> So for the v5 series:
>> Tested-by: Soeren Moch <smoch@web.de>
>>
>> I also tested powering from a UGREEN USB-C dock (see boot log below).
>> This also worked well. Only the data role was not switched correctly
>> to host as required for the dock. At least we got this 'not supported'
>> message probably related to that. Maybe that can be fixed later in
>> follow-up patches.
> Yes, this series focuses on getting sink power role working as this
> is needed to enable USB-C support in Linux (or any other OS). Handling
> for data role swapping can happen on top of this. Linux should be able
> to swap the data role if it had been configured the wrong way around in
> the bootloader without triggering a hard reset.
In a quick test this had not worked. Maybe something wrong with dts?
Needs more investigation.
> So this should only be
> needed to have the dock's USB ports working in U-Boot itself.
Would be nice to have. Not that important for me.
>
> Also acting as USB-PD Source is not fully implemented and needs to be
> added on top of this once it is required by anyone.
Good to know. But not testable on rock-5b.

Regards,
Soeren
>
> -- Sebastian

