Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA6606A685
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jPLAX3NB;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cpZ0AgVm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1962F60784;
	Mon, 23 Nov 2026 13:37:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MtVF6shB0-Ke; Mon, 23 Nov 2026 13:37:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D2E96072F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795441074;
	b=lhK62VP3tMxnYJ82t6e5dRYSl/D5yp17OSbWxj+72icbHQSaaO+shRYuBduvJTbUqtYk
	 yOV5kTkh8MS6x26fiMV1xKVpvoUA+JuORR756YQxXwNAUL1u1sc2KYRwG1wLEpZflTFvs
	 Tg3jbTRjUbYXQ1PZaj71NHatPVyOElOK1Ax81igZNL6lsoHoauXYRPq7IB9nXsJxotGMW
	 SlkazEFfrKX/FzL7kXcFnv4Ww6GrTGM+v5GMk/aiwSL29bw6IlEUWI4fkU1QbCtgUGls6
	 o77Ty0edX1Wg8eu/hdpqdNjuRNTwzpAZ5lCZvlVVFl8b+m/V0Td0G7sBwrAbGqxGXjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795441074;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YcxoAhCCg+LZOQkSWkzs1Jflr5XV6wZokeZ2vNPD/88=;
	b=GXK+d+/4388JISsY5mvAWCR4ack9bTGU35BaXXxrpQLyiEQy6rEN2Z9AuUskJDZASdJA
	 GnUznbeAs8s5mQ8rs/iFc5MXb+j00qnueGtRd8RM+h4bBPfEJmaAtCDOLVqIdYuEUR7ou
	 SIX4sM0cJCF4k2mWj5TA3iD+MFFtYEtyiZPamaSNoMTrJeg+kwpl7rtlMULS9SmucObNL
	 X1xHinqfJVttbNRJmFT0mAU3Fmn3SAAbJ30JS3sXo7nATsCatz4Tvd+fds/AUbcGzwV85
	 vzMzqMBhZI3EhxzswsdkiPmNyYNiD6Q0bjLqQELCiN6Q2ZvSvOTGrVTsu02bbCjmTVw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795441074;
	bh=YcxoAhCCg+LZOQkSWkzs1Jflr5XV6wZokeZ2vNPD/88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jPLAX3NBoSsuSDmDyQ6MZUboLkEctIOP7PZzxUxs6QBKaKuYfCpm2JUsrKnuhRG0Z
	 52FACeXPSe7vnbbCYbLQWTXsQ0LBOrv6TS065rFmz8g0/2kwKcxGNiCDxH3ue3gYyf
	 lZpZeCyLnCqHpmhL5K8pblZ/6p2FrP100x/1cvurEWMVdtBVn5PtOWBjJUQ446a40U
	 4DeIVZdT8/xB+iZypW6fQAYdM+SnDK/P2eoiF02yndN7BAXRqJD6KDC11GDJCZDlUI
	 EofkAtdKcKk+LYps/Ex2nmkSNYxknJT+RZsEWwE15jos04/WCLrXFQ6oNOprOnYkOG
	 jChr/+rtW71mQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D2E96072F;
	Mon, 23 Nov 2026 13:37:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C9B61AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E3D440259
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:37:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ZCa_TSFYbsa for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 13:37:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8E3F0400BD
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cpZ0AgVm
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E3F0400BD
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:37:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06118841F2; Mon, 23 Nov 2026 14:37:47 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C73B83108
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 14:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so20946785e9.0
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 05:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795441059; x=1796045859; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YcxoAhCCg+LZOQkSWkzs1Jflr5XV6wZokeZ2vNPD/88=;
 b=cpZ0AgVmjDZf3FNa2NnS2c01Xrj5/14g1f1kkpCGYX/PLaPC65VqcLtl1xgpRxGRBT
 OKO+2y3pnHsRXtATRmqvFs0XXsknFqfr+bYNNQ3ZcvZaq3/g7BFgOOa5aXlN9BukNtgK
 x5D0TrI8gWv11jY07uJcupAw/1z5VRFovsmULCMWJt9Rp05acaqpteovtorq5NheBPoN
 +eua6EQei8r9cBMbQuPqQ7SEmANLePrxuvJ9P7/jOZ2ePsEXVCBd0ioQ5BSdXe5f0So8
 sM1WLu2QhcTfIJF7xXM8oKjgpsfgNTNl8hdDy8GfvC7pJrompdPKcQzSZpZNBOC7Q9Mw
 XYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795441059; x=1796045859;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YcxoAhCCg+LZOQkSWkzs1Jflr5XV6wZokeZ2vNPD/88=;
 b=ndRSCyktpj6xQxx0Agy7QiqYrhI4OT1of6kVJL3z8Pi3xnmaMVelFgxjr9YbdWyDHx
 W9vu6afOqsCU9pM1pR8JLFGwKXlU8dfx+87/ZvxNlNEEnsuCFRMjT82wZhtXhmvUv0vD
 A6CLMvEUcJ20t8c1oTR1wXgHoqi91ZmOeeaLb1chinn0qvaslZlC8EKJ2XqAdz/Z+Tls
 mcrjlcqSGGYG+9GSKG7DzCQ+aCvw5/iucdIknggYmu8OwuJxPvmGFllMrLLTcpLWhLPa
 q8dapPcJDHGjUvBV0xyy9q/wdtVjxDo7ojvsAm8gvs0CvtLwDnknAEXXdA2m7EWKkhyg
 cqbg==
X-Forwarded-Encrypted: i=1;
 AL+hErGUjYDLRzaEx1opdg/McSLxda9iJSEtRR+GPy3RTQc2GMgP4UPErh0gg0FXQ5Ky7xEk5I101AI=@lists.denx.de
X-Gm-Message-State: APuU4Z8WuLU/g7MHNO8GPWfZOGAxp8Xs3A6/s/2ZTlCRhkIGZ1T4UFK3
 GLXf3z4X+uFYaLOJUMui4/DLLFPN57nAH3nkVV5pbtqG5lU2QQK8teXcxF/1ZCMITmY=
X-Gm-Gg: AZFdTZcZdwgKIjEZgiTKfUfKHe3QEYjxXVPe0uy+AQemDGoGtc7/723oAdoN3nyfu1d
 S8JTCbqaj3T/v1H4cvkk8qnTpfHGlmDuOvaXND+5XDaKN2xRhpIgu3SMZc9SlWIXFPp/LU9Puah
 a3eYo7BLOYSSL1tiHRJa3zcX9sYqwEnz89PDXBRZnymWuel5aTDsvjz0sQTbjnRicR5BROyt4tb
 L1Un6Q9VTMx4US8aKQ0ty58A8UymDeiUjBBafjMY7+OjiJIqJvn2z10c7wUHLFleDp0MpQWFfCc
 TMEMz9AyEhvhMVC7ZzhXMIkw41nr67VGqfeZf4mpTZBPYRrlUwDHi3Z9miQaPWshfROlDDWjzzt
 gaLb0ekKaC0xDi2MhlLTsW3MmP18Zq23gW8lRXgzDkuihnzRQP0F8ZIgdBy761zXcw7QbEfUX0v
 01AYnHFir5VxMSAyJAWwhlwGu1sirrihKwVz2nUQc1G/ocUw6x+0J1+BHCwwZB3cM+lJMy7rluf
 QR8uVM8TTwolnRydUD5gjgrc5OidwkSyIZB9qrXZpG0hJBi+PkJe/cYgUUGnhcKHfuf2od3/fjv
 pCWKLahP/PHClIHZwsSbahE9LgnhfegBIsItT8ahcYE6G68XA8xVgxCkuxOd95abJSP5UuXXDRE
 XgZEmqH0CVpW7AnNkpHGpdi911R85
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb8881099cmr228034735e9.12.1795441058612; 
 Mon, 23 Nov 2026 05:37:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860::642d:5bda?
 ([2a01:e0a:e50:3860::642d:5bda]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm359373505e9.2.2026.11.23.05.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:37:38 -0800 (PST)
Message-ID: <53169c72-64e0-4ffe-ad62-a5d7f988bc68@baylibre.com>
Date: Mon, 23 Nov 2026 14:37:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] fastboot: Add
 board_fastboot_flash/erase/get_part_info hooks
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Peter Geis <pgwipeout@gmail.com>,
 u-boot@lists.denx.de
References: <20260930075527.92697-1-clamor95@gmail.com>
 <20260930075527.92697-2-clamor95@gmail.com>
 <xhkdbfqy567t3.fsf@mkorpers-koolstof.csb>
 <xhkdbcxt65btd.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3HUqT+TqyRrkyc83r-sDXMcMEXpqPPYxhinvp1rs8pDQ@mail.gmail.com>
 <xhkdbse0ypi3o.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3NSBJo+n7=Km5+GmyuQ7QQ=FhKydXP=dqBnJC7w4K=4w@mail.gmail.com>
 <CAPVz0n0e1r42peR3nv9ma-nFmhsiXB+cZCa6EdN35MA_U8K-SA@mail.gmail.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <CAPVz0n0e1r42peR3nv9ma-nFmhsiXB+cZCa6EdN35MA_U8K-SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Le 18/11/2026 à 11:45, Svyatoslav Ryhel a écrit :
> ср, 18 лист. 2026 р. о 12:44 Svyatoslav Ryhel <clamor95@gmail.com> пише:
>>>> You are mixing up. This patch does not add any vendor commands. It
>>>> allows using native commands with vendor quirks seamlessly.
>>> I know it's not exactly the same thing. I'm just worried these extra
>>> hooks will make stuff less maintainable in the long run.
>>>
>>>> For example. Tegra devices require bootloader and bct to be encrypted
>>>> and bct to be updated every time bootloader is flashed.
>>>>
>>>> $ fastboot stage bootloader.img
>>>> $ fastboot oem board:write_bootloader
>>>>
>>>> Used has to stage bootloader, then write is with some custom vendor
>>>> bootloader flashing command which we have to make, document etc etc.
>>>>
>>>> This series allows intercept native fastboot commands of flashing some
>>>> partitions and apply vendor specific adjustments directly. So I can
>>>> flash bootloader, boot and system with native command `fastboot flash`
>>>> but bootloader flashing will be performed with encryption and does not
>>>> require from user any additional movements.
>>> I understand, that it might be easier from a user experience point of
>>> view (just fastboot flash <whatever partition>)
>>>
>>> But adding extra vendor hooks also means having a specification of what vendors
>>> should do in these hooks: adding docstrings, adding documentation in the
>>> fastboot.rst page and such.
>>>
>>> I'm not NACKING this series, I just wish to discuss in more detail why
>>> 'oem board' is a wrong idea.
>>>
>>> For example, do you have a closed-source userspace that forces you to
>>> use 'fastboot flash' on tegra devices?
>>>
>> On production tegra20 and tegra30 devices bootloader must be encrypted
>> with aes engine before flashing, and bct must be decrypted, updated
>> and re-encrypted before flashing. We decided to use hardware boot
>> partitions to store bct and bootloader, so we do not have traditional
>> boot partition. Hence we are using fastboot flash to intercept
> boot > bootloader (typo)
>
>> "bootloader" or "ebt" and "bct" commands to flash partition and use
>> our own implementations for them (for emmc and spi). All other
>> partitions can be flashed by default and need no special handling.

   I'm rather ok with the patch and with intercepting the native flash
   command through hooks, it's already done this way elsewhere in fastboot
   (fb_nand.c, fb_spi_flash.c).

   Some small comments for v2:

   - board_fastboot_flash() returns 0 when not handled and
     board_fastboot_get_part_info() returns 1, it would be nice to have
     the same value for both .

   - When you rebase: flash() now starts with flashing_refuse_if_locked(),
     please call the board hook after it, otherwise a locked device can
     still be flashed.

   - A small update of the fastboot doc would be nice too.


Regards
Guillaume

