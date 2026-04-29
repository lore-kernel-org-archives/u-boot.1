Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08CCFF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 849018489E;
	Wed, 29 Apr 2026 16:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eJqg3SLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56AE4848A1; Wed, 29 Apr 2026 16:21:37 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 299B48488A
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-676fec7e946so11389988a12.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472494; cv=none;
 d=google.com; s=arc-20240605;
 b=Ei+w8+jvDYyy+Xp7ohv3UlBsg0u4ur1EPCyg7xZbnFkfsD2QsI2CKS9/nMGAOwefGI
 imRq7/pdJ1t9vssV3cvvjjuV96Z4BHRSg1SStpjwSwR6R4otuNK/K/FRhfOClmp1/mGJ
 0Q2pQ9kcvXU/50FqYIuklGaj2xRicsWtDRhL0iPrluCNSyiIlA5XgKCe8bPaoRtg/abD
 OWQQzN7tsvfB2qDwOrbGMNu+SduQsA9LZ32YQKLdQNm4fcyHKu4a6GF2w3U699t6FVr2
 Ohtd6FjjcxLCtgQNZfyBw8jXbblksiIMP+Kl5I17wuUc4yAwbjswznh0djLF+eoHcUN1
 RyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/Bvs9MqhN+hvS5dQXwIW1MGj+bxbuAP0eH7f0sr21I0=;
 fh=SPi/X0WlztfyTm38DRlSkfy/6oW86yZLUHiv9TSsvno=;
 b=Ki61DH6FvjQtanBH1cxMHfqJ89uvyVNTXRwMDDRngF1ph130sJerPwgXTTuP4cyx7j
 ptZqNWIKsR6U42u1I5brJj3+nnZkLy0D+CEauedmH50luA/nPWuoQeAWzMR06HWIeifT
 6bWLvAu7bORW0W/5RhL9E6vYqLCiyJxoKRCtGMtsqwrty+RF77W9qDgQtKYBC712qIgv
 QPXmnsyeKiEWHAD/rP2RRkJYkbADxLtlF0y0UzX3gtfEuov4T+QnvFlSNir/OFLBUt36
 QeEbnXjbsxSMNXr5+/X7C26yKY6QQv1Y1fDiAWkfIJm91CaQWiUmhGiGqLmO9QI2WR7t
 HwZA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472494; x=1778077294; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Bvs9MqhN+hvS5dQXwIW1MGj+bxbuAP0eH7f0sr21I0=;
 b=eJqg3SLhHazdU2D7Omx3Y/TqNWZ9P9xn0BAkHGsgX1+M32dzVKf+eVorvmqAP1DZJO
 /XoDl/l0NwW1WO5AuGwg0V5WadPP2w2EW4+p4ma+naEQsYHGaLtffjg0UM/DFXTfLhMD
 IXxtOqBrH/k0UpW4x0eLVYcDXoalWya8EvJ8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472494; x=1778077294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Bvs9MqhN+hvS5dQXwIW1MGj+bxbuAP0eH7f0sr21I0=;
 b=JTQfUzfmnf9H9CbzSCJ/sDT9yXsMAGglTOPLn2IeIQAkaThcGywt2mf7Lq2Vg3ejgH
 AY0V3yfjwHabWwPw4iV6KNjwVIxqIFeFjNP0FNM/bscvUTDzyrv8nc2y6HBSgYlW7lk/
 v5n0zjx8VODEqzBCBbK9AesNwc8SBAJQbOa/JnfyNLdqhWf/ZuSe1k5F5j4Vz7NvsEPj
 gjoZMMm1lqe0TYwPtUGDujxPUF2ehKeTPt5/jgYKAJ4REGCwO6U80kr4147rtMedHqEk
 /1urCijNf55fjE9fq0Avj+yoRDQM1BZLHzQQONECbPQgWVtWLClPVYTf6m1BVmXER5U2
 o7Tg==
X-Gm-Message-State: AOJu0YzFfSZDiZsREq8GGzXJOs5xeyw3x6kwJr6j7NN+sIdIpIPC7oqp
 9Zv5tnKFpVUELiIRC9BSGsZbNNeZLCo9NI2l4y+hUuMDW+8HMQRO053ka4PLgRqaxkh7MXmr652
 YFps7bkI4uq4zp+2j9cfIn4xbCFjyNAf2N9+5voW7
X-Gm-Gg: AeBDietew/h7YPMSc5AMmH6ki0jbZKYVP193UZFa7OLvYaNYPOYryjIqoJhRS+aUebX
 RcYo+bRkQQ3QbnbHSpL5MJ6MQmIP0qDJglpMHOE9Ghs3DBwg/J46wTIzUlkhm2SlHMQaan63fI5
 C5pEbbz5g/06oPsw3aLDrjHroQXav5t2NSiHxvmqRAejc0jv+baUs5PfX+NwOrKHwFyQ20/XcUc
 7UgZZblQWqmELyZmdlWi26pbqFW5gXdwYprrY6ZXTwzg4vtiWlMk6Onxk3fyd+MLksjqzDpAW+Q
 gdeDZGo5tNFLBjuGTL0E90D0d4s=
X-Received: by 2002:a17:906:8d8d:b0:ba7:ade5:8605 with SMTP id
 a640c23a62f3a-bb93c79d3d7mr267025966b.6.1777472494622; Wed, 29 Apr 2026
 07:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260423042824.3480-1-briansune@gmail.com>
 <CAFLszThg=EamyRohxNA7V+nk+OMVK356nUjAVSbu4+kokOJpdA@mail.gmail.com>
 <CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHAhdmY3Q@mail.gmail.com>
In-Reply-To: <CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHAhdmY3Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:21:20 -0600
X-Gm-Features: AVHnY4Ji7F69Qz_bZOicfSX8lSx6mTBLQVtpP8kOYiTuc4a1Ujqf7RHk197sJiE
Message-ID: <CAFLszTgouk66AOaL2o8PvH9EKNFabE=pjxpa9QpC_F--VhE9cQ@mail.gmail.com>
Subject: Re: [PATCH v6] Improve handoff prepare on SoCFPGA
To: Sune Brian <briansune@gmail.com>
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

Hi Brian,

On Tue, 28 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wrote:
>
> On Tue, Apr 28, 2026 at 10:04=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Brian,
> >
> > On 2026-04-23T04:28:24, Sune Brian <briansune@gmail.com> wrote:
> > > Improve handoff prepare on SoCFPGA
> > >
> > > Ensure qts folder header files are properly updated by isolating
> > > the Python execution environment. This prevents partial or failed
> > > script runs from corrupting the target directory.
> > >
> > > Changelog v5 -> v6:
> > >  - Clean HANDOFF_KEEP comments.
> > >
> > > Changelog v4 -> v5:
> > >  - Change HANDOFF_KEEP condition to if [ '$${HANDOFF_KEEP:-0}' !=3D '=
0' ]
> > >  - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
> > >
> > > Changes:
> > >  - Implement a temp folder for Python script execution.
> > >  - Clean temp folder automatically despite execution failures.
> > >  - Gate the file replacement process on the successful exit of
> > >    the Python scripts.
> > >  - Execute the replacement (with or without keep) only upon script
> > >    success via the NEW HANDOFF_KEEP=3Dxxx variable.
> > > [...]
> > >
> > > arch/arm/mach-socfpga/config.mk | 39 ++++++++++++++++++++++++++++++++=
++++---
> > >  1 file changed, 36 insertions(+), 3 deletions(-)
> >
>
>
> Dear Simon,
>
> B.C. the server is down and I don't expect Google to have an auto fail
> mailing recovery.
>
> > I see 6 copies of this v6 patch in patchwork, so I wonder if I got the
> > right one?
>
> I will try to respond to this email as politely as possible.
> Please reference from "patchwork.ozlabs.org" list.
>
> > The per-version changelogs belong below the '---' separator, not in
> > the commit body. Also U-Boot convention is 'Changes in vN:' rather
> > than 'Changelog vN -> vN+1:'.
> >
> > You could try using 'patman' which will get this right for you automati=
cally:
> >
> > https://docs.u-boot.org/en/latest/develop/patman.html
> >
>
> 1) I only do basic software
> 2) I used ./script/checkpatch.pl There are no errors, warnings etc.
> 3) There is nothing to do with the patch itself either the software
> nor the file itself.
> 4) I am not too familiar with patman
> 5) There are many better things to do rather than complaining about
> the patch headers.
>
> So forgive me I really don't give a damn on whatever the header requireme=
nts.
> If you feel this is not passing the patch standard simply reject or
> label all patches to
> "Changes Requested".

That's up to whoever applies this patch. I am just a reviewer :-)

The reason for the formatting rules is mostly so that maintainers can
apply them without manually redoing the patch, etc.

There is also this which might help (although you might not want more readi=
ng):

https://docs.u-boot.org/en/latest/develop/sending_patches.html#commit-messa=
ge-conventions

Regards,
Simon
