Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F739C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 15:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF3D7826AD;
	Fri, 25 Apr 2025 17:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h7/OcaTT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7023882757; Fri, 25 Apr 2025 17:03:32 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BF182169
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 17:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-acae7e7587dso366594866b.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745593409; x=1746198209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M9w0wE45ea1S3gQiFwQvJJYIcSZYgQaiDR/HbIL1vDg=;
 b=h7/OcaTThtLwJNBqNPFJ1pY3txgJ7BdioTTrlpc5BYXysIefYxnHnhv2gQYbC9dQep
 7Bo0uJ7sq0SmTw4aeo5qRu5OcJmNwy3BMyqtKU4qYxyFrsiUmkRoQxVSrESju6zCOKSi
 oZcNoqfoF5hr4wMsdWRlg2h7W3fOIV77PsUuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745593409; x=1746198209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M9w0wE45ea1S3gQiFwQvJJYIcSZYgQaiDR/HbIL1vDg=;
 b=cn8eHgLBGDwp1w/ZkzlK1ZHS/5/jcrPgmKyZ37RIA3kzedhVGgTycLzzKFlMwo/m/I
 Q6CSdAH462eia15F77zlbFpgOOLLMZ2ZTYl+NNZyIEANqN5R325kw45fNg19ECOSYODV
 JVJvrTEYhDtzPmEBCUAzDTms34GH5AQDQ87WBAHXTP2DwAHg0jB0QVNmua21H8qcAxc/
 zSI25NP3hZ/W2mf7TBudeRQF7/SQ/at7/MuXbBQpxLlnEl24rMmgoTE9Ram5gtN6Fztn
 HTnHbnVpInjMpQZ9iIKmq1sQfRjexoBVPcjWWkFWjl4uo4VkBAX2EZV3yY8cZiuvt9X3
 +WEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkqrTC3uHq8Yi4ApH+mYm9CugI+W72x22P4oGDoaCir7W/ck0HLfX7PkG+yQ7SvsQj1XKBgCM=@lists.denx.de
X-Gm-Message-State: AOJu0YyKs31QA6j9i1CPd5umrbzYL2l6x3BCZ5IONyJhSgoTQHOhoV/t
 nDwbkxCttUn3Be/7S6YSORLoqkEPMrxmcxBNYyGmwY3q2+WSbbJlGKM4VpcMaGU7wHYq3a/eg2h
 0Gb3l4hO+z0l7/A7GClFTBIt5EDu8Kgbmh7JmErCOi7zv9J0=
X-Gm-Gg: ASbGncsCzyaN3dX7ITLRQGQKrb27lErgIzlkmVhX/CHmH87/i9KWmMv+DxGWLPwEqiV
 XnCt6+R3kQsMnGK0i3lYe4arSFz4m9minVqaPuVS9LBH1Wg7ev7lOHFEgX9SAN5n9O2hTVnMa4f
 QLpeYzG+uoj0VT6FZ3HNCqfMg=
X-Google-Smtp-Source: AGHT+IEP693H6B0nHmx70Sl7d6WeyUAq5byqdH0fMrBe1gk2aZnM0dD6uze1exy8De3sroyac0F0FqVxzZEl3hmwwPI=
X-Received: by 2002:a17:906:9fc6:b0:acb:5583:6fe0 with SMTP id
 a640c23a62f3a-ace71095745mr247114266b.15.1745593408805; Fri, 25 Apr 2025
 08:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <CAFLszTinU=6v+3OyaH0pp8snYm9BgfVrU_+35x2Az7fVs_CfYw@mail.gmail.com>
 <4aef8b9ffd41d4e36550806f4688fc18dbddc500.camel@phytec.de>
 <CAFLszTjPHBw-F0EkQJnT4TOsxdYzGH5EtRBaeRCoKGxQQ_cw4g@mail.gmail.com>
 <20250424184923.GM5495@bill-the-cat>
 <CAFLszThPcJjhBVLvz=EkdeEP1K948cC=LyZhBk_Upk3iSWXCig@mail.gmail.com>
 <20250425143752.GU5495@bill-the-cat>
In-Reply-To: <20250425143752.GU5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Apr 2025 09:03:17 -0600
X-Gm-Features: ATxdqUGHyCJRrQQbMhmH-uRMuYKYnKaS3H5_CeUJ9H0uicFINmIY0QvPG3saIbU
Message-ID: <CAFLszTiYCObeLy+HPnpXSE3yQ20ZN-+hptoi_nYT4DXimjHFYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
To: Tom Rini <trini@konsulko.com>
Cc: Martin Schwan <M.Schwan@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
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

On Fri, 25 Apr 2025 at 08:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Apr 25, 2025 at 08:35:52AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 24 Apr 2025 at 12:49, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Apr 24, 2025 at 12:31:38PM -0600, Simon Glass wrote:
> > > > Hi Martin,
> > > >
> > > > On Thu, 24 Apr 2025 at 06:43, Martin Schwan <M.Schwan@phytec.de> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > thanks for the review and sorry for my delayed reply.
> > > > >
> > > > > On Mon, 2025-04-14 at 05:32 -0600, Simon Glass wrote:
> > > > > > Hi Martin,
> > > > > >
> > > > > > On Wed, 29 Jan 2025 at 07:25, Martin Schwan <m.schwan@phytec.de>
> > > > > > wrote:
> > > > > > >
> > > > > > > Add a bootmeth driver which supports booting A/B system with RAUC
> > > > > > > as
> > > > > > > their update client.
> > > > > > >
> > > > > > > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> > > > > > > ---
> > > > > > >  boot/Kconfig         |  11 ++
> > > > > > >  boot/Makefile        |   1 +
> > > > > > >  boot/bootmeth_rauc.c | 408
> > > > > > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  3 files changed, 420 insertions(+)
> > > > > >
> > > > > > This looks fine to me. Just some nits below.
> > > > > >
> > > >
> > > > [..]
> > > >
> > > > > > > +
> > > > > > > +       partitions = env_get("rauc_partitions");
> > > > > > > +       if (!partitions)
> > > > > > > +               return log_msg_ret("env", -ENOENT);
> > > > > > > +       partitions_list = str_to_list(partitions);
> > > > > > > +
> > > > > > > +       slots = env_get("rauc_slots");
> > > > > > > +       if (!slots)
> > > > > > > +               return log_msg_ret("env", -ENOENT);
> > > > > > > +       slots_list = str_to_list(slots);
> > > > > > > +
> > > > > > > +       boot_order = env_get("BOOT_ORDER");
> > > > > >
> > > > > > Environment variables should be in lower case.
> > > > >
> > > > > Unfortunately, we are bound to the naming RAUC uses for these
> > > > > environment variables, which is upper case. See
> > > > > https://rauc.readthedocs.io/en/latest/integration.html#set-up-u-boot-boot-script-for-rauc
> > > >
> > > > Can't you change it, since you are introducing new support here?
> > > >
> > > > If not, then you could perhaps set the env variables to lowercase when
> > > > you find uppercase variables? I suppose that would require updating
> > > > the client to do the same thing too?
> > > >
> > > > It would be very confusing for a user to have upper-case variables for
> > > > some things.
> > >
> > > Simon, this is an unreasonable request. This is how RAUC has been
> > > working and deployed for years and years. It would be a nightmare trying
> > > to handle migration of existing deployments for an aesthetic change.
> >
> > Yes, I figured. Perhaps it could support lower case in future? This is
> > the first I have seen on RAUC in U-Boot, although I do see this file
> > which has both lower and upper case:
> >
> > include/env/phytec/rauc.env
>
> I don't think there's any need to complicate RAUC support here (nor
> in the future Mender nor swupdate nor any other long standing OTA
> mechanism that might be more easily integrated via bootstd than
> environment patching).

Let's see what the author says. I assume that U-Boot has its own code
in RAUC so it might not be too bad.

Regards,
Simon
