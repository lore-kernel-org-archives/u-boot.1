Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA58606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FkLpwdxP;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yy8C9XM8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B59EF40A49;
	Fri, 23 Oct 2026 14:55:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cOY_RZQEvXL5; Fri, 23 Oct 2026 14:55:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6D7D440A1A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792767351;
	b=VnjABPoOSfgiatHCahnzNHEkuB6h7JWCRrI9yGKq3XvcsRg4LNIVwwwYipk2IJPCxk++
	 jLAuZb4rWjOinFb3clULsIMWqX0/asx+uU/fWJ1R/eMXSsLw6ShIW77CPvLkixn7GSZN4
	 bDZgWRFDhhWumI5TcnWkcNWLZ4H4YbXoxtJFErogF6WURlJCGQK8u2SFAoAIUapuN0+wZ
	 hY8ZNo0M+3MnvgtqxnOTQY5kPdLkvfc3vhtsmSZo6ahO5D16KdyueLKED6cXhP3DI3Tm6
	 0tFqTKTJQL5jMKF9V3fMu6CBwwFpTpuRt0OrCibsEuYU3po1McrHMfy0Q0egRKTHhrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792767351;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4viEiB0YmYG6+5vg3tgo0E7MFuaV5psTzS9PZl8UNP4=;
	b=AoGJf6H/mnlmFmTz5mto7GQcnUU2i1hK/UoHOEFYG4kBW/ySgSB8KfSyMkZP9o0JErkT
	 4mUPIdTfVEQvIt4U492YBuFvRo+5NZTRdnsND6ypTgPQ+rIld7zn4zy17eosOxsCpiq+a
	 8hXungUvI1ik7vLjKpHM1Y6vOpHfRcj5/NSJ2Zu0ggSK3ay5I9wkzB8v3l+67NtDkG2qG
	 Gdqc+2A1j6ynu5/ALd3T9q/5WWSoFetWpLQYtrD35q9Ob3UG7q/tFkFotQDfl8uy348Zz
	 Oo2UqmRmx0i7ZIn++jFYtWyaZmnicL1QozBn2BD5Sa8UybhxtSVknEAYZHmaN6bo6cg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792767351;
	bh=4viEiB0YmYG6+5vg3tgo0E7MFuaV5psTzS9PZl8UNP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FkLpwdxPNRQN9fWAfk0cR36CUnHV96Ok4uBk5LDg4k43xXeLqdigF1+GKhBNG+1ED
	 4NYaikEgUIfTeWLqdhxuNuIPd5Pmu5WoBkyEsGRD/lTGfDc2F5IyV4Lz3jEZRBLtbe
	 tqIMKpViq1SIlHFYK9/QbQxqMa+MNxqqNIEek8nNNuZj+uMWln7CrZCHgWKS2lQoDv
	 YvZQyUr4BbF14+afW/Ub7qKW3J3FQnh4N529/3JvZ8pOljEWolbePcUEhpWsMZt2Wf
	 bc84ohK8cutV1m4aRdF48RjNBnwIZaPiU2sj6DqJZ/KfG2TBcI2JR3Jnod4gmXzaHM
	 I8gPqDhMuePDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D7D440A1A;
	Fri, 23 Oct 2026 14:55:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AD4012C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60F07606D6
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3k6oJKacXEef for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:31:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6FBAF606BF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792762281;
 b=a/wABOecDvxYVejtpQU5a+3cla4dzPrHAQ+I8RodhcddtRpuaXwCnSGWpcg4y5/gnVMz
 E3iNtGOCAcD0tE2LQq9MrIDvSq7Zo3vOR5qoysaHRYiTTaqUNcV+xI5oUs/cJnnP0ijD7
 tvjnbH5ZDZdzbTZIO6GpX/cc6B8LqyHhq17Puli6BtgnvPyEC5GmEVLPsfkvVY4mM+TIO
 CgUQ4BV1jzw7l4/jw771h9MtMThsXlcuF2EvKl2gRVkLaKHRKc9hPBe658FaZiRIKi/04
 OPkprUOZcPBQPw6hLCd6nuQ5aOrCaqtgqRYDfMZFXebY2lLb38YytMBQC3QXoKQbeUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792762281;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=4viEiB0YmYG6+5vg3tgo0E7MFuaV5psTzS9PZl8UNP4=;
 b=WeHeqyCUih41fHeMPTXoTqayPOHaVBKzuv+kJjzsg8B8/hcr/Xu0hBeQxSzetB/nZf3C
 M8mrpOdmDJmWyOtoLlUzbeuxKpOz6y3oJcGN1SAzd5lYM5421gD75oE6Wk9Lhedz9umJe
 6S31a8SiOuUwjleX9JiwE7oZy6cNTuTU33/65rWCmK8S4ZKc7DJs+wBKOjQp60b5Q6LgF
 2qCjZurYyFV1o6AVrBfJxXPD4syBeZJOqodU5iT/+IcnM6jHJqw+wXXp3PXKtLj4ROsJV
 Yycu1xBigDCeJr+xucNY2iX8yQvcL3+TfHpEj8DhQvO/1gtJd6J8eMrmaAuPZfQdGxA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Yy8C9XM8; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Yy8C9XM8
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FBAF606BF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:31:19 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2e5378b281aso5152475ad.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792762278; x=1793367078;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4viEiB0YmYG6+5vg3tgo0E7MFuaV5psTzS9PZl8UNP4=;
 b=Yy8C9XM8D4F7m9fzQeuadJLESb83Cw6V+F2Y+as65JrUChsoLw8PcySjg+zk3UD6KS
 Q9py9q5XP0fkXc2nwHk1DjwiRjP2FfhS6b6YQVco2Dnb0QufB91bPVafiwHEtF3CToto
 fmdMVn6idXT3wZr9eI+6qi52YYog3k/MgzQB1IuAHbKl7XwlPnrgcuHAFarfz86P9uz6
 sWbXrVigQ351oc6DpN2YQkReFmib2wb/XwZLSOiRyge2T6Gii0RFnKBZB4bslrV6+ir9
 q1jFMKiiM8rmN0Ol7TtxLLwiEEKhpFccdeWz6QJrcEIHF+1FD1BAwnZlA6nbfVz+HiLk
 noMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792762278; x=1793367078;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4viEiB0YmYG6+5vg3tgo0E7MFuaV5psTzS9PZl8UNP4=;
 b=EnMB68b0a0VYJoVvY9Z/o1NGrnjaThdUu7O4jj3S8E6noajwo5O6fRttlZvd5vGt+b
 ppjqX+tE8O8Plx3Ws97lPnrFp9OeyfpMGesGWGJstkXdWxNLwbh1/trzcVBTNN6zdT1j
 pKwm/1A4d68GreopOOCPOeCOiqNwoz/vyU+QxX7bUsAQq2goZyCYHF/PDhrdVBXAyjCF
 DbcfhxTl2Biii4eHfFBy9W6gCplYbJfIoOFalvPKCl0sKosFyC5QbBAS7VI2HTJ92+bR
 inR3oza5AT2+09DedwrH8MSvLLaqZOGNdibV1P8zFlEtAlegCPVepIX0ZkPC9HrWggiS
 d3sA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnZp839PpAPy2POnJ/YWDYRtm4Wd0R014OcdohMrqM3muk9pir9OHtcjQbGdHtiq0BY4O2yIc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLMN8c8gy3HN1jG0UmxnGnhBd1oyhazCbicayLDLnBcyt7pWhbY
 ZVJkFw1LwsHpIfdJ1R+RhwTR1oAkYhkWrfDRJB+f+g5BqenoH4/DbFJl
X-Gm-Gg: AYBFou0E2sMw+lLgfTNeHvhedmTw4QNxKo75Cp6vrpypfb8eg4CgbXPCC9iqkZebnw1
 BLP/tysKbGduMcMAT1OyTFU2++ysUE666pRiA5b55YY+0hd4LY6LleN50biiI/Oq5CDya1XN/Ht
 iUNzy1s1HBN89ZeQANSDonWGevT6sKadTMG2SAmGhIA0eFfoEm+RBHQ2N6roshhwc9hKO/+uqIN
 aOuDdb0emNgekh4A72Fuc02IX7de5onJ97lZR03Fwn3TWHso/oc7GexV/bE9ldYbS5MVSvCZnak
 p78Z8I6A+eBlfhCF85x/01Py1yPgfA1GtahF0cL1Pr6eos473WTJW0bOqcAdGjKc7muolGar063
 7nxRVzGpEhMj7KYEVGYfNdkiqNRWlBRCmC1XjTjKHImrSdq4S/7yyRW2J2FLvbGQKum/lik1C/A
 4pX8ykQ0YHefVzv6nn5pN19qEL7mw9giy+dpcooWx85aS4tyWHJkNXMLRYdV2hVRn1S4R4gGg3R
 d9+5J2MKxNuUO0P2RqNUy/p8dDXtCC5icTNbd7uU3RNXyvbN4NPQA9w/g==
X-Received: by 2002:a17:902:c948:b0:2e5:d2af:8a92 with SMTP id
 d9443c01a7336-2ea7c1dac15mr23941555ad.61.1792762278198; 
 Fri, 23 Oct 2026 06:31:18 -0700 (PDT)
Received: from [0.0.0.0] ([20.89.104.82]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea947abf3dsm116335ad.75.2026.10.23.06.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 06:31:16 -0700 (PDT)
Message-ID: <2235cf81-8b4f-4ac1-be3b-08f0d981bac6@gmail.com>
Date: Fri, 23 Oct 2026 21:31:11 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] usb: add K1 USB2 PHY and generic DWC3 support
To: Yixun Lan <dlan@kernel.org>, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Dave Klotz <DaveWK225@protonmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io, Eric Chung <eric.chung@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>
References: <cover.1792007916.git.DaveWK225@protonmail.com>
 <20261023105942.3896164-1-alan.tseng.cs@gmail.com>
 <20261023120427-GKD125937@kernel.org>
Content-Language: en-US
From: Zixian Zeng <sycamoremoon376@gmail.com>
In-Reply-To: <20261023120427-GKD125937@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 14:55:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun and Hung-Chun,

On 2026/10/23 20:04, Yixun Lan wrote:
> Hi  Hung-Chun,
> 
> On 18:59 Fri 23 Oct     , Hung-Chun Tseng wrote:
>> Hi Dave,
>>
>> I tested v3 on a Milk-V Jupiter, on top of main 903c9578e plus a local
>> patch that adds the Jupiter DT to the FIT.
>>
>> USB 3 works without your combo PHY series. A SanDisk stick shows up at
>> 5 Gb/s, and fatls and a 32 MiB usb read work.
>>
>> But it only works after I power the onboard hub by hand. The Jupiter
>> ports sit behind a VIA VL817 hub (usb2109,2817 and usb2109,817). Its
>> vdd-supply (GPIO123) is not always-on and its reset is GPIO124. U-Boot
>> has no onboard hub support for the VL817, so "usb start" finds only the
>> root hub. After "gpio set GPIO123; gpio set GPIO124; usb reset" the hub
>> and the stick show up. The BPI-F3 DT has the same hub, so it probably
>> needs this too.
>>
> ..
>> I don't think this should block the series.
> 
> Right, I've merged this series and sent a PR, see
> https://lore.kernel.org/all/20261023063727-GKA184714@kernel.org/
> 
>> I can send a follow-up that
>> adds the VL817 to usb_onboard_hub.c and enables USB_ONBOARD_HUB for K1.
>>
> 
> Yes, onboard hub is right way to go, should be quite straightforward,
> I know Zixian (Cc him) is working on a patch for it which almost ready
> 
> Maybe you can co-work with him?
> 
Indeed, I had also noticed this issue before on bananapi-f3.
However, at the beginning, I used a different approach to solve
this problem:
I used the glue_configure callback to call 
dwc3_spacemit_glue_configure() on drivers/usb/dwc3/dwc3-generic.c,
which powers on the onboard hub and releases the hub reset.

But that's not good. Then I found u-boot provides a way to do
the thing exactly what I need on bananapi-f3, lol..
(CONFIG_USB_ONBOARD_HUB/usb_onboard_hub.c)

Hung-Chun, I'm glad to test when you send patches about that issue :-)
and also thanks dlan :-)

Best regards,
Zixian
