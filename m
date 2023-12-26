Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4962C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D2187926;
	Tue, 26 Dec 2023 10:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WkRX4nT0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC8E88791F; Tue, 26 Dec 2023 10:48:17 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90F78781A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bba50cd318so1641876b6e.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584094; x=1704188894; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qj+ToHc3hE4A5yBCbuG3o/3tbHQrBLcMtGkDmDxild8=;
 b=WkRX4nT0EC1o321eatjMfCyGHdpEPhctlJmBu6idTlj1+Xby8ed0vI80j4aoK6ZwzG
 X32kVdrebslzZzd0S7drUgit4ZpDX3foesY0mzL/+Oa0MEwU/WFBjSBHsmRyanop2Tbp
 FUJeCigQzM1EAxDfQ5RyYTCaryGoYbHHGdTDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584094; x=1704188894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qj+ToHc3hE4A5yBCbuG3o/3tbHQrBLcMtGkDmDxild8=;
 b=tSW7n+WQCDBo/nEIPJKmTK/GPZxmmIWyzNzjqQQjhPDcUJZPAH612GHFIJ1pixuKyq
 wN+eekyf3wdnOenC6sZFacdz/R5kiaXOuT9h+vCXEM9a5NE3sq7BCTQcCVGcj52qKHyp
 5ns/qYHMV0P/2aH+pDWDaw5Rd/8Ptu0QaBz79iYLwQ6eORTC8dkXlQmn4lkslliQpwHs
 5+ZP8LMqvcGZqO5t6CMK3AviFByHyXE1o2+02C+Pgrkt2LB5AWpgSGVQWPbY8RdsyuZI
 WAB9TeErfC1GqtYC5aDdj88X6yUSn+c7SWc7w2wBtoNfCQFODE8aSJ9yT+Y1en728eP6
 /aXg==
X-Gm-Message-State: AOJu0Yxe/g6JDv0Pa1xuySiw3xUrxoFOONH2kI9uK1t7aktSWd8lBhCD
 nUbU9deSLPyOUVGvpEsfrw6fp+1YpGIuB5FanMjq5Xytxzbo
X-Google-Smtp-Source: AGHT+IExJYcrzOLnmWa8RHUIKqcf81nR3oP47zmo4fJlNgk9yNdulddooYle/IhzOOD5In4+uvb+ZHHUFS3VmGjjRF8=
X-Received: by 2002:a05:6808:120e:b0:3ba:a85:42b2 with SMTP id
 a14-20020a056808120e00b003ba0a8542b2mr9437693oil.58.1703584094512; Tue, 26
 Dec 2023 01:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-6-xypron.glpk@gmx.de>
In-Reply-To: <20231223004429.247301-6-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:37 +0000
Message-ID: <CAFLszThrHODfu-ZhHEzRe5wT-nMpXAp=UCBJC3FipTi9owhajQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] test: unit test for smbios command
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

Hi Heinrich,

On Sat, Dec 23, 2023 at 12:49=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> Provide a unit test for the smbios command.
>
> Provide different test functions for QEMU, sandbox, and other systems.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  test/py/tests/test_smbios.py | 47 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 test/py/tests/test_smbios.py

Can you please write this test in C?

Regards,
Simon
