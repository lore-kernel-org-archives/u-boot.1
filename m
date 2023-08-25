Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA85C83F05
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 23:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53E1D86B10;
	Sat, 26 Aug 2023 01:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tk+vR4+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A64A86B03; Sat, 26 Aug 2023 01:53:41 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E46E986AE8
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 01:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe15bfb1adso2197692e87.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693007618; x=1693612418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YVj0H2ZCt+Q5tHyM6jYljLBIjM0ywDcflTNrT/Nhwfg=;
 b=Tk+vR4+mKx9tFojXxNVtynamjUj95BqfpZe7/HB9WAeARNCaqRI1320o8Bh3mTYMnc
 aph/hOZ5nGtCScS2G35JaN/q/BtpleYuerGFxwZpSv0OgghuhAZ/Z3eTBYMRYjGaMIbD
 pixilWWQL597lkIr56Z116elY/Wn8fDTqMx+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693007618; x=1693612418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YVj0H2ZCt+Q5tHyM6jYljLBIjM0ywDcflTNrT/Nhwfg=;
 b=U5zHUQfb/h3dt4Z/8Q1WlWra0Hr6aM1aBvm5hV4U4D3pmnuq9tLmjnk065ANDv3Jkg
 PZvXYVa1HJhSmqcsGRnwIKtQr/14+LJBTTWpeXFuBqYN28XsrOZlf8rqp3tdOmwlnEnA
 4eQFPMMM9OF96fcgNMfqwe7jvCcgyonLYfXwv7JtnCsTQGDuOHwG79Bv9jTNDNYvdtnM
 Bkt8+JnxJXp8MBZVWt5WEdUSvtDxA4DLwLOMFBv+Xi23ovIWzsIhbM39yK8fVcatQNWp
 4ipkO2s2LY1fu8b7jeTvwoYPHi8g0hYv8i/m3mMnDbVTGn07soCEx22VIsW3YC9nZ22p
 dd7Q==
X-Gm-Message-State: AOJu0YzoiJok4nWIH7Z9VijUGunJ+7pCevZ9CfsQJqcRiA5RQalQ4nXO
 Qs8Sydk9+CP2hMie0KBE4jN4trCH4LfeenTzqBebrlf/ZYd/FVbRB7U=
X-Google-Smtp-Source: AGHT+IG1yWFNqkG7CYUcDMW+ZDWCV3IOKmvmhVA4WsNabNK9ybkQgo50HGsT/H06s2AqMkrmY3PGJCsgTvyzmJvizfI=
X-Received: by 2002:a05:6512:34c6:b0:4fe:1dc8:7ec with SMTP id
 w6-20020a05651234c600b004fe1dc807ecmr11606381lfr.37.1693007617940; Fri, 25
 Aug 2023 16:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-7-JPEWhacker@gmail.com>
In-Reply-To: <20230825193830.2753640-7-JPEWhacker@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 17:53:25 -0600
Message-ID: <CAPnjgZ1BaAaQk4emYQswT3CVT0jRK9qtvOxavzi4cCfOzDtKbg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] cmd: gpt: Preserve type GUID if enabled
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
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

On Fri, 25 Aug 2023 at 13:39, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> If CONFIG_PARTITION_TYPE_GUID is enabled, the type GUID will be
> preserved when writing out the partition string. It was already
> respected when writing out partitions; this ensures that if you capture
> the current partition layout and write it back (such as when renaming),
> the type GUIDs are preserved.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  cmd/gpt.c                 | 16 ++++++++++
>  test/py/tests/test_gpt.py | 66 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
