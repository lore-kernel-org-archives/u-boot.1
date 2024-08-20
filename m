Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26585C531DC
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 19:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA5788D0F;
	Tue, 20 Aug 2024 21:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qszZyMA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8956188D81; Tue, 20 Aug 2024 21:49:13 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6495588A74
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 21:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-68518bc1407so66216917b3.2
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724183350; x=1724788150; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwSZbgXk/DoTso9wViM1zjZNb89ie/da4uAOOVCLOpA=;
 b=qszZyMA1PNCSxPWx4aZu+jsR64Bs51K513uPxu1DxRAV3Gj8EF0FzUbjCs+IXzxzna
 Pn5OdEXr7+sWKbjSAvYg1BAMLDeWjetMn9w0aGNUM9o1XABrL5DWro0WYrwmzjH69HZI
 UGhRbiW18yYQ5RWE7gWJBb5JCxCBd/8Ddp7Qi7EekE1D5RYvqhCKdyMBn3Dy2YiXIukb
 I6Mfa+8EAclqgIxSQFT/7npc+8Cdws3HWe0kJuVHKkQ0hpbp6D16cUkpc42yZ3/LRELb
 u+41IKpr87rgB7+9CgCSVbbg77f2E92MlGUUHtxBXhlyuqVZDzgEqwe8aXytzMa6hi9U
 XruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724183350; x=1724788150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iwSZbgXk/DoTso9wViM1zjZNb89ie/da4uAOOVCLOpA=;
 b=dtQmEA127FOuDJC4QpZGWaLwDEBZwaoqlxyLfqWG2u7M7TLSO2QN0+5zIpJoEfgJSy
 zlgle6+nwz1TGGyTLYEH0+mYC9F/vVigdB/vJ3jNI/3zve+bPypjpeTr8q4FMSVTJwhY
 YZevqewPhSsfd6MMWaTgmQqfgUqpyPdZxCty8BSClF4YuodqYZsZMxECef2TeFYAuACk
 pTyNu7l3xSJxa0BgAOEa9mBU7j/zPU4oBxCuOBPQhCrpr2TMFx18qwmqFPQwAbSweBKj
 5ya4lGhxRSKrA26jeX5AA74iN/HGUXhtkuZ8hnrM+QsadTDkL9RQx+nN+XnxYhVkh8xz
 0lIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDuuSa4d8FkqsqAEzosB80Zp9Q455QfL9i5xeECChJezNVOfSC0J7aQJ+cKReesgQD2BZVUJY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxkd+Arc04jjEKuXGn9BMplkYEfdrnawUcIUlTfJGq+gcp1vRDZ
 7bvP7BV4Ydwe/Ro+LvK3wvmW5e8Xq1RCfmakJgQvdiPHkuVui50MrIZHZGs40bYq0JzMEPgHLoF
 YXdDbzOm46yHhf/kG60uJ6Ayo+gQ3Kk3Uhmw2+w==
X-Google-Smtp-Source: AGHT+IG6BwSJ/1JbT1aBaKVkzQdYGczvlkxNIqvLAphMyaqK9UaOLuyJG4jEUFtL21JwKri5J9YP84exuPiNfRObrs8=
X-Received: by 2002:a05:690c:fce:b0:65f:8f77:720f with SMTP id
 00721157ae682-6c09c0cbe59mr4395587b3.5.1724183350205; Tue, 20 Aug 2024
 12:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
 <CAPLW+4m_rzR-96+4kNfE1a73kiASRAm9m+M56EqqNBZb6V7+5g@mail.gmail.com>
 <CALrBrZ3H_FzVUvCOz59gJCiHEPY3_fG6xH3sQ4nMeMdzugwfBg@mail.gmail.com>
In-Reply-To: <CALrBrZ3H_FzVUvCOz59gJCiHEPY3_fG6xH3sQ4nMeMdzugwfBg@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 20 Aug 2024 14:48:59 -0500
Message-ID: <CAPLW+4ngCAam8K1atOfVqvhUAvN53oa+t3QQR1YiVeHMpfQp1w@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] mmc: dw_mmc: Enable eMMC on E850-96 board
To: Minkyu Kang <promsoft@gmail.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 uboot-snps-arc@synopsys.com
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

On Mon, Aug 19, 2024 at 8:45=E2=80=AFPM Minkyu Kang <promsoft@gmail.com> wr=
ote:
>
> Hi,
>
> 2024=EB=85=84 8=EC=9B=94 14=EC=9D=BC (=EC=88=98) 10:15, Sam Protsenko <se=
men.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>
>> Hi Minkyu,
>>
>> What do you think about this series? It's been pending for a while
>> now, so may I ask you to take care of it?
>>
>
> applied to u-boot-samsung.
>

Thank you for handling this, Minkyu! Is there any chance this series
can be merged in 2024.10, or is it too late in the cycle?

> Thanks.
> Minkyu Kang.
