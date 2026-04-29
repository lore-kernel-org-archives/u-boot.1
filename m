Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693CAFF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:34:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E073984894;
	Wed, 29 Apr 2026 16:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ffsVfPTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B9184897; Wed, 29 Apr 2026 16:34:22 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D694384876
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7de4ebe10cbso5311434a34.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777473258; cv=none;
 d=google.com; s=arc-20240605;
 b=ftQSp9BwVm20Mi2CfdctLZv3n51FQ7chxoIokhfI6RSfakBjBLhhCZbaAwVzyxxElh
 4zGNwFm1sdDr9TNtu4NntiXK/qVUJWLW2wxA0yVyK5oQmzLaVpjutmz8M0WF0glKxFHu
 7b74hWc6ybjqYSG2QW2P+cXgUQFp1yc/8v3kxXNlxvdEuSR10PHfqMTcWksRS8BDFykz
 m0jcUILp+QCr9Li+qpPCVEVq2/jPCyhfeSAEI8/zDaD4YskImv820tZvsBTVMPpKN0cu
 iepVvng8nGvw2BU0AQe8DmYevCV1sMmHeYNVNYockLIyaqzmHKkn93HWtK2G5V4+tNZn
 21/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w9GP99m2AvdomvtA2c3nwoTRrkv7V1v86S2Qnw6Lf4Y=;
 fh=hxgwr6lottpQV6gabjiqtX7m958ne43urJfyaoL4cZk=;
 b=Rsy5YDNe61WbNbcKGq0Kv6tXr/1sSAJY8CDz1L5+tjycjiu55bpk3oOFyqiVeOSJv+
 UtcOrzX99d1PchdsHnGwmMQzoH6VX4Wi4oj8lO7GceVxgiWY4bOgR2bl/ziQawLDDM5u
 xHCvuOsQG+uE2gPZi1liTmI1lZaR/zAbUmDDboJLVpgDn9iNHgsmta9QK3g1eShicCpR
 6GjJ8FiI71qUQj12a72oU3j10E3T6RJxT2t0GkZ/1QvnXkpN/Xs46X4gRQqW3VGiFl+H
 SJ6Hvy3QfwC0gECN4CcppmVFAoGeoad3Z2+ZoHu6D0qEug2LDRHCwVjyO2eLrlXwvxaq
 vQzg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777473258; x=1778078058; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9GP99m2AvdomvtA2c3nwoTRrkv7V1v86S2Qnw6Lf4Y=;
 b=ffsVfPTvkiAImieJIkGnhaoPXSprKzNm8FxmmfcJ/SiAw03GJW/O9KNTUxiza30ShR
 zAzn0PSB3rVMSmFu3bMkagS2hLvtcN9yr9yqnuRc7gK1TIrepWzzePmU+vptIQgOHQ4x
 yV0bqosyrTZxuQPscnkxSxnnPu6w1z8RdW6z0k+nJt67NfrHlzrOrl8ot0EHKn9828E/
 /uwL/M/dVQ/s+XB0pvXTyhXVWC4eHLTuf13nX/9rpd0Dx+1OJteSYjGt2nHmkgnqqcVx
 k1H+YW7eM+TxBwshPKEag5PsCHIjWFNzxmscTVEVpBpYzEydJeWSteM91YezKz3vwZ/M
 VtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473258; x=1778078058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w9GP99m2AvdomvtA2c3nwoTRrkv7V1v86S2Qnw6Lf4Y=;
 b=dAqelcppXR2rHe9tYU0PLR9aAWT4hadx1gW1eKBs+vzgvGa6t9JIECy0qr95Iu9RWg
 Ka2nKFIrfOCk2+yKipHa9wTHypWHOb4Vk/3IVeKZmyBLuqDOKOz+AH8h/xTXUgWrSkBK
 8U6XQyYLMsJbFEW8Dxvs+5d4gflEtOEgmIszkD83vK0Q40t/G4JsEQQ4RK7hnuW8rW5+
 kLW9Ht6V6vY79m6RFg3VRkBkfcWZCcilegORzdlFtp0hIexN+L9QO+RrXebEqBeZ0tY0
 2CFVES+4gm6TrkJ/iWiKI6DFYPBnwtfQUrEROYZ1lFH6ryC6atFwIptJmlX32EUDW/yq
 gNEQ==
X-Gm-Message-State: AOJu0YzcnbbP+WwjqEdcJvi5hFHMM3LuWGjiMSL8JXsO1KBCTCK6xnEn
 24Nd/WtJyY3oyvqeXUAkakSFmWSzlu2PPavXWT6VNAs+MPldX+5balx3yxTZogTRfN9tKlXSKlA
 aVj8kqvXy48JkjbSECJm6mS8eM9uY8QQA7bBdQVU=
X-Gm-Gg: AeBDiesGa6vnqTW69zqu7QmgU0GQJK1TcdCo8yQ2nB3eA/CcgA8O9mqpqibSrzIV6BW
 BWg+2LrKpK106nNj/VmIiDRFjObCkLGDpCcCvaPDQ78ijcED+/zfjCT5a0sXjC840HVLZuCdfbK
 LlwSs+DueY5f1tGsuQqY7+RfJcY3AxbDg1+FLeiYNdX9S50O3put3n/KA7zoDtNWahQKS+jby2F
 tQF6lYuJsfNqkGPRfe4/SyKoOjdQhfGwUw4x5Hbe7FbqqEsZNAaBgWHlrSsntE9zm4szKux2hZh
 bJARMGihq89Jby8N/NHWvFTh3uoL3w==
X-Received: by 2002:a05:6830:83bb:b0:7dc:5899:c711 with SMTP id
 46e09a7af769-7de99f7b0c9mr4825081a34.3.1777473258552; Wed, 29 Apr 2026
 07:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260423042824.3480-1-briansune@gmail.com>
 <CAFLszThg=EamyRohxNA7V+nk+OMVK356nUjAVSbu4+kokOJpdA@mail.gmail.com>
 <CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHAhdmY3Q@mail.gmail.com>
 <CAFLszTgouk66AOaL2o8PvH9EKNFabE=pjxpa9QpC_F--VhE9cQ@mail.gmail.com>
In-Reply-To: <CAFLszTgouk66AOaL2o8PvH9EKNFabE=pjxpa9QpC_F--VhE9cQ@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 29 Apr 2026 22:34:06 +0800
X-Gm-Features: AVHnY4LIgkb4LhrtGAocAN_acmgPUvELERPLLCHnpXAK_D0KhPeLQXy_FtUXlD0
Message-ID: <CAN7C2SC-MuqHK2+0vaZzZFi-up1L7=KcOSRedF6f6F3D9Uoceg@mail.gmail.com>
Subject: Re: [PATCH v6] Improve handoff prepare on SoCFPGA
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Chee Tien Fong <tien.fong.chee@altera.com>, 
 Tom Rini <trini@konsulko.com>
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

On Wed, Apr 29, 2026 at 10:21=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Brian,
>
> On Tue, 28 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wrote:
> >
> > On Tue, Apr 28, 2026 at 10:04=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > >
> > > Hi Brian,
> > >
> > > On 2026-04-23T04:28:24, Sune Brian <briansune@gmail.com> wrote:
> > > > Improve handoff prepare on SoCFPGA
> > > >
> > > > Ensure qts folder header files are properly updated by isolating
> > > > the Python execution environment. This prevents partial or failed
> > > > script runs from corrupting the target directory.
> > > >
> > > > Changelog v5 -> v6:
> > > >  - Clean HANDOFF_KEEP comments.
> > > >
> > > > Changelog v4 -> v5:
> > > >  - Change HANDOFF_KEEP condition to if [ '$${HANDOFF_KEEP:-0}' !=3D=
 '0' ]
> > > >  - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
> > > >
> > > > Changes:
> > > >  - Implement a temp folder for Python script execution.
> > > >  - Clean temp folder automatically despite execution failures.
> > > >  - Gate the file replacement process on the successful exit of
> > > >    the Python scripts.
> > > >  - Execute the replacement (with or without keep) only upon script
> > > >    success via the NEW HANDOFF_KEEP=3Dxxx variable.
> > > > [...]
> > > >
> > > > arch/arm/mach-socfpga/config.mk | 39 ++++++++++++++++++++++++++++++=
++++++---
> > > >  1 file changed, 36 insertions(+), 3 deletions(-)
> > >
> >
> >
> > Dear Simon,
> >
> > B.C. the server is down and I don't expect Google to have an auto fail
> > mailing recovery.
> >
> > > I see 6 copies of this v6 patch in patchwork, so I wonder if I got th=
e
> > > right one?
> >
> > I will try to respond to this email as politely as possible.
> > Please reference from "patchwork.ozlabs.org" list.
> >
> > > The per-version changelogs belong below the '---' separator, not in
> > > the commit body. Also U-Boot convention is 'Changes in vN:' rather
> > > than 'Changelog vN -> vN+1:'.
> > >
> > > You could try using 'patman' which will get this right for you automa=
tically:
> > >
> > > https://docs.u-boot.org/en/latest/develop/patman.html
> > >
> >
> > 1) I only do basic software
> > 2) I used ./script/checkpatch.pl There are no errors, warnings etc.
> > 3) There is nothing to do with the patch itself either the software
> > nor the file itself.
> > 4) I am not too familiar with patman
> > 5) There are many better things to do rather than complaining about
> > the patch headers.
> >
> > So forgive me I really don't give a damn on whatever the header require=
ments.
> > If you feel this is not passing the patch standard simply reject or
> > label all patches to
> > "Changes Requested".
>
> That's up to whoever applies this patch. I am just a reviewer :-)

Hi Simon,

I am going to ignore all your mail in the future.
So review whatever you like, don't care.
There are many patch not following whatever rules or guidelines you
mentioned.
Just review those as well. What a waste of time on your emails.

As politely as possible!!!
Brian

>
> The reason for the formatting rules is mostly so that maintainers can
> apply them without manually redoing the patch, etc.
>
> There is also this which might help (although you might not want more rea=
ding):
>
> https://docs.u-boot.org/en/latest/develop/sending_patches.html#commit-mes=
sage-conventions
>
> Regards,
> Simon
