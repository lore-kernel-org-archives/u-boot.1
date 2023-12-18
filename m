Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069F5C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 11:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A46D87E0C;
	Mon, 18 Dec 2023 12:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bDSFRjLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20DA187E10; Mon, 18 Dec 2023 12:30:36 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66ED887E0E
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 12:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5e32af77f15so22897547b3.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 03:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702899029; x=1703503829;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84aKg53vPK3l7Lpkkt2hG8JdtmePs5QDaiAGpc2UWFY=;
 b=bDSFRjLNVchOmneNLphh1IdhrgwmF2dxV6f3LT/cTbstCKiXE9vcey3aiMIgwFvNDc
 9OHPb3uV10rZa9Yw/m4cxeJrCGI+pM15UK3piTOKXCy3deIaFTw9X2ZZt+6a9YE3PAhA
 yKkFxNXXENQr0lWxfStGYgMjanO0gtnaB7cic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899029; x=1703503829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84aKg53vPK3l7Lpkkt2hG8JdtmePs5QDaiAGpc2UWFY=;
 b=kBu+fSGFdRR3ZGyA4X7ETsB9vAJWiHgK0/JjKcwGNDDpOe034qVWUceUmBGH/HsUSn
 DBqdkMqJyvn5j0SgyguiwIpd8dlvs4LZDxdx05IAnymumJMjRhoVmbtJpR2R152ekH79
 S8NwXri+5IPzki6VAQiVT51ieW3Li6lK1VmdfNULYwqT1SxMKZjkOlRh2pJcen5p7kem
 ZQsHMN8VVkbO3ETi8swPfdUzCLEZjAobHaN1/6ZosaCxcoRItywdj1/6LRlfJTzGzRb9
 rvtd/Yu4k0dvRM955bvb2ZB3AzFH/Dr29aXoSp8kJhajk5EGAVwT36mIPykiV3Aq52KM
 ciCA==
X-Gm-Message-State: AOJu0Yy/OkbQJU+QLXJ4d5Pl4ul5rlrLPC1z2oh4NQKTsGI4kS0f+mQ3
 CmNbmwkM9NhTwOdXTWbVR7qZrLWGrCkfol3xMT1qNg==
X-Google-Smtp-Source: AGHT+IGQIbKdYG6337JOPBktE0uB/Zpb2/X/G3qnb0l7W+DLicYbyYGabLmQoWlEyqWQL6NA2nIpB+AlkdYkSRW1yyM=
X-Received: by 2002:a0d:dc83:0:b0:5d3:9fcb:b699 with SMTP id
 f125-20020a0ddc83000000b005d39fcbb699mr13740553ywe.49.1702899029659; Mon, 18
 Dec 2023 03:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20231019032125.6683-1-bruce_suen@163.com>
In-Reply-To: <20231019032125.6683-1-bruce_suen@163.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 18 Dec 2023 17:00:18 +0530
Message-ID: <CAMty3ZB6X45-22f2M+yWeRFkPWLKDVcC8yL9ownXhUBAJO8hkQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spinand: Add support for XTX XT26xxxDxxxxx
To: Bruce Suen <bruce_suen@163.com>
Cc: u-boot@lists.denx.de, dario.binacchi@amarulasolutions.com, 
 michael@amarulasolutions.com, frieder.schrempf@kontron.de, 
 bruce.sun@xtxtech.com
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

On Thu, Oct 19, 2023 at 8:51=E2=80=AFAM Bruce Suen <bruce_suen@163.com> wro=
te:
>
> Add Support XTX Technology XT26G01DXXXXX, XT26G11DXXXXX, XT26Q01DXXXXX,
> XT26G02DXXXXX, XT26G12DXXXXX, XT26Q02DXXXXX, XT26G04DXXXXX, and
> XT26Q04DXXXXX SPI NAND.
>
> These are 3V/1.8V 1G/2G/4Gbit serial SLC NAND flash device with on-die
> ECC(8bit strength per 512bytes).
>
> Datasheet Links:
> - http://www.xtxtech.com/download/?AId=3D458
> - http://www.xtxtech.com/download/?AId=3D495
>
> Signed-off-by: Bruce Suen <bruce_suen@163.com>
> ---

Can you rebase and send on top of master? This won't apply.

Jagan.
