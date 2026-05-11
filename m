Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5BDCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF00983E76;
	Mon, 11 May 2026 15:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i8x5/P65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 249DB83FEC; Mon, 11 May 2026 15:08:42 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54768838BB
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so674173066b.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504920; cv=none;
 d=google.com; s=arc-20240605;
 b=ERgdWbCzP57lZSbGEQGqJPYxWMvs9XKmm7pxkXSTjISrVckirUsvRhQiftiJK1/Fo9
 gcdknbKLP6dksmwvoTLtTBLC9T8tRwXwMe1v+PMfT775R5t8tkbsd9NYWRhbu5TF4JBB
 Yfmt5YnbYV+t+hOdhpZwAQf1M16EHqzBwFij6rU6FtWtAkD3ddkOBUT2sjJMqUrla4Mm
 0df05LliVJnCt231KiWAdq2LfJxRXTHmUfTKwn9iqcaPCX/oFh/Y91wFExz4qHfuF/YQ
 hZZXPs3dwwMfCB0kgfvZluLQoYlo4QH9p3yOsOorS8fco3qQjzjECGtfLoIFO/s4fJJC
 Xtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O8U83TuSYgY/fQeVqifZiWV77QrawOkCiMuYQqSw2Ws=;
 fh=DHWba/x7tuoorNirX1jlfatUYioWd7qRviNee1YRGB0=;
 b=kXvlcqDXVPlF3uJ4LJyXdN17hcECIG6evFPAK+3COhOpLIzpq5K7+42SyljLyuuidO
 nQIQ+bwU1oLcPqdB43fQ8xwp+9r4JTaK88mEZ/sy0/swqgh6kowE1TVXhBdXDByveBMM
 +vAjoBUzG751oKta0gmdzWXIqCexgkW34GRpEFpgF4Voy2e8ySPRTEAV2XX0be3p6qpO
 N2M/3/andMNafyCsqFzuPekIYj4DOwProhFLcqlYVn8YwEwuthzdaGpCyRa7Ws+rzKHa
 T4iqONSzm+z0Gnuh+E4CvWgBPnzswaBBr5JIGGgU8kq4w/q+MlXgWkAmvuNBXH9OajOM
 wkng==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778504920; x=1779109720; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O8U83TuSYgY/fQeVqifZiWV77QrawOkCiMuYQqSw2Ws=;
 b=i8x5/P65ykfoyXXFOIOh9DA1K7uIyYYMcM5iLFeM+SqLUGS3OzNUYwlJGDkemfMrDC
 IvPYDDdXRcgF7S13Po1Jd6tNNULl76yYKWtks4RNDGiFle/RD5MLTztq/ODhbRUJwsdX
 9/yKYSC+445M5m94EghWwWxRUlC8bdop6+xnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504920; x=1779109720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8U83TuSYgY/fQeVqifZiWV77QrawOkCiMuYQqSw2Ws=;
 b=kBMS0uUVQBwVD18XFSV3I6lwEiZQh9tSk+dF/B0LawGnZgaKzTVLpWyivfLJo8GP4K
 TaAhM88X5CpzGwabXL26cdrjcYE82dVmjkVNjy32YPEfIn+AjDqocgiBuddMyw+Oz0tq
 jwTlenJ8xLGZJKusBv71nfeUfAcTDnnVY4Db/1meG0YKMjPSvxrGS5ceVNMB/YON+vm9
 OxQdMZ27G2yLTuERPC53zcvMK94Na8129968WS4TlIe1juHUQNFk5zBplRS7P2T7e9Ul
 M/e0BoHEFbal/ObNT3oHvfYCejrSHY7Ct4uvKfImJhwMpfZjdSyTDSNvAyX8NhRHSUhF
 LcxQ==
X-Gm-Message-State: AOJu0Yzq9mrj6NAaSbgSvJrn8RHXwrPcwPgUrbQxovzXM+42fAxsRO3p
 MWh4fIOFjh7xV/iQVtp72Ot7SwCy6DfiGb2x4Mj73zO/4Buwpb2NTujrlbm9+PaC6nfe6wyBIq/
 /XJQkjqgUJGegYZp5fUnJHPSlVK0d3u0LcaJsU+K6
X-Gm-Gg: Acq92OGluY+LcDWzHD9H1rcd05RAO28a+vIMu6i9FeJ8ebxkL+6S1tLMBam0cGaz26s
 3XHKjZipETvsj++gilvufm6yJOJmzeeA2zYbfTwvUNRKTGe1M3nMzpEZGE/Anolt7X93lZu3bkt
 IhxuJVyYzESTZaiYW9/1v82bGeQJdqe9HemLAts9vU3o/xQQIGv2ithk+03ya5i4SZtFFRo3KgT
 CKBw2DGM3Hc3ccOXorrzdceH63dIeTiXN7db9ceIHcW4/dytmDV0WDFl1gu3x5BOjnBD4O17tX5
 k8ArTKyHVeyrZ9Wd
X-Received: by 2002:a17:906:fd87:b0:ba8:2ebd:dfb6 with SMTP id
 a640c23a62f3a-bc56dd1a4e3mr1421983166b.23.1778504919642; Mon, 11 May 2026
 06:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-5-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:08:00 -0600
X-Gm-Features: AVHnY4KjvA5ZampNspxBjcd2q0UpZqguZR9EocP33VK-ZZKB47bmm5vCIgtkJZs
Message-ID: <CAFLszTgSpZO2WcBQVjS4Z-Wb87u=YrN97mjdBJTNfnEo4iGzxA@mail.gmail.com>
Subject: Re: [PATCH 05/11] video: console: rotate: Staticize and constify
 driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On 2026-05-10T17:16:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> video: console: rotate: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/video/console_rotate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
