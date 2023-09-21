Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66118CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E100B86D56;
	Thu, 21 Sep 2023 03:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ZgMWAdx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E128C86D78; Thu, 21 Sep 2023 03:06:13 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C3886D39
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d818d4230f6so591545276.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695258365; x=1695863165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2tv74uNY73uBgnpl4ZCRlwgXBDlpkVxpA6872nXHIqU=;
 b=ZgMWAdx8DHN1xOwAeoWDF11GLgmym6kf6Ogi12Uxon4GBkAsp7+RJsAIO5dp58E0jg
 Fuy6Nm3/e7iHR8se9Unj6jC2Dgg1gi/dKFab4Q1mH8iyu7H8Q5p8bDGA9HnE8OcdD0FM
 0RMdRMJkT7/S+GeSF8+JSE8LauXEt87hRB1OOCrOZ8+cYBjQSE1ljPBjd6wkuQ3ojDr0
 c1rr8cS1zimrozva+lmo5TBMdnpZ7m8haPOVzPqx1abQmhsKiyMU+hqwm6sgXu8m5mIC
 YPcEdP7ZfbepJIgti22vvMti5pVkKHKuCsJv1tJACwGd0PB/F1s5tShdNz50uhCwESdg
 iTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258365; x=1695863165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2tv74uNY73uBgnpl4ZCRlwgXBDlpkVxpA6872nXHIqU=;
 b=rQx7l/wAcVxnEkixUcgIOkRDswtz+YmCtsPKNjtjhgZS1TCWUsCv7tt3xaHHxbN1a7
 HwquwmPhf85giY/RCur95Ij+SZVNAvDbTD9ojcMqWHXpQwjfsAxSj646fQs0zZff02BK
 MFda5Y/6c2RValw0iqBlavaU7kH8hY1yAWaqpXUcjtb9QP219Fu5xfQvVQWia/P8kDgr
 rKZgIcObUgWSI5CR/qz3aNj151yXWumfk0MI2PEX6SL5YZ6OUmG1Ci6Axl7mOQrq2kDm
 aId+lNTjpeSfR+YLFDXL73FuRbQFGnKlhPKtEH/uP1ochZzGtvZhM/P4xH8xPNuK7ZR3
 IIyg==
X-Gm-Message-State: AOJu0Yx0+yG59N+vX1HlL6g+5h3w0U0/DlFne4GsLp6BjOtn5kqUmVEj
 5I8sH5a3hifiuSilvxHWdHBj+EwxYgnCXE1vI49aqA==
X-Google-Smtp-Source: AGHT+IFBoZ8SD+PcafMZ3MAHDM2E3eEAEkfDKoqfeYno+wqyF9iN0HGw6huJGUOInX0Fyk+k94ufg5YkHxCjXdzWq9o=
X-Received: by 2002:a25:ad4b:0:b0:d81:c512:e542 with SMTP id
 l11-20020a25ad4b000000b00d81c512e542mr3885076ybe.31.1695258365378; Wed, 20
 Sep 2023 18:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230911163536.20735-1-avromanov@salutedevices.com>
 <20230911163536.20735-5-avromanov@salutedevices.com>
In-Reply-To: <20230911163536.20735-5-avromanov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 20 Sep 2023 19:03:21 -0600
Message-ID: <CAPnjgZ0mAg=V1R6L126Qs0RjcjZHuodqGM5puZa1LN0_umtJzg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] sandbox: add tests for UCLASS_SM
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, narmstrong@baylibre.com, 
 takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, post@lespocky.de, 
 marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org, 
 jh80.chung@samsung.com, paul.barker@sancloud.com, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, kernel@sberdevices.ru
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

On Mon, 11 Sept 2023 at 10:35, Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> This patchs adds simple tests for Secure Monitor uclass.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  test/dm/Makefile |  1 +
>  test/dm/sm.c     | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>  create mode 100644 test/dm/sm.c

Reviewed-by: Simon Glass <sjg@chromium.org>
