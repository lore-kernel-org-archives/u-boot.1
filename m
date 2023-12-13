Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4D1C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 257C287831;
	Wed, 13 Dec 2023 17:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eesX/nBQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4627E8785A; Wed, 13 Dec 2023 17:33:31 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C3C6874CC
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d35259e8dbso1703785ad.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702485206; x=1703090006; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2wAWkJHjAslHSYT7eDOH57H9G3xk73+oTA/uF83xYY=;
 b=eesX/nBQa93k02SkVJ4NySswHevW/MS7cLmu2yJ492oOLmFXW47CTaz8/bPSoQMTEm
 DVfInJSijoEcd4Sp0OvkfTqw1+bWZjgHQ/Flbv9yaFcd3CUB+PCNMGbr1sGgYs46SE4M
 FXrs/oDF2WSkegGDSq+hDLrBwbbls2y3WOLtXOpmyQ8etMX4YwKOMqF8tGK9nBX3Y+j1
 TdCSlYvpB2KRO40d0XxasOMomtaSZDD4Vx2wY+M48zAmHmL6Xbj3afce7GmvaZH1fbOl
 Uy3V7XqV4vZIpEkZ6rI3YofAA7YUypDVgr1ER+yZhTQK3IIay4vYkflr7L0blcC7uyM+
 xuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702485206; x=1703090006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2wAWkJHjAslHSYT7eDOH57H9G3xk73+oTA/uF83xYY=;
 b=iVKaUFlM0ozwtnZiXNGkG8JjeLYiqawwGUR5zr8q+Ruzsnrg8Rj+iN+a3qgRR8t6jx
 v38PlEX5idWSb1nRHAYDZ86Bx1gRH70X5fQL59lIY/woBkku6oDl65adJ6TK4n8HpS/u
 iw2CHFrNuzjEvyYHHzutJvyMGZRyBo/6ClEBHD/B4Qq4B87ayly63Fa6kYYknCIl7kz/
 OM0l98cWLb242XuPPmJ92GXnq3lpTW1EeySha4XqMlHl6MNip6qWsVF/51KvpsxktgZz
 Wz7cKDWY6DpjnxNfdQLJ8I49kIAntqh1d15tcvXGbucqWxRDmCobsgvMwKLkGUZH7Zfz
 9lNQ==
X-Gm-Message-State: AOJu0YxOJBH1o0fo81gxFFiUXqne88LQ4P+fUVezVoz+wt1a46qkZdGg
 sCRJrH0sVEXhdLdESCwK8nZ3dyGoNkWjbBZI11g=
X-Google-Smtp-Source: AGHT+IHmiWWjSxSMxCgSrXfcB+q7Ypz6EG/qGsXNrZHSp11yFd2iUDP2IlMC1wnhmWR3vWk0sEH3U+xYarIu62gji6I=
X-Received: by 2002:a17:902:b18d:b0:1d0:80db:a841 with SMTP id
 s13-20020a170902b18d00b001d080dba841mr15702554plr.3.1702485206672; Wed, 13
 Dec 2023 08:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20231103224733.59410-1-festevam@gmail.com>
In-Reply-To: <20231103224733.59410-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:33:14 -0300
Message-ID: <CAOMZO5D3W9uuPGEJ+dQLLqTsh6nmKWJzO2dwAuYiUUQdS2MOOg@mail.gmail.com>
Subject: Re: [PATCH] pico-imx7d: Remove board_phy_config()
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Fri, Nov 3, 2023 at 7:47=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> With Ethernet DM in place, there is no longer the need for having
> the board_phy_config() anymore.
>
> Remove it.
>
> Tested on imx7d-pico-pi board:
>
> =3D> setenv autoload no
> =3D> dhcp
> BOOTP broadcast 1
> *** Unhandled DHCP Option in OFFER/ACK: 42
> DHCP client bound to address 192.168.0.138 (138 ms)
> =3D> tftp zImage
> Using ethernet@30be0000 device
> TFTP from server 192.168.0.16; our IP address is 192.168.0.138
> Filename 'zImage'.
> Load address: 0x80800000
> Loading: ################################################################=
#
> ....
>          ################################################################=
#
>          ##########
>          4.3 MiB/s
> done
> Bytes transferred =3D 9034120 (89d988 hex)
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot-imx next, thanks.
