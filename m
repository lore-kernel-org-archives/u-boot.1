Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827DDC2BD09
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 20:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 876AA88249;
	Sat,  6 Jul 2024 22:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NOuDeRJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD44288249; Sat,  6 Jul 2024 22:47:11 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D045D881AD
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 22:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52e9901f858so298160e87.1
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720298829; x=1720903629; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KaaQD4QEIicZx7wKJZwSFoqZ11Egz6vFM/XVcM3IPhE=;
 b=NOuDeRJS+CDRrYUMdkzaJxsfkivFQld6iIpz5T9J7+GdVYVsEK/d2M+2chngD5OlYN
 Ffweo2Mms05SAE+MZcUygggn1ZWwgKQXosSOu3MT4A/WXpq+E9pxW/I1FO0pdnDoQcXG
 AK+v/5NM5usUw95HzVacBK4b066fuqbtNZ+CCIQBYrUNwjjgA9hQWcFW0HCRTteoSCG1
 Sz//cor/ZZMguT79s8AmVlg6PyJJssfTWcN72cDqJrpbtdJcKDrpjuIFD6zdHtfbEWvW
 dfqkj8cgFw8JGPie4YyMDdPFya6mmZ82/0UyH8g9EyHn/rAHn2d9bncI8VFTsYcyjr+f
 WbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720298829; x=1720903629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KaaQD4QEIicZx7wKJZwSFoqZ11Egz6vFM/XVcM3IPhE=;
 b=XrYX0zTXRw3dtK9wnKE/rRmtVohuZUYTXW11XxzDjsw6YbPkL+gdHvfGKJhXkv6WG9
 4s65E8eUcgzOqOS1ba1/yXjZs1T2OwqMDaKwmM8g28IQkD9f5Q9FCdVswE8J6WYJl/jv
 ejEzsl3DKxAizIUoGEKCXv3YvkL/LYjaoiPr5vTICqQo55Qx2Pckcl/w3D9orpXIXFYF
 56e69r2Zu50RUksPZZrAX/YeH9NCS2Wj9kk87jrwfEANuAmLsPRZNe2Ad1XQECuL7NL5
 DgcnitDA/SeJBnouh2xmf739z92C6fR5PZOkR46bsAN6RRUMj1b3Kj+FeoT1vUzP7Q8+
 EPcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm1qUrwDfBGP6QsVCfSvRoeV74BHQSxJqst2fXFZESzLiKo+ImVzhcgECQUuqFwMV+5GifY0uucItOZtv1qndpd6lLXQ==
X-Gm-Message-State: AOJu0YxCuF0Xtxfi8gM7yGTSXXhAkPMelliMYBTboUH+zhwAt+6L8vBe
 d0ik4X2o+jRNjOvHeEQQ1VlYt6kPWIWVQmqBv8l/KpBlSedCQr+ccdeSHXDqpKCEYL7FKMZw9kw
 nSHkYQ6UE46Zssg+jsqbJ8IEyERA=
X-Google-Smtp-Source: AGHT+IG/YeBoaKbZ1YQYNS/Ug2aMZ+jNqIsmvmeIYsoavCaH/zbVAtgpb2LhWzTRRt6zySHNKCF8KScKiQOF0cQiato=
X-Received: by 2002:ac2:4115:0:b0:52c:a657:7e85 with SMTP id
 2adb3069b0e04-52ea0706237mr4683587e87.3.1720298828892; Sat, 06 Jul 2024
 13:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240705132724.2865958-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240705132724.2865958-1-alexander.stein@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Jul 2024 17:46:57 -0300
Message-ID: <CAOMZO5Dn48ChZp2vm8rpcYfPxQzBujW3nykq4TooVGVK+nxOig@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: fsl_esdhc_imx: Fix error message
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Fri, Jul 5, 2024 at 11:26=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Add missing newline character and also add the return code of
> regulator_set_value() to the output.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks.
