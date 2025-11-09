Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8F3CCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 08:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B59D83EC9;
	Sun,  9 Nov 2025 09:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HH5DmhPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D5C83EC9; Sun,  9 Nov 2025 09:38:07 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71D6683EBB
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 09:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-63f976ef4bdso1661593d50.1
 for <u-boot@lists.denx.de>; Sun, 09 Nov 2025 00:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762677484; x=1763282284; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnMZgMyw2+3AVfjHgEkZm9DCWpsL5SoUwGFFOme7AcM=;
 b=HH5DmhPyusIeQZbd2vxEjJQFY1YU86tWDsDbsQvpwTpYfSIea9VC54q6ls5gFO8mAv
 jgMa/A5KOskOgIB1VgeOUIh8PTRDHf6bpyWSKYiGbZWcGC9b6fSF6ACcGta/icDpPBzf
 549ZaERFV+dmKib7FieEjHV3HWFcYlta3Epvif3UxXLolSbEHoXNNuD8y08QcNDVyxSI
 7H0rcqI/uaEhZEHl6iwrI0GJJ2ui9ujk6wdCPAjm4X7lfMttnqpv3iOC384RtHJNHQF4
 IMHAF7krugYAfqyddDNYsEnYPXPE0BNZP1WhpDQ0MnNgxoLkFIPX0ZD7jQQtKYwGBNcJ
 Wm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762677484; x=1763282284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hnMZgMyw2+3AVfjHgEkZm9DCWpsL5SoUwGFFOme7AcM=;
 b=AkyGG4MxM+mU+jceYKgj+K4Pk05zf9Y5abSPUtvnGb780vqJ55FEdpePVShk6vwGwf
 XBFVGVFcw6JvejO9SseePmF+fg/BqZgFe4qygdqySCc2etefLKkIFpIm8xyYLta8NVlr
 mtCgLwY53eM+KBJdBtARGAPqUW1NZXb34iwcoxdXgPeubsypeYhO6OAu9Lfm5lCa8RDy
 5rTO1nrnbQbNYQ1KW0B6jZIaPQzQRS0h1z5V+NocbAuoSjWJpJ/VA6Pnq4yp1Slda7Ut
 gNvy08+NeBawiriF4wSa2GA6Gc1oy7JPWbbZO2VYEaVjpYpUCpiyV1d5bBR9TKDHVDgP
 njPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmAZgxXnMB2uIhHTD6yYmpu1TqNqzx//YVXHlJ74Qa9LJP09DTC7JZSp0+PEOTHt4OdqImJEg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxtpm4850EVg9zqa6JbSsKIuVaMnK8M17+4iHAAK70vTSdPTZRX
 OGDG7Pq+m4GUAJ95QKF4HMLPRPJEk9cs0MvkQaJ6U2YkmhwxFGhX2qfAAqXDIBw3H6rOXOWz9tO
 UDebqJ/QkevlKyF+8kvxqUqtGHMiJXFkEaj0tHmGgKw==
X-Gm-Gg: ASbGnctraKfgn7GqnmEoSlYdQFg8tNgV3fXg933eTfq0jyRcezvKA0mvqFnQm6ZDzR1
 8L3UhEamoBJnecTrhjWqbO/H23aywdaYS00gDhFaW345iPu6qerKhVDzcjquTO0gkt+Egqi50ch
 cj9SMzAjvpSM8WmQ1lp/QGHX3XeSvNUOhotPlqee32BJleAB8/DB67uEz7kttZ2+nRvh9u5G7Ct
 5Q9yf9LMhwc7HbQBEy3j1lp81dCcWwM+NwS0Nxqs0HSn3JOOgip46HeueA8p4sWkLSGAIVt6Q==
X-Google-Smtp-Source: AGHT+IGOeE4jEXfNi8jeDluHWffZrQc6KREKe0VTqBb7vqVAqAE6Ij4f5nZFWSrffCLxJlFzLL07QTEvUhluEgg8PRU=
X-Received: by 2002:a05:690e:1507:b0:63f:b4b4:4fa5 with SMTP id
 956f58d0204a3-640d45b4bd0mr3255797d50.46.1762677483752; Sun, 09 Nov 2025
 00:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20251109070521.142477-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109070521.142477-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 9 Nov 2025 16:37:52 +0800
X-Gm-Features: AWmQ_bl7RHS3fYXbhprgi7pGDYBbyuVrEj0tGRQLDFDNa4l1nlaUj5R4E5pi55o
Message-ID: <CAEUhbmU7HWj8a7i-XMi36Omp9yO4FQZL6+U2M54qLmS67oB56A@mail.gmail.com>
Subject: Re: [PATCH 1/1] dm: typo programmaticaly
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 u-boot@lists.denx.de
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

On Sun, Nov 9, 2025 at 3:23=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/programmaticaly/programmatically/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/dm/root.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
