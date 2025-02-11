Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB63C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 08:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFBB9806FE;
	Tue, 11 Feb 2025 09:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xcT0Cm5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC869807C0; Tue, 11 Feb 2025 09:40:19 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA5A80079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 09:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso13075035e9.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 00:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739263217; x=1739868017;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j1ZtkKsBEwHp3appNwTY06ht+JLNxyY5zsBVSlLZXJU=;
 b=xcT0Cm5zkER8VkIM00z453+EDjTAuXZrXb8DLFppcpjY2LpoA08JrJDSYMJgH3NCo6
 7ryqvrC1LdKglKqjVGYM01l0DlALLTvT0e70MUJJDcA5r9x74Y1lT2fpB/xblRtltlwX
 d0TBc6Xlg5Hs5iUNWhhb/U1FG75ZGVcnPbcG4/uKIIOO56pYToiO6hnxqzucNOIcojxa
 Lfv0ypKdhhDbRqTxI6vr7pMldR2dvB8ZJ1ZJFgkOMR0K0zC8K2nYElTyENKnRmmMD+mt
 LjU/jzeNUuamfY95ar5+EnaORunXVf+0eA2OKYLB71atk/oQnoRfN2Ro5K70JyM2PVHC
 TpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739263217; x=1739868017;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1ZtkKsBEwHp3appNwTY06ht+JLNxyY5zsBVSlLZXJU=;
 b=RhU5FxSD2HiXUUdDRys0kWZ6/68r7X2SA+nn8Vovq32FA6g93LEAe7OOy++KVdH+tT
 SiNcEzBI2DQGkHlNGnKp4n51+bVNbhdJzgQqPUHHMwHMM3/HkI4JKu08wda5sWeWmSSd
 6+pJlIuFz6c1kk49WEn1H70WeXmqCg7JrK6VE6VK6QHkdwCD+MZ4o8OWWSvH0lKSmKMX
 XsJWM2Iu6TeI1/zRz4Y6EWaDBQxNBzWd0/wSBw8zRLdzUssWmuOChyYTNnclq0do73dC
 GyVXXZVT6AL0c3vnu2Mivj6GdElwCNIEm38OjxmVJ5irSUdIPe1IS2N2VPwfN1knx5ya
 kEWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVJn7BYNgUP87l4lJ//drErq1w95ZHTB3AeJFIk754Qr/C1EQ7s8axhZcCsgHaYbxLn0iC0tM=@lists.denx.de
X-Gm-Message-State: AOJu0YxLRjG/JTSVOgbxjfnkgiEYeJC9PfS2yjRgiMKCqX93pjHKzMik
 X7J5eklinTHs/eDBorgyx90uXB6zoo5+G88zbaRKaZRJgIbYkbDu/LFlS49rtUs=
X-Gm-Gg: ASbGncui2lwmFnh5Pth4MHQlK2Pb8XYlpxGoGIqNQHXV0p+XnGpapFqoddYvMBkcC5I
 AOGJHYgZfI5tHvx0eSGz4+rpnRhn+76IMeJ9PkcNRmDsb0mOTEJzV+soIloxzF8BDd7ujTpbY/a
 V+2q1fq7VZ2XXHS3tgtRn1HEz1yADX//5SSg6dud8DeNVhgv7BTsiTJjirKBJXAQcX1A9ZT/iSM
 vhKX7suFyNPkKpmZ37oR0vv3FBM5FLLJdC3T9NXTogFdOIIYkKUBcEP0x6nJorywGr2jwOzL2Gv
 HLGk2+WwJ6nqM3I5X2OaRXku
X-Google-Smtp-Source: AGHT+IGyqOSjtP4i2Cyo9CIRZX+watFO8CCgfcmAeB15lRn0iKJ01Z2+KTBHVXcm+L5seyjq7Air3w==
X-Received: by 2002:a05:600c:4650:b0:439:403a:6b77 with SMTP id
 5b1f17b1804b1-439403a6d76mr80083165e9.10.1739263217223; 
 Tue, 11 Feb 2025 00:40:17 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394127afcbsm66892585e9.23.2025.02.11.00.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 00:40:16 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Caleb
 Connolly <caleb.connolly@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>, Jens
 Wiklander <jens.wiklander@linaro.org>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Richard Weinberger <richard@nod.at>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 3/6] test/py: Drop importing utils as util
In-Reply-To: <20250209160725.1054845-4-sjg@chromium.org>
References: <20250209160725.1054845-1-sjg@chromium.org>
 <20250209160725.1054845-4-sjg@chromium.org>
Date: Tue, 11 Feb 2025 09:40:15 +0100
Message-ID: <87y0yc98nk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Simon,

Thank you for the patch.

On dim., f=C3=A9vr. 09, 2025 at 09:07, Simon Glass <sjg@chromium.org> wrote:

> Now that we have a shorter name, we don't need this sort of thing.
> Drop it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Add new patch to drop importing utils as util
>
>  test/py/tests/fit_util.py              |  6 +--
>  test/py/tests/test_android/test_avb.py |  1 -
>  test/py/tests/test_efi_fit.py          | 24 +++++----
>  test/py/tests/test_event_dump.py       |  4 +-
>  test/py/tests/test_fit.py              |  4 +-
>  test/py/tests/test_fit_auto_signed.py  | 18 +++----
>  test/py/tests/test_fit_ecdsa.py        | 16 +++---
>  test/py/tests/test_fit_hashes.py       | 14 +++---
>  test/py/tests/test_fs/conftest.py      |  1 -
>  test/py/tests/test_kconfig.py          |  6 +--
>  test/py/tests/test_of_migrate.py       | 14 +++---
>  test/py/tests/test_ofplatdata.py       |  4 +-
>  test/py/tests/test_optee_rpmb.py       |  2 +-
>  test/py/tests/test_sandbox_opts.py     |  6 +--
>  test/py/tests/test_scp03.py            |  2 +-
>  test/py/tests/test_source.py           |  4 +-
>  test/py/tests/test_trace.py            | 18 +++----
>  test/py/tests/test_vboot.py            | 70 +++++++++++++-------------
>  18 files changed, 110 insertions(+), 104 deletions(-)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # test_android

>

[...]
