Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75837C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D8788926;
	Fri, 14 Jun 2024 14:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FkGy5SQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4A59886B9; Fri, 14 Jun 2024 14:51:05 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3635C88926
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f70131063cso18638205ad.2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718369462; x=1718974262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HvbmoQJTnu2qe9MnT9Zma1kl2qdGSn7UK7FyjepGIcA=;
 b=FkGy5SQKVepzHT6/z2aXYZpD2At9DdQ2R13eCaV5+TqHB4WfWtfrZen71heYF+EF/z
 bY+Ry0kZPjC4gtk22ayEgvYPJqpqBYDvo4oJbFSVy/qxwWgnnzZazU/wnyWnbGQiLkdd
 UF7Q7lh+FpdRrxf0nm4x07RQiVQGumlqG98or9o39BIzOfhatcON/ZiPlBA4oja2eJgS
 6b4o7PdeKtdas/Jvy/vYfqQkYH2mzeWpqSqIuVKofLu6mGEvupbmlYEa2DKblaXKbZ32
 zD+70zG9BXC/+WAt/NBLvfIsbyYcFfLiLg4OWR7eRV1FuHzgwV1DEpl16qr5Su7gELGq
 JI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718369462; x=1718974262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HvbmoQJTnu2qe9MnT9Zma1kl2qdGSn7UK7FyjepGIcA=;
 b=TGlvUYwl8BzZsMCuk/pZvKeMgaayKAkcmo0i9aYUnotd6eSssa/GTxyu9Bk+C3yPk4
 vEOdC9riABJtnU73UhnOfLK5h8URwEGpL+Aeema+ws02q+cEX3KwUATeRoU8Ohq9l2K9
 e0La6QU2+91hI+t1hplvHdDE2VhT+B4BkLtG9GLyoZwfJiNzn2vBcIVxRAIjEB0UTJPT
 Vpp7xeGKO/zevZ88GJTFIfWmIBozBRV2zHKQZmLf6Eb/sM/7IAQANS61OjLcoUlnTNTr
 2KOt7ztVzVLiXqpMlMt9yxdTilWA7JUfk127fxdbHe+1Xm2v4ARHSgO4TjaTRgvmMKAr
 H6kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAm5p+t8rY4IVJRooBXsPB+6GKSlURQkxwGbedfRn1W834ggXTQZxDNLw+IW5+Re2h4GOohA/Nn6ZTPBvK1oKT47bxmg==
X-Gm-Message-State: AOJu0YxkO/IagyzigyRhWH6etAmQMDHTuf7KJzc0gx9/+ifI32MYQY3b
 r+xLmwFZguHb4n+2zYIxYgf0IePxqWVES3Iy6C04ebdKq4XixYkpkUKFMY8Ad5rufAA1tLH6vDy
 ItFXQEXeeV/1oWpQMRYq2FTI1Yq95MvYdrUJXdA==
X-Google-Smtp-Source: AGHT+IGTaMQ9hX7j39POIEGgkMnzIkVWmYy5s2pTZ6tHY2GqZM2lk6RfnjMNJqekqDpBPx/dUv25FHSiBv9thspFJrg=
X-Received: by 2002:a17:903:32cc:b0:1f6:e1ba:221d with SMTP id
 d9443c01a7336-1f8625ce83fmr31807035ad.1.1718369461679; Fri, 14 Jun 2024
 05:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240614121404.16952-1-ilias.apalodimas@linaro.org>
 <b9307a87-5c4b-4ef3-b635-86879b2a9742@gmx.de>
In-Reply-To: <b9307a87-5c4b-4ef3-b635-86879b2a9742@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Jun 2024 15:50:25 +0300
Message-ID: <CAC_iWjLKETAM+0BsnTf+fMvdu4JbbcX+Ts3-bqL79+964NwmLw@mail.gmail.com>
Subject: Re: [PATCH v2] doc: describe UEFI measured boot
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Eddie James <eajames@linux.ibm.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 14 Jun 2024 at 15:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 14.06.24 14:14, Ilias Apalodimas wrote:
> > We currently only describe the process to enable measured boot using
> > bootm. Describe the UEFI requirements as well which predate bootm.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Changes since v1:
> > - fixed remarks from Heinrich on titling and DTB measured PCR
> >   doc/usage/measured_boot.rst | 28 ++++++++++++++++++++++++----
> >   1 file changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> > index 9691904a9d8a..b5f7b05aeb02 100644
> > --- a/doc/usage/measured_boot.rst
> > +++ b/doc/usage/measured_boot.rst
> > @@ -7,19 +7,39 @@ U-Boot can perform a measured boot, the process of hashing various components
> >   of the boot process, extending the results in the TPM and logging the
> >   component's measurement in memory for the operating system to consume.
> >
> > +The functionality is available when booting via the EFI subsystem or 'bootm'
> > +command.
> > +
> > +UEFI measured boot
> > +------------------
> > +The EFI subsystem implements the `EFI TCG protocol
> > +<https://trustedcomputinggroup.org/resource/tcg-efi-protocol-specification/>`_
> > +and the `TCG PC Client Specific Platform Firmware Profile Specification
> > +<https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/>`_
> > +which defines the binaries to be measured and the corresponding PCRs to be used.
> > +
> > +Requirements
> > +~~~~~~~~~~~~
> > +* A hardware TPM 2.0 supported by an enabled U-Boot driver
> > +* CONFIG_EFI_TCG2_PROTOCOL=y
> > +* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=y
> > +* optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=y will measure the loaded DTB in PCR 1
> > +
> > +Measured legacy boot with bootm command
> > +----------------------------------------
>
> nits:
> The length of the underline should match.
>
> All of bootm, booti, and bootz invoke bootm_run_states() which calls
> bootm_measure():
>
>    Measured legacy boot
>    --------------------
>
>    The commands booti, bootm, and bootz can be used for measured boot
>    using the legacy entry point of the Linux kernel.
>
> Otherwise looks good to me.

Thanks Heinrich, I'll send a v3

Cheers
/Ilias
>
> Best regards
>
> Heinrich
>
> >   By default, U-Boot will measure the operating system (linux) image, the
> >   initrd image, and the "bootargs" environment variable. By enabling
> > -CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree image.
> > +CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree image in PCR1.
> >
> >   The operating system typically would verify that the hashes found in the
> >   TPM PCRs match the contents of the event log. This can further be checked
> >   against the hash results of previous boots.
> >
> >   Requirements
> > -------------
> > +~~~~~~~~~~~~
> >
> > -* A hardware TPM 2.0 supported by the U-Boot drivers
> > -* CONFIG_TPM=y
> > +* A hardware TPM 2.0 supported by an enabled U-Boot driver
> > +* CONFIG_TPMv2=y
> >   * CONFIG_MEASURED_BOOT=y
> >   * Device-tree configuration of the TPM device to specify the memory area
> >     for event logging. The TPM device node must either contain a phandle to
> > --
> > 2.45.1
> >
>
