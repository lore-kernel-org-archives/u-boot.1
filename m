Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD9DCCD193
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 20:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D90CA83631;
	Sat, 18 Oct 2025 22:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sw8eFNFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66361836D1; Sat, 18 Oct 2025 22:31:46 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A17683438
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 22:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-579d7104c37so3913336e87.3
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760819503; x=1761424303; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/HMbCRfhCBCq6+mxF3OSZLGxs1YrYe0mPfPPcjXNlA=;
 b=Sw8eFNFkSCOwGs5ALzCS/JEOfU0Y16xhptM6atYXxOfEyow3OKSu1vJMw/BuanzxTG
 0ZiCdBj2A3RD1oMbUv6By3pHcfWpJfKpOs+/1AA/DXvalP6E6zP7uCiufmFKDOJc28qw
 hhSxR75k83Gq61SXZjMFz3/+yBAdDTh4QJ1qv7ipB+op2uSGZKOjCSw3gpTQylWt3oTG
 tKDlIKAgy3+XbIV+LgUDhEj7dMvSd5Efhy6BytBdtkwwqc2BoUshN4QSzJu+XJw6ilfo
 lZkLMVK57IbIZWAvWAK3O1W/rov9qinVDcfv+P/1VLxwXGrMTs6TNjJXZFlJdgsul7/k
 DYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760819503; x=1761424303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/HMbCRfhCBCq6+mxF3OSZLGxs1YrYe0mPfPPcjXNlA=;
 b=PfG951sMpXD5n93Y3K9cHg7m2xeeZOjZs/KwXK5IsQJ8KYohhHpKZoEwKqA/7hMVpR
 hKW+l09xLSd40Ddupjd05kcV4nYtWkC4Txzdag5M6UboKDhLysGLedxo5TP8mPbkQHYz
 MCrZaGSUqEksqPySidjAPYbkInwda1Sp1BZmZoNHGk3hNcCt4RG2DkwV7i8g5G9sAkji
 P66pROAJhWH2Z5V9WG6lLRGMsACBaaDcYKwMJy0/MqdjQAupA5H1r5rKnyNbhGD3VBBA
 cEoAr+EDGttmsccDxodkwkLvN03EtAOljjiuFQIhbuuIfCkoFcTLooCm5j5GMRs5eNH4
 0/8Q==
X-Gm-Message-State: AOJu0Yz3XxDeV839AUzw1CYJSeUwaJ/DkhF7X6TNs9ClDrlUF/HKDFLd
 soKNX2DQTiUzPUyaJLF9Ir1KB0hGRqWj4c+EfWxdoCRhPxHP2DNicqTAKHviRA2oF3nOXIMQLi5
 2GE0MhThjlX2Nqdz+e6aYqCsMSWqYRic=
X-Gm-Gg: ASbGncuU9NaRbVbfH/IniS8WO5FQHvGJETFm36/1uN8LfD+ykwgDrcl53TwwIxfQmbX
 qgzNJotdwm/gKVWuj7dC/CvzsCmuwroULi9AH6FsJiWd3sKkKWpE3gvl+ZbuTRlIfGhGnouZeNe
 XUhNs3dqJ23q1uV7P/XzszuHlMgISRaljw5x9C/KiX+GUfHegEq9AexcDr4jK2Y2Ph8UY5Esoko
 PbWR4RprC2Vr0E7JCjEUhtMNnM8KrgVJZzwYmbAWyHA4e1xgPwRtDa6WjuPabMmEstp3k2oBPcM
 wqYtf5pkyxEliWo=
X-Google-Smtp-Source: AGHT+IG2Dfyv9nZrTjhTM8zWbUR/PP9mOlL/4wWnwChb+FH7dQjEt8hi8pGlksAFOZ1orPm1eSIvrLx/oGs4MZwfJ6s=
X-Received: by 2002:a05:6512:baa:b0:590:656c:d114 with SMTP id
 2adb3069b0e04-591d856c3e0mr2430753e87.46.1760819503072; Sat, 18 Oct 2025
 13:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251013034128.1752157-1-ye.li@nxp.com>
In-Reply-To: <20251013034128.1752157-1-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 18 Oct 2025 17:31:31 -0300
X-Gm-Features: AS18NWAZvSWx_iTUw6XKl-jWx2JTWi_X-hbLDTycayIxRExA5RTGUjVQkACL5oQ
Message-ID: <CAOMZO5Bp-s0z8oObJ333BJ5Oy0mTjoenSPqPn66YzxcK5H2OMw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add i.MX95 15x15 EVK support
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 alice.guo@nxp.com, ye.li@oss.nxp.com
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

On Mon, Oct 13, 2025 at 12:41=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:

> Ye Li (3):
>   imx95_evk: Share the env file for both 19x19 EVK and 15x15 EVK
>   arm: dts: imx95-15x15-evk: Add -u-boot.dtsi for SPL and binman
>   imx95_evk: Add basic support for iMX95 15x15 EVK

This fails in CI due to the lack of a MAINTAINERS file:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1268701

WARNING: no maintainers for 'imx95_15x15_evk'

NXP folks, please ensure that you always run your series via CI.

Otherwise, it is a waste of everyone's time.
