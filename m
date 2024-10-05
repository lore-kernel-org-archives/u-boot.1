Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D3ACFB421
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 16:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60ADA889C3;
	Sat,  5 Oct 2024 18:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D979N0kz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1D9C8897F; Sat,  5 Oct 2024 18:49:31 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1322A889C3
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 18:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fad75b46a3so29776101fa.2
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728146969; x=1728751769; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Evfp6O5pWD0dHq9cKB7Gvyq/3/eDtfmUShWPIrjUKj4=;
 b=D979N0kzUJbKBwXsvNo+HlV6Fnq6Gkq4Jhxj90IXxjakN/gPm1Z7yNJOc2O7rrjyVn
 86vRq2bRSy0rrMX2hpM4QVYi2ReFyWHkgAoWKIHWRncUBwRo9T4bm3ZLSdPBMnTj0V9v
 ltFHHbiJGkQE+Q5lHzkfRoMH11xDCMGIJ+BpWN/w7CaWbiJ/VSCBdcs/8eZTNTY6OtiC
 U+QoKOC4S8CiVza2/m5iay9vSbaRA+HRRER8tFIGlAEshD0CbiIQ0jJZkhZAsajI4cwl
 QFBr/jvo326av842PZFIaAvIRKL7btYIDpXe3k/z2zCgwXgyBV5xD1ggPU0+wZZuExFd
 e9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728146969; x=1728751769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Evfp6O5pWD0dHq9cKB7Gvyq/3/eDtfmUShWPIrjUKj4=;
 b=a2NXZpb0Xr9dp6is9zvhmR+K227hyFgnYWHoOJh5S0HUIn43Tlo5OvPNI3Iue2yjVC
 esk2i897e/bRgQbh/YdnLJVFexafMwyKAFOk3VUz8AqGFEpG5WhWKLXQ6cs6Y+ZMQrtD
 EyuOeSln3S0srD4kyn31i/vP6XCzEYgE3hsLkr5+IG4d51sHTdIbfJxFeSHrsPTqEu2q
 CnXAhv9Npcsil48JMs0w2OybUTLW5NSFsZwdyHePBUxH9m6cz6zefVrp4uX13j4ogNb8
 7v5qDaqzlf3pud9nv30VH/3k8rccJAGgdHXe8txPIn4B3dG+Jv5D90VCnBSbewBhm4+t
 P3Bw==
X-Gm-Message-State: AOJu0Yx9m+hn9bsHx6aEj66szMyX6TliuvBVxzFT9LmEljI7WUu9QNx5
 mgibACzQMdt2gbrTevt8iT9vvPFMY2RWmmdEGTomfrrxCgZy0uXt2wuzDZ2BLMWDOxOAB2Du1I0
 nt7DFVgoPUUPVgIF5UI3Dt3atUjc=
X-Google-Smtp-Source: AGHT+IEdWx2aI83KQccQIGZS4FhBu2bRbrohVC1Lr9tstMWLzZ8OH8R5XwXhMUyrhdLilqmxNbi9RH+KtwHweXzN26A=
X-Received: by 2002:a05:6512:3502:b0:536:54c2:fb7c with SMTP id
 2adb3069b0e04-539ab88a118mr3360451e87.25.1728146968969; Sat, 05 Oct 2024
 09:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241001160324.3894617-1-paulliu@debian.org>
 <20241001160324.3894617-2-paulliu@debian.org>
In-Reply-To: <20241001160324.3894617-2-paulliu@debian.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 5 Oct 2024 13:49:17 -0300
Message-ID: <CAOMZO5BbQpOt0_+oFPw0rsxYWfc+RZBsDDMLe5_pQaC-841e0w@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch: arm: dts: imx8mm-cl-iot-gate.dts: add
 no-mmc-hs400 to mmc2
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Tue, Oct 1, 2024 at 1:03=E2=80=AFPM Ying-Chun Liu (PaulLiu)
<paulliu@debian.org> wrote:
>
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>
> The eMMC device on imx8mm-cl-iot-gate seems not support hs400.
> When booting 6.1.0 kernel we got the following error.
>
>     mmc2: mmc_select_hs400es failed, error -110
>     mmc2: error -110 whilst initialising MMC card
>
> Add no-mmc-hs400 to mmc2 node solves the problem.

Applied to u-boot-imx/next, thanks.
