Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35EDC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 01:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C098840D;
	Wed, 17 Apr 2024 03:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="o9fU+hDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7DB38841D; Wed, 17 Apr 2024 03:28:40 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98A4388371
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 03:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713317318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Er4Oku7ZDMXUf/kwXHjXDKJQKggGcoVP4SI59kps2eQ=;
 b=o9fU+hDGVRuEFVJEMqFu14qy/7zMqLjM1L/tNnEoB+BNHk1CpE47xk+rdAKF09ROz3hx0V
 V5N9kWLdwwBPK9XIqHh+cItbM6p6HYb5+WPZOgkC3sIRMm3gNsdg2k/1ClyKQfu9JknEJ4
 pKjaUdlCo8Fvq0DjrwdkIocL0EYjZr/8gSGzPETujcHt2L1c3o8Ef8PPYnZ4AuYe05V9CS
 9m6ZGzA0weYOVuTJwQS2KzdmzebrnH5o341z7jfOjqbMF8aCgnSHsGBuMo4winmiZc2eFx
 UQVYy5S1uDdqaC3AsKF1OZTzHmYjd/7HnVH/eZUflNewd8ctQkH6MB0SWQ0Hrg==
Date: Wed, 17 Apr 2024 03:28:37 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: 'Quentin Schulz' <quentin.schulz@theobroma-systems.com>, 'Jonas Karlman'
 <jonas@kwiboo.se>, 'Peng Fan' <peng.fan@nxp.com>, 'Tom Rini'
 <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
In-Reply-To: <000901da9056$75785ae0$606910a0$@samsung.com>
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
 <3b2643b4-dea7-43cd-9f9c-da63e6588281@kwiboo.se>
 <ac394528-ca53-41d5-8c4c-7c10943a7c92@theobroma-systems.com>
 <9b62bbedf2c6d52b76a8ce1ce57dd35d@manjaro.org>
 <CGME20240410085657epcas1p4c824b9243f8e2c6e8bc84e51d5cb1deb@epcas1p4.samsung.com>
 <8fec34b8-8d04-40ba-baca-5394762a4d27@theobroma-systems.com>
 <000901da9056$75785ae0$606910a0$@samsung.com>
Message-ID: <3e14a54ad8627f40a3718970386c8f67@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Jaehoon,

On 2024-04-17 01:33, Jaehoon Chung wrote:
>> -----Original Message-----
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> Sent: Wednesday, April 10, 2024 5:57 PM
>> To: Dragan Simic <dsimic@manjaro.org>
>> Cc: Jonas Karlman <jonas@kwiboo.se>; Peng Fan <peng.fan@nxp.com>; 
>> Jaehoon Chung
>> <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>; 
>> u-boot@lists.denx.de
>> Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to 
>> match linux
>> 
>> On 4/9/24 21:28, Dragan Simic wrote:
>> 
>> [...]
>> 
>> > Let's keep in mind that the troublesome DT properties describe the
>> > capabilities of the MMC controller and the board, not the capabilities
>> > of the MMC storage device.  As we know, eMMC devices provide automatic
>> > detection capabilities, to allow the host to determine its supported
>> > modes, and match them with the ones the host is configured to support.
>> > It's all described in the JEDEC standards.
> 
> I didn't see the above mail in my mailbox. So I can miss something.

It seems that, for some reason, the mail server(s) for @samsung.com
don't like the IP address of the @manjaro.org mail server, so my email
messages to you get rejected.

>> So why do we have those properties specified in board DTSes instead of
>> in the SoC DTSI? Logic would want us to have this defined in one place
>> only. I assume the issue is that even if the eMMC chip itself says it
>> supports HS400 but the HW routing or some other issue make it 
>> impossible
>> to use, we need a way to disable it from the DT for that board?
>> 
>> > Having that in mind, I find the approach in the Linux kernel rather
>> > reasonable, because I highly doubt that some MMC controllers support,
>> > for example, HS400 without supporting DDR52, or HS400 without supporting
>> > DDR52.  A reasonable approach for an MMC IP block is to make it capable
>> > of supporting all the speeds below its highest supported speed, to make
>> > itself capable of supporting more, if not all, MMC storage devices.
>> >
>> 
>> That's true for the IP block which is self-contained in the SoC, but
>> it's forgetting about the other part, the eMMC chip/card. It depends 
>> on
>> the HW routing, where mistakes/limitations can happen. And I don't 
>> think
>> we have a mechanism today to disable the modes set in the MMC 
>> controller
>> for a given MMC card from DT (aside from /delete-property/ in board 
>> files).
> 
> The both opinions make sense.
> But, It doesn't set to all capabilities when nodes has mmc-hs400-* 
> property.
> 
> That's why it's describing to each property is because they want to
> clarify only which mode they use.
> 
> AFAIK, I can't remember exactly, there were some boards that even
> though HS400 is working fine,
> but HS200 was not working fine. (It's depends on which IP board is 
> using.)

That's really good to know, thanks.

> There were too many cases not to work fine because of *HW* design.
> eMMC and Host IP were supporting the HS400/200 and all modes, but
> there was a problem of handling clock.
> So it couldn't use HS200/400 and other dual modes.

Yes, there are all kinds of eMMC signal integrity issues on different
designs.  There are also similar issues with different microSD cards,
causing some of them not to work in SDR104 mode on a particular board,
for example.

> And We needs to know if it's working fine.
> If we want to use hs400 mode, but board can be working to other mode
> without any error.
> Of course, we can see a mode as log. But it's at least approach to 
> limit.
> 
>> > In fact, I'll probably go ahead and submit a Linux kernel patch that
>> > updates the descriptions in the binding, to hopefully eliminate any
>> > ambiguities like these.  I hope you agree.
>> 
>> I for sure do not have enough knowledge in MMC to argue more than I 
>> just
>> did, so having people with more experience/knowledge have a look at 
>> this
>> would make sense, let's see what they have to say :)
