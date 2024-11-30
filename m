Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFFFD735FE
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 11:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7335788F70;
	Sat, 30 Nov 2024 12:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CzaIiHkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5ED89065; Sat, 30 Nov 2024 12:05:53 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93B488F24
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 12:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53de84e4005so3082298e87.0
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 03:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732964750; x=1733569550; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6nqq4i+ZPw4JTmT2wGpIT87BHLcaT7foOF6/d7dpPY=;
 b=CzaIiHkwwzG0IlVi1ZU5EoGkME7/zhCaiiqRXt5jG4M8sxLOql8iKATiByJ5PjMobM
 gO8lDMvyCp4sPjr+4FYsNgguDzOmvLMafaU8uHLQrZiJK/wMcK6+eU3fzWYzfCPVDfPa
 ni+o9xTmOKIpPgx2frz4c2KZYa/Nu7xAQ0RmbFwO5VhSB0xmiYWgDzei9WI+il4y0dXG
 lkurBkja9HvA5q+XKkOYzsYUlmvBSXMmsBbuZmQ4z3BjuuBNj3dD2FPwq7hTwdsPnx5u
 qtc17fuvBT3heomQUKokl8ZMYcZaajClZBBFUNCR7SR8ovz+6Mz1Pp5rUtwnqWh3DABC
 yQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732964750; x=1733569550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6nqq4i+ZPw4JTmT2wGpIT87BHLcaT7foOF6/d7dpPY=;
 b=T5usHWs0LxR1e5LltRHP3Q4Egq2C8LGl7cjbV8rNsdKL8U933lPXsmOrloaT6L6VJ2
 u1svMQCmfaUk/qC6uOqY058tTGDqKkIzYrhnw2NpfR1Q7UMLFh22wW+ae5rBHc0YmAzH
 SBNAdozBOf9l+FsaD1gU7A7hs3nTgr/TYbfkxVowPZFw5BUIefj9MuPByq4TB+4+0SOZ
 PUUx2n8ZcaektlGd1UHxXGbglWuDnVmm0UPAklUOqmzKVOTuAlaNdp2LpQQ7rtOkSkho
 bURIqPJPEMwlZTOLIqqDB3sdVcUnbOUmvOYygNjmV/xDD5LEVYKLlutHWYBnVU3p9MSW
 W0HA==
X-Gm-Message-State: AOJu0Yw15X9Zooq5C/2N2VFP6HXJRWvcIqbkFzpSpiBcnjj82qH9UQ/z
 HWfbnpSfwEClKIn7XPkbH+yziXzWVE2fHYZTxqbgLIM0nd/fI8OFSxj8m7eRK/My7Lo9ZCNwbkN
 CzWHLb15XxOnD47mrQsngf9hEKww=
X-Gm-Gg: ASbGncvAOObcByoJfNkt3tl0p4jL2XUvAXSdBBYMNtvD6s18BO11aqp4eaI5mdpAb6I
 VYAS/tYutbNtTZf/YTo+azBTQUl2ru1yWm7cc0DenUvKbj9nD7cFe6GSQ9yioFTM=
X-Google-Smtp-Source: AGHT+IGfaG0BfASvTa+ik48OPJMIZjuIOe7DbeVo1sN9JT9IGMFd6Plz8Jt8u+VSEhum8wnCI3gtwE8kIcO4c2OKy7A=
X-Received: by 2002:a05:6512:b12:b0:53d:d405:90b with SMTP id
 2adb3069b0e04-53df01148cdmr9735923e87.52.1732964750111; Sat, 30 Nov 2024
 03:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20241129003548.253551-1-marex@denx.de>
In-Reply-To: <20241129003548.253551-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Nov 2024 08:05:38 -0300
Message-ID: <CAOMZO5DUr5e6zqecytGiXfHf3SWhBNezRA1Pk_-Lsf4zf+XE4g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Enable PCIe and NVMe on Data Modul i.MX8M
 Mini eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, Nov 28, 2024 at 9:36=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable PCIe/NVMe support on Data Modul i.MX8M Mini eDM SBC. Except for
> the configuration options which are enabled, add slight adjustment
> to board u-boot.dtsi, which is necessary as there is currently no
> driver for the I2C PCIe clock generator. Since the generator is
> strapped to be always on, it is possible to supplant the generator
> functionality by fixed-clock.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> NOTE: Would be nice to have in v2025.01

Applied it for master, thanks.
