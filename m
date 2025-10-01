Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54CDCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 15:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F4381D6A;
	Wed,  1 Oct 2025 17:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kAEg4tWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B21368328F; Wed,  1 Oct 2025 17:54:26 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29EF3800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 17:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b593def09e3so3828955a12.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759334063; x=1759938863; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0i/bUDueud3yxggxnpK1au66HYs8qfWTpoTVOx+koQ=;
 b=kAEg4tWxAIqJMc9WreK4b1DYS4WOv8VcSmqME4YrAoj+CtHgp7ragQP6Z2nubf3CkG
 sWZ6x9Fy6OqTCRje6JkH1MqyBYC85wlQW1tIjlvddmOvUF3nNAPEOvY6ttB9z37fuGWO
 wQ/yzWWWptwhsKKrAPvVwj5oYIurZZxaj8AHAQ67CSQvOMv5EFkwCrOlO3xAhlai2yz6
 R5EGWYkvCwojdG4idEPvLz39xRgJF1Y6c1ffzgvPTLY5oWg5d6qVmh2MNLGmMHemW/xI
 9W1QtUuTyZNpz/apby6ZvY2HOJenrKVDEZC0+R/VuI4Ho88ukn472vhFvqyitr6Y557G
 6mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759334063; x=1759938863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0i/bUDueud3yxggxnpK1au66HYs8qfWTpoTVOx+koQ=;
 b=u3pKPi9QmGFNczJW7VuOZ5efy6HY2ykDds8GFoPo0wHLfLrfBjTp6EWYTo3TjZBKqP
 2AZ9nGc6FaHp96LICPRGohSASoBmpp/QsEfYEXn8Dk1mZosELuMmudni32xmq8FOZqg6
 S2l+kvKkAlPKWs2eBjknuMgNGz/xzY449qtTB87+GjTNTSxXIVO8p/H9EmPMriGXDdez
 7MqAIf7u7VlZxZ/98iTSPZ6/Mg7QHYiBtwl9MF33XL2i3LRu2DeigythRdGkPAuBC1ul
 /IPHJwo3qNqjl+y+hOJ2jRnTI00F7Pde8MMlj/wcfLvsnWxU6EN74qSR1zRnQPJ8CcO9
 GQGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWardbgjrlAXZ4fRpWaPfJmN7vw/cocL9cAWyovN21rKzJTacs0Vk8XBnOoLJv4uxqszJU83qA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxl1BaHvSnJuFZvfeVml7UDyJjql/9FH04yNu5Gt6eMhsnRg/GX
 XCfE44GTEuvThvluZRjZxTWD03SSeZD5DGKErf6UjUjEjLg1SAG7fY1GVUeT0nDkTF2ZZmPphJo
 JnWqwK7PqT3QBuPU5w2+On260jEorRy1mrG7EQB4kTA==
X-Gm-Gg: ASbGncvnfzYWeaepQpOMXxvhYsNd2swk5LkWSspv8JffrHNW/jIHa6JmAdqH7KP+sxc
 yvZIOWJuPH3aqN2pe4gS2/U2zfIXt3NAU5dJhW0he/d6p0nOVXtQl47xP/zsO3WUgcnMTN//9Mm
 EjWiXBdYW3RrSlopJiT6Ez8pvbsTCThUFSDPmxwxzjz8imHD8AiXWvOuljf/ZWhCZSM9s/mBdaF
 b6jaPQcbjqnypyXtCCuP7rfUL8SqDzS
X-Google-Smtp-Source: AGHT+IEoAnfcCav/uR/wpDT1YpuM1tk14bldbXItmg52cjI3b4Xxxuh7mnXzXQz+IgoOP6ycQ6HdpALtA3LRYUl6xuA=
X-Received: by 2002:a17:902:ef12:b0:25c:8745:4a58 with SMTP id
 d9443c01a7336-28e7f28e671mr50144175ad.3.1759334062627; Wed, 01 Oct 2025
 08:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <b7c008b2-0a1f-4971-af4e-428faf818d4e@arm.com>
 <ada31617-374d-4f87-97eb-c91da2c4e9b5@arm.com>
 <20250929181133.GM6093@bill-the-cat>
 <cbedfd39-85c7-415c-a401-91795408ebc8@arm.com>
In-Reply-To: <cbedfd39-85c7-415c-a401-91795408ebc8@arm.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 1 Oct 2025 11:54:10 -0400
X-Gm-Features: AS18NWAFWn7DwG0EtwUsT5JIldaFwNnaS5orFG9f5EeSlbzfmD0vqRyzYavdJFs
Message-ID: <CAEfUkU+jQDQmeLm6Qw4dKGgN99eprzn-CEaRdHdAzBOmn3UT8Q@mail.gmail.com>
Subject: Re: Transfer List Checksum Correction and Impact on Bloblist
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>, nd <nd@arm.com>
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

Hi Harrison,

On Tue, 30 Sept 2025 at 06:54, Harrison Mutai <harrison.mutai@arm.com> wrot=
e:
>
> On 29/09/2025 19:11, Tom Rini wrote:
> > On Fri, Sep 26, 2025 at 05:09:53PM +0100, Harrison Mutai wrote:
> >> Hi all,
> >>
> >> We recently applied changes to the transfer list library [1] to correc=
t the
> >> checksum calculation. Previously, we used a simple byte-sum approach.
> >> However, we later realized this contradicts the Firmware Handoff
> >> specification, which states:
> >>
> >>> The checksum is set to a value such that the XOR over every byte in t=
he
> >>> {tl_base_pa, =E2=80=A6, tl_base_pa + used_size - 1} address range is =
equal to 0.
> >>
> >> This discrepancy creates problems when interoperating with Bloblist.
> >> Should Bloblist=E2=80=99s checksum calculation be updated to follow th=
e same
> >> XOR-based method?
> >>
> >> [1]
> >> https://review.trustedfirmware.org/c/shared/transfer-list-library/+/42=
548
> >
> > Erm, since this has been out in the wild so to speak, we can't just
> > change the algorithm without bumping some cardinal. Or are there yet
> > other implementations that were doing what the spec said?
> >
>
> Raymond; Thanks for setting up the handoff tests. The next release for
> TF-A is planned for mid-November [1].
>
> We=E2=80=99ve run into an issue where TF-A requires specific tags from th=
e
> transfer list library, but we can=E2=80=99t consume them due to the recen=
t
> checksum changes.
>
> Tom; As it stands, ours is the only implementation currently using the
> updated checksum algorithm. There are two other consumers - OP-TEE and
> EDK2. OP-TEE already has a patch in upstream review to move to the new
> algorithm [2].
>

There is a question: How did you pass the OP-TEE CI test without U-Boot cha=
nges?
There is a CI check QEMUv8_check2 in OP-TEE that builds with Firmware
Handoff enabled, but the manifest is pointing to U-Boot v2025.07-rc1.
So I think unless you have merged the updated checksum to U-Boot and
updated the OP-TEE manifest with that commit-id, otherwise
QEMUv8_check2 will still fail due to the mismatching checksum
algorithm.

Regards,
Raymond

> I=E2=80=99ve also reached out to the author of the EDK2 implementation to=
 make
> them aware of the change.
>
> [1]
> https://trustedfirmware-a.readthedocs.io/en/latest/about/release-informat=
ion.html
> [2] https://github.com/OP-TEE/optee_os/pull/7531
>
