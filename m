Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6FBC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA18587A37;
	Thu, 28 Dec 2023 14:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l3ynNzEs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D967887A06; Thu, 28 Dec 2023 14:37:21 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE398781C
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78158569dc6so159315985a.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770637; x=1704375437; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYWyJixRy1gR9yFzz2DTPy2yBFJLAMtHYx6KIZg5qKI=;
 b=l3ynNzEsf4CGrJ6j5ffuTo/Rg2j0qFftWI/uVfOSseonLOlzAXrEQdiHeIHvxXT0DO
 AhZfzQU5mrnr2g9HgaptbqUdYB4wnhpWVXYAMS+Zt582otRMQoIR/WSQfeMVEcYIMkmg
 yFc2l+d7rpwWrNk7/b0Cn7/r8InxO9/kThhxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770637; x=1704375437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYWyJixRy1gR9yFzz2DTPy2yBFJLAMtHYx6KIZg5qKI=;
 b=Y8OTrcHbCyGpTzuiFNSAdGgGxxgcsf7ZEwpnp/xTK/HYcMg0XKrWlYrxuYDjkcKNZA
 +Dd/9w9erLt9pqlUr1QKoKAoOAxTEJhOK/IMJloc9FfUA5Cr857sHTrnsP1RajxDQudq
 R48VFNUk6s/lX9SKR8QEhDgDgPJG0lQB7CV+nsU1cFT0TAiUaiD0iDXSkOmx/yED7job
 S3ksSJYKY9+dqq096Ym+mXT2bBi0eKssrRrd44jOHSJ3oEY/puYuFuk+uuX6IvAKCjfz
 aAqD6NLqcaflp8+0CSykDsbS7vqwlYf4CfAL/+fbU0G2lbT/9jYWsZ7YfGRIrJauH+Aa
 iVuQ==
X-Gm-Message-State: AOJu0YylTPaAcWNasT+s1E7l/2b0m7q3Ebr3p66eXqI+WnLJXhMT3/hp
 ZsGUW/4TRz0yJhAPJmVupbMWUSgWnJfr9Bhx6q9Sa8AjVuIE
X-Google-Smtp-Source: AGHT+IG92DVToIolXamhGwvaXFJOsXV4tlnirNFjO7ysSmrhZYqlHdCEj6w9iqt0CJntNzc8vh2i7czFRnOOpSILzbI=
X-Received: by 2002:a05:6214:c27:b0:67f:434c:3e22 with SMTP id
 a7-20020a0562140c2700b0067f434c3e22mr12450979qvd.64.1703770637206; Thu, 28
 Dec 2023 05:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-7-raymond.mao@linaro.org>
 <CAC_iWj+bo2gq6wuV1aQdWHybe2MhG_46DsMLBGpNbADEQnHHVQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+bo2gq6wuV1aQdWHybe2MhG_46DsMLBGpNbADEQnHHVQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:06 +0000
Message-ID: <CAFLszTjtFzVGFNQS1suMKB4RVPc9rUB_a778pv7yiOBrYwj3Ag@mail.gmail.com>
Subject: Re: [PATCH v4 06/12] bloblist: Drop spare value from bloblist record
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi Ilias,

On Thu, Dec 28, 2023 at 7:29=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Raymond,
>
> On Wed, 27 Dec 2023 at 23:08, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Drop spare value from bloblist record header.
> >
> > For now it is still present in the header, with an underscore, so that
> > tests continue to pass.
> >
>
> Looking at it again, this commit makes no sense to me. Why is this
> needed in the series? And why can't we just fold it into patch #10?

So that the tests pass and we can keep the patches small.

This is on v4 already so I don't think it is a good idea to
restructure things at this point.

Regards,
Simon
