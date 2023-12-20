Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F23EC46CCD
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 18:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B02587650;
	Wed, 20 Dec 2023 19:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HnXzRA9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 820BA87786; Wed, 20 Dec 2023 19:18:23 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F73587705
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 19:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5ca5b616de0so1060363a12.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703096300; x=1703701100; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SX+9dd7rU3AfO0Q7WidUe9DEzf47Y6lEEmKYfs0ESrc=;
 b=HnXzRA9RFA5VzGTJxiBV+hzGdRGgvqM7QPC2dkVMRod95TvfAW3eipnpidXFH6ruJW
 sTgGN7zqSguBXykMuqfDWZdJTqTj71NNh1jfKR8ev2f/buicmvKottXiTaHSzVOsYCaQ
 Dx71IhqRgEsAvO19ExM561pn26rwccmEvOs0IVIEy7qzVo1w91buYJzZKvond536F4NH
 RrVcjYYkYM4NfNrTKLaKMfCCqIbUh5gudjuvwOIHCWbyGE/bT14zuAWD7kE6VB2KLDl0
 XY7mUK2WSaB915fuw9TY+tjfDCi2uc2q9nKA57cQg/qpJNTcGmLbuSzxHb/yv78mC+gN
 E8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703096300; x=1703701100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SX+9dd7rU3AfO0Q7WidUe9DEzf47Y6lEEmKYfs0ESrc=;
 b=haUfuNsTtsAonjBgi/FFNBmpz6RcIn+haPsKoxIWLLxT2cMsnySBNoLwvbBQzmO7Vu
 veUa6tsD4MFNJCNPswlYmqXicAXnSo1JdDU9f84C737DSoxnTJld1PQHpX1zybVk1PtS
 NHIb+zv4k4qr2RL25VJoII0DyTqtNgE7VXuH9Qfvq44hfl3iJEm4dLgqUPOk02wJXA4f
 GV6RA5jdxjeqcdQvz8Wyt1pK4TCoIU9qAml4x2DB0CiBLtBXdgUYFHaZI+o9MDXDhcQf
 DJhgVbLr83TvACIV+xC7e1EFgTd2AhgeFiqNiqRoR9Vz2ru0r0T1A7bCUyPvzR6PWmks
 oMYQ==
X-Gm-Message-State: AOJu0YxQoolUzyaaTN2EHaYemOm0p4xIaE90Ad3Rgz6ZwXH5pm5GSq/f
 JZtpmSfiJ4ODtuWoTVBHI/1vX1mTa4NYB+TMp0g=
X-Google-Smtp-Source: AGHT+IG/WmXA0AAWFRhg6GC2Jd/7KCtkZbcSfJayygoeBjD6WtEoUJRi6+tf/z+iv4vtEg4Ni/X/OIuGF3PBlQxgDis=
X-Received: by 2002:a17:90a:fd85:b0:28b:c22f:b1c1 with SMTP id
 cx5-20020a17090afd8500b0028bc22fb1c1mr4366738pjb.1.1703096299637; Wed, 20 Dec
 2023 10:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
In-Reply-To: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Dec 2023 15:18:06 -0300
Message-ID: <CAOMZO5BaWjErU3Y7w5T0=Xy2Ou+LZ2Xao+RdsndCCihjY-qsJA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] colibri-imx8x: configure module usb hub to bypass
 mode
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
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

On Wed, Dec 20, 2023 at 7:39=E2=80=AFAM Andrejs Cainikovs
<andrejs.cainikovs@gmail.com> wrote:
>
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
>
> This series:
> - Drops -u-boot.dtsi includes in apalis-imx8 and colibri-imx8x device
>   trees. This file is included automatically since quite some time now.
> - Configures Toradex Colibri iMX8X SoM USB hub to bypass mode,
>   and brings out of the reset state.
>
> Andrejs Cainikovs (3):
>   apalis-imx8: remove -u-boot.dtsi include
>   colibri-imx8x: remove -u-boot.dtsi include
>   colibri-imx8x: configure usb hub to bypass mode

Applied all to u-boot-imx/next, thanks.
