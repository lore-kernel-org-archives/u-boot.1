Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB1EE95A63
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 12:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 634BB86D3F;
	Sat,  7 Oct 2023 14:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GZVEomod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A41286D6D; Sat,  7 Oct 2023 14:53:12 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A841486D14
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 14:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-690f2719ab2so672827b3a.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696683186; x=1697287986; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fGwWl0ixN8M+SfA73pnNH+J5B5AbZIlsaBvFyM7zow=;
 b=GZVEomodN7GSmR/Yb92N7VUsuJxX0hoss3YOm2vjufCrD1j8ehb2lU97rA59pa5VKn
 Fh01I0g2fUX0wRNE+YyXp74KnccenI1n4UZZ25ySJfIq6grCQkU2ikg5Ip/irYV6KLyl
 8qiHypLAa1yI162lIWnzucObMQWTWAiHuyaK7Bth155Be8BSvr3EKHa2ZkQzwNwikonB
 go8nZCL5/w1FYeFDaPu//Ifr3HSfLToCOt99Kcb9S4ZwTLZDrnK8j32Nr7l1+XUwQ0aa
 K8Zlnn364qe364BrSJ3QjBKnTRs0t4VA31nZ1IsPLp6rbH11q155YfFtRvL8iacaOvCJ
 VJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696683186; x=1697287986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fGwWl0ixN8M+SfA73pnNH+J5B5AbZIlsaBvFyM7zow=;
 b=GpLIFY28lSP0dUOvhTJnU87DNOiNGRXiewwwUGNrXcL5Ge36npTnG4KBfgFoiS9y2G
 Hc5tNd5kMQ4n9A+z5LbJvs5HbP/VY2zpJnbYsVlC/ASTg7PjvTYU74gtmN1wWme2cCi7
 ahqZn+a4NEEJMR/NMlD8Ez4RIlFDxP9tVH8NkB9JcZhNYkioeYzwAOY3cufei0PL+SyZ
 W3djxn9hdPV31HDsaUVXQgeWoYFGVvCQomceSSvuVC2NEEhQqiFfM+807e9BQ/tmmp42
 oTPcMVim/CzDmrljheDCT7SpXulkaKD29PokBqh8p7l7VVdqIFFZiv+NHzRJWUmB96OA
 TvcA==
X-Gm-Message-State: AOJu0YyLbUVNEGc+aZUg2MDC0X8RnY0cPYHOqllhjb2JvZdED41ILns8
 qNePFIF/4ECOMLMcie2lr6wx+FoRIE66g7CvBDo80YWnV0c=
X-Google-Smtp-Source: AGHT+IH539s70ZIvl9+5o9Jw12U8Ach1VcR637OOTD+NBQiCAqfS/lXgQHLsgKzbHhIxgaxx/Tzk7JwORXExYoZ2kvQ=
X-Received: by 2002:a05:6a20:7f84:b0:15a:4634:e4c with SMTP id
 d4-20020a056a207f8400b0015a46340e4cmr10088993pzj.5.1696683185902; Sat, 07 Oct
 2023 05:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231004191358.24488-1-francesco@dolcini.it>
In-Reply-To: <20231004191358.24488-1-francesco@dolcini.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Oct 2023 09:52:54 -0300
Message-ID: <CAOMZO5Ana03vQmYC9_1aW+qfhMBeSHgNtRhwyneTMxTXBGOb5A@mail.gmail.com>
Subject: Re: [PATCH] toradex: verdin-imx8mm/imx8mp: Remove bootcmd_mfg
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

On Wed, Oct 4, 2023 at 4:14=E2=80=AFPM Francesco Dolcini <francesco@dolcini=
.it> wrote:
>
> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
>
> The bootcmd_mfg env variable is legacy from IMX downstream u-boot branch
> and is not needed on mainline.
>
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
