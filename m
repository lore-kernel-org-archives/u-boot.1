Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5142E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 08:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23CCA8005B;
	Mon, 16 Dec 2024 09:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="d3OZ3r8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D86398005B; Mon, 16 Dec 2024 09:27:21 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE4C78003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 09:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chf.fritz@googlemail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e2880606so3444958f8f.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1734337639; x=1734942439; darn=lists.denx.de; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=My9XtVOx5Nlxhw1VB7xZEo76+++nPweOGujvaf5nMcA=;
 b=d3OZ3r8IJPATTdDG+YsTvOIWV/ud8T1H/NlZxUVehUgdzjkMimuwMZRhg+xdE3x8bq
 lXvSLa3dOQCb8tvoiuonMsDQVZJutmc/3pRMxbnG6l6dPDKqTE7a28KHVSln5OOdQlry
 1nEWdgHjxdHQ/0rsel20MHquBS4iZj2x8PJRjDQShpneWPbJUgGN6t+FAZ1OlBnN9FFb
 bbebB9Sr+UPQ2vv3FVORzPXnSNEmnBWW4FETTgnbXQL8D4IQBfpYtgow9H/OOq4T8ta3
 ojGPkKzgDDBUBw5NAOUDaMjvmYSF05mpwZ/58/uovNGCU7nnhaE4BW4i8uzfXHHmdcx9
 9FRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734337639; x=1734942439;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:reply-to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=My9XtVOx5Nlxhw1VB7xZEo76+++nPweOGujvaf5nMcA=;
 b=wPs3gzn2YCQc9aJbg0Iu9TFqQ8RFLwLcLG1SADm4AV1zumXjsK9c265crF4x5OOkQa
 N4AJA2VmP2TND6JPVvRuuSf/GRTiEBNN2bHCKfa24ms3hSgVl4E0J/mLvfaNNDA17olu
 Tp6ozeKRrmv8BoM3zFe2OA2rHbQpreE5OV4brxTKsZpJ6mOSJ9G1BMIply0pSNHFkv/v
 BoeVvfGdr3JkMasi26A1Z38bu2ebDQY/TK+IAkt29rNyBqY7mYZ0c1MGBIraPj6QCPaL
 r+5UYnxn0mbCeMM89L+B/3g+/MvvtMZfxao4YsY0phv6O3xcYZuWVm/8zkhmK5jMFAar
 3G8w==
X-Gm-Message-State: AOJu0Yw021/zjTdkKeKOejBNaQumeoDdTm8shhPEdBQH49ILHt3bISsA
 jTmAy/eTToy6D/0Qn9mmcMt2Fz1uqAaiRvV7FSN13psIHOrkoHZmvKigrA==
X-Gm-Gg: ASbGncvOzidhgmw5ny/4dc11xcH54m5Pxr7nPb/vAvYc8iUt28TO7GctHGhAdGt2adG
 qYZa9J6knEcPMub6xRcg2sX4G1oJ/RTPznssXSJtOYg+eUOQwK1VIuJkTSfftReGHVNCBqTZeZ3
 1Gt0wEouPTH5uE+3bBYmWO+Vhb6uhIf+TanGGT4Vq+5ZGT/JLtxw8oYkSbz2y5dUDawshDITA0a
 8ux0hNQJeq4HXgw5+okEwRp7YQNB6gf6E+959K7H05J5UN5U+i4aMu0Jg91pM7MFWQek1M=
X-Google-Smtp-Source: AGHT+IFPsL/YG+/1e1vBJJXyqxKDQayxvFv5Zl68t0yuBOAB4gbBSBbAiUnHVRFTlTWdmzH8h7l/pg==
X-Received: by 2002:a5d:6d8e:0:b0:386:43c9:3ac2 with SMTP id
 ffacd0b85a97d-38880ad8785mr9559688f8f.15.1734337639095; 
 Mon, 16 Dec 2024 00:27:19 -0800 (PST)
Received: from mars.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060582sm7321959f8f.93.2024.12.16.00.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 00:27:18 -0800 (PST)
Message-ID: <01420bb81265f69bbcd56dbe658fc0528d94e87f.camel@googlemail.com>
Subject: Re: [PATCH] imx: hab: fix srktool -c usage by removing spaces
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot <u-boot@lists.denx.de>
Date: Mon, 16 Dec 2024 09:27:17 +0100
In-Reply-To: <CAOMZO5BezDHXphjvX+Kat6rFq5zYC5yVucET2NzTHdFYnYTqXA@mail.gmail.com>
References: <33e7b95383c1e5dd20f4cd2e30b88391a09e0858.camel@googlemail.com>
 <CAOMZO5BezDHXphjvX+Kat6rFq5zYC5yVucET2NzTHdFYnYTqXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
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
Reply-To: chf.fritz@googlemail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Fabio

> On Sun, Dec 15, 2024 at 2:04=E2=80=AFPM Christoph Fritz
> <chf.fritz@googlemail.com> wrote:
>=20
> > +  $ CERTS=3D"SRK1_sha256_2048_65537_v3_ca_crt.pem"
> > +  $ CERTS=3D"$CERTS,SRK2_sha256_2048_65537_v3_ca_crt.pem"
> > +  $ CERTS=3D"$CERTS,SRK3_sha256_2048_65537_v3_ca_crt.pem"
> > +  $ CERTS=3D"$CERTS,SRK4_sha256_2048_65537_v3_ca_crt.pem"
> > +
> >    $ ../linux64/bin/srktool -h 4 -t SRK_1_2_3_4_table.bin -e \
> > -       SRK_1_2_3_4_fuse.bin -d sha256 -c \
> > -       SRK1_sha256_2048_65537_v3_ca_crt.pem,\
> > -       SRK2_sha256_2048_65537_v3_ca_crt.pem,\
> > -       SRK3_sha256_2048_65537_v3_ca_crt.pem,\
> > -       SRK4_sha256_2048_65537_v3_ca_crt.pem
> > +       SRK_1_2_3_4_fuse.bin -d sha256 -c "$CERTS"
>=20
> What do you think about simplifying like this instead?
>=20
> --- a/doc/imx/habv4/introduction_habv4.txt
> +++ b/doc/imx/habv4/introduction_habv4.txt
> @@ -244,12 +244,10 @@ Table Hash.
>=20
>  - Generating SRK Table and SRK Hash in Linux 64-bit machines:
>=20
> +  $ CA_CRT=3D"sha256_2048_65537_v3_ca_crt.pem"
>    $ ../linux64/bin/srktool -h 4 -t SRK_1_2_3_4_table.bin -e \
>         SRK_1_2_3_4_fuse.bin -d sha256 -c \
> -       SRK1_sha256_2048_65537_v3_ca_crt.pem,\
> -       SRK2_sha256_2048_65537_v3_ca_crt.pem,\
> -       SRK3_sha256_2048_65537_v3_ca_crt.pem,\
> -       SRK4_sha256_2048_65537_v3_ca_crt.pem
> +       SRK1_"$CA_CRT",SRK2_"$CA_CRT",SRK3_"$CA_CRT",SRK4_"$CA_CRT"

thanks, looks great. Do you want me to adapt the patch and resend?

 -- Christoph
