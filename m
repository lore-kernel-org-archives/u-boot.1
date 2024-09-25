Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8C0CF58ED
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 807C388B13;
	Wed, 25 Sep 2024 15:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g50grhzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1055788B13; Wed, 25 Sep 2024 15:49:33 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7313A88B11
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 15:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f7529203ddso9886671fa.0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 06:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727272158; x=1727876958; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7zzNQJW6EUWlgxWVfHpHkAbqJiR+E7WE+maGw4I+xM=;
 b=g50grhzNq3UY9oBZpm2Vqx66Wp2KaI8h6HWAVekXU2d6KeYYX0/LnKvpGU3bvozt7e
 ylEbu5br74mkd50gvzSGrza4BmiDEGN+D7PZq2H6758PQnzzZ34ErbN7EYH6VcV3jWwG
 tQxov3NiArLv1OluGzCDCbINmh7hCDtL8yduhyirUU4PZsVWDggrfKMOUfO/BVa/pCZg
 1ULcWrws5+YJQOze8FUWNI/yrlt6VAuwUMctJ5O2QxvM10K/rUGEOKIQou7t1m0w0myP
 3Ubngicp06t0W1ao4Zudv/6YG6of+508gKYzaOkkq9Qt3vHpfs3Ri19AQlR6jSo1HyrE
 FCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727272158; x=1727876958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7zzNQJW6EUWlgxWVfHpHkAbqJiR+E7WE+maGw4I+xM=;
 b=vyEZqBQp4plJzXhNI7YDeHaQjWcUWXXR2ncHpbCJ3TbvoLDw7NhjoPe2s92AKFAQ+V
 8o9kRoM4xwWdwsVFT9fP2hFIRB+g+a68pU6UrvdQRZQzOKATyuGR74/Fldbed30Tuc4q
 uzlB2RCjvBdP0RwMF4wXnhU/aFW7GGkjoTRABtYZzg4X6phX7EJbvAtbBWldsKhs+wz8
 19EfKPvhY6hd74UyyoY6XCiVkMIP3scGS6pC9obw8EIZ00utrm915p56wDWrcXIalwLB
 Qe+ycG19V1LGuXqEUrPZB+M5Cv8g8yLWHPNgQbAjcLAYAz6vYR7cBZq2HrRYrYYaxiY6
 TgPw==
X-Gm-Message-State: AOJu0YzOFvSWAQAlgAZby+u47Yh4OJhY3FsCPu+1lLEefXFOt2JqDHIB
 ORLGEwZb7DHZ2zSxCwqDIku8zVqYy3VJBRFIP+dVfJkK0URWYLXywifpwevH8046L6dgDEMgWnP
 T7N10M6k7xGvFTZHJHT5XnpIJ63SHNIqJ
X-Google-Smtp-Source: AGHT+IGQjMXYIq+DLOuxEsauzKyhwlIzHQnxV5qlCfGidEs92yxbivjMmSdQIaNaPR8T947KdpVhBwwdIyovT1PWMEk=
X-Received: by 2002:a2e:a551:0:b0:2f1:6108:3f00 with SMTP id
 38308e7fff4ca-2f9463f9100mr11901421fa.0.1727272157347; Wed, 25 Sep 2024
 06:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240925001119.667820-1-marex@denx.de>
In-Reply-To: <20240925001119.667820-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Sep 2024 10:49:04 -0300
Message-ID: <CAOMZO5Bu-UW--EMZ7hPUcW_COWr+5mZioBrhBv3UgZPXNVBvOg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: Add DH i.MX8MP DHCOM SoM on DRC02
 carrier board
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Tue, Sep 24, 2024 at 9:12=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add support for DH electronics i.MX8MP DHCOM SoM on DRC02 carrier board.
> This system is populated with two ethernet ports, two CANs, RS485 and RS2=
32,
> USB, capacitive buttons and an OLED display.

The patch looks good. Only one suggestion:

Please send a v2 indicating that the devicetree has already been
submitted upstream and add the reference o it:

https://lore.kernel.org/linux-devicetree/20240925001628.669604-2-marex@denx=
.de/

Thanks
