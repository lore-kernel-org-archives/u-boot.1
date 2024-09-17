Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0026C35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC36088D9A;
	Tue, 17 Sep 2024 14:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TFCgUyNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41EAE88D9A; Tue, 17 Sep 2024 14:23:08 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B3688969
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f7528f4658so39173391fa.3
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726575786; x=1727180586; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PIYuBHGgmmU6xFt4uUrlAaa8V5aJqO4YzSDcDteQFCs=;
 b=TFCgUyNx8IBLpR271GyqNps0WykRRSL6HRBC8reAQq1uXR9tyyQ+fChoCE1bEwQAnU
 at0hug8B6pf4A/gQX+BvYpLddrsWwwKoTCGXJzaXO1JfCyDNLlNKFwuvxUcBYY8ZDMM8
 X/oVRDT3jBqv5g3elr05rRMpH1A3r3f3ojuuDfwmLco+RGlU0MFT+qSwfBf1wIiVyx77
 wON0CLSBdWbJEWCSZ0G95tXLOw+Y3aSI9Z4GSwLA0lgIhh+HHDL9Jjr4DnGt0UeH3JgS
 gd8u9bpX6oraVQnUGA2v3bHvjTcmZEuZNWPCbQtBZ64vzhF2yejf31toFN3gpbqP2pxM
 CWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575786; x=1727180586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PIYuBHGgmmU6xFt4uUrlAaa8V5aJqO4YzSDcDteQFCs=;
 b=tOhV5YlqYLip4NixpkR+PVsBZxfnJt/32ZvQLGUX6f2IqMWI33EkU49O9kUKSYZ6tG
 25Ln84X2umVAWCavclk36Jg/x89Ag75Dp+RTcAF9SpmA+uW/y3mp/HJHRw1ZZL9COWcy
 SLn+JZ+X6GDLY+QIzrMenVPLGpTXxptGtLNF0bK3N8SkskSzRL2t7M0emtnxEJP/SRte
 awy3V48YOx6o0Vcr2GDn2N0LD1EKPjVLF9OXb6SJZgybx2xEZkyH+l75ZpmNTNyEimJm
 hP0j4X1izUEay0CK90qrdK2YEogk2xwBpNeztjUy18pQwQQODDg4a21G9eYpGH6K9JRq
 z+qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbCLflC5fXvLcOX20Xvh7h5kGWXagZ6dX41T0V/aOvzKGe7/p3l0wUaqw2Sqhif6bY3W9ZXC8=@lists.denx.de
X-Gm-Message-State: AOJu0YytHPIcMonURnf6XAUphgTAdDe+jxzMjCZHqJh+DehhUXwgX0hm
 J1vo/jwOyQq6PecUVOzclfgNUtn9MTnSHfpWCIr8NyM0lXVqnKl8hd9sobgn94Xbi6aQ3Uhukig
 dEyhVhtGNnn2Tyk8BniBi8Z9AOAc=
X-Google-Smtp-Source: AGHT+IHj70390ILJckx+dOGvUHyXOyNvN78hPvzXyhrYBh59k/mgo7hLjkhN6q2xt9WrZqnkCUeBb1xiw+7ZspbJTew=
X-Received: by 2002:a2e:b8ce:0:b0:2f7:5d53:7196 with SMTP id
 38308e7fff4ca-2f7918e843bmr79145441fa.4.1726575785382; Tue, 17 Sep 2024
 05:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-6-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-6-4fe8effc937e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Sep 2024 09:22:54 -0300
Message-ID: <CAOMZO5AVyeTauRe7KKMxwa-1zueiam5u1D=3DsQ34=xryfx85A@mail.gmail.com>
Subject: Re: [PATCH 06/21] imx9: soc: Change second Ethernet MAC fuse layout
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

On Mon, Sep 16, 2024 at 11:30=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:

> +void build_info(void)
> +{
> +       u32 fw_version, sha1, res, status;
> +       int ret;
> +
> +       printf("\nBuildInfo:\n");
> +
> +       ret =3D ele_get_fw_status(&status, &res);
> +       if (ret) {
> +               printf("  - ELE firmware status failed %d, 0x%x\n", ret, =
res);
> +       } else if ((status & 0xff) =3D=3D 1) {
> +               ret =3D ele_get_fw_version(&fw_version, &sha1, &res);
> +               if (ret) {
> +                       printf("  - ELE firmware version failed %d, 0x%x\=
n", ret, res);
> +               } else {
> +                       printf("  - ELE firmware version %u.%u.%u-%x",
> +                              (fw_version & (0x00ff0000)) >> 16,
> +                              (fw_version & (0x0000fff0)) >> 4,
> +                              (fw_version & (0x0000000f)), sha1);
> +                       ((fw_version & (0x80000000)) >> 31) =3D=3D 1 ? pu=
ts("-dirty\n") : puts("\n");
> +               }
> +       } else {
> +               printf("  - ELE firmware not included\n");
> +       }
> +       puts("\n");

This build_info() is unrelated to changing the second MAC address layout.

It should be a separate patch.
