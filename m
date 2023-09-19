Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6B3CD3445
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DCD386A26;
	Tue, 19 Sep 2023 09:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7/t6r4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 631D286AF3; Tue, 19 Sep 2023 09:20:24 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A36086ACF
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50336768615so22289e87.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695108022; x=1695712822; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Dy2O5PYidDrFnxRDaSLSsd/fPm96U3yHyyb/xJOqUc=;
 b=S7/t6r4gWl8ajzlRFp0dF/rgJcV+wxCqVlogmZR//dX2OsBQVgTZZ0qs99qJUEIDfn
 goJOeH+yvCak9/Ai6aPWZn8EKcsKz0/eI6u0G8cDk8+mgIXMOZ+fymgH26U8DyjYHsRB
 0iw6mmKax0hrKj7WvmDWzR3CAc6vKUONbfdbKPDZfjYHsdj579otzX1c95QOnCNox0S8
 PkXTOJu7SYdra0cH/rWCmrIrnEx3WZf7FnsOAKFJVxq66lBZpxrjp7TmaLy/jdXdgSlk
 bmGF/OBmFSc4g3ynFcOOZfshVc/F53Ur9ad9jqSRSR4xxYxhI8Cwq4zj+H8MtAFjc2Uu
 zcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695108022; x=1695712822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Dy2O5PYidDrFnxRDaSLSsd/fPm96U3yHyyb/xJOqUc=;
 b=H2siP/wtv2k1OgosY4jlJUiu5ljvvp6+nUgJb3aBH4XhxXpWanlXEEThlFvISTUUHt
 +T5GLEl9VvfGRnRq4Z5I/VBe4cSPoBizTWeufRpo18lvjr7KDT3dyjsxY280jJMIwOi7
 vic16yjMkJj3k43XNR3AQqDcc19EN8Auo2GVG3rCaqMw1MWba689D6OgMfg6OYEAgexZ
 qPl/WKjRyrqgExNp+GkSyNLi783Tyx1PBza5nkI00OVq/Sbrr5AJ5vSdxAaz8Il1zx5E
 1co8MgF4ozhQq3PuagGkxB46d7DPG2iI4Q/nGZOcRd+yP/c78xG7ys7NZUUX0HfGXOzI
 ehLg==
X-Gm-Message-State: AOJu0YwEx1Lx7kcLHM5JcTPmi03dfDa1bgdsgcss9Onjh4Rg0wPh+rRv
 7shnGWZ/NbPMAwZ5/dlLW0wG2ZQxWV21KTM2zc8=
X-Google-Smtp-Source: AGHT+IF8OT1BuOftsSvdysajpB9ZVZMWdlg1B0sF/9kOvtX4S+NKwOatvn5x8Ir55PUd8Qqg8TTH3DCE+KO+8XaPo+Y=
X-Received: by 2002:ac2:51b5:0:b0:4f8:75cf:fdd7 with SMTP id
 f21-20020ac251b5000000b004f875cffdd7mr8786625lfk.22.1695108021855; Tue, 19
 Sep 2023 00:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-12-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-12-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:47 +0800
Message-ID: <CAEUhbmVbf0aM2ymwdjSGR+w=9RUZi3erAAsbeeYisvbCKaLWsA@mail.gmail.com>
Subject: Re: [PATCH v4 11/20] efi: x86: Correct the condition for installing
 ACPI tables
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
> It is not always the case that U-Boot builds the ACPI tables itself. For
> example, when booting from coreboot, the ACPI tables are built by
> coreboot.
>
> Correct the Makefile condition so that U-Boot can pass on tables built
> by a previous firmware stage.
>
> Tidy up the installation-condition code while we are here.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch
>
>  lib/efi_loader/Makefile    |  2 +-
>  lib/efi_loader/efi_setup.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
