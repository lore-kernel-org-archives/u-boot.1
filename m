Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1835CC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 08:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ABC887EBD;
	Mon, 12 Feb 2024 09:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aFls5KFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53AB387EBA; Mon, 12 Feb 2024 09:06:07 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD0787EC1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 09:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33b670e4093so669006f8f.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 00:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707725164; x=1708329964; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZJaeKzr7MglYQY4lYHEPX8fAbj4bozDiunr3fDcGMk=;
 b=aFls5KFm18G7bzeUPZAzTQSM0txHMasEDbx+AHVxWod8SiHyQLEHVydXtRGgncMTT6
 oD7hJuoVySabxsokyKHzJhVHgI8f6lyUfujY7+5lRtL9s7/I2f7kx+cndR64MMRaKb1t
 56TAjYnaN29fSQKBEEmCpq5NAavp+epAvg8gvd3cVdDFM39OBnlRteczT2Hu8R5WFBFM
 64Ptk+5td49pHo7UuWY1VbbokzyZHNqv7HATAxBHNBsHWb+QXSMgS4sMfNXNOvX7RqH7
 6JJKBaq0A5hBgnXMpAvktA6OsbcUqN6kpbHz2VRDtjGTgnY/T+ocEmmG6/ONyTWcUZie
 I11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707725164; x=1708329964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZJaeKzr7MglYQY4lYHEPX8fAbj4bozDiunr3fDcGMk=;
 b=BQJ4DuA7b3JuKXWj/BACSdz7OLs3A3vBmE51hhu34Tag7CZ491m56LcLNBtHPoDSpA
 9Z7f3TOyzVNKwkRRwenEzcY2Tg/SbPWiNiQIxHPSsqPUj5Qo413+wWzGk6A6vDm7dNvO
 tmRCa8GaiXHMgYrYuCM6EltFUo/V1p0Bpwy8hYULPOEpsd2oI5TKAX93Yt75Wiv9lSly
 neTUGifUyFzHyp9+ckJeMhC1axei3syAojtrs6i2Tqt5x1Q2oli4QeNTYAMa74PHCi8g
 LZ0j/khcUBLZfKftirGOd9ldJ43Ac2O7O17eAjYYzWU+iqgD0KT05NUjIdvZMVoav/7l
 28aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU26B29e7vcJ1sUBAoKvBr4MES7pL3UKi9sz4i8Vkwm8kqO/UbqRO6IYBopjwGMVcu0RbXl4Zz5Cny9dxd2nobFN6PT9Q==
X-Gm-Message-State: AOJu0YxA6DzDfTXbDvfVyXmSC5Vlxs5XdqPl75Vut2Ti2JoRAubtloOX
 YKvizl5TkbKaad/TH7yXvmGT2WEKqZPkFPV/lJLjHB9JTN0ZPWKvkbL3fSepoV4s4kBormMy7LX
 rQFWt1qE8sAC4d7Z8gWiTIkcJJ3U=
X-Google-Smtp-Source: AGHT+IFJZtsYn1HQ0XyzT/k5Gv5ZciNh01ID9wXWZGX6/lv4v8Jl7JxG4hJD36CQFuiJ8VCv1AryLak0assNRTT027g=
X-Received: by 2002:a05:6000:68a:b0:33b:2309:63e6 with SMTP id
 bo10-20020a056000068a00b0033b230963e6mr5565047wrb.5.1707725164099; Mon, 12
 Feb 2024 00:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
 <20240209192045.3961832-2-igor.opaniuk@foundries.io>
 <b457cb25-ea09-4e27-85aa-0e97a5aa7fe0@moroto.mountain>
In-Reply-To: <b457cb25-ea09-4e27-85aa-0e97a5aa7fe0@moroto.mountain>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 12 Feb 2024 09:05:52 +0100
Message-ID: <CAByghJYSy86JjsC2cvGA0-5RupogR-vkADwQ6f9vSRnW4LtcFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] common: avb_verify: don't call mmc_switch_part for
 SD
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>, 
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Dan,

On Mon, Feb 12, 2024 at 8:05=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Fri, Feb 09, 2024 at 08:20:39PM +0100, Igor Opaniuk wrote:
> > From: Igor Opaniuk <igor.opaniuk@gmail.com>
> >
> > mmc_switch_part() is used for switching between hw partitions
> > on eMMC (boot0, boot1, user, rpmb).
> > There is no need to do that for SD card.
> >
>
> Is this a clean up or a bugfix?  What are the visible effects for the
> user?
avb cmd fails for SD cards, as mmc_switch_part() fails after trying to acce=
ss
EXT_CSD register, which obviously is not available.
>
> regards,
> dan carpenter
>


--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
