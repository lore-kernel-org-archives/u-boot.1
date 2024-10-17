Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630BFD37485
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 12:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A06DD88E36;
	Thu, 17 Oct 2024 14:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DRJWL8kF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D1B88E32; Thu, 17 Oct 2024 14:50:40 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3277188E36
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 14:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb3debdc09so8149051fa.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729169434; x=1729774234; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvARLtS1eefbpj27vP+2lJGHXWLnWJoBIJvbPnsnonw=;
 b=DRJWL8kFP8HWATsmZElosZbcUpXsCburLZ61sYMnj4q8BdQJNroCyCAHVX6WX9CjFE
 cZ8hssNHweoKk71eKFd2saPraCkxycAPwNI9JCHim1cctU4AxpDPmOXbssIQspB5ZZiF
 wCFvDVG4WTtu/Hz5/+8hOp1os0RyfKT5A/XfkGi2a0oPyjcnyeRQBmxMcwm0AanAnKeF
 oIy7XLrtQ2utLwDuXivEZvBBBEhLmJKOiJooAUezwWePE6dU8RGPplPO51X54kXcuqVq
 oH8n4akqe0L7+luV2rwmtR9eicTq7fn+u5uDHKyDtxsCouYgFaYap/MnTxeId9yx14F2
 ellQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729169434; x=1729774234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TvARLtS1eefbpj27vP+2lJGHXWLnWJoBIJvbPnsnonw=;
 b=QKw5bgwAEx07ZTMZLv+cmGnKMN+V+TTJ+doByPrMgX9PuPmU0kGTV3f+x6y4b16SeB
 bbc5i6/VhkSlL4uSggWJCo9236HYLejyAZlyWNn/eDk1IUfnNbgwi++vmq52R2c6sVxI
 AMrFz9VL8ejBRnnGauXdMErld5STRW4NuiW5cWWOkhF7P3ZYEk4HisN/UmnXWU/OGqIy
 gcs5DZrQKS6Au1G+eOCJtHclWWSH/9GSH4s22Fc0gg9C3dkhOX4RXm+toRBT4HSuthpf
 vUGxHjsNd2wQ3MzQYRwJ/2BC/A3zFk2zQ/Qr40KqdWc9tPrElYHuOutC0xSxKyTI5IpE
 gOjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+wsBc8o2HKkEeowvQb2SB1PfISOzRhdc4rFeAB3njICkULIN2JqTPdaIh9l4ACQy0AFY2foQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyLeCsdUCiSkCIxnMU9hp1jO5Pl3JIYXbOyhQrdQuO3nBuepxkB
 YkzBCIItYwZqw8h4r0SdVh4pD75qu1CbLf1xrjovhxa5SxHxkPcyP/4pGwcasZF0LUQjBXuotZf
 JNE0EvzzF7PfWpEfEmzTLJYIYGuY=
X-Google-Smtp-Source: AGHT+IHbgeuZPrQJBg6WSbilWLyPKmm9tAeAyAgxLoQdVJF2YsT8UozVCVk+3d2BkauOij0BIIj9I8YhkG6aDgbpdkk=
X-Received: by 2002:a05:651c:19aa:b0:2fb:357a:be41 with SMTP id
 38308e7fff4ca-2fb357ac153mr94803451fa.5.1729169434165; Thu, 17 Oct 2024
 05:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241017081236.26742-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241017081236.26742-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Oct 2024 09:50:22 -0300
Message-ID: <CAOMZO5Aikd3f5-Cnbtcn74qBAkLOs5hv_42FeZk2nxz94vksBg@mail.gmail.com>
Subject: Re: [PATCH V2] cpu: imx8_cpu: Avoid revision to corrupt device tree
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, trini@konsulko.com, 
 uboot-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
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

On Thu, Oct 17, 2024 at 4:08=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> U-Boot device tree is padded just after U-Boot proper.
> After the whole stuff loaded to DRAM space, the device tree
> area is conflict with BSS region before U-Boot relocation.
>
> So any write to BSS area before reloc_fdt will corrupt the
> device tree. Without the fix, there is issue that =E2=80=9Cbinman_init
> failed:-2=E2=80=9D on i.MX8MP-EVK board.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V2:
>  move the rev to malloc area in cpu_imx_plat
>  tested on i.MX8MP EVK

Please adapt the commit log to include this information.

This patch breaks CI. Make sure to run all your patches through CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/920875

aarch64: + imx8qm_rom7720_a1_4G
321+WARNING 'mx8qm-ahab-container.img' not found, resulting binary is
not-functional
322+drivers/cpu/imx8_cpu.c: In function 'get_imx_rev_str':
323+drivers/cpu/imx8_cpu.c:78:17: error: 'rev' is used uninitialized
[-Werror=3Duninitialized]
324+ 78 | switch (rev) {
325+ | ^~~~~~
326+drivers/cpu/imx8_cpu.c:76:22: note: 'rev' was declared here
327+ 76 | char rev;
328+ | ^~~
329+cc1: all warnings being treated as errors

I am getting too much extra work to process the patches from NXP folks
and I am not happy with it.
