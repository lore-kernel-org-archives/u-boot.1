Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86242C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DAFB87C37;
	Mon, 29 Jan 2024 13:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OkljTSdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9438287C9B; Mon, 29 Jan 2024 13:07:21 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A494877DA
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dc22ade26d8so2187343276.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706530038; x=1707134838;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fdey2SNi9ypVkk7NpUglkMKuNyZMA+hzkultGcfWMQY=;
 b=OkljTSdX+Dm7L5vrTxv/2pW5yOBS8ZsqsUtQPeJmwnNwHov9RZyOyI+nepEJcUj7lt
 tBQo8aWo2fX54OC/rK1NPvtiJMueucRo4rplagkQ1+BA6OO3jvKIGxPn2VqB4zmSBZCa
 +VN7mZnc+j02JktqjXAKmxcHLLsJ0AuYgKkzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530038; x=1707134838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fdey2SNi9ypVkk7NpUglkMKuNyZMA+hzkultGcfWMQY=;
 b=AzD3uDUe5KkNrTzlhTv1L7ik6OHbYM0jNaXyS8bCKPX7zCjGolR1mOq+18Di5q95Nw
 jI1LvQwCaY4o5XgXR7tWn5CspbMs3UdBLiir3t9YQrtjRqLHGq+I6xRix3NI/asNyKeQ
 ZobUXzjV4lDlFFU9t3ceevxirSDgjFacq4RCaP7bBi2fbfQbxsHVQm2WB4ISRiBWoyNP
 ZaZm8rZ1jmjjoytXFuezzQr0mXJl472zdZeWKlWxHsjzn0CpiymLHUGXNJZQQeyby/0X
 K2Uf1qhPZurVXE45V/MCI/7r+gMbTFSfcNxTDO5gAWRh0K6ZjwHNmAUAwqKSIojE6583
 fXEQ==
X-Gm-Message-State: AOJu0Ywy5DlxHGFwHZW3G1MxU6GbRutAsdH1jKM5qvg9v/oHgySqMfd6
 xTTbk9jslVJxbfaQ9GDYl/YHfeYaRgSxpjK5VsTOc9w5mH53UJ8chfhsRZauKbch6oQldDWf43c
 I4hysYyXsEIn1GHC18dC6srOdFKMdvIfYhZGMeg==
X-Google-Smtp-Source: AGHT+IEMUfHpwVKY+CJI8nojTGL7hmMAyJqQiS3N8tTAAEwuQqxnL96zaSFLwl2GyGfq2QnFCtCeE21+7Gf8tcDbT9Q=
X-Received: by 2002:a05:6902:2388:b0:dc2:5573:42df with SMTP id
 dp8-20020a056902238800b00dc2557342dfmr2394631ybb.25.1706530037752; Mon, 29
 Jan 2024 04:07:17 -0800 (PST)
MIME-Version: 1.0
References: <CAMty3ZCo4NyOo8c7Msn5Ub+B7eTA-MEoFXh7_jeFPVUvVWMyPg@mail.gmail.com>
 <20240116053834.3628-1-ssunkkan@gmail.com>
In-Reply-To: <20240116053834.3628-1-ssunkkan@gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:37:07 +0530
Message-ID: <CAMty3ZB2A9gZtkMX-je6qovq6r0GBhyG0NWX+y+PeoDw3=02DA@mail.gmail.com>
Subject: Re: [PATCH] Add XMC
 XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
 site: https://www.xmcwh.com/site/product
To: Ssunk <ssunkkan@gmail.com>
Cc: chiawei_wang@aspeedtech.com, u-boot@lists.denx.de, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jan 16, 2024 at 11:09=E2=80=AFAM Ssunk <ssunkkan@gmail.com> wrote:
>
> Signed-off-by: Kankan Sun <ssunkkan@gmail.com>
> ---

Applied to u-boot-spi/master
