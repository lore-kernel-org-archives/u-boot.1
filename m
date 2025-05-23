Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25A2C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 21:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F168E8338C;
	Fri, 23 May 2025 23:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="INMLvDyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80624833CA; Fri, 23 May 2025 22:23:29 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 789408334D
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-602e5dd500fso90601a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748031807; x=1748636607; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=avrAIpzMbKaQGV0QGfLDjMQhwkFkjSs/cwLjbGQgo8E=;
 b=INMLvDyOgC/79eEfb633ocM71FUNhux+cm6vHP5C2XxcTXYngPv48bJHZBX6FTheK3
 fmwZCQlq4hI8VZo/YyKeBC4+asrXCFgvw+0Lz0szeFt0DUzNXsvYoClByRKxQmbtgxqB
 9rqrba64Py5ba9zh9mJIaOPBkmNPVWCa3lDs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748031807; x=1748636607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avrAIpzMbKaQGV0QGfLDjMQhwkFkjSs/cwLjbGQgo8E=;
 b=v7rbiiohr2zPHZJzUFQCw9tx/hE6nQGAHrADhE/AWQ+TESBihnlDBeiWgeWYq/60W/
 OwnLMuE1K+BLd+1ynQj3mpH426FRz02zN4K5gx3W0Pxy2zwoYnNnz5M0a4WxXD6Y7+y0
 J4xpIbXLgwkD6zXq0uJnsOP/wDX/g9IReR7ohJs6qN5ByLzmQCeuydO5uDzlvMsMOwJL
 SGSKKP9sSVPKPfj+ATrtGXY6Z6FwbocB795wmnzSjOMu9zBYfyvcxBivQqSsuxDCjhPj
 Zq4o9girkPO8799WYfLMYCk/wOkvurL+9vGIfkEbb3ATdWcYofCoRPMZtbXm9ziMHXIu
 +wrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAQJ2j6O6a0dPf3loXNqcTytN7uKCu+zqjqZVo9Yz6U8s060xIGnY4Ao4HYUmkQ8YMCRBsZQk=@lists.denx.de
X-Gm-Message-State: AOJu0YxPwVZs6yswZ+C4Z3AK8VeGTUdZ2rupKMMTvRnTCBodMh1S2xvu
 6pTH9ye+T4XRS+kD5nJ+mGEv7g/VRIu4G7o5EeWOm4+M15IUC9pUP+T5o8mieEwOkCETO5dhQgE
 KSiNzLxd8pPEQYndobYwaId/vaOfvXuPmUb5QRZ03
X-Gm-Gg: ASbGnctdy8R3uz86BBj+g9c7G3yj/XCsJI7ZLYniegtECNYw49frYilfHEQNEz5SqL2
 z/pXG//LaGGqa4cMnfLf6E1WqD3Ocpql/3SIHO2tG2BwnNP8ZK3G7k+Q6iFE9j3p7W63jaHSC/7
 HS/epqva9YiYnQWDmtXg2SqTbTnBHJv5g=
X-Google-Smtp-Source: AGHT+IGirqFSV8dIb544Cy7H3v1asdNzQD0Le4ipAKT1pHJnUP0sSJIOnFW4PyzbqP866rVusBIUayoSDkK4ZaoVmi0=
X-Received: by 2002:a17:907:7ea8:b0:ad2:4736:9c07 with SMTP id
 a640c23a62f3a-ad85b12ff10mr50739866b.2.1748031806755; Fri, 23 May 2025
 13:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250523130651.1329593-1-sjg@chromium.org>
 <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
 <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
 <20250523164909.GV100073@bill-the-cat>
 <8734cv45fr.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <8734cv45fr.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 21:23:15 +0100
X-Gm-Features: AX0GCFvmB0_VSFCfL-cL7Qh2StE9jxKicO8URVLoMmYyzu3j2dwaliUHQsgfTtA
Message-ID: <CAFLszTgiPDQxESZ763G6AmZNSriB1W-OSGEEAtcn769oHep-EQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Tom Rini <trini@konsulko.com>, xypron.glpk@gmx.de, adrianox@gmail.com, 
 bmeng.cn@gmail.com, caleb.connolly@linaro.org, christian@kohlschutter.com, 
 daniel@makrotopia.org, ddrokosov@salutedevices.com, eajames@linux.ibm.com, 
 francesco.dolcini@toradex.com, hiago.franco@toradex.com, 
 ilias.apalodimas@linaro.org, jdanisevskis@aurora.tech, j@jannau.net, 
 jeremy.compostella@intel.com, jerome.forissier@linaro.org, 
 maks.mishinfz@gmail.com, marek.vasut+renesas@mailbox.org, marex@denx.de, 
 mgarrett@aurora.tech, mkorpershoek@baylibre.com, michal.simek@amd.com, 
 moritzf@google.com, Oliver.Gaskell@analog.com, patrick.delaunay@foss.st.com, 
 patrick.rudolph@9elements.com, pkochanowski@sii.pl, pbrobinson@gmail.com, 
 philippe.reynes@softathome.com, quentin.schulz@cherry.de, 
 raymond.mao@linaro.org, semen.protsenko@linaro.org, 
 sebastian.reichel@collabora.com, sughosh.ganu@linaro.org, 
 tharvey@gateworks.com, vincent.stehle@arm.com, weijie.gao@mediatek.com, 
 ziyao@disroot.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 23 May 2025 23:22:13 +0200
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

Hi Mark, Tom,

On Fri, 23 May 2025 at 18:12, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > Date: Fri, 23 May 2025 10:49:09 -0600
> > From: Tom Rini <trini@konsulko.com>
> >
> > On Fri, May 23, 2025 at 05:36:52PM +0100, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Fri, May 23, 2025, 15:19 Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 23.05.25 15:06, Simon Glass wrote:
> > > > > Some functions provided in lib/efi_loader are actually useful for the
> > > > > app as well. This series refactors the Kconfig and directories a little
> > > > > so that code is easier to share.
> > > > >
> > > > > As a starting point, it moves some filename and device-path functions to
> > > > > the new directory.
> > > > >
> > > > > The next step would be to move device-path code over, but this will need
> > > > > some discussion.
> > > >
> > > > Hello Simon,
> > > >
> > > > Overall the ideas in this series look fine to me. But this series does
> > > > not apply to origin/next.
> > > >
> > > > Applying: efi_loader: Separate device path into its own header
> > > > Patch failed at 0001 efi_loader: Separate device path into its own header
> > > > error: patch failed: cmd/efidebug.c:8
> > > > error: cmd/efidebug.c: patch does not apply
> > > > error: patch failed: include/efi_loader.h:967
> > > > error: include/efi_loader.h: patch does not apply
> > > > error: patch failed: lib/efi_loader/efi_bootmgr.c:12
> > > > error: lib/efi_loader/efi_bootmgr.c: patch does not apply
> > > > error: patch failed: lib/efi_loader/efi_device_path.c:10
> > > > error: lib/efi_loader/efi_device_path.c: patch does not apply
> > > > error: patch failed: lib/efi_loader/efi_helper.c:6
> > > > error: lib/efi_loader/efi_helper.c: patch does not apply
> > > >
> > > > Please, resend the series based on origin/next.
> > > >
> > > > Patches that are not based on upstream U-Boot cannot be reviewed via
> > > > this mailing list.
> > >
> > > The app is quite behind in Tom's tree due to rejected series.
> >
> > It was not "Rejected", it was "Changes Requested", please stop
> > mis-representing things.
> >
> > > In fact
> > > the app is pretty limited on x86 and there is no Arm app at all.
> > >
> > > My current plan is to move forward and eventually Tom might take it
> > > via a pull request.
> > >
> > > Do you have any other ideas?
> > >
> > > Perhaps this is something we could put on the agenda for a future call.
> >
> > There's nothing to discuss in a future call as step one is "post patches
> > against mainline".
>
> I agree with Tom here.  I did look at some of the patches in this
> series and now that I've learnt it doesn't even apply on top of
> mainline it feels like I've wasted my time.

There is a base commit in the cover letter, so you could look at that
if you like.

I plan to apply this series at some point, so any review is not a
waste of time. I do respond to review feedback.

Regards,
Simon
