Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F75AE7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 16:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 895738036E;
	Sat, 21 Dec 2024 17:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OctmmXOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE0B80381; Sat, 21 Dec 2024 17:22:44 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7612C80243
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 17:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ffd6b7d77aso35109421fa.0
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 08:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734798162; x=1735402962; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFBvRT63e/bu7hx1QQj9PLnBWI3Gi8yt2omSCxC/DRc=;
 b=OctmmXOeBXK7JCV/Lh51didreIvVrdcWufmeeYPcTwGCOOezWbYhcNpiP13eFEV6C+
 JjHp/gWfgrhkoJPVLDvD9w/esKkFaWc3DZeXqyT/OtL2azqnPJKM+fYmWXSwKjk5bqhU
 XGaHLcLwK8p3thrwIEJQSlgHq5pMSoiHqiCWgME6s5XzoCZf8of+2/y9rFcxzE3+nEyg
 ft7/K6DTW94FcbqGZyyVJ1LIMZntcqcbN8yr0PHlGCwfCMxSDDoDmn+J62R67exO+XlW
 nysw/4mhxwYu3gK9fRSVHqwHvwBrTD1B/EN2KFsMEa+rpcpR9nXRvbjXc/v9KGTFb9Bp
 ZfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734798162; x=1735402962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFBvRT63e/bu7hx1QQj9PLnBWI3Gi8yt2omSCxC/DRc=;
 b=ExYdEaDFKNugSiwtIAny3nqofsD0KxYGN7rGZAVRdYhfG5RNnmVJPe0+qHbzRubDbc
 Vz4cNupOTmryIj3HpEhO0urWSSFLbvSRyGlJaZbD7O3lQof842yb+tJw6ooRWh5fMOo5
 t65pFAGuk6DFO3BePfC84cq/mJY7BuAA3TQ9jtpLqbG3gdrE2rEESx11Vsxga18vmBir
 ECW+poO5dd05ggO74BaxKF73FbZ8oL6FUZe3O++h2Wfiwp6oyXhnfzzVBrV+6cGp64cS
 oq8gxLXoA5DC/pyz1973ii/PMUJlK5k+SiebVd6F3CQpWP4HAWIfb63KK4RQviIpqkoi
 tbjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdfCxozWge5w21IiVSSxTvyQbpjHL/IVuBc0Rltbq7I0WJCILCQVOwsyD2WBqMSYnUWvptx3w=@lists.denx.de
X-Gm-Message-State: AOJu0YzsZHjTchXg1hHFqqhz51WlW/TKX8DnCDD+YrPpdrpiaH7aVN/q
 CYgU0X6ilMPbcpI/4UMd4+16lfqKEAOjkq2HlM6c+M5BpGaSV+y6JZ1FWEqAig8415+vCq8YiLh
 c56md5Kc6K+026KlgokxNFO7Mlks=
X-Gm-Gg: ASbGncs9RUUOZttjkFoEbjR7yVL3UFHTQ1DHm1k1zK1DrblIzS2WlJ0q71G6bmOmg/f
 ghRMDzsNzSSPNX58I1602skwZRE4rnW/eoiFmMqdcXc1ncXL0y6X6qs5IyKtHz/n+zRvs
X-Google-Smtp-Source: AGHT+IH9aQJ9ajTav9gokBdJ88Kxm9mNvgiu0BNqAVxfqVbHRy17RgEbAsI0xBvqzUSMjcnC7zeUaNX6tCQdh0VOO9o=
X-Received: by 2002:a05:6512:350f:b0:542:29a6:a067 with SMTP id
 2adb3069b0e04-54229a6a09cmr1788953e87.6.1734798161397; Sat, 21 Dec 2024
 08:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 21 Dec 2024 13:22:29 -0300
Message-ID: <CAOMZO5DwsuRyfXRC8JucS6DQ0n98ERh8V2g2xs+TVHjH+DG3WA@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.denx.de, 
 marex@denx.de, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
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

Hi Alice

On Thu, Dec 19, 2024 at 11:56=E2=80=AFPM Alice Guo <alice.guo@oss.nxp.com> =
wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> This patch adds i.MX95 19x19 EVK board basic support.

Do you know if this board boots without patch 17/17?

If it doesn't boot, this patch should be the last one.

> +Copy imx-boot-imx95.bin to the MicroSD card:
> +
> +.. code-block:: bash
> +
> +   $ sudo dd if=3Dimx-boot-imx95.bin of=3D/dev/sdb bs=3D1k seek=3D32 con=
v=3Dfsync

It would be better to call the final binary flash.bin to keep it
consistent with imx8m/imx93.

Also, don't hardcode the device name as /dev/sdb as it can cause
problem if someone has /dev/sdb mapped to something else.
