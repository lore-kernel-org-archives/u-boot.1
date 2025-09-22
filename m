Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215D8CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A668832F9;
	Mon, 22 Sep 2025 16:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bQ4ObcQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F23A833ED; Mon, 22 Sep 2025 16:22:20 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD09583211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-57bf912cbf6so1787096e87.3
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758550937; x=1759155737; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hh0JcfQOAygvbQ+26JEYKSrR/99oESOo8cfg6nlHenc=;
 b=bQ4ObcQMsP60sFE/CvOr6XL7TlDN6MgUiUZHSpWfDb5G3Hxzr8usPDdOELDSKqzbwr
 o6wcT7YK1nq5jE2AqE6tbK/PzOLXEn7Kup3rbNJw3Ei3OZ35goTszfZr3pWcJkS16u5d
 TIk3olO/ml8IM6zlkT6QgwsLafoxQmI0y8K0Pk02hC3DgBV4Hn3fOksktyam0LIBUTbM
 6E1HvghT5BGULekNT0BH8IBtU+JOMlmUwhuh5BDrhr8pAu8HiD1b/dgm2U1gy8kONv82
 70Ln26oRluK8bnvIifETCgOk/lWH3VBJVeasSkjFp9aWyhj69jbqSu9vks8gNP5YriYu
 A9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758550937; x=1759155737;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hh0JcfQOAygvbQ+26JEYKSrR/99oESOo8cfg6nlHenc=;
 b=Uf/tP7xnDb+9rqD12pCILuzhIZSD7JnpzpXVNq64PE57VsRzqItsjsFgj2BpA8ni7c
 B522M1xJhvlrfL5uTNLKgZMZkTmY0D+n2eIPFCwct1scLLvgg2vdDOV9LVyui5IsYpUW
 WRfzFI1aS8U3esD4FVdvIEwUHXC+QnC5HoX7trOiEU7/3ZW4Y+IjW6W2r9+nwjmKZ4nl
 VFm0svWXi5up1K6jhniGHDenAwtwXsU4WXQhLMBjZlbMYS0vJDtyZyxGyPM/4XTXnyrQ
 Cx4yDtbImD2UJhspPT3Q//GRUQucG9IUOng8Mg+rPDVZPV7Avqbm7uQnCuXjxfyf4KTi
 g0Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGUrWiTy1vFSDmDu1SXQ/wFqKappjT/XA4ARXzg+gi9Lz6zNEW+WAelXAh6RtsKbf2oqc+Z2M=@lists.denx.de
X-Gm-Message-State: AOJu0YxOOs3rDtZnO5A4mVbnOWbxgZbTs509pTIufLndhtnMIKJJoGbJ
 TvKNluEK0BPfP0I7Sv+6n5Bom2cDfi0MsxMWROXXBp376c1XhkCjlfBMfgoWOMRNeLfsFbaxK6V
 BjXhDeRJ2e10Fs9yGr7rm42rOdJHvpoM=
X-Gm-Gg: ASbGncsGZYOUCoxMJBlYq8y72LcyNllX/AzqUfPRIB71UQxVbUZhgx8b4WBfUgkZqTN
 Z/dYGK1ZmV9a+LrnNKUgH1+XfVgm3Fnwqs8le8sjH1Gn52mVGtbra/u4r13Bx6gbFk72bLGX3lN
 6NPdLA/cuH/kk2jMj+XYW7/huDIftkDLdb3e0k5PL1OB0CHgb1/gkkMQwyeG29WbBrS3KAPgRk8
 W9Vgrobn1+Eo9jMa6bAqq7E4GbS0EWPo65mSsHkeaOE6ESmTQ==
X-Google-Smtp-Source: AGHT+IGtyD4Jg9FdwT4azaOtZWNJxXLYEY7HaZ1tn5gsYagUaC/aduSE9d11h97WZC3jmwaBxBQw7FU47tlzJlFS7P4=
X-Received: by 2002:a05:6512:b9d:b0:57b:1ca2:ab60 with SMTP id
 2adb3069b0e04-57b1ca2ac74mr3613909e87.52.1758550937015; Mon, 22 Sep 2025
 07:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250916025735.20289-1-peng.fan@oss.nxp.com>
In-Reply-To: <20250916025735.20289-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 11:22:05 -0300
X-Gm-Features: AS18NWBcDdkiOm_9-UXYed9RqF3EntKmpqnIySOJ9X-fO0HTMGYIKQrvuSVreOE
Message-ID: <CAOMZO5DiADK7BEtdPNRkyG3YBzRkbbXYegHz_TBSOrD=moFk-Q@mail.gmail.com>
Subject: Re: [PATCH] power: regulator: pfuze100: Fix accessing the regulator
 desc
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: jh80.chung@samsung.com, trini@konsulko.com, u-boot@lists.denx.de, 
 uboot-imx@nxp.com, Peng Fan <peng.fan@nxp.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

On Mon, Sep 15, 2025 at 10:46=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> se_desc loop check is wrong, it relies on the desc always has
> the expected name to end of the loop. It works because the device tree
> has the expected name as of now, but this may not be always true.
>
> Drop se_desc by moving the check into probe and fix the loop check.
>
> Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied to -next, thanks.
