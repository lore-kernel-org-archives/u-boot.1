Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A25C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 20:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD47B876CA;
	Wed, 20 Dec 2023 21:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ql+ZYwof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0148783B; Wed, 20 Dec 2023 21:16:32 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A76B8750C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 21:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1703103390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+05uf3akNsxRDRy5xu6Dt1thk4dqkPYnTx5C9uAty4=;
 b=ql+ZYwofUlMu+LBYLIvuVWdZGg+og/05/qTlJy37MGuExN3FF+SqbRm/iQS5ExpUGf7+HQ
 /dwOxQk2qNI0WxYquxZuTO+VTDF07SYyJzUypMl6qZts2tXcUZqrs36e/21fizZy/nb5xQ
 YVHrAkNjuii23VS6KTT9yAJpYrNAwGK1lsQRKDbNpWaK5let6/y/x8XlScR4ry1KfzincQ
 CUrNXA5FZ0Lno4fVkbqV3a62ajGyWgFznT6hb40wxOalEB8aJCv8d1kJVWry96pbCIxM3w
 1b3Z8doVQAFCWXS73hfeDH6PWjMhXFHWWOSpCZFg652gdUk1cztb6gO7Bm5JAQ==
Date: Wed, 20 Dec 2023 21:16:30 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Sean Anderson <seanga2@gmail.com>
Cc: =?UTF-8?Q?Cs=C3=B3k=C3=A1s_Bence?= <Csokas.Bence@prolan.hu>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de, Daniel Golle
 <daniel@makrotopia.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: Passing boot logs to Linux?
In-Reply-To: <cf0fea58-45f8-ba73-9652-2a501343e0c4@gmail.com>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <16e633f9d4b1c426aaca510157479d65@manjaro.org>
 <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
 <2c108e1ff92db2b74f5ccccd770872a7@manjaro.org>
 <5e0e71a5-f3c8-413e-96a3-a0b6edee928f@prolan.hu>
 <3900f4b15852d0af65635b3a794d34af@manjaro.org>
 <f22f86ec-987f-4404-8722-82270f1e8da8@prolan.hu>
 <cf0fea58-45f8-ba73-9652-2a501343e0c4@gmail.com>
Message-ID: <83c598178705603a6b48a6797dc5b4d5@manjaro.org>
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

On 2023-12-20 21:03, Sean Anderson wrote:
> On 12/20/23 14:24, Csókás Bence wrote:
>> On 2023. 12. 20. 9:29, Dragan Simic wrote:
>>> On 2023-12-20 08:52, Csókás Bence wrote:
>>>> On 2023. 12. 20. 8:09, Dragan Simic wrote:
>>>>> On 2023-12-20 07:49, Csókás Bence wrote:
>>>> That's what I read as well. Is there support for U-boot to write and
>>>> Linux to read PStores?
>>> 
>>> No and yes, but U-Boot can already read pstore.  Please see
>>> doc/usage/cmd/pstore.rst for the U-Boot part, and
>>> Documentation/admin-guide/pstore-blk.rst for the Linux kernel part.
>> 
>> Irrelevant, as we only want to write out the console log to U-Boot, 
>> and
>> not the other way around (that's for collecting panic logs, which is
>> already implemented).
>> 
>>> Another benefit of using pstore would be no permanently wasted RAM 
>>> for
>>> the recorded console contents.  Also, having the data recorded to a
>>> storage device also goes along with providing permanent records.
>> 
>> I'm positively *not gonna save boot logs to disk*, as most embedded
>> systems have Flash-based storage media; writing to them on every boot
>> would be devastating. Plus, I don't want the console subsystem to 
>> depend
>> on any file/disk operations/drivers.
> 
> pstore is agnostic to the backend used. In U-Boot we only support RAM
> backends at the moment.

That's a very good point.
