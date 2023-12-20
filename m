Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F11C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B8986FFE;
	Wed, 20 Dec 2023 09:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="KYAc/l4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E668887578; Wed, 20 Dec 2023 09:29:42 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC25986D2B
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1703060980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPn+/R4UMu/ggLLlpIxYh5de6RLhSJe+cdemed4MaOY=;
 b=KYAc/l4eEMkrybeG5klcrTL6snw7sfgxiyyR7MM8tsifhGJWYVPYSbVf41Riea6SHW5Fta
 p6ndofx6/Fyb2lwh6CVHqBT3mHG5GAqu0p58Hwxd0B09ljS3mxZnGs9YrKTiQuEgHrxeC4
 8Bf58cRkoJyPesppkYeNiEKLusfKYm5djq5JE/PBWp0BGpxGLvFfVIpDL6CryjjNJbRepP
 HSS1I2xS67xU3aS4fD2d/HJPspmMnb7jJMfS53bH7Wk9F0crZs3ePM/wZJYf1FxTo0XOBX
 4jjRHt/LEo/Ow41VvrmP1VDAzCF0bFRsurIv61/7hRuRv8awMKb95s5kuJdh2A==
Date: Wed, 20 Dec 2023 09:29:39 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Cs=C3=B3k=C3=A1s_Bence?= <Csokas.Bence@prolan.hu>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>
Subject: Re: Passing boot logs to Linux?
In-Reply-To: <5e0e71a5-f3c8-413e-96a3-a0b6edee928f@prolan.hu>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <16e633f9d4b1c426aaca510157479d65@manjaro.org>
 <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
 <2c108e1ff92db2b74f5ccccd770872a7@manjaro.org>
 <5e0e71a5-f3c8-413e-96a3-a0b6edee928f@prolan.hu>
Message-ID: <3900f4b15852d0af65635b3a794d34af@manjaro.org>
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

On 2023-12-20 08:52, Csókás Bence wrote:
> On 2023. 12. 20. 8:09, Dragan Simic wrote:
>> On 2023-12-20 07:49, Csókás Bence wrote:
>>> On 2023. 12. 19. 21:33, Daniel Golle wrote:
>>>> What comes to mind is that CONFIG_CONSOLE_RECORD also captures ANSI
>>>> sequences during menu or count-down before boot, so we'd have to 
>>>> either
>>>> introduce a dedicated log_printf() call and use that when ever we 
>>>> want
>>>> the output to also become part of the log buffer or we could somehow
>>>> filter the recorded console, eliminating all terminal control
>>>> sequences.
>>> 
>>> I don't think that would be a huge problem, Linux userspace can 
>>> filter
>>> ANSI control codes if it wants to. For now, I'd like a byte-for-byte
>>> copy of the console, as-is, presented to Linux.
>> 
>> But wouldn't recording the control sequences as-is actually be pretty
>> much useless?  For example, some user can spend a few minutes
>> scrolling through the boot menu, which would produce a fair amount of
>> nearly useless recorded data.
>> 
>> Moreover, if I'm not wrong, viewing or parsing such as-is data would
>> actually require replaying the control sequences, to reproduce the
>> actual console contents as it was recorded, which would be quite
>> cumbersome.
> 
> It *is* useless, but most of the times the user won't be scrolling at
> all anyways, that's why I don't think these few extra bytes would be a
> problem.

Quite frankly, when it comes to computing in general, taking the "ah, it 
probably won't happen" approach isn't the best thing to do.  We should 
aim toward covering properly even the edge cases, if you agree.

> And no, you don't need anything to "process" ANSI codes, you can just
> `cat` them and your terminal will parse it anyways.

In that case, you'd probably see only the end results of the control 
sequences, which makes logging them as-is quite pointless.  To see what 
actually happened on the U-Boot console, you'd need to execute the 
control sequences step by step and watch the results.

>>> As I undersand (never used it before, just quickly read the kernel 
>>> doc),
>>> PStore is for Linux -> U-Boot communication. What I'm doing is the
>>> opposite. But the approach I envisioned is similar: make U-Boot save 
>>> a
>>> copy of the log to a struct at a fixed memory address, then pass this
>>> address + the length of the log to the kernel via DT and/or 
>>> commandline.
>> 
>> Actually, pstore is primarily intended as a means to record and store
>> kernel crash dumps for later investigation.  In other words, the
>> kernel writes data to pstore during an oops so it can be investigated
>> later.
>> 
>> One of the benefits of using pstore for record the U-Boot console
>> contents, instead of using a memory region, is that no special
>> utilities would be required to access the recorded console outputs. 
>> Also, many of the requirements that you listed below would be already
>> fulfilled.
>> 
>>> What I thought to include in the struct:
>>> 
>>> * magic cookie (it was in the 3rd party solution, and it's an easy 
>>> way
>>> of doing some form of integrity check)
>>> * struct version (in case we ever change the layout)
>>> * U-Boot version code (maybe not necessary? It can be parsed out of 
>>> the
>>> log as well)
>>> * length of the log (or it could also be passed via DT/cmdline)
>>> * and then the log buffer of course
> 
> That's what I read as well. Is there support for U-boot to write and
> Linux to read PStores?

No and yes, but U-Boot can already read pstore.  Please see 
doc/usage/cmd/pstore.rst for the U-Boot part, and 
Documentation/admin-guide/pstore-blk.rst for the Linux kernel part.

Another benefit of using pstore would be no permanently wasted RAM for 
the recorded console contents.  Also, having the data recorded to a 
storage device also goes along with providing permanent records.
