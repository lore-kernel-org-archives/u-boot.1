Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A4DCDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 16:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20CDA86FE6;
	Wed, 18 Oct 2023 18:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WwTn3LJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C71B86FEF; Wed, 18 Oct 2023 18:10:20 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E04C186FE6
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 18:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9c53e8b7cf4so442589966b.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697645414; x=1698250214; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QDUABld+oErSL1NTVc85zrfDq0tlHJkeeIw4rz9WLEc=;
 b=WwTn3LJMQsYZLISveJZwEzJ/1y0jLKtq1jbdYqnN+y/fMeV5HoX0MRi7GHzpTIrC6v
 6BrfRqSmoSthF9GdGwHxDnZ1TN+gHwHVKju9ycENmKRiMFfRKaBGd1qiUW8c9rqP0zbM
 lZV+MFXKbUNMAEtivdo1NsxgHfJxY6rTZpLik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697645414; x=1698250214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QDUABld+oErSL1NTVc85zrfDq0tlHJkeeIw4rz9WLEc=;
 b=ItDONtcFXLZl1m0TnGSfZwl/ABKFYDfgYLUYbKIc6DkZyaatnE9Ligryvc6fZCTNnP
 MC0jnLwobTFPzssCwRehIHPX9D/flQok/IOcCD3yRJvvuP7SuvmXbWQs3Q9vljoVsBz5
 ntu7CNuPH9+agydDcKfN8HdpKkd0gkZrzW2INDNpe6vrjU6dMUY14sLqMHAr1TtvJnVW
 l16z70y4Vz6YtJdRTeW3CC1RDHE1lQLER8wp31Qa/rnxUQSIQHMLdhHnE0grBF1kTbHS
 Q1nzJ9VdNjKAG/1vQNvE4DQwVCjV0Qfr/38x77VSQiy0sO9+QWC62U9LPIwtO3UHzB7n
 dkCQ==
X-Gm-Message-State: AOJu0Yy2iQQnVfIAXPNUdCQIwadFx/odd6ZldYn6poZUBXSoaH7oPNrV
 9K6KWt7ltTakC9HStyXjLL0tvdU89glPkIsrFfQS9A==
X-Google-Smtp-Source: AGHT+IFGhgDhqliPTEI+TAOu2lJDV2pSYWaxqwouPpvHdl1MC0Mif4vAnloJsE+DkaYP/N05m0FnxNKfG4yAG41EPao=
X-Received: by 2002:a17:906:4784:b0:9be:ea59:1457 with SMTP id
 cw4-20020a170906478400b009beea591457mr4598714ejc.40.1697645414031; Wed, 18
 Oct 2023 09:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
 <f0a3eb7e-b0fa-33da-c155-f26b48d4fcaa@gmail.com>
In-Reply-To: <f0a3eb7e-b0fa-33da-c155-f26b48d4fcaa@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Oct 2023 09:09:57 -0700
Message-ID: <CAPnjgZ2CHtL_BScQgj5LWxX4+b+S5Ss+MS16kpXqhns5zm1Ozg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] rockchip: dm: prepare rkmtd UCLASS
To: Johan Jonker <jbx6244@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Marek Vasut <marex@denx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 18 Oct 2023 at 08:00, Johan Jonker <jbx6244@gmail.com> wrote:
>
> Prepare a rkmtd UCLASS in use for writing Rockchip boot blocks
> in combination with existing userspace tools and rockusb command.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  disk/part.c                | 4 ++++
>  drivers/block/blk-uclass.c | 1 +
>  include/dm/uclass-id.h     | 1 +
>  3 files changed, 6 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
