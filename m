Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6941EC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F4D875FC;
	Wed, 20 Dec 2023 13:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="KO6IfDV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90CAB87705; Wed, 20 Dec 2023 13:35:49 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DD986D38
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1703075746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k+IFkylcX7pxhl1bzh3r0kkrhnCYMoRr4S7cKeQmmUU=;
 b=KO6IfDV/gY4io7rOxNzcIYeHd34LEKQUMTUQj9h1pl613zcwQ6pSDY/FRHUjEsxBdXk2gj
 eQj7v+3gAK6FgdbOVwrEApElwhCxbj72jOS0g/OYytPTHThb6G7S1Iulu+lAZeUyzdFGSB
 o7wWtH3toxuNaBrkdDBvEbrT2VO830McytmTLqf1T3ZNv1IjeuBlN2FWlg7QNMAKJCETPO
 RxWethVKfHs0314dShu/6uD8ux3oPhkcbmP+nHUaasOye98smkDQaYW8WhGwdjv34GW5Wf
 uxO8KyKet6Psxn+0xEMb5wecf5hSO/feguCDs17vdd8IqxCwk0wytCRghZlIsg==
Date: Wed, 20 Dec 2023 13:35:46 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Sean Anderson <seanga2@gmail.com>, sjg@chromium.org,
 Csokas.Bence@prolan.hu, u-boot@lists.denx.de
Subject: Re: Passing boot logs to Linux?
In-Reply-To: <87msu5np1w.fsf@bloch.sibelius.xs4all.nl>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <87msu5np1w.fsf@bloch.sibelius.xs4all.nl>
Message-ID: <52d6c4a1973f88607651672ce82af944@manjaro.org>
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

On 2023-12-20 11:31, Mark Kettenis wrote:
>> Date: Tue, 19 Dec 2023 23:45:48 -0500
>> From: Sean Anderson <seanga2@gmail.com>
>> 
>> On 12/19/23 23:11, Simon Glass wrote:
>> > On Tue, 19 Dec 2023 at 13:15, Csókás Bence <Csokas.Bence@prolan.hu> wrote:
>> >> Is passing the U-Boot boot log to Linux supported yet? We are working
>> >> with a third-party solution, which works, but is a bit hacky, so I was
>> >> wondering if an official solution has been merged yet.
>> >>
>> >> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
>> >> everything to a membuff, but I don't know if that can be exported to
>> >> Linux yet. And if not in the tree yet, would such a patch be welcome?
>> >
>> > Not yet, but yes I would like to see this.
>> 
>> I think most of the infrastructure is already here. We could use
>> either console recording (as mentioned above), which is more
>> complete, or a new LOG_DRIVER (which would have the advantage of
>> omitting things like countdowns).
>> 
>> In terms of sending things to Linux, I think the natural choice
>> would be pstore, which we already have a parser for.
> 
> Well, this should be OS-agnostic of course ;)

If possible, of course.

> What is pstore?  Is this documented somewhere?

As I already explained briefly in one of my earlier posts, it's a 
mechanism that the Linux kernel uses to store the kernel crash data on 
persistent storage, for later examination.

Please see the following links, for exaple, for more details:

- https://docs.kernel.org/admin-guide/pstore-blk.html
- https://man7.org/linux/man-pages/man8/systemd-pstore.8.html
- 
https://blogs.oracle.com/linux/post/pstore-linux-kernel-persistent-storage-file-system
