Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA34FC5472F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 19:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41C2687B84;
	Tue, 27 Aug 2024 21:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SIBHSNWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8CE87B84; Tue, 27 Aug 2024 21:27:00 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE67B879C1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 21:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e179c28f990so4917036276.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724786816; x=1725391616; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Kq7vX9m16k3VS+7aKTFxnxYe1sxYsl7sxrpKAO9EsA=;
 b=SIBHSNWD1EtoGCKTcQpuvZhsGkpFqExP7iOBsJSDDSFFvwtmuBzduZPzMZ51Jhq+0c
 /lsB3GJDSkpiAokcgLOySVJMPNbS+GeaFKFvTtQxuhx4D/QEOgIRHH6A6V916qAahsm1
 FgNOonP0ctO9z8GpkxOTdjttP1KAcbyX7n5so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724786816; x=1725391616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Kq7vX9m16k3VS+7aKTFxnxYe1sxYsl7sxrpKAO9EsA=;
 b=SCehTEAO9F42WGFKvGitri0lL15EKhnI1o1YAWKp9VtdITO/WoZh0ZORqJ8pK1oENU
 WXeDn9JP8hDxF40Awu9EU0RmLs0Y7tQFvXzyZBBBadRxyYEdXmbYu9K/zo7+l4E8ftqM
 oqW+JMAPjbE6/amccapIimgM7eC/EbUkOnaEa7GArjcWF8LPchhKDCD4lx+/eaKdUbzS
 M7gbizR7dsvuRlspFnb0IV23O3ZOOSL6nLi0TiKcTlt8V9CZxDUgYjlfb0rGR6RbHtlX
 +Kj2a5CX6wJkNoi8hGYffcX4RJ7CO5vADM+PnG/WYy675UNyh9rBFJ/uLrA8Sc7g4bOH
 b6OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9gtcODj+Xu69YpY0zko/yGayMfAov0LyTq8vPNek4EcyjFVZRUznuunhGcQ7ztwARVKHzgKs=@lists.denx.de
X-Gm-Message-State: AOJu0YycCR8WvXJY397qmoltSPPLvc5if9NFTNNQT3X09SzRZlJvf6lm
 MwO27W6icJiuz+GdERPNfOogCbBfxYD5t+VlY67paR18ey//KvDMW/uL1JwzRw0OxqyoHt+pXpZ
 usAri15Pg9AYMFYtsrBJNYixDFsfVxbTjTgWp
X-Google-Smtp-Source: AGHT+IGxVUCgD5kZyBSUKFg+ruB1wy996/PGMEkpAbmqEUtLjB2EsEOoAWCv3I77/cnFqEpZK8XAEm8E6UB7MJUvRfM=
X-Received: by 2002:a05:6902:2d04:b0:e05:7c38:1085 with SMTP id
 3f1490d57ef6-e17a86639ecmr15893391276.41.1724786816469; Tue, 27 Aug 2024
 12:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
In-Reply-To: <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Aug 2024 13:26:45 -0600
Message-ID: <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
To: Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>
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

Hi,

On Tue, 27 Aug 2024 at 12:47, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Lukasz,
>
> On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski <lukma@denx.de> w=
rote:
>
> > Unfortunately not - this change is only for properly setting start
> > address of the u-boot.
> >
> > The _real_ problem here is the symbol placement generated by binman
> > when we try to define the image as a single one.
> >
> > Moreover, this change follows other boards with imx8mm processor -
> > ./configs/imx8mm_beacon_fspi_defconfig to be specific.
> >
> > The "fix" (for which I'd been now probably opt) for this issue would be
> > to generate two images with binman - one for u-boot-spl-ddr.bin and the
> > final flash.bin with the former one included (as it was before SHA1:
> > 37e50627efacd8dae18b564e9d8886a033e181bc)
>
> Is QSPI boot broken on i.MX8MM?
>
> I am adding Adam and Mamta who have tested QSPI booting on
> imx8mm_beacon and imx8mm_evk, respectively.

Note also that I sent a series[1] which allows the symbols-base to be
adjusted, if that helps.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D421010
