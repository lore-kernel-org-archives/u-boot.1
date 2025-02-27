Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F9BC021B8
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 02:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C1F801FB;
	Thu, 27 Feb 2025 03:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E0M4/OPD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D62807EE; Thu, 27 Feb 2025 03:23:30 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B228006D
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 03:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-545fed4642aso408099e87.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740623008; x=1741227808; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1xOGd3N5TFnuHpBRqiH1UJd0tcgghOmlT+5pYpcwjw=;
 b=E0M4/OPDcnqs1ETkIi5kuL6+6J299iY1RvgYW9JNpM4lHOsYJfkVGHEnvinL66wd/7
 AU5Itrj8OuqC2qY6ja71Sn2z8lDN8uoR4YPXOqLqqSFPjAmmfC2CGKhRJkeJoroo5xms
 w17E7TV77Bvu96vZn7IoAMJTUifI+FxPTCqEsz9Gav4BWg0ErByi9mDG1hP3UfDaYZxT
 1Ys/EPP5KcgP8uxnLqGQmny067TjJYOmLW5SKnG2gNSji6KmWwiEyJkvfDr6QtXcOqpV
 VGYXCY18WCAUX6bmjOg1x+Yrgu42OuG8jmp1lJvft/XvAOT1vVrR2mwLrRhNE/pNT+Xq
 vpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740623008; x=1741227808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1xOGd3N5TFnuHpBRqiH1UJd0tcgghOmlT+5pYpcwjw=;
 b=Bzk9uX3V7hmcLQFoA9TcPax7AJWYP+J7KvnEbpYxt6gEFzRzsJzf2H09NBOTx7vmWG
 eq+U8nw5/419ObEvMlfbxRBNAhMZGtAdx2lPzq+2Zru+RAnMbIBqmv/o4w/c3uyzu4N2
 PQ1hwWYg9uVhlMTVWaZZK21yO+EuzK1X3Cz1aK3ynL40DTjPOw9nOl2hkBGnZoBRQzZ+
 pgm46HsXyapfIqXMPe2+Ye4glKQQg2/Jwf5UeAOSC8VTsromFAeHOj6O9Hg1CstRussO
 2dNMJiwzU38QuLiozRqFzQiGT/TA2DiHEZ2saJRjQU1/ZS7iCsAjZbxH2MbBGOqU8omj
 Ro/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Gj5cVyQO3KpRpv355IdPL2ptE15B87J8VG5PAh4/o6+28MLEAKqICkqglIgVYKvau+yZiA4=@lists.denx.de
X-Gm-Message-State: AOJu0YyT8IV0tOMLQYWU3JyhMNwEg9maIvt9uzJofXeDdwA1VWoy+wc9
 b0OHavpahu3JKZrAlr4vFmN9R7eWYAFP31Y6Ze4IJj505qg7yUYoa7Zos1J8/t8w5c0Wxrk4TwU
 pUcA4t97vHJvC0FIRjCVLjP2jbCI=
X-Gm-Gg: ASbGncvveQoOJGvTKeTfwiso7PxmlvhsjQblsJr3XIoxTlvb6B7OwKEM0Yq72KeJXs0
 lmL9iV7djRI4gBc7CtAB5v3RPsaeKZi3ztJjtU9Zo7Z0co55akfNTKryAjURahUO2X4slT8O9OD
 vkROobN/xOfSWH6f4firM6z9IPgWDIUbLk5a77SWc=
X-Google-Smtp-Source: AGHT+IGwn6pWqlZce9sNEpa+w1YfhoTJv5kT9eWS9muOEgcKrm5qYD6DHShdxV8e0tvdxsIlooLmJaJpCvCIi7+9cM4=
X-Received: by 2002:a05:6512:3ca5:b0:545:2ee6:84a8 with SMTP id
 2adb3069b0e04-54838ee76c0mr11046447e87.14.1740623007515; Wed, 26 Feb 2025
 18:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
 <CAOMZO5C3UmU45sN-JyS-qRkVbFC=wW1=OjhZ764UGbmK4YJp6w@mail.gmail.com>
 <20250227005524.GP2640854@bill-the-cat>
 <CAOMZO5CMHA3QZKd_6uO_u3hj29KWe4dvYsY5SLaDNznbWegY6Q@mail.gmail.com>
 <20250227020856.GQ2640854@bill-the-cat>
In-Reply-To: <20250227020856.GQ2640854@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Feb 2025 23:23:16 -0300
X-Gm-Features: AQ5f1Jq0VSH68SPUoKsd66om7Kar9epFlgTbYvXbgUTsRu9gnY4bjAWFjDDMXCg
Message-ID: <CAOMZO5CXNFgjfeUa9pzidsOcNHfgp0JWwAgY4H4D_zvjUun8Bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 uboot-imx@nxp.com, u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>
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

On Wed, Feb 26, 2025 at 11:09=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:

> Yes, it's not that extlinux.conf is doing it, it's part of bootstd?
> Sounds like it should be implied as part of BOOTSTD_something rather
> than per-board.

What about this?

--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -564,7 +564,7 @@ config BOOTMETH_CROS

 config BOOTMETH_EXTLINUX
        bool "Bootdev support for extlinux boot"
-       select PXE_UTILS
+       select CMD_SYSBOOT
        default y
        help
          Enables support for extlinux boot using bootdevs. This makes the
