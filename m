Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF27C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 13:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55F8887EFA;
	Fri, 12 Apr 2024 15:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mThVKoJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50A9B87E91; Fri, 12 Apr 2024 15:40:42 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388B587EFA
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 15:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2a2cced7482so241167a91.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712929239; x=1713534039; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UbN7FA0/ZGb/a6E+F81ojlgz7W/Nu0ytrrKI8lpG2c=;
 b=mThVKoJBSUi2Ab4eWLL3ZWtQEkS6ng2Yj5H3zNZ9lrY4OOvAGIYFDkbVIu2fWLBHTC
 X6vR2H6jNo0l5Hj8z0ZV27yOEMATR+os4bfNBl2b2T5Xd9ZV+0558xqFt3aJaZpKbcVL
 yk0dCIfZWGqXUHBmF2ORHfDS/seaHHLjLjrWS0AEWzkQRFEkWmSpRovqHTu50V80V98m
 M+Z16S04QEffKbHR/rUl7kA/7t08NVyYtPEbSqhFssT0Di1nPdHoQhy46itaQkBml0o3
 /CjNitSPhG8+vZXKjFXjNQGyckPPeEAd5uoisL8Tij9/rI5rsmw8HPzdyRHC9I6Gi7NK
 sl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712929239; x=1713534039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UbN7FA0/ZGb/a6E+F81ojlgz7W/Nu0ytrrKI8lpG2c=;
 b=Y6lRCgw7LvSenH2PUgXQAQAFGAJgK5+ZeMMmp/rLNGifjcTp8yMNNz8l7uaAjLBuJa
 busJuhX147Ik9RbgXwU8JHkvcHRXkpOssL97Ha6CFJr03neT9VRntN0y3dmDRqnUMMLf
 iMyzQk7x3/6fJJtxlDSRraBmrhEDLqHdGIBw8s5k2HU9q1Yfvt1IRixFjWPCtFuOZzA+
 jRwhboplxlWzOshhPMvFsT95uCriooeei3Q0YPehX7Rg+RPZLSxMEPd8TaSc01b+uthu
 y/5wB/DCpFSJ1TPQETSJW67ODNYrdBXRx5wPPwcacTyKXYdedf955iViziEfJaONbv0g
 Twag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy5O4T4VGJ3ndeEKG9NUh9sHrihCE3k1R0hF1KC+cPdXTxqldrusZU6vGzpfAZGKSCu12eB7Q3mzrPMYp6Sn0P4HRskA==
X-Gm-Message-State: AOJu0Yzz13GCgTTiRVb+2iqj5PVsbi7+cTl7PvF912v3+IRUEPWYsixl
 SJn4P9S6iSgc3p8yvQa7PqcqhuoYuAxF3CAAVzc8YIiftbj5SfEC6Md2VQEW3ZY0dxB0SAYNitB
 EBc6xXABwosb82WVD8EOe2VorYiig4FYF
X-Google-Smtp-Source: AGHT+IFRVN/LXsHL8V9akMLUi7wmv+rzRZFLT3kCxStqhovl7SPIEi07n7kW8f9u1O9+v9BKKC4EKPn7sOM+qkb/7ao=
X-Received: by 2002:a17:90a:d704:b0:2a2:afca:c635 with SMTP id
 y4-20020a17090ad70400b002a2afcac635mr2518080pju.0.1712929238651; Fri, 12 Apr
 2024 06:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
In-Reply-To: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Apr 2024 10:40:27 -0300
Message-ID: <CAOMZO5B6PCqU8G5EXDG+41T7nVmJqFPgwEVfZvpYmryACRFmyg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] imx93: Conver to OF_UPSTREAM
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Yannic Moog <y.moog@phytec.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Wadim Egorov <w.egorov@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, PHYTEC upstream <upstream@lists.phytec.de>
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

On Fri, Apr 12, 2024 at 10:24=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> A few nodes were added to soc and board u-boot.dtsi(lpi2c, usbotg), those=
 nodes
> could be dropped after upstream linux supports them.
>
> To support OF_UPSTREAM, a few driver changes are included.
> For TMU, still use U-Boot node, I will prepare a kernel update,
> then back to U-Boot support.
>
>  Mathieu: please help test the boards you maintain when you have time.

The series looks good.

I will apply it after Mathieu or the Phytec folks confirm this series
does not break imx93-phyboard-segin.
