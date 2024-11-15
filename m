Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBEED6A223
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C5A89346;
	Fri, 15 Nov 2024 15:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sj0WiRgx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C28C8935E; Fri, 15 Nov 2024 15:20:44 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BDB088D29
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9ed0ec0e92so238468166b.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680441; x=1732285241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bnijsNiCpeVlNHDsPF7rN2ZiJvKMecQ6+Xwj1tNsn3s=;
 b=Sj0WiRgxsuauaME26NJcjYJ18tftMWF1yluXhAWqPb9yrGLwuUpjYa2B3zWNFV25ei
 00qWp65rqy3NbD1fiLUrh6vvmHTF/iEs/rKMiFvuh57VHtrX76/JKRXmFKgxHUn6fe5v
 sAqinIqj+123FE3dfmqtBQXgKUgQU3XNE9NYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680441; x=1732285241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bnijsNiCpeVlNHDsPF7rN2ZiJvKMecQ6+Xwj1tNsn3s=;
 b=MpdG22+PHDI3/RR387qZxSUwHaRqILyheDz/cE9q0OwuvpUwq774DEm8Yetz7OI/y2
 ybniQ95sYgSj7W1mgPn+m+EnW6Oa5D5+StzFUVQ4+wtOlbx/lYp1+FJH58l4UidF1g+2
 6h/5y4pFlWDzHOtBsGqMCOVD8w+AJ5fcNyZ/qd9q2z485RXsC4SKEY7ET7g01WxbyNNL
 59FuSnoRvYnW5sa8NB3sxnf2X5YOt/5qV0tSD4dVl9WyY4479yWsDaQh7UIj9OaWeUXm
 TV+rOdrohFS2AlQ2qLhs60GwAU/Q5Urt1PgZSe9CrNk2go4Z/q2ComBLN2yNtnAmXGPi
 IT1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDR5vxsvtOW4kETk4hKElb5+NMbi7HS8rBS7+CMHFZbX/hK00K6dbmRCEEeRK4bsPZp2Gqgfo=@lists.denx.de
X-Gm-Message-State: AOJu0YzgyFv3EO62Ro6qZEpBO5K7JQJDgDOWNuSIM383pl4TwgbJQUbA
 GKA2sUo6HejczxiCD72JON4Jx527rAScmrYnHf9pho6+A0E4/H7jBqp3BgSz7g7j9faYTm9LLgX
 xPoDKqtvxtfsDeOURXv8AXTisZXDiOYOnje8h
X-Google-Smtp-Source: AGHT+IGCdSERClDUzcfvzIFJPexTNNI8X2xfd/fS589UorRpI1eTBSIo+h5kpHTz6i5prEJMGoW/+dBRsaR24rr7T+k=
X-Received: by 2002:a17:907:3f98:b0:a9e:d539:86c4 with SMTP id
 a640c23a62f3a-aa4833f41cdmr223739466b.9.1731680441482; Fri, 15 Nov 2024
 06:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20241114142917.481564-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20241114142917.481564-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:20:29 -0700
Message-ID: <CAFLszTifoqr9AaYVkK=1JtWdqY+2XNpWD=R6nwLxqpWX2i4_8g@mail.gmail.com>
Subject: Re: [PATCH v2] net: lwip: provide entropy to MBed TLS in one go
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Thu, 14 Nov 2024 at 07:29, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> We currently provide entropy to mbedTLS using 8b chunks.
> Take into account the 'len' parameter passed by MBed TLS to the entropy
> gathering function instead. Note that the current code works because len
> is always 128 (defined at compile time), therefore mbedtls_hardware_poll()
> is called repeatedly and the buffer is filled correctly. But passing 'len'
> to dm_rng_read() is both better and simpler.
>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>
> Changes since v1:
> - Update the commit message and title and picked up r-b from Jerome
> - v1 can be found here https://lore.kernel.org/u-boot/42870ab3-1621-491f-a221-8ced932ed703@linaro.org/
>
>  net/lwip/wget.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Yes this seems better!
