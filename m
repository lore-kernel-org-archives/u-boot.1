Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34A6CF8548
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 22:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81DBF890E4;
	Thu,  3 Oct 2024 00:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J19xjqtH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496DB890E4; Thu,  3 Oct 2024 00:55:56 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94AAA88F5B
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 00:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cb2f344dbbso2778736d6.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727909751; x=1728514551; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frBoE9ieFSCcLTkVs/ZEtO6YQJT0JU+DPASyBRSmeQI=;
 b=J19xjqtH9YPJSTOS5wTfdRsnTIjn9SQh4YNdfUOs3MF01gpl831//pxgDfAR2w31xn
 TDYQb+78okN09QrY0IexZRw8sAQwr48MwPWafOPVCP/pCy7Sryqqc6gc4ln4vGAWOEe+
 x3riv5DZcEhE4j5tW3B7/R5Y+jPX3dqGoTFD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727909751; x=1728514551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=frBoE9ieFSCcLTkVs/ZEtO6YQJT0JU+DPASyBRSmeQI=;
 b=O/C0Qjs5qKBl2O1b7Li0ZFO+E9No+dSZRKyutubJ4WsTGpvZAurSkGqS1rv/fr9/pf
 HcySEQzuFzCQVj3SXMg4R1/AIrWuWieAmFd1W8yO82fJOM5tvGbftSjUBrEo6PDLz6Qc
 o2KZdP0rHMUDFabdSK3R5qB0x4mLczwfOA1/zgH+8YixwwkbNaMX0eDlB54vSwUU0y8T
 QTl6Fo2FJ2aceRcr+4bl5Z8EQjeDZJXoUzDL0s4DrTyoOdFIdpuircD9Km54p7eBvECI
 TLrOD1VbOSxGqB0UnYDlTelS8vSrdMf8Yid4A6xv5FNTh4XEwAXQPayYeZ/kei+PXmzV
 Am3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbIsowqA6v7Sk9NfjnvpoLPHpF9ItLUZ55CD+8EW94LYYqKwZlfOcbijEqrSto+lrvwTGJOLM=@lists.denx.de
X-Gm-Message-State: AOJu0Yza02mM45KOeJPtQccNPM77M9PyrQwVtRRX24D6Jq0DeBuydCDA
 rmngnxa3XoK9EoyQ2UfEFTStxqBlG7IZCH91pnq9mze1hqIIYKbUCN6Lv8e4UDk2WolxTXiQrmw
 6pm8jDnip3Mq3MLVxPff07UkjfHNcaNiAWFt/
X-Google-Smtp-Source: AGHT+IHLUSMCTlGs0VnFBrcdRhbruItGW7Uobfg6RJewQTDEwe+Ijkhfst95E+Cy/OOihElqaONR1+aixYZKrnGE3eE=
X-Received: by 2002:a05:6214:490a:b0:6cb:2e94:3e24 with SMTP id
 6a1803df08f44-6cb819c8b43mr61611056d6.11.1727909751485; Wed, 02 Oct 2024
 15:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
 <20240611-misc-20240610-v2-3-028e82b0b620@cherry.de>
 <20241002-caption-saline-d00d342af087@thorsis.com>
 <cd12220e-a111-4576-87d1-e838f1c5998e@cherry.de>
 <b574fe29-3e3b-df51-6b09-af06303e11ac@gmail.com>
 <20241002155437.GP4737@bill-the-cat>
In-Reply-To: <20241002155437.GP4737@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:40 -0600
Message-ID: <CAFLszTiOnm8sX03zs0u1WZCKh0cUFZKwvD9TZRfUOQnuLcvkrg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dm: core: migrate debug() messages to use dm_warn
To: Tom Rini <trini@konsulko.com>
Cc: Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de, 
 Alexander Dahl <ada@thorsis.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Dario Binacchi <dariobin@libero.it>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Michal Simek <michal.simek@amd.com>
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

Hi,

On Wed, 2 Oct 2024 at 09:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 02, 2024 at 11:13:14AM -0400, Sean Anderson wrote:
> > On 10/2/24 05:25, Quentin Schulz wrote:
> > > Hi Alexander,
> > >
> > > On 10/2/24 10:37 AM, Alexander Dahl wrote:
> > > > Hello Quentin,
> > > >
> > > > sorry for being late to the party, but I just tested v2024.10-rc6 a=
nd
> > > > my console output looks like this now:
> > > >
> > > >      ofnode_read_bool: bootph-all: true
> > > >      ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: f=
alse
> > > >      ofnode_read_bool: bootph-some-ram: false
> > > >      ofnode_read_bool: bootph-pre-ram: false
> > > >      ofnode_read_bool: bootph-pre-sram: false
> > > >      ofnode_read_bool: u-boot,dm-pre-reloc: false
> > > >      ofnode_read_bool: u-boot,dm-pre-proper: false
> > > >      ofnode_read_bool: u-boot,dm-spl: false
> > > >      ofnode_read_bool: u-boot,dm-tpl: false
> > > >      ofnode_read_bool: u-boot,dm-vpl: false
> > > >      ofnode_read_bool: bootph-all: false
> > > >      ofnode_read_bool: bootph-some-ram: false
> > > >      ofnode_read_bool: bootph-pre-ram: false
> > > >      ofnode_read_bool: bootph-pre-sram: false
> > > >      ofnode_read_bool: u-boot,dm-pre-reloc: false
> > > >      ofnode_read_bool: u-boot,dm-pre-proper: false
> > > >      ofnode_read_bool: u-boot,dm-spl: false
> > > >      ofnode_read_bool: u-boot,dm-tpl: false
> > > >      ofnode_read_bool: u-boot,dm-vpl: false
> > > >      ofnode_read_bool: bootph-all: true
> > > >      ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: t=
rue
> > > >      ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: t=
rue
> > > >      ofnode_read_bool: bootph-all: true
> > > >      ofnode_read_bool: bootph-all: false
> > > >      =E2=80=A6
> > > >
> > > > This goes on for several screen pages, and clutters the usual outpu=
t.
> > > > I first thought I messed up CONFIG_LOGLEVEL or CONFIG_LOG, but no.
> > > > All I had done was setting CONFIG_DM_WARN =E2=80=A6
> > > >
> > > > Am Tue, Jun 11, 2024 at 03:04:26PM +0200 schrieb Quentin Schulz:
> > > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > >
> > > > > Prior to that, seeing the debug() messages required to enable DM_=
DEBUG
> > > > > which defines DEBUG (and then _DEBUG) which in turn makes failing
> > > > > assert() calls reset U-Boot which isn't necessarily what is desir=
ed.
> > > > >
> > > > > Instead, let's migrate to dm_warn which is using log_debug when u=
nset or
> > > > > log_warn when set.
> > > > >
> > > > > While at it, reword the DM_DEBUG symbol in Kconfig to explain wha=
t it
> > > > > now actually does.
> > > >
> > > > CONFIG_DM_WARN currently reads like this:
> > > >
> > > >      Enable this to see warnings related to driver model.
> > > >
> > > >      Warnings may help with debugging, such as when expected device=
s do
> > > >      not bind correctly. If the option is disabled, dm_warn() is co=
mpiled
> > > >      out - it will do nothing when called.
> > > >
> > > > Instead of just useful warnings, users get debug messages all over =
the
> > > > place now.  Is this actually intended behaviour?  Can this be fixed
> > > > before v2024.10 release please?
> > > >
> > >
> > > There are basically less than 3 working days left before v2024.10 is =
released and I'm inclined to say this is annoying rather than a bug, so I a=
m not entirely sure this will 1) make it in time if we agree on a fix (need=
s to include review process in those 3 working days) 2) be acceptable for a=
 late addition in the release cycle. Let's try though, maybe we can figure =
something out.
> >
> > This is a bug. Printing this many messages will have a major impact on =
boot times.
> >
> > A config going from "may print out a few more lines of extra info" to "=
firehose"
> > is very surprising to users (as evidenced by Alexander's email).
> >
> > If you can't figure out which lines to disable, I recommend simply reve=
rting the
> > patch.
>
> Checking this myself too, no platforms enable this by default. So I
> believe we do need to improve the situation here, but I don't think we
> need to revert this for release.

I think the problem is that the dm_warn() thing went a bit too far.

For example, ofnode_read_u8() should not warn unless something goes
wrong, but when it was log_debug() it would show everything.

So in that case, the first and last dm_warn() should change back to
log_debug(). The middle one should be expanded to show the node name
and (strictly speaking) it should only show the node name if _DEBUG is
0. Eek.

Not a release-blocker IMO, but it does suggest that adding a CI test
for DM_WARN would be useful. We have a few of these already, e.g.
'sandbox_noinst with LOAD_FIT_FULL test.py'

Regards,
Simon
