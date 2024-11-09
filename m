Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4CED64099
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 02:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BCB888FB5;
	Sat,  9 Nov 2024 03:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JapSPqxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAFD988E14; Sat,  9 Nov 2024 03:16:13 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D0288FB5
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 03:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb3c3d5513so23543021fa.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 18:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731118571; x=1731723371; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=os864Ti8QyTNLFwySwVE2B9V1tUk9Qy1xoDlha8F8eM=;
 b=JapSPqxHQfZfcKJBFvezMhOMeHCcLzG6tQS/BRCy4DcXi0f8qDTn9ZQfxTjEJV1F18
 wJ5CZjP8LMxmum0KdXBjCJH0qqjaknezKCzrumaR5sstmR4aoEFSlNlPUQsyG1TcYvV4
 3w1UepZMgt0DE7GA4aa9C0WCsG4dVz2HxtoFMSX0fAOlkWEKDTgi9FxjqvU2BPA4M/K/
 7hasE/v2Uutz5ROXKsGXIVi0qXAe7q4C+hO1CUa91BY8Y8CxnqyCLGC3hxBmXbjmVzid
 3nm45tvC1wEGCk6DtUIHcJB8ciCj+/e3kQdSPPtzMUyJFt98xUprUrJOx9USQAMz20/X
 1QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731118571; x=1731723371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=os864Ti8QyTNLFwySwVE2B9V1tUk9Qy1xoDlha8F8eM=;
 b=uxOxlcSP+/WSXxnx/7Aitu0vV2/t5RXI7SH/CrjpRfSKn5I8apMgZFRRU6IDYWj9HL
 aUFTxzCI3Nai4RVHIxQoJb6YMiZHa+fNP5WOWUlC8FZPwwpZf3CXCELwAgm18W5t2hVR
 5H3Z3W44LmVkRrK0iVxXxWJVmfxBXMUxxCD2FZHY2SaSUR2cvKp7ELKZc29O7i9ERIDp
 6fH3luWI0WATfN8cK62oZc2losVWfroMI0ryAJyQqbDi5bIAUu1ozKRXzC53USQmG1og
 HrQolwVCxQaLvqZb7ne5p1a88L3maVA115o8epQGoqxbEDiU8dE+dg7OdVRG+nF+XDQX
 yHJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs6PUyTpEDoqweZFuu9DPl0/cQ5txnWJ/SKE87VtGGu2pVAeuoWD0l5KY5CwnDv6MQ61Qpmlo=@lists.denx.de
X-Gm-Message-State: AOJu0YxLSPXG1/6C9aOivvG8Y2lWX52mYnCDfmFygkOVuhPGsUB+7oyx
 EFPkVNH4adLqgdN9Za2Rb+tQkLEwXYdkawzzBaCA0r8XLZwdhmBOcJ4LSI0n+ZlzlZw0RaVPxLR
 T9HGFPx5nGICgAEYPjAyp8C/DvFg=
X-Google-Smtp-Source: AGHT+IFxsgNl6hCYtWoQdeWmFpSg0EtuDZWAuEZbduqZc322oHG1N9ZeIZeiDwJ0qNniqWAFzzT8g8v+ZHkYYzOtJK4=
X-Received: by 2002:a2e:be0b:0:b0:2fe:f8e1:5127 with SMTP id
 38308e7fff4ca-2ff2013dd96mr24550231fa.9.1731118570711; Fri, 08 Nov 2024
 18:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
 <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
 <20240905155402.486a7110@wsk>
 <CAHCN7x+jLfzMGFUcbAfHr9u_2s3Z=LxN-TNCtbzUUop66p4Rpw@mail.gmail.com>
 <CAHCN7xK3-iUUGf20-JxAWfK05-te=sskbdpU4kU8ahy8sfROFg@mail.gmail.com>
 <20241104091418.74acd1f1@wsk>
 <CAHCN7xKGW2+_8P0nnMM6gyJVPQOw15S2pFUhwwuv13JVqY3qNA@mail.gmail.com>
 <CAHCN7x+K14RkvbDdCHPq+YaH7bXSBH-6Sdwnb1+TULCE-H5puw@mail.gmail.com>
In-Reply-To: <CAHCN7x+K14RkvbDdCHPq+YaH7bXSBH-6Sdwnb1+TULCE-H5puw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Nov 2024 23:15:59 -0300
Message-ID: <CAOMZO5CNfgBaEu+eiqq8vnOe5ro+a_fQpJigauV0vcPjdODHrw@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Adam Ford <aford173@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>
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

On Fri, Nov 8, 2024 at 11:12=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:

> I think I have a fix for the Nano.  I want to get my hands on a Mini
> again to test it.  My solution creates two files, a flash.bin for
> booting SD/eMMC and a second file which adds the FSPI header at 0x400
> with the whole standard image starting at 0x1000.  I have been able to
> boot both the SD and eMMC's with one config option which can allow me
> to remove the FSPI config file and consolidate both configs into one.
> Once I can verify it works on Mini, I'll post my proposed fix.

Thanks, Adam. Appreciate your effort!
