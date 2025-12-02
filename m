Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DF4CFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 08:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB8083E0F;
	Tue,  2 Dec 2025 09:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pFZmemT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2796F83E21; Tue,  2 Dec 2025 09:53:54 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6BD583C39
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 09:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-78a6c7ac3caso55814317b3.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 00:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764665630; x=1765270430; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZpfkI+xNVDWuPr1LZRyNOl633zCF32W58uV/RiPm3CQ=;
 b=pFZmemT4LMbMe+EIGYOk3wtLHlCM0ScIVpLfgqDs9nmosuisPZpl/2lmT2whO/ovNW
 5Q5sDNoIXeT+/DnRZ7yOW4Rm5ZqwDQV45GvrmDtUw5OQTxtu8d+QI0Pot+hbnrRKDBE1
 71NrUcNWI37H9v1xbCWA+XT68JHieFuLEFIkFrGy7QStoiX2fjN8e/c3++ncA17mSW5l
 x7jPn8EmuSYCq3meDpcFZ422YInrsS007DxrYJc3/ebY6gc/7t0boWX/gmmZBhJizAme
 s9uaCNt8tyWBlMmcY10Zi/pqfblLf2GLzWeFkAWucXa5nh5oAW/HYrd6h7SMAAVHPomU
 b0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764665630; x=1765270430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpfkI+xNVDWuPr1LZRyNOl633zCF32W58uV/RiPm3CQ=;
 b=Wm4DLt7sv7xBaGY1KNQ7ZET4TLegaqp58Iprd/vj2BqKNc0fyvLiztns6qlIh9B30Q
 yAB/Hq6Jrh+yW9JOU4AwWQ8o2+yGrtk19C4OGqbqAigiWIEfk4lw9XPKIwjgrE+7eGg7
 WTHOSr15dcHiDEGtU4nktNMh5hM8WgzkDU/CUNkv7ukmwxJXGuqyp/cHiFStONKUx1Hf
 V4NIDXynuPX2+n/8XOYbAnACvYGn124Mm13LJQCgDdflYTsmn65T8x9RCu+hFLcNdDUi
 8qFBr1vSvW092bavYsOpF7WapnEj2Snob4xiA/aWrCxClazw7dmz2+dP7AQ9gvSZLR8h
 oTTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+G+9AwUOw6hUEMUgkIuB2O4dVgUUi1hHXM+40CCrX9X1DnmQOkZu9Ncll0nNh//ScnxNF9Qc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt0dkVI9tnSU+n45n1j/1WR3kqL6U9E6yUj1N00ATqKuzh2G66
 IOgPSNnxILahnTPREvGpD8/BqE4LZaJlbRsoJJMVtZrxGCY0ISkqNN6Qhuz45/e8Af/qNIusDzI
 OhEKDkrVwCN+dtfYJx6GJtQIvUyry+MEMQxUx6sbfRA==
X-Gm-Gg: ASbGncul6QCB51HRyeZQ42Ie8OnwRSGR4ZkZjLrc/kxP+0sSY2aF+wNpAMfQjOQqI3r
 HK22DLb92PIjdwlyZ0hbY8x5ArvJfGe6lQ5SIrQFhMiV7pzBYRPmtUl0fwSoUVtNL4NC6htsU6K
 u7DbDQ9+Y6qs3J059GahgSNC8leBOnMnBl5URonao0E1eXoT9jr4X089QAy9NHMQVpCjNPO4BSf
 yG+rzuz/TEnhconNRdnEOjK0ozkXGIr7vfJhkD5EmTy8nEQDR2h8YgpWNNYBsNieqE4qaZdC1Ta
 hLgS/fa4AnnHHALslJHkYKvXL0P9AmZTUEceyUkFeL141fcyjD2W2MFOfRbPpNF5z1vUbSCTgJ6
 XmTVNOhU=
X-Google-Smtp-Source: AGHT+IGXBLzYs7RybDlOthXZ1biIZd8VThcRtlrH6EkMfqr9KvSSbnjGVQovwhzmMzre6sPtChR4wSoqBH8gTT8YcqU=
X-Received: by 2002:a05:690c:e3e4:b0:787:e9f8:1869 with SMTP id
 00721157ae682-78a8b454672mr321840667b3.10.1764665630500; Tue, 02 Dec 2025
 00:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAC_iWjLYvzHHJ+KYj68KWa=E+V3wc360HRf_dWCh7ny5bdEU9A@mail.gmail.com>
 <CAN7C2SAEZgm8KshbGU3d48U3w01vtG5zvbzZRbA_3tE5S0E+Lw@mail.gmail.com>
In-Reply-To: <CAN7C2SAEZgm8KshbGU3d48U3w01vtG5zvbzZRbA_3tE5S0E+Lw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 2 Dec 2025 10:53:13 +0200
X-Gm-Features: AWmQ_bniyfofmqGetnfKiN0Zc4yFIuhWz7sqBFOGyYYl-GT-Rs4PHsQ8IUTyY68
Message-ID: <CAC_iWj+Jo1fP2ucXPY+q6+rFhHsT3PKz7H2J4dH-3cyAk01HEg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 u-boot@lists.denx.de, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tien Fong Chee <tien.fong.chee@intel.com>
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

[...]

> >
> > Ok, let me go through my irc logs in case I find it.
> > Reading the email thread we should compile with anything > 8.1 right?
> >
> > Cheers
> > /Ilias
> > >
> > > --
> > > Tom
>
> Hi llias and Tom,
>
> I have a question might be wrong or not even exist.
> Tom mentioned GCC 8.1 kbuild but u-boot is considered as
> kernel build or it does not always be that case?

We use the same Kbuild system as the kernel. I updated that a few
months ago since we where stuck on a really old version.

>
> At least so fat there are nothing can build properly below 10.0.1
> Using ARM official cross compile binaries.

I think I tested with gcc11, but I I don't remember testing with 8.x.
I probably missed something on the backporting. I'll try having a look

Cheers
/Ilias
>
> Thanks,
> Brian
