Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC79CD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 12:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59152803C6;
	Thu, 28 May 2026 14:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UHIBgtEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D10839A8; Thu, 28 May 2026 14:43:56 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA04E80087
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 14:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3963c468e0dso5481951fa.0
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 05:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779972234; cv=none;
 d=google.com; s=arc-20240605;
 b=JQWq2NF+QNdA/ZvVJq9oTp94dZVcOpbsjrOTBH+m9g9u6qPXtoj0s6du4bdzinqsIH
 K/NRcEX9Hv/QEM87INEDBVEoVt/qqgI4Fe2IAHltwT6iKbuYFLX55zI5pRsOT25MqdDu
 VZq1niOeY3hSh0pEutuYOieL4M0dOEQmw0Fjyzlv9HeYHsjjsSYGVH5yVuwfbxM2bBQ4
 V7IArplcyiOzLEG2udvyvDNdEmyrD73CMV0HB/4CeNjA+4WzQAuXvX9WFF0UKNx7N2yq
 BWcsInwGngGNT7hIlTC6pAeeNUjZwn+83J/o6H8bb6CpHqJNpX+eybxqJsQrHSugNCbY
 rA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2tNGzhj/eiGONEuFh4B/S9JwAsMsEjzb5Ag+8V7C4PM=;
 fh=NRFM2gW6pFNNWYCYabUkzVmyCZlDyuyONd/hNT9XRcs=;
 b=ifUddtgNFexXyXceIUH0UEiUriC26rl42t9ua3EKfz8G+Rz+ybWh0CDdiSXQW6Yy7/
 U7Ni7dRXvUXBIeX4j/dyKIv44uAwGw6lX26RDT0DQwGt+PrleoK4XOQUhKrmvSrowFu3
 6nxlMwobJIYN1M/PZ3qa0smxy+2qxHfw5EP099AtWpG6Mxdm8yGixoI+e3LJeXMN/esP
 BJcx2jYdTTSfKGG2GwAqLeNPeowgBX8CvuFxbeI+3xjbbcdhCAkE5EDpVMYj6veRAVUS
 q37o2HNcEnTT6Q1xt3tmBdoWjxFw8ZLcpsWYGXCl27cyS5Ba4kVctclxofRvCpCoS21O
 Th3A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779972234; x=1780577034; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tNGzhj/eiGONEuFh4B/S9JwAsMsEjzb5Ag+8V7C4PM=;
 b=UHIBgtEyzdH2UhoKEwW9I6pCFkE8Go9Dxz8yf5doBKWt0wbNH/yiwo88sPjw6R5oLt
 4meykx6uzJEobxT0Cu8HEoVGxLjNZ3U2N4m4A7qCiJdQbLnaoIKbjk38Xodm8jV4/xWF
 dq2cgTPCh/LjJ78uN5Ge2u30yI2v4tg0Su69pmRR7ze+Ab7MYmCVy4AUo2VAQKb+tOja
 ejmINnAVeuWEORgF1eTaTjCtW43cIWvnR+ytqVP92y2krXGag8gYVbVxM1rRcaE+CION
 AFeI+xxp8eTbhOc5fUIx/uVTrEoFlQq2c1+WZxLeUKZtNH8dalQbbExeHHcsCmr3KpXB
 Dy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779972234; x=1780577034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2tNGzhj/eiGONEuFh4B/S9JwAsMsEjzb5Ag+8V7C4PM=;
 b=UjBvkYsh5k7OiBnXEd0WSJzV6i/DvVxXbk61l/9rfe5povS8PTCOsOYT6tPQV695Pv
 sh3NLeTOoxLTTDSL29TqrUekfYFS/uwDejDIqVv8eg50g7GfKQJA3M1/Ts5LB5HMOhoQ
 w9WToRNAZROSsltJ214PVLCEaOttRwMGmWDtF16zO6omP4nar+s/kl3TMVWP7wdg6axD
 QgcffcVoPTke90618GAFR7x3EIHZ+j4UrxsoL5unyw8cBwqXijphY+MSsm0bjmfhJmR6
 fZQ9D5khLSCu5ZVwxCTqaVU9IlvJUrgO9iUrhT3iofYTyTqycSPt8x1bLFuCHII/ysrA
 cplg==
X-Gm-Message-State: AOJu0YzUp42QaNynWcLvDauEniuX6eAxjvUUzQnUQ6K0jOeoAcYkxU+D
 6stiFC/ekYsZXWbhdkff1sD3qE64tGSjGxScFyuWJYWs2euqgc4Sa2I3870mWErgclQWULKDIa1
 5sem00Kpct3XfoHc0tRg59rbMC/RXoDw=
X-Gm-Gg: Acq92OEh2JSTuzpr3PN4yEsjmfqJjcid3j9fTgj/IQgSxU+Yg8T2ZvYJAsJ2Ol2g01j
 nVJdSbtJ9+A0Q/9Ie6jzgN7BAwspekd7GxepbBG+XjKO+qHjBQU0MZ8te9HstcxgdmhUoG/TTez
 C/a0e29ee9xQd+9jIuiCU6dccSOz72/BXLnt6dzGcMEWhc8OMBsqWhrne+bPwuTMJIhpRJhqgZY
 WAoGWBJiDBb2i2rTMemQfxw46cVr1O8JDUMhhlA4hXC4T5u1awGS9w+kjX+dCQmNf2ylGLaZEzi
 sPz/+nqAqduPN0/IhQpqvMrZ7gUrijIXDERask73NOnvsULEufs5kvqieqDTHAQcaoCwAOO969e
 3Itohh0k=
X-Received: by 2002:a2e:b6d3:0:b0:38e:8902:7a7f with SMTP id
 38308e7fff4ca-395d8c8b744mr62057641fa.13.1779972233582; Thu, 28 May 2026
 05:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260525235155.96167-1-marex@nabladev.com>
In-Reply-To: <20260525235155.96167-1-marex@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 May 2026 09:43:42 -0300
X-Gm-Features: AVHnY4LWGIUdNhObdJzACB-iN0lxKo7KTeCBscfg0KKUNNIyRGuO28Jl5JS5rDc
Message-ID: <CAOMZO5DN7DD5rNAbL0WxVoCHxqikjS9aVdg1q-SVXxEhOLrQCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] binman: imx8mimage: Handle nxp,boot-from = "fspi"
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, 
 Alexander Koch <akoch@initse.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Mon, May 25, 2026 at 8:52=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> Boot from FSPI requires additional 448 Byte long header, with U-Boot SPL
> starting at offset 0x1000. Currently, both i.MX8MM and i.MX8MN attempt
> to generate this header using fspi_conf_block with filename pointing at
> CONFIG_FSPI_CONF_FILE file. This does not work, for two reasons.
>
> First, the CONFIG_FSPI_CONF_FILE is generated by mkimage -T imx8mimage
> and may not be available yet when the fspi_conf_block is evaluated. That
> leads to a race condition where highly parallel builds fail to find the
> CONFIG_FSPI_CONF_FILE, which is usually called fspi_header.bin, on first
> build attempt.
>
> Second, binman gets confused and patches incorrect offset of DDR PHY
> firmware blobs into U-Boot SPL, the offset is incremented by exactly
> 0x1000 which is the size of fspi_conf_block.
>
> Fix both problems at once, make imx8mimage handle the generated FSPI
> header and prepend it in front of the imx8mimage processed data. This
> way, the race condition is solved, because the data generated by the
> imx8mimage are surely combined only after mkimage -T imx8mimage ran.
> The binman offset calculation is also solved, because there is no
> fspi_conf_block node in the DT anymore.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Is this series 2026.07 material, or can it wait until 2026.10?

Alexander, if possible, please test this series and reply with your
Tested-by tag.

Thanks
