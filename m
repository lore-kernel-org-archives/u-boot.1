Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01302C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB03487604;
	Thu, 26 Oct 2023 16:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dz/4nYWQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94CB387604; Thu, 26 Oct 2023 16:25:37 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15DC875DE
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6bbfb8f7ac4so222030b3a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698330331; x=1698935131; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dmqh7kG42TnKIUm0yWGuTF1LJRnkWCLP9Z7tXCyc/1c=;
 b=Dz/4nYWQ0Rm6A/Ukoypj0IH/HTfLt/ud8bKlwQhhRJFI0HH4SCY/WYqUgtHRLwBt4+
 mUOFvIc8i9UrJOfJg5se0+RPI2MYTKdMOGxKnIbCSFX3fSG9uHLZS9CbdHDOx5ID4zIy
 NlsweF8kDHIKN2fOcI/0Pijfsd4Rx7BGCc0fj/JcWKkVS4siZ4o0ZzNexGJq45RInKsC
 mWb1jvkOW90ro76JfSUOTkhODjMUofddczHvfzXauLweXN5ZFXSvm5Onnq4C7gXkFCaV
 U+ssKuAcA93MA5njNpSc0Ki2Y5KYSmvnpUE6Q067DpP1OMKeQOhC4Y18uEIAEOuFi4uC
 DvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698330331; x=1698935131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dmqh7kG42TnKIUm0yWGuTF1LJRnkWCLP9Z7tXCyc/1c=;
 b=ZQFDAVmvGtmmBPWrHQfTK2lb8SK9faQ3vdaZcLOotFDhzWIFaLy472ogmBsVDCd+cc
 8N70dMviBLIGVXYgZMOOcsHUXZEppzdEb+fLiQFR92WkTCFZ0yxWXWlyTL5jFu7PW2Xx
 9xYbQ7JtK19/kkybNPXxkWwPpWCGDHDTvu91iqQQ6Su/YTNru8VE7csd1LMdfITTNgeS
 MuAz/TJrRXk6fc4ZMyMmhCHf6aiJwxPctAY+OokQEGje70fHGSeYtlpvW29wVLbYufnd
 wS/u4QCYs89oM/8go7lABTsw8RJu+W3bCG57PgCIXthH2WwdisfWCLUuDLdkSVR7DVqg
 9Efw==
X-Gm-Message-State: AOJu0YxRSum6bOwhsHc3yBMpdrDndgm7q9KRB1LdB/FLz53MXwW+ZEM4
 K0ipAJUjhXsY3V4hc5yOf3wW4nci1MefBrX4NZekDl71BEo=
X-Google-Smtp-Source: AGHT+IFVuaWsSmaLLdmjl/RTzOmJczu1xJjD2HQc19FdRFXc5P/nO8+Arvoun2qV50izO0nXwCMh70ovVzvZa1KhnL8=
X-Received: by 2002:a05:6a00:2c8e:b0:6bc:67ca:671d with SMTP id
 ef14-20020a056a002c8e00b006bc67ca671dmr18209324pfb.1.1698330331053; Thu, 26
 Oct 2023 07:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231023152629.2727547-1-hugo@hugovil.com>
In-Reply-To: <20231023152629.2727547-1-hugo@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Oct 2023 11:25:19 -0300
Message-ID: <CAOMZO5DyK+PDgk=2cOsQogVb+vCP=WhyR3MK8isYtm_KoAbESQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove non-working address from MAINTAINERS
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
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

On Mon, Oct 23, 2023 at 1:45=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The Subject does indicate which board it refers to.

It would be better to have it like:

imx8mn_smm_s2: Remove non-working address from MAINTAINERS

Reviewed-by: Fabio Estevam <festevam@gmail.com>
