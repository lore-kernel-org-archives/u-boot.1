Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D49AD26D7F
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE4F8436C;
	Fri,  9 Jan 2026 19:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qkc6fkg5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2ACD84382; Fri,  9 Jan 2026 19:01:59 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 449E584206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 19:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so654821266b.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 10:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767981715; x=1768586515; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoK0UMbkPWBHfpMFByC3pNovdDEtqvP+4H2H0Z44f58=;
 b=Qkc6fkg5wXQ7lygiBD1ax266pfiSDS1J7p9aWsm9UgzO2KBBFkODj/tOZZOHYwA2ce
 S5/ACAdH8Gu7zKw4om+DbfIKhfbQeR7GQrv0KN+coER95rh/lGhqFF6J+V4HXqxKDXSJ
 Ert3sQkxTqRHfvtA9CRgUeIu0q9XFFvF4vpd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767981715; x=1768586515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aoK0UMbkPWBHfpMFByC3pNovdDEtqvP+4H2H0Z44f58=;
 b=mmCM63E2Zw+n9e9OgKnMxew/UNd3Qe0wqqASaTVHyrsWmudZbyEMBNaxG6BDx0bvND
 2U3DxWqfv+kvMJh761uFMFocCnw2LGdwOKR6gPLqtfoEwdvA1hDyx39WBG1FYy7nOQZb
 2G41ar64WnYATU3O47wSKYcWLl/29qaBGrcERNLV/suvO7ZGE1eaHjr0KA919cSFTttf
 hxxp1a2JzrIN7oE7TospQiN3PXHu3X+lOUhsLmce1gmiKxTu9YexwcLJsoL6k+5OoZSA
 MdU3aTom7HFqq3HUYnavq1d+9i13alHHPgcyQE9LoTPY7D93gPVSquCDdCf7IpMSKIKc
 XCEg==
X-Gm-Message-State: AOJu0Yxwd3vedh8zDOOhQEmlSMrgaz+BM0WDr4gJJKZp3RZaXJm9nq4M
 dDJ//ZRpuGMguKDFvCt/GKzwbA4Xup08jwurhEU45NU5GA7e6egDmZgrLz1vpu4oLQpFQ0cTnhQ
 //sB+Uu+2hnu0fLLybFYd83ZveRRGU93J2eejs9MR
X-Gm-Gg: AY/fxX4WUDL9mDC+PXpyuK9kztyvaFt7ooYXlZwnhMUMRVJ+0FSD012PWJhR8xcvagt
 bT1bARglhdDy6YmMxG6NsMKfksAHzLs0cD/KFCNWriK2GZTqoRIcNjvPsCC8zOaixGOaIUz0+pP
 mlPEwB0ZVl6OIWO8aAkhAoh3zEWPlIBY23a2iSLHzvphvPMJkT3gYP3gynFKoRoulsUUf6FKJWG
 baUmLjq+s2UEhuVUTw3KODID8C5R+8YcDucAglMG07uWL/FhPgdb+oZtomtFuCtapZptQ==
X-Google-Smtp-Source: AGHT+IGLVtOg1BOlHkahNa4/7WeIv1sWFiTHAl9sh+SrUL4fLRPZIvsM7cr4w2G94ClrH8P+lQtBAJ0G/VH/fwgvcfo=
X-Received: by 2002:a17:907:6ea4:b0:b84:41c0:950b with SMTP id
 a640c23a62f3a-b84453e8681mr995323766b.62.1767981710012; Fri, 09 Jan 2026
 10:01:50 -0800 (PST)
MIME-Version: 1.0
References: <CAJs94EbyBnv=q6Gxp0WAhTRakxKm9xXgnriCVXQiycSem5qpCQ@mail.gmail.com>
 <CAFLszTgEMx7NZpTO0tTx72AMjZr_w=A787hhLT_YzHVTt=h7oA@mail.gmail.com>
 <CAJs94EYXUdeAyGahUR-BPcnFTeYZvJLVSqxarD9kv-9KuMV87w@mail.gmail.com>
In-Reply-To: <CAJs94EYXUdeAyGahUR-BPcnFTeYZvJLVSqxarD9kv-9KuMV87w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 11:01:37 -0700
X-Gm-Features: AQt7F2o4JWZJ9IEsmAy51z4Lmob2djbhiA1OB5aA6ZSn64zKKAEphOzSHBvAh6I
Message-ID: <CAFLszTgbDtBKhEVD+q0JRkq0C++Mm+uX6gwUf3+Td8O3rf82=Q@mail.gmail.com>
Subject: Re: FDT overlay: lost in the documentation
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Matwey,

On Fri, 9 Jan 2026 at 04:45, Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:
>
>
>
> With best regards,
> Matwey V. Kornilov
>
> =D0=BF=D1=82, 9 =D1=8F=D0=BD=D0=B2. 2026 =D0=B3., 14:33 Simon Glass <sjg@=
chromium.org>:
>>
>> Hi Matwey,
>>
>> On Wed, 7 Jan 2026 at 06:00, Matwey V. Kornilov
>> <matwey.kornilov@gmail.com> wrote:
>> >
>> > Hello
>> >
>> > I have a board with SPI where U-Boot image is located along with
>> > environment settings. The image is supplied with correct FDT, so no
>> > additional dtb files are required to boot Linux from MMC. I.e. fdtcont=
rol
>> > variable is set up by U-Boot. Then EFI is used to execute Grub2 which
>> > handles the rest.
>> >
>> > I've read
>> > https://docs.u-boot.org/en/latest/usage/fdt_overlays.html#manually-loa=
ding-and-applying-overlays
>> > but it describes mostly how to do the overlay loading manually. What I=
 want
>> > to achieve is to automatically apply FDT overlay from a specific dtbo =
file
>> > located on MMC at each boot. What is the recommended way to do that? W=
ill
>> > rewriting the bootcmd env with pretended commands work for me?
>>
>> We should really be using FIT for this. It is designed for this
>> purpose and is a better solution than individual files.
>
>
> Ok, I see. I just want to make some experiments on the table. So, my conc=
ern about FIT is that I would need to reflash whole bootloader for that... =
and then revert back. Isn't there less destructive way?

Oh I see. Well there is the 'fdt apply' command so you could run that
in a script, perhaps?

Regards,
SImon
