Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4435BC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 01:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5913287083;
	Thu, 30 Nov 2023 02:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AG6MF97o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E871A87083; Thu, 30 Nov 2023 02:13:47 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA07E86F64
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 02:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephen.graf@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6cb55001124so1260623b3a.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701306824; x=1701911624; darn=lists.denx.de;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRlvrK07ME/swY1WtbkSFR7EDZxwvHnw2DwPwO6LavQ=;
 b=AG6MF97oHnksUu28zP4E1FHLZfnGQNXHVnp5LrsRNIK5EqP0DDBPGahcVQ8o8i35hf
 tJK3ZvlGoHBYvwAG0SuIIe6LYbhNRDZ32aqoFMVld3ELAz5mqNbjDXWj016KTqiadLKG
 8zkemY6Fq8resJdlwrocFbO4GPw8YDwDKs0968ePOaLOe64yehHiVRjgxg5c/nGfAbso
 jqOUqYWuJlb0mtmmaXm9Ay/LhglG/hltla1IcBGCmjlcyoHHHney5XXV/C5lUWbqg6r8
 tcJu1FK4rXPjcUoqs0UEylR700FRuZitZ+lh6LnUK3BmGgWkZHjECQrySnxrm9m6ad6p
 q+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701306824; x=1701911624;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GRlvrK07ME/swY1WtbkSFR7EDZxwvHnw2DwPwO6LavQ=;
 b=ecYVpQDLF7k3IDvrxp6sXVCg9k57NTecwVTcZZh2kVjzp2lmxfgsgm26IebJ8FeO+c
 z3aMg71W2Gg+1AkW6Kt7xCtLV6OOBSzcglspdgoNSbY3o1u3acE3CnGmhHMgSk2Tc8KF
 NtzY29SfJ8qBlFfi70EwlIgiZtz8U+iPhuvzLIjsVr/DZKAaG/Ys6Grih41F/Wnj7T40
 38NoSPn+0FdvOczP9TfndJ2yjf0gFdOQqWXVWhHkQVUXIAVr4SJW1vPkNyJlneHJq7pL
 l4Sqy81MjGx8VpBEfF4wxFt1P2LM4stPLr93h55kXeFYKclQn1XQgFD4jG9n/RpC9Ye8
 9ExQ==
X-Gm-Message-State: AOJu0Yxs08GZ8rBPkoY2DbgKsH23O0QUMu5Mh4V1MAWmQcm7iTGPL2XJ
 2t9DMUAMSgVqQC12Q12eAKUCSkVpSfNdIg==
X-Google-Smtp-Source: AGHT+IHWXFPf3pnitxvRRVnIq53o2oX4t0dZ7xmS/i8c9uaIbLku3rIFWerU43/CaJw+lmtOSxH0EA==
X-Received: by 2002:a05:6a00:1252:b0:6cb:8abd:39b5 with SMTP id
 u18-20020a056a00125200b006cb8abd39b5mr30053248pfi.1.1701306823895; 
 Wed, 29 Nov 2023 17:13:43 -0800 (PST)
Received: from [192.168.1.3] (d23-16-72-139.bchsia.telus.net. [23.16.72.139])
 by smtp.gmail.com with ESMTPSA id
 i5-20020aa787c5000000b006cb7e61cfa7sm25736pfo.36.2023.11.29.17.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 17:13:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------souDGRPkyc90BWFO9uidqPL5"
Message-ID: <d410fbe1-bf0f-4cb5-99cf-3353b952985b@gmail.com>
Date: Wed, 29 Nov 2023 17:13:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mdt_debug write
Content-Language: en-CA
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
 <20231126122342.3944cad5@slackpad.lan>
 <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
 <dae3bee5-e1c7-4154-959c-e41dabb5d844@gmail.com>
 <20231128013746.23648d39@slackpad.lan>
 <5d7ea381-2a57-46f7-85c6-2bcad339d1db@gmail.com>
 <0d46cc83-8820-4bf2-95bd-a0c12b6f7aff@arm.com>
From: Stephen Graf <stephen.graf@gmail.com>
In-Reply-To: <0d46cc83-8820-4bf2-95bd-a0c12b6f7aff@arm.com>
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

This is a multi-part message in MIME format.
--------------souDGRPkyc90BWFO9uidqPL5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Is the attached patch file going in the right direction?

On 2023-11-29 3:57 p.m., Andre Przywara wrote:
> Hi Stephen,
> 
> On 28/11/2023 20:07, Stephen Graf wrote:
>> Below is the console log from trying to use mtd_debug write. It 
>> returned immediately with a strange success message.
>>
>> root@orangepizero3:~# mtd_debug write /dev/mtd0 0 0xf0000 
>> /home/sysadmin/u-boot-sunxi-with-spl.bin
>> file_to_flash: fread, size 0xf0000, n 0xf0000
>> fread(): Success
> 
> interesting, I was under the impression that "mtd_debug write" would be 
> the way to write to flash. In hindsight, the "debug" in that name should 
> have probably put me off. Anyway, "cat" is probably not a good choice, 
> "dd" is better, but it looks like "flashcp" (also part of mtdutils) is 
> the go-to tool, since it does the required erasing automatically and 
> also reportedly does some error detection. Can you please test this?
> # flashcp u-boot-sunxi-with-spl.bin /dev/mtd0
> I would test this on my end ASAP as well.
> 
> Do you feel like sending a patch to the U-Boot documentation to get this 
> changed then?
> 
> Thanks,
> Andre
> 
--------------souDGRPkyc90BWFO9uidqPL5
Content-Type: text/plain; charset=UTF-8; name="--- docboardallwinnersunxi.rst
 .txt"
Content-Disposition: attachment; filename="--- docboardallwinnersunxi.rst
 .txt"
Content-Transfer-Encoding: base64

LS0tIGRvYy9ib2FyZC9hbGx3aW5uZXIvc3VueGkucnN0ICAgICAgIDIwMjMtMTEtMjggMjE6
MzE6MDYuODQ0NjA3NDAzIC0wODAwDQorKysgZG9jL2JvYXJkL2FsbHdpbm5lci9zdW54aS5y
c3RfdXBkYXRlZCAgICAgICAyMDIzLTExLTI5IDE2OjQ4OjAzLjY4MjM1MjMyOCAtMDgwMA0K
QEAgLTI1MSw4ICsyNTEsNyBAQA0KDQogICAgICMgYXB0LWdldCBpbnN0YWxsIG10ZC11dGls
cw0KICAgICAjIG10ZGluZm8NCi0gICAgIyBtdGRfZGVidWcgZXJhc2UgL2Rldi9tdGRYIDAg
MHhmMDAwMA0KLSAgICAjIG10ZF9kZWJ1ZyB3cml0ZSAvZGV2L210ZFggMCAweGYwMDAwIHUt
Ym9vdC1zdW54aS13aXRoLXNwbC5iaW4NCisgICAgIyBmbGFzaGNwIC12IHUtYm9vdC1zdW54
aS13aXRoLXNwbC5iaW4gL2Rldi9tdGRYDQoNCiBgYC9kZXYvbXRkWGBgIG5lZWRzIHRvIGJl
IHJlcGxhY2VkIHdpdGggdGhlIHJlc3BlY3RpdmUgZGV2aWNlIG5hbWUsIGFzIGxpc3RlZA0K
IGluIHRoZSBvdXRwdXQgb2YgYGBtdGRpbmZvYGAuDQo=

--------------souDGRPkyc90BWFO9uidqPL5--
