Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFAFC46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 13:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55ACB876A4;
	Tue, 19 Dec 2023 14:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MpkX0pEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0191087669; Tue, 19 Dec 2023 14:42:53 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4A386EA6
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 14:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a23350cd51cso344138266b.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 05:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702993370; x=1703598170; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4c/D109t7fxkb91zr1iUdnvCib1309hmGtfe003yL8=;
 b=MpkX0pEKaxqOOXpc3GAlQmiy2+kyrNrgwcAdoAkV5D5Pv5UUrM97uUdLZIBvu8GnhT
 HrfQStpjyj+VJIfMcAfqiIO1FIRhw6EfgN7SMeLnOxE2KWtQ1Xju9NX32cuSD3E+IyFJ
 WdKdpdWXF59SjUfTBgzAbb6clkC9HN1fliY7HdrT1z5ba6ZL14RBCW594Q9yzdfBsd9w
 Yj2ChEsBNpcT4Y3z3cZvzwNgUcMU6i272M6xQLDXVprp8qdRpy9zKKvMudSizUuA9qsm
 iNa2CrMDl+xgohWUnHnDRqzTpY9NL74U4vxT+EMKjvllkrHV4olSABg8Wi1mq7qXD4N1
 aRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702993370; x=1703598170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4c/D109t7fxkb91zr1iUdnvCib1309hmGtfe003yL8=;
 b=t6g2rNJl/3gCsGzjzsi2WlNBQ3DjMGEO9/bq759lkCBbe9BIHs7QXTpo3XHny6E6uS
 47c5F3mx3sOeK8BKjLcFDDAXrGpu4+k0jaUE8G2xsUmhWxt7JX9OvI7j87PEkoxS/ZXS
 pIgZbvM2TN9LR/TK0zb68uSfBqsSoml0KSMmS/ZK3eUoXnC+pN0AF8hnSuPiDZ1njaOD
 ICaOA//wn7UD1KtQ1g2feQjTAlSSHdHuWQY0FmOMFj+4Pbl+PZ164jBa8jgPkssWpRHg
 ygkdNj+IloSbcV0RpxPgT5V9qZ/91nnvlv3gRQ0Ivv9JzzjyWezXNsK4R4NT8ExhNVgf
 VQ5g==
X-Gm-Message-State: AOJu0YwraxMlNdpDv1WrxHb9AO7X8e/wxHFoFaJPjSZ2hsPih6u2MRn4
 +CV9j1BAMFFuGHPkXgrZFVqula7W3mMX8vbwn8Y=
X-Google-Smtp-Source: AGHT+IGXIXg251vN0/OHuyP1oZjA/XLqgwEDNQg4P2b4l0KHC2gU6wTdXDYD9bNK8De/d5zibOqT6E/l4cVj3khJ5pU=
X-Received: by 2002:a17:906:209e:b0:a23:54a7:3b13 with SMTP id
 30-20020a170906209e00b00a2354a73b13mr2072571ejq.123.1702993369693; Tue, 19
 Dec 2023 05:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
 <20231219122439.31983-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231219122439.31983-5-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Dec 2023 21:42:43 +0800
Message-ID: <CAEUhbmVTn3_noumF2NSsPKZwrcdUwgopvRJCOd_VtmBR0W9PpA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] risc-v: add ACPI fields to global data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Tue, Dec 19, 2023 at 8:24=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add fields for the location of ACPI tables to the global data.

nits: I believe the tag should be 'riscv' instead of 'risc-v'.

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v3:
>         let tables in global data depend on CONFIG_(SPL_)ACPI
> v2:
>         no change
> ---
>  arch/riscv/include/asm/global_data.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Otherwise,
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
