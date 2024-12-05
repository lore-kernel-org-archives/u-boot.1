Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA67E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2B638952C;
	Thu,  5 Dec 2024 20:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XV/+KVuc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31A28952C; Thu,  5 Dec 2024 20:55:18 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 996F989541
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso260859366b.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428516; x=1734033316; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XW0n/SB60v3gLw+dorwR/1zjPxvYzrLWrq/L0ztbi1g=;
 b=XV/+KVucHWLy1x/SaXPUHkQVodHKS+8SOFc2pR6Gs6amArGXMwE10p7zmWqjsi4lJ2
 yz2SEK8Zgw/QA1RZ3HDNNO+e74WJMj23EQMrPI9cVQSpzgELVsb/MFQ3kkLDh7j0CLcS
 9QaQxSMxgqOR6YLwex6tlJhxaKpm7eqm47RHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428516; x=1734033316;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XW0n/SB60v3gLw+dorwR/1zjPxvYzrLWrq/L0ztbi1g=;
 b=ZWhnUNFfMme+vFd2rb1crbBuA19UKXdQ6384IfMLE9sAnYtGFqjYYfkUy3jW81mHYO
 7FcSCI4EXFHFEJQBHowQMfnx5qgTUywX1Z0NRHFQG+DLIUh8bgpO06WGBWN4aaj+2e6m
 zpQFYv9sZa/k/YlKsNLaYj6kF1FyMKuCKAmKkAlpS6VWG4TQ7D2/7T4a2Uq6P0B7JiIL
 1uCrqYusEZ8vIM8/1w/yL6uRhWZBaHLMd7gJTAD0IVd4buLJlBIFfZVQPxRSFabYs/Wm
 jR44IJG+YfUumYMMd+uwIZXPF1gRDOsv3IfDa54ZAOaf54c1LZi2eDirW2QP+IFkVRXo
 uzFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQxcARD/Q5QOXIHjhtcx9t3sPh9BFnfULsafTKTeekWggCT8+gNrqoIgilWIxiNSHC0nSRp5w=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2Oedk4jgHio8tDg0QB4kBndZgF2khSfiYDqa+TFDizuRpXa/R
 t4nEQAC13GeXa3aZKbR70TDM0eSOieQ76S6g7KZmxETpNFvO78mqQ9V538qAv+2OLmRh8XqxQe4
 qWwmexZEl2cV7BDX2D0O5KbrfaEghOKJ7zBCC
X-Gm-Gg: ASbGncskV/P24rmCqg70NmIzdQqj+7/3TvxfIJeRSuFwZ8OOR8phe8d+WNG7wCNofM+
 TRZZvQbrCjJh+9Sgyy8BkaZfeVVJLl9Sx
X-Google-Smtp-Source: AGHT+IGngCIFeyYt/crnNlkn1DeRqjRGUXZ9v4GzOvHYds0fwrSK55HkOG+5vbXUeK31D1WZ6n4HUdQzDUQ8Duij0OY=
X-Received: by 2002:a17:906:328b:b0:aa5:3979:cb3d with SMTP id
 a640c23a62f3a-aa63a080181mr11487466b.26.1733428516061; Thu, 05 Dec 2024
 11:55:16 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 11:55:14 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTh8PCDM5P7TWPfSYnEcC4hNiQyP4HpyzLZermSNnt+e5w@mail.gmail.com>
References: <CAFLszTh8PCDM5P7TWPfSYnEcC4hNiQyP4HpyzLZermSNnt+e5w@mail.gmail.com>
 <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
 <20241202162239.GE2457179@bill-the-cat>
 <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
 <20241203005541.GP2457179@bill-the-cat>
 <CAFLszTi6koMMr0ggVLxKQK5LCBv+hCunewacBxDAZYH+rERGiw@mail.gmail.com>
 <20241203140133.GT2457179@bill-the-cat>
 <CAFLszThLAYQfMxE_fVuTYX57vNBfi0PyvBzuUGCw0_1EsXk7ag@mail.gmail.com>
 <20241203160131.GW2457179@bill-the-cat>
 <CAFLszTgx6BacGQyiMOoCzYDM3vsOBgfr2XbzBEsNOZ_Gzj3=ig@mail.gmail.com>
 <20241203165132.GY2457179@bill-the-cat>
 <CAFLszTiEk64zKzVEK06diR8=expsWWqxjV_Jx8FQ+RwpiSBjsg@mail.gmail.com>
Date: Thu, 5 Dec 2024 11:55:14 -0800
X-Google-Sender-Auth: YQd2U0bbn668kg6SK9Ee0fmgV7k
Message-ID: <CAFLszTigBn4Z_EbWSS_6hODdB3KFoJWwd26HV0wqV5j5uKFyeQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, 3 Dec 2024 at 12:45, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 3 Dec 2024 at 09:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 03, 2024 at 09:37:34AM -0700, Simon Glass wrote:
> >
> > > Hi Tom,
> > >
> > > If you like, you can apply the reverts first, since they break boards.
> > > That should not be controversial, particularly as I explained at the
> > > time that this was likely to cause problems.
> > >
> > > Then you can leave the discussion on OF_BLOBLIST open.
> > >
> > > Just a thought.
> >
> > Absolutely not. Again, 70fe23859437ffe4efe0793423937d8b78ebf9d6 says:
> > "Standard passage provides for a bloblist to be passed from one firmware
> > phase to the next. That can be used to pass the devicetree along as well.
> > Add an option to support this.
> >
> > Tests for this will be added as part of the Universal Payload work."
> >
> > And your new patch says exactly the same thing, but then:
> > "Note: This is the correct way to deal with bloblist, since it allows
> > boards to choose whether they want to use the devicetree from there, or
> > not." and a large number of patchwork links. And after squashing the
> > three commits together to see what's being changed, yes, you're
> > rewriting a whole bunch of the logic without any explanation of why. It
> > seems to fix 3 Chromebooks and isn't tested on anything else. This is
> > why I'm saying it's unreviewable.
> >
> > So no, at the moment I'm inclined to wait for further reports of
> > problems, and we're coming up on a year since 70fe23859437 was merged,
> > before making any sort of last-minute change here.
>
> OK, thanks for confirming that.

We could of course imply OF_BLOBLIST which would still allow my boards
to work, by disabling it.

The opposition to this patch is mystifying to me, particularly as it
seems like a clear mess-up.

I'll apply this to my tree for now. It is certainly correct.

Regards,
Simon

Applied to ci/master, thanks!
