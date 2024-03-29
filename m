Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4066AC6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 22:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6415D88228;
	Fri, 29 Mar 2024 23:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u1VCaPOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A39A88265; Fri, 29 Mar 2024 23:25:55 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E157881C3
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 23:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dc742543119so2461573276.0
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751152; x=1712355952; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxnZbxLiTXeVpjW+evu4PZX6UdqiLcphjGIpgIqfA4g=;
 b=u1VCaPOP7w42Ag9JLPZPnggzw6O4MBvkJVgzE6j8fHFwOdejGfNgU+UIPz+hNSCrV5
 TRwYKkp3nPqWr/73t+NtG6vRaH5YT8nLj5zYbirocTS0es3an9n3AuUxMMKU+9QOSwuX
 7FRFQlWJZc3F4VjHpOYChlm1433DjyLvglyjA3eqWnJsuY/8KZrFgVWJ45bZpFEE61hz
 UsJkyUMQN/ylooKbqnldrjK4e3rIC6nKEX3z0UvQd8nTj9imlYLJ+1sDu5XNso8tD4Lt
 fkrDvn+bsVPs3jPFs/0kEv+UgdVWsSGTc8Kz/6K7+/YzYrXv+EkHYuiZ4Cb+fs4eGNyZ
 HmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751152; x=1712355952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxnZbxLiTXeVpjW+evu4PZX6UdqiLcphjGIpgIqfA4g=;
 b=t07+XhkaXY2wmp04Y+K9TfRE5dYkpr6Iy0MW7yLRcPY09VoKl0RvcUypBDxixYIe/B
 WBYOvaBTvHyi++npBVbASZevigWDfLz6NbqRQBAMLk3WZv+pD/gULrWn2zFAKwX88XHF
 zQBnL9O+eyB2/bWTik3xhd+Q4dZSYmLdlzy56RN2sx8JFnebjCofB/LjIgsxUuM+Tw++
 39rDpuXpRR53p8bP5+Hhni2qAQCsf8fwPrLcLX7cKYk47wKMditK/Z5hO2WSlZ3hjOJr
 D72riY13Ma/BXCYto9Um4j1OxWe+tEJr+6aUGDNvbERzmfK2PXZ7P7OgeUJsO/8OqlDU
 dXaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIdmzYpDZn9dI2PCFVWJm/IHwZLnT65P6mUJAoObNVbSq+70Bhg2CSVDMPRclMSIJg+CmU5CdqBg1QHj6w4P04fjAhwA==
X-Gm-Message-State: AOJu0YxfuoJCVfCgrI3AJv6BnOf44847zPlCgHq8pawZCnkcjRVv8g4Q
 /ZLZfHj5YuX1R1bHZiGctxLOy0Oezse6dII2lSckPz2J+AgRyu4aC5JpcYxaZk2x8M9Psvcnccz
 5l7z3MV4PWQe4kMVRJqzzB6cZKTaRj9egR3n/eg==
X-Google-Smtp-Source: AGHT+IHjCVmnvA4V9xem19ljYH1XXaHsgIBP1Yl0s3udr0AlX51W99kAApF0r41xTZaB5DV+y7upM/vaZiTbZbYcA1U=
X-Received: by 2002:a25:a406:0:b0:dc7:43fe:e124 with SMTP id
 f6-20020a25a406000000b00dc743fee124mr3195891ybi.11.1711751151990; Fri, 29 Mar
 2024 15:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240328222951.11431-1-semen.protsenko@linaro.org>
 <20240328222951.11431-2-semen.protsenko@linaro.org>
 <c9320079-458a-44f5-85a6-3a7c8bd3585e@gmx.de>
In-Reply-To: <c9320079-458a-44f5-85a6-3a7c8bd3585e@gmx.de>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 29 Mar 2024 17:25:41 -0500
Message-ID: <CAPLW+4kY_2yD_m-zmd7yTM7sEW9jJwUaXg9FzSOBaFtJve5Ouw@mail.gmail.com>
Subject: Re: [PATCH 2/2] part: efi: Treat unused partition type GUID as a
 valid case
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>, 
 Johan Jonker <jbx6244@gmail.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Steve Rae <steve.rae@raedomain.com>, Petr Kulhavy <brain@jikos.cz>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Thu, Mar 28, 2024 at 8:07=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 3/28/24 23:29, Sam Protsenko wrote:
> > Some platforms use the "unused" (all-zero) GUID as a partition type GUI=
D
> > to make some partitions hidden from the OS. For example, Samsung phones
> > and other devices often have GPT partition tables like that, created by
> > their "gpt_builder" tool [1]. All partitions with FILESYS=3D0 value
> > (second column in [2] file) will be created in a way that:
> >    1. Partition type GUID will be all-zero ("unused")
> >    2. Attributes[48:49] bits will be set to 0 (whereas non-zero values
> >       mean the partition is visible to the OS: 1=3Draw, 2=3Dext4, 3=3Df=
2fs)
>
> The UEFI specification is defining what a GPT partition table has to
> look like.
>
> According the specification partition type GUID
> 00000000-0000-0000-0000-000000000000 marks an "unused entry" in the
> partition table.
>
> An unused partition table entry cannot define a partition. It is one of
> the entries, that you skip over when enumerating via your patch 1/2.
>
> With this patch 128 partition table entries are printed for an image
> having a single partition.
>
> =3D> part list host 0
>
> Partition Map for HOST device 0  --   Partition Type: EFI
>
> Part    Start LBA       End LBA         Name
>          Attributes
>          Type GUID
>          Partition GUID
>    1     0x00000800      0x0001f7ff      "EFI system partition"
>          attrs:  0x0000000000000005
>          type:   c12a7328-f81f-11d2-ba4b-00a0c93ec93b
>                  (system)
>          guid:   ee474198-4601-4d5c-81f0-54acf904dd40
>    2     0x00000000      0x00000000      ""
>          attrs:  0x0000000000000000
>          type:   00000000-0000-0000-0000-000000000000
>                  (00000000-0000-0000-0000-000000000000)
>          guid:   00000000-0000-0000-0000-000000000000
> ...
>
> 128     0x00000000      0x00000000      ""
>          attrs:  0x0000000000000000
>          type:   00000000-0000-0000-0000-000000000000
>                  (00000000-0000-0000-0000-000000000000)
>          guid:   00000000-0000-0000-0000-000000000000
>
> This is definitively wrong.
>
> >
> > Although it's true that Linux kernel verifies the partition type GUID t=
o
> > be non-zero (in block/partitions/efi.c, is_pte_valid() function), where
> > its U-Boot counterpart code was borrowed from originally, in case of
> > U-Boot we want to handle partitions with "unused" GUIDs the same way as
> > any other valid partitions, to allow the user to interact with those
> > (e.g. list partitions using "part list", be able to flash those via
> > fastboot, etc).
>
> You cannot interact with a non-existing partition.
>
> You may create a new partition in any empty slot that Samsung's tool has
> left in the partition table and then write to it. No patch is needed for
> this.
>

Thanks for reviewing! In case of Samsung's way of creating GPT tables,
those are actually real partitions (they just "hide" those by means of
setting their type GUIDs to 0), and it's possible to flash those and
interact with them in other ways. But I can see how it's not a
standard way of doing things. And because (as you pointed out) this
patch leads to undesirable effects on other platforms, I also think it
should be NAKed. That of course means it won't be possible to access
all partitions on downstream Samsung devices, but with upstream U-Boot
people will probably want to create an appropriate GPT table anyways.

> Best regards
>
> Heinrich
>

[snip]
