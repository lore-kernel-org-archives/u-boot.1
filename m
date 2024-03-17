Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBC4C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 23:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 035FA87FCD;
	Mon, 18 Mar 2024 00:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mx3bLRgR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C0B87F3F; Mon, 18 Mar 2024 00:55:13 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3252587FDD
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 00:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-29c572d4b84so1377843a91.1
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 16:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710719710; x=1711324510; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JQ2y/95wNTkyvUJ8UT1Q3wnvemRjqeDx45BFRmqv88=;
 b=Mx3bLRgRXQxffT3GQebnYuhvaA2GrLyhWSDGQkui5vKl7XGLBcxNbdhggX6ycGZ/4o
 pm35Tf/5VdW8svcG6hbIyG116YAMK8OO+bzOoi8Ioo3P3j262pH/SAi9e2TyoJl7z9A+
 tBOmfSCT31RWozEdlsWyUvcjIrDcYDP2bqcPaw3Fo8bpjBCJAiPYQ+zgRe47Vgxc5/lb
 pCvMShb3OrOqIKZqecCGGb3i5fv9KnJ1wC+IEMHpDYC8HXRdJUx2D6cmw0Mby2bfvZJ0
 Weolpd4SkPNAAJGSvkCQvgFdwAylVaGmesVaKNscvqfOWfIwcYl+m5j1AEU8dx4REs7R
 Fg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710719710; x=1711324510;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JQ2y/95wNTkyvUJ8UT1Q3wnvemRjqeDx45BFRmqv88=;
 b=nbi4tTAS9DEhiz3a/hYFBjiyhTTx+BRJERMpn3d8ucoobOxrJnyh8hEQITMnngoOIM
 kumScLJPJLOSWSTwfKRs3hS2zEpeCK2pVXYy+OrMRq1JXIQWCh+UrlPMFvmO2NbH39OV
 T+eqzGZtRVUP8SsCtwiIJ7GsQ+97ox0xDLzalJmhW7LQF3sYtM5RaZCsYgcR8fXPUc8p
 TjgdQGvU8h4Tcj5ngE9VDa3b8/Nd4ybLNl++P0ecorussuvevLTgrmyK+poD4AlSdcsk
 66ASc4ople/pnHIiH3VUFyuBMGr6bLD/Xjha3MMe0Mup2ZVeFeE5SUjLQlHlb2s1NyJj
 sjGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFeK6ay01zGqw2Sa+ofoRwipj2Rtxj1I9BiRWKR0dOaVLBhAACPN5SYW4M9xu63BNCwEqsiiQimL9JCDVhkDw4keserA==
X-Gm-Message-State: AOJu0YysI4TJRm/aAtCu11Vg5pudKZV56DWBJdzS05fJDilxf7D1hWyE
 LR1uacr9f7jNsbm7sS+UoordiqUiBqZZyrOvbbtIH3W4bTA3abCdsQwfksVWXCieuh7WHNLxPPZ
 TTMSZISEKYGOTZF7AElw2FDxn3l4=
X-Google-Smtp-Source: AGHT+IGf1yzxQp5CTqAlgMBvnvXCBJjZ631m3U3c1DO7DGMWrti2Si0JTa6NVoQbyxwP3X/cjdpGWTIjX8w4GgGfZP8=
X-Received: by 2002:a17:90a:a409:b0:29c:7697:d2dc with SMTP id
 y9-20020a17090aa40900b0029c7697d2dcmr9310687pjp.4.1710719709737; Sun, 17 Mar
 2024 16:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240313003641.2650648-1-festevam@gmail.com>
In-Reply-To: <20240313003641.2650648-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 17 Mar 2024 20:54:58 -0300
Message-ID: <CAOMZO5BWZsJx4T9kGbtTkLasD4R=+vRB4T6fLMariK1bGG83qQ@mail.gmail.com>
Subject: Re: [PATCH] colibri-imx8x: Fix sc_misc_otp_fuse_read() error check
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

On Tue, Mar 12, 2024 at 9:36=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Commit aa6e698a7acd ("imx: toradex/colibri-imx8x: correct SCU API usage")
> made an incorrect logic change in the error code check of
> sc_misc_otp_fuse_read():
>
> -       if (sc_err =3D=3D SC_ERR_NONE) {
> +       if (sc_err) {
>                 /* DX has two A35 cores disabled */
>                 return (val & 0xf) !=3D 0x0;
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
> Fixes: aa6e698a7acd ("imx: toradex/colibri-imx8x: correct SCU API usage")
> Reported-by: Hiago De Franco <hiago.franco@toradex.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied for u-boot-imx/master, thanks.
