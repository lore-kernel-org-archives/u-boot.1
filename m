Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E749C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 11:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5AFB88119;
	Fri,  1 Mar 2024 12:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OehuYgxO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFEF68812A; Fri,  1 Mar 2024 12:37:53 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB62E88111
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 12:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso1118685f8f.2
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 03:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709293071; x=1709897871; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S/vB7zZnIApcSaXWAVPrQdKoClX3g7UKeSPiyTpVbRk=;
 b=OehuYgxO6MnYqaQLwNAj4v9TXcQiUUDy3kJrtd9DQdmcMEiRF03FBoZxx6peULwQQs
 GEHldFvAfA/na86N8/il0ylaxJad8DT22rIivyQWojAurBkB/6CNGzGoz9Q86LcrxO2g
 3RexB3L6t6WwULKrcfGW2av/wYxT/Z4pe59hzZqe0qBv7GmkbGJ5oykGs7J2effHUSZW
 7RJBoVvHnjs2yHFJ6mWEIbbn2X0JttF3rY0Ss0YmtWM0m5a8t9ei2l3uNVBLt+qkAAT0
 FPgFfquWKTp5Ur+BvknCuYfOIKqugkbLed8fUQxq9/OQn+6lV6WuM4qvDW/3BcvNHu/O
 ZSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709293071; x=1709897871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/vB7zZnIApcSaXWAVPrQdKoClX3g7UKeSPiyTpVbRk=;
 b=Y76JMLg6wvJJy0NN0pJx5Is+Ibz0b9jlwXLOxJo6FjFo+n+rAp03Rpc7WWveeSm82s
 xow+S64cYM3SO6kkOH2dmklEfhrIcLELRD93gzaUyDfsyoNY8Op/bCsUGMmsZrBXFjvJ
 yKrDULp6eCL8T1RybqmHJe/s00TIGErtDQFiceIUgrrYpiGK9wyOEQuWz/89jkKpOP+p
 lLL/R/kM70qt3IPDWqjqTXcsqtmbOSR7y9nbIC+hnYwJPEKQOlyu/gvNWc3kcjcHp3Gr
 zrnUE7I8IlN0i2GJjWNKXgQ8Y8rZAotx0NvWKTwEEBb4uKMTqv5RHQ+vgMvdaetz0PVr
 YCmw==
X-Gm-Message-State: AOJu0Yx+gembY8Xv7VtzB3SRLWiPV/4BSVlxG4IMeuzQj5Bcg8U49bg5
 z0IbZw+mfr4RW3aWyhdWl4GISv3dcuDkO/pTHbzBKe9/KALctyEclJAp0P9q/x4=
X-Google-Smtp-Source: AGHT+IFRnWPDLt/nuQUt0YWC6+5YOqmQoO+61toabIHavw9xFkSCKIs+O7DH63ia2ai3O2/6J4DmDA==
X-Received: by 2002:a5d:60cb:0:b0:33d:d791:1164 with SMTP id
 x11-20020a5d60cb000000b0033dd7911164mr1345506wrt.8.1709293071256; 
 Fri, 01 Mar 2024 03:37:51 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 r12-20020adfe68c000000b0033df5710fabsm4311243wrm.44.2024.03.01.03.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 03:37:50 -0800 (PST)
Date: Fri, 1 Mar 2024 14:37:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH] mtd: nand: arasan: Update the correct return codes
Message-ID: <b9ba5f71-88a1-456b-a074-62eedf4f0f28@moroto.mountain>
References: <20240301112109.3618564-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301112109.3618564-1-venkatesh.abbarapu@amd.com>
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

On Fri, Mar 01, 2024 at 04:51:09PM +0530, Venkatesh Yadav Abbarapu wrote:
> The below exception observed on QEMU, as it doesn't support
> NAND controller.
> 
> "Synchronous Abort" handler, esr 0x96000005, far 0x17acfc878
> elr: 000000000803ad40 lr : 000000000805f438 (reloc)
> elr: 000000007fcb4d40 lr : 000000007fcd9438
> x0 : 000000007bbfc880 x1 : 00000000ff100000
> x2 : 000000007fcf059c x3 : 000000007bbfc870
> x4 : 000000007fd9a388 x5 : 000000017acfc870
> x6 : 0000000000000000 x7 : 000000007bbfd0e0
> x8 : 0000000000003dd4 x9 : 000000007bbeec0c
> x10: 0000000000000001 x11: 0000000000003f8c
> x12: 000000007bbeecfc x13: 000000007bbeeeb0
> x14: 000000007bbeeeb0 x15: 000000007bbee474
> x16: 000000007fcef18c x17: 0000000000000000
> x18: 000000007bbf9d70 x19: 000000007bbfc888
> x20: 000000007bbfc870 x21: 000000007fd68ddb
> x22: 00000000ffffffed x23: 000000007bbfc878
> x24: 0000000000000000 x25: 0000000000000000
> x26: 0000000000000000 x27: 0000000000000000
> x28: 0000000000000000 x29: 000000007bbeed10
> 
> Code: 927ff8c1 924000c6 8b010065 f9400887 (f94004a2)
> Resetting CPU ...
> 
> Updating the correct return codes rather than hardcoding, remove the
> free as there is no memory allocated using malloc.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

The crash is caused by the use after free because we shouldn't
free(nand)?  Returning the correct error codes is nice, but it shouldn't
cause a crash...

Fixes: 3dd0f8cccd6d ("mtd: nand: Remove hardcoded base address of nand")

regards,
dan carpenter

