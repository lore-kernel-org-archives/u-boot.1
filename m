Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA1CCD4849
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 21:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF39483D0D;
	Wed, 12 Nov 2025 22:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hTUz1rP3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2107683D3C; Wed, 12 Nov 2025 22:15:27 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E25883CEA
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 22:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5957f0218a1so79117e87.3
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 13:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762982124; x=1763586924; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOviDvTuAiOYpN8ZdEeGWJIXUZUBMAAdPJ4y5kVMxwU=;
 b=hTUz1rP3bdn7lqRYvkYxBsY2cyVQZmTcGZJbIN2gMXc6UqPBq0Uz0s0ciVu5kgeCG4
 cuhSznmH4Xw4vsik1ymCUqKhwJW6qh8BBnk0tXE2t/r00jcsOTCYd+grt2bV9LxncGmi
 DN5NNJPRNgsdO0p20U6Y/5t1P/r5AkrpoCUjDYG9TOLiUcUfmtlxa72ZximW0uD1+v2r
 2LNeubx1GfxpOjtw72mA736pY5eswGx0ghzQ1S01kjAOviH4Itwh/w/3Y+1BIgRd1W5w
 LLdBqqlbxs3FdRnggq7ow1iJQfqRQg3jNfRTbLhwJeDc5Z5d9tI6VrbM79mYyBAUJFMK
 Yoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762982124; x=1763586924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cOviDvTuAiOYpN8ZdEeGWJIXUZUBMAAdPJ4y5kVMxwU=;
 b=CzBcCeBBFpajiGGG3sytoE46qyD+XECjOP0dwSkbO5T4TuNuVtsSxO6tG/8UI1dUgN
 kN5M0nGrYpVklzQABN8CuNP8ni50QZcbEPzXCLF9FgenPj1d2i2OJ1SFBzOlcb0VIbif
 Wq/NXXMEzcXM8ME6ue/2wB2dYdOTsgT5vJeA4MbxrnWe9QgSAPx6hoH0qm079jXdtgId
 rehAtTN/7JvrqxCYdXSQAH886G2pi41gkaGCPo+RAdsy1IOy9VXmSYtYn13XMIEZNHuy
 41Jk+bok1QdWrixOo9pjKDxThqhql6lzG/mFIrFC5rX6zXczH1dyld+4bZ7tmTDChd1H
 kZqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgdTQpx5++1jrL+4HmBLEvek7yGu7I7yP/98RWBgvhdivyc5qo0cFUvbqogjQGnPPJT33CXSo=@lists.denx.de
X-Gm-Message-State: AOJu0YyVB5W+GoXh8xAr31JEGBKyVGj81aEXwdwtsnEQBZ76SIDfEpxh
 XqyMVMbUJY3n1FUQf3jggAUQ260GLzbam4yPEgz2wYNI8oSHPn/vDE//bqDOsfMMCOmhZDIf/+z
 bPBEMCA9qOt2CQdY8LoW8ZOdPWfWxiFc=
X-Gm-Gg: ASbGncuaF0tMzQGp8lyAJPodN4wlRR16BYFZkz2cgeiOfzTTw9mTUEEWsem412zHDXh
 M6aY16DFO1Rxzvzw0QXV1fUZq3yqZBlrzquOy99tQnNXYkF62zDa8pAjKzTnuxm4l9YL53jSH9h
 MlE3uqdAogaJmJCuIBmZPHqrvF9O4RDQIdjhuKBqAjuS2YUN8KHxuMyMencz5H6ajheUSJzViOa
 zUBwOPpY9TWDFnK77Fr30/XF63lmHn7XWzVeZvjC0aQKAfoqFNrtZI1M3QNHlJjWoheJP6QJalf
 kC4+7PKNnqFZ8A==
X-Google-Smtp-Source: AGHT+IGgbqjy85yPsAMBJJBVSkxd7j3TTMijFhDHrRhcNGqmhalPKsVLIMtfq8rp8LfOcRzUAnqsHMho99o8HHwO7jg=
X-Received: by 2002:a05:6512:114e:b0:592:fa1b:c0e3 with SMTP id
 2adb3069b0e04-59576e02114mr1909473e87.16.1762982124088; Wed, 12 Nov 2025
 13:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20251111-imx91_pins_fix-v1-1-f9347f896cd4@valla.it>
In-Reply-To: <20251111-imx91_pins_fix-v1-1-f9347f896cd4@valla.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 12 Nov 2025 18:15:11 -0300
X-Gm-Features: AWmQ_bmUhZw2YF_udzWVr9WlGJNMMvpX68zSRzZjuvDSrAyu69Q6tdkDvJBraQY
Message-ID: <CAOMZO5AD6BQP3WhcP_NBMm33Fs2Lxao7yvbC9DWrPz8q3_5nNQ@mail.gmail.com>
Subject: Re: [PATCH] imx91: fix ENET1_TD3 pinmux for GPIO function
To: Francesco Valla <francesco@valla.it>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
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

Hi Francesco,

On Tue, Nov 11, 2025 at 10:19=E2=80=AFAM Francesco Valla <francesco@valla.i=
t> wrote:
>
> Fix a typo in the GPIO function for the ENET1_TD3 pad, aligning it to
> the function specified in the datasheet.
>
> Fixes: a9d562daa3c3 ("imx: Add iMX91 support")
>
> Signed-off-by: Francesco Valla <francesco@valla.it>

Nice catch!

Reviewed-by: Fabio Estevam <festevam@gmail.com>
