Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0878C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 743AC869C5;
	Tue, 15 Aug 2023 00:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mRoC04jR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B3DF855CE; Tue, 15 Aug 2023 00:43:11 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BAE386A0F
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so6299963a12.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052988; x=1692657788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oat4Io33enYWzRReLSCNAkB+cJNnMk0r2C+cFV/NyJ4=;
 b=mRoC04jRx/FE0nNx+RbqsQttZDRfrWaMToXx3OBejqsu3YdmVfyk7vmR7dydSyfqJ/
 3ksrYSe9dNx4DEvp2aImrXZH70XD2lAIq1hFcC3QTZhiwUMyORqlUKWhbmgaz7rHtS9d
 meTa/iP2faaOWsbqCILd25TxBcEtBIgQNTKiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052988; x=1692657788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oat4Io33enYWzRReLSCNAkB+cJNnMk0r2C+cFV/NyJ4=;
 b=OIrBlocdZ3HDCsUZk63LqXXRa7O9MvHi2HD62HPsnN6O2xYKsWYwcbbDru0Ts4TKhC
 wSbd28nHpMjx106pRRbmilvpKu1pdPf0RWyR38Mf7GZu8kVP3utQo/yAaoHDQwq+tn+Y
 wF0kcDtNkRIzozFueVNKqWXnPb3NnUzqNUXT3/x4f7ZZVRmqCuYEj/xe94hESbPZZZht
 XUmc14M3lUq6zdLahB0raFLEKF6nUazgT2lMAAAj/TH6pJki4eg3PaojYYNxv7nLcFEt
 0FUbupRksLOja0aYZLLFs0ezb47OmotLdO1L14tSUbTm0SPgG04eSVMgFFAaJVsr2mtB
 KfEQ==
X-Gm-Message-State: AOJu0YybB1nn1cxLppjSEfZhUrjv1zPgdQWGWFyz+HwIS50g91exKwnl
 uVluovC5jtz0WVaShVvQPKp68z1jqMPoF+mFcAtMZWGVJyyphUYF8D8=
X-Google-Smtp-Source: AGHT+IGSkuYUNvTEC1Tpr0E5ZNIGZN5smrn/fbROppW98znEq598xh7EcQwjKhNoFGs5W9adFphZYQd+ZaCi4lKIBkM=
X-Received: by 2002:aa7:d054:0:b0:522:ca6b:ad7d with SMTP id
 n20-20020aa7d054000000b00522ca6bad7dmr8191898edo.9.1692052987942; Mon, 14 Aug
 2023 15:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230813195150.159499-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230813195150.159499-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:42:53 -0600
Message-ID: <CAPnjgZ2VQGOT6qTmV9SS1ngiS=uYpwBCPrH+t_a1ube9cm5BXA@mail.gmail.com>
Subject: Re: [PATCH] configs: sandbox64: Enable PCI register multi-entry
 support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
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

On Sun, 13 Aug 2023 at 13:52, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Align the sandbox64 defconfig with sandbox defconfig. Enable missing
> PCI register multi-entry support. This fixes ut_dm_dm_test_pci_bus_to_phys
> test .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
