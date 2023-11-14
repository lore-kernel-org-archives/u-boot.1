Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19DBC4167B
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 10:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599D887440;
	Tue, 14 Nov 2023 11:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MXONHSGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A57F87440; Tue, 14 Nov 2023 11:42:09 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BAE28723C
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 11:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6cd0963c61cso2940781a34.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 02:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699958522; x=1700563322; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OCSjsHUJorcx69wAOiGNh3xQCDDPHfbdzn/G+tZZCKw=;
 b=MXONHSGenOpGwyOWwNLWFtK01NJbqEEFaHKURFM4BDXXxpcLIdFl70ornUFKA875I/
 R4K6swGU+/9DIazjwot5LzzEZvxfhSXg+usBPN39YLW8JTB9IKlG3V67CbOsdmgrEBHv
 IsQScgnYXraAeHoDZimnXpuzbE4NwfJJX7w2AnW5+xoGUwWwf9QHC7mkZgmMOGd4vF8q
 fO6H1rE0WmpahqOEA3PbUm3dOLpXPQtlBsvtxOksyJIBxxGgtEYyoll5eDFMQR63Z2x/
 egqTtMqjNdacFu7TcdwWjOU6jNyJ1hLb7V4FHD3LW+iNbexdYsPe1nt+2HJXNh4Ig7jX
 xT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699958522; x=1700563322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OCSjsHUJorcx69wAOiGNh3xQCDDPHfbdzn/G+tZZCKw=;
 b=kHfLuhAeM7PvTTU+ZLfytfqgoIAOldPa5yQozcYZ/dUnQRVAkW6q7sDMA4WV7StO7n
 dCAOlMEdctuVSCVpfnxAp5cVOj5+UDg0bQfqyeAQPlzzYxm8V29FRhfeNU2AlgFYg92r
 JXNNofVWEBjVP5feG6jSuqMVH/bD0Cpg6RCxEMnAIeIDhbVelrZYh24VzoYkgkXv1xOd
 TQZ1GJVlSTWEzZzxSr85Wpb+2gqzB5XCzCDu3VmfW1oKmf/Dkovj0XWknRl+LwJTUjTl
 k8dSf3ulXAy2Cjv+MF4Dq1dNIVy3CuZ0UKKz/DmPqOYtZvycZAIXoSXAKKzENXZaeqiT
 LHgg==
X-Gm-Message-State: AOJu0YyRStF1339S3Ez4LSw/v7nlwPKVHh0mKfLVE8ku5HSbeapFlHgp
 eoykJQ3j4eDmGIa3903nD/i1cuHrWy89mqDeKgw=
X-Google-Smtp-Source: AGHT+IEWLhHn8PAIbNyph52fs1naKQKw+C6Rdmr/Q8gzGlaNL74BWEP3uPo2RxgJ5cFF+/+2d7uqZdodMrrtBbkqBKc=
X-Received: by 2002:a05:6830:12c1:b0:6d6:4ebf:1557 with SMTP id
 a1-20020a05683012c100b006d64ebf1557mr2022590otq.21.1699958522554; Tue, 14 Nov
 2023 02:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20231030165502.27813-1-semen.protsenko@linaro.org>
 <20231030172550.GV496310@bill-the-cat>
In-Reply-To: <20231030172550.GV496310@bill-the-cat>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 14 Nov 2023 19:41:51 +0900
Message-ID: <CALrBrZ03==vjnkYyW-jnkdTu7kHcBq4Vu55XSksiBt78VVbyFQ@mail.gmail.com>
Subject: Re: [PATCH] exynos: Avoid duplicate reset_cpu with SYSRESET enabled
To: Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2023=EB=85=84 10=EC=9B=94 31=EC=9D=BC (=ED=99=94) 02:36, Tom Rini <trini@ko=
nsulko.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Mon, Oct 30, 2023 at 11:55:02AM -0500, Sam Protsenko wrote:
>
> > The sysreset uclass unconditionally provides a definition of the
> > reset_cpu() function. So does the exynos soc code. Fix the build with
> > SYSRESET enabled by omitting the function from the soc code in that
> > case. The code still needs to be kept around for use in SPL.
> >
> > This commit was inspired by commit 6e19dc84c14b ("sunxi: Avoid duplicat=
e
> > reset_cpu with SYSRESET enabled").
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> --
> Tom


applied to u-boot-samsung.

Thanks.
Minkyu Kang.
