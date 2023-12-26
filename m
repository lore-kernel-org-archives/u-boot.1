Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8ED1C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0ADA878EC;
	Tue, 26 Dec 2023 10:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kootgyY9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2B38781A; Tue, 26 Dec 2023 10:47:24 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3940878D1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-59489ce4ce6so346312eaf.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584041; x=1704188841; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUIj73R7UhP+KHTReV8n6wbl+RdEN7308/kILeVxqZg=;
 b=kootgyY9j14yWUHaj0wSjuKcEsJeTLMEeGQEnf4M7W6w7uik5qz1m/T3pOOIwAYUmi
 61iUvI1dN4fgl5hF40t8Jr9IMkcCEzuids2Oj/ls6rBWpjYG8lkVhBRdGetUGvgCRCie
 UGt/2YhCtyJNs/Kaoq9+AprZJDNZUTO9/VhOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584041; x=1704188841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUIj73R7UhP+KHTReV8n6wbl+RdEN7308/kILeVxqZg=;
 b=mHeO74d/m+lfutfepY+KWjT3Yznm19Y1k6Ei8LrpBb2heVrBsOhLLMNeNlkfqAPM1A
 2fZ2EsHKCD8ox9Rf3cAdjKko66/l0vazx8+IijJjakMEQaTMffeCehsDxFqX1Ff5DKrV
 E6pCkuTl6X028Pez/78nfrsljV1lTJaCW5nm0iU5F+n/3cJkWOPD2UHFvOdeo6tmkgIH
 Sx+FzPN3nzLFk+h3SnO0Rbq0FVMGljngT7fNqEXlT2O8KynKPti4lvwdYmvO6zRM9twh
 3R4KhneLMfzfg7zRi90aUPK4I15CKDpv4Jh7XrpS9ZfB3Dt+R7yuD8OfXGZqw9DB20hj
 VAwA==
X-Gm-Message-State: AOJu0YzS2kCYZ+UXgWIK6kTI4kImpp7T4AQn0cI2/tEJQlCxZiKHhZLe
 tfmrdEqbnL1u+GDMEI90WyCOp0TGEPSrYHgeluMyoGP8UixI3Omd62U8ctIR0g==
X-Google-Smtp-Source: AGHT+IE187MwuIB3zMQFrcmkEw1AjjrKbN2Z87P6f0Ud3yAIy/zzHMneSIPhPkOYzNGAPCoR8eduda8M/abzAf8yCbQ=
X-Received: by 2002:a05:6358:63a7:b0:175:42:e60b with SMTP id
 k39-20020a05635863a700b001750042e60bmr121778rwh.5.1703584041387; Tue, 26 Dec
 2023 01:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20231222181250.49764-1-xypron.glpk@gmx.de>
In-Reply-To: <20231222181250.49764-1-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:04 +0000
Message-ID: <CAFLszTj9rqEr721m+HZgqzFJM=6+t_RMGsj+-X9eJHGCb30cxA@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: smbios: verify_checksum() is duplicate
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Christian Gmeiner <christian.gmeiner@gmail.com>
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

On Fri, Dec 22, 2023 at 6:13=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> The function verify_checksum() duplicates what table_compute_checksum()
> does. Replace it.
>
> Fixes: 415eab0655a8 ("smbios: add parsing API")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  lib/smbios-parser.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

It would be worth mentioning that that function is always including in
the build,
