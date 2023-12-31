Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F840C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 06:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BAF087727;
	Sun, 31 Dec 2023 07:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="N+LVLcj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B068773C; Sun, 31 Dec 2023 07:06:18 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC9EB87225
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1704002772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2pSf+T8OlwlaDZkoXkHwwJnuY9JcnhyZmTW2Ff4baE=;
 b=N+LVLcj7ORkA+QWTE3Garht96gzetWlp1y3+p8MzWk78hQsDoqFjBdxXu8LbLHElOiQsVP
 JpNpPuTvIs7Bjx8nS5RtsJOjnaUWOen6R9q/btwl7lHNdHekvNEtqeruJZr7+SvSz98mTD
 3x3UGbLGiMzojzDW8H5rX9JuzGyjaAO4ooWLy5IG8m1GOpMn4lAGv9PDfCfIDdVvDtcvg5
 TCrj86NFizXVmluA0cCO7pxSUrzLtaikayhwKEE2W5U5baJz2vu+vf/fV51niVf/2bFCqv
 q+DlE2oPDh0cj/aBFQ9iKJl2gZOh5fWc4a+76YF6+/pJUBy7I4WU7k/1+M1Ruw==
Date: Sun, 31 Dec 2023 07:06:08 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: =?UTF-8?Q?Cs=C3=B3k=C3=A1s_Bence?= <Csokas.Bence@prolan.hu>, Daniel
 Golle <daniel@makrotopia.org>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>
Subject: Re: Passing boot logs to Linux?
In-Reply-To: <514fe736-5122-41f2-bb1b-ee1a42ec2cb2@gmx.de>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <ZYH-K_UGat0yWMVH@makrotopia.org>
 <CAPnjgZ3sNBuaNkbTF2d=E2JD4sQOaA5QRfzDfz1KSV==nOWbTw@mail.gmail.com>
 <514fe736-5122-41f2-bb1b-ee1a42ec2cb2@gmx.de>
Message-ID: <365d67352976a6592c7a2ebfe96f4da6@manjaro.org>
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

On 2023-12-31 00:54, Heinrich Schuchardt wrote:
> On 12/20/23 05:11, Simon Glass wrote:
>> +Heinrich Schuchardt
>> On Tue, 19 Dec 2023 at 13:33, Daniel Golle <daniel@makrotopia.org> 
>> wrote:
>>> On Tue, Dec 19, 2023 at 08:08:48PM +0000, Csókás Bence wrote:
>>>> Is passing the U-Boot boot log to Linux supported yet? We are 
>>>> working
>>>> with a third-party solution, which works, but is a bit hacky, so I 
>>>> was
>>>> wondering if an official solution has been merged yet.
> 
> U-Boot supports writing log messages to an rsyslog server via broadcast
> to UDP port 514 (CONFIG_LOG_SYSLOG=y).
> 
> The device name can be set via environment variable log_hostname.
> 
> If you have a log server for your devices in the same network segment,
> you can consolidate all your logs there.

Sure, that's also an option for one's development environment, but 
unfortunately not for various standalone embedded devices in the field.

> A driver writing log messages to a file could be created in U-Boot.

Please read our earlier discussion about why writing to persistent 
storage is desired and why it isn't.  Basically, we need to support both 
persistent storage and RAM backends.

>>>> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
>>>> everything to a membuff, but I don't know if that can be exported to
>>>> Linux yet. And if not in the tree yet, would such a patch be 
>>>> welcome?
> 
> It is not enough to export a memory buffer. There must be support in 
> the
> operating system to read it.
> 
> Linux supports the common platform error record (CPER) format defined 
> in
> the UEFI specification. See
> 
> * 
> https://www.dmtf.org/sites/default/files/PMCI_CPEREvent_Proposal_v3.pdf
> * 
> https://uefi.org/sites/default/files/resources/Spike%20Yuan-%20Server%20RAS%20and%20UEFI%20CPER_final.pdf
> 
> Boot errors can be reported via the ACPI BERT table. But that won't 
> help
> you in OpenWRT which uses device-trees.

This is interesting and presents another option to be implemented at 
some point.  Just as some devices and platforms want to use UEFI, some 
simply don't, and having more options available is always good.

>>> To me this sounds very useful and definitely something we'd like to
>>> have in OpenWrt. So I'd volunteer to review and test your patches 
>>> once
>>> they are ready.
>>> 
>>> What comes to mind is that CONFIG_CONSOLE_RECORD also captures ANSI
>>> sequences during menu or count-down before boot, so we'd have to 
>>> either
>>> introduce a dedicated log_printf() call and use that when ever we 
>>> want
>>> the output to also become part of the log buffer or we could somehow
>>> filter the recorded console, eliminating all terminal control 
>>> sequences.
>> 
>> I have been asking for this for a while. We need some sort of inline
>> function to enable ANSI output. Perhaps something like this?
>> 
>> #if CONFIG_IS_ENABLED(ANSI)
>> bool use_ansi(void);
>> #else
>> static inline bool use_ansi(void) { return false; }
>> #endif
>> 
>> bool use_ansi(void)
>> {
>>      return gd->flags & GD_FLG_ANSI;
>> }
