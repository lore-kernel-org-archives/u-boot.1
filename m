Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097BBC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C506E87907;
	Tue, 26 Dec 2023 10:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RSK2S9Tp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1871D87687; Tue, 26 Dec 2023 10:50:29 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A568793A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bb89215406so2797463b6e.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584225; x=1704189025; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wr7KYxn2eQz2gDiHywVP67CNLF7lCzb1tdT4z0fx38=;
 b=RSK2S9Tp5PjuFJ7g/G1goMsP4Eq0jobcdUBDNC6I+2SwZJqUFJ5gZg0dxMU3yuBjjq
 kbhhCQ8xfdWNjXVHHv7Grg07HBA7jyw153qKAT1fIi/PlRnSY1maCkP78p6klA2fJPlz
 5fwOt82ng2NwcN/3O+8PpyzViYJQisJKdYqn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584225; x=1704189025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wr7KYxn2eQz2gDiHywVP67CNLF7lCzb1tdT4z0fx38=;
 b=cAAbUh8DrSajwM2sYM1dvuvOoAvsJxV0+BhABLTx+EHLTx8InLY245RsQyhnWV4yPX
 VxmXqy0ipen2MuWclz+OxJ2iS4MLelrclSMNNbipRb7PXnRWXno9EixPSfbUhTv17iw/
 rsnQBsbBWfoOGUA93jMWnfUN5TUT+pBD6DBoOLGbsu8T2fw8R4Xg1Dj4a6Glu6MyiZxQ
 bQrARiBlq+gVIdXC4u7gK/jp6MvPNkERhzMLgzITOhDein0yqkaCwly4UwFEPASGxd43
 HPpJde9/zkLkRX7Hbjx5NMKP59uzCVcV+RhUVP8AjJ3ocCy+p58HmphipmfZaKCc14zK
 sAKA==
X-Gm-Message-State: AOJu0YxLsOhZcNZPtkEDuV9d2SBgrOpDEaIXDyEnWXZrGScTyebvWNEM
 BN1knPpYYpTi/YW6tp7gaYhch4CMIPyOvZJo6/VEEKoQYNkz
X-Google-Smtp-Source: AGHT+IGKFobJILsNEsmAX42n8DaeCjidBXQPHDTCE/CAUtjhw7UvDYNWZAkJ6CZayDBGrkcpdTf2nmDCnnXYJuWj1OY=
X-Received: by 2002:a05:6358:7255:b0:174:8ce1:11ad with SMTP id
 i21-20020a056358725500b001748ce111admr8937604rwa.9.1703584224802; Tue, 26 Dec
 2023 01:50:24 -0800 (PST)
MIME-Version: 1.0
References: <9f681497-d13c-4ccc-9209-7a8b33e3195c@gmx.de>
In-Reply-To: <9f681497-d13c-4ccc-9209-7a8b33e3195c@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:10 +0000
Message-ID: <CAFLszThsThxhWCgP+UHmA5BxRUUBfDP7SDahtAm5WOrHoT0xhQ@mail.gmail.com>
Subject: Re: ACPI: usage of sandbox virtual addresses
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Tue, Dec 26, 2023 at 8:56=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> Hello Simon,
>
> currently we use sandbox virtual addresses in all ACPI tables. This
> means that an application started by the U-Boot sandbox consuming these
> tables will crash due to accessing invalid addresses.
>
> Shouldn't the ACPI tables be migrated to use valid pointers?

The confusion arises due to the difference between addresses and
pointers. If we store addresses in the ACPI tables, then things should
work.

My approach has been to avoid using casts, but instead use
map_sysmem() and mem_to_sysmem().

Which particular piece of code is wrong in this case?

Regards,
Simon
