Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02650C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 23:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F167287F64;
	Mon, 18 Mar 2024 00:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FmPCTEkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023B787F39; Mon, 18 Mar 2024 00:52:08 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC17487B35
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 00:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1def81ee762so4146675ad.0
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710719524; x=1711324324; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sM2FORU3Tb+XQVGGY/2TPa+4hiPY/5H4iSfYCg7FOl4=;
 b=FmPCTEkqN/NNeDrAOrt1gWcGaT3QYpxDZbRuc5SRw6Zz7Dp4Cmn6RXgltqUys12DaC
 EY9nb/l39pc2tKonequDLjWYWzqXjjf01Grhwr6yiVimcCPDXbPr/mlkXBJtaKT7/qMf
 fddqBAhI0VkZQSHVvImfpnXpQ+LY5H0u4v/n6XXJliljWMolzU/BpuPOizOl1bmwQ1/u
 tPi/S/b6bZA5CCvOv5gbO1S2n7XdPG0ziR8kTiS9ef9az23AW6gXqxn59UPoR998Jdiw
 IdSNnFKgpbGhbJ7tzOQqgXCAkTCLbTKP/nZJCbbZNFCPgkVLtlFmvIl8NLfcHCKVAp3x
 1bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710719524; x=1711324324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sM2FORU3Tb+XQVGGY/2TPa+4hiPY/5H4iSfYCg7FOl4=;
 b=rhCClXn0nBa2WSyRdmp7RndFLB3gDs3Yhhc9BR3nruvJ2LRJR9u3IMt3N114iS+1ME
 //0VLNdGWW1lPmnTywnAU57wyrvrLhvGeKa4VzvTkyI4gzDQm07G/j02wuVnpEp3di3Z
 ehtmgG3ZRi+wRNu1/5Em2Vs1epj5OVwVfQ761lzEx1WrPOcwqSizl9ons8P5+K7PUpfk
 1++tNY98MZMOiA3ytzBxdY9TM56Ua1KfiQBs4xNEbSVP9VoRq8IHlN1ovTVmV2d154PT
 Hykpz/6F3qddWSuc1RclZd/S7R2ZCfN4x2JaDlJOFWSOiRDIYjYBYK79KtBJgtp0spZ2
 J1Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPMHOBdQ7kURSwOJ4lounyk1ciQ+AqloGqjVYvkCcKEg8rHfTv/6bftT8AqnhG1rNtHqj6pXLFyPsP/xbVwdP9q4u0Rw==
X-Gm-Message-State: AOJu0YxPBhFwEu3udQHKzWA6ib1vnw+64J84qPkIFVjHwjWnv7MOFxVn
 8U1XHKRWW8JZKB05mIGizDT6EPxALVr2nojdW+HgKxS4DM1guMZzLIHoO/5KIC+/oNWhrakRbv1
 Dd+Nh2PVgFEnJo999Fl9/j9XrXC2a/WuhGf8=
X-Google-Smtp-Source: AGHT+IGfsmJjhPC97gICMI7J+Lx0dfsCzIwWqlbCUn+adRggj9jzpnSoRMVt9QF7CVpz+47L2xxwf9z4RXRBDD6TLVE=
X-Received: by 2002:a17:902:d501:b0:1dd:5a49:7a98 with SMTP id
 b1-20020a170902d50100b001dd5a497a98mr13798362plg.3.1710719524227; Sun, 17 Mar
 2024 16:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240307152302.2338472-1-parth105105@gmail.com>
In-Reply-To: <20240307152302.2338472-1-parth105105@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 17 Mar 2024 20:51:52 -0300
Message-ID: <CAOMZO5B9KsQGbsCWfbx8OHG2QMY8Lr6vdCnTBNz3UnRUST-3EA@mail.gmail.com>
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

On Thu, Mar 7, 2024 at 12:23=E2=80=AFPM Parth Pancholi <parth105105@gmail.c=
om> wrote:
>
> From: Parth Pancholi <parth.pancholi@toradex.com>
>
> Enable watchdog functionality for Toradex's Colibri iMX7 (NAND/EMMC)
> modules.
>
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>

Applied for u-boot-imx/next, thanks.
