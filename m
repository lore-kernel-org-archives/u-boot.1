Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24176C48297
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 14:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 568EC87811;
	Mon,  5 Feb 2024 15:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cOZeHHen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87DA38786C; Mon,  5 Feb 2024 15:25:43 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4F4877D3
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 15:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a37878ac4f4so162962266b.2
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 06:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707143140; x=1707747940; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bq8auSnQQQEsHMqfoETHtVGEWEhAMCtCbbi55A6RXcc=;
 b=cOZeHHenEsoaxr4fy3DFuSniIEwNwSVmdFUkM+Wj7xYV5ZFzTxwh0c+jzJm47Ty4u+
 NoMZX12wBOTwI4bHt/wIp2U6VFPfZ9cBoSRdl6u155ZBLuWUvo20mCb/FoV+MpfD62j6
 AJKuXCjg7P16huVxwXik4oZk3aavnex5wyrlng4dsOsutZHznY3wybX1DlsRfL8gU3dW
 TCMSt8xCGGbLFbWhf7lKPZBuLiyxdBMwMluRBBBfzeGhkM9v3S0vjGj7tS4P3+FW8KrI
 e18AWBj2Yysh943sO48ZLlukDFZ1q1bPIYlZBM62/YUaX5+vsT9aKBq2AZ96R3Gm9xSz
 0hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707143140; x=1707747940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bq8auSnQQQEsHMqfoETHtVGEWEhAMCtCbbi55A6RXcc=;
 b=DHBy0MkmvqFb7RmgL3A/xxysX6GpaynnjndNuLDLiRudct10jhJrBUbizSPvXJzR9G
 s0hXbASOYowNUH+2r9d1XDFUV8+hfBkbpBe28ZspdYzZm9Ucqo5vN0ngeVLWMX8aJXnE
 YZvo+lASvSU4lrn1wjj9i+DcbHbaCi9COtZoR0LIYV5nnjnbMmWsmrrkNC0tK7JQZEYX
 RSPT+P0052sRljQZkCMz6s3ihBYfjxfQQsrDrhsV94e0NyLG0TnaNi/1AvRLx/39G4PK
 6UkWOjxxsS1f9Gus+zWkKOVshE6EgvAd/hXj3d5YJe+Nann29+osdkVo3Xur5rPnkfvV
 0nLw==
X-Gm-Message-State: AOJu0YxzI1sFwYHY1UMerhFezsXs+m4VbiVYpca/t5Frb08eeqNTkB46
 WQi4mng2UH0X0nz6D4DsNAo8hcsnihSjN2GYRs++nBhONrNMLVHKRJRIrWVUBB4=
X-Google-Smtp-Source: AGHT+IHSqiI+0/oAUjt+L+UjQy4VosRFOV/aGOLBCae0vzigYPrXK2lbf9zRjPxTpZxPRQDsVpkeVA==
X-Received: by 2002:a17:906:d10e:b0:a31:61ad:6554 with SMTP id
 b14-20020a170906d10e00b00a3161ad6554mr9056212ejz.69.1707143140596; 
 Mon, 05 Feb 2024 06:25:40 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWb/sxvDVBBT3e8j0SVm/uo1cTvmD9bGw5gl0UbGVcp8SbU1Kg6ePTivsfHqCDOgmF2R3czdZ+i0LDhzH+DI8egc8SLjg028+oSHVdHFzXdM/tF8yxnEbUhEkw0NQ==
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 lv24-20020a170906bc9800b00a35c5acc51bsm4375890ejb.160.2024.02.05.06.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 06:25:40 -0800 (PST)
Date: Mon, 5 Feb 2024 17:25:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hongbin Ji <jhb_ee@163.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH] xyzModem: Correct xmodem blk verification conditions
Message-ID: <bd80e95c-b2bb-4ff2-8943-7a185a310546@moroto.mountain>
References: <20240205065850.7556-1-jhb_ee@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205065850.7556-1-jhb_ee@163.com>
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

On Mon, Feb 05, 2024 at 02:58:50PM +0800, Hongbin Ji wrote:
> When the blk sequence number is 255 and cblk is 0, the original XOR condition
> produces a result of 0,and the judgment condition will be unsuccessful.
> 

This code is 18 years old so it's surprising that it's causing an issue
now.  This was added in commit f2841d377060 ("Add support for ymodem
protocol (loady command). Patch by Stefano Babic, 29 Mar 2006").

Not just 255 and zero but any time "blk == 255 - cblk" then your new
condition will be true where the original condition was false.  Is that
really intentional?  Is this from reviewing documentation or something?
What documents?  Or is it from testing?

regards,
dan carpenter

