Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C539C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 20:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D110805E9;
	Mon, 13 Jan 2025 21:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kpnanS1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D879D8060C; Mon, 13 Jan 2025 21:09:30 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5970A805DA
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 21:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so6268158a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 12:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736798968; x=1737403768; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CSRxU/i4NKdTqkRMQCd9BDlgsMJV5N0og1HwALTYdsQ=;
 b=kpnanS1YqZGjvC3hbh0CvKs3SRUb72iVAKe1b8t5NEfclgwW+sNCNLgd4o5T8MA0bJ
 /48Cu7LaFb0T7sStmsfnoV767FadfALxANvE2OCgl6CxLVQqmSZLV6rA7tuVUfOubXMC
 A7PUMH9FRjwmlz4nl3IGdoqMkymgN65fuFt+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798968; x=1737403768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CSRxU/i4NKdTqkRMQCd9BDlgsMJV5N0og1HwALTYdsQ=;
 b=aM2rxjg2cVuA3remyh7eyvfDcd4KXqLGKXSw0bO5sjXDS0kAIKpseTQi6fgWEsZSrj
 EDXkyVMk/hDE7CoyDsukeItvQiJI7Ux7At16NLQ83aRfA3NqWkofQjyvnkf+fBnyfSzW
 niacflt6fECc77T4YRmelzdwV3sSzgHgY+Xkf1bjmTHP6ry8q6KlCSBYBHtDBOkBBwbC
 dFCl/JLoqnHzcN6Nz6a0DccErlh4EMOio19IeAu469LJQFU95vib3CcpTtilBi8k65f6
 JuUuzBNtG5bNDbKeflZfuujJ8GLP+0SnSfPbub6RruP/VU4fc/QcQcY2GlqcytVA1abH
 kanw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRpg4avaACXMkM3pmXRZOiNem7xk+2lQx6VFNXrXoJCVaNag0Z0DkfjS12up2cHIUuBn/DdtM=@lists.denx.de
X-Gm-Message-State: AOJu0YxvqitONRFJo449+HArLYYb8Xpr4+FI53R0vCoEJKY2ZgAZlasB
 ost/kALDl+HxSVDMwu6UFhseZmypX/pbXoe/mZxFG5II8xjt9Cyw0lH8HkzQZd2FwkWukVL7Vmj
 lw0aOQvZSehZ4Qap+Rbtc3ysh2gLdpmXBq4nt
X-Gm-Gg: ASbGnctd9MFCnBkBBn4c1dszYk8nuMd5GUoTHQYuF7WEprbuLUOK6Pua7qmBZkw4khL
 0X8YRJZyfULbnbOjuTqon9I7SrMyO4U47yi/tkso=
X-Google-Smtp-Source: AGHT+IHfRwbEUKoXaAGMLBzU1+1+jngTDBDH0FoEQ+q/y7KEW4aZO6F0zInAMJCs8+oCofEwGovZvzjB+GVW4pp3T7Q=
X-Received: by 2002:a17:907:7ea2:b0:aa6:a732:2123 with SMTP id
 a640c23a62f3a-ab2abde54demr1702261566b.54.1736798967697; Mon, 13 Jan 2025
 12:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
 <20250110224554.GA2278614@bill-the-cat>
 <CAM=mAOmee=By9ErZrvk0hVbZyLH_viguu_wMfOsV3LzTwddArw@mail.gmail.com>
 <20250113015108.GT3476@bill-the-cat>
 <CAFLszTh7S=jmezZNwg=b+96+6ravY41iRbgJ_ssJ48nx4d=0QA@mail.gmail.com>
 <20250113192352.GZ3476@bill-the-cat>
In-Reply-To: <20250113192352.GZ3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jan 2025 13:09:16 -0700
X-Gm-Features: AbW1kvbqvyx4B7R8zX7Ob_MtYBQn7cLFGD73bqrmwda3IcqhfH_iEV_yiJcyyGA
Message-ID: <CAFLszTht-DdniDnZDgMsf7F5oK3X19ahjcNsM6u1-sN-D_8kdQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] cmd: bootmenu: add parameter -e for UEFI boot
 options
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Mon, 13 Jan 2025 at 12:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 13, 2025 at 12:01:45PM -0700, Simon Glass wrote:
> > Hi,
> >
> > On Sun, 12 Jan 2025 at 18:51, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Jan 12, 2025 at 08:08:13PM +0100, Heinrich Schuchardt wrote:
> > > > Tom Rini <trini@konsulko.com> schrieb am Fr., 10. Jan. 2025, 23:46:
> > > >
> > > > > On Wed, Nov 27, 2024 at 08:06:30AM +0100, Heinrich Schuchardt wrote:
> > > > >
> > > > > > The bootmenu command can display
> > > > > >
> > > > > > * menu entries defined by environment variables
> > > > > > * menu entries defined by UEFI boot options
> > > > > >
> > > > > > Not in all cases showing the UEFI boot options is desired.
> > > > > > Provide a new parameter '-e' to select the display of UEFI boot options.
> > > > > >
> > > > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > >
> > > > > Very strangely, this leads to the EFI selftest "Executing 'random number
> > > > > generator'" test failing on Pi 4, where was was passing previously (and
> > > > > Pi 4 has an RNG, unlike Pi 3), and this is
> > > >
> > > > Do you have a link to the log?
> > >
> > > Here's the failing part:
> > > Setting up 'random number generator'
> > > ESC[0;37;40mESC[1;32;40mSetting up 'random number generator' succeeded
> > > ESC[0;37;40mESC[1;34;40m
> > > Executing 'random number generator'
> > > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest_rng.c(52):
> > > ERROR: ESC[0;37;40mESC[1;31;40mRandom number generator protocol not
> > > available
> > > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest.c(114):
> > > ERROR: ESC[0;37;40mESC[1;31;40mExecuting 'random number generator'
> > > failed
> > > ESC[0;37;40mESC[1;34;40m
> >
> > This might help make the log more intelligible.
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20240811145209.4191404-37-sjg@chromium.org/
>
> Shrug, it's the age old problem of sending raw stdout to a file. It
> looks fine on console as it happens, I was just grabbing from an
> existing log.

Oh well. I would probably suggest only writing this junk to log files
if we actually need it in there (i.e. something is programmatically
checking), but it seems like this is a different situation from the
one my patch fixes.

Regards,
Simon
