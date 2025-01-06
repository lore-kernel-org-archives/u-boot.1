Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5038FE77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 11:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C14E801E8;
	Mon,  6 Jan 2025 12:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CYdnCaZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 160498036B; Mon,  6 Jan 2025 12:07:03 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049F3801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 12:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ffd6b7d77aso192414231fa.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 03:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736161620; x=1736766420; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cU6HUoZT66gVFUHmQUTeaYe/I8qs52K8LxRX5IwHNAU=;
 b=CYdnCaZwaiNyLnnwbd60Oj6e9XvW5qu7p4U4NivX5f+rH3sWfCrD4FiY5UrreSxtJ/
 OwOTFmEutGYKRXQWU7mGM6azUlejgJYXV8I0agXbH5pJsLlaGn9rd/FRHNL5iBW5PKOZ
 LcMstUZ52DXu3/kKBiBMEYcaHxACz/uMIngj6CpIpd6TpsjHbcN72PrifdXqzzWpycE+
 fgGAAgHVKoSyDEVUc2O7d16SgY/cZV1qLQ15GcXWbVdL7jLl3Z/nivYGds0/WEKnumEE
 a4xmJ3fwKh7bWtBdOTnEUrLPF9/izVETqHKYjkIwvoPgRtXbmIK4XMw0OTd74jSks24a
 LwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736161620; x=1736766420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cU6HUoZT66gVFUHmQUTeaYe/I8qs52K8LxRX5IwHNAU=;
 b=rYiJQim3wqyonkXc0ZBOGLpeTI5L7Ajj+Xga2lra1sLvA3kVVRR/yPKms0RR1Tniq0
 ieNRuzv9zgM9oB/ldoKXRMHh16nl2Fd2KRXYZOaXX9YA3BbJXRnoxtEdLmrqhntVRS7O
 asP6i1PpHfQPQsKxqE3vL1suBno3qw63opa4kNE6DsGFlI1jeCn01cHVxjZJwlGF6c7K
 KiiNlO6YAK7tqafRf67Vioyjw5gD1PI7Xvl4kVb3VlUZ03LsWZHcv6woVYgpavrZXtF3
 V5IUbG2JBghmNp3wA7HtyvAg4C2+tb/Sp52++jsgKRGw31uRpDxwDKsgZVHbVoQJSDO2
 znlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOY12UwBoaj8pCNHa2WEiVP8VK0RIvsUvlZSzG17r43x6952Bn5kMgD/vtcX5XHy0Qy6rohCM=@lists.denx.de
X-Gm-Message-State: AOJu0YwVH9rCFkEKnk9EfXAvV4vaYH4TMoLur2QJFK0/LPe2BTWZhHT2
 Sf+nchXacBseB91tQAPJIMO/VILYogsQ1+wJwcPv/m5pKfWKOk0uyNAEmPElX1nN5QfxHbOmhRr
 gO5+gdtjuS16c7xYW/X8TNQ6iPXQ=
X-Gm-Gg: ASbGncuVP+6X3qB/gQqX61qttWvm+htXxlt3yjAQo4SHP9o9iQv89papnHBzG8MS+cA
 3i2TTDITMuWz4oInM50o9jJSXAmAlZ4TsveArtkfypTZv+BRaevEDrPtrGrFf+QDRzUfFsw==
X-Google-Smtp-Source: AGHT+IGLVmIFuGziwKWncURpdNH35u/PRRMdPTGDNGIDOdIaM66SFa8NjeBXbqLHZMRaEkualTkOxY1oqqzAANHgkM4=
X-Received: by 2002:a05:6512:1394:b0:540:1ec0:4d86 with SMTP id
 2adb3069b0e04-54229533e4fmr17100902e87.17.1736161619904; Mon, 06 Jan 2025
 03:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <20250104-imx-bootstd-v1-1-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-1-e09618cc1d65@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 6 Jan 2025 08:06:48 -0300
Message-ID: <CAOMZO5B1H8pKvnAHcrbNmDM4Ur7jniZDqdtJi+y6JxLYXpJSrA@mail.gmail.com>
Subject: Re: [PATCH 01/12] imx: imx93_evk: switch to BOOTSTD
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

On Sat, Jan 4, 2025 at 12:19=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> --- a/configs/imx93_11x11_evk_defconfig
> +++ b/configs/imx93_11x11_evk_defconfig
> @@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x18000
>  CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
>  CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
>  CONFIG_NR_DRAM_BANKS=3D2
> +CONFIG_ENV_SOURCE_FILE=3D"imx93_evk"

This line can be dropped as it is the default.
