Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F82C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E02C4878A5;
	Tue, 26 Dec 2023 10:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NISKHM0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC0448786E; Tue, 26 Dec 2023 10:47:54 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A94C8781A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dbb20471b0so3355141a34.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584071; x=1704188871; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bunpTnSscEP8Ny4SyEYyO45Ubd2aTaras5YXcCMVDU=;
 b=NISKHM0fwW6NjuqCNDGqpH/uEhxJQEjk/thYQ50qT+Fr+H09Qo9724fVv6GUCB9K0G
 6vr1y5ha3Cb727o0OL/UMD+1cR5OnJ2wSxRn+6/I0Pjf1GSPyd2CSxK5iC2UhFK2M0mq
 p4J9CvRxc4er5pemrQE/r+JUcYUuAya0t2cso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584071; x=1704188871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bunpTnSscEP8Ny4SyEYyO45Ubd2aTaras5YXcCMVDU=;
 b=FYk5j82y+mxDM6TddPu4LGKklz3AoQv8i/jmj2zkR7g+M55zP+Of9EP1THfNCzN+Kc
 ez0dQyIhc/7iYDCPvLjCzlePFc3USRByPxWQ3C5lvPiJJ2dxu64XyL8W5XV1mOEvk74+
 z5PvIS10UJ0fDUOkj0bE4Y8AxqbzmrWcG7SttMSIK3MQ82SZXyv6KYAOQ7daV9UP0Pte
 HHbv4LtFDkflBVPDTuyRygC9uO3SJ2onj8Ve+3IQ+8+EqB8+gf/U9NdMSCxDljAi7TKA
 r1TDKdFQLDvF5DPtPvN7+yExAhFP7N5OBlKpsnQuzGVc7fEffCW6NYJd2GNbIoQmy6aK
 U8VA==
X-Gm-Message-State: AOJu0YyhDazn3OttXWnVGU6D0JqKie2ePtFPSG6k0aOzK9I8p3K2IlOY
 fGwOxF57novJzxTapgR6ByfiMgElILJgnLWtI4mBthqEJa8e
X-Google-Smtp-Source: AGHT+IHf+JI8Tg13nLaKp1TKqTvZoBH//9n5P47IUmpFgwlBMDznCqNXXVFJ2ZEJOuzXixonS/DZcTZ8OEaxDNUbgCY=
X-Received: by 2002:a05:6358:5289:b0:172:d988:b4d4 with SMTP id
 g9-20020a056358528900b00172d988b4d4mr8687323rwa.54.1703584071214; Tue, 26 Dec
 2023 01:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-4-xypron.glpk@gmx.de>
In-Reply-To: <20231223004429.247301-4-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:36 +0000
Message-ID: <CAFLszThcND8mv0RWQO9rM3MHgKoGtpPbag5ghMrA84RiiLeFfg@mail.gmail.com>
Subject: Re: [PATCH 3/5] cmd: provide command to display SMBIOS information
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On Sat, Dec 23, 2023 at 12:49=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> U-Boot can either generated an SMBIOS table or copy it from a prior boot
> stage, e.g. QEMU.
>
> Provide a command to display the SMBIOS information.
>
> Currently only type 1 and 2 are translated to human readable text.
> Other types may be added later. Currently only a hexdump and the list of
> strings is provided for these.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  cmd/Kconfig  |   7 ++
>  cmd/Makefile |   1 +
>  cmd/smbios.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 cmd/smbios.c

Reviewed-by: Simon Glass <sjg@chromium.org>
