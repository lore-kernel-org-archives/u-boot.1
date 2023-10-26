Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68CAC25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE85587B6D;
	Thu, 26 Oct 2023 16:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ir/sdJc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F0B8875F6; Thu, 26 Oct 2023 16:18:15 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADCC86C61
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5b83d83c19dso74548a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698329890; x=1698934690; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbfnZ/Wpkkk2artvNcd4NtWt6B3nSe16B0gl1uHq8cM=;
 b=ir/sdJc9amyVyRyvjG1+HvZbal9XD0ieSaLoiEWyZnNt41eGDjLftFeXEVryHrDYuA
 rKym8Wc9xndkXpSU5FHyBxQeaPeNWA04YX7LuUcVGJOdZiy+aRG8TaDuUg+HbysxYU9i
 vTlWjZvmKZI7Ep77SHvsKnsJ7kmUKl1Z+mnNPghZ1iDkCE2zIc6ABAPu1bT4N+uLF8eL
 eknk/+M+o8h3YU6xhTUE7+7q0TmRUXdffmz5mMD9G0A8p6nt1ahsv1iiA8kXPIIrH1Sb
 jzdMhDo05C13adx3zwBjvw832SNvY0dtaPqCZKiURAsVkV+b/72XTA6naAhk3McN8lEg
 NFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698329890; x=1698934690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SbfnZ/Wpkkk2artvNcd4NtWt6B3nSe16B0gl1uHq8cM=;
 b=EK6opnJR+kIAjiUbkpx0TzrQWfZJcBsAFkQ6enQBwAYUgNl2G3Jl9IeVciOOlzJDz4
 jksPMSoQSf1p4o4lQzA3w9Sfn/jJj/UF5Rgy6GkydEC/CeaHgy0mLFHxJ3vM9QBpeI8C
 K3/5h5ansROeMTqBZWNdM+rZgUNGI6AxuEAxCduYeW8mZ5W03VEz5B8TEAUtfh3CPJWg
 Jn/SJO9OISB0n4QP+aTwiAD5XHdZaYb4Lk1iF/vTnV3dlc4d0TUcWaRPzm7z6HfJLEUi
 42Usp2hUmGE625DO5QqHLmb40K+rD/2iWui0/NYN72LWhIq1XZNydGsXrK/7rqQxStiW
 XVAQ==
X-Gm-Message-State: AOJu0YzvsOW55QM5glOMgQVt3EDi+qFilkm4bGh146MtQmlLce41/IEg
 U6cWPAuQg9kCpU3FA371KjvDGzCwyOw94+HPYlf0h0yr
X-Google-Smtp-Source: AGHT+IGf93ByS3l7+RpHec8GExCjJdGnQ39rPLECqF069tx29N51AE/7K+zTUb/yfa02wU9lnyXTsNiTgdW4wU/8cZ8=
X-Received: by 2002:a17:90b:4d83:b0:27c:fbf8:6c43 with SMTP id
 oj3-20020a17090b4d8300b0027cfbf86c43mr21108564pjb.1.1698329889826; Thu, 26
 Oct 2023 07:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-2-marcel@ziswiler.com>
In-Reply-To: <20231026073220.244387-2-marcel@ziswiler.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Oct 2023 11:17:58 -0300
Message-ID: <CAOMZO5AKu48fsRNvhyAsb2azoQ6XUbyc_YH9kTxw4J+Ecf2wRg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] imx: spl_imx_romapi: fix comment about stream(usb)
 download failure
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic <sbabic@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>
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

On Thu, Oct 26, 2023 at 4:32=E2=80=AFAM Marcel Ziswiler <marcel@ziswiler.co=
m> wrote:
>
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Fix comment about Stream(USB) download failure.
>
> Fixes: 1cbebc786276 ("imx: add rom api support")
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
