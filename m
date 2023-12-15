Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E8BC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 01:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0017187B57;
	Fri, 15 Dec 2023 02:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m9UMt8aJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DDBF87B5B; Fri, 15 Dec 2023 02:18:55 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D70DF87B32
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 02:18:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5ca5b616de0so47557a12.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702603130; x=1703207930; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifFLqfXgua7c3mJdFD9sHT/5cXm5kjyzE354J4i/tpU=;
 b=m9UMt8aJpTPpEeYXbVGZ6WIjUxeIXWxpTDtO0R2HkHRGwBxJ22J2MA5JRLjER2tDbK
 o7P3TfhnKBOISocXOlA6xjN5sTQj+Y91RAm3XA/+nD75I0yt7/0UovrplI8cLoNBmOYY
 Sftfw8WiYNbl7+TeODchyfbkuq7BUbwN+n5X8i0GgvO6uubcTeUU5CCb+Ubl1kb/80Al
 db3gv0R8tD2JYOcMmx+w7F4Av0HQwahhl7DR1+oOJK3y2hNgiDCEtI5K/Yjw0q30A1bd
 EcCqCR61DF5i5xHe48WvRDlPpqCgocerD6gI2HH14Mj3lUmPHX7+hK2B64XWA+NEimXm
 k5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702603130; x=1703207930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifFLqfXgua7c3mJdFD9sHT/5cXm5kjyzE354J4i/tpU=;
 b=VxJ3dbnklshttmRPZcr+2IyQ0Ad2jpU3wUjnr8BNTM4PxcsPM+hYcvCHKBt1v7v78C
 VCJvBSbULexXpuP5Rpxb7vVfjiYPc2sCFXY29joRh51XZ4d0o6A+oXe2J/rXkGJ4MnqE
 Q3c84CkEbIpWLxJAI5ba/1DIPn54LHa5kVQ+Hes/gw+9Ez4xWx/wFXpSBXHjaVYAbJMJ
 NXT1jFANS19NE0VfWDbZiHeAr6DkXyxI2OdqK7VNstK1BDWo1wSObRowKagdlu3dGv73
 t3uQ36Lqt78HwxxvTRQgDf9Nwaf2D4RYk4qSldFsLxBEqIt9xlZ1vi4D26HfsWCHI4z+
 3qkQ==
X-Gm-Message-State: AOJu0YwAU0282yy/0BWuuc60Whbh849KcN3tQ8o7n/IPYZXyqaPaG62N
 EEvCo+xkfEip0WhOEjcMeAsiWGmI/H4V/92k520=
X-Google-Smtp-Source: AGHT+IFY5L4+vCsbqAUXghreGWkHe7BicL/p4GH1fvyyZiFgugxRBWaFIe+LwoVJUl9HC+ejOl5Yr4WJX4eKSLzkj0w=
X-Received: by 2002:a17:90a:6345:b0:286:4055:63e0 with SMTP id
 v5-20020a17090a634500b00286405563e0mr18508199pjs.0.1702603130198; Thu, 14 Dec
 2023 17:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20231202015839.213942-1-marex@denx.de>
In-Reply-To: <20231202015839.213942-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 22:18:38 -0300
Message-ID: <CAOMZO5DtbLhq21WfkMpB77RJA06r6GaMtvU=BvoLH92eUBCEvg@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable CAAM on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Fri, Dec 1, 2023 at 10:58=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable CAAM in U-Boot to make crypto available early in the boot process.
>
> This has a side-effect that in case an older kernel version contains a
> broken CAAM initialization timeout code, initialization in bootloader
> will help that old kernel version function correctly.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx master, thanks.
