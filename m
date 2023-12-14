Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361C8C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BC887B0C;
	Thu, 14 Dec 2023 19:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qNhvSjyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C8487B18; Thu, 14 Dec 2023 19:10:11 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E51B586828
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5c85e8fdd2dso81873387b3.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702577406; x=1703182206;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77JdjkOZCz0rbnoXuI8sI2SAkJxa8g1yHDqAyALUiZQ=;
 b=qNhvSjyKpBpg5XRLcrbpCNuoGcwl4B1jYni1rTU8Wnx+Dmwwzi8Vf9ITKhfxOPhWKj
 WYPB94XrWJ6xEPqzsFu0CWTPFu6gGOku8Gv1/JNj0QRQhPTKlx7wMKBrW5+JALQDZz0l
 leg+8fd2p2V0V/M7R38Q7/HR5r5dFGI5kq/Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577406; x=1703182206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77JdjkOZCz0rbnoXuI8sI2SAkJxa8g1yHDqAyALUiZQ=;
 b=sHDq6eJUWI2J8F8TNuxQeLBi52xvPilsa9g8gMYtc2y3WjgrUlfgipyiW8Nxn+bWKY
 NeLgPnvJJaWdHjASVF3JSWguiIMx7j+2n7B+49WQSnKmRHWJGtdqSyI1SpcHT+sGkSNM
 bPM7K01Mo92rnGJsNtXRiBBCFQ6EJkL9NDlWBvDkJjJFru07tX6dr7uk4eDb/E8VXEDB
 AkpRxTZi1TBZMXhP9sAQGHdmMRuKDwS1o7nATXdGaEO6t+Pxh03NnDfPqvzR3UHup2w1
 SqAZvhvfsQQf47cDLceYB2gefxCRJdf7kzke5oiFy5lGjimIPB+E2NaPc4PleA0U5fPe
 cb+w==
X-Gm-Message-State: AOJu0YydAXlZAyGVFQESKEIBHwo+2SO/eOkVMgJjS2d49lMkzddvVawP
 9qMWKf6tG8hGKjZR3LfOPhfvs4rZeJarCxKTGxLCB25IpKiXJmhJDoI=
X-Google-Smtp-Source: AGHT+IEMQq6KFdPIZD3E52rdBQPoJ4M5VV/yJXl3RwkteuD6yzz68S1xf1BlaYao7z4/rKmjW1wN+ndw3iDMu2WM80A=
X-Received: by 2002:a25:9cc3:0:b0:dbc:ddc8:e751 with SMTP id
 z3-20020a259cc3000000b00dbcddc8e751mr1688654ybo.117.1702577406621; Thu, 14
 Dec 2023 10:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20230804203501.77159-1-seanedmond@linux.microsoft.com>
In-Reply-To: <20230804203501.77159-1-seanedmond@linux.microsoft.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 14 Dec 2023 23:39:55 +0530
Message-ID: <CAMty3ZDGD2_BM-VwdmrQ14ep9wDR-T6BQz9veA=zbzthh_fzNA@mail.gmail.com>
Subject: Re: [PATCH] drivers: mtd: Add MT25QU128AB params
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, vigneshr@ti.com
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

On Sat, Aug 5, 2023 at 2:05=E2=80=AFAM <seanedmond@linux.microsoft.com> wro=
te:
>
> From: Godfrey Mwangi <godmwan@microsoft.com>
>
> Add Micron MT25QU128AB flash.
>
> Signed-off-by: Godfrey Mwangi <godmwan@microsoft.com>
> ---

Applied u-boot-spi/master
