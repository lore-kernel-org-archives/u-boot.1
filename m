Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D46C54E68
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 23:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8770187FF7;
	Mon, 18 Mar 2024 00:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kwBoFUsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E510A88001; Mon, 18 Mar 2024 00:56:41 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADC1D87F3F
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 00:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29f8403166aso459033a91.1
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 16:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710719798; x=1711324598; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnyARSVLO+rhnjLNDLAFc0LtKyVaPIptXMvm+WcnEHU=;
 b=kwBoFUscvNHFGOHsVle6nCpzjJ/yqMVOiwyOBWrwBLC6OnKsVAQyTA0BzA18uVI1+Q
 FbvpK02ULu0H3JN3BgHWhipvcBdjciBASEqZMeSnBFeSD0ofk+SQusn0gPLWyNQzdXty
 4o8xKC/oC0OKrn9RUQ4uSeZvRqQX3cj3uAHEveKXwG/WRnT1zmxciWTKy1BWF9Hosf2V
 IpPtjXFM5WaVIk1gYhR73j0eJtoyniYLjED68rSfw+JEvhPT2LmrNTCl7RcAxKFaR8Ty
 jrIYoD5FFd/JhcbEYc70wrNO7VyqahQfIfdN6na43ZtAZpN2LLA022HXeAYSSPWAOZjN
 QHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710719798; x=1711324598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QnyARSVLO+rhnjLNDLAFc0LtKyVaPIptXMvm+WcnEHU=;
 b=OdyDaYSDBlHEXyX0SvJNQBJFnLEHSy2w4U7kqRPDfocNjayVW36sSWRXGErFLPGHvb
 UMgsrlsAPXfkBTNxV88RAlRjdDDA/85GNR3vUg2fmOytC3ej3P+WvMorgWApsS66hLmL
 cw2OrcXNZBXYRf2j462b17G1z8PJguT4EXuPuyHC9nfl5aMPBOhqI643/jGFg1suf+Mx
 x4XoCRSBpEj6d5SCZZk1Cw3DWYPyYIAP/KkroHQxhtkTkDyxP5ezWk+3SMcnlHuGwHIf
 5yV7sEVvAxyRR/Rhx5sQ33+qyrsQQA1F8fzwzlw4NQSCDisF4CUBXjKf1BNwZMCQqFLH
 5Jiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjmNRyo/JtIPdpWF+v8Zkk76IfNR6Lh5sHiE0HJt91I/w2DBCiebijMVUkQpmMIJA4+xG6EEsaklgjHzzAHanon5b9Ww==
X-Gm-Message-State: AOJu0Yyd8TGz1o/07N7TiRFVokrzC3g/47V8zUTEop+xER3P/NW1l2Q4
 z7RaFPUEsxVGsBBpTCOURdoZKgi76YBRUwMA5oZHVEZEm/+JitzJ/4XkXN3igDw4z37EyS7mjmj
 4Jq7wI2nxgL7D3cd/+7T6FK1S9P9PbLQB7zk=
X-Google-Smtp-Source: AGHT+IEUcallh6jkwluBE8pTxDW4Y64ZFAcVNVojsf2KrimY4MSG/AJGXDQ9jEDQoPpCvrG30dszLbazB+QdgNLQJ4E=
X-Received: by 2002:a05:6a21:670f:b0:1a1:3d79:82 with SMTP id
 wh15-20020a056a21670f00b001a13d790082mr12148028pzb.0.1710719798197; Sun, 17
 Mar 2024 16:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240315144426.38560-1-ivitro@gmail.com>
In-Reply-To: <20240315144426.38560-1-ivitro@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 17 Mar 2024 20:56:26 -0300
Message-ID: <CAOMZO5BEcu5VcfcHT6NqJAgVZE=vZjAg9yKJyYjcPA1UHUMbyA@mail.gmail.com>
Subject: Re: [PATCH v1] arm: imx: imx8m: soc: Fix NPU/VPU fdt disable fixup
To: Vitor Soares <ivitro@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
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

On Fri, Mar 15, 2024 at 11:45=E2=80=AFAM Vitor Soares <ivitro@gmail.com> wr=
ote:
>
> From: Vitor Soares <vitor.soares@toradex.com>
>
> On imx8m[m|p|q].dtsi, upstream Linux uses different names for NPU/VPU
> IP block nodes. It leads variants without such HW block having it
> enabled by default.
>
> This patch adds the upstream Linux node's paths to the disable list while
> keep the compatibility with downstream Linux.
>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Applied for u-boot-imx/master, thanks.
