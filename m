Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C31C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 11:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A00382FAA;
	Tue,  8 Apr 2025 13:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dgTtw70o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9688C8312E; Tue,  8 Apr 2025 13:30:02 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7781882F5A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 13:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-54954fa61c9so3351847e87.1
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 04:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744111799; x=1744716599; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVQQaGNo6YQXalAviXU1gYX6YvJnXRN8UBWMsUGuqDE=;
 b=dgTtw70od0JkQtsfakZTfxE6d1qAUiq8GKemP07cq/mNVoo4odnhggjVHn8nj94bMa
 OLz9UbLQvllUdZ5fUZc7cDZCEmm7Nyj+opWmWD8zkllgqsSUetWVxrdyfVLyrCDmFunB
 QpSquKCXfsLCQ4cInIlZ7gDLFK86VgcCQoXcU0irNCSjdQlfqxwJD1LR57WWTB7Ngk2m
 cGB9p/2NeFSryQqUHBaiD5arKRKqhR4opOONgfHsw9vsDBaCkDn0KXkgUJeqV4V+jYMD
 rEWCJwJ05DXTfW6Xj20BUDfD0kv/Ly6ReutG0+xP03UUtET/mJ4+9CEI6RjFJ0p/3boG
 oEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744111799; x=1744716599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVQQaGNo6YQXalAviXU1gYX6YvJnXRN8UBWMsUGuqDE=;
 b=gRHU6+w/DkTfXnJaEiEFLUN33HFe6FzxbrgJhbt2gQ5vTWWX0TBZ0GYrVg+CylzrME
 rPqB0zHmyR0C4y/s3HUfEP4bmQJTUqqWjqui1k6EW8rS1vUS3fuTDK7adfKo1CIYBG3w
 Ii251lmu40rVqN2BnsQvxZT6LcFkx4yTY0cd+NNAdt5qdRBLWsGodGb/LlZjQ1dTtGXk
 qWK/1sRoFyM3U6ZKh9SA/6hXoYCF7piHvW/DC1nJ+aaSpApOR34JVtjYqzyzini9IW58
 psTa4QdaogEylB3b4xjOuBxOSnC1dj9Rbgh9/qEL1nw6+zfT8d+zbOTti6oMBNw+PtIM
 9Ylg==
X-Gm-Message-State: AOJu0YxSNeK+fTOTtHMDJgVTyF5QKLAtIIFyg/v0L/TyvQja/mN3bEil
 gY+l3BmmBoPhBxZqXQN7p2NdqvuvscNup5MVjSfBFl9GgWLAUsk7pm8Et0RVFcKJx+ZOlhTI1L2
 u33eoerceJqoQCZhgxAsAue/Kgi0=
X-Gm-Gg: ASbGnctGDDSlAb4MHUOCtTLDvbNiNxLCS7a/MOolPr2JP8uHEx+CEJoDQTholSTSaJa
 DCtnidkTj6WV0+1kjjs7if9owizMwH0shw4CbrBzdcrTbaLAOCDc/s6kPeHKi4E/QtNNlZlNUw4
 VBUv+0vip598oz0bxNeB1sCB7arC8Ue03vvJduN1of5tf7kLk+8+tgfZiEMQ==
X-Google-Smtp-Source: AGHT+IFfYNg+WmiJkBukc+dGTCdhCqmnQwR16EOrAWGos2+NZ4vlblIrYbGeMzRWiDIpBsmjROKAj6bJRxffJQxqVGs=
X-Received: by 2002:a05:6512:3f0d:b0:549:8c2a:3b4 with SMTP id
 2adb3069b0e04-54c22777944mr3599423e87.13.1744111798465; Tue, 08 Apr 2025
 04:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250408001639.469298-1-festevam@gmail.com>
 <fe0ac3f4-6c79-4ce5-b63a-6a2b1b8c5386@linaro.org>
In-Reply-To: <fe0ac3f4-6c79-4ce5-b63a-6a2b1b8c5386@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 8 Apr 2025 08:29:46 -0300
X-Gm-Features: ATxdqUEhWexiT5l5gW8CZl_UoyiZddwabkDsSBV-loEGyx3N_UAHzSiy7w3Y7jM
Message-ID: <CAOMZO5AZSmcGA067EM6PuHonTQweD-HYa5yHK6Eo7H0R2izAZQ@mail.gmail.com>
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

On Tue, Apr 8, 2025 at 4:16=E2=80=AFAM Eugen Hristev <eugen.hristev@linaro.=
org> wrote:

> At91 boards have a eeprom memory that has an unique MAC address. Some
> boards have a QSPI memory that keeps it.
> The fact that no MAC is available makes me think some of these drivers
> are not working. I suggest you debug that, and do not enable random MAC
> address.

Yes, it seems this is the case, as the following SPI NOR error is seen:

jedec_spi_nor spi_flash@0: unrecognized JEDEC id bytes: ff, ff, ff
