Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F43ECD13DA
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 20:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C717803C6;
	Thu, 30 Apr 2026 22:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G7S9Ezhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74354803C6; Thu, 30 Apr 2026 22:01:19 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95EAA80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 22:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4243bf9be36so668327fac.3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777579275; x=1778184075; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:resent-to:resent-message-id:resent-date
 :resent-from:from:to:cc:subject:date:message-id:reply-to;
 bh=9QrkUDXJkt+y7dv2Kvlc7faagOMGXnYTMqhPOLAvKSQ=;
 b=G7S9Ezhc7zLvtpA1VOorwJPyYsUrEBNgJfHN6VurcwPJX4fZVCxRono5QiNUV2WMT5
 rRVW+Ophcz3iAag27tDcex7pdHJ+VZlV3XPcuv7WPbRlt8G1BGG7h67YCcXZ8B4ZY6LM
 ydfIRgFvs8c3A1oGmG9b2L6OgV/bcy8lh0qxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777579275; x=1778184075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:resent-to:resent-message-id:resent-date
 :resent-from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QrkUDXJkt+y7dv2Kvlc7faagOMGXnYTMqhPOLAvKSQ=;
 b=lav1GZeOl4kvadQjA6rAIFm5miqyNULHwpHMfi9zD5Wmgg23J+bbxpStqsNG0MFJOm
 YupC64JTpnbkluhjxrR0hI0eMFoRnvl6hf+9PFLjrsLY4r17ZhAuUKcbM0NoQpQdM5cQ
 O/uwUIZ71/odK48E88m3dNjoGJFU7xoIpPZuRDRZCRBfs/G0aTk8RfIjdCfQNIcADgIo
 QrZRsrA8/cuRZmHHoeEs488Wx32H8pj/Es5oCmOAmJViGy6fwY2+W9cwJFPXlCrugG7b
 X8oYH013Nmc5QdqMXLz8ZNjDx+BOzVbykeBx8XzclxcfZ4vcX9kWjzUNxiWInqJvsi6E
 FHaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9l2VRTugszYksr3DnHQkn7HWIDtYl21k5+WpWZIOMvN2URpTcTNJilW8Aom2z/gMA5/GjoE6Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7WZwT9hcr6XZx5l/uE9RWvGoN96ZDUfxCWslhh/EgYrClTJf3
 UVVi0RQ14KBBPNAN3mIizopPP4X9NwYvRYdaWNs5QsLh7JYAC3h6x+xy8M72woxhfMEZI0P6Eip
 rJd48C8uDKu7x
X-Gm-Gg: AeBDietuq8mDsUGdN8XsediQsSCEeTQ7ifBp4LcBGNQsGgBas8vKB5xz3XmpPcCKhL0
 vHeFm2Ajuwe2f8T1KM2cKf3b5cXSoF/1zHRk9SkK2dup0gJ1P0pO1ZjLK3tVKWZQAkoV420HIFn
 6sV8ltyeP+Tj2lIQGCii3WuW7r4pVhg0c4PFzkkW6QnpeGLmEeJVbDNCw7bduRmlYO7faKQlqTa
 KG42h2fxo4g0d/9I6NhJZB0xuyze6sdbsjUHsgVfHbmLytgTTDhIqPkcx6aPXqt3o1VEvB1Eq3W
 sRslzEoBrkjvHEGRcsFgIc4GqByBKOKhmferg0apsbFpGvvhCQ1Om1+G43canmVTs31O3hq5Svj
 w3whDBh9hP7feuIIaHstrp29gjf6JtERYfjHdOgjGFHYcB0SKx887Uxa671/y5BYZ9CDdFzarat
 9ncU0YYuwi2BceaWG7nxM8Ph2+FrBLd993ROKeYvjMUI9HEBP7pPqqBLEh7ghKydMZeFxrZ4OHX
 Mqrsdq2bValQqgLg3zWZSxclrIAPEbdBDRd/PmXh6bl1dxIrKuoaC/c3t8vuw==
X-Received: by 2002:a05:6870:f2a4:b0:430:29f5:285f with SMTP id
 586e51a60fabf-4345c5560f4mr4053fac.35.1777579274937; 
 Thu, 30 Apr 2026 13:01:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454cbc3c7sm620897fac.12.2026.04.30.13.01.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:01:14 -0700 (PDT)
Resent-From: Tom Rini <trini@bill-the-cat>
Resent-Date: Thu, 30 Apr 2026 14:01:11 -0600
Resent-Message-ID: <20260430200111.GC1614990@bill-the-cat>
Resent-To: u-boot@lists.denx.de
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454cbd8dbsm602103fac.11.2026.04.30.13.00.47
 for <aristo.chen@canonical.com>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:00:48 -0700 (PDT)
Date: Thu, 30 Apr 2026 14:00:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH 1/1] test: fit: Use shared make_fname from fit_util
Message-ID: <20260430200045.GA1699939@bill-the-cat>
References: <20260420074827.3917463-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420074827.3917463-1-aristo.chen@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
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

On Mon, Apr 20, 2026 at 07:48:05AM +0000, Aristo Chen wrote:

> test_fit.py declares a local make_fname closure that is byte-identical
> to fit_util.make_fname. Drop the local copy and call the shared helper
> at all seven call sites so there is one definition to maintain.
> 
> No behavioural change. Both implementations return
> os.path.join(ubman.config.build_dir, basename).
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  test/py/tests/test_fit.py | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)

Can you please rebase this on current master? Thanks.

-- 
Tom
