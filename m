Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3389C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 16:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE1387F6E;
	Tue, 20 Feb 2024 17:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A4TdNpXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98E287F9A; Tue, 20 Feb 2024 17:04:30 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37CBD87ED6
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 17:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dbdd58ca83so389535ad.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 08:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708445063; x=1709049863; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpZFcqS5lAIJNuez1OqzceDdShLxGZ0qJz8bwmzl0w0=;
 b=A4TdNpXAAhfSbF5F2sCwyWbNq+mmKMGQdNoZ2BPyRFSqXZZpal8IQdtzzqh6QEpFTT
 oGVjd3zg9PSZc2Jm/Zc36ToRcfaMiN+6EpIk2O0Z+rgvMum6+8FQv341k/hP3pcXhUwp
 nst9y3cDnRUd/+/5VOaZvi2gSaCb1o8AeTjTLBdoCh77lgPCpsA+PtwS+tddiu4T474y
 2INq55Jh3szvyey0wcw9yPtLG82fSsIt6T9ZMH1B0IrPQnL73vD9/8WO6uzi9uDrdNsU
 CCR0D23hmJuXlaAmp5Cr4SwCcLNVdetkNoaAATxjtFCYMazmAmGJqfmW9JjImNwriWPJ
 osyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708445063; x=1709049863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JpZFcqS5lAIJNuez1OqzceDdShLxGZ0qJz8bwmzl0w0=;
 b=bBj02L4/VQDBAj8mg0mhp9vwXbMl1txFpz/iLPT+MW8yA3McV8mOWyeSCoDjMJJEZs
 JOlPYn5JhHdJ+v+BIRsdj6nvjbzLGp89KUNDXsqxjhGFJY9UjIiXMOTZpVxUmFd8Vwhk
 gtnzJm3f1d+JoqgcTOaSEPzKdVDuk3eXLDy9vUDToswRV+Upz8+JYoYA5KAXOt9sjdV9
 bG3Yexqho74ZvFRq+Nk28bRaKtBUy0r4Xkg1Ia2crfAo0CwnPfXXtjpigNcrKZOWtACV
 FJeZkRt+mx/Ktu7ITVoUNkU9Xf77SYr8cTKI8zsETRiXnHw7BWNoOO9tiHhUxkbU6+8D
 DjhA==
X-Gm-Message-State: AOJu0YzhHEv1e/oXusTRq0Lji6U5GTDSduGm6O4XQcTcx0zbdSTK814H
 4UMf7Fbqtt5LR5h8UbNxznKXCzBx4Zz5HAZl3ejjpuiLKBMHo2DjhYGLXqAqz2N97WS2wUe+mED
 GCyyEtrH8EPPGXpjWN+HbHEk/ZSg=
X-Google-Smtp-Source: AGHT+IF9sZHq1uay5fnRo6r7bSQxN5cAkWmhGcJPZR8kJgykpva5Qwh/inKYBzCEy26mlpZSwhYqc0B4nz5iiaUhglg=
X-Received: by 2002:a17:902:c185:b0:1db:a770:81a4 with SMTP id
 d5-20020a170902c18500b001dba77081a4mr13011743pld.1.1708445063260; Tue, 20 Feb
 2024 08:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
In-Reply-To: <20240220131056.2962331-8-sumit.garg@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 20 Feb 2024 13:04:12 -0300
Message-ID: <CAOMZO5DXgO_etRG_FKJKwyEzUkKiFm=ZuiztxNcRQ4932N6CXA@mail.gmail.com>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com, 
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com, 
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Tue, Feb 20, 2024 at 10:51=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> Also, enable reset driver which is a prerequisite for PCIe support.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  configs/verdin-imx8mp_defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defc=
onfig
> index 22b8a334dfa..d8bd644322b 100644
> --- a/configs/verdin-imx8mp_defconfig
> +++ b/configs/verdin-imx8mp_defconfig
> @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=3D0x1b67
>  CONFIG_USB_GADGET_PRODUCT_NUM=3D0x4000
>  CONFIG_IMX_WATCHDOG=3Dy
>  CONFIG_HEXDUMP=3Dy
> +CONFIG_DM_RESET=3Dy
> +CONFIG_RESET_IMX=3Dy
> +CONFIG_PCI=3Dy
> +CONFIG_PCIE_DW_IMX8=3Dy
> +CONFIG_PHY_IMX8M_PCIE=3Dy
> +CONFIG_CMD_PCI=3Dy
> +CONFIG_NVME=3Dy
> +CONFIG_NVME_PCI=3Dy
> +CONFIG_CMD_NVME=3Dy

Please don't group all these new config options at the end of the file.

Use 'make savedefconfig' and then 'cp defconfig
configs/verdin-imx8mp_defconfig' to properly
add these new config options.
