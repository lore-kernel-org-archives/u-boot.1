Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3C7C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA83C87B20;
	Thu, 14 Dec 2023 19:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kPLUYVdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA7487B22; Thu, 14 Dec 2023 19:06:55 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2BF87B10
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5e3b9c14e46so6822817b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702577212; x=1703182012;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XTDtNqjzOoSf6PKoW+/nXxOuVjrqeiFn94yWM7ueis=;
 b=kPLUYVdGsnDz+egj4/iFqJe1UB1Gv35ZCcIgPkBYEvHSnzKX9fp71WmWgCPO9xmZeD
 RiBnYJQP4QB1DnEiSzbxakRYLxPz+KSOaVLerTg1TpFCen/XfS0ozHF3RQkfQDK296Fx
 882Qhe5xewapAm5Q6rEdD5dm5OvHZuUagnHIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577212; x=1703182012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4XTDtNqjzOoSf6PKoW+/nXxOuVjrqeiFn94yWM7ueis=;
 b=rD9omVQ3CAq1mPSKNzmSQQO5T5pqi9RM2QRo459SOSAa2X+8sXNt568oNjfeR7dTXw
 GjKUmytYA6pXMca4/zW3UlQHLS63uCX01jsWkssHX29D0NzGVDYlYr+JRupIxqaHrXlu
 wp9jZzkyfM2+YbDYxHo9kHBTE4rR9JPQoxtoM0yc6NwxzOMJvKJSkYWATHu3ekI8K1G/
 PkgmFHzv70n9PMomMEiaejUIkyOrDBboGN8KhBtzDrGXuq3izPJps82d+bwZr8ppMwld
 +jtrUk7WYoL8ZxDBZzMspItInXPeQnNqfocVqOZSwlhuxJMrrEQxQUwsUt3cuSEM7Ve8
 rqQg==
X-Gm-Message-State: AOJu0YwjQ3UtGtjx1U/OAulyIpS5LZAp+49TnUTPJ56aM5+tLhnRMHuU
 lOv5cfnOyfiOEMvh5sbl/Dzt3rENFj1R8ZCytRNE2ak1inEyF/YF0YQ=
X-Google-Smtp-Source: AGHT+IGzmLqGX0NCn6yTFe6eNEtqBBDwW+sOdzseYXSWD9Fg0xKS+UUBPWe8i29tPSP/XRCkShSpSlATdDn2QnbrnQI=
X-Received: by 2002:a25:8c88:0:b0:db7:dacf:3fd6 with SMTP id
 m8-20020a258c88000000b00db7dacf3fd6mr5487675ybl.131.1702577211703; Thu, 14
 Dec 2023 10:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20230926091024.408275-1-JJLIU0@nuvoton.com>
In-Reply-To: <20230926091024.408275-1-JJLIU0@nuvoton.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 14 Dec 2023 23:36:40 +0530
Message-ID: <CAMty3ZAkugEM5HGukva+d-FX5LyAO66wCTNZ1BKofKg9m1wLPw@mail.gmail.com>
Subject: Re: [PATCH v1] spi: spi-nor-ids: add flash model w25q01/02 support
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, trini@konsulko.com, vigneshr@ti.com,
 u-boot@lists.denx.de
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

On Tue, Sep 26, 2023 at 2:40=E2=80=AFPM Jim Liu <jim.t90615@gmail.com> wrot=
e:
>
> add flash w25q01jv, w25q01jvfim and w25q02jv support
>
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---

Applied to u-boot-spi/master
