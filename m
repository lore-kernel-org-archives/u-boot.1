Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B99C5AC67
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 00:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56E3E405CB;
	Sun,  9 Aug 2026 00:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dOMT6XhoQDiH; Sun,  9 Aug 2026 00:34:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6379940592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786235675;
	bh=o/HrqCtjlHfLk63UR+GSg9DwLEjplofkxsY1MYBmFjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bRSPSw9j53qESMEwOwu3DS86hXw1IDeZcy9cfUGozWkWP9a+ViiDXLIy0c0bKjnsN
	 28b8Y0DFZUW2vIBv1PxTdt8lAq2xhqJnNekaKuZEpTwIWLlGNvOZ8lSl7zTg0TGPqA
	 zA6AlhtMUGdFUAxM+270aYhQCZkAiAijCPdevUQOdcTteXnmqkUfZx75a2fOcV+VGk
	 TrskREsT7/c0fwJ8L++AM5xzn4OxIhyW+GKPG5ZA34dZnyalViVW+vwaDMmRz584KI
	 WGe+/9mVhu6QOQYAIvlT70synyRPVk0+rwOJZuzxbXQwqjTez8DI59j4QBz9ZO9Emg
	 FdpyVu50lY9Ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6379940592;
	Sun,  9 Aug 2026 00:34:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78CD5218
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 767C760617
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EPLOzKzUtEwj for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 00:34:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 87CAF605ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87CAF605ED
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87CAF605ED
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:33 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so1025472a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 17:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786235671; cv=none;
 d=google.com; s=arc-20260327;
 b=CXekmY46sL+5fuCjhUaFqh2qKsgsbDusfVTEAjx7TKZqRElazoIxH+W8yqgDf2EmYv
 mQNA9IFu+s8wX8l8BgxSsaLeF9xGi8WlpAGrnXAvY9jUurDgKOlGMp8iMVKdORarZ6gI
 Z0h0LQyt1IdDFP4qKsr9ZK5qcjPq/ls6mkw9ZAxyJXxUSFJKoSJ+E3d0m5oYkpaBWsk4
 XmzK61Q37/j8znCQbAUt5JAuKTiwdurMahVqZpUsGI+xUX9yLQ/ncOh00oC2Gtz4Olva
 4IuDvOY0k1mR4jORZb82O9Qp6/nquFaGHqnS2Evzf5kUOh9WkHvkRVfw9UGUGUNsfy/o
 spcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o/HrqCtjlHfLk63UR+GSg9DwLEjplofkxsY1MYBmFjE=;
 fh=iUrA2NuR1GxEAnNccmNCli7N3qsfjYrqK1UwKunY5oo=;
 b=HpOjjZdtRnDSzrGAO6mLCTzbrtLvxv+xN7NS//jbH/2QgvohXWxQJmRhlaqmcQNQs4
 udu/WB9inlh2H65VP7R3gIAWKJx9CFoKeR5KSuzJ74EF699HWElXQGIbwxeifOEGAfSN
 /D7TRiRKIZi8+A8kiL1ex/fos6c3l5B0e84TC6Z0siXopMyOiwYcjoCiyOX+ZGPsO7K3
 1/n0wDJU/5F9g2hZWBDAd4Bn8h9W93fU9wD7EfrPkLYghcwXa+Zax50BX7o3oWBYnd5y
 mlNUvIDjyg7W9kzuqSvBPtloBaNrBWUEtDEP4/bfCP9L1f/LJzW/U+4QQdZpAPNWSXCE
 M1Hg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786235671; x=1786840471;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o/HrqCtjlHfLk63UR+GSg9DwLEjplofkxsY1MYBmFjE=;
 b=oLOL3N3Ww4zeGgUW/2v8JHf545orufkXz0EKepY6GBknGbl8+DqGw/Ng3Ogm0zawcl
 9CXU+XbPVYJPAJTE6kzlCZu2fIgoE7V3O01Upa9SXfS+yhNpg3D2H/ORO4lryW+X4w7k
 184ZaBHzr0l0prmlJuBkU3C1wg3aRywWiw/L7RdfN7pQYNahouGxuZtwCHFmG4ZI7q02
 qP+EQLTF4Lgsjjyc7iw/E7wQfRudduspCjxw3RRmzH9oxyG94iMEE+aZufNEnAYWT0Ca
 4YUC/dYlx1EfQ7/5oDnfoJFuxIzIunYzS2SUig+Z0G7QhK8ttiiRYHz1TtEajyc8RyR1
 T9Pg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXyICYxqFMTVuAt6tmIJzJWi0Xl3p1CHnD7kmk6dLaG2Cf1blxjXw3QwR4gwyEBQwd1zmsHvQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxl4wCyRXEJ7gY9UmG9UOoqRVpqiw65cjm4sxz7x0r2CYN+s6Uv
 L47+Ow8ThOPvbUuOtuT1V0vhqt5onbiyNzKxdZOcCmdEeqSbbRh69ReIiQLmy7y4Pcmvvnt3jSq
 Oo4hVTLITFNHs3DlP11OIxDs3uZ0+om3oBr3+64ko
X-Gm-Gg: AR+sD12nDUA8NfzQ6NJXuy/MPypMtITenLrlVyqyUUqK3grZsbOoDyo17DptNxvhwbK
 RxG8T1LkMjMI7/94uhZS002XyA9kF04nO5PvUormMeeSUIvShqy3MdDnRPgJUGTJVQLOHSRC7Oy
 09TRRz+dj7GZutUGCNfEeUlRPGS1nT9hBpG78oqrS3wx7va2ZraGPd/hL8GKggpxBYj5Pzk2c8o
 uGnaNQ6kcT/mX/KZjouFJ0Hha5zBTGET3BnwYlA+m4yV+3YvYCs6B5eNkMo0smwiwja8G398Pqv
 mKKvLBKmq5PPXlU45PVAy/VzFteGMDcBBjeYvZWWneg=
X-Received: by 2002:a05:6402:5107:b0:6a0:c9bf:2023 with SMTP id
 4fb4d7f45d1cf-6a14f14c0b5mr15378440a12.17.1786235671607; Sat, 08 Aug 2026
 17:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-2-jonas@kwiboo.se>
In-Reply-To: <20260803190946.2259514-2-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 18:34:17 -0600
X-Gm-Features: AUfX_mzH1Xk3vfhqXNL0cZmNekuMhvZSX1MBCsrtzU1DjogOoZqf1MgkuynhX-w
Message-ID: <CAFLszThqHknziYB+h7MechMvfZq2qUY=Rg54gbkSE-tvwHgTJw@mail.gmail.com>
Subject: Re: [PATCH 1/6] rockchip: rk3506: Imply OF_UPSTREAM
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786235671; x=1786840471;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o/HrqCtjlHfLk63UR+GSg9DwLEjplofkxsY1MYBmFjE=;
 b=G0Td7lBUZNkXAwqinKe3tU8gUdpm/pTRw17z16qqK4OmALQ5wyIAbLk1+uL0WM3FpY
 zw+SBhEZehC8ergkqebd25C0diPJpcbjLqb5RUd/QCYC0ECFVbV+reLtzlScTQuW626N
 kXRJreocAfZilh6EYy5PO6/u8Qf5RmyKy8Jms=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=G0Td7lBU
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

On 2026-08-03T19:09:38, Jonas Karlman <jonas@kwiboo.se> wrote:
> rockchip: rk3506: Imply OF_UPSTREAM
>
> The Rockchip platform typically require new board targets to use
> OF_UPSTREAM and board device trees from dts/upstream.
>
> Imply OF_UPSTREAM at SoC level for RK3506.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> arch/arm/mach-rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
