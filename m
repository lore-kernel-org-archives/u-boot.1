Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458F0C83F12
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D199857BF;
	Thu, 31 Aug 2023 14:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="YmBWBO/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF8D86572; Thu, 31 Aug 2023 14:14:17 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECE3833BF
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 14:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5925e580e87so8528367b3.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1693484053; x=1694088853;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s77IWDPk1uPcOMxzaTF15AZpDPazGIxn8SWmMIiXrVQ=;
 b=YmBWBO/2vJyNajYZTRrBW+qP4zIeE1b72it6cmh2GjiWTwMvBOcOSHz8yWktIoT5yR
 IYfm7FOrCedGjKa+AfcnkE7KnjenmmiUm/xcAvry2G+nF35KfXs8YYZPbDK2a7SZdqTW
 CUOW2xW5aJymfSiDHBiXLJ5PUWjZGlViCt+vmrt7Zv2yKrsP1/L9LmGY2A7efgAacz8B
 /jU9i4b6HS97EUyBMgAMXVJSbTLGQslkK5H2nBWXe1R3m+JZ28U9etoyWF5m+NNa9zgE
 imyvYH/THKCg7zztv5lo71GICiS4fVpJvVi7np45qAmJWsXYBYu0JBmGzb3NY7ALDoW2
 yDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693484053; x=1694088853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s77IWDPk1uPcOMxzaTF15AZpDPazGIxn8SWmMIiXrVQ=;
 b=XQkKH62k8FyiFvMuRIyLhYVE6McIjkVlDokQo3ND2fLbpPvTQyTUdz0LMdktKBlXbI
 8on5W2uKzuEvJ3m+98EcBXmUICVuI5Rw5ElAJ1wB5JAnD9CC1QK7jDmQcXgONxb8parg
 dpypAq7ulmbWVK1la8Pc722l3AbVEb9PsbZ1ld30Nc2i0Rvjsh/nH+AfzMwxoNGNv1i/
 4n6XVooe2U1Ikfc2zgBI893Vha6Y5rZcuXsAStCmbUDce958aQ2S97mGUPRt0XvhqJOL
 yvS85Kw7lcEFOLUCQv6yccJvcCFi0Vki7Lw8x+4x0q6KvvJDYdBQUKDJJ6/BgAdnn7We
 qzuw==
X-Gm-Message-State: AOJu0YzcEB1HkZ0pPY1Rt8wav/pBkMsKwac/ekGwXET/lRsLq7jSi5nm
 jt7TY1+pLfSgOILsfsW55cQub2LX3pFRj6MHEDT+2A==
X-Google-Smtp-Source: AGHT+IHICJ5+RWZCfgdnbgbrCfXszuKjisQ5B9K62Q389qBcCkV2ycDH0pBmSrLsfnQCdyqD6oNs3iLgA/7d8xE2TMk=
X-Received: by 2002:a0d:ca51:0:b0:57a:63f:f760 with SMTP id
 m78-20020a0dca51000000b0057a063ff760mr4751744ywd.7.1693484052912; Thu, 31 Aug
 2023 05:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230811054829.13162-1-ashok.reddy.soma@amd.com>
In-Reply-To: <20230811054829.13162-1-ashok.reddy.soma@amd.com>
From: Michal Simek <monstr@monstr.eu>
Date: Thu, 31 Aug 2023 14:14:01 +0200
Message-ID: <CAHTX3d+0omMBoGELzWR1rXEfjbQJm6vMoC+sPE=_XUPuY6x+6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: zynqmp: Add tri-state configuration support
To: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, 
 stefan.herbrechtsmeier@weidmueller.com, git@amd.com
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

p=C3=A1 11. 8. 2023 v 7:48 odes=C3=ADlatel Ashok Reddy Soma
<ashok.reddy.soma@amd.com> napsal:
>
> Add support for pinctrl driver to handle 'output-enable' and
> 'bias-high-impedance' configurations.
>
> This support has been added in Xilinx ZynqMP Platform Management Firmware
> recently, hence add a version check to avoid backward compatibility
> issues.
>
>
>
> Ashok Reddy Soma (3):
>   firmware: zynqmp: Add support to check feature
>   pinctrl: zynqmp: Add version check for TRISTATE configuration
>   pinctrl: zynqmp: Add support for output-enable and bias-high-impedance
>
>  drivers/firmware/firmware-zynqmp.c | 13 +++++++++++++
>  drivers/pinctrl/pinctrl-zynqmp.c   | 15 +++++++++++++++
>  include/zynqmp_firmware.h          |  3 +++
>  3 files changed, 31 insertions(+)
>
> --
> 2.17.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
