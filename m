Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB62C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 10:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EF8887D07;
	Mon, 11 Mar 2024 11:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H5FqnFqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8084487D07; Mon, 11 Mar 2024 11:44:19 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A5787CF2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29c17ec16f6so70092a91.1
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 03:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710153853; x=1710758653; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EY3lXuCPHkCDiHRYv2jdZO/3P0dD2i/9v/dJlf5u3s=;
 b=H5FqnFqdR10Ol6PD3j87jv4SJY4aLcrjRR2MJa56yuQjYxQeulZlygiIwiAj+ZmCqz
 Us332PVIg/hQeTf9+fb0ekzIBr3daJj2S9MuFP6dniTcw+4FGJpBbtpeOIQQwVsjBueD
 c40DQggHv7dc714yaJkQ1v4D04ObVM35+n4EFF/duS2HFqYropMzj6J6tnnxScs27IxU
 cqEDBJ3fEv03T/NLu1Zih3P4mB9/j9OqNmS4DfyjBCP4GeFELWzvQuGEWi9NyGit+W7j
 7G0qXnJzDjwaoHRFZLp3NMjo3nCyIQGb8TD0MkKQjU0IAe2usCRdCjcwnFf0TRRw5U5k
 b45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710153853; x=1710758653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/EY3lXuCPHkCDiHRYv2jdZO/3P0dD2i/9v/dJlf5u3s=;
 b=B6Xnqp2stko3PF/mS/aAjKDeNF2BzbJY1yDvFn2vihtO2YzeUywpDTRnveNG6N1YnB
 QO9+gg8TMH+nv0Q6NLUHznF3/H/UdHQXE3HCGZ2PGw6NrE3UCZscTU/z//Nq0tDwsAjL
 iWz3nO9yT16AnjoONprP1EcKV74dxTMvT6PcaDJadqBs3iqvo11T+i4cYO1bG9wBdre7
 VBVZn0yoiXxiI3+ROQKjuSF7EKEU5aiXtnFXodr5iB0q7CLqGBIgdR8QXeT5mUULaXIJ
 hesFtHySnC6Iyd/dQfJ4mRepzbeEs13NCfTeXf3Fppo0/+ryfoCbtlYi9eAOJPKjdXmn
 uf+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo3i7H6KnfbtOQVXjXl2IQ+/EXxdanhlcNj1HHfO+su1I+jhm+8fkSaVbgsetPUY2ErRXVkoRtPEth49TkXq4DAxhjnA==
X-Gm-Message-State: AOJu0YyH6/Es+jYlQVNtXcgt2A9DlPkry7mKkjX+b8FvUquuhQvwfCQo
 G4kiI8IrVgqTqnWJxOoGEFNyhM80amL5SIAfK08DWUfYPm3TO5FvFKwNNNB/S5sEwymAaMaOnRQ
 +UhR9/xW1OX0K7Sj6vszS76eY1Vc=
X-Google-Smtp-Source: AGHT+IFhF3FCQYYdF+0mKK+6ebL4dwg+gMw4WQaumQQFtO+rydZ9tP5K26tavYs66pwnokiXS2Tpp/W4JMC+7Ii1mhw=
X-Received: by 2002:a17:90a:498c:b0:29b:bb08:6997 with SMTP id
 d12-20020a17090a498c00b0029bbb086997mr4644473pjh.3.1710153853720; Mon, 11 Mar
 2024 03:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240307152302.2338472-1-parth105105@gmail.com>
In-Reply-To: <20240307152302.2338472-1-parth105105@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Mar 2024 07:44:02 -0300
Message-ID: <CAOMZO5DrVC9+=_EGX7ADYFk57MfLbEv1YjcdKRCPSFZ1_yHmpw@mail.gmail.com>
Subject: Re: [PATCH v1] configs: colibri-imx7: enable watchdog
To: Parth Pancholi <parth105105@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, u-boot@lists.denx.de
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

Hi Parth,

On Thu, Mar 7, 2024 at 12:23=E2=80=AFPM Parth Pancholi <parth105105@gmail.c=
om> wrote:
>
> From: Parth Pancholi <parth.pancholi@toradex.com>
>
> Enable watchdog functionality for Toradex's Colibri iMX7 (NAND/EMMC)
> modules.

You described what the patch does, but the reason is missing.

Is the reason for this patch to fix the 'reset' command regression
like you did at:
https://gitlab.com/u-boot/u-boot/-/commit/be23b1331fb35b7d5a095ef2c0b522c1f=
241eee9
?

Please send a v2 with an improved commit log.
