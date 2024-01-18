Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB03C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 13:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C66DD8798D;
	Thu, 18 Jan 2024 14:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQsVAOuT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46A8879F7; Thu, 18 Jan 2024 14:30:28 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B6FD8794F
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 14:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-290291820ddso67462a91.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 05:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705584624; x=1706189424; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dsl9cF7Esx5G9F8JAbVULHZNjhoPoeDbJkNFc4RMKP4=;
 b=hQsVAOuT7SzQltqlGgwG/TFORJGzA+vHxiyS3WMZD3SX2mAmZ6YWaHC6afOOlAgg65
 cjWv4mrdO0rezGjoWePtzK33GLVnVVVIRzQFHHrqpOVfoZ1MX5o0+6hX+2q5DjHnTRcY
 P11EJ/hxaGY9/f71XZegk4Eoz+bor4WTBrchwV4+ncBf8ml8/lbYLpTlGgMXmiXoaUnu
 uuPERmCd+qXw7Z0WE5eVeKVt1OphYF4vwgP0OmU+YkV6cPpE1QjQLXvcICByyvAXyShJ
 ZS2sbW28pS/wW7fNy5SNpWvqu/2vnR1xr3g/BaGBrjd+EmrjzkwReP1JrHuKSIOEQ/ee
 jmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705584624; x=1706189424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dsl9cF7Esx5G9F8JAbVULHZNjhoPoeDbJkNFc4RMKP4=;
 b=ehXOIfIRqcQ8tSnorvjpbOqN97Oj8vfb8CNJ0kxqoMjUcyuvbYSlxvTyAB8vBind9z
 HzZ8L2uxTA5VuZ8yzBvv3UdRJejOn3bYZiMDC3CbRk7dIpCPWQEAtmLZK8icoSXszCur
 DZo11HJIj+4q2w2CVenTTRM/zg6GKXOZP6Ynf+8MnY+3WTUBrxV7LRysPW8kE6vCN+KA
 pTI97xIlqyw0md3s9FVjML613IebtB/FeD5cSlXZD7T7PCKU4nfWSOtVF0S057PQZpDZ
 QX6eaEbaFWrgyjemr/b/QSLp9OGZ4Mc0l6EC/eceqaRq5sVT9tY8facSyolsW4yp8Qdj
 8wng==
X-Gm-Message-State: AOJu0Yw6opLvfXAE78aBfKRUQF5LGlYI//s5SmXOcHGq03SaxBoa88Ho
 xzqfhCjhlLDq0OzmlX6LH3HY9jFkrCX9RDegqhStOT994tLhBR01qlKxYCra2YumFeAC2lTjgg1
 qweXPeykTgx08sJ482mlxN3saPBc=
X-Google-Smtp-Source: AGHT+IFkY62tTU7tp121GY8iunNYn6/UgZgzXD/HJ4pzncSTrB9cEzJMqQS8aQFwYOa/QjtpgLhLZJX6rqH8ADYDgtg=
X-Received: by 2002:a17:90a:d582:b0:28e:1e79:c5c2 with SMTP id
 v2-20020a17090ad58200b0028e1e79c5c2mr1474783pju.1.1705584623915; Thu, 18 Jan
 2024 05:30:23 -0800 (PST)
MIME-Version: 1.0
References: <1705043234-39185-1-git-send-email-ye.li@nxp.com>
 <CAOMZO5BpA7Mx4Pogz4vMJaBy2GeoroKAELRg7wftUNdxuePtyg@mail.gmail.com>
In-Reply-To: <CAOMZO5BpA7Mx4Pogz4vMJaBy2GeoroKAELRg7wftUNdxuePtyg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 18 Jan 2024 10:30:12 -0300
Message-ID: <CAOMZO5D4Ej6madVoVu8Shc-b36-VOQNPN5kv7_hUhbVoQWVBVg@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: imx8m: Enable the SError exception
To: Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 thomas.schaefer@kontron.com
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

On Fri, Jan 12, 2024 at 3:00=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Ye Li,
>
> On Fri, Jan 12, 2024 at 4:07=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
> >
> > To work with commit 2f3c920(imx8m: workaround ROM serror),
> > we need to enable the SError exception and install vector in SPL.
> >
> > Signed-off-by: Ye Li <ye.li@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
>
> This causes an image increase that makes SPL to not fit into the
> internal SRAM on some boards:
>
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/769422

To fix this problem, what if we enable LTO for all imx8m platforms?

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kcon=
fig
index b1937198402f..6617a631b4d6 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -7,19 +7,23 @@ config IMX8M
        select HAS_CAAM
        select ROM_UNIFIED_SECTIONS
        select ARMV8_CRYPTO
+       select LTO

 config IMX8MQ

What do you think?
