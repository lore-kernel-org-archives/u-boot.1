Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F95AE7D0AE
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 21:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E94A86459;
	Thu, 21 Sep 2023 23:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lSMS1oqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C67E86466; Thu, 21 Sep 2023 23:58:43 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E4C18603A
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 23:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso177424466b.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695333521; x=1695938321; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=663oj4wHnabK0pp7sOx4Lg2LuhN7OFgWWhmy5LHGsug=;
 b=lSMS1oqk08mdOg27gaeVIi+ANLpJQqm1lIek7BXEwnMlgHmQuwZHtlMQjYWFKrTAFa
 4gbU8XjNUEj07c945QJi1/+UsbsboKENOHKQDHv+jc5UQzjdMrRAXseO+grkVr3+cpoo
 Re3HRnAJon+UZM5ugf+3VBnwtj2vuR1fEkgOVUYl/uQfTsWf0aQdXPhqCU4IbUxw7k9T
 /aTxK3axWS3Z6J/hAXJFamYftI2mVl1b0A5XbBblEDnizUvd+mZ96cmzmYu9UQg/Wtgw
 Dx0yxV9K5XiA2Z+jaJ0/gm6XVLF5mEQVpYSSKMFbjjCi6ATxqUU+uciZBf8WwZcesKd/
 SPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695333521; x=1695938321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=663oj4wHnabK0pp7sOx4Lg2LuhN7OFgWWhmy5LHGsug=;
 b=R+M/FiBvRWJpSwcccYYpThd4brXT5FsJ155kczCTjGq80o5rQjsaAvmkoTadto0iY5
 LYXk9/Vj0yatFKMmV9Nz14swMT+5acstS3jB9qZjNTXO21oyPwyjxsKfoKkNauhzHPCC
 AAlbLGdD/l8wHD3/8JWeebZ0qPtoaCGLiy4wY0dy9zJKoyAfeLiCSttL832/jnfB27TA
 ugJ0aUrYndH+iBjRrSlprePaOkjR0qMC+HYmTtCTeRV6pqQ/+7D054Jb+CQ+M2zE6YXi
 G7eCmUbctTKdFhxa3y1G23yWqZVIEioN7K+OKzTPgFiGNwJBifN7v4o+g12sr79sVXiW
 FiiA==
X-Gm-Message-State: AOJu0YxdK75zXePT0ylFTuP+Tks1q6TQWkjaAGgDCIm4DA0wD3ikd4Sy
 nihBhcm0mP7L0os5OvFX1yrcqx1m8M9NHcFJoqs=
X-Google-Smtp-Source: AGHT+IGOcQCKGEKauX+EqSe5fuCYsZXZXRwiVE51Wqm6cv/lAUsiPrRr/UbttFnkFJc5f41ss4SH/tsk2QuCZiP7btE=
X-Received: by 2002:a17:906:2cc:b0:9a5:b878:7336 with SMTP id
 12-20020a17090602cc00b009a5b8787336mr6937393ejk.7.1695333520860; Thu, 21 Sep
 2023 14:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230921133748.1543007-1-sjg@chromium.org>
 <20230921133748.1543007-2-sjg@chromium.org>
In-Reply-To: <20230921133748.1543007-2-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 22 Sep 2023 05:58:29 +0800
Message-ID: <CAEUhbmVoYz+pu5vtPz3CvQqctp1_E0yDmpFFsPkV3ZLebt=GeQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] fixup: Move python control earlier in Makefile
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

On Thu, Sep 21, 2023 at 9:37=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Move this control into the common area of the main Makefile, so it
> applies to non-build rules as well. This allows 'make mrproper' to handle
> python files as it should.
>
> This should be squashed into:
>
>    65a33eba10d Allow Python packages to be dropped
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v7:
> - Add new fixup patch to move python control earlier in Makefile
>
>  Makefile | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>

squashed into "65a33eba10d Allow Python packages to be dropped" on
u-boot-x86/next, thanks!
