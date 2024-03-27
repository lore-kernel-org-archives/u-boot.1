Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286DAC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 01:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86FAE8801F;
	Wed, 27 Mar 2024 02:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZKDbCOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92BEF83CF3; Wed, 27 Mar 2024 02:18:26 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 437528810D
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 02:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e694337fffso906794b3a.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 18:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711502301; x=1712107101; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlZ9RkK9MfpWjp2yQoRNSsVKbuExtdNY5QEW30CAvN8=;
 b=QZKDbCODoMtMjupiLyuLI4cir7FumA4i1CVn2FewYqvCR9PtnGhyhBwGotCxb2ud0l
 EwCfRXj//VBhDTPtrZpbdQgsRsuB05w4K3sQF/bOOUNXryHAbri72KH52vP0g9hCPRv6
 y7TaB/jfzW8Yc3RAYnxRzn3rTxyhgxu+3IiZG86RSqb0wrKZjLrMjSkD69PECMHhDdM9
 jfD7UaUJ2Svb8Js9+kXlmUKCB5BVVz+HBuISMI3xbkOt4k2IKsqe3cL3Wn+lZNr29ktj
 bU07z9rpK9OKG8MRbWC3JaLI8+jQbbsXccsmVSFyIrWk7w8+M5zy2DlJqq/BWR2Ggf3r
 EgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711502301; x=1712107101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlZ9RkK9MfpWjp2yQoRNSsVKbuExtdNY5QEW30CAvN8=;
 b=QzlVypP10w20SQP3Dd5XKQy7HkECYLzOuBN0tONa5tXj6ivc6woa99FBPl27B/qxZ9
 S1j85RhIEAXpYZC9e8AhNp9jYjuI2ebvnzWwNZZu/X+x2YxM2SRnEg0eRWMK+oIIrCUK
 Jgct4zuxXMOMgGHhIvCIFsh/MwUtH41EAN0mwxKT0fg8QBZI+TGbD35c+BisE+jD7mSC
 OMWX+KXLQvsggAiiSFRXRl1GwnEv9b1E8vUbgCYhQaWciZYduxJImTwjfZdlGtQv+pnk
 pe2Gq8NMh49TaiS+ID4AW30X4/imOb76I1b4NneDBI+gKQjOoU4oweL0BzeouA14BS+5
 qRzg==
X-Gm-Message-State: AOJu0YxLtTH4lfQpGeOQtJx5ExVuU+KMeK95+HxUzAMXhNT4fpXU5+wZ
 nek4DmtXNgAJmLqrfHdGJvjpP/Mzv19z6LJj0o+4XRwQPBNAouyAj9ERuTntrVFOlIt2ZLkD4Hy
 QllNRhXHfdmLsx20Yp23Am0ytGfLv0EKz
X-Google-Smtp-Source: AGHT+IHamh28I6xIOJZS59pE4dzRU2IVw39n1DkHfEWD0x91RIuJLacO+iyKahdjQ/kRYV4ch0etP3ZAEI+GfeDLaKM=
X-Received: by 2002:a05:6a21:3293:b0:1a1:481b:475d with SMTP id
 yt19-20020a056a21329300b001a1481b475dmr13963235pzb.6.1711502300651; Tue, 26
 Mar 2024 18:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240326110656.21110-1-javier.viguera@digi.com>
In-Reply-To: <20240326110656.21110-1-javier.viguera@digi.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Mar 2024 22:18:10 -0300
Message-ID: <CAOMZO5DYmkp6Wm79bBFv3fFuVWu+LghiKqPkC5kcLnW21Umy3A@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: fix signature_block_hdr struct fields order
To: Javier Viguera <javier.viguera@digi.com>
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com
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

Hi Javier,

On Tue, Mar 26, 2024 at 8:07=E2=80=AFAM Javier Viguera <javier.viguera@digi=
.com> wrote:
>
> According to the documentation (for example AN13994), for AHAB-enabled
> devices the format of the signature block is:
>
>   +--------------+--------------+--------------+-------------+
>   | Tag          | Length - msb | Length - lsb | Version     |
>   +--------------+--------------+--------------+-------------+
>   | SRK Table offset            | Certificate offset         |
>   +-----------------------------+----------------------------+
>   | Blob offset                 | Signature offset           |
>   +-----------------------------+----------------------------+

Could you elaborate more about this and share more details?

Have you seen a run-time error or did you catch it by code inspection?

Please clarify.

Thanks
