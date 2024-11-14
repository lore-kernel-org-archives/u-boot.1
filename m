Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A7FD6A248
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 22:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70D3188F2A;
	Thu, 14 Nov 2024 23:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gpivi9/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4A389313; Thu, 14 Nov 2024 23:07:04 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A03088F20
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 23:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9ef275b980so14179766b.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 14:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731622022; x=1732226822; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CZICng1RLp7SKj0szCHDA43+kO406zH/3VgqFoBmqk=;
 b=Gpivi9/tY9kbNodR2XGgm7dkn85gCF8FVCIOuG0JOURijFsSTQPv7e+o93Q0hNlxbn
 bgHqnCYUIAlc70K2t7+i8UQ5K3koCDcJNcqGI/RhcvFLSK0rknklgRaenzni+rcC6oFn
 7ogTmoOHvP0PdYp10B1jKclIe13rDtoHgOw1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731622022; x=1732226822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7CZICng1RLp7SKj0szCHDA43+kO406zH/3VgqFoBmqk=;
 b=Rk07ta4ksFjUnhbQ7kiRsItm4v+QO85Jw8OECeshK7WM2Qm2Iey4rqLUdnd+t8g7KM
 jLw20yn4nv7H7zBWxbWVDoibJR6f6vhj2QiF5e27lcbJwUwuuNmm1earLD8Mu9BcvbJu
 bMiOx/Wd/BqoQAToibSvw/+shEppak6R8l+WCH11cRnDfX8jy0eR1ed2TkBHx212bQWd
 xPgAlTUWddQuxfo8FCqZ/x3fDGXJ44cZFdZFxNMc9Io2QGp8vxmwxstvz4ksM1gmk7qh
 YLnpNtmRqNjo0phS2nebg73BmW83mnauOp5NqTxUnu/7WSI2LbzmO/1T3dx5Vpk0F2ux
 3rxg==
X-Gm-Message-State: AOJu0YytU9vC4ETfV7X95NRuvNnaVzTTvgnHPJfhcTukDcG0inj8LaOz
 BIuhFQlhIC9sfr4NX96LvC2PhdgYxOcpdFPGm4cso9mq9cIdRmjI/QzqpMvds3MU96k/nVaxF67
 0K9t7P0m75MopbKd3GBsvnIWchXgluL9DsZqs6d1dMdeUdZwIaw==
X-Google-Smtp-Source: AGHT+IHinTAv24Y5p4TLL0nUWpWmBE5gquxHjxcQV66sWUv1C1KKMPhQRmXp/kEluOP8xE0e+R3psun8aY7vPqxd/gs=
X-Received: by 2002:a17:907:c24:b0:a9e:dab6:aa10 with SMTP id
 a640c23a62f3a-aa483507feemr23348566b.41.1731622021623; Thu, 14 Nov 2024
 14:07:01 -0800 (PST)
MIME-Version: 1.0
References: <DU4PR08MB111882C823AA07294E82B4FFC935B2@DU4PR08MB11188.eurprd08.prod.outlook.com>
In-Reply-To: <DU4PR08MB111882C823AA07294E82B4FFC935B2@DU4PR08MB11188.eurprd08.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 14 Nov 2024 15:06:50 -0700
Message-ID: <CAFLszTgRhKWNiB4LeDP+zkXrX12YnRfMvfx5ZdA7mWMU2Qb69w@mail.gmail.com>
Subject: Re: Clarification on Bloblist Initialization Settings
To: Harrison Mutai <Harrison.Mutai@arm.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Arthur She <arthur.she@linaro.org>, 
 Manish Pandey2 <Manish.Pandey2@arm.com>
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

On Thu, 14 Nov 2024 at 13:41, Harrison Mutai <Harrison.Mutai@arm.com> wrote=
:
>
> Hi all,
> I wanted to clarify some details about the settings for initializing a Bl=
oblist (i.e., CONFIG_BLOBLIST_ALLOC, CONFIG_BLOBLIST_FIXED, CONFIG_BLOBLIST=
_PASSAGE). The documentation states that if CONFIG_BLOBLIST_PASSAGE is sele=
cted, it uses the bloblist in the incoming standard passage.
> Does this mean that the bloblist is used in-place wherever the previous s=
tage places it? For example, if TF-A passes a bloblist at an address specif=
ied in the platform's boot parameters, would this mode use the bloblist in =
that location?

Yes that's right, but if BLOBLIST_SIZE_RELOC is used, U-Boot may relocate i=
t.

> The reason I ask is that I'm preparing some patches to add bloblist suppo=
rt to vexpress64, and I'm looking to configure this platform without specif=
ying BLOBLIST_ADDR or BLOBLIST_SIZE (i.e., automatically detect these).

Yes, that is a better way to do it, now that we have the ability to
pass a bloblist between phases.


> Thanks for your help!
> Best regards,
> Harrison
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.

I hope not!

Regards,
Simon
