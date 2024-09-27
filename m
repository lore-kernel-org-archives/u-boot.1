Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3EACEBF8C
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 10:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0E88908D;
	Fri, 27 Sep 2024 12:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kxsTeGHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4F7C8908D; Fri, 27 Sep 2024 12:19:18 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E6DC884DB
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 12:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f75de9a503so21598841fa.0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727432355; x=1728037155; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCRxrENw+9BLkBTFU1TsbkeG4w/1Gmunbo9GGi6uMBQ=;
 b=kxsTeGHEUo6hBeMGShf3ypTqTgi2XmhOGr869RUrf0n4oFCj0HYgkKzMTOdX0XhvVG
 7nU32ukQhWjKyKayxHrPKMmfkKasu/Av+PzgoUojQOV0aYLeRBY5oXaLMQIqL2u2qBTp
 nlKupUMRAqYcdT1cOQq6kMZcSo2HWsT/lgXa4HEApXpvvfAOwoT4If9EuLmDYJLuaBY0
 3bt0ok9yr27PqeRnooPAztcc5US9gzQ4qgKVP7HvJQ5FWfrh+2cvWNYX5CDFc+H1ivRP
 p3ImQcKyF1JLhigYdjuKFn7gOSqWtivPQULrQGKSXRue8WyTseU3FmTPA2+TVv0Li0wm
 mylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727432355; x=1728037155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qCRxrENw+9BLkBTFU1TsbkeG4w/1Gmunbo9GGi6uMBQ=;
 b=cqK9KA8yOydKt2B61SEI6vl3hUTvowi5D91q69swUVaoZZ8tjSRNfC0r8SwWUjIHMa
 DUebvmsNeJPjJI/9pwnyTVygAz7rNTXXoX6QfPfP5ESKbSV0tDC+C+T87azSiiconUu2
 Lp+7PlSS/FYA3LLiHubk7rU0PnTPwWF+YnZCVMC6DKuk5Ydg6RQdUspeknndHUY0E6xu
 /KNfbUUaWAeNFo9JVfCuFPotoT7qSDVoX+LpXvo9YRA+sDG+J+0je7oCV9CWIuaDSHa2
 6MuRNoHHyEFnkDXc5AQB9UF1i1H5WRCr8zWWAbnVDWoHwD49lbtkRvybA+CDAOAlBIxl
 n69g==
X-Gm-Message-State: AOJu0YwI5+ZjMW+tMZQCLrQiNQW8HTQPpSIFLyjvn7lOc2rxnsX2inQp
 TX2+nDQ1ogksXOyyVGmWbbvzxFqQLX3HE8hIDZHMZlk6hWEhs7UfUX0A3wIEJ8axSah40DWZz+o
 4rUpbrUmkooj6T3pvnNLsf5YaEEk=
X-Google-Smtp-Source: AGHT+IGMVGzLMSwCAoN5fQVwUA2qWjYuRubSkofl+D3Pb+Gvonb3QI42AV1ypxMEruUnexoU8FY2Fgb52X5UTRQvhYI=
X-Received: by 2002:a2e:be10:0:b0:2f7:5519:710d with SMTP id
 38308e7fff4ca-2f9d417b05dmr16121321fa.33.1727432354931; Fri, 27 Sep 2024
 03:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240927071844.2738740-1-alice.guo@oss.nxp.com>
In-Reply-To: <20240927071844.2738740-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 27 Sep 2024 07:19:02 -0300
Message-ID: <CAOMZO5AczcCNAg2rPJSoc2mrULGtAX4TgCZfD_z-iWFrpn711w@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: adp5585: Add SPL config for ADP5585 driver
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, marek.vasut+renesas@mailbox.org, 
 clamor95@gmail.com, paul.barker.ct@bp.renesas.com, michal.simek@amd.com, 
 andre.przywara@arm.com, ye.li@nxp.com, jim.t90615@gmail.com, 
 billy_tsai@aspeedtech.com, kabel@kernel.org, caleb.connolly@linaro.org, 
 biju.das.jz@bp.renesas.com, sr@denx.de, piotr.wojtaszczyk@timesys.com, 
 Peng Fan <peng.fan@nxp.com>
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

Hi Alice,

On Fri, Sep 27, 2024 at 4:37=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> So we can disable to build ADP5585 in SPL to save size
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

You missed your Signed-off-by here.
