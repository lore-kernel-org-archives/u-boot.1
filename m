Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDF6CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 14:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E9883A32;
	Wed,  5 Nov 2025 15:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TLnfiDlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F67883A57; Wed,  5 Nov 2025 15:14:39 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE2083A1B
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 15:14:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-59428d2d975so3711571e87.3
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 06:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762352076; x=1762956876; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wf/URrVLLGTKDinKj6L1DV31u8o0VLwqSMsoMTrJjJA=;
 b=TLnfiDlJB2Nno6QQYUDbQOHtOu1iTlOobEzy4OXZ6azRLSTNZUJm08dZbz2b3VikQ5
 xrLm18qeazM76tUI20lEy3Iqd+W+SlqFo5KSrikAR6PhY9hfY3pt3dn8bTl5HJapFjyK
 OabeVRe8NuR8+b5tjkBLfdqmW8VMguotAcuvuhokZo3smoHLCkdSkqwD/zZaC/q57Z6Z
 Y+BQ69neP6LSzAsjH0Wu2f+C25MJd/vrDF4GhAr8QEfy5UuYpQjPE6umZMQkF+p1ayG8
 kRUn4ZMRulU1WbqdtRG0y+25XGZuEF2r4+CHcnEjonrRNaJPnL76gIuvBu1fX/Ax69h2
 49Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762352076; x=1762956876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wf/URrVLLGTKDinKj6L1DV31u8o0VLwqSMsoMTrJjJA=;
 b=W3kLo3rhK2lAI5ab8npEcEU7OlGDXj7JelWU0lp8MDN4XLdjZWh0eYelCRZ9yuo+Zk
 JwcCGGQ1juwPbV2QIray+lN2oL/TAw1W+YbA+yHA0os40Fq5yU6qbQqH5VJRmrblX9dT
 4/bi+nmZR/lPrZBU/Wa8zjSBu8BcWWUiPHSprR5FtqhmjQjF/r+1DBTYP97We7jjV/Z1
 gbV4rAfGFE0wbuW96w01cHjbAP3MrPfQaDvFa7mPuVLvF1iu/QCJl1fqsGpDJBEd5kCJ
 v6w18XwBWNRtwMYpDi9fl6Lsa9jsbXHEHe1DW1wF0eu/NbNFkSasVpn8q6JT+dM5yxdQ
 /x0A==
X-Gm-Message-State: AOJu0Yxf9h291m5nNo9lpQ/bNu2qy17yMsw/Suf3hBS2f5K+v7LX+1LJ
 2k/M3W41fj3PPlWlVCmS+LOLqCuCMMlEA5jEd0epQdY0FFQEkQpYbnT9dUJpB4T08cV2t2F0gBz
 3hUjwWeOYGz/aq/ZVBuE5kroUKXq/eVE=
X-Gm-Gg: ASbGncuylOrm0hToJNKBoWwtrPPp9rgpxtfWmbroRkKW8tL7M6e49Q2DTXiGKHDsRbd
 /WX0ebYAc0kNsxDLC917QBab++EA+3ORAHNOZ1C1DVZTeoa3HvNQLF+QN8IRXzs77MA+m25e9sh
 uvF0Jdv9d96QzYLK19LNAQlH3MeWFpSZP66eXNAj+z656KhFG8HAsqRl34TE2XaSKr2JLbaiket
 o+AjXhRbtKKZsjoMVv9t6LIp55e5tBCfspswo1Er1lPL28OLb4ppBJ26unF32N/1P+G1Tj14Kaf
 7i7uD2PlHQD77Ou8
X-Google-Smtp-Source: AGHT+IFbG7K9BKGpQtNWOoRsATPg6ppiZv7/VclvOEMJsxB+wR1mZWw6jmNfXHWEX0BMce9JG5HhvqJAwwA8rO8/cO8=
X-Received: by 2002:a05:6512:4025:b0:577:3ccf:cdee with SMTP id
 2adb3069b0e04-5943d7d1d66mr934908e87.41.1762352076094; Wed, 05 Nov 2025
 06:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20251105140609.117866-1-andrea.calabrese@amarulasolutions.com>
In-Reply-To: <20251105140609.117866-1-andrea.calabrese@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Nov 2025 11:14:24 -0300
X-Gm-Features: AWmQ_bmllVsuso4sEsqhUkJnXOvTOBUyuE37WmziTg-Y28hJLIA0dIuDy4FQM-4
Message-ID: <CAOMZO5Ach-Dd3R98zD31o1THp_M+yRu8=Pa4Ph6w3aeVJ3MboA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2D board
To: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com, 
 dario.binacchi@amarulasolutions.com, trini@konsulko.com
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

On Wed, Nov 5, 2025 at 11:06=E2=80=AFAM Andrea Calabrese
<andrea.calabrese@amarulasolutions.com> wrote:
>
> Introduce the BSH SystemMaster (SMM) M2D board. Notably, the M2D is
> designed to leverage the existing device tree of its predecessors, the M2=
B
> and the M2.
> The primary distinction arises from memory incompatibilities with the M2B
> and M2.
> To address this, we've implemented a configuration system that allows for
> selective inclusion of the desired memory components.
>
> Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>

Nit: the 3/3 in the Subject is incorrect as you are sending a single patch.

 diff --git a/configs/imx6ulz_smm_m2.config b/configs/imx6ulz_smm_m2.config
> new file mode 100644
> index 00000000000..67c1ca33074
> --- /dev/null
> +++ b/configs/imx6ulz_smm_m2.config
> @@ -0,0 +1,81 @@

Please do as I suggested before:

1. PATCH 1/2: Send one patch that introduces
configs/imx6ulz_smm_m2.config and converts the existing
configs/imx6ulz_smm_m2b_defconfig and configs/imx6ulz_smm_m2_defconfig
to use it. Please write in the commit log that the reason for doing
this is to make maintainance easier, avoid duplication, and simplify
the introduction of new board variants in the future.

2. PATCH 2/2: Add M2D support using configs/imx6ulz_smm_m2.config.
