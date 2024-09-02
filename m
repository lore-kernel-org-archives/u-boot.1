Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D632ECD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 18:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291AF88C39;
	Mon,  2 Sep 2024 20:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lrsj2sRV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B2E88B49; Mon,  2 Sep 2024 20:21:10 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D208876E
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 20:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5334adf7249so5805025e87.3
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725301268; x=1725906068; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OihDL/OCI0wQIInOLdD4oFesvilFGYAaVv7EXbPsQdM=;
 b=lrsj2sRVsYeT0bmn4Hsh5X3rT94KA3DNkW/MLFXfqKF3qhDaNZvWL5x7FwYCsEK88M
 /xehGyHiAa94mM7xXLNF8tbbJs/CG7LPayLKbntTkihUDIiajbykhPg3SrOKdjgMoTx6
 QVj3CPCvNPdgRBJXTuwcLS2uQSvBvhhJz1dUL0bvpcX9osOfTDDWZkk+EuT4ehdmRF8I
 Ex82Gc3w71BQEYuijPY/igfhtaTPlJmpBJnbg4KceuJYBJo40MeZxxk3RpTwbMb6Oxsz
 IzYdLnw4a+UZY15mErNp1MxLH1s0RxFE2us7tcpMGWSYFQFu+xj1UeSZDdOPng+No0lh
 rmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725301268; x=1725906068;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OihDL/OCI0wQIInOLdD4oFesvilFGYAaVv7EXbPsQdM=;
 b=mvIrGoMf791ksD4skWTz0sdrljA2tWQBBoIkJpJnA/YP7qJQy6WddYuuHgg9cmNyLN
 0usW0Zw1HdZA9u4z7LVdQOx9vZKPD1Ky1K+zyoBPdwnD0SiD84H5CgifGBKVwxWQlF+Z
 iIKi4VZICeV74e4oZzO7CRIg/pKXMopwp1qNyby/qz4GwSLhtBNtRPguYGnkiJN8J5fR
 b+xM+MvI8G0GqwM/+CUmULUP/b0x3cLlMjdLMziaNIEYJeF89dN5YI7MZU85PybSIYnq
 gHFadV7c9gJvdYeBLrEAMgbOucT+QBLz/8UU6aviZ7kAvJ9jnCkoNpcNDC2laFa2iI+H
 sdzg==
X-Gm-Message-State: AOJu0YzRTeE0+EWQZhIm42z1Xv7agmlsWKF0Wx/L1QFfsYvht6L1fpkz
 22xqfVJLap+vO/6lIv6zGOG5I4r5gI0lIuNoSTKAY/UZGKFbw4ZzGYCnHD7SQixdjxbJwoJcMlS
 aX6R7JIpW2fd3DcnreTKF5AaQ1zlFcYPy
X-Google-Smtp-Source: AGHT+IHgJmjoO7oyCyVz3c4NXKQspvydbn6bHtouSX0DtobkzTeJYiF1SDaDU/AjAmgfevWMa+4jhBb/p0EOBdRQjs8=
X-Received: by 2002:a05:6512:318e:b0:52c:e170:9d38 with SMTP id
 2adb3069b0e04-53546b3f373mr8245142e87.31.1725301267329; Mon, 02 Sep 2024
 11:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <3fG.Zblj.WuvIm1nVob.1crVrB@seznam.cz>
 <CAOMZO5B=bCCApd-Pi5UwW_ckx5UjfZcAvfDtaSrV=j0bzskpHA@mail.gmail.com>
In-Reply-To: <CAOMZO5B=bCCApd-Pi5UwW_ckx5UjfZcAvfDtaSrV=j0bzskpHA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 2 Sep 2024 15:20:56 -0300
Message-ID: <CAOMZO5BkpNSAmq=wOo0KQmL=AL5=VcmGv+WNJopet2Di5NU17Q@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: mmc: Allow using partition name in mmc erase
 command
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

On Mon, Sep 2, 2024 at 3:12=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi Tomas,
>
> On Mon, Sep 2, 2024 at 3:06=E2=80=AFPM Tomas Paukrt <tomaspaukrt@email.cz=
> wrote:
> >
> > The mmc erase command currently requires blk# and cnt parameters
> > which can be obtained using the part start and part size commands
> > if the entire partition needs to be erased.
> >
> > Simplify the use of the mmc erase command by allowing the partition
> > name to be specified directly.

Your Signed-off-by tag is missing.

Please run ./scripts/checkpatch.pl 0001-yourpatch.patch to detect such issu=
es.
