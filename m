Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A2ACD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 824AE8465D;
	Fri, 15 May 2026 14:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nsw6sft4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A031E8467F; Fri, 15 May 2026 14:55:19 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F408464D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bce57c132b2so169503466b.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 05:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778849716; cv=none;
 d=google.com; s=arc-20240605;
 b=jVkKAmW/LXlKuG8kQGkSu4nPXNbYIYE1rPC7FFruJQzE71vYjEezmEX79hqJxd6BxU
 sQyb7PEcp0UlQLoBei8Z55DknKgC60pTDI+WV/2qswNm5vWw2F5jYX34ldSpfur2+roI
 D1eRuY54+nh3McicaFRGnWhN3iEx5UmESnRP4yEtL0vEpyV80q98hbYRKegEdlcoT5t/
 PMqytcRlGamvOknuk3r2C11BkE2bVjYON5EdjJqrBbJya+zuv6eHuAyMeIjrd2lx3jLB
 zGV9d5o2GIVjuI+K5irYQxOOgBYfFanMd3kWlwm+dZLgL8a29Ogsmjv0ew5uvoklumuz
 3ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d5g6/2Zgiibogt9ex30r5UZrDAmdn/KI+gz4Mj6BI54=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=RqnclwByQIVKPvIn6ttatPOBJBXABpt5tnE5rne7L6CzDP7xCUvOakll9tC5/xIVKv
 vJ4q8wkUe+0IQ+B+IJXoRRSbZTsDGkI3HY9IM4ADKZgXRwowINs5idr2mtYE93fFHLv1
 rhLw6ZtGevqDM28QgWFGn0+4xXWAcBuywgfDRooIdkXbbF37v/PXYv8+FBiormSIMXlc
 exd9i0IV40P0OxN9hRsZI7RtgQcmwk0JxFjiLlj+eLwq9KhWaL6DpqVebck/qF3jQThS
 N3PYqmg5tBPvxlUU5s4u4Qe/wyD5aGe9Y1fPijDtsBiVJrF4VQeQHE6HKM89lx60lV2D
 p5lg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778849716; x=1779454516; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d5g6/2Zgiibogt9ex30r5UZrDAmdn/KI+gz4Mj6BI54=;
 b=Nsw6sft4tSjoGMPNXdKKNaL/QC47jrWZHtN1kV1ziFgMY8RckF9Sl52b5dAsn9JkTC
 /E5vwMdjnrpdcCXkZGeXTfbTL7SFrABY4Nw+2aXALk8tUVlwzT524ZD1akCTIgNaFwiF
 jfInbEspdntXKietdOBKhBCa30KRe0AsOn43g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778849716; x=1779454516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5g6/2Zgiibogt9ex30r5UZrDAmdn/KI+gz4Mj6BI54=;
 b=QotFuphHtdfsSsyCL9uc6/VhkOFXaQ/1+ZZH4vP7AifCJ3PJmAPPTK9x8XhZ6qQEkh
 CklNs7yQB2yefRL1jjeSYKLzOyNZ2LZ53Hc5+PYWP3W5EpK9k4okP23LQp31MbYByqC8
 M4pyxACM5ByYKq6DLXE233jWA5tcsFObcPdVUf9fYCuwIVH9IhzA7jZ1Czu0w+oRwAfM
 LuPK05G/16Dk73uwKWjJb+8EgUGnPy1X7+KsBQDb8jkMxvx6/SO3P9YvGIdKm4nQSxWL
 nGSjGBGIdVjxtXQL1zz96CB6A8u9Ou2M903rStpBZB6ne8PxxFt5wg3S7L1BKfPLvVqK
 gSAA==
X-Gm-Message-State: AOJu0YzxqK9DL4h5aL5KsFA3zd+Di3SFwAqDpxV4k6l/WNERYFKBRQc9
 7GxwjAxhHRrOdyombKoY+WsNbYQCjYdWjf87rtkUX6c8ryCkl8eKjjxF2krZXznif/2YcRfn1Uk
 BOz/G+UQuSCGk/MpNOy+72/NqMqgVF4aPDFHh/ke9
X-Gm-Gg: Acq92OG2hq4Kyr73Zbz/ga1426oIfOvZPCZR3/qLeBBVxF32uqtjMBqZcty+F6iaDN2
 dwzn0ipio/ebOSNdvd/NMl64cKiOPy/eiC2kHUBDHQNQVTcweTNyxxzkGIQL32BtXZGZ+qbagwF
 9H+EcP4bPcIbb60sqFs/wwEgiBgy4+y/mnG9f86bDuxtTGhjOM65D+Zj8zoRBX/SIts3mUwEOcc
 YS4svaZody5mGppXLictllPa9C8qR5PNi0iIIZysOKCCuWalX6ID3/Npg1FADmwIcWKyNfyfHc+
 B0wjOM6Ih5Gp5by9
X-Received: by 2002:a17:907:1c0a:b0:bc1:d3d2:9348 with SMTP id
 a640c23a62f3a-bd4f346164amr385459066b.20.1778849716563; Fri, 15 May 2026
 05:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778657347.git.weijie.gao@mediatek.com>
 <5840777d0366c5d2449115c4143c802213ad36b2.1778657347.git.weijie.gao@mediatek.com>
In-Reply-To: <5840777d0366c5d2449115c4143c802213ad36b2.1778657347.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 06:55:04 -0600
X-Gm-Features: AVHnY4K50Z2EtNQVvmthGdezVNoVKnVwJLT7WjH2nx05JF_tAzCih35PQOIOf1A
Message-ID: <CAFLszTi=1mKZ8YjPy30qQJ1ZZb3UjRjZtEiSk9g2GUwi8F-UFA@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] cmd: ubi: change the type of parameter dynamic
 to bool
To: weijie.gao@mediatek.com
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

On 2026-05-13T08:02:45, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: change the type of parameter dynamic to bool
>
> This patch changes the type of the 'dynamic' parameter of ubi_create_vol()
> to bool as it's used as a boolean.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
