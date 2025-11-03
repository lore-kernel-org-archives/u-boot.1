Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406FBCCFA05
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 11:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0826836D1;
	Mon,  3 Nov 2025 12:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kg81FWIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 144E383700; Mon,  3 Nov 2025 12:43:08 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0467D8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 12:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c53f916ef1so1197510a34.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 03:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762170185; x=1762774985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WOm0UVcUeAPCJEx7M1DlFwFNM/V7jiLe2bdyrZvjZ1Y=;
 b=kg81FWIRL8TOFcFgkYsq9DC3IEqAsAnZUaVqIUlljYl7QLyRjhKN4KYvU0ASCqSD7A
 VMd6V7/6QLu01S/jp5ShJ6eW0cXeKRxyEGyhM632W5h8WYvSc+MziFgIPJ0WRQ62bptW
 JNy6XHRsY517nfrHCnXU2IFFh2chrs2eKtTGLs55k84fMcekBLv5IuH7ZMjqI1LePNl6
 nUQ87CdoFMFVR1FcOCK5TvkWVJMiG+jTnQtDIXzgT4WvTageBdKY9QILcuXcLuA69zpT
 ExrBRZrF9v9ijZE5Dq6MdJX9knrcWGdkH7sxLtTB6j375YKF0AFenKb3P305JDdtCDb+
 JHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762170185; x=1762774985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WOm0UVcUeAPCJEx7M1DlFwFNM/V7jiLe2bdyrZvjZ1Y=;
 b=ArtpIbq9SWCy1TuzWQgTVmVvfhqzs+va4mpTscq1na1AJIx9CKqi4mlPp/gkSy1xG4
 Xbdqvu/5283yd+AXGmlOu3NVA72CT7QlTS0wzOtbkD5ozdfPt7KD/8rPHv4JjJh5rsFl
 TQoXyBAoJisnnXV6NSkyhAfbV102hTgn7S9TSINKvoFO0gRjDDSt56g9i+rKgcaNJmT6
 866ph4l1ffgjh+I0zcxNHZXxr772ya3kANmGtHjMPQQNoVTWVYTtNUgPZb/wn8UMSZYx
 MUiIjc6MxvuZp+jkDW3DJOFd4Si8hEk88yuFaNYBM2q/HluFMAv5RoDUWcgOyrTkg4he
 7oMg==
X-Gm-Message-State: AOJu0YzC54JrNfYkTvV4TRwB6y9IyvjtGKJ1VEVs8omj7zNuEqs/f94j
 WM1pCRTW/3/LDZSNaDvYvXLOCF3Gd/K0tq5A42OoKrlQlcbvbjaXQ5YAuwVCtsjjk14mYFl0uIo
 NVOqPMhg/7FmMh/xwMjXL2kGXjPGKXXTtweDMJ94VJA==
X-Gm-Gg: ASbGnctY2WHLvyBderuf3j0kAc3jJsRMaZ8mtm0xchc65PyfKKKymsGquHR9NItcgSX
 Scncdl2FRAtxyfnZJzw4BvdZfaXxcKuEkmeIivwJT/hj9lSJqs0xsA6K5Dnn7rnL3ChV8riZcLY
 nyHeNWmh/NVfPlvy1suoFt2U0kHuIGcPOLW8xtjI9hPq0KLbEQW8jdYykUzq72W0aVom/uMO6az
 qy9XBYEHipuJDRVK/oTZIhIwzgOvS1lOuduGJBz0ysDLOCXlVQZYy/s7SFMRA==
X-Google-Smtp-Source: AGHT+IF9HhcruDEmaTJFoQHRNigoxtWC5nQaQQkpv4tlxtG7JknQ1e2FN3fVkRw3TIVvkDfog7a0mzkicSXuWYPfy5g=
X-Received: by 2002:a05:6830:2646:b0:745:9769:ea40 with SMTP id
 46e09a7af769-7c69670f747mr8741762a34.12.1762170184666; Mon, 03 Nov 2025
 03:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20251101203429.1603832-1-jonas@kwiboo.se>
 <20251102113122.1038-1-briansune@gmail.com>
In-Reply-To: <20251102113122.1038-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 3 Nov 2025 19:42:53 +0800
X-Gm-Features: AWmQ_bm9tk7j1PN9UQcHIy3OjM_3HsizK9_tmf5l8R77q3vdMj0Uk9Kvq-iMDN8
Message-ID: <CAN7C2SC=371dZ+nunuxEHHEQqB44=FJmqN0_VZE6YFnHfH_Pvg@mail.gmail.com>
Subject: Re: [PATCH] rockchip: remove regulator enable from device probe
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>, 
 Dang Huynh <danct12@riseup.net>
Content-Type: text/plain; charset="UTF-8"
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

> With the change introduced in this commit the core gpio/fixed regulator
> behavior changed and this now result in unbootable boards.

I am not sure this is the case.
In order for the boot to start the SD card must be powered.
And the 0x40 and 0x4000 is then read accordingly.
So why TPL phase is not having issue aka it is not dead.
But only after TPL aka SPL phase to break the power
between eMMC or SDMMC?

Regards,
Brian
