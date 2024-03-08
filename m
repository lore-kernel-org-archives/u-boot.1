Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1FFC54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F10687EDD;
	Fri,  8 Mar 2024 18:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="buEU/Cz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8268F87D60; Fri,  8 Mar 2024 18:51:04 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 337A387EDD
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dc238cb1b17so1230375276.0
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 09:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709920261; x=1710525061; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0EdmKnK2Sqr6BovgTpgRe9cVYCzfGDIK5+klbiNTtgY=;
 b=buEU/Cz50WWMTNRkAeCGxf5QzlGNxbDtfjDY0uHRrKSWqfyF0gzVifeebJUlCzidWU
 FHhuhXyyZd+DSQJULvNZBpCs20InFqbUJMpo6it1tPB+BBY4hKxs3bzLNkE5tnTJ3PLG
 JMmjU8rVjcfN7Bn4W/R6JybnG6cA45OkSXqidUi99sCXZIAST6EwJV5KBLcfgbBDMI4s
 yvQl2EutBRJcFt+ifbkxyRzahUp8Hbj8KFXbLU4jt7/8UfK5qf+7TVwV3MPp9fggJBpd
 Fyf+cIYqEV+vVyGl9Vnyl1dtPctsHHc5uNVwYZkt3nwGJcB5pciRkng1rKKiufFACjqc
 jdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709920261; x=1710525061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0EdmKnK2Sqr6BovgTpgRe9cVYCzfGDIK5+klbiNTtgY=;
 b=QvqSn2Zu0oUPDE+FS6NKM3jKiyZu86InqL+PGl4RrtBkk842I4l6/AL60ebrBmCLCh
 U4utHc6No5TpXhm1BddMtn9AD2e2waoRUgRmwMfV1QGMAD/UUqfG23Nxm/BOV4/RsvDH
 YFZPWoH49aQXqDPqLsehiUSXbRFqP32jYDk2sgbawxm4hCmWlnH1rIkUs7Aod0CDjBcF
 ePKBzBaeRfwafTSbtfst0zQHaU0lfBAXrrl0Vm3BNRVJTX/ADRFMaP4hCU3a8XkcIa42
 xsNljXzt4BskwrHOMZdqhbKMv/PGmKRDwSe1+Z1IVwh6T/adgGcqWaN2nSPgcvFztCY3
 kz/g==
X-Gm-Message-State: AOJu0Yyv/XtiIi14Cy2tQzq0AJvijTW/zNX3pjq0srgMPr5jdY3qk7HW
 oVRv4oXqF/CjAXH1dUfaCZduJKqOaHhKqkFeRGC+trkngI1oS7asFe6anYNDogz0ah2RnaI/1Gl
 dG88iXh4mjDCqcrIvvuIE6ImDPXvAnc6SpHqUiA==
X-Google-Smtp-Source: AGHT+IGkSWV6FVxnVOUxnXwy9n6KwbtdzGu4inggRIHjZJgjm20nUp1iy1lCDSrtaWD+WchvNIZH93q4wPQhL8sS6ME=
X-Received: by 2002:a05:6902:34c:b0:dcc:2f94:591a with SMTP id
 e12-20020a056902034c00b00dcc2f94591amr18091304ybs.12.1709920260928; Fri, 08
 Mar 2024 09:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240308165937.270499-1-colin.mcallister@garmin.com>
 <20240308165937.270499-3-colin.mcallister@garmin.com>
In-Reply-To: <20240308165937.270499-3-colin.mcallister@garmin.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 8 Mar 2024 11:50:50 -0600
Message-ID: <CAPLW+4kG7yc2xG4VCLPapsP=cD4QcBQEV=bsPG3zYkwjRJeFzg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
To: Colin McAllister <colin.mcallister@garmin.com>
Cc: u-boot@lists.denx.de, JPEWhacker@gmail.com, sjg@chromium.org, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>
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

On Fri, Mar 8, 2024 at 11:00=E2=80=AFAM Colin McAllister
<colin.mcallister@garmin.com> wrote:
>
> Currently, setting CONFIG_AB_BACKUP_OFFSET in a target's defconfig will
> not actually enable the #if protected code in android_ab.c. This is
> because "CONFIG_" should have been prepended to the config macro, or the
> macros defined in kconfig.h could have been used.
>
> The code included by ANDROID_AB_BACKUP_OFFSET has been refactored to no
> longer be conditionally compiled by preprocessor conditionals and
> instead use C conditionals. This better aligns with the Linux kernel
> style guide.
>
> Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
> Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> v2:
>   - Replaced #if conditionals with C if conditionals
>   - Opted to use CONFIG_ANDROID_AB_BACKUP_OFFSET directly instead of
>     macros in kconfig.h as CONFIG_ANDROID_AB_BACKUP_OFFSET is not a
>         boolean or tristate value and doesn't have different values when
>         building SPL or TPL.
> v3:
>   - Added "Fixes:" tag

Can you please also address my comment about CONFIG_IS_ENABLED() in
the previous mail? It might be just an answer if you think there are
no issues with that, not necessarily v4.

[snip]
