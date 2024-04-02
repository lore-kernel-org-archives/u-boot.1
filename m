Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA514C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 07:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 280B88834E;
	Tue,  2 Apr 2024 09:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rPemuPt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85CA88339; Tue,  2 Apr 2024 09:24:38 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BB38834E
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 09:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-415584360c0so16684995e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712042676; x=1712647476;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SBLABUDBtY+U6DXwf0Oa6rNRUeFYMr+oDF+WA/CDjiU=;
 b=rPemuPt24ZcmarQkTZOHw7kAo1OLkoVQo2emxZLlvqNRR7Qeh6xk0dxnlmp5WvWhDB
 +Bst8dxcaTIVJTc4AG7G6d2aOgUg+LqUD+u1aXSjpOXsaw2f8XDWpi1DyEXFqBOewtYJ
 voAydcGR/MUHgksdZbqs+xMSthnkYloUTNZTWrEQdqsiYPewz+v2k3RPLop276x6XZDw
 KhlfTeI1zqw6uia8yq6FjGbiiSfCjsrYLS/4SLuJJAkRoWs2bHiGFhNpIjbnGVU5w7pG
 S4O3qHkMoCrk2vlKPRPy6bvLwyIrbWz7Tm2kb7jR4QTSGB1vYOUmU6OB6ggqpKRN35ri
 oiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712042676; x=1712647476;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBLABUDBtY+U6DXwf0Oa6rNRUeFYMr+oDF+WA/CDjiU=;
 b=gJ/1DgwGSBs1f2A1h4mS3bxMK4+6C4egLp/azh/Ct/lrmPbSuQCAcjNzTZRCLFP5nR
 5ZA7W60XgzvkI9RHS0ziuuc7OkZW1cMC5nluN7hAqso2AkB42dI9e7elCZ71lRJFU41Z
 TnzXJSuqc4sAbmZS/qiToj+hePvYg3jHITIg0sITdLJmvxF3q5YAcK9mvXSO91nG2z3E
 7loqNDLe6BBxM4F54Xzr1iwza4U1hVrlfKG42RVcTdkflzCBjrDYovC7Yhu/qiTwgD7K
 cftk6a0vm/dN+mfZITeuxgosDmxeO+BNP9x6QjODZQV1Jsmkwt9W/3QkNPer7irSL5Eo
 dIvQ==
X-Gm-Message-State: AOJu0YxwP5uYnG2W+4Z1c9TVKNO+040ToGWHtfN+HLmxIwfTlUQ59fi2
 qlZmkS4orevl7kloaBGyD3RZmbPu+TdcCrs0r62L5wr10m7xJwIZ+V2YysKLVnM=
X-Google-Smtp-Source: AGHT+IFYu7K/cmu9ZQCEIkNXBk7jrA5EYZQbuKRcilRKVQeC/PcOLThyhurPEAn+IXjDkPtsUVMZNQ==
X-Received: by 2002:a7b:c7d3:0:b0:414:d8f:4399 with SMTP id
 z19-20020a7bc7d3000000b004140d8f4399mr8547120wmk.18.1712042675991; 
 Tue, 02 Apr 2024 00:24:35 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 l13-20020a05600c4f0d00b004161af729f4sm1063796wmq.31.2024.04.02.00.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 00:24:35 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v5 16/16] usb: gadget: UMS: fix 64-bit division on ARM32
In-Reply-To: <20240328-b4-qcom-livetree-v5-16-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-16-4e98228b3d03@linaro.org>
Date: Tue, 02 Apr 2024 09:24:31 +0200
Message-ID: <87edbogrbk.fsf@baylibre.com>
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

Hi Caleb,

Thank you for the patch.

On jeu., mars 28, 2024 at 17:59, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The patch introducing support for dynamic sector sizes changed the types
> used in some divisions, resulting in the compiler attempting to use
> libgcc helpers (__aeabi_ldivmod). Replace these divisions with calls to
> lldiv() to handle this correctly.
>
> Fixes: 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

I believe I applied this already via [1]

I plan to send your work to Tom this week.

Sorry for the delay!

[1] https://lore.kernel.org/r/87a5mqei67.fsf@baylibre.com

> ---
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/usb/gadget/f_mass_storage.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
> index d880928044f4..ef90c7ec7fb5 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -239,8 +239,9 @@
>  /* #define VERBOSE_DEBUG */
>  /* #define DUMP_MSGS */
>  
>  #include <config.h>
> +#include <div64.h>
>  #include <hexdump.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <common.h>
> @@ -768,10 +769,10 @@ static int do_read(struct fsg_common *common)
>  		}
>  
>  		/* Perform the read */
>  		rc = ums[common->lun].read_sector(&ums[common->lun],
> -				      file_offset / curlun->blksize,
> -				      amount / curlun->blksize,
> +				      lldiv(file_offset, curlun->blksize),
> +				      lldiv(amount, curlun->blksize),
>  				      (char __user *)bh->buf);
>  		if (!rc)
>  			return -EIO;
>  
> @@ -942,10 +943,10 @@ static int do_write(struct fsg_common *common)
>  			amount = bh->outreq->actual;
>  
>  			/* Perform the write */
>  			rc = ums[common->lun].write_sector(&ums[common->lun],
> -					       file_offset / curlun->blksize,
> -					       amount / curlun->blksize,
> +					       lldiv(file_offset, curlun->blksize),
> +					       lldiv(amount, curlun->blksize),
>  					       (char __user *)bh->buf);
>  			if (!rc)
>  				return -EIO;
>  			nwritten = rc * curlun->blksize;
> @@ -1058,10 +1059,10 @@ static int do_verify(struct fsg_common *common)
>  		}
>  
>  		/* Perform the read */
>  		rc = ums[common->lun].read_sector(&ums[common->lun],
> -				      file_offset / curlun->blksize,
> -				      amount / curlun->blksize,
> +				      lldiv(file_offset, curlun->blksize),
> +				      lldiv(amount, curlun->blksize),
>  				      (char __user *)bh->buf);
>  		if (!rc)
>  			return -EIO;
>  		nread = rc * curlun->blksize;
>
> -- 
> 2.44.0
