Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AB1C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1875E80FE1;
	Thu, 27 Feb 2025 13:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B20ExU+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A7E380FF0; Thu, 27 Feb 2025 13:50:04 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFF78083E
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-548878c6a5aso916170e87.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740660601; x=1741265401; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQCOgMT27o3YnRgENVdK1GmcSuw86gW9rOKvDrJBhbU=;
 b=B20ExU+K8hcbbsn8Yd4JGD6I4YgJnJw1+CqU1HZuhYz70iop4z6/cvnZbWu3Yi+dbd
 ZsD7YX+ABRTJVRGAxojGk5LDPjuEC2kMhIcSnbLkjN1YnK5uRl2iVNEjAUmBfewn2vwS
 j/wtoB/2QedSc7DOLoZYYl7a3gu5adqNzvUjSI8Q2APGrfcd/6owl0ANwsusSOaLcR8s
 9zlwikgmg9gk0BUzAQl7blECY5FjsUtIOaw7I7h+IO5B2mQt2amyb8PPXXO8uekYulFh
 smPs7+n1pwS2HdHkG/VJ1s+bgamXO7Idg0FuzwHOkoiMtYzbaDhUTz10935uU+GIYasd
 +Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740660601; x=1741265401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQCOgMT27o3YnRgENVdK1GmcSuw86gW9rOKvDrJBhbU=;
 b=cdfkieTGHR3J6sRCNT3PVElX7sLJCA3yK6TYlP4PERQJG+l9ygg4a31pVMtiuN3A0J
 8hHRHuwel8LVOgJQS5K3OwTrxLgTG/m+DNRBJ3qx3USXvbMP2ZKt6OOq570aWCsxTeIs
 xjQkgK7H7JITRFYlN3GLaAEcpwMQPaQPEvRxVx/uDM9FsbP71beOaoHdmUrsbjrMtlwz
 Z4W6UFcf8lBQhJuBSnk0IpuNKhde67h8Wol319vjPA3IgT+7luc8mDJ/q73LX58x4aqK
 3k8vQLTHTHMoMQls6+sEs9HmuZYxHM3611EYvpvEONMZw8yKegTCwrcWRhE2Qd+MvGz+
 VrfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIinaW3e6zeajYhXp4caXleA/rFtRx1YWUCZl5Iy1xF2D2H/GxAlLD2W0W1nJFg+nd5kpb4lY=@lists.denx.de
X-Gm-Message-State: AOJu0YzrmuD3sFpSGgyyruusD/hBV1aZK9f0qCisymJHEfqbayxJaBwk
 d06+JmJYS2MAJSSp8LmW/9+CcIoB7RS6r4YzKKIy7kDOqggqpcCv/vRVKk6ium/7w/dg68DJeY3
 Jw2zcYLOBp7zfX5JYNJ+pZXO+Smk=
X-Gm-Gg: ASbGncsKMFAO8x9X8ywT9MQerAM26ZFqwcxNdCdkjfhUBHgSO2wZaY2h+VjTrSbjNCn
 qUGGynzEaSwSwbCNJZSoAh5YywGzPNmigYm374HCGDHsUntfQzGRt4hqy/rraAAMRo9ihyslqQ0
 +10otWpSqwg8QuEmQw/tgTWTkt1RZvFSVr+mSuGnE=
X-Google-Smtp-Source: AGHT+IGgek6BBBgQ8GKcHJzpCJC1pBNNkcwcgWxqclI1cTYa7gBEwwL3CifHQ39RrHky0BLTy9Cwq94g5siEsbU+VvA=
X-Received: by 2002:a05:6512:a8c:b0:545:2c2c:5802 with SMTP id
 2adb3069b0e04-548392634e0mr13208482e87.48.1740660600502; Thu, 27 Feb 2025
 04:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
In-Reply-To: <20250222121711.6697-2-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 09:49:48 -0300
X-Gm-Features: AQ5f1Jogks2JSy-HVopGTm2caoqmEg9TTnvFIxoxKnPGCjKflMh3UqLsPxQ9F2c
Message-ID: <CAOMZO5BzmFyXhPw0rhpZzkFs0uRiRvEzACLry-4ToTjPWUpiYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Ludwig Nussel <ludwig.nussel@siemens.com>
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

On Sat, Feb 22, 2025 at 8:10=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Select BOOTSTD_FULL and BOOTSTD_BOOTCOMMAND
> Correct DEFAULT_FDT_FILE
> Correct env file for imx8mm_evk_fspi_defconfig
>
> Fixes: 364ba68ed1a ("imx: imx8mm_evk: Switch to BOOTSTD")
> Reported-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Series applied, thanks.
