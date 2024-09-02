Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0369CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 18:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 519CD8884F;
	Mon,  2 Sep 2024 20:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gts3EFjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE7B88875; Mon,  2 Sep 2024 20:12:59 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B56E8876E
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 20:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f3f90295a9so50529431fa.0
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725300777; x=1725905577; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDkj+MZoAN08vBOX3WGF0O4dgH8ygoR4YYTem3xe3vI=;
 b=gts3EFjZicll9UkjLeu9XspdVk1GanD8wvaI2dA4/N76kDHdtV1hVnhOU6soXcr5xG
 gZHeKdTrVUb2G4//aRr7OOOVXPJDfDx4TdW2YShT/qQEnItX6YN7P9xGrNI5i14Xkujh
 yuyBkfWiuWNzicIck+ikeuJ79DoWMbTFW/6zToXn+xcpwkgOERmPQfDk0aRdPwDcGqWV
 2NazKej62N+VmW/je/qRQYNmR0K2BG1M0aC23HqOw+ajVbamfstCxVu1A6yqW0jsnBb3
 IG92o2/ezeknK7I871LAXZnYBQ6Am/slKYk6Qmz9QebfkJkn+/Vc1j88XDDdsC2+L7aY
 lKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725300777; x=1725905577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vDkj+MZoAN08vBOX3WGF0O4dgH8ygoR4YYTem3xe3vI=;
 b=eeZCEXQ6s2DbK0/kY/Y4sBkKkbRm92M5MHqIZ/KWcDjx/bi2eVty2B+pNrsHIQMpmb
 WPeXESSuo7X+INZ8ry82QdH7p4QG0+i8egq7v+C0oHMFcQVJ3GcnKKYLR08ZkrB+c8a4
 8o+VfqYENEgkIfKzSX+ySevEVLn2g6tL/M2IYPjk5++RGXv4WyiEtGasOBgMtwQPEqZG
 bY9UOJlJGL+mGXcS9UrNCV9pEHkg0aVwxWl4xsB1p9up9qqYOU/khItme4cvJv866vYi
 O6EwXe9qcT5yrE2cktVN9H+LvHmFLLVQFAVhROrUkBGpkBa/NLXAWrDp6wlFfPZ5kVDF
 lSyA==
X-Gm-Message-State: AOJu0YxOy1nMRxddb5Hnptk8aiozXyFJF7zB9+jpRIcWQZdYCQc0+feF
 U6X3ALqzDFm+cwlohhSNzCAO2OYqNGd7Vur69uhGXXkJ6NZHNj8tjM1z7/63QyYn8zNUqRbJGEo
 e1ut8RwSHi7LyYmT5Hj5DY6kQl4k=
X-Google-Smtp-Source: AGHT+IGwE7FeM3MjKX2evrUesw2xmKqsYfJYhSun/JALmZR6FnXDqfIRwlvWJK33Cn4iplIbLQ+B1761de/pee18qSo=
X-Received: by 2002:a05:651c:1546:b0:2ef:2dfd:15e3 with SMTP id
 38308e7fff4ca-2f636a14952mr27906281fa.19.1725300776270; Mon, 02 Sep 2024
 11:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <3fG.Zblj.WuvIm1nVob.1crVrB@seznam.cz>
In-Reply-To: <3fG.Zblj.WuvIm1nVob.1crVrB@seznam.cz>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 2 Sep 2024 15:12:44 -0300
Message-ID: <CAOMZO5B=bCCApd-Pi5UwW_ckx5UjfZcAvfDtaSrV=j0bzskpHA@mail.gmail.com>
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

Hi Tomas,

On Mon, Sep 2, 2024 at 3:06=E2=80=AFPM Tomas Paukrt <tomaspaukrt@email.cz> =
wrote:
>
> The mmc erase command currently requires blk# and cnt parameters
> which can be obtained using the part start and part size commands
> if the entire partition needs to be erased.
>
> Simplify the use of the mmc erase command by allowing the partition
> name to be specified directly.
> ---

Please write a changelog below the --- line.

Something like this:

---
Changes since v1:
- Bla bla bla
