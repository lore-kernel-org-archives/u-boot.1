Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F004CD1288
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 01:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4DD188349;
	Tue,  2 Apr 2024 03:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ausil.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="lce4Euvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BA788339; Tue,  2 Apr 2024 03:46:10 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7277C88351
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 03:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ausil.us
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dennis@gilmore.net.au
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-415db53d905so2042815e9.2
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 18:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1712022367; x=1712627167; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LG9IxxF6nmk+PPWhk32BhaaVHx9p0XSDMpLGDpL9tu8=;
 b=lce4Euvfy2XWTWqfEtc6QPnQ5Vxb1FEWxPhrVs2OMpb+4IgakHGoj5TRxkuQflKcEf
 roTOxTbBVEaP7BjV01saNCbfaaa/tAFt62ITcNNoBWS3XXq98hTrQElRkh6BoIZkdfZH
 A9VA4e+YSeX6oC26tqNuQuGU18wPNdRWOMe8M+6/Psx9UmGIbCv+RcZfNuXCQg8Td8iH
 fmRobQaLlI64KCMhT1zNZCRm/FGm0qCGVIJOeI5v8JT4ovTzZTHhmXWWYzjqx6aB+brs
 QWws8iKxXfeCE6iUGntpOymrOyxgfMI3TD7EeNlRqH5orlZsUD0/95tYneSg/YbdN6ah
 ZG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712022367; x=1712627167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LG9IxxF6nmk+PPWhk32BhaaVHx9p0XSDMpLGDpL9tu8=;
 b=kULQwp7nlQ3C+sgWjV8FTnT/Tr4Iw92LUhMV4QDnCM6vCPnIWkCRKS9yYQ5Xg7Q4yh
 rbNzPC1GOceHS18Sv4BfhoVAqw22z+5apsRr7Q7lw5XkfZ79AYpG+t6hSWRHe3fyQM+j
 lZ5xQUmaJXR8OrvsjXabEVEtVRf8DxipdzcuBxJPOU8mAsSq5h0OlmAbC9D+oocFIiK3
 5/vidXQN9XGqn/F5fKiYh7PirUk7Zwyi0kU06SE+b29YEMnepFdmtZkLYfy/blGal7eO
 eNd3Vc5rSzX0FUiFNjtErWbbs7NVFQyqGC50MC0jIk3t+n4d7x9yoVqqSkUJULT8ckc3
 6vdQ==
X-Gm-Message-State: AOJu0YwlPkWelhqZ4oagvtRmK16HQQSN+H8WYwuzZpgss//0HMuWCY6p
 p81UehCS4aycWqOmfc1Pe46EmxiN2L6/FI83qjX7V+7DhPEBRmonRVv1DgwPQXei46A2B+iwaS1
 g9ppVS/AfaNsj2vcvHyKgqSHAbFQ2sG+sV4zDZxKb/u4LeooL6RKOyw==
X-Google-Smtp-Source: AGHT+IG6Oyz0il4zMFtEzZz5SRTdQQVp3BuX9AAsK1VhPUnWsyS2T0PU9XhDHHLIoumYpH6bQ41mAzKejebqbxQi69I=
X-Received: by 2002:a05:600c:1d24:b0:415:6863:960b with SMTP id
 l36-20020a05600c1d2400b004156863960bmr2200859wms.25.1712022367041; Mon, 01
 Apr 2024 18:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240402014035.8169-1-dennis@ausil.us>
In-Reply-To: <20240402014035.8169-1-dennis@ausil.us>
From: Dennis Gilmore <dennis@ausil.us>
Date: Mon, 1 Apr 2024 20:45:55 -0500
Message-ID: <CAABkxwtnFoC=XBfiH+xX7q5=fkFouadpymFV7TeUKmemL9by8Q@mail.gmail.com>
Subject: Re: [PATCH] mvebu: Enable preboot start for pci/usb/scsi/nvme
To: u-boot@lists.denx.de
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Does anyone have an alternate email for Konstantin Porotchkin? he is
listed as the maintainer for theESPRESSOBin BOARD. and his email is
bouncing because his inbox is full.

Dennis

On Mon, Apr 1, 2024 at 8:40=E2=80=AFPM Dennis Gilmore <dennis@ausil.us> wro=
te:
>
> While preboot was enabled, it did not work as commands are needed to be
> run to enable some of the subsystems. This patch starts pci, USB, Sata,
> and nvme and makes sure that the system will boot no mater what storage
> is in use.
>
> Applogies for resending, I accidently left the u-boot list off
>
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> ---
>  configs/mvebu_espressobin-88f3720_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_=
espressobin-88f3720_defconfig
> index 7ecf5ab0d64..fause his inbox is full4f7a809609 100644
> --- a/configs/mvebu_espressobin-88f3720_defconfig
> +++ b/configs/mvebu_espressobin-88f3720_defconfig
> @@ -21,6 +21,7 @@ CONFIG_AHCI=3Dy
>  CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_OF_BOARD_SETUP=3Dy
>  CONFIG_USE_PREBOOT=3Dy
> +CONFIG_PREBOOT=3D"pci enum; usb start; nvme scan; scsi scan;"
>  CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_DISPLAY_BOARDINFO is not set
> --
> 2.44.0
>
