Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C03FCD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 16:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B3388505;
	Fri,  5 Apr 2024 18:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jaf0q2NP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28CC88512; Fri,  5 Apr 2024 18:51:49 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D151A8845D
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 18:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso440856a12.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712335906; x=1712940706; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpWSXQZgMdI13zT6QN3HXLxmEIbMAVEMBfwMYHB5Ft8=;
 b=jaf0q2NPtM1mEFlK4jTPuJTIhU6Uz0m6MwhlZhaHSgRvBGgVISRFLEir4pAr2Of56M
 FH5xGSwwhag7tQf2OnR8ezSlyEX52sJ8S8yKAiwfhBkOe0x6JgEJy6wMd4rUm4bfeAcy
 0g1agTClAAkOgjt97KKITl26HAGQlXLGcCpX4Ettqdny1fHFUodz/lOyh2JxBL13rAeQ
 yAYx+665cNuhCqb4LfjXIybNPGrHf1Cz/TvEMk6gzz9hCP4PNyN52fIDbj5XuPo3auW8
 uyBA7YmWbMo95L4cjx6/Uwp8NPfmJg8o3LLh+kSqwE5Y8IJHG54YNR/Z0CHkT7eM7Y+z
 iOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712335906; x=1712940706;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QpWSXQZgMdI13zT6QN3HXLxmEIbMAVEMBfwMYHB5Ft8=;
 b=D45m7M1wIhvYenqR3WO4/2Ne9m5Ywydr1Dt+KN6V/Kthg6PLXB8CsfrrKTyFJt6Vdp
 OZ5jFEpZ3PgGF91i0HH6OP/+wtyRZ0QIVvQb9hCw/SAlf9JUzhYJQlXwpUwTY+caea/Z
 DwXBAaOvuA9h60WWNUo4RI3bgUcToMxdbYUJlDFbJ2XS9UhFmMrbiXtgu1kK8yk5mLd0
 8VHUM0+DvvQm9akr8ll5lU7G4Dg5rf2NMhpOMggL99Qi6dzd9piqKEay4ZkdPqaEtbbR
 3g9f08kDAlhroYyYG4qZx2JH7+kSukcY6WJQHhbOGj1sNkX0smnhL5XhUdslBtTT5Zve
 /fKw==
X-Gm-Message-State: AOJu0YxTSwFEwSydiEM6E0IpGNEpjx/wwpP9cKzA4pnLMlvi/1jglXT9
 fs0nK6oEPeiWca3fZScZ2IjhT8tgPXU5u9RvOW5KXcgXhuqdJ6NVyv6Kwiiig8tqCts6dZLFm4Z
 g9yYMAUubQFqQ4Vbbcg7oJ42ZH7OL0EfV
X-Google-Smtp-Source: AGHT+IF41+U/LYtQbMKTRHMDMjvLNvlJweVdghNE1Zskq4gUCxFI6qyaNLXXdKHzKpJ4HudBlhOALGP4mO8Ig+XudJc=
X-Received: by 2002:a17:90a:c392:b0:2a2:5a91:1d2f with SMTP id
 h18-20020a17090ac39200b002a25a911d2fmr1845551pjt.4.1712335906378; Fri, 05 Apr
 2024 09:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240326212455.118772-1-aford173@gmail.com>
In-Reply-To: <20240326212455.118772-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Apr 2024 13:51:34 -0300
Message-ID: <CAOMZO5BVjUE64GwkQcv+6c4j545krwH9-L2ZL_4x45CVx=DDZA@mail.gmail.com>
Subject: Re: [PATCH] configs: imx8mp_beacon: Enable PCIe NVMe drives
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, sumit.garg@linaro.org, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
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

On Tue, Mar 26, 2024 at 6:25=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The baseboard supports and NVMe drives via the PCIe slot. This
> requires a few extra config options to be enabled.
>
> The NVMe can be enumerated with the following commands:
>
> u-boot=3D> pci enum
> PCIE-0: Link up (Gen1-x1, Bus0)
> u-boot=3D> nvme scan
> u-boot=3D> nvme info
> Device 0: Vendor: 0x15b7 Rev: 20120022 Prod: 184960441105
>             Type: Hard Disk
>             Capacity: 122104.3 MB =3D 119.2 GB (250069680 x 512)
> u-boot=3D>
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
