Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888B6C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 21:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2890080C67;
	Wed,  9 Sep 2026 21:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XUBmFy61EA3o; Wed,  9 Sep 2026 21:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1E466807B3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788991067;
	b=SxALBla4XMsBkVZCOG9mC7Gd3apylvIknbpsBGCv9MhirPTMNLW7f4M84bschfqNwBkr
	 RR/OvUWL3W90pCXc10G2UXnpD0xOD9sDCMSU+eMptRNL0EE1LsDR6KL+794xJR/+GWY8T
	 FkAQRsIItbKf/VtqoIjjANFkydZO7uZtvIqAKciF+DBqIjlpGJtzIyxAC6KcZ+0mAFkXd
	 pWo3f3trmF1Dc/v5IcTnRipM60/SKofHTBB9wWhEi5ZxHwIIONa+wQGJNU5cn3lKQbV1H
	 DBm+rvYr2apWm+KhWMSGkvdAArgdDxbou3WomjqnuYmOg95UIkQprnycdoYjrHHi7xQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788991067;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oFQxX/WMhpn3o7sFeXhfgN5WUWphTnHAb2xNEdrJM6I=;
	b=jWu5zOY8CyFM73oA8hlegrFK0+0NTjccMD7/AVRW6Er2huNQU9hb0UJrnp2xlvaLg122
	 wTtxaLYDIdy9O1JC3wyQwQ3ezIXoaOwJCcMtQomkLKncUdLtWc5FCSZDvYifntIHFpfYk
	 pqTvJDlG6pkSeW44utpaSnU+7SYZFO1hSibGrO4YGa4faPF7Cz9N3XsxREmaBmcTy6+/h
	 dfGoKJeMBa6vvAq5iXJ1XbxlgWx5pSjx9RDpKm5dRoLpF7Ocq3wjWlraafNxA7tLBE8kJ
	 dARvYK4Qzs/LyyUWFp6vb6D2ASe7slOLKS/eyxvAVVovGG/273Cg1iqxYiBkUYywsvw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788991067;
	bh=oFQxX/WMhpn3o7sFeXhfgN5WUWphTnHAb2xNEdrJM6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xDpcnJov1Iga9PkiB9K30Ttt9xf6kGGGtYx1bG3YVv9O2juaEkVYtfWpHyb/QaujH
	 d2KMUP/LsHzAousMAJqGJFXRcCX7fG1iOyy57FG1tgECOBKnb4q8XaaJOEk5CZKt9o
	 rMjjh4K5ohMcVKgSEK1XkdgSB8UzsjFTzTI3eDcTgefzKvpYLbaEkqHTGewe2+yUKe
	 p6qCTbeK7vmyrV1oPs2fVcCQ+VvxfgReY20lZluRxG9HjoqspKgzyVjJDGRX/q49Md
	 wIqiXOLXuSNPiSUgo3TrXVBitFKvWRpLecY/nOKjW9O5DPGNDzWaEQKi1DW/02n7wi
	 psRQyrcqHgUHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E466807B3;
	Wed,  9 Sep 2026 21:57:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F9B9E11
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91AD64026D
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yWSVMvYtMXM9 for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 21:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A3736400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788991064;
 b=SkdulTG1doTlF0TEwSSqOf4JM7IuMP5PfhZVeCKl9vEPeMGYlby8JRxKHEd7E1XVq+0a
 HI3co6UF1Sd/W0mR9uh+BKGcY/cC8VrwzAAdpmlN47OoreHFNlPncBzTwhBRd1Fx2ytcu
 B+vKlGR8RG+f8Y7Ji2wd+kbOTADUMZ19zk5N2Ha2AVA0kKU9CPGZrC+0+f0m9HwixRKZq
 5sFMNMYXCE0GVPDUIcWPlyngxAvxU+IYM1r7SQENvoEUe0OLSFQZQLm43BpPbV1m4TJED
 moTADQueQ/ci0JNvOACL5wwALdRLGdDR6Nw1vSKV2FE9Z2zXq0f1ub9Ex4tl/B0Ge4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788991064;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=oFQxX/WMhpn3o7sFeXhfgN5WUWphTnHAb2xNEdrJM6I=;
 b=riMwwSk4YQUmtN6Ss6SPOfbzKIT8iRUggvmTYlI8JJXhm1mgR8cR+GshIEZOrerrlx4L
 pZWdwbuEEw4iHTHJh7Y9vWPIX0JajRDYNR/apg9LpjLVdom1tKKxt/wYv+F0t51XdTFdX
 Mq4FuPfJlKYO5SMtR6j7EquriT+TtImfxt2jtuh01LbdDIWoshxfZ2LkTWXEN3JM5xw3n
 iTknCGoMfCkz8V5QorNDDxNQ+yhjCut0ZZqSU/L+lol58SftbE2bEr6FkndrZMaptIteB
 zC+GvhygKGr9clq8QllfJ/ji254dmQhvlPgAbY2dF3+OSmY+/sIXVJ4OxVVIytTUxCg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VyOTW8EH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VyOTW8EH
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3736400CB
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:57:41 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4b333de9451so5618189b6e.3
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788991060; x=1789595860;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oFQxX/WMhpn3o7sFeXhfgN5WUWphTnHAb2xNEdrJM6I=;
 b=VyOTW8EHmGbLxdKpZ4nehbaz7kB67Ng9Yx4hdCsjmXt9gJI/1x/wNq/TIXQPGEzXR+
 s0XnVXIkbOu9S1yYWSUx/yK3ADXUxILprL5FlJbF/Ya/FWjwFuSr0DCdwu7oF2Qt1yiC
 aIIZ3Gd6s3xYEdxhNNdkP3im2PIuzh/KhH/xE9kmrL/Ry1bd3TWeRA65x2ZGzi9K/LFT
 IYO1JWRHK4+fGZiKHqLehJo30RM36L4+ghLA20PpH6AfddiiaUsDg1fZjKkK1kLBSLNY
 /SAhjTa71IvBa+MAfie/UV+n/6/VP2D+AJpMSniksTwwZeztwe7Y2gSl7rCjzEQorMxp
 aWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788991060; x=1789595860;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oFQxX/WMhpn3o7sFeXhfgN5WUWphTnHAb2xNEdrJM6I=;
 b=ZGaGAAbOYAZAJXGbfvuL5J3wGypMP4DR368cEOuumrPfy+UMXtD+NrufOJ+ODuDL56
 0/QJUS03b+Ad+0TlcFcLBpUD4qZf9aSkndxiOWO0VFKeC4j55M+zgbPL++cxeZaUSpP2
 5K77xiQt5r85x/Y62NpmxkoyOYy2rm+Ne3AgXHEdtyKGfezvVRZ8mTCKQAZKb5LuHway
 sb0Km8lw7PvyxX4kF9BD/dC7p/TIOF+LkP77AHVqgqISxbgzgZFB7MisdI3leRsTMXGm
 Uv+rDtfmgyticIFW9V/Y9tlBRFcgbHLv7Js7StScouYHBG3gQzsAnEWw0uUNf7qGGKAj
 F9Yg==
X-Gm-Message-State: AFuF++mwnMomuznb963IIR71bRoy65Osb2a2XrOMgN/WyB+KftI0xDKR
 U7mEtpXiJVLhhSegvOcz6vmd39Xq7narfeSPsseAPZXKYWS4OaggQ+74MeFZR4E1EU4=
X-Gm-Gg: AYBFou1Tuk3x4DqBcdt0NP64srtKUYpZZ82GiCnD4VIQvgFLr5HmWOAuYhvzHVsHJSn
 E0gSi3kUvoPPDI4G1dQr0fe09cALMab+3D07D+80CViCduRQ+0/WAsxWbH4pAVPKZLk1NHHB/Gr
 0NdMSq0qT8iTQLC9Z+4HDoTjWcLi99nA7LATaQLg0c5faOE/N9y7R/IdC+4/4nUGYZUodjMGYTm
 VqPWnXRTI67f2qmpb5OgyXhgZNh7GYB+HE02SKlpsCfDsbt9f5PG0Tz1w3FleIvEloiOdXiMnKt
 UICB6B2UXBq1GWEDD15LeoLzngkFkpfWbKl6bfruW/mnVtY7q/JLzGXZwzcyPk7Q9Rw8xYQtYwk
 +iE8v8Rg/UuAuNZZrmgnHh0G6R1AD60hadoPE3l/XiN7Af3COosIBeenM6DVyqcxasfEl35/XiX
 P32rO0hhShFi1eDcUnpXGWjqwJZ/T0uj9hEqVz9Z1WCAJwk32jAP1i/FJzFWLxqtDP19bbUfVnl
 3Vn/DdEWFBi2+yG1SQ91KsMUhUi5lE5Pj4WWsw4fwUcvGg=
X-Received: by 2002:a05:6808:3098:b0:4b3:74fe:2f77 with SMTP id
 5614622812f47-4b961a7cde9mr26872215b6e.11.1788991060291; 
 Wed, 09 Sep 2026 14:57:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a8c5:6332:5ea:5b26?
 ([2600:8803:e7e4:500:a8c5:6332:5ea:5b26])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47947f96dd2sm9327916fac.14.2026.09.09.14.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 14:57:38 -0700 (PDT)
Message-ID: <a9bceb63-2f10-4571-9c23-14e472c41fb8@baylibre.com>
Date: Wed, 9 Sep 2026 16:57:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] fastboot: add SPL support
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
 <20260906-ccaione-upstream-spl-fastboot-v5-5-023516e77321@baylibre.com>
 <7b98b6c4-078e-48f1-98d1-1b65fc19b611@baylibre.com>
 <aqHOCHRyUGfhJcXf@macbook>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aqHOCHRyUGfhJcXf@macbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/9/26 4:23 PM, Carlo Caione wrote:
> On Wed, Sep 09, 2026 at 16:16:16 +0100, David Lechner wrote:
>> On 9/6/26 3:02 PM, Carlo Caione wrote:
>>> Some recovery and initial-provisioning flows run before usable firmware
>>> is available in persistent storage. In these flows the SoC ROM loads a
>>> small first stage, but that stage must still provide a standard protocol
>>> with which the host can provision the device.
>>>
>>
>> ...
>>
>>> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
>>> index 111516fd1b3..a2a89fc04f8 100644
>>> --- a/drivers/fastboot/fb_command.c
>>> +++ b/drivers/fastboot/fb_command.c
>>> @@ -48,10 +48,59 @@ static void oem_board(char *, char *);
>>>  static void run_ucmd(char *, char *);
>>>  static void run_acmd(char *, char *);
>>>  
>>> -static const struct {
>>> +struct fastboot_command {
>>>  	const char *command;
>>>  	void (*dispatch)(char *cmd_parameter, char *response);
>>> -} commands[FASTBOOT_COMMAND_COUNT] = {
>>> +};
>>> +
>>> +#ifdef CONFIG_XPL_BUILD
>>> +static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
>>> +	[FASTBOOT_COMMAND_GETVAR] = {
>>> +		.command = "getvar",
>>> +		.dispatch = getvar
>>> +	},
>>> +	[FASTBOOT_COMMAND_DOWNLOAD] = {
>>> +		.command = "download",
>>> +		.dispatch = download
>>> +	},
>>> +	[FASTBOOT_COMMAND_FLASH] =  {
>>> +		.command = "flash",
>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (flash), (NULL))
>>> +	},
>>> +	[FASTBOOT_COMMAND_ERASE] =  {
>>> +		.command = "erase",
>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (erase), (NULL))
>>> +	},
>>> +	[FASTBOOT_COMMAND_CONTINUE] =  {
>>> +		.command = "continue",
>>> +		.dispatch = okay
>>> +	},
>>> +	[FASTBOOT_COMMAND_REBOOT] =  {
>>> +		.command = "reboot",
>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT, (okay), (NULL))
>>> +	},
>>> +	[FASTBOOT_COMMAND_REBOOT_BOOTLOADER] =  {
>>> +		.command = "reboot-bootloader",
>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
>>> +					     (reboot_bootloader), (NULL))
>>> +	},
>>> +	[FASTBOOT_COMMAND_REBOOT_FASTBOOTD] =  {
>>> +		.command = "reboot-fastboot",
>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
>>> +					     (reboot_fastbootd), (NULL))
>>> +	},
>>> +	[FASTBOOT_COMMAND_REBOOT_RECOVERY] =  {
>>> +		.command = "reboot-recovery",
>>> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
>>> +					     (reboot_recovery), (NULL))
>>> +	},
>>> +	[FASTBOOT_COMMAND_SET_ACTIVE] =  {
>>> +		.command = "set_active",
>>> +		.dispatch = okay
>>> +	},
>>> +};
>>
>> Do we really need to make a complete second table or can we just #ifndef
>> the indivdual commands in the existing table?
> 
> That was actually suggested by Mattijs here
> https://lore.kernel.org/all/877blphqmg.fsf@kernel.org/

ok
