Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594BCC04FE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 18:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6B2386BFC;
	Wed, 20 Sep 2023 20:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q5Ia54JP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C25EA86C04; Wed, 20 Sep 2023 20:42:08 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B4286BDE
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 20:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-690fe1d9ba1so26097b3a.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695235325; x=1695840125; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yloPY2fdjVeIacRfnt3NVPsEjhqctGR1ZtN1kYyqUTM=;
 b=Q5Ia54JPvHjKAhwMlVx2JVfpRAO2B9lyR7LXBCENlWkwD0iGv+5Eg2zY+i6HvwZYnd
 A4lsgAkPqpqDQ3eXdjalUWAcxpztQqmzXa6oOXgBT4N0x0GiYXSZlSf2OB7a8T4l0jfr
 QyOEC7Q71CbHosbnqgU2aW2Fn5p75pV/O0MyCr2N+HIlbRbib9PhnhmNzGY6R5d/Wc8f
 Ov9t9A0+0cUy2Arbxb7JkTDY7ilObpVGC1I6BzDqV//DSDLay7bjUY5C4aTHP0y04LaZ
 IpSatcWVHCoOJNCR2E1IdM89mR8sUrcWyZrmcH4KopMoiGJz75wRgUoufm8OfCuNTGTa
 hMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695235325; x=1695840125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yloPY2fdjVeIacRfnt3NVPsEjhqctGR1ZtN1kYyqUTM=;
 b=rmh1dayzNgITaonhB1HwT7TrpryraukoXS/dXhdmo+FDAXHA7/CZBJ8MF7xX8e2hHo
 iW7A0P5HqnuuOHg7IdVQDbLRP5nLtWLKJgYhjLSc28RoEbFVfRYIEaUHGoG8bcdNN1tD
 aBSbp6Tw9aM2p9vinqtSCBtlZMjvw65URvPjRcSFNZHWlXp8bkq1G9Ver2Kd7ihowIVC
 mC0khONotykhTpjtIMrkEGd1Acz+V0sZSzAkToxrxJHl5iyUmFR/DkKlmPmAfbb6ygMn
 qExpIsLolaOorerWk6OoJUCN6Q9fRlBjldqSyKOaq6ENN8PdZgkO1NTdKe0MLOKcXqff
 uZmQ==
X-Gm-Message-State: AOJu0Yy/KZkHygxxzGgnf47JvSsxRFVz71SqByqafnv/xKPFaQBFi1Ny
 8ZhTG5w7XBCtbh74HgX+Tw+zq4X9FdBt/Tju0k3wMpFPpCs=
X-Google-Smtp-Source: AGHT+IFQ02gnKDqaUVjWlkketXLGltHpSlK4rjRfJDcd433udAcqYcGZTfqXVxtMIPwMzXQaVtx3kFIUhqeZHQf+SFk=
X-Received: by 2002:a05:6a20:a126:b0:14e:2c56:7b02 with SMTP id
 q38-20020a056a20a12600b0014e2c567b02mr3879707pzk.0.1695235324953; Wed, 20 Sep
 2023 11:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230904132437.36435-1-hiagofranco@gmail.com>
In-Reply-To: <20230904132437.36435-1-hiagofranco@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Sep 2023 15:41:53 -0300
Message-ID: <CAOMZO5C_4rsL5YELCEA5b94G8Njc3pdRkRcpi=b_t2axc6fSug@mail.gmail.com>
Subject: Re: [PATCH] verdin-imx8mp: drop unused tdx easy installer ifdef
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>, u-boot@lists.denx.de
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

On Mon, Sep 4, 2023 at 11:09=E2=80=AFAM Hiago De Franco <hiagofranco@gmail.=
com> wrote:
>
> From: Hiago De Franco <hiago.franco@toradex.com>
>
> Drop unused code related to CONFIG_TDX_EASY_INSTALLER, that existed only =
on
> toradex downstream branch.
>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Reviewed-by: Fabio Estevam <festevam@denx.de>
