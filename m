Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFE6C54E68
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 23:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E843687FE9;
	Mon, 18 Mar 2024 00:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JdYTdF2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C99B387FEF; Mon, 18 Mar 2024 00:55:58 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CD387F3F
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 00:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dd8ee2441dso7004715ad.1
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 16:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710719755; x=1711324555; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ks4TLz0cGIYDzxL1GmDw2Sr03ZsqaNoKuv9RyWVCLOI=;
 b=JdYTdF2kcikZ+ZTc3oJVjvPwPiYYjqixD/LTtcKdYoRcS691prNMuGtk5YjyHrd84s
 MTf9qOlLmv4E0HwTA9LBjYrAE5f/kvpHS+jpookCXZBbe/BPc2pMeQkboo5Y6xQ6RHF2
 KnwK7iU0sGTm3FBWLxu39GlmXXu9kVbGy13Ib0wTYPDCI83AgSgnT+48i9IdR0E5j2/S
 XeGupjMrOT/Kaoa8qhmS60PxvlqqvbL3Z5fI5ppDsy+NX5438N6q0ZSCVFo657HG1sPJ
 EOunEtcK6WiKzP+ZmAytWTIZp655lyNVfr0Cx/NkEP8GVXqM3mGE3oV93AWQQPAOM2C1
 eIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710719755; x=1711324555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ks4TLz0cGIYDzxL1GmDw2Sr03ZsqaNoKuv9RyWVCLOI=;
 b=OvEtJm8atfwelYwZsLwBk3ZPQlzliNfYMPvJiIiIyMzKgzWdCcWG6bstakittX6QOD
 YhVM9JmDwgbf48AUOaLoQ9eY2ca9Jp9WKZF4ZtfBO+bQ+ancpuUcTteNZLey7KqEhH2r
 t7IOxdP3LyIyhU3nkTPw53D2ig7FQLBbtHTnrtHEQMTx8O+yDCPRZf1PBs6AzA908Mw+
 2oKMrFMXuVSXsxvhjRQarWufHxMPiPhu1CIGEGKxmQuiS2cRAaPeWVrd8+G9IqeiAIoD
 3aZ71ARAWdGvMkcVC4whH9XXT0UU+A3mdMNsmyW8pUYaTliHIc8Iaw3b1oY46Q44ytzE
 7dKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm01ONXwnE8NIGn6SiSIoiyi6XsswS1gzbgtRk0LClLOqic6RuiKW3DfhI3Z/MRvnRPKAmn9AFAaVCyMYl4hL3ZoYSuw==
X-Gm-Message-State: AOJu0Yw7LvUHkQL3mCdvV9nuFxJPVzvL4v8i8/W1VtwCT4746vfqqbT2
 QMzng3nh5T2ZJ6DdDb32ipN1XS1ABPVthqHyG81QrmC1OplBTWQXHDnz5WD1W+pAik8bwbjqYxc
 3HuhkQGo80OKkvNWtbnRLv8tnCNY=
X-Google-Smtp-Source: AGHT+IHQh1IjKo8HX4Jjl7AYJ8KSr5UVYxZjGs1+lWkhMqG7tDv1nmEhoQ26aKAO4dw6xizTyGQzJzGSrlnzqOzuP0I=
X-Received: by 2002:a17:902:d501:b0:1dd:5a49:7a98 with SMTP id
 b1-20020a170902d50100b001dd5a497a98mr13803658plg.3.1710719755048; Sun, 17 Mar
 2024 16:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240313005941.2654166-1-festevam@gmail.com>
In-Reply-To: <20240313005941.2654166-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 17 Mar 2024 20:55:43 -0300
Message-ID: <CAOMZO5D5AGL3xk355TY-A5f66FMKL3=P4rZTeKXxcQ+=LmUHTw@mail.gmail.com>
Subject: Re: [PATCH] apalis-imx8: Fix sc_misc_otp_fuse_read() error check
To: festevam@gmail.com
Cc: marcel.ziswiler@toradex.com, hiago.franco@toradex.com, 
 francesco.dolcini@toradex.com, u-boot@lists.denx.de, peng.fan@nxp.com, 
 joao.goncalves@toradex.com
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

On Tue, Mar 12, 2024 at 9:59=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Commit bfb3409d676f ("imx: toradex/apalis-imx8: correct SCU API usage")
> made an incorrect logic change in the error code check of
> sc_misc_otp_fuse_read():
>
> -       if (scierr =3D=3D SC_ERR_NONE) {
> +       if (scierr) {
>                 /* QP has one A72 core disabled */
>                 is_quadplus =3D ((val >> 4) & 0x3) !=3D 0x0;
>         }
>
> The other changes in this commit are correct.
>
> sc_misc_otp_fuse_read() returns 0 on a successful fuse read.
>
> This inversion causes board_mem_get_layout() to report incorrect RAM size=
.
>
> Go back the original error check logic to fix the problem.
>
> Fixes: bfb3409d676f ("imx: toradex/apalis-imx8: correct SCU API usage")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied for u-boot-imx/master, thanks.
