Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC6DC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 12:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B6A782E86;
	Tue,  8 Apr 2025 14:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UpaDoGwY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3457C82ECC; Tue,  8 Apr 2025 14:12:59 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31AD482E50
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 14:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-54af20849bbso2998300e87.0
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744114376; x=1744719176; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWZEpmb8BE2nllS4UCOJ1QDIq3qNewZwUrqwGk230Ww=;
 b=UpaDoGwYU3Nt+VPap/rGTaU5C737SX5YVilIvoJkbqKqA9MUUGMeIRHCPoxQluIoh/
 pUX4kMeKGO9Sral96Ozrf8IS/iF5ef7H/EH4gK5fYP7JgR9NBNuPncodwDBJlpIGIL4D
 0FxNGxe7658FbUi25XxYwlLgrJbMeWHTnNyL4esXmlv93PKHc5LApsOinhFWpG/EMdZG
 Dqx5enjEAkPOcmbreA7Ujxrs6DVBEHkErOahXWwK/O1+FMOOYOTqQFhciBYbwsMRcyTw
 FYf9NzrItyDOdX3KbfutbT0AVhBrr1dul0O27TqZ09YLMxh1ptNd7DghnREWYi4sQ5FD
 TZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744114376; x=1744719176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWZEpmb8BE2nllS4UCOJ1QDIq3qNewZwUrqwGk230Ww=;
 b=OXKXylBgKMG5v+wIyH0ShP4bHkZU1LTFLA7b75PAaMRz15SwGWAHOfeZoaESUXwM7r
 6XZrrXgKpA/vSBMoFz4//fRkuXXFfZues7oUASQDZEpwjvjSzTvDloHLhTfYQOGQs+Bq
 /OYEkyQhlaXXorCzyyV/yIGoCEIBxE6FuWWponlWJSyX0ECQEd+07PbOmzQbUylYdNqc
 xqPJljF77Ny5y7vKCet1/ReuvcLJobjIBVl/RFAcInQJZ3Be4Y4R5ZvfdEQSUKg/0QxN
 p97jhig5zJcj1qF4r6rMWcnlOG44KiaHvlPqg126xldTxZqbpPH8CIqYfWU/Y3+MeeMr
 Zy3w==
X-Gm-Message-State: AOJu0Ywtrs5Mb06UtRUYr7iKg8+CQvb65Do7opQHayrLk2emMswRPlw7
 8KxAQZM6cWfr8+QPqJOb1iQEq0/jTWnGlVz3YGpL4DNgE1I5RTSBEJlOPx/TgAP0+YrLQr91ssT
 5eGSFByLnI3q6o0L2ISn9YYqdwCA=
X-Gm-Gg: ASbGncufn4fU6p/py9/NRfMCZY21hKWCFlpt4YsM8/uYVEu1lwXFtgxoJZJIjQS8l8g
 7HOajsz9piNpjtKzNmdFFJOTY1Zmm1vxi4lSzxMS3OPMA98JU+BwCGDAQjyQWbt1RKz1/KZrpg4
 BgMhcp/yQfKbECUWdMMCPLZ6fC8TjnLg/JLheIpIDghDHgqrz7reJ0oXXf/w==
X-Google-Smtp-Source: AGHT+IEI1oVJv1y0GBDAn795XgfWXteUBLsEgdlL8zLGBZOO/pRcySQ3D7F1UYLNrs5346vKyt95d8tzit0HGrd2BXg=
X-Received: by 2002:a05:6512:3f1d:b0:545:56c:36c7 with SMTP id
 2adb3069b0e04-54c227f5150mr4976253e87.41.1744114376147; Tue, 08 Apr 2025
 05:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250408001639.469298-1-festevam@gmail.com>
 <fe0ac3f4-6c79-4ce5-b63a-6a2b1b8c5386@linaro.org>
 <CAOMZO5AZSmcGA067EM6PuHonTQweD-HYa5yHK6Eo7H0R2izAZQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AZSmcGA067EM6PuHonTQweD-HYa5yHK6Eo7H0R2izAZQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 8 Apr 2025 09:12:44 -0300
X-Gm-Features: ATxdqUFKMS99uV7Gnpb_OYLrJKP7AO3Cote9avR4V1zJYu7wwnuFbaBCL4_R730
Message-ID: <CAOMZO5DBsrKoJytCw23h=3=0jrWAewCpbWqRVpHR=TNb08a5-g@mail.gmail.com>
Subject: Re: [PATCH] configs: sama5d27_wlsom1_ek: Select
 CONFIG_NET_RANDOM_ETHADDR
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
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

On Tue, Apr 8, 2025 at 8:29=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:

> Yes, it seems this is the case, as the following SPI NOR error is seen:
>
> jedec_spi_nor spi_flash@0: unrecognized JEDEC id bytes: ff, ff, ff

After opening jumper J8:

SF: Detected sst26vf064b with page size 256 Bytes, erase size 4 KiB, total =
8 MiB
Net:   eth0: ethernet@f8008000

QSPI is detected and Ethernet is functional.

This patch can be discarded, thanks.
