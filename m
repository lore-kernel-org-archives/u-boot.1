Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDF7C47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 12:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C0187CBC;
	Sat, 20 Jan 2024 13:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IaXmVu8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767A387CBC; Sat, 20 Jan 2024 13:16:14 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD3487BC9
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 13:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9b41a3cb7so483984b3a.0
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 04:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705752969; x=1706357769; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTaot/VFVY+/6o9Rcvp3tSiq2a6h7hFxYOdgOQAH5qU=;
 b=IaXmVu8ZdM4lZvbFGz1MBz2DYFmTfqWWrFm/IpGeaMcmhVn8Hj/VNvTZ3iE1KtGbR7
 ONomn8TzP5fHJJXvq6Tf8BHYkcF7VKLxT43BsbYwWO/Lrc5Nyq3Wk4VxMEBunQgXubAG
 aU3CsZDbOirFC84PEGpNrBTkjNrwWRVRz4YjvPa9RCaEUEGj5s1QCOtxTs174ZcSJ+69
 HLRujtOR9J1i4da8gAXmw+BaL6CoP2vbjWMGO33J7KyMi1ACpyNpTDSJI0tMYERkVL/9
 xSeAJcqUNPksg335c0WdSIqFl5mvEF4R/j8YYOSerJcrGX0VsitIPKuAq3Yn3y6wK44V
 c+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705752969; x=1706357769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTaot/VFVY+/6o9Rcvp3tSiq2a6h7hFxYOdgOQAH5qU=;
 b=gfYs3lwLg+YSVDg96qDhbVymeOnLVSouItCQNHWWUUPiao9uqa476J1PdTzX2ZnVvg
 dmfgNLBNL8LZAOdlS+viycdKvqvpsINW+r6UYNAtSGvoIt/x8allpiiGx67F1SO4JTRh
 o1UkrbQkjie7sP2UFXw3OBP+6uWcwdUC4aoMPwT+vO9tAj+dZXY5GsnfMEY0LIvH+rWq
 fEULHERUMkqtfYn4zOEFBqIKJwEH/Z1LZXqLCxKUK1r7Xf3MxG/mpyIk2pOtisKBaN+d
 iBigZHnwOc5NqJtEaO3Eo5nqZctD7DtkO6nM0WCeNX1sLvrAA9TAQrkPLIWyk1/Rj9Cf
 mnRA==
X-Gm-Message-State: AOJu0Yzsdw3SkrNmNZMfO8EbEqqG16ZGkkq/p7kWoAAbSw2/fvhHM+oM
 0ahBIvqZoeFiuiT2RfzK5AQ2f3SdUo6lOSiUGs1W+kzsEt+Hyqb7/1D+7nAsr00ODCs2346ke6E
 1VnyC2zOmLfVXk30S5OiwbxBuCYO2RVn+4CA=
X-Google-Smtp-Source: AGHT+IHyzc9OPZTxPJioeJbq9fklV2ehddAWs6bkINmauRsyo6sKSMW0NFNEqefS8KAfxcmltgE3WEQka6clI2MAAgg=
X-Received: by 2002:a17:90a:cb8c:b0:28e:8e5b:73fd with SMTP id
 a12-20020a17090acb8c00b0028e8e5b73fdmr1808649pju.4.1705752969418; Sat, 20 Jan
 2024 04:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20240119160845.11412-1-marex@denx.de>
In-Reply-To: <20240119160845.11412-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 20 Jan 2024 09:15:57 -0300
Message-ID: <CAOMZO5AJT3dcEWo3iW3gg3EFHO+k-Bt_95=QW-6Xq7jkCnpFkA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: imx: Configure GIC clock parent on Data Modul
 i.MX8M Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>
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

On Fri, Jan 19, 2024 at 1:09=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The CONFIG_SPL_BOARD_INIT lets SPL common code call spl_board_init()
> during the SPL start up. On this particular system, spl_board_init()
> is used to reconfigure GIC clock parent to PLL2 500M, which is the
> configuration expected by the Linux kernel. Enable SPL_BOARD_INIT
> and fill in the GIC clock configuration code.
>
> Set GIC clock to 500 MHz for OD VDD_SOC. Kernel driver does not
> allow to change it. Should set the clock after PMIC setting done.
> Default is 400 MHz (system_pll1_800m with div =3D 2) set by ROM for
> ND VDD_SOC.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@denx.de>
