Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9133AC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 13:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D1F88A25;
	Wed, 31 Jul 2024 15:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ATwYT8vg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36E23889D2; Wed, 31 Jul 2024 15:36:23 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9590888A25
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 15:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ef298ff716so10314181fa.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722432979; x=1723037779; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rM2KLqyY+URfccRmKEIc+NTFpxl81TVKg5xW1rfGSRw=;
 b=ATwYT8vgGeA9UZedgEAyg+7IkowelEzRAJbzBYKOx0MGnqU7PQpndKAYsZaI+a4cBW
 DNzikQhJhS6p4RjMKRMwfv6LudUrMvhP3nEJLSWGnQChPd7GBaYdtI/IKCzH45Z9QXxu
 MM2W+FfSyme60cezZ6N8g75E/kWAefV9GCxaSlMGLyg1BG84ouM68B7yIh6ThzJvtY8O
 rQyphG4gWpVnAxuNnIG6pIsbt8oaHhQWfHlXOKdmuxSGnUYWI/MHMZVvR8dDN3MXnGD2
 B3DdfGGnSei9mlHacYM4xHIAjkkstjw0lXxCM/q3tM4bBTdcU+574hDSZ0lY4I7SBGLl
 YxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722432979; x=1723037779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rM2KLqyY+URfccRmKEIc+NTFpxl81TVKg5xW1rfGSRw=;
 b=AnH1qVnE0Vng+hSgrM9U0U+a2mi037XaIFsJr56zEfvB39kDM5AM0ooExPUlD43TCw
 ottlWA+rk59ErGhNymG4XNcuKHSdn0Of0po/NrSVyetlrBAUKLGwihfKNtc4NhBZEg96
 UoNjiqhPg+5XnvPo2mhP5JdYm+EoByNhNQgqpLS1Yh/hRh/fmsy4GSlqNiSo/Mi3MxXV
 2xg+UYjdbGL3tHAd3M3cMUaYR2zpkrwc/qM3e6tz2cukRDZMLlkHo0oLCqR/II5x5u7l
 BqTBScuz4+1+6bgVABCg2T1XQizxNRAerFkKv1miUfE4Rj/qZytfPeGJ+QvnfPf7hnEf
 tHgQ==
X-Gm-Message-State: AOJu0YxLYrOz14DYIKTsNhtczoZhlVP9Glx6tY5KYlWNrDh0CjznCTY8
 TXmZVx3hXsM6TZLuO+8f9lipwXJLc374LA1byOKHCdKFMZHE8P4M37gc4DaoP/ctEXUPxfA7W5P
 sx8lyJAnCn8I0aYd/WSrZ3n343pU=
X-Google-Smtp-Source: AGHT+IFdPBLhfZnd4zUxsd/BWIs4yqW8FtKtYy40h+KJa4oJJZU+oMu/7RdutmdFp/5lPl5xWdQW07d7ornQY6Qczpk=
X-Received: by 2002:a05:6512:3b84:b0:52e:9beb:bc09 with SMTP id
 2adb3069b0e04-52fd5275421mr7933447e87.3.1722432978302; Wed, 31 Jul 2024
 06:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-12-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240730073003.28892-12-Zhiqiang.Hou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 31 Jul 2024 10:36:07 -0300
Message-ID: <CAOMZO5Du4Ty8rka9g+RJ-TE+33YrKdeQGMgP98eTvB0UJfMv=g@mail.gmail.com>
Subject: Re: [PATCHv4 11/14] doc: cmd: add documentation for cpu command
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 sjg@chromium.org, marex@denx.de, lukma@denx.de, seanga2@gmail.com, 
 xypron.glpk@gmx.de
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

Hi Zhiqiang,

On Tue, Jul 30, 2024 at 4:09=E2=80=AFAM Zhiqiang Hou <Zhiqiang.Hou@nxp.com>=
 wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add documentation for the 'cpu' command, taking NXP i.MX 8M Plus
> as a example.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V4:
>  - Added brief descriptions for each subcommand..

This gives the following error:

Warning, treated as error:
/builds/u-boot/custodians/u-boot-imx/doc/usage/cmd/cpu.rst:document
isn't included in any toctree
make[1]: *** [doc/Makefile:70: htmldocs] Error

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/878784

Please fix it, run 'make htmldocs' and submit a v5.

Thanks
