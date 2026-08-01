Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BA7C54FCD
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 04:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C60284078D;
	Sat,  1 Aug 2026 04:20:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ebV78HiFAeb; Sat,  1 Aug 2026 04:20:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 273B640775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785558059;
	bh=yTyUzQlwEdzMwCdU5mSDPx4SPAn5cEiOrEeVMi7HFZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c+vuR+tGGNf1ElGDXjiuJNI6ug9/qrQyhXFd8dFy4zE+VuiHnW/V8d40mu1iEYqoh
	 oQrAha1UQQ9En8f97nT2sEanjJMX8/mG6uAPWupqI9hwzoED1brdP153QhLK9yjBjE
	 ncL/RFKTDOaXxcDNrJiByJGyt2juw6MfRhXyKgW+AQ97UH4qP8m87ci2fqCzrLva73
	 AMZV4iJZ4NBGCD6N9dwy/h5Dva+HYxa6wgkfZT5VgoLx8KYSDxz6akdIZZzD5dnwO6
	 AvHo6rT3T14DoSD3gcaDfen6+Z03lfmli/not6Zk/9+V6pOdIe7s0BfoT0l7TnmN/D
	 izX0GnLhW1R0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 273B640775;
	Sat,  1 Aug 2026 04:20:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 26BBA3B6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 105AC60631
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MDNFjwYikmUh for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 04:20:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 286FF60629
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 286FF60629
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 286FF60629
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:20:56 +0000 (UTC)
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6682259cb3dso2792543d50.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 21:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785558052; cv=none;
 d=google.com; s=arc-20260327;
 b=PcbM2GM/y/X9ZH2Vi6u/FWbeMc3vQF45ZKWDLKRlKhcoGwoLi5d8QTqjo3xjjbnBwU
 gYIEX4b/nwmYzIZfnzGRoHV99IY2PfedOGIJrAuBveW86Rzyx9gHI3zrnlaCT/uxvNBy
 sRxjP8ao98yqNJF5ookKgGq6Zs5hyPxdiMUEbrVQDCvQFglKUR8Aa8WAGYXFNHya+aK+
 TF8gqogjyUriXqRj/tmR6SSqy5lEfZ+Z89S+5bgH24N6nCPdmJGaiL6bKwtlvFUbDgps
 XM1moiVGiEylZ1OGvprrJFTqvwPN0lD76qwSXvuGnsuiRc9b1+4DiglgLOyAX+Hrz2D/
 IBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yTyUzQlwEdzMwCdU5mSDPx4SPAn5cEiOrEeVMi7HFZc=;
 fh=992YSfiWnPUezw49ncjDygYgt4EKWyy4WaxzRns3kJw=;
 b=e1fs2qLOYhspiny79ddzOhrG7Y2sO9nr0QkU3GJBPvJdvl9lDs7FUucJm/qQsavHBE
 m6CrVnqQI+UfXjidEjvLkavWNQhzISYF3kOGWAWmM2dPmZ4ChUyBWDE5w6d02d2E/YSn
 IEO4+I986F40Z2sSqZdYNSiwTKeg4Zf4mSTXcyV2RQa/9Xg400kCJkGi8CjHh3/TzbZt
 lD9uQXHeyBB4juEdB7csYPDt2e8mYDQpFcOEf1xAQksOBPFsWfYnLybNGyIMob0g64yP
 9ZQ1o78K54Nucfe+P5Yvh16EvE2oE63/LekThkCzukHHbxERHkJ9Lv5bN7zdpN+ykEp5
 J+6Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785558052; x=1786162852;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yTyUzQlwEdzMwCdU5mSDPx4SPAn5cEiOrEeVMi7HFZc=;
 b=T/IXjGUD/K2iAxlM53M5l8YNM2QcJmKIwM7iHZwEwlm3ySCpDjMZTcW2Y7cgPHnuwm
 +Al9hu8aaVBdfpJX7IufTGEdRe6oafB7iPyhAIX7oALUz49OQY9WWOZr1wcRCa1DOQ3H
 FpZ1I66kh+RuOMJMjPU47yIOaJ7j2lS56INV5bNbv7ZcSZ1ieTkOSsYrdyT/DJ4Nl2xA
 vTrWp7rknh7cuQ/l3A3bCVlQau8zQu5vpoeG3baYGtXPZ1lej38CR3ovg9htfTHGg9F/
 nbT5mtpSTkUDlwf8U3hB+30VzlO7s+POTjFkrjFhB6OigkvKNHUQ5kbW15fCvaXn4eQL
 p/XQ==
X-Gm-Message-State: AOJu0YxB+PZajoTwwVu9xhu8sm/9OBXzpgc7x843dhJOl2R07UkX8BDm
 8ptLSftMySmoERsGb6r1LFBSVvOb1Zxw7X+lpAYsFUZoUHFxAz2dhngMrIJVgKuypKIQo0ICnHn
 maByiuBfIbSm7reuuNYY/obLPY/1lKvNjCftng89s3Q==
X-Gm-Gg: AR+sD10d9TWeEksRJ5Ab9epZ1MPLSgc7zZ9G9jP4JDtQzGGtgsjda9pAOM4g29cTnIZ
 DSmvEhfKMrmERIGbMrEZ0PQEpcWbsDMX0cZTMyEikJQv9DT+udLi99jLg9NzXpWFhLxoNgSfq0O
 quoK+3WqpWtuFlrcqLU6+eIj5Aa+utE9ga0Tqm3KQA3ru0CAXHV+uzavYd/FQYMzTPObebNwLfc
 AZqVXMUBuF7uQo/rQOfAUFsat5tWcpsg/ulmUh8Ypv0yKYALat6TP9Q3Bro4rypH5zIlj+rGlaW
 jNwGu807D03Ce+dc+zN6nVkUxRxM6iILAOSy37Z3D+3p5UJZUIX7ryDwhjUMR3GOELhIEr9rlOr
 LMMbpDfBTpU8cxIcrXUnFIqwavGNbA32o3Mj07STmCn58xkLzUHEl26iG/ywEzkcWD84xbLiyk7
 36Kexo6HzQiw3fBa2h0DZdkI1IQkytlFxo2aZ+12Q6bjklDPg/rmjtoGjuo5+45JGcJKDpUutJp
 kpxDZLhxQkLCmmjNUrd8AVSOUOEj4mpKfOipqgCyuatek/J/ENUfP+Pjt3iQLtFF5AFyYE/9xfl
 Q6SHqLrXkkgTgmXzVnDI5IEbzfjephYPEjFjHia5AHOJ322tdIo3vh+R/bQH7fEijZ4TKdu+Mk+
 ZPupKJc/F/gcdtf2TO1+75eANL2jOPkTno11VnZlL58n2iR8g1ReJQw==
X-Received: by 2002:a05:690e:4391:b0:669:1141:36bf with SMTP id
 956f58d0204a3-6694f8a9f1fmr2165420d50.11.1785558052408; Fri, 31 Jul 2026
 21:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260731201935.2542305-1-trini@konsulko.com>
In-Reply-To: <20260731201935.2542305-1-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 1 Aug 2026 07:20:16 +0300
X-Gm-Features: AUfX_mzLQ7-rDOcfLycEOBy-n2ogv8LoLkMdo5GRBMDk62FGdqPIWLm7iS2i5YM
Message-ID: <CAC_iWj+S-3zX1iyen9yP+AAqYapzrKrnRbHJ4+CF68QR5OuWFg@mail.gmail.com>
Subject: Re: [PATCH] Gitlab CI: sage: Disable test_net_tftpboot_boot on
 Raspberry Pi 4 for now
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Randolph Sapp <rs@ti.com>, 
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785558052; x=1786162852;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yTyUzQlwEdzMwCdU5mSDPx4SPAn5cEiOrEeVMi7HFZc=;
 b=N6SY70bH12uhB7f8ZaLVxFNXwn8NT1VBVrJ9sKqODL9ZHIEcQKSDL8kLBlqb7QG9zG
 qqUL5Q0qTg9a6Ay9QqxRKh+ICDIWzjMqtJlZ4OjweskpewCKq+oqjgJ0y1sdI1iBQbnu
 z52z3Qhtjf9Op7QElHvJrT12ZNldq4UrvlSD8Ae7FnrjJUGaC4X4ZE7m0WXyohbENtzy
 W0yHW/fK7I2gxGqgeMn8iWt0V2Ii7c5jJmW3KQdqe6aHSQ1dlDiSxDmDZBYer+KzorqS
 nFjqpIn6tZ3PB9LzPsC7DjZ4YlPR31/u9cfgMOdoQ/5RYYKneV835rNc8CrkprS1SZjr
 VQYg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=N6SY70bH
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

I'll see if I can reprod locally.

On Fri, 31 Jul 2026 at 23:19, Tom Rini <trini@konsulko.com> wrote:
>
> With commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
> we now get:
> ERROR: freeing fdt memory region failed (addr=3D3ef667e0 size=3D36 flags=
=3D2): -1
> ERROR: freeing fdt memory region failed (addr=3D3ef663a0 size=3D400 flags=
=3D2): -1
> on console when booting, which is non-fatal but leads to the test
> failing. Disable this test for now.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---

for now
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Randolph Sapp <rs@ti.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> ---
>  .gitlab-ci-sage-lab.yml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
> index 90f97696f86c..9e1c2378c6ef 100644
> --- a/.gitlab-ci-sage-lab.yml
> +++ b/.gitlab-ci-sage-lab.yml
> @@ -144,6 +144,9 @@ Raspberry Pi 4:
>      LABGRID_EXPORTER: "sage-exporter-rpi4-1"
>      LG_PLACE: "rpi4-1"
>      TEST_PY_BD: "rpi_4"
> +    # With commit 623f6c5b6ab7 we get "ERROR" messages that are
> +    # harmless during OS boot but fail the test.
> +    TEST_PY_TEST_SPEC: "not test_net_tftpboot_boot"
>      OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG =
-a ~CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST=
_MATCH -a SYS_BOOTM_LEN=3D0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_=
BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=3D0x02400000"
>
>  Raspberry Pi 4 (rpi_arm64):
> @@ -154,7 +157,9 @@ Raspberry Pi 4 (rpi_arm64):
>      LG_PLACE: "rpi4-1"
>      TEST_PY_BD: "rpi_arm64"
>      # DHCP is not being run first, needs to be investigated.
> -    TEST_PY_TEST_SPEC: "not test_efi_helloworld_net_http"
> +    # With commit 623f6c5b6ab7 we get "ERROR" messages that are
> +    # harmless during OS boot but fail the test.
> +    TEST_PY_TEST_SPEC: "not test_efi_helloworld_net_http and not test_ne=
t_tftpboot_boot"
>      OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG =
-a ~CMD_BOOTEFI_SELFTEST -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_B=
OOTM_LEN=3D0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BO=
OTSTAGE_STASH_ADDR=3D0x02400000"
>
>  Raspberry Pi 4 (rpi_4_32b):
> --
> 2.43.0
>
