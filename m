Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288A0C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6F487907;
	Tue, 26 Dec 2023 10:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bCnHlFVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CCA58789A; Tue, 26 Dec 2023 10:48:06 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 224228781A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-28c179bf45cso2179794a91.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584080; x=1704188880; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2aio9+Sp3WxMppB1UjG/3VvgLytnqxCL40Xwv4aBvww=;
 b=bCnHlFVUTZ2cL6cjjEjz8QYRwViFz9K6vQnK8Pqu0f6aHkl2eEXBzZDt78A4MQj8vf
 g7En/5edJsxz798Kpi3ZmVSdM1p7VwedxzYrpio3nSWWOcOnwfjTK6lsKc6/4gyNxx0j
 dV0CQIBHePpxaHjrNheNHJ2J/WLK3dZkTbzpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584080; x=1704188880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2aio9+Sp3WxMppB1UjG/3VvgLytnqxCL40Xwv4aBvww=;
 b=QufqRt5ykimZyq8L5OPk6SMC7e7xDNW7c+SwJ7pP1Fz49aRLXBe/tf5D6cJwfD53yi
 V+b2UXqpEDgO6/v8d/85czgM6w6B/iBDB/3fCUl9Hgi7Trz7tC6DSRX3ydCoYLLgwQzP
 ypXxJds38LqWZ+6ghbB7oJlrpFRd/X1I8tTCjYcUwRp4jEcmKkIwQHECnbKCH/EfTRMw
 C9B2GRVAiWmQ5AbZnBq8+m2H1OxEt+9qTcYq1uFEwh3rxAzwIuyCrYZB0Yr8P9RflVFN
 zgaeseSrDNLHMOdK4R2pVFQQr1mrnLfYZV9onXK115BmWrh96A6E0unfojtnsapEshlm
 OsLA==
X-Gm-Message-State: AOJu0Yw5DUmplThsgIM4Yj3NSBUfZ2z68od2XrI2GTBeatzz54aw3km8
 iHXJAJY1+fvVciNIrkD0rQtKe+dyUN9m1hZ1ZstWtz3yj+7G
X-Google-Smtp-Source: AGHT+IFqEoquiodRRbT72giCy9T3140AEUj7FHm8YrMMVrl9HXLaPPiXfFClVRyNlElVToSBtq6qq7PqqfTOMDvGh5k=
X-Received: by 2002:a17:90a:cb97:b0:28b:b425:b6e2 with SMTP id
 a23-20020a17090acb9700b0028bb425b6e2mr2903179pju.74.1703584080544; Tue, 26
 Dec 2023 01:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-4-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-4-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:41 +0000
Message-ID: <CAFLszTgO_8UC9Wuaki6-vaFmgsqvovcLk813pZqR8TjyYgAf4Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] bloblist: refactor of bloblist_reloc()
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>
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

On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> The current bloblist pointer and size can be retrieved from global
> data, so we don't need to pass them from the function arguments.
> This change also help to remove all external access of gd->bloblist
> outside of bloblist module.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
> Changes in v3
> - Check the space size before copying the bloblist.
> - Add return code of bloblist_reloc().
>
>  common/bloblist.c  | 10 ++++++++--
>  common/board_f.c   |  8 ++------
>  include/bloblist.h |  8 ++++----
>  test/bloblist.c    |  6 ++----
>  4 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
