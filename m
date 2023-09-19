Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7520CD3447
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F68A86ADC;
	Tue, 19 Sep 2023 09:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e6BW+JHX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A74A86A26; Tue, 19 Sep 2023 09:20:16 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E88986A81
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50325ce89e9so1731724e87.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695108013; x=1695712813; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxKdxeStjZ4g2UOfruM0TuqgUqGVy91ttNuWT1bHhdI=;
 b=e6BW+JHXpz7ovILEznFzrQn0RA9MPf7gJDVExGKpCNndtZs961KswOB9IBNwI4tdhn
 vokcfFi3EL4SC/etvjRqr2o3z8JLJrwZFIYf/nJrEKXBLKL/4ChqcB8BVmr6nN1yBbLI
 umWa8B4eZ67NXZzTR50wKgFIDf/fA7duIyhl9Mkkz2uq+fCslCZV3pWM49pKvy/ZA+Kr
 0DUcXHlSNAf770wzzOOwAvKKU8/291KBd/gk8r+/GHlI98+zgxc0JWqPezGpzbP7/fak
 5zZ4TMCCz6GQ/yMc+Gl5XgPIzUQWs7ft4YlOOyN98ujMhNhZqj5uPFsgCPDir8+mt0uO
 a3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695108013; x=1695712813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TxKdxeStjZ4g2UOfruM0TuqgUqGVy91ttNuWT1bHhdI=;
 b=Izq1PHNat+Zwzd3o4Y/B/Q5AsakS5nN4/seEaE752yRzhwFuSu3qbOn0kfa8/R2h6I
 sTzUfDXvszAmSAtds5hi8/CHoBwoMWEBTQSetCmSotd4QenD59p72MyXYppSV0vunVJP
 bjA9+2EGdlAROL0pSu6cCMVk1Spv8+BK/RhxTfX0mHev3rsVy3CEbkKbfUMuhgjPCpvq
 KSWjF02srO1MukB5DXRblpEJDtBA71Ix54CkSR5mK4hZl7j+MT4/75WXNWv454DHK/PD
 lAnwa+N4dmpUiFlKkCzze39cqP8X6mcznnT56iS2+tqrCtJ2549hUEyLR4Y0mMeXrPDd
 jM1g==
X-Gm-Message-State: AOJu0YyzTPZLvFw3tIhg6fVuMOrZ0/WVclMxauNlaQe4Iochf8BESTrb
 hq/qvQ07dgm7RT5mvLUzqKZpIpYEN157Ko3ALqtNzohH
X-Google-Smtp-Source: AGHT+IGxqNK8F9d7HlGp78FGKPPoyUpVDY7fPjA/lvca5wMnCP/qXsI9Yg9Psz5i1zkfW0uRw7AeVu4Qh8Trqp2gWeE=
X-Received: by 2002:a19:790f:0:b0:500:7685:83d with SMTP id
 u15-20020a19790f000000b005007685083dmr7829838lfc.48.1695108013627; Tue, 19
 Sep 2023 00:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-18-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-18-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:59 +0800
Message-ID: <CAEUhbmWDyf=Bv5jnzBL0aCm3jnWRNFTd+2JySN3APUFNBU0q0w@mail.gmail.com>
Subject: Re: [PATCH v4 17/20] x86: doc: Move into its own directory
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> There is enough material that it makes sense to split this up into
> several files. Create an x86/ directory for this purpose.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch
>
>  doc/arch/index.rst         |  2 +-
>  doc/arch/x86/index.rst     | 11 +++++++++++
>  doc/arch/{ =3D> x86}/x86.rst |  6 +++---
>  3 files changed, 15 insertions(+), 4 deletions(-)
>  create mode 100644 doc/arch/x86/index.rst
>  rename doc/arch/{ =3D> x86}/x86.rst (99%)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
