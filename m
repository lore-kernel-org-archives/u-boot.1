Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24ECC46CCD
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 07:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188F28701C;
	Wed, 20 Dec 2023 08:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="JcYUbvlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5B18700D; Wed, 20 Dec 2023 08:09:28 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8323C870B7
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1703056165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7abL6prwkH/R5h3lxUeie9suZdbWi0aC6OS85C7SbO8=;
 b=JcYUbvlVHz9lOi6ABapASympllwrKw1VqHU4HhWdlAlUwvNUrQuBFzaWNlHj2gBASDH00d
 45yb2aFpLjxhJh51bHIq9wOMalDdR0j63h2hfducFVepQbYhfFv/P77CDEfcluMP9spF84
 Wt/Ai+HI+h+Rt1+uTpHh/L0D7VEbGdkyVzHLbNeWE9PHvwUjvDuwC+yx7IJEpmzlJx1Pkc
 SsItxtzKjJJhDfnQi22dbp2dWd7hmsdDO0DHwDgwVH3uRo1ME7ElgL7IR/bQdqFFp5lqqj
 xwrIX0L3jJuvW/mdQVXtw3Gv8RiOVD/QOAgwgrnL7Udo5MqP8huj4KO1NzckTQ==
Date: Wed, 20 Dec 2023 08:09:25 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Cs=C3=B3k=C3=A1s_Bence?= <Csokas.Bence@prolan.hu>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>
Subject: Re: Passing boot logs to Linux?
In-Reply-To: <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <16e633f9d4b1c426aaca510157479d65@manjaro.org>
 <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
Message-ID: <2c108e1ff92db2b74f5ccccd770872a7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2023-12-20 07:49, Csókás Bence wrote:
> On 2023. 12. 19. 21:33, Daniel Golle wrote:
>> On Tue, Dec 19, 2023 at 08:08:48PM +0000, Csókás Bence wrote:
>>> Is passing the U-Boot boot log to Linux supported yet? We are working
>>> with a third-party solution, which works, but is a bit hacky, so I 
>>> was
>>> wondering if an official solution has been merged yet.
>>> 
>>> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
>>> everything to a membuff, but I don't know if that can be exported to
>>> Linux yet. And if not in the tree yet, would such a patch be welcome?
>> To me this sounds very useful and definitely something we'd like to
>> have in OpenWrt. So I'd volunteer to review and test your patches once
>> they are ready.
>> 
>> What comes to mind is that CONFIG_CONSOLE_RECORD also captures ANSI
>> sequences during menu or count-down before boot, so we'd have to 
>> either
>> introduce a dedicated log_printf() call and use that when ever we want
>> the output to also become part of the log buffer or we could somehow
>> filter the recorded console, eliminating all terminal control 
>> sequences.
> 
> I don't think that would be a huge problem, Linux userspace can filter
> ANSI control codes if it wants to. For now, I'd like a byte-for-byte
> copy of the console, as-is, presented to Linux.

But wouldn't recording the control sequences as-is actually be pretty 
much useless?  For example, some user can spend a few minutes scrolling 
through the boot menu, which would produce a fair amount of nearly 
useless recorded data.

Moreover, if I'm not wrong, viewing or parsing such as-is data would 
actually require replaying the control sequences, to reproduce the 
actual console contents as it was recorded, which would be quite 
cumbersome.


> On 2023. 12. 20. 6:04, Dragan Simic wrote:
>> On 2023-12-20 05:45, Sean Anderson wrote:
>>> On 12/19/23 23:11, Simon Glass wrote:
>>>> On Tue, 19 Dec 2023 at 13:15, Csókás Bence <Csokas.Bence@prolan.hu>
>>>> wrote:
>>>>> Is passing the U-Boot boot log to Linux supported yet? We are 
>>>>> working
>>>>> with a third-party solution, which works, but is a bit hacky, so I 
>>>>> was
>>>>> wondering if an official solution has been merged yet.
>>>>> 
>>>>> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
>>>>> everything to a membuff, but I don't know if that can be exported 
>>>>> to
>>>>> Linux yet. And if not in the tree yet, would such a patch be 
>>>>> welcome?
>>>> 
>>>> Not yet, but yes I would like to see this.
>>> 
>>> I think most of the infrastructure is already here. We could use 
>>> either
>>> console recording (as mentioned above), which is more complete, or a 
>>> new
>>> LOG_DRIVER (which would have the advantage of omitting things like
>>> countdowns).
>>> 
>>> In terms of sending things to Linux, I think the natural choice would
>>> be pstore,
>>> which we already have a parser for.
>> 
>> Yes, using pstore would make sense.
>> 
>> As a note, I'm willing to work on this, if Csókás actually doesn't
>> pick it up.  I'll be so happy to see this feature reaching all kinds
>> of boards and devices.
>> 
> As I undersand (never used it before, just quickly read the kernel 
> doc),
> PStore is for Linux -> U-Boot communication. What I'm doing is the
> opposite. But the approach I envisioned is similar: make U-Boot save a
> copy of the log to a struct at a fixed memory address, then pass this
> address + the length of the log to the kernel via DT and/or 
> commandline.

Actually, pstore is primarily intended as a means to record and store 
kernel crash dumps for later investigation.  In other words, the kernel 
writes data to pstore during an oops so it can be investigated later.

One of the benefits of using pstore for record the U-Boot console 
contents, instead of using a memory region, is that no special utilities 
would be required to access the recorded console outputs.  Also, many of 
the requirements that you listed below would be already fulfilled.

> What I thought to include in the struct:
> 
> * magic cookie (it was in the 3rd party solution, and it's an easy way
> of doing some form of integrity check)
> * struct version (in case we ever change the layout)
> * U-Boot version code (maybe not necessary? It can be parsed out of the
> log as well)
> * length of the log (or it could also be passed via DT/cmdline)
> * and then the log buffer of course
