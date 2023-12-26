Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A5BC47072
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0FE6878A5;
	Tue, 26 Dec 2023 10:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EM+IPh31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DFC28787E; Tue, 26 Dec 2023 10:47:05 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94E8287895
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67f5c0be04cso41073786d6.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584021; x=1704188821; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpfkBOyaHVntFbelvN7Hx1OAhGT5ZwJimPxvPfpcZmI=;
 b=EM+IPh31oD7f1bL2xImbBP+5Vdur6ym4PEQ4QrRMWyUMbuW4QzAmPkZpJdwl9zvtD7
 LNdo4wELiRuBGzNiORLxjFlas2ZiZe0fHKztA5j4QLlfyWoV2Cn4wbdmwBVAGyBhVFoC
 G7JArgtvzrffHPZOAgFfIflmpF1bU7I9RfnOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584021; x=1704188821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bpfkBOyaHVntFbelvN7Hx1OAhGT5ZwJimPxvPfpcZmI=;
 b=izdT4JPhTRtrWrpvusY1p68w+prM8Lj72jLTpLhMfUfbNEXp4pORR9o8vQ4YW8Gbgg
 rUT/3CZMCOEGtTSO0ZDxZrD0sjnU7NgPP7XDOoR370how3lTxzUhpAEFxky1NygDy/vz
 PGxa+CCGSLjMWLE4ufUoOGIAwinaQ6TeuoLE0m3GST7xm86lWxNU2MIzAZFwMldqO4JP
 YLtrGOEiSf9HgoSwVxwFD5IaihdKyFHfDmRSDj/oEO6wxtJGP26bzOUoeKxofGLu6aUW
 v3AsysVO+UFsN4CSPDrDiaHMMj3KFgZconhDUtJlBLt60DnglXDjegLXB7C47dUNNn4l
 t6Lg==
X-Gm-Message-State: AOJu0YxE8wbxO8UYxllPFuSeU0Tp4L4D/22max03f42JUkLVIRefgrHa
 PUOHfiHfWFhxHMX3W6SOabtQU9I3Y2aDk+gjSc68jfRkyc2k
X-Google-Smtp-Source: AGHT+IGJQFvVqpoqhwHqpGTyAtjPTfHj+DOgtx3bD0BCDT6/MUqpWVblS96BpGJwv5WUHDSnCQQSZSB88iCzXB6oreI=
X-Received: by 2002:a0c:bec7:0:b0:67f:c73d:f6e0 with SMTP id
 f7-20020a0cbec7000000b0067fc73df6e0mr6036478qvj.32.1703584021315; Tue, 26 Dec
 2023 01:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20231224181255.4954-1-kettenis@openbsd.org>
In-Reply-To: <20231224181255.4954-1-kettenis@openbsd.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:46:50 +0000
Message-ID: <CAFLszTjdAVCUcneofANpjj_hVx7Qg_fS5akTkXxjik_V-ttRVw@mail.gmail.com>
Subject: Re: [PATCH] arm: apple: Disable SMBIOS again
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com, trini@konsulko.com, 
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

On Sun, Dec 24, 2023 at 6:12=E2=80=AFPM Mark Kettenis <kettenis@openbsd.org=
> wrote:
>
> Apple machines do not have memory below 4G.  Since U-Boot does
> not support the SMBIOS 3 header structures this means we can't
> support SMBIOS on these machines.  Unfortunately the refactoring
> of the SMBIOS code this cycle accidentally enabled it again.
>
> Fixes: 53fab13a7b1 ("efi: Use the installed SMBIOS tables")
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  configs/apple_m1_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
