Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6F6EEB59D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 12:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26FB788F9F;
	Thu, 12 Sep 2024 14:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BshQM4/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80B7188FA0; Thu, 12 Sep 2024 14:30:31 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74E788F9F
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 14:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f75c56f16aso12556461fa.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 05:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726144228; x=1726749028; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2LRHGNHHDK/LqPBaBxABC7/xR/ay2LTGZr/QQWUHqg=;
 b=BshQM4/AOm8bh7KS+FZL0ctU61KL/A5zYMAKwIl2OD8hf1NHTFVRN4C936zM1LoBFj
 XpdgSU38t6fFwT+jk/rTkiTIWlsZHwsRUWhmUUwC53I3aaiVhXYo8S9FTyeFdElq7wy9
 herkc3Ys3Pt8eUMuatXVYj7gQn8drFlN5E/kS+uDhIFK0mcTAQGxBbdjwzL/zBsrKLQ/
 NzCJD0p3oG8GvVMlTFnTlF/+QsK20aEivCleY8VrXNLBPyUH8Dx/v83mPEg32oQcJC+L
 bspnwBpgmBlMnNo6phadCX/owZfjWYe2FuH/852+CVJkgkbtBXc4E2eB3CXXWIg0bMxI
 zf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726144228; x=1726749028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2LRHGNHHDK/LqPBaBxABC7/xR/ay2LTGZr/QQWUHqg=;
 b=AUV/HkNgn1hTOOF1g++cx8APrdocwftssq3xknhtzFXNQqF/oTP1xJ6GrFkboZ1mU2
 HxwYT2EeNAUFvrsNtom8wJbSn8X1egfH4sG69uamnnsKXojrmRw370kEVSfWg1AtcmMm
 lTxziB5zGUCxXgVk+T4Se2uuVQnphTvMq4zN53HpYtri/o5bquD5al9sleDOz+gQxB7z
 a3Kmie6utDifF8A6fnCm+gJG2FrLbJrEAaXzGFIQynIB0PLyTEhoU2JqPJ4c5iNXEiLt
 dWObakeEdlFgINASdFtdgbQAn1drNtb/hG9iytgq6Hf+tfcgTlt4wOvCifqtCBsp8vGJ
 zhQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVElihdYQ0OlrkRD3ccM3PUWKJ0ja+15+NTTPbd2Qjnee+fKgUffTK/rM/I+2XqRfnbMbCSwyE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/VIUVDWkVYGEWlw9WjoixDQeOxFJLh4Tj8dxc7+IdhtC8qlJP
 LKOKKpGstrLeXrPidFk6d+oLVd/DVusepODdFwJVP2VTm94Rng3sZB6DTDJGT03P4Z5yzcjKH6u
 QYWE7lQ/fJAU/qVD7nVn328LBzFA=
X-Google-Smtp-Source: AGHT+IGZdADw0L975bzkEYXD3uVS9kisyuHXcaBvBhxP5xZSJflL01RJf8SwVNvabrs97ShldxXOCYT4REC5G4ueCRk=
X-Received: by 2002:a2e:b889:0:b0:2f7:8d3f:11fc with SMTP id
 38308e7fff4ca-2f78d3f12efmr7970971fa.31.1726144227607; Thu, 12 Sep 2024
 05:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <20240910101344.110633-4-miquel.raynal@bootlin.com>
 <CAOMZO5DxLh24w4owJ63z-aEfRtu0gct+DzGPbZQdyFBt7NO1uA@mail.gmail.com>
In-Reply-To: <CAOMZO5DxLh24w4owJ63z-aEfRtu0gct+DzGPbZQdyFBt7NO1uA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 12 Sep 2024 09:30:15 -0300
Message-ID: <CAOMZO5D_-49AdXCe-O5NRqw91oJ4WwpHqEomKBAd_hn9qxYPeQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] clk: imx8mp: Add media related clocks
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
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

Hi Miquel,

On Wed, Sep 11, 2024 at 4:48=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Miquel,
>
> On Tue, Sep 10, 2024 at 7:14=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > These are all the clocks needed to get an LCD panel working, going
> > through one of the LCDIF and the LDB. The media AXI and APB clocks are
> > also described.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> This one does not apply. Please rebase it against the next branch.

Also, shouldn't we restrict registering these clocks only if DM_VIDEO
is selected?

clk-imx8mm.c and drivers/clk/imx/clk-imx8mn.c guard some clocks with
their respective CONFIG_ options.

We should do the same here to avoid unnecessary code growth for those
who don't need
splash screen on i.MX8MP.
