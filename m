Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71F2C47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 13:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252AE87DB1;
	Mon, 29 Jan 2024 14:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k9NHco6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0AF687DB0; Mon, 29 Jan 2024 14:34:40 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A6F087BDB
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 14:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cfb8126375so543656a12.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 05:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706535276; x=1707140076; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwCcPxLAaApgBPW7zKhxkqCWhc05QN/1Qle+1vMBJB8=;
 b=k9NHco6pRV5Jm/O18ed5cDgRrawi+BFD5PZFFBrO/i40+sAl7yyB7leMHf7T4YOKJw
 IHJytnxQYMZyntZ/psgNvonhzoDDjTy1fRrvqsDLXI2ub1J5hu5Gq3EWao/9C320vvdn
 8ePdkzQJoJtz0sjYP/tie1jv8yR8oTzD77ww7BO3MHezXOYJbuQnnq9FByFVGLknGBTG
 ZzUuiq37GAPDHp5x/SJVNdbuI9VHXCI5NayKwuSDB62SsZF9l4lvnpepaH3n3s9L8oeG
 FG2Z3YD290ay/xC7xgcbBfOYJNFcVtv/EYvkwWjmryAZQdGiKLRvYxjgbFF5yZZYIq0v
 PXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535276; x=1707140076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hwCcPxLAaApgBPW7zKhxkqCWhc05QN/1Qle+1vMBJB8=;
 b=oh5MXtBNmJug9OXhqDrh4rhjBvX45gUwIVTnSy16kZjCUJy53IEjbhK0gxWNIsk5R1
 cuTMWxv8NmBwQi4IjsdqeL+lXIZ1npEMiIH5UjlH+tMgyqRw5vejCm8xhFxTPXifJoOZ
 QVZE+tqOrSH6fdvH15wGoasBBJfPC1OdacdgrG0rpjh5yCADivYPpGhwkuqSv+1jee2C
 X1IYYol7JD4EsLfo9W68TM0IJEgY/HJMMwiYld3vmoCB7iP2pvmeEBKBDrX8hMlacNLk
 5Hgnxz9L+4F6uiJgH5u3/hzGYY9Fqqk1uEUwmFC65jnuln5HufkhHdwU521/3Y3bwXlZ
 LsOg==
X-Gm-Message-State: AOJu0YwepW8LFLZPGx7A5rhJz2vR9oiTXRNwXRo4GiHx8c31ktu1ij7+
 SNJom1jqjoKsAZVbaYb10hk4MWg2118A6dZglP1H7Ojh3hMWghHgECkfYo9f1l8+YiX7ZGpYd0A
 6Iu74YKk2ieeQsZVeQ4vbjGvdM24=
X-Google-Smtp-Source: AGHT+IF7BvbaocEv3S98eFB0h1hUE4sQhh1Gzm2iBYsEnCQsq0eT7xGeGJ58zKMS+8Wgf6Hqk+fGYdQvqXWmHcpBv+E=
X-Received: by 2002:aa7:98c1:0:b0:6dd:c870:2f7c with SMTP id
 e1-20020aa798c1000000b006ddc8702f7cmr7121806pfm.2.1706535276546; Mon, 29 Jan
 2024 05:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Jan 2024 10:34:26 -0300
Message-ID: <CAOMZO5BJRDdD5a7JZ+ws7aqz0p0nmK_vXiq33=V3s5X_4m8+-Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

On Sun, Jan 28, 2024 at 6:43=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.co=
m> wrote:

> +++ b/configs/imxrt1050-evk_fspi_defconfig
> @@ -0,0 +1,100 @@
> +CONFIG_ARM=3Dy
> +CONFIG_SYS_DCACHE_OFF=3Dy

Out of curiosity: what are the problems if the D-Cache is turned on?
