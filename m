Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD467CE835C
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 15:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 137D988E3F;
	Mon, 30 Sep 2024 17:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Jkbz9lrL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2269F88ED7; Mon, 30 Sep 2024 17:46:56 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1117B882EF
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 17:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cd74c0d16so41999815e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727711213; x=1728316013;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=37CzbMGj8CDjHa7Zg8dBs0EbztjUXJe3UPmcqQ1LoY0=;
 b=Jkbz9lrLKL4tEaKz5LdHgwCp3P41V1ti+6gbOteYgjVNTZZ7lvVYn6aoMmcGj4hq70
 8+qqhuzJ+KTh005TQoSJ2sqt8yYlqrj8pz+f10pft8K1K5uI+tftVA9qyHHPk5kUiT/R
 Wz0QugdaljHqk6kyyhKLps4eKzKGrHb8DeJOwoQ24j1hHnJbSO4GlTENWAgUgzJsZ0TJ
 6VKYGP92RmFdCNeVxuwEWwueRtlxEaWsXKcfHa/HVft1CjHpq9VUJ4X4pJEvPk2k6MjJ
 R1DfnbJe80pmJTtz0qOlkMECntbZDArELHBk8uvh1jyCDDQQfulDUyNfMbHVpRzCK1eo
 4YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727711213; x=1728316013;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=37CzbMGj8CDjHa7Zg8dBs0EbztjUXJe3UPmcqQ1LoY0=;
 b=V6ZpLa+J9f3tSCv5/1N92gO/Uve2sF7+qN1VUaxJYArJ1d72rneV6GzYNyR1g9hE3G
 Sk0D6P7y1hJdVYzZoWLy2xHKKeN/s5siBwCpuu281kHb25rmbLaldqcgTTKX1EzfysuH
 s6MYItBwMl3GUtjsnzM932FLbGmlnfVwhis6/xvxazmb//Y/u9tJFiU05ukZ3V6njzN0
 slbPmvbsooS98kpM9HxTEihCWe9p92L61QtnZgUzoCe2husIDWHegvYjhzVbnO8oIwj0
 eNG3rqjDLKj1JvZp+PsKPEkSxHB5Crg1UW/iVBG4zaiIwEHaXmgCP77xs1eAXBTaWMhi
 TWeA==
X-Gm-Message-State: AOJu0YyZ5GK8a0otHdnx0EfVzfFWwT4BSmkTJ5hdYY1CTOnIfNGxgHSb
 u/hjfG7teGQCSgNUyaql1Oy3NakQ5+XnvGgGPtYjgz9z+R7oJfFc9KcSX/55LfU=
X-Google-Smtp-Source: AGHT+IEWYW6pOcKbyR3SIv736lxadNFzN8cZlOW525HBZOrxCNyjKZgpBkZd3/H8twf0nMLR+ac/VA==
X-Received: by 2002:a05:600c:4454:b0:42c:b95c:65ba with SMTP id
 5b1f17b1804b1-42f5840edf1mr88378305e9.6.1727711213490; 
 Mon, 30 Sep 2024 08:46:53 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a3622bsm153900185e9.35.2024.09.30.08.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 08:46:53 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 lukma@denx.de, marex@denx.de, rogerq@kernel.org, vigneshr@ti.com,
 jjhiblot@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH] usb: gadget: cdns3: Fix missing cache operations for
 non-zero Endpoints
In-Reply-To: <20240930093407.2998969-1-s-vadapalli@ti.com>
References: <20240930093407.2998969-1-s-vadapalli@ti.com>
Date: Mon, 30 Sep 2024 17:46:52 +0200
Message-ID: <87ed51m9eb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Siddharth,

Thank you for the patch.

On lun., sept. 30, 2024 at 15:04, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:

> Transfer initiation and completion for the non-zero Endpoints are
> handled by cdns3_ep_run_transfer() and cdns3_transfer_completed()
> respectively.
>
> Failing to flush the cache associated with the TRB Pool within
> cdns3_ep_run_transfer() results in the transfers never being initiated.
> Similarly, failing to invalidate the cache associated with the TRB pool
> within cdns3_transfer_completed() results in the transfers never being
> completed.
>
> Fix this.
>
> Fixes: 7e91f6ccdc84 ("usb: Add Cadence USB3 host and gadget driver")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

