Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A88EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B4088E06;
	Thu, 12 Sep 2024 03:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gi95mNLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E024688DE4; Thu, 12 Sep 2024 03:01:18 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7BF088D09
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7d916b6a73aso300985a12.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102875; x=1726707675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qyJTlgO80SaknR9GbAoI0SteQQ6JQPddLbHq/4P9OX0=;
 b=Gi95mNLtKJmiPmc28CHEBAI92th/5JmypTEMXVJQ9ZADqkGcXLAmcpIH5d7+gfWwy4
 FTfUTBvAwt7jzziYkOQGuVzLiEZwzse9YG7mPp10c5S9UHXlTUwGfjat0S2Lrh9K7apk
 PPl/qVVRFDgQErcXMUsCEePGnh1HSPzhiqm5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102875; x=1726707675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qyJTlgO80SaknR9GbAoI0SteQQ6JQPddLbHq/4P9OX0=;
 b=MFMbVMcfpsunBdAJXW7NMKfortPKHfwYo+XvuyUZdU98IAfwefojdFi/qWYKSY4qi7
 8nalAyztXudpFp71vz3UXgWVLCdrZEYJEpw7hunDSKvIk2UBzlMp06I6oWRJVJ2pUi3p
 VGMaWDBdGI3Knq/I9ekLPY0lsFOI+jB69NEIoXjZbDwkLXEKckEkehW+m+OqQi03hBhQ
 NkKVu80jhyrjX3OLXyR26IDx0S985e6WnSyDtxMQ5ZaLUMFn3m2J5q9FwZHkoPBuj+le
 1GaPGalEv+FVskZ30Ygpdw42kYpol5iazAfsh5MJBaIKuuldeA1KdEwxG7WYBN7z1INx
 1bkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzfl6zxhUXl275m3OQ0vTxkcmzFRs9MIIg6fEW0P/41fYlEvrVpx5ljfgIhI09ePJ0r8QEomg=@lists.denx.de
X-Gm-Message-State: AOJu0YyySmVXFKwbk2J2TIrAQVybZeNWHXue9ct+/1x0+nxT5edIcyK1
 etzr+IpN4S3wtCGOYgJJbn8jjrCCAKb/jUKcC5L6PGO9BI4sudxVIpPYNhDaLRoCGJ0sdOLk+1W
 xSgrl0vYAylIBpHufA8oY1Fxhn/VcAYrJyww/0ErEPo5yVes=
X-Google-Smtp-Source: AGHT+IH7aCSUvIfDri9bW8SeDh/M5/bNMrRl9OkdsIX7+U5vRfBKDiCJTh1QCHA4K4rAmoTAnvP2EWzeBPGJv9qm4HU=
X-Received: by 2002:a05:6a20:d80a:b0:1cf:4ad8:83b9 with SMTP id
 adf61e73a8af0-1cf76239a41mr1363787637.43.1726102874820; Wed, 11 Sep 2024
 18:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240911214945.15873-7-ddrokosov@salutedevices.com>
In-Reply-To: <20240911214945.15873-7-ddrokosov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:00 -0600
Message-ID: <CAFLszTjeYpMMWzbn=tEfbzTeSQXucY1jZ2=hwyWXjaM+G1WF4A@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] test/py: introduce test for ab_dump command
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, 
 semen.protsenko@linaro.org, trini@konsulko.com, colin.mcallister@garmin.com, 
 4.shket@gmail.com, avromanov@salutedevices.com, u-boot@lists.denx.de, 
 kernel@salutedevices.com, rockosov@gmail.com
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

On Wed, 11 Sept 2024 at 15:50, Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> The ab_dump command allows you to display ABC data directly on the
> U-Boot console. During an A/B test execution, this test verifies the
> accuracy of each field within the ABC data.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  test/py/tests/test_android/test_ab.py | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
