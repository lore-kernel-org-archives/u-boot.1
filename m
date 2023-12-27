Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273BAC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574278798B;
	Wed, 27 Dec 2023 16:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i0cQ0I1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 083F4879B6; Wed, 27 Dec 2023 16:43:20 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8358387956
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9b267007fso653082b3a.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703691796; x=1704296596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XhJZDnsPhHmCcUHoHM+/fpakqBxZa5VNYhUu6RCJu3U=;
 b=i0cQ0I1plKBRP0dj51FoWQM47Mqlh+ViLZ+mmm/HcT6jZ+UFp5RIPpt9SyxKda0zqB
 q6Cia8787kF6gkrBzJKofCTXQoZcs6iHTUMRt6Zdzz18uIfpccxJJ1EHoDtlAV7Wp7qu
 aSY2IE5O3Cqq986nFsJP2KfgujncDDF2ylzcZnr/A1JWDJQ0os248317YaARqXvNzlmO
 wq/kWj2r1RqfOMnji7KfTfB9boydBi9AJFmSVLi11q2KuuBoQ9Cyi70EzaUjs+FECKyz
 KaOh0R4QFhbKeiJF1o/oeETCJBgnt4VJKlqBCi8u9Sq/RFnpPGJrT0H/NK6+odzed8Hs
 iBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703691796; x=1704296596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XhJZDnsPhHmCcUHoHM+/fpakqBxZa5VNYhUu6RCJu3U=;
 b=WKlgU5DLd4dyv8mstUgevuh3fBeUvNFsXy+nNRhOm6aexH2ojDeRECmNBSzbpsL3w7
 Z9FqWOfOrSHhgMs2GOQt1RA3N63TiHzwJyGK7url2CMlhMFmOS11rgVsEA+wehS5dBFA
 I/SIrTF16BwdtYqormhvDoYidRDHoeNvxmWCd6ZutOGdluapCp0rdxsfqM2W3tOic547
 rTPl9iM02i+GxWuYejJB6qJeQKvHYhDpYn+/PHTdg86OKG7357Tp/MGLEkSQja/1TM+G
 ZPq7kH+bWnuoxpmnRsXh750hDxSsuBHCTWQQZutaA5d7umnUAeeeLP1C3uD7F9902e/a
 3XSw==
X-Gm-Message-State: AOJu0Ywewsk6AnNrLQatCaCrzjrjS/V/bXBIyBu9o8Xcrf5M73aCo8zZ
 m/h2TPG9zx5YsZkOSEFOqSB9oIteu4cDlhqKsqWq7H11Q/+R3w==
X-Google-Smtp-Source: AGHT+IHYsrMKiqLiSFzwsh37K0yTeiNOKhRakn79cwOEfAPwHOZb+Px8lNf9a/qHQ+V6LloeRHQ24ODYCm1MsciRIdI=
X-Received: by 2002:a05:6a20:3ca6:b0:196:23a5:64b with SMTP id
 b38-20020a056a203ca600b0019623a5064bmr606086pzj.34.1703691795833; Wed, 27 Dec
 2023 07:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-10-raymond.mao@linaro.org>
 <CAFLszTjGejJm4XdCachiy5C-2i2L2XyWUschx+bNy+1YpYoOcQ@mail.gmail.com>
 <CAC_iWjJdtqT8dUszq6G=Ak_W4n5U9m1dkq2FryidBYg0unKAPA@mail.gmail.com>
In-Reply-To: <CAC_iWjJdtqT8dUszq6G=Ak_W4n5U9m1dkq2FryidBYg0unKAPA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 10:43:05 -0500
Message-ID: <CAEfUkUJStL=GH4hnOG8NJfAUK1Eom2uT2W9tFt6ak28LXracFA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] qemu-arm: get FDT from bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, jwerner@chromium.org,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias and Simon,

On Wed, 27 Dec 2023 at 04:32, Ilias Apalodimas <ilias.apalodimas@linaro.org=
>
wrote:

> On Tue, 26 Dec 2023 at 11:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Fri, Dec 22, 2023 at 9:32=E2=80=AFPM Raymond Mao <raymond.mao@linaro=
.org>
> wrote:
> > >
> > > Get devicetree from a bloblist if it exists.
> > > If not, fallback to get FDT from the specified memory address.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > > Changes in v2
> > > - Refactor of board_fdt_blob_setup().
> > >
> > >  board/emulation/qemu-arm/qemu-arm.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> >
> > I believe this patch will not be needed, since we have fdtdec_setup()
> > to do this.
>
> Yep, it's not. The board-specific portion should be limited to what
> happens if the bloblist is *not* detected by fdtdec_setup() (assuming
> the user wants to allow a fallback)
>
> But I think whether we allow a fallback or not is really something that
should be
considered by a board vendor other than a common logic in fdtdec_setup().
And a board vendor can also decide whether to allow a FDT that comes from
bloblist
by this custom function.

[...]

Regards,
Raymond
