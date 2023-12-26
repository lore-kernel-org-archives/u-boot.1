Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FCFC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3711387969;
	Tue, 26 Dec 2023 10:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bTQEji6A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D25187951; Tue, 26 Dec 2023 10:50:32 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D1D1878D1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-59496704246so563105eaf.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584228; x=1704189028; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWlg+YhpZUC5XcfjrvoxBuUlV9fRkynMRceBtwUcaPI=;
 b=bTQEji6AWM56IR8GJqBP2S8XmRNaYtHQBKATRRSV2ABOoA+4p8ACB8W7H9AP1DZwfB
 8xWHFEoR/at1pueujLg7SI68TSKhNVxHL7a5u4pabHaTnEO4L8IPahCBTTDubHQR0jUg
 mbrDcLWZyEqtRZjpdWvkh7nHyNZgFHrdD3VjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584228; x=1704189028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sWlg+YhpZUC5XcfjrvoxBuUlV9fRkynMRceBtwUcaPI=;
 b=mx4tEbUSdNdq2zv2TeCFYI232rilfQukk54kEeK9vtyCrF6vjpup+n0saUmAHGNuOl
 gGJhRUiZ4m6OAmKTyR7uujaLwQmVlGV/Bz67nEx8dv/u7EYMn1NDrmvYijrOb3FPiyZ6
 eZYE2xY1v1+72mqVUG3C2au2oexAfaoynxRlWvNd7TNe1wuFd/gomnyL6HTXVnWIdhAp
 aTs/hZ0c/K5RZqL3+gzzDrzUVnNUFsjddhP8ChBJD2Ijf+XfUQHbBUUmnErmTg9vEaPb
 akJ6YrAp+ubOOiq7si03/Flu7+sRH/DRuer/JoqcDLHpqZOCWNc2t6s+84rEeJnordUL
 odWw==
X-Gm-Message-State: AOJu0Ywy76C53SiL+gR6IOzOEe2QTIUvWOCBl2gvRDX7bHcFOo5OJ0Kx
 X5XEBEbXo+2jC+5+ymEDnIZllc6TlRj+crnx7USQemx12knj
X-Google-Smtp-Source: AGHT+IHi5ivS4eoTywQQDSbzy63nGpgpXZ03uLbQlV8Q9p8DwyqcABn+kVW/enS5Fh1MbkqiazHtAfB1ZsaJ4disD5M=
X-Received: by 2002:a05:6358:7250:b0:172:d2ac:1e with SMTP id
 i16-20020a056358725000b00172d2ac001emr4741529rwa.5.1703584227865; Tue, 26 Dec
 2023 01:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-4-maxim.uvarov@linaro.org>
In-Reply-To: <20231225153929.8284-4-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:12 +0000
Message-ID: <CAFLszTi6SE6j29wSeLKTUMYVix9Ch641mM7f5xMwHYq4N2jpyw@mail.gmail.com>
Subject: Re: [PATHv2 3/9] net/smc911x: fix return from smc911x_send
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com, 
 trini@konsulko.com
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

On Mon, Dec 25, 2023 at 3:41=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:
>
> return value of smc911x_send is ignored, but on sucesseful
> send we need return 0 and or error -ETIMEOUT, not opposite.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>  drivers/net/smc911x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
