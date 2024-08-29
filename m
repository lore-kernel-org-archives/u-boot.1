Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61968C7115B
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 967FC886F9;
	Thu, 29 Aug 2024 03:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WKet/RzE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF2E886A3; Thu, 29 Aug 2024 03:26:29 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B539886F9
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53436e04447so122888e87.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 18:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724894787; x=1725499587; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9oJtVaJzYjUu2FnA7G8i4YMP0e9lQ5kKbos+CDcoCE=;
 b=WKet/RzE2YF8o6iQQCUwD9PtG1+T2BMW1/n0obbCfkSv1pKBwbcThKr6rCj1xZa6JB
 IZtTf9G5C+dxJVqcWGVHcGrzo32Z+IYD/FE3ZwdUV3DgL8LV7L5l4fQRI9SYpewOIfTB
 KZfvfz6LUV2ODJ0cZq915ddVc1zVMLXLF10dB2pQv4/bffY1SkF4HLUOQxWO8VihQ1IB
 1h7Q4XwOpGEkVmUdSmyG2AM3Jq15Hp3wp2LpDp+Tavrj21RJNrkZ58afC1swQo4sVXYi
 TkNQT/lEDZbUd2NgUcxQ3qtcjlJGtXZFPkoCHwddazY0tjHKBS4FdE9yAxtR9aEuxgRL
 4tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724894787; x=1725499587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9oJtVaJzYjUu2FnA7G8i4YMP0e9lQ5kKbos+CDcoCE=;
 b=KjZYB0NyDPbijC0TmvINlvGVSZ1Sbg4wrFbJJAZmDzu923X62zVjXTiycrM3Mpg94q
 a/D/B+hIeeWnip96mdryp1OGBj6BgcagU6xJuZJ95m0vL77CBPlSG/iVkUJE7zL73SXA
 FNPXIKuxxnfWiTDTWwqDWbzOS/Azlz0eTre+FGi/0kn1Bwvydjiqhq311RxBbih4cQHR
 4tgmULbmRaArubp5xAOM9O1zVhIhKmTsGKPluko7sOqVujV/QqHyU1dnytvcn8UEFc/p
 BertI5nUij9y7NEcSksHTvGzTC/5Id04AhPHRGKimDoIQMikS/q/wMGT2VmmUCC4Cl5U
 6CfQ==
X-Gm-Message-State: AOJu0Yz33zjuTOm2MvzEikXCDXdxJpgBb4VwNYYL1s2KbnIBJtbvI570
 ZjA9jhepX8uxWqa4xZ67wFrNRZlCpiADlBul+22JKFaWhyG+hIc3ocVXJtd41CO4pUWeYHFkpP7
 nOO0c7IPyJkdjSduVYmvCsNc2lSI=
X-Google-Smtp-Source: AGHT+IGeb2wkH9QtRnaGq2+foN+xVLu4WSS/ts+tqsivob8b3ZhhJXMZ6qLNPMzVU3Rt1G3db19dXZVml44i6oUbCrk=
X-Received: by 2002:a05:6512:39d3:b0:52e:a737:2958 with SMTP id
 2adb3069b0e04-5353ebf75b1mr200062e87.28.1724894786178; Wed, 28 Aug 2024
 18:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240829012247.179471-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240829012247.179471-1-marek.vasut+renesas@mailbox.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Aug 2024 22:26:14 -0300
Message-ID: <CAOMZO5AnrOU87M1NigUqzF-p8zMctDv105C36XTzbcgKPbUyEg@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Wrap i.MX config options in HAVE_IMX
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
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

On Wed, Aug 28, 2024 at 10:23=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Wrap all the i.MX specific options in HAVE_IMX, otherwise they keep

Do you mean MACH_IMX instead?
