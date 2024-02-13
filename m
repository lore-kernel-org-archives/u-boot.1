Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1E2C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 13:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5C487D64;
	Tue, 13 Feb 2024 14:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="haCu+0Fg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C205E87D76; Tue, 13 Feb 2024 14:32:07 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B5187D64
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 14:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-411a6ada28dso6365065e9.3
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 05:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707831111; x=1708435911;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X3ViBsXIbPo4cQDSGoUQ/ELV2O9wGxWnbhmGyyEaZww=;
 b=haCu+0FgAKgpZUINmzoitV5uT/mguVJSdezvwlQFZfHD5PsRc5GgRL6p20atVqtbpF
 LKMFbA80hX/o7b3lSMeqCF9kZUUOz5ZMdv7YuHPRIfVFBx8YQNbIIndo83S+yMJTAD0W
 An+GkRAg/FqBODo9iWyhfPeTrVMKWFykaRDFTpr6U0OIPCYh2sqQhLy/xWcmoU7rMApH
 J14nl4fTm3iYc9puTeyaNv1LWiNZ70DLtuKz65Qh7TfSnDWKvNs8bHdaNmwS38T04UB+
 1AlO4e7j8Lopp0S6UnHZTVHq/bXftKMGYPsogCxZwUpv/+KoFRGp03CrRqQhMqJlNJU8
 KWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707831111; x=1708435911;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3ViBsXIbPo4cQDSGoUQ/ELV2O9wGxWnbhmGyyEaZww=;
 b=gi8YZk0vMW/sciTiamYpi8EnPKW/DLIXrGltpUCQEYbHCL305uvZyL200xA1Lhqq87
 wRWoSeuesLuwaYjJBlmJVtWgsp+sOx7emX3/RzULsBe8bEq6wJNFySNb2sIn0L6SNclo
 dc3egk4nPHZ6ZId2GDQR/JRSooQRybb+PDEcmMRX7DPyFGW7+RjYnI/5Sox4POVbFF1p
 m3ovTRdQPjnVPUymexyEPHqK9QF/q0DbNHDD3eyQP/dSDEwaqgtLg4Df6IvejqNli4RU
 C9SG7dpIRy9zH41sNcQhorMtuV4jEkDpETQXWfWijtIWxfWkAnWuE2/fogij1BAyLMPo
 29SQ==
X-Gm-Message-State: AOJu0Yzyr/ezgZSp+t7h//kHIMOhDe3yEZJLkGF8VfInCOAlV3P0LMO1
 8gmJhWyhOe/Y/+Dnf4MiJ5CdKVQ0inWONdjBnG1DkrOM1LXdkyAx9T0W3VENnVU=
X-Google-Smtp-Source: AGHT+IHo1om30flNhGc8Q4aADzzbqXt573L1ZmhzHrzzekOkwn6jycBQ930rCLa7n1h+r8vWCKC9KA==
X-Received: by 2002:adf:f787:0:b0:33c:e2ba:99c5 with SMTP id
 q7-20020adff787000000b0033ce2ba99c5mr417320wrp.62.1707831111291; 
 Tue, 13 Feb 2024 05:31:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVzh/EWSLtSH2KcWm+R9iNCpgdUsxM+rhD3OJ48ri7tJwTzUEWHl9mR874+COBtk77VzJ9Q7iftAauq7J6uS+XydDGsWOaj29WjuM/Npts9jm0hntqwxa4rcuf96wpIsWs/pUjySUdHmS1Qx46WhWyqT9REw1aVQ116GbErmS8hF4q/MtktL2oYK8iBKQOmjNFzTuFgg7rzYdX7mKbTQadPMlRua278kYTV
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 by19-20020a056000099300b0033b79440fa9sm7358977wrb.111.2024.02.13.05.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 05:31:50 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Igor Opaniuk
 <igor.opaniuk@foundries.io>, u-boot@lists.denx.de, Ivan Khoronzhuk
 <ivan.khoronzhuk@gmail.com>, Jens Wiklander <jens.wiklander@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/7] common: avb_verify: don't call mmc_switch_part
 for SD
In-Reply-To: <CAByghJa8QqYvU7hnYEwihhTBo=YAH1Ky9YtB95w0RQ0H0RW+KQ@mail.gmail.com>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
 <20240209192045.3961832-2-igor.opaniuk@foundries.io>
 <b457cb25-ea09-4e27-85aa-0e97a5aa7fe0@moroto.mountain>
 <CAByghJYSy86JjsC2cvGA0-5RupogR-vkADwQ6f9vSRnW4LtcFA@mail.gmail.com>
 <87h6icg4sw.fsf@baylibre.com>
 <CAByghJa8QqYvU7hnYEwihhTBo=YAH1Ky9YtB95w0RQ0H0RW+KQ@mail.gmail.com>
Date: Tue, 13 Feb 2024 14:31:49 +0100
Message-ID: <87zfw4ebi2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Igor,

On mar., f=C3=A9vr. 13, 2024 at 12:19, Igor Opaniuk <igor.opaniuk@gmail.com=
> wrote:

> Hi Mattijs,
>
> On Tue, Feb 13, 2024 at 9:13=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Igor,
>>
>> On lun., f=C3=A9vr. 12, 2024 at 09:05, Igor Opaniuk <igor.opaniuk@gmail.=
com> wrote:
>>
>> > Hi Dan,
>> >
>> > On Mon, Feb 12, 2024 at 8:05=E2=80=AFAM Dan Carpenter <dan.carpenter@l=
inaro.org> wrote:
>> >>
>> >> On Fri, Feb 09, 2024 at 08:20:39PM +0100, Igor Opaniuk wrote:
>> >> > From: Igor Opaniuk <igor.opaniuk@gmail.com>
>> >> >
>> >> > mmc_switch_part() is used for switching between hw partitions
>> >> > on eMMC (boot0, boot1, user, rpmb).
>> >> > There is no need to do that for SD card.
>> >> >
>> >>
>> >> Is this a clean up or a bugfix?  What are the visible effects for the
>> >> user?
>> > avb cmd fails for SD cards, as mmc_switch_part() fails after trying to=
 access
>> > EXT_CSD register, which obviously is not available.
>>
>> Does this means that we only need this patch to fix AVB commands when
>> booting from SD cards?
>>
>> If yes, I propose adding the following note to the commit message:
>>
>> "This fixes the avb command usage on on SD cards."
>>
>> If you agree, I can do this while applying.
> Yes, could you please add to the commit message so I don't
> send v3 for that (if there are no any additional objections/comments)

There are no additional objections, comments on my end.

I will add this to the commit message when applying.

>
> Thanks
>>
>> If not, we can keep the message as is.
>>
>> >>
>> >> regards,
>> >> dan carpenter
>> >>
>> >
>> >
>> > --
>> > Best regards - Atentamente - Meilleures salutations
>> >
>> > Igor Opaniuk
>> >
>> > mailto: igor.opaniuk@gmail.com
>> > skype: igor.opanyuk
>> > http://ua.linkedin.com/in/iopaniuk
>
>
>
> --=20
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> http://ua.linkedin.com/in/iopaniuk
