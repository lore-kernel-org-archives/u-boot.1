Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17FAC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B768874CC;
	Wed, 13 Dec 2023 17:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JGdEoyO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCDC58781D; Wed, 13 Dec 2023 17:22:11 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE38874BB
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-28ac70368b9so402599a91.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484528; x=1703089328; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqmFEEpuBNGxgFl85J7DiSziPjHBsq0AsoiGQ6R7f2A=;
 b=JGdEoyO4VD6FQg7d6V0KvxyTWX3VhAyRnswtwVu62C3aqgVD3otcuOIX7XiEw67cGz
 4w+7Lzg++fHjsC7MKsq9YRP9Qhb0zs66gp4BIZ/ecAsP9fDvmXR43Zkse721tOxEzMfP
 tDJFrr3qrf+Mut/TOM2d8dQUhHQCwarPneVteiUqghYF0AnVo3PaVVCgN60oy7+Tb3Cw
 ttxp+n2m+dTeM2fd+kGKnjNQrhsnl7a1rIkyk5zB9Cs2Ut3Yg9dMLC4aqsB+juu5Vvf4
 /g5Q2M1vBwSJG/3ZX3Mhz6pJgJLj0R25FRsbLnTCe8AS1mjpGNcHV239OetiQQVv/kv8
 xHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484528; x=1703089328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqmFEEpuBNGxgFl85J7DiSziPjHBsq0AsoiGQ6R7f2A=;
 b=LeE8NZ18GRFY+3kF5s6Du2FdlNxMfP5NU2I+jfrJsfqxNG18XmcKJGK4yJIX50TXQW
 si4dL8ykZFXrM8bTxVvrxFPyebKujE/U3uQh2HotwmZJR7rLeREJMZf0RI/lXNUXurfJ
 Pb8scsGIukB1AxYXYL26KQBOVhi+xbtzfdboJANNvaoG2LOUEm+deNXKxc2hlEwySbgx
 N/H6AdtEnJ8hcy3GVUbsKykai/X4wqbLPDXyVTC9xt2kX3BKCqgg3Jifwp73NtYM8EKn
 D+22fI0nnGI3ixJQq/2IsOTdFSXcjFWrxAd31Yqu3RE7sJR6mSWePZMJAaezGW21o2Jp
 CAbA==
X-Gm-Message-State: AOJu0YwRkveIy8+l+6tKmkLFER5BUqhA0lDMJCt2Nw+Etnfph4zYELgB
 TFzJDyinF45ZJ51+dlC97sDxlnVPkEDeAFGuJvQ=
X-Google-Smtp-Source: AGHT+IFtTRKyhGAJFhVfGIKCz/Qdm66sEn8wCWWDelRCfmaLN3jlUvhas/0yXRNYDrpKeiD1SULXox6kuSebhIa+jAY=
X-Received: by 2002:a17:90b:3a82:b0:283:5405:9e90 with SMTP id
 om2-20020a17090b3a8200b0028354059e90mr14014476pjb.3.1702484528057; Wed, 13
 Dec 2023 08:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20230523192155.33222-1-gilles.talis@gmail.com>
 <58a07085-3926-b942-fb8c-58f1f5eac421@oss.nxp.com> <877clq6odx.fsf@redhat.com>
In-Reply-To: <877clq6odx.fsf@redhat.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:21:55 -0300
Message-ID: <CAOMZO5C=N408U+dY+C-czBSGYMexmDeiUdyzwLkLjZcy7DtS1A@mail.gmail.com>
Subject: Re: [PATCH v2] imx: imx8mp: Add support for Polyhex Debix Model A SBC
To: Milan Zamazal <mzamazal@redhat.com>
Cc: Gilles Talis <gilles.talis@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 uboot-imx@nxp.com, u-boot@lists.denx.de
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

On Thu, Dec 7, 2023 at 2:15=E2=80=AFPM Milan Zamazal <mzamazal@redhat.com> =
wrote:
>
> Peng Fan <peng.fan@oss.nxp.com> writes:
>
> > On 5/24/2023 3:21 AM, Gilles Talis wrote:
> >> Add support for the Polyhex Debix Model A SBC board.
> >> It is an industrial grade single board computer based on
> >> NXP's i.MX 8M Plus.
> >> Currently supported interfaces are:
> >> - Serial console
> >> - Micro SD
> >> - eQOS and FEC Ethernet
> >> imx8mp-debix-model-a.dts is taken from Linux 6.3.
> >> Signed-off-by: Gilles Talis<gilles.talis@gmail.com>
> >
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
>
> Do you know why the patch has been left (as far as I can see) without
> further action?

Applied to u-boot-imx next, thanks.
