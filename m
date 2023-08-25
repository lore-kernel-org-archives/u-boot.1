Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB31C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 20:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6691C8655E;
	Fri, 25 Aug 2023 22:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSSqzgxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B529864B9; Fri, 25 Aug 2023 22:17:01 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEFD586906
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 22:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52683b68c2fso1909719a12.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 13:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692994618; x=1693599418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6BWPkULSROGmmC7J4iQBN8qiIUNlpGtpIOFDTAo6xw=;
 b=cSSqzgxTosyWNUQloDE6ZBc/mbjCWdBKaFfN8Vx7NAQE4zqp6GlW7Vn40AGCDH169x
 STw5zo/k49JZqQbL648oZtq4g0IQYRgi9QwMp2LBn6DvccgCee4FvxKDds0iWOwq7NNt
 7BnpOmSgsf0fk2bgqYIiFZbju/D/BZrI2N1LN+SEcnxNEbs0yT6bibpbykRDdDNLmBxE
 MtviFReQwmi2UR0duyxc3azsJoHfgbPYVeNMe+ypuh5O1WMUpw7sAlvKz4UqCwGtf815
 +R23TgllZfi++YNZE+kgzLf/zvCphAtBrfbYK+hS/vkaICi8ghguOajBJOJgkiNNXPNT
 AbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692994618; x=1693599418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6BWPkULSROGmmC7J4iQBN8qiIUNlpGtpIOFDTAo6xw=;
 b=Y/EGo16xZF1cA8n86eGDgLJNVB4phM7zJ+j+VJn2k4hNJpF6CimLGSQ/OpJjvxOBii
 w1k1jfNd5sdr/Xk6rabZomRz+lgtPOQLOs1OhUo1vi5Aci40dros2Z5auzLiII1VVTFu
 iZDfhMEWqVHo1TwXV1W0F5/Y3i8F7ztYIFCp7ODEY6J/qV7kwAWRBdHT+ET5ZXrCYVNP
 3GAKRZbiTorRMT8EDaBZlAq8W0YLJ5feYKpCufR5oQlCPZmzypGZcXH4fPcLJYVnbch4
 IA5iGDQzGBogWgvJhJinioZlGLIInDm3Prbjpq0O5BTF/jQlOmfHTiVx+Yqpmdm2TzWP
 vlkg==
X-Gm-Message-State: AOJu0YyD7hHmZYn3q3LPjQy6X56O3xpnINz0RovOTaEOH7UdwYtzuLKm
 cCXrU7GqPrbAmG7kPgFNtQXbKDULLn4klwn/dPk=
X-Google-Smtp-Source: AGHT+IEAbFe0cBXjffaFXwf4qk3xt5KC8acCC4KJYZA9Q+vhP9KeQVP1GM/3qiyRrvbOe57R7Zs1paY1W+UTVYRpOOs=
X-Received: by 2002:aa7:d952:0:b0:523:b133:5c7e with SMTP id
 l18-20020aa7d952000000b00523b1335c7emr17182302eds.1.1692994617913; Fri, 25
 Aug 2023 13:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230825013930.1753078-1-sjg@chromium.org>
In-Reply-To: <20230825013930.1753078-1-sjg@chromium.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 25 Aug 2023 13:16:45 -0700
Message-ID: <CAJaLiFzS+oHkRuGCNDGj=xA4ooNvYrV38qYED+ipA2M_O_uJuA@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Drop some TODOs
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Thu, Aug 24, 2023 at 6:48=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> The existing TODOs are done, so remove them. Add another that came up
> today.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  doc/develop/bootstd.rst | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
> index ec3136535783..3e566e994d6c 100644
> --- a/doc/develop/bootstd.rst
> +++ b/doc/develop/bootstd.rst
> @@ -752,9 +752,7 @@ To do
>
>  Some things that need to be done to completely replace the distro-boot s=
cripts:
>
> -- add bootdev drivers for dhcp, sata, scsi, ide, virtio

Good to see SATA finally in bootdev driver! I'm testing bootstd on a
couple boards, and have been waiting for SATA bootdev. Any idea, if I
should wait for it to be merged to the next branch, or is there an
easy way to do it with one of your patches (I can test it on the
latest master branch or next branch).

Thanks,
Tony

> -- PXE boot for EFI
> -- support for loading U-Boot scripts
> +- implement extensions (devicetree overlays with add-on boards)
>
>  Other ideas:
>
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
