Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE0360A2601
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ujli/NbS;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=OqjKwUIg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E33AF809C0;
	Fri, 30 Oct 2026 14:38:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cFpq3B3vY6iM; Fri, 30 Oct 2026 14:38:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0184580809
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793371116;
	b=rM2qZfy4vmASBeWKMc1iZHSiO2c7FdAvXaJrJyRqjCzbnWC2xK0dC1xmchQa+lqzhtyS
	 v3lY7IhwJgi19X35oXz50uUk6hdJs+AqxcLgJ00h0Y8DSp46UMGX/zlufvven4M21bN+K
	 CuurEWAQaGfx3pBolpusJIA9CbU0T+O8FKyWHWxyDCWdZsACG5O057LYZBTIMHweb+bdn
	 EjifZqEIr8Fai8hOJWQdhSqR8FNPzHROhGLG42V8mczdRjl+QU38qFFifzxnJjaaSbLYP
	 IZhCgLWVY8+vqRO0WU2WK+yNqEcrtkFfurC2++aK74DtoKByk6OlL+X4ncfol1Msffg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793371116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9wQR1Arpe5d+feFg2mA9m230DuUXE/sL011N4S/t9ns=;
	b=bploiuKHj4t4yjA1WVrOjn8Rq6C8dNiBBDg5XFxGnpyswWd6RIJz+9MOTTbuqtbO/y4X
	 gX1QGJ5LBlME3xgfnWUUh3e0aT3AgvVCNIWJng2Ca0IRAOTmVc34XB3itxQvtBcg27yGo
	 zW6QF9fC8Iy62GKf6wKNprG7wi9zMMchteeHigubyfeHC99Ug+bzNmBLloM7M5re9gwND
	 07l2o5MVkZChltr8gc+TZKEKuY/mY+s/SRA1wAWe9l8hpdEddN/syV+H1v0RaTT7IK85V
	 XDgDf1rpszRcF3FLkPZwFySv7xN2jhwzrkGi1dJarxYTMV4glifxEMqR/IH07FygztQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793371116;
	bh=9wQR1Arpe5d+feFg2mA9m230DuUXE/sL011N4S/t9ns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ujli/NbSIjkk0+0ZD4nhuc0nk7ryYD5IU+R8MxxjvPIAByJ/lbbxVyj+e49QPr1fd
	 9q3GqW1lTAd1gJIQZ7SmYVhzv9hb6xG6m1QWDrmH5eAbPC4AOYcXw3gg5IoF1WrP6M
	 aLtc+vEy4OAwZarU1oJt1VII4z9dSCr0AR6YRnABkgfekhtGbCVIE/BLIDyPvP8e8r
	 PvfDJJc+jPhCn2lGePHWB3rbSVYy6cIuBs5lEiBu5D0ufwqMyaFml4ChcO9EsCae7X
	 IYFPHVe9PZEyErFMIX4tZsA/kqYN/jByRhgul3bMiw0Hl2GJWWR/qWiSuz3CnpAJxu
	 hPiZWMyN8qSiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0184580809;
	Fri, 30 Oct 2026 14:38:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 584CCD38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49B4540A61
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEXTbHjoWnga for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:38:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 415014055E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793371112;
 b=iEhyWieZFZrtFu+MqvkELviJbajzQwHYSYNSs+sRj7iEcYlrZmrEpKpIJs3fyLa+AAQL
 XQ9aBN39lMh09YuVB9P57e1oQ5hT8/bNvF6dgMn1KOwr0TEo3Z55qOXcMoWQ0wXZTmRM5
 FOKr5/SSSL5wWBkpK88cAJTe5/WOZQDywkFVQF3Ed9XzaxqKx0U3fJzQMWfsaNDmnFnBW
 WEwXeYZRx7ny1HOTwzYgkBcSvMSzfpXkmMaJ5xSlEFX8KnVUsoUcoUaprCkd+aDy0g/vA
 A4FppkSgM3JpbqE8/58exhNqe+8ITIVhPoJ8YdSga/D2uJC4RJeoun9rCKtM7naLGxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793371112;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=9wQR1Arpe5d+feFg2mA9m230DuUXE/sL011N4S/t9ns=;
 b=rpLZf1cpqS7zvUwM1QmH1VD4mZpT0hKvY0NB09G2um6ABZ35beT+WHACYL3a720b1APU
 1Ea/iTHVxSrFYxe8/rK1QUd+N64wFpbx99NXlgtcqOZjbtBYRzQhebKUOLS8uJZ/Ocr0w
 XX/yOv9PpuI8mScuSNjbGueQ3F9klSOgxUX1hh0aMbDhcZxQN+0Igfa7eGA1kF0uRs4Z/
 9kE3+KWfw/Zta5fH7N4V2/825QvlXvyqoUik4aSk5C2tBVaXY9iWlhtP/w75yOgpowUnk
 wMEzIjgDZDTO1y7pzpFocofk2iRLJ1Ar8WT9Kx5ChpbJq9+yJfw2Rj3lnxZT7kL/gUw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=OqjKwUIg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=OqjKwUIg
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 415014055E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:38:31 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67999045530so700586d50.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793371110; cv=none;
 d=google.com; s=arc-20260327;
 b=pEoDFoJ4+Kfg0QS30PUNmCozdBZDmK2pyZQlGQH+vbY6ebxosPsigyp/vsQinAqHeP
 3IwXJCX/tGuVeEC+EtYhog7+dh3gljhtLZnpb5cf1GNx1RCwpvrN8NHTG140YgS3/8tG
 C5dbTBtGe6obpRQrNg1hwUAACES+ZssXEgCtTelud5EMlbfimLNyOvx+TkrqF+ZnabXi
 QcqUPhfLYoMZRT3GGVggf9ReNz/GOcs4/SojZZvBV071fb+i+squqX1zuXRvMJL6Qskx
 1kklcLiiQh1fBPRiqNbAabuDQLCDbHdAR+Hw02y/v96j52qGqXBi7Q92oYTVx2BFrEti
 Bvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9wQR1Arpe5d+feFg2mA9m230DuUXE/sL011N4S/t9ns=;
 fh=SrIiV4UmZI3o4VWxVwrqhea1tguixXrRCsxIOwHrSsI=;
 b=Ai+pZhzKJtrU/6VWrNa6DbZxALXZKpUI6Hc0n4JYHLDg8RnoI5uCwswVJZmzWHNRSI
 hgCMX7E+7Mfws2YiNFXpjSc761JV4d++JvvC03A0Rw97vnJs5UAGm8LthLHpOiBOwu40
 POsziWociIzbnEYqluB451Md72vPXoE6XsI0UIE4mIIeU9IiWOwLf6sSBGUB3/ldw4AJ
 17c47UKcyCYvcNN7GGJ+OmD1Zydb9tg5soHk3zdgP59qmWMVyZ/WcBWXKeDg84eRo8DN
 LweByqv4dH51j+HWhwl34GVeby2xSzDfNKlvYbwIc1SpjA2ZNM5QLsrjTZmJEl0Y+I4r
 YtWg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793371110; x=1793975910;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9wQR1Arpe5d+feFg2mA9m230DuUXE/sL011N4S/t9ns=;
 b=OqjKwUIgWZEUjBLufz7xuevQlN62wIDvGpM7jLqNkOegGi+ftk/i9ZccLrH0uV+0jG
 MyagWvJFay59jmhnXFHXngCVz7Sw7zz+rbClaPspQb8XylmTBScpBCGMkMMk1IssoEWx
 8ZNelWkuBK26FzMZGUBYj2OJC/A4OjLhRecQoxrldGj+nZWGPk9OHQDHUE+0d6XiLA51
 qcO4Lf5vJ5CbC1pfUkZEGx4IFKFc41BjUAYpTlEqy46iz1Zfsu1okqRIkisEZv1gKF72
 3PnVzmFz30XNH/mX/KOmVylzuwNwaPBftzfsqMi9PVV5gxTUU3MoJz/kfS9tqYCeHWUu
 +MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371110; x=1793975910;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9wQR1Arpe5d+feFg2mA9m230DuUXE/sL011N4S/t9ns=;
 b=f1R3OXNYyNy2nc+1yS+p9oRW3xRJM4EAYlCQN42VDwwO8cbuqHyGlwgJ+3AzyFYpfc
 ynS6lo5Enk02XCSp/01yWVIL2Z6O4qxNiK4/Sr/7vol9W3VMTGd2VZk3PGwXBi27Jjqc
 suALqTxk0Scnur4owl33VofPJBFJ4E2mXMFi5SYzckn8Ae5Z7LpA20ON+/QhwSE4Aduu
 7ftH9FjFhtYtox8lioM2eHJRNstj1tNznk+Y6NQ0YU2v/ThPQf8JtuQLf6/nI8mbg3zP
 6M2b0AUefdJ/oLtTHu6pmkaJu6oCiIYawJHud/rntXR4K9LRULW1FT0Yw7RmgHbpmMDj
 ewAg==
X-Gm-Message-State: AFq9FYIdwwPVCdU8dWubpCW2gmgHmD7DgVj/ucIrCoB+aQBqOSjKhrWM
 0/74ivme1gx1hxPR1isvQou1qawZ6Lo/kGjl16Dn7vs64b9Zw1Ba9g6rHqqMQ2JjAbfjh0Molpi
 nsnFEvY6HkfPcwkAgyfS509skV7T44bW72BSZ/U4wbg==
X-Gm-Gg: AYBFou3KqieQW/REGwnzB7bEkJRkT2PsnuuG7TfVeJDvH1C6tGLNMoXIbop8wNikeDK
 1eFnBGDm5/+69HCLQBAqLRHw6a3yzcXF9LK3icAPM2mmuaqz17S/uPy9y3PHb1ySech60DXcvhX
 M70UP/wexb0MlsVQHmphjmAIV+78wr3idgkhWjTZRqtpfrKy0KMxcYFIT8RIDI8D4OEB5dmGahK
 hCQaN5LabDz3d2Hc7rVUVXvwZp2w8Wji8vgrvf2AvKFbc6ZgYq7TZCcP+oocRcbxrWFEh9l+vxO
 E5RX8VizxzLO3catAL10EGIAKf0O4OL38LfASMthXO0ba77ZWrfk8lX+RZEPaWbFaBa8L5budtC
 e6s9bZztkUDTpnnOfIwrkcOP/AvXDkkeoUDdca8lJ2s9xbFJYA3Ju20TKe5qjDkFMQIwUBcTDqU
 fShHJWuNbZ1aA6WaPB7xV/+vo=
X-Received: by 2002:a05:690e:12c4:b0:675:617e:6c2d with SMTP id
 956f58d0204a3-67ba4e96573mr2105738d50.25.1793371110494; Fri, 30 Oct 2026
 07:38:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-riscv_iommu-v2-1-e0b816494b1a@oss.tenstorrent.com>
 <CAEev2e9WvQD3ZJNU91-UH1p5KBw1zXZgqhJuBC+6y+Q9HvwrwQ@mail.gmail.com>
 <CAEev2e87Wn=pE1uqFTpi1EVBiyHq=vLPFmvBTOv7Nzrdji0CNA@mail.gmail.com>
 <atiwg1Zus9vNQQJx@pie>
In-Reply-To: <atiwg1Zus9vNQQJx@pie>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Fri, 30 Oct 2026 09:38:19 -0500
X-Gm-Features: AclHuK-hq832Mt1g-qJAJQxlrNSGl4iuJBoZZj4QAp5319dmqSVUwNLnXJz4zFE
Message-ID: <CAEev2e_jrdDCWmoqHrrRX1-Yur=wS1yGuwkYFk0cwDm9oFSe0Q@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: Add RISC-V IOMMU driver
To: Yao Zi <me@ziyao.cc>, Leo Liang <leo.liang@sifive.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Tim Ouyang <tim609@andestech.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yao/Leo,

On Wed, Oct 21, 2026 at 7:31=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
>
> On Tue, Oct 20, 2026 at 05:53:18PM -0500, Anirudh Srinivasan wrote:
> > Hi Yao Zi,
> >
> > On Tue, Sep 22, 2026 at 1:37=E2=80=AFPM Anirudh Srinivasan
> > <asrinivasan@oss.tenstorrent.com> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Aug 25, 2026 at 11:43=E2=80=AFAM Anirudh Srinivasan
> > > <asrinivasan@oss.tenstorrent.com> wrote:
> > > >
> > > > Adds a basic driver for IOMMUs that conform to the RISC-V IOMMU
> > > > specification. This driver sets up the IOMMU in bare mode so that
> > > > peripherals requiring DMA in U-Boot can function.
> > > >
> > > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > > > ---
> > > > Changes in v2:
> > > > - Changed DDTP read timeout to 3s from 10s
> > > > - Link to v1: https://patch.msgid.link/20260803-riscv_iommu-v1-1-79=
3cfa421ab2@oss.tenstorrent.com
> > > > ---
> > > > Hi,
> > > >
> > > > This is a pre-requisite for U-Boot on Tenstorrent Atlantis. On this
> > > > platform, the IOMMU comes up in Off mode at boot, so this is needed=
 for
> > > > SD and NVME boot to work in U-Boot.
> > > > ---
> > > >  MAINTAINERS                 |  1 +
> > > >  drivers/iommu/Kconfig       |  8 +++++
> > > >  drivers/iommu/Makefile      |  1 +
> > > >  drivers/iommu/riscv_iommu.c | 82 +++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  4 files changed, 92 insertions(+)
> > >
> > > Gentle ping on this.
> >
> > Gentle ping on this series.
>
> I'll try to have a look soon, but am a little busy these days with
> travelling and work. Please ping me again if I don't reply after next
> Friday, thanks.

Gentle Ping.

This patch has been on the lists for the past 3 months. Hoping we can
get this in soon.

>
> Best regards,
> Yao Zi
