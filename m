Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5E6CF258E
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 20:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B022D89030;
	Sun, 13 Oct 2024 22:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OoOa+7Q2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FEFC88FDC; Sun, 13 Oct 2024 22:20:13 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18EEE88FF1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 22:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539ebb5a20aso854863e87.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728850810; x=1729455610; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DL8Ys2ljF6fFLy+ibQwW3myDBdYfeRedfeiVqdC7F80=;
 b=OoOa+7Q2Lyu2cpsWOt4J+wHvI+VrBG5T32MBWZYgXjoF0G3xksDwh0plJfqCerpFeq
 wAY5ywLJg1oGYmf4zGbRxGlHgelT2EuMw3PbYF82eRHeahPCeIEsF5HmquTnPFFTDAuC
 /U0HPMoHwLQTFS08ux/o9Ny+c53Qa2mIhBB2dB102lfHvfVL1yIN6uwdl7zR94d5MInH
 HYKNc4rV6KDZQlgM4Hv72LY4kFFjEpBVcw+eEH8EbwJ3FroLjSSD1KPgG/g9s3gpWqvU
 Z/H0ConIhYg+1zIaVnt3hQ9ymKIeGeMCOPnoQrkiFYlvwsMpSanlEovptdQSfuURImiK
 iu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728850810; x=1729455610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DL8Ys2ljF6fFLy+ibQwW3myDBdYfeRedfeiVqdC7F80=;
 b=h/L6heofc99earAuh5HToZn71YpgpJpfXcnidRu6d6zmgTNy12dytALTS9yLNM5Ch1
 5AebeN6A4pGA6a0WWNiDeQPzbFN1HHZbMEkkvybwWUvdUXyrzugcEqhK5ghBl9d44bVm
 iEz1TQt/ktGM7sinuOkBsKWj+KMRKkBg+Jg6oGpF0nQZHxsiIJuD2ditF0QyTxwpzdO7
 VFlO8t2If+ufJpVaM6d3XvMbuRbsHpRmL+44JZHGa0O+5uPMXprE/49Y3SvJElZO+tCk
 rFrxqIthcB0vvKXG+1m/8jlViDSRUH1FlsfWiyXqeMf4qZpazkd3Fbl4DZ5z1TBFbLp/
 cKYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT53ekzOXEXQCz7Wp37GVHwDTIdYOYmiyeDEiVSW4wptY7Lwc0JyNxNCPvORSBb0r5fPuvPyw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+q6PCXdYCqXsZsN1Kb3vssNhNZPpWZgqJthDjeqHdVkqnHncT
 rraLFt2tboZNyfEYGd7JHua2HU4dSxygrL7i2wmHFokJa0pu7c1Phh079uRVPkoiB139Qk1uwdH
 OnLopyO8kGwlywj1AkcedNpKHVc0=
X-Google-Smtp-Source: AGHT+IGB49syxY96wimuSc36fgVB9E5k3foPcJxdmUyF1uugPZZF1XWpIr4F99uQ80C8SreR2YJQNndihgxuXArwO90=
X-Received: by 2002:ac2:4c46:0:b0:539:968a:91a8 with SMTP id
 2adb3069b0e04-539e571da42mr2587595e87.47.1728850810069; Sun, 13 Oct 2024
 13:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241006001652.14784-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241006001652.14784-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 13 Oct 2024 17:19:57 -0300
Message-ID: <CAOMZO5DXoeDzBoBzS+k6VKEeumDVDaU+R6k-8UCtOq5N2Lv8+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] misc: ele_mu: Update ELE MU to get TR/RR number from
 HW
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>
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

On Sat, Oct 5, 2024 at 8:13=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> The MU parameter register can provide the TR and RR number.
> For i.MX95 which has 8 RR is different with i.MX93 and i.MX8ULP,
> so update the driver to read the PAR for exact TR and RR number.
>
> Also update compatible string for i.MX95 ELE MU.
>
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Marek Vasut <marex@denx.de>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>

Applied both, thanks.
