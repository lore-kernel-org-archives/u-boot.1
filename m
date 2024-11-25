Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E7CD59D7F
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 23:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C1AF8975D;
	Tue, 26 Nov 2024 00:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="lzsOtU8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6950B899FE; Tue, 26 Nov 2024 00:41:15 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE5B88FC8
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dimorinny@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa5366d3b47so325781766b.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 15:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1732578072; x=1733182872; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8SdHkU298doPpZMV6hdirWBtr1BmuXkZRK/e1z9H8LA=;
 b=lzsOtU8FTxI5SoE2Jy6ipBid0HmYYaFe4iWsGwFmR1I1xLxoHUmIOUKC84nbx6hhfg
 YHfCLtyZwZOyXZ3uDoxiaUGIK8AvlsrOrrSqfYL9cl/bIaLkrOYiS/hBxI+3mW2/vDtN
 JRHsLNxBcFFt+oCPA9xDmCN2zDPfz1ODofi5BXLKSrgXF6wtap8ivSLtXtlYsDhCmlIG
 rTxS7r04N1Qic5NLHmoJrPu0EZDgOfr87D+MKggYN6dkKiPpNyreY2NO7NEXqa+d+OZt
 dSQbzRTer5N3ExGoklNYPK48mm6AHqvZtWMnYx9IJt6+4LEd7WLYcjCa0jzALei3yE3Z
 6KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732578072; x=1733182872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8SdHkU298doPpZMV6hdirWBtr1BmuXkZRK/e1z9H8LA=;
 b=HFRT0sZuMPtQSQAIhW89+NMfwbuJy2+WFNUtt0id3LfSIEpPtpVFsTfbSfUNDQ6arE
 Lr3mMaI9ipX7xU9eWGxQhPUsk3bTGt5e4OQqaspty2h6WREe09+wDewr3+LXDMibb8XU
 hvS9QQ+mu4c4HMdHcmIthsuvoy7gEdQGWP53UVfUDjwsND2QdCHvsyaT8PIODSsRyQlR
 Whg5QWWsIPfvXHZVYSsCpXvs8RWlX19ApLotTdRU4JZHlrOfv6wOoOcVBGFGOUdfAb95
 Xb+JWYUFmEyaD6VUnFRNPZWuTEiM/irREYGOjYOxIwUmXbeAXimRu/Eo+pEg0bdB3L3T
 NC5A==
X-Gm-Message-State: AOJu0YwMGbSkozOb4WSyVTzhJzMlF3N2WS4Ef0BVDrJh2CASgjKuLkKe
 HijEZaPXJrc4wktWQGKFwcK1DAacNR13wy4CwpF6EDRaOLQ9T9SRQhyRsKArkd1ShxRFKekMVT/
 2DW2wBFoItngiEzoxeR0TmyDLMGicz11KyHwp
X-Gm-Gg: ASbGncv76+/QCTrAFj+KbYwoWglG4OsgF0HtiC7Gyw4IsEKpL1tzAVLEgS26LjJGoS8
 7bZzwI16ThYR63Ps3V5zYnuYqn/cG2jnixsIGjE7I5xDmXz2Nv09EX1amHeHOGGCTwQ==
X-Google-Smtp-Source: AGHT+IFVky0gy/DoUY7XYJVB/QHs2A7Pl8KWi1VaNpagO5CplIyLDm03nYrE5KQmJi0e2/Wf/qNTIR8KDsdq1GcV92s=
X-Received: by 2002:a17:907:77c9:b0:a9a:67aa:31f5 with SMTP id
 a640c23a62f3a-aa50990b2a9mr1215719066b.10.1732578072430; Mon, 25 Nov 2024
 15:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20240306185921.1854109-1-dimorinny@google.com>
 <20240306185921.1854109-2-dimorinny@google.com>
 <f2e90ccc-424e-4ab7-93d9-7ca4aaa5a600@linaro.org>
In-Reply-To: <f2e90ccc-424e-4ab7-93d9-7ca4aaa5a600@linaro.org>
From: Dmitrii Merkurev <dimorinny@google.com>
Date: Mon, 25 Nov 2024 23:41:00 +0000
Message-ID: <CAOWkq4mgzqdAjU+a3iFc7_UnsP03NTNp+TdK94t4g10tD2DOuA@mail.gmail.com>
Subject: Re: [PATCH 2/4] fastboot: blk: add block device flashing configuration
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, rammuthiah@google.com, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ying-Chun Liu <paul.liu@linaro.org>
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

Hey Neil.

Will do it by the end of the year. Only tested it with a virtio-block
though.

On Thu, Nov 21, 2024 at 12:44=E2=80=AFPM <neil.armstrong@linaro.org> wrote:

> Hi Dmitrii,
>
> So you plan to send a new version of this patchset ?
>
> It would be very useful to enable fastboot onr UFS/SCSI based devices.
>
> Thanks,
> Neil
>
> On 06/03/2024 19:59, Dmitrii Merkurev wrote:
> > Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > ---
> >   drivers/fastboot/Kconfig | 20 ++++++++++++++++++--
> >   1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> > index 5e5855a76c..460c5e98d7 100644
> > --- a/drivers/fastboot/Kconfig
> > +++ b/drivers/fastboot/Kconfig
> > @@ -87,7 +87,7 @@ config FASTBOOT_USB_DEV
> >   config FASTBOOT_FLASH
> >       bool "Enable FASTBOOT FLASH command"
> >       default y if ARCH_SUNXI || ARCH_ROCKCHIP
> > -     depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
> > +     depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
> >       select IMAGE_SPARSE
> >       help
> >         The fastboot protocol includes a "flash" command for writing
> > @@ -109,12 +109,16 @@ choice
> >
> >   config FASTBOOT_FLASH_MMC
> >       bool "FASTBOOT on MMC"
> > -     depends on MMC
> > +     depends on MMC && BLK
> >
> >   config FASTBOOT_FLASH_NAND
> >       bool "FASTBOOT on NAND"
> >       depends on MTD_RAW_NAND && CMD_MTDPARTS
> >
> > +config FASTBOOT_FLASH_BLOCK
> > +     bool "FASTBOOT on block device"
> > +     depends on BLK
> > +
> >   endchoice
> >
> >   config FASTBOOT_FLASH_MMC_DEV
> > @@ -189,6 +193,18 @@ config FASTBOOT_MMC_USER_NAME
> >         defined here.
> >         The default target name for erasing EMMC_USER is "mmc0".
> >
> > +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
> > +     string "Define FASTBOOT block interface name"
> > +     depends on FASTBOOT_FLASH_BLOCK
> > +     help
> > +       "Fastboot block interface name (mmc, virtio, etc)"
> > +
> > +config FASTBOOT_FLASH_BLOCK_DEVICE_ID
> > +     int "Define FASTBOOT block device id"
> > +     depends on FASTBOOT_FLASH_BLOCK
> > +     help
> > +       "Fastboot block device id"
> > +
> >   config FASTBOOT_GPT_NAME
> >       string "Target name for updating GPT"
> >       depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
>
>
