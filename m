Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B453CC46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 10:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5CE08771B;
	Sat, 16 Dec 2023 11:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Agj8iKPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF5F18771B; Sat, 16 Dec 2023 11:32:09 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB9387717
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 11:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2866b15b013so177604a91.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 02:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702722726; x=1703327526; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E51mwr85q6GOwz6pLl4rn/y6Ri7i+q7DjRGt/eeee20=;
 b=Agj8iKPyADEPb3hB/7OQ7O1IV9oJlAUp4YWLAsuZKYC4IsAJ77JQnABtNUvmsgwFXf
 cm1vY3E4JKoECrx8+G0pJGCGTygVyDYylV+0g233T67YNg+SKHhPwWSbkfrmwYBYbRbK
 9cNqyGJhzyIc/RPjRWGyA0KGEWMRwTSVRkomyMcZsWPpKfWLPOFke6q/qrgrNMgfBjv3
 iGaTWl527jqIeTgSnMLJ+1eBoqvaN6us7QWY+wEmgeKsgC3QHEmHumVgPat7TaXPMV2y
 npj5h2gGMdoC99Zv1lH4+l1urIg8C3kE9EoxqYHX7w53HzUFEOGjxbBcOUFnC/Yy6QYU
 yjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702722726; x=1703327526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E51mwr85q6GOwz6pLl4rn/y6Ri7i+q7DjRGt/eeee20=;
 b=ELEP5RrnA5//MzwZbR0vDIY4uGRf0z6J9YOc333Mu+r/2s5sgzi8bxAx4nDrJhTiK9
 FWR1bS4g/QsnHg1UKmm2tk8YfnFHm9XxsaOCwjSBed1jdkduHk75Ze7WhVxep6E4ykwv
 zOeK+qyUZPnpyWJDjAqADMWBtn1Ri8/lEQcnnHPoFSaGPgJCGwo7lcH31fnQjhBtQwJB
 Hq24hJc5llCI7Se5VTUYURFMXVEovsZorY+5aP3z5GnbB+JFr4hc+07WW6ZszOw9I0kZ
 JSqZoTr+qUdUECYKOk9gfCX05JaXyi7/G+jKZMwwH2IyKqw8SuS2a85eOuQdSec/dje9
 Vr3g==
X-Gm-Message-State: AOJu0YywCPcoydiNAkSSQMe+DnnNVfhbEZbYmCFhh835JvL+6TnoLjue
 9guRjp55jq7U1TVmmbJfMFkJPDD1Z1CGlLSrFz5mNcyzYxM=
X-Google-Smtp-Source: AGHT+IHbZyOJYGpoBHv7WwSLX6nDWMKVcot3qiusn4dKAPi6bbcJl58OslXD1g1FFu8xuiwMiGie6ntEza3kzBIilBA=
X-Received: by 2002:a17:90b:188f:b0:28a:f2bf:207e with SMTP id
 mn15-20020a17090b188f00b0028af2bf207emr9063270pjb.1.1702722725621; Sat, 16
 Dec 2023 02:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20231216053624.326731-1-marex@denx.de>
In-Reply-To: <20231216053624.326731-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 16 Dec 2023 07:31:53 -0300
Message-ID: <CAOMZO5CraAXEwCgRgmJ6kVuZkg5Rbina8Gng96ySWWe4evRBoQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-pico: Fix alias node indent
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>
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

Hi Marek,

On Sat, Dec 16, 2023 at 2:36=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Switch from indent with spaces to indent with tabs. No functional change.
>
> Fixes: f8548ce0e093 ("imx7d-pico: Fix the name of the u-boot.dtsi file")
> Signed-off-by: Marek Vasut <marex@denx.de>

Thanks for the patch, but this is already fixed in the U-Boot next branch:

https://source.denx.de/u-boot/u-boot/-/commit/4b5c1175a2ba8493ecb223d99b31d=
5f55eb4c3f4
