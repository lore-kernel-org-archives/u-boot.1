Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96405C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E41E587872;
	Tue, 26 Dec 2023 10:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mgDfTfUE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FEDF871C0; Tue, 26 Dec 2023 10:51:03 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C5F87910
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3bbb9f39e30so178781b6e.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584259; x=1704189059; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWUfRFFMczJ5a8rHcVeB61l3/Lw5RHSKkpPpNfQwo7s=;
 b=mgDfTfUEKc2WdFv478fjLUg8QQAOxXJcDlSxRQIrGscHe66pci5jm90sKf76MrgSL7
 l9KT39+ZkWw5FS7vrA4jk8vhtMZOriJiDQRav1GrV+BxFBJpx7RIUquusLhr4MLo/tfF
 L2A6EvDq2aMBkCmdwXjldQot4L8f5zfkkSqpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584259; x=1704189059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWUfRFFMczJ5a8rHcVeB61l3/Lw5RHSKkpPpNfQwo7s=;
 b=o7s2LKQTU1d3ZCWjcoiO/0KO8J3QsKUUYfY2E1apferPA1BybC7Fe8wqY0bABVG/az
 gINQdYQonRW2vIuKevO2wh/iMlOE1KYR5qKjK7XX3tf75TgfECZzIEuI2/+0u1ryEt/d
 Vyg/N0noS/J2SeeYLCpM8pcSrXafkWJ6vD/yD7jp7ArZVSoVMG1iKacRLdltdAg3jqbT
 wwrvmCquEnpdWDusUXTzCrfVYIQZQKJKIL02ibpjJk3n9TEG80/QBxpeFJhjBZO0YrQQ
 UNENMh9icQAY9iKdGtoIjF3SpAIbkPUWrW0eA2Jvm92him/aiMn6qdACdVEP9aXG+XwQ
 iYoA==
X-Gm-Message-State: AOJu0YzL/kkUEhpetBcA1mGhQ4Mq1tdJYXIPrM+4nRhmD8grbEB00836
 mGR+57Q0SDoAQHhJE0fYk/qGpNd/kHmTmmYy5k2iHo6HZ7mgy3nAZKaFvB9yEg==
X-Google-Smtp-Source: AGHT+IG6Gp48/7i9qqdeWs2FPjObBRnA8loyJm5W1fQwCHm2Eih4aysJOcuena6He2sWWpgLpsabNqRMwTP/X7B+I1s=
X-Received: by 2002:a05:6808:3195:b0:3bb:9928:d9bb with SMTP id
 cd21-20020a056808319500b003bb9928d9bbmr5105566oib.38.1703584259752; Tue, 26
 Dec 2023 01:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20231222175403.46629-1-xypron.glpk@gmx.de>
In-Reply-To: <20231222175403.46629-1-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:47 +0000
Message-ID: <CAFLszTgXZwBsFUbJBn9+PbFo+H-kip0pe=xc0073xUhptnuHBQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: smbios: remove redundant next_header()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de
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

On Fri, Dec 22, 2023 at 5:59=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> next_header() and get_next_header() only differ in how the const attribut=
e
> is used. One function taking a const parameter and returning a non-const =
is
> good enough.
>
> Fixes: 3d49ee8510d3 ("efi_loader: add SMBIOS table measurement")

Yes, please drop that

> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  lib/smbios-parser.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
