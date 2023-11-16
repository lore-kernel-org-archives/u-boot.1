Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38253C072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48ECC87465;
	Thu, 16 Nov 2023 02:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iNyt4UTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7357E8745B; Thu, 16 Nov 2023 02:39:52 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2D287444
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d9b9adaf291so264453276.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 17:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700098763; x=1700703563; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SNmo5Wc4ISR+m+oywsJF/dnKluLALifVaWT4EvI/O0Q=;
 b=iNyt4UTXMbJ85G7nfRsuxvjV0x0IWIZRV/ZDDSt8Fyqi9IroSl+Jm3ll7CZLUQueWc
 X9VCc6lboSCNkGInPT8wfMAxSImLDxwJH53TjoUJ+Ig2isixAAl4x8p4LrRFi43EonG4
 AhdDM7UDiDQBMDTq4f3APERB5yi/sDqaXbrNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700098763; x=1700703563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SNmo5Wc4ISR+m+oywsJF/dnKluLALifVaWT4EvI/O0Q=;
 b=MWnSIb6/ey4hb724gOD57hhAkLm7xyN6M1mzKdhciKV9oGXJSDa1DpjRRH6Msu7d/P
 kfYt+1mKxno3ZFugUhbbtp36HoenkqV8HWYJOJmoeB6ik+KwRzxt0n1ztgaRBQ54w9+C
 Af2MPvNQWcYpx3814OcaIpLrVHzTcevaJgMARqHeOcI5ib01ArEoB19DsQIXSKLE6EiE
 39mr90atE77mTVJDvPXJMl89WbopGExcD3ai2hJJN0ZtJiLBjA9PsvkYsd4k+r0b6QPx
 oHlF9fCX3Aj9KR6dY+yza95Z8YVj6BZkSa1tCyuyboNyk14WV4+IM2nEvTDkxoAPLnaN
 Pq9A==
X-Gm-Message-State: AOJu0Yw8D1Begiftnu7YZHd+fxqq/aNwbXO+odQfdWqvArRcU4Ce1HSB
 /NHGncE5fbRR3wRn7Gv6tSg8DckEcWKu+btK5OmqBA==
X-Google-Smtp-Source: AGHT+IE47UjdLEzJX318q6aOHWv8wRMK+l9IQb8zeRoGj1hrHhGoCUMTQIWmXiemPewshmmrkHCcngNvUgwU7lOT05Y=
X-Received: by 2002:a25:d784:0:b0:da3:b603:8314 with SMTP id
 o126-20020a25d784000000b00da3b6038314mr14337385ybg.0.1700098762915; Wed, 15
 Nov 2023 17:39:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
 <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
 <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
 <CAPnjgZ3VY_M+zd2na+N9WCxj-L2F+KKhLgykQ21FTA7GPVrKNQ@mail.gmail.com>
 <CAHc5_t1fBzzpJaQed9kcKF92ProStsutmOBW-1jmi5vWFvLM8g@mail.gmail.com>
 <CAPnjgZ3WNmnNv7DjMFDM9Med3yRng32N6tku4NGxbwA5DRhQgA@mail.gmail.com>
 <CAHc5_t1H39YV=HSSa7TCEdzRctAX+zibkx1vsuwEW-raOL9TcA@mail.gmail.com>
 <CAPnjgZ3V65sCuRV_NzJFZHL7-ZHq9SQUTxvvbj5GszFAhJ4WzA@mail.gmail.com>
 <CAC53B67-9BC2-4EB4-9846-F78166140BD0@gmx.de>
In-Reply-To: <CAC53B67-9BC2-4EB4-9846-F78166140BD0@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 18:39:05 -0700
Message-ID: <CAPnjgZ2P=85dys80aXA4Hss9f=wq9YR+KrNSw5bk+n=W7RFj8w@mail.gmail.com>
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Wed, 15 Nov 2023 at 15:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 15. November 2023 23:15:46 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Shantur,
> >
> >On Wed, 15 Nov 2023 at 15:13, Shantur Rathore <i@shantur.com> wrote:
> >>
> >> Hi Simon,
> >>
> >> I have figured out the cause of the crash.
> >> It happens here -
> >> https://github.com/u-boot/u-boot/blob/master/boot/bootflow.c#L470
> >> while doing - free(bflow->buf)
> >>
> >> As I understand it,
> >> - Just before starting kernel EFI binary calls usb-uclass->usb_stop()
> >> - This starts removing all devices in my case ( 6x usb_hub, 2x
> >> partition, 1x blk, 2x bootdev, 1x usb_maas_storage)
> >> - While removing bootdev, it ends up calling bootdev-uclass ->
> >> bootdev_pre_unbind -> bootdev_clear_bootflows which calls
> >> bootflow->bootflow_remove and bootflow_free
> >>
> >> I don't know why this buf cannot be freed, is it because the EFI
> >> binary in the buffer is still being used ( efi/boot/bootaa64.efi ) ?
>
> EFI binaries should never be started from memory allocated with malloc. efi_load_image() should be invoked which allocates EFI memory via efi_allocate_pages(). The handle created has to be passed to efi_start_image().

This is a mess at present, as you are probably aware. EFI has hack to
look at loaded images and try to patch up its tables.

With bootstd we will be able to do this properly.

But note that memory allocation in U-Boot is done via malloc() and
lmb. We don't call efi_allocate_pages() except in the EFI code.

>
> >> But commenting this line out fixes the crash and linux boots happily.
> >>
> >> Fixing this properly is above my pay grade as of now.
> >
> >Great, thank you! I will send a patch.
>
> Free() typically crashes in U-Boot when freeing the same memory twice.

Indeed. In this case it was not even allocated.

Regards,
Simon
