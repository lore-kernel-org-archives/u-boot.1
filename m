Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B167C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 14:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F300878DD;
	Tue,  2 Jan 2024 15:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mbEfUVmp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E460E876BF; Tue,  2 Jan 2024 15:06:47 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FB3887823
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 15:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bbbc6bcc78so4894394b6e.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 06:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704204404; x=1704809204; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HW4HBzqhZNwTwCuDRK9mnwtAwVBsJkZI/a9yd0gvsFs=;
 b=mbEfUVmp45oilKb8zrysW/Z6lwYNXzIjaYuyph25Un5AOxqT+Wz5RL2WKFmAVIs1Q1
 kE/xILzYApG10g/U0uYRgonUXdm1ue8Pn+Oqs87bYhwxqlCbWORiVwZuDo+DA3TiJVs0
 fr12I/XR9TxJNUi/qoeE/s1ClljVSAAQ0Hmco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704204404; x=1704809204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HW4HBzqhZNwTwCuDRK9mnwtAwVBsJkZI/a9yd0gvsFs=;
 b=D/pUOrzV25oLGvF5ZXl1xFRRmArqjUnUcwtOOmx138Gr1GV80dmy5iqknbHusCRUdw
 oWv0Er1tU6WK1Fxd6tm8auIp9K8NriAQud/yWPjbiP5+Sm3xBCi32gjSMSCJ4ITgE0BF
 8eu5EPe5qW4VyIao9fuoW8nBAc3JPB76aEamxM25IZzqjAqKLZ+KQUgBeqtMf/9oz4PO
 7/V7xlCXgjOXUCskSryiuYFHMJJ2RVMVm6xJQkpiljKenw9jfv+QfJ24OAUtyXUvnbSL
 p4YXiSLVznW+c9z8PBDfXPKD0uWgzhhyrtS7RvqQq3r4D3Jza4GUgIDZLQkyGFo3uEF4
 UM+g==
X-Gm-Message-State: AOJu0Yxtb4Yf4Cx/t3iPMvsKtJIL4FDQcnhs2j74kriNzwrSc4Nbatr9
 oRMTnV90AcmDA3JHo7KIFMFEFhQuuoST4OHEf4AW61+rJyCw
X-Google-Smtp-Source: AGHT+IE1Z+ywFouMlJ6+izjN9U7Ucgl/G66eI21/VqYSwAYbRX2k/i2sr/uJmNXaQOHKajNfb56LWBqHa9poi53bXmo=
X-Received: by 2002:a05:6808:3189:b0:3bc:19ea:4019 with SMTP id
 cd9-20020a056808318900b003bc19ea4019mr892805oib.75.1704204404030; Tue, 02 Jan
 2024 06:06:44 -0800 (PST)
MIME-Version: 1.0
References: <CAK9R8u_QmcHLv6KbNm8+8EDvnmgehFZfoPNVCVn8n5P17ArErw@mail.gmail.com>
 <CAPnjgZ2JUCWjr35yL6pb2XSEs7659A1Sjh4CgQ6B=vXCLhRvtA@mail.gmail.com>
 <CAK9R8u_MQtmYcPwiYwXmqse+1yfPaE1ZEHZVtrgHAP-KgPAT+g@mail.gmail.com>
In-Reply-To: <CAK9R8u_MQtmYcPwiYwXmqse+1yfPaE1ZEHZVtrgHAP-KgPAT+g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jan 2024 07:06:33 -0700
Message-ID: <CAFLszTgNit2-K4BJ31UZs_xS9HUanCMm2Gr14xxAUkmo90tEuQ@mail.gmail.com>
Subject: Re: Setting up boot chain ACPI on ARM with STM32MPU
To: Ba Gia Bao Phan <phanbagiabao2001@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 andy.shevchenko@gmail.com, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ba,

On Mon, Dec 4, 2023 at 2:47=E2=80=AFAM Ba Gia Bao Phan
<phanbagiabao2001@gmail.com> wrote:
>>
>> Sort-of...the refactoring to allow ACPI tables on ARM is completed,
>> but I don't think any U-Boot board uses this.
>
> Hello, could you tell me more details about this topic? Which platform AR=
M are ACPI tables enabled for?

There are some patches to enable it for qemu on ARM here:

http://patchwork.ozlabs.org/project/uboot/list/?series=3D388154

Regards,
Simon


>
> Le mer. 29 nov. 2023 =C3=A0 20:28, Simon Glass <sjg@chromium.org> a =C3=
=A9crit :
>>
>> +Heinrich Schuchardt
>>
>> Hi,
>>
>> On Wed, 29 Nov 2023 at 08:29, Ba Gia Bao Phan
>> <phanbagiabao2001@gmail.com> wrote:
>> >
>> > Hello everyone,
>> >
>> > I am a trainee at STMicroelectronics France. I am working on a project=
 "Setting up a boot chain ACPI" for STM32MPU, which is based on ARM Cortex-=
A . The objective of my project is to add a way of booting (with ACPI) besi=
des Device Tree available on STM32MPU.
>> >
>> > I found that ACPI was enabled on some x86 platforms but I don't know w=
hether it was set up on ARM or not. I found a PATCH that discussed Enabling=
 ACPI booting on ARM with Raspberry Pi 4 but I don't know if it functioned =
or not. Did anyone here succeed in setting up ACPI on ARM by U-boot?
>>
>> Sort-of...the refactoring to allow ACPI tables on ARM is completed,
>> but I don't think any U-Boot board uses this.
>>
>> >
>> > What are the differences between x86 and ARM platforms when enabling A=
CPI? The architecture of my board STM32PMU is ARM so can I apply the techni=
que used on platform x86 for my board?
>>
>> Firstly I wonder why you want ACPI?
>>
>> Secondly, if you have the tables somewhere it should be easy enough to
>> build them, building on the series you pointed to. Heinrich is
>> interested in this, I think. I can help with advice. I have been
>> toying with going back to that rpi series but have not done so yet.
>>
>> Regards,
>> Simon
>
>
>
> --
> PHAN Ba Gia Bao
> Etudiant en 5A STI - INSA Centre Val de Loire
