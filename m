Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31797E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 04:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B7080192;
	Mon, 16 Dec 2024 05:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CJUvvgWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A73D800D7; Mon, 16 Dec 2024 02:57:16 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6595880050
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 02:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=effbiae@gmail.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a7e108b491so32846295ab.3
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 17:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734314233; x=1734919033; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5pwE8zDu35ok4YLSrSrKqbQ38w9za7lEOlNsnTb9kuc=;
 b=CJUvvgWHF2WH/E+DIzn1hfceRqgGDPGwUkpHbIjyE451kNrA7WYWb89Rcew5hwvyvi
 2uG1Ju9X+6pLiHiUVZKOBq82aP77cYH0VC/RyZ4vc6ziCQdpSUjsC2c8e069PPc0w/1U
 nbYKno42P8u5J5RU8gmEmuqbzNafklK13hRfbHBc3ZcPSab6lyQUR0A5/14PeXb+QUWu
 A95AVW9TDXaENfW73vGqQ31gxAlx9KPbjaKi+hH0F8f5ba3sPmQpO9PDc3+aH7YGevzs
 /K8NqkeglgORhEzSFxQaZtqmgl+mUMuwg8eqgrkG1FmRm0UTq3Pd1s/TTiNqdiz9BGki
 CPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734314233; x=1734919033;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5pwE8zDu35ok4YLSrSrKqbQ38w9za7lEOlNsnTb9kuc=;
 b=BxVkyaKmEPKv0pNajkWiE+PmFsa7fLCQVEoAkULVq3V66DqsZYsa47GpCUZEb6/hxa
 AMozn+F81hP+crvpVvWdDFTf35fT92/R2LedlPkOczji6yxQYvd1cK48jLBVCtZGTr3e
 0P4xaN/nZoIyC4Wy43wy/HBoaIYdIPezHiZHnTRKF8Lv3XKn+D58y16JPtHHrenyQERj
 9mkbIs400S9Ot5xPRd6sG+F33hDPCwgkzGisleVaMsiUVSLpP1lJh14jhAioWiikisI+
 ZPgDWsAk4DvkAYexqxgwY65HtbGOF6t6wogCl/5i+ZjPlb32uS9dgTN4BtOmjXEvPvAb
 kmfw==
X-Gm-Message-State: AOJu0YxPGDP9illZ19dVAZlhkmfqJP6AQVhDINuiJIt2W0xkR1IpZFjj
 ldMbTWaR0Ud33F1OVgPKzeBe9QiXJJ88PpMYink22zafJ7FWmFpXbDc5YNbH/XEtH5n9mulmAB8
 3aRmxJ/Rl0QQHBN1CZT/hNa36w6M4VTNXPQ0=
X-Gm-Gg: ASbGncuRTaWY41Op11l+KDUoU9ADFb9kzwzwYXlfVvz/mQG9HUcc0VTfoJePcjVQqTw
 81IVw9Fif2vnrq7IbM6fekiG20HChz4v6MeYU/g==
X-Google-Smtp-Source: AGHT+IHeeWsTaeQ/1kGWtJUfcO0Y6JDVlvfjWYsCQXG0pu+fMoAIlKwvATtvtNTbqJtYzIfDtFjuKPbkc1vp5APvWnY=
X-Received: by 2002:a05:6e02:2169:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3afee4ba0a7mr116291195ab.10.1734314232855; Sun, 15 Dec 2024
 17:57:12 -0800 (PST)
MIME-Version: 1.0
From: Jack Andrews <effbiae@gmail.com>
Date: Mon, 16 Dec 2024 12:57:01 +1100
Message-ID: <CAJvHTNwvmDH8L3x8ujcbJLR4=dXsGb97VmZ37Jm2ZMWLaC67rw@mail.gmail.com>
Subject: running u-boot in qemu-system-arm64
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 16 Dec 2024 05:36:45 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

thanks for u-boot.

does u-boot run in qemu when emulating a raspberry pi 3 (or 4)?

i'm running
 $ qemu-system-arm64 -M raspi3b -kernel u-boot

and i just get a blank screen

i built u-boot with
export ARCH=arm64
export CROSS_COMPILE=/usr/bin/aarch64-linux-gnu-
export CC=gcc
make rpi_3_defconfig
make

i also tried variations on qemu like:
 $ qemu-system-arm64 -smp 4,cores=1 -serial null -serial stdio -M raspi3b
-kernel u-boot
 $ qemu-system-arm64 -smp 4,cores=1 -serial null -serial stdio -M raspi3ap
-kernel u-boot

best,
jack
