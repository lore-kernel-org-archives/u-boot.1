Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49242C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 12:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D674A60692;
	Fri, 11 Sep 2026 12:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tI4RBP82NBHN; Fri, 11 Sep 2026 12:26:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E0E9660672
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789129569;
	b=oheL2yN0NWwq0YY0GDE2QNfEDxKpBxAy4SbWplMPZQIUGs1u3LOZQ080XnMwclEB/ZZD
	 TYqUTTTDNtorQYTt5421QnZjchXX1EfmevfwEhoPPEHI89DZBO21iwd0Ri25DIwvr+2VZ
	 LeDZtTmUgxAYSa7luryrtsfxRa1Lq1X2w1pRZcqvoAin1zHDNy/X8ijClwQatxT0N9bBS
	 8m3jzabOc3UE4+aIgVKl69+Djnb+zJLK1d+9YVAMT4y8u95DONY3fWeJT/HugoOUlhR5T
	 GqJbHMJTV2d13aVLra+ydNZc5PIeRBWc+4FX8N+KnlJLbAu4X20Ja2ppV/Hwckvh1ow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789129569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NOGVmRn8UJOWtbR3HhtkP1tSe3UWDm4yp6BwldR32hI=;
	b=Qs3FpfP/gK4y2s8IdtqHyrWInOpAD8AmUMJ3o5nVvjtePVJVIMeOgVjR+abiay+6MCOH
	 TEfTt58FWnuUEqB/80p8TiI47J7VdE4jHXfbs9lg/7XxppWxYjSo9YYtjXtNxtS52Ffpc
	 j158Cbx2gSgH42nEJQWokAmKk3h6m3JSzMsMUxWjRAlMohdo3xRAIg283iG+hzlKqXkpA
	 +fbEed3H4ZIvqOS/JWH650P14yy8bdOgKEUVfobihfWdDTcyLWZQhhQwpHBeYzMmV/ejc
	 52/87WI/c5H9oG8nYkebaD8dJpZMKXKjR+6bbOpkMd+Q0ZRFToQqsYWI1A/vPqP7KsA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789129569;
	bh=NOGVmRn8UJOWtbR3HhtkP1tSe3UWDm4yp6BwldR32hI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1Caw4T0BarLrx9Ncwj0hvUPf7pn7Qd5ZXNAzoiGBcwykMBpQsY4EzxLmSl5kHpkp+
	 elmpRF7DEQlnplVmMpNI1dTMuP4g1QT4jbGWCf3gTKC3w0uLn/A4aRxQqGpN1rvNaE
	 /9laR34BF6YSdwRNyFm4Yh8W3aSt/ADu4fPLf5o6q/pa13OIpGnduQSgBrxR+xNjdN
	 CmAZq6qEHRJkNvm3z8L8tVcsu01nyjdq4ZWJgHdBNX3qGI3L0RJ3H5xsUiysE9oD8N
	 TjHNDY5p9Vf/Lluf6R8BBkUmTu9PTr0L4NlOYcYXvZgYBIoxxTIRrMcD0US94TbZCm
	 c8Q7W76EqM2lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0E9660672;
	Fri, 11 Sep 2026 12:26:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D2D514C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00D6140479
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DpzXLNW58VZ0 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 12:26:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1362D40469
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789129566;
 b=Fg07xI/ElVC+7C8rhW66y3CMF9PJj9bvPoD2rUB1jubZyzP2WdqIWahguUbN71vNkVmB
 V7nPT8SQe0VkQkho4X8DK1FIFCBErATq69gPPws5Rk0NfsND+ZqHLkwaboh1kTvskM3W8
 KxW1aRS6yRJ5E2dAOp2/VnDx1dXWDgi3KZeDkeKzc5Y1W63icC9K/VBVXqUwbxEypgh02
 nWmcxyCqNrBn1vn/UCxmZjf+Fhkfki860R7w6o27/wQvLTOhQ3C5whDgVWM9IL5bSbQco
 O4zIoCDrhzz2CwyYcPokUyeG91xXYpTVpYUyDLJOiLBtF63Ev6n1KKpfX5C76w9au/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789129566;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=NOGVmRn8UJOWtbR3HhtkP1tSe3UWDm4yp6BwldR32hI=;
 b=rYhyVnAkzSYhFsw1Lhe1NM3KWp1X5VSpeMrjx7v8Z1FPdtrOBMllAlkhxFKsfCNH4qTX
 n4M/dsKcI44d1K+wqV0AT/lanmV+d8tYzngH4sxOiVMaJcathS0S07fbbMvq+/WYCgJNi
 Bmg8k8sscuIgQ6d+9ozHLS7NAnRQHdzKtugL09D9ThvfSAPWX+iUQDl3p3wvaisNcfUH0
 6cQgI8ddkXVa0bnkyisKSx2bOLNMMcN6Vnh1Jgj84u1s8SN7/snH0tZlvt+l2qOkeLGab
 GUOgkFxmBmMeEKoPhEHfZpIFBIOaiiYtFtMBgpCA6j4WqfQvRiObmj61kPKnbgFNjfA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qilo61Yd; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qilo61Yd
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1362D40469
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:26:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B0F4A409F8;
 Fri, 11 Sep 2026 12:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86AB1F000FF;
 Fri, 11 Sep 2026 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789129564;
 bh=NOGVmRn8UJOWtbR3HhtkP1tSe3UWDm4yp6BwldR32hI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Qilo61YdmlkWwJPGLR/dRn96tzekOjYv3Fadlp3xHRn5FHWybvx6t6hlMrB0bvdXA
 3xTX7h7LZkjsJFqZ0QCMXKclj+6Y6IhINsi14lykVezT8W/g37uIwwJj9D4VoW5cH3
 jSo2fCGlGG2zruB6F4I+gXLZL/GwNee6R1ixqxqRxT7vnSIQgrGrpxeXNRRLMgi6T3
 yPJMyGMrtvsldNZTnou2wtY/n7/Z3QuZEO0WjYZAHEP2+ytNcZG4wemE7s0NJY5FQY
 aJCjailx7AgLwlmZ3utAMeMJESTxZ/raWLC9dHapfmJYk/w786AloIDPjMMEQI3Km7
 mR7itZpTRpVNg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: David Lechner <dlechner@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Suhrid Subramaniam
 <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZug==?=
 =?utf-8?B?5paMKQ==?=
 <Macpaul.Lin@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, Vitor Sato
 Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Julien Masson <jmasson@baylibre.com>, Alexey
 Charkov <alchark@gmail.com>, Adrian Freihofer
 <adrian.freihofer@siemens.com>, Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Vincent Jardin <vjardin@free.fr>, Peter
 Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v5 5/5] fastboot: add SPL support
In-Reply-To: <a9bceb63-2f10-4571-9c23-14e472c41fb8@baylibre.com>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
 <20260906-ccaione-upstream-spl-fastboot-v5-5-023516e77321@baylibre.com>
 <7b98b6c4-078e-48f1-98d1-1b65fc19b611@baylibre.com>
 <aqHOCHRyUGfhJcXf@macbook>
 <a9bceb63-2f10-4571-9c23-14e472c41fb8@baylibre.com>
Date: Fri, 11 Sep 2026 14:26:02 +0200
Message-ID: <xhkdbik4c3rfp.fsf@mkorpers-koolstof.csb>
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

On Wed, Sep 09, 2026 at 16:57, David Lechner <dlechner@baylibre.com> wrote:

> On 9/9/26 4:23 PM, Carlo Caione wrote:
>> On Wed, Sep 09, 2026 at 16:16:16 +0100, David Lechner wrote:
>>> On 9/6/26 3:02 PM, Carlo Caione wrote:
>>>> Some recovery and initial-provisioning flows run before usable firmware
>>>> is available in persistent storage. In these flows the SoC ROM loads a
>>>> small first stage, but that stage must still provide a standard protocol
>>>> with which the host can provision the device.
>>>>
>>>
>>> ...
>>>
>>>> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
>>>> index 111516fd1b3..a2a89fc04f8 100644
>>>> --- a/drivers/fastboot/fb_command.c
>>>> +++ b/drivers/fastboot/fb_command.c
>>>> @@ -48,10 +48,59 @@ static void oem_board(char *, char *);
>>>>  static void run_ucmd(char *, char *);
>>>>  static void run_acmd(char *, char *);
>>>>  
>>>> -static const struct {
>>>> +struct fastboot_command {
>>>>  	const char *command;
>>>>  	void (*dispatch)(char *cmd_parameter, char *response);
>>>> -} commands[FASTBOOT_COMMAND_COUNT] = {
>>>> +};
>>>> +
>>>> +#ifdef CONFIG_XPL_BUILD
>>>> +static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
>>>> +	[FASTBOOT_COMMAND_GETVAR] = {
>>>> +		.command = "getvar",
>>>> +		.dispatch = getvar
>>>> +	},
>>>> +	[FASTBOOT_COMMAND_DOWNLOAD] = {
>>>> +		.command = "download",
>>>> +		.dispatch = download
>>>> +	},
>>>> +	[FASTBOOT_COMMAND_FLASH] =  {
>>>> +		.command = "flash",
>>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (flash), (NULL))
>>>> +	},
>>>> +	[FASTBOOT_COMMAND_ERASE] =  {
>>>> +		.command = "erase",
>>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (erase), (NULL))
>>>> +	},
>>>> +	[FASTBOOT_COMMAND_CONTINUE] =  {
>>>> +		.command = "continue",
>>>> +		.dispatch = okay
>>>> +	},
>>>> +	[FASTBOOT_COMMAND_REBOOT] =  {
>>>> +		.command = "reboot",
>>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT, (okay), (NULL))
>>>> +	},
>>>> +	[FASTBOOT_COMMAND_REBOOT_BOOTLOADER] =  {
>>>> +		.command = "reboot-bootloader",
>>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
>>>> +					     (reboot_bootloader), (NULL))
>>>> +	},
>>>> +	[FASTBOOT_COMMAND_REBOOT_FASTBOOTD] =  {
>>>> +		.command = "reboot-fastboot",
>>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
>>>> +					     (reboot_fastbootd), (NULL))
>>>> +	},
>>>> +	[FASTBOOT_COMMAND_REBOOT_RECOVERY] =  {
>>>> +		.command = "reboot-recovery",
>>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
>>>> +					     (reboot_recovery), (NULL))
>>>> +	},
>>>> +	[FASTBOOT_COMMAND_SET_ACTIVE] =  {
>>>> +		.command = "set_active",
>>>> +		.dispatch = okay
>>>> +	},
>>>> +};
>>>
>>> Do we really need to make a complete second table or can we just #ifndef
>>> the indivdual commands in the existing table?
>> 
>> That was actually suggested by Mattijs here
>> https://lore.kernel.org/all/877blphqmg.fsf@kernel.org/
>
> ok

Yeah, this thing is more of a personal preference. In my opinion it's a
bit more readable this way, so thank you for splitting it.
