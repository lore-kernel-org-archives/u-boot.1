Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7E2CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 11:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB87832AD;
	Sun, 26 Oct 2025 12:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKcxAtWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E91F783623; Sun, 26 Oct 2025 12:55:34 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06A6582E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 12:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-36527ac0750so33440091fa.3
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 04:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761479732; x=1762084532; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzvUQKIqiVYafx+FZ9AVH+4zzxQwMW+ckoN+CnFGp+I=;
 b=fKcxAtWDsdpmU6SdeqvlI9u9eEGal+sbjJJYdTNUhat6Jx4s0UuzNtI+YKfBKHikQY
 b2mpXMa+XC3fVJ2BqXy5+ea1R3+DM3fGCPfPy753n6qEqAA4vyFHmE2jFCY4369v/sss
 8DAQidYcXwzSu0X4BVrRV/I9zklC2Z7DWjyaLVm7KGkbYS+RcJCq39POPQh44LcFvkhM
 CPnRDC7IjP3ln1chqpbVvDsDfqliYpvIFHthyFN6Lb+t4VZwGwqkcyFQA5bi/A6ylzQQ
 eUdb7geyBNuNqT/oTOt794QbmHaqvO3TFxatkIDb8ILzTr7uL8J9wwTKgLfhm0ap7l/j
 +65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761479732; x=1762084532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzvUQKIqiVYafx+FZ9AVH+4zzxQwMW+ckoN+CnFGp+I=;
 b=ByXkCLuHEW4CVbpS2nuiAMg/qV1CdqtmyV5Hq3TlR+MQ7cuM5o8nL8MbWtsTEK2BXA
 MaOaChn37dVM1+xs/LipIMZHpxwusQO61llYo71HeYeGZYX6/j1RJyhwVJWAglGm89zw
 /Fac2kJiOsPuL7sayKv2KvxPfyth5WBXADuNkg9+4pj6iMNA/fLERxquMJwJn7ZX+DBB
 L+vnXZ5D2/S9t7DBa2ZMnjhy27pu3XQqLc3uGwH4MchW1L/ilVC1G0pek6Yixf5RXHg+
 Jw3aDKOxdqYhaWUXHfHEKJVsGymZp+hEMKFMqjgFI7S6J+c9uzBleCHeM8XuUeCUYK0v
 Yj8Q==
X-Gm-Message-State: AOJu0YxWhVzVAa4ZWOd4kkxfUu9MKK858c46IQug/vy/7IJ9XzFmF71m
 RCwB7za+GSS1MSoevrNbthaqxv2i9HSOpyfzzz/RE3gxxDb2t2xHmrKTasBjfLy/a9QgFd9ZzfB
 AvmVgRSsW+tC3AsTv0/PNZD88nhgK5o4=
X-Gm-Gg: ASbGncuVqMbQswqToVdRY5I5CDaISAbx6XCXWKy75N4e/J141KO4Gl7ZHvdWzQlhgdj
 AbLqTKaVLKMRp7fc46Ujk5A7K25G4urKrV341LBk8UeKVvjv6P+Dc/RzKuTAM7sTFbIa6yuLFFy
 5XX8kVw6xT+Qba6Bk6bg+17pbb77ikPEsR8K1nuCQFup28+p29nl1/7lV9D/FrAIWOfPwQ8fSeL
 G8x8NAg/wacuvrZaTdEp3ZixrWst2RQrYEypHPC7hP2i7Oje1ObrUjMwuxxsCPWEPYo9yU8Dcc+
 HFlUrHDvfMsveVr9iENFJd1nLac=
X-Google-Smtp-Source: AGHT+IHBRG3quEphzFXYsbMiK1II2ZbDPqbltiWH74wo7fLYCnl+Vt/na6/bxV3AcLOm8vzKJS1L2RTRukBKvAYLqYo=
X-Received: by 2002:a05:651c:b25:b0:36d:501:76d7 with SMTP id
 38308e7fff4ca-377978c14acmr102727471fa.14.1761479731995; Sun, 26 Oct 2025
 04:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <bfe7ac62-0d01-45b5-9226-e1d425565d50@schwermer.no>
In-Reply-To: <bfe7ac62-0d01-45b5-9226-e1d425565d50@schwermer.no>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 26 Oct 2025 08:55:20 -0300
X-Gm-Features: AWmQ_bmbXRJxIbjNzGHJRE7FNWK2xeyM-9JCwUH_PqhTFpnSpz_2OZ18GwwzNGI
Message-ID: <CAOMZO5C_8xacCJn9+KWC44nSuMWNCUu0c=YHsQvTH-+1yKawSQ@mail.gmail.com>
Subject: Re: mx6ull: init_bandgap regression
To: Sven <u-boot@schwermer.no>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, dario.binacchi@amarulasolutions.com, 
 peng.fan@nxp.com, ping.bai@nxp.com, sbabic@nabladev.com, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, martyn.welch@collabora.com, parthitce@gmail.com
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

Hi Sven,

On Fri, Oct 24, 2025 at 6:23=E2=80=AFAM Sven <u-boot@schwermer.no> wrote:
>
> Hi,
>
> We make an i.MX6ULL-based board that is built around the Phytec PCL063
> SoM. We have noticed a regression between v2022.01 (good) and v2022.04
> (bad). We have also found the following tags to be bad: v2022.07,
> v2023.01, v2024.01. We have bisected this and found the culprit to be
> c1af358c ("imx: mx6ull: fix REFTOP_VBGADJ setting"). This code still
> appears to be unchanged on upstream master.
>
> These are the symptoms: Very few of the thousands of devices that we
> manufacture (< 1%) fail to decompress a large XZ archive once in Linux
> userspace. We have not found any form of memory testing or other load
> that reproduces this issue. Reverting the offending patch fixes this
> behavior on the affected devices.

Please send a patch with the revert.

> Perhaps the NXP folks could chime in on the intended behavior. And the
> mismatch between commit message and comments mentioned in the offending
> patch.

Peng, can you look at it, please?

Thanks
