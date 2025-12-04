Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89CDD1F9CD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 11:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC2E83A36;
	Thu,  4 Dec 2025 12:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iiF915/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E8B58405A; Thu,  4 Dec 2025 12:55:19 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50EDC809A5
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 12:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6443b62daf6so688420d50.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 03:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764849315; x=1765454115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9zvoT7v8YxGmHbSYSDVh/MccPs21JjnkNpB3kFjBUSg=;
 b=iiF915/YVQjqbrenHxLGYvNed3kntxrF3mN49/Hm/gFcjlZxy+BF4bZ25IIi6+fkE9
 uiIMSKSL1qf3d1I+x4ZFG/guNOHTU44g2H0CbbWqCIB+rTltHiKKu0YPqyI681UuhmvA
 5X0kPNy8tQNqoj2wg2zWQHOts0RF3WvfbXlIOIvWdDN/4lqxfRm3qdKmqnNFvruA66cU
 Y2UZmrsqxa5vejm5R7SwOaYcBppQ6GHyRV9S3ZhEbwjbyHK5A59HsTS0P+lWuVxLCNsA
 co2dfMTQXwitcpJ0kXGy4w8qFJ3A9uQgVbFysYmsdQUesqhjSYijQKeGjvZbQRDipaZ4
 +juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764849315; x=1765454115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zvoT7v8YxGmHbSYSDVh/MccPs21JjnkNpB3kFjBUSg=;
 b=MWkVNowQjwK821FI05ZaRH5AqJvGXKrOK7Zk1ugrjKZWA74JmImMW4+vc524h7h+P/
 f9Sqoqct3Z8gUGwk4eRNQ5wFSkeaT1An0ElSnD+66Ouiyo9Q1s2F+reoEj3Z6vNOJ8vm
 zzFbvTtW9/0K9hhaaeCkvxbh/Ag+J0A6czPMncml3y/mSKokAEF39qxBvUCUwINDePG7
 hjhTfPRDXwaRwVGjP4WxpcMDF3bbwhkWquWuMOJw7yIYYONw2Yvtqjqjlew0a6Gcposs
 pFGUjF5UTp2jF4CRfanKqY5NC67YeoggSNMjIVRpsHWPsGJnsQDeeFgpISl3mBE7ah0J
 9MKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1qKKfG+ZcZZuh+U+CD5xKFBmgpaRH9EeR+2xE6VdQEm+tO+UAvYFmdmK35G860AKjCrVFHQc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+d5otkz8l99sLrqCZmvrdyH71LhB3xJYAjWDQhipU6X7qJP6O
 0oZmAg4o35utavDu/n4kMP0EqzKG+vvVaQ08CIN3fdKZUKlP1h3wHhLW8eeC8+LR8mxL199ky8C
 V/Nf+9CGSfzlDodFA4+j7VXy06C+/n6ZKlYlsBzROzA==
X-Gm-Gg: ASbGncss4PvlV/3fC2tXFuodeu7edcfmqkb/udS9fr4x4A3DgdmyXT6xeczr4gYwkEO
 HZLTz+V1IjxrYlrVig/+SX6AD+Ynx1M7KHzTtvZLuXbqtIzLjGkbzashBH6fpLpVMQU6u21ggcX
 KmeSPxe8imOrU1M/WXnHwQd1cXKxGM17ADPf7hGPhnpdmPaEI2JUENjGYJlKRCY1b97iLp9xrYu
 sE40Z9hEgPlyakimSKurvCGvA9fjXvX76lrylCfK3uQCdWCsx2gRShDykT0Pe2npQs05mw+mK2e
 dn2S7HRdQsscpsPS+ooEKZwh9bNaa8oAKO0JUJ6wej0cXdtBkaBnRLwNGYVnojv0Pm065z8gvYO
 7mHxDVKQ=
X-Google-Smtp-Source: AGHT+IFciEBLS4iN5e+dIN+b1F8xRtIGqt1PZmMH9hBrNsSxSMb+pejAPgsXDypDnTmgbPfKY/XWYH46ajlK8RI/FzQ=
X-Received: by 2002:a05:690c:600a:b0:786:7a54:460c with SMTP id
 00721157ae682-78c0bfd305cmr51703397b3.11.1764849314670; Thu, 04 Dec 2025
 03:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
 <20251203110108.1d93975d@kmaincent-XPS-13-7390>
 <CAC_iWjJ0PFXABOkwPSSdjRuFSPUF79fVCWNRvU5s1PLCuV5ydQ@mail.gmail.com>
 <CA+DkFDbecwtJkX-7wHzQjhVbi-tpjzZVzc7N3kvhr5OtKivgWA@mail.gmail.com>
In-Reply-To: <CA+DkFDbecwtJkX-7wHzQjhVbi-tpjzZVzc7N3kvhr5OtKivgWA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Dec 2025 13:54:38 +0200
X-Gm-Features: AWmQ_bnFBObgXXPkdEz6pQwmMzUd08apOPjW9n9rbWAwxxxRlmmEjKVqAAedGEE
Message-ID: <CAC_iWj+EWm8tnG5=Aqk=iZRnpr7rREV6a8okzSuJ4h=-8OmaHA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add support for fwumdata
To: Patryk <pbiel7@gmail.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 E Shattow <e@freeshell.de>, 
 Raymond Mao <raymondmaoca@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <ziyao@disroot.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>
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

Hi Patryk,

On Wed, 3 Dec 2025 at 16:04, Patryk <pbiel7@gmail.com> wrote:
>
> Hi Ilias,
>
> > > > Add a new fwumdata tool to allows users to read, display, and modify FWU
> > > > (Firmware Update) metadata from Linux userspace. It provides functionality
> > > > similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> > > > metadata, change active/previous bank indices, modify bank states, and set
> > > > image acceptance flags. Configuration is done via fwumdata.config file.
> > > >
> > > > Made a few change to mkfwumdata tool along the way.
> > >
> > > Still wondering about the choice of putting this fwumdata tool in U-Boot
> > > instead of TF-A. TF-A is the boot part that manages the update process and
> > > rollback through the FWU metadata,
> > > therefore, this is where it should belong.
> > > Why, in the first place, mkfwumdata was accepted into U-boot instead of TF-A?
> >
> > The actual update happens via capsule updates only, which runs in
> > BL33. TF-A needs to be aware in case it's involved in the boot process
> > and fails to boot. In that case BL2 is responsible for booting via the
> > other bank.
> > But generally speaking it's U-Boot that processes and usually updates that file
>
> If I may add something - actually for me this is not that obvious,
> e.g. on our platform we update the metadata directly from Linux, not
> from the u-boot capsule. As far as I'm aware, the ST, in their
> OpenstLinux does the same.
> I'm also not sure why it would be the bad
> idea to do this from Linux. Ofc the BL2 handles bank selection as well
> as rollback in case of boot failure on a newly selected bank.
>

The whole point of the spec, is to be able to have A/B support via EFI
interfaces. There's also an indication in the ESRT table, that an
update is pending for approval.
But if the data lives in a file in the non-secure world you can
technically update it from linux.

Thanks
/Ilias
> Best regards
> Patryk
