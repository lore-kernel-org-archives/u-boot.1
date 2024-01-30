Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32408C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C25687E0B;
	Tue, 30 Jan 2024 15:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jRs1ICMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D99F87E10; Tue, 30 Jan 2024 15:48:12 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A72D8309D
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33ae4205ad8so2131473f8f.2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706626090; x=1707230890; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SzAC52nW2WSo2yIvT/ZXosBT7uuN61VGkmxgX4jvWng=;
 b=jRs1ICMut+mzjrIbDMiXdaOPBCkI7fJgSNwkHGXSw/r5rOFTMgbacUwv7y1hCzdkXS
 psok8vWmtLbvvbBktL6spb5Zzb8NSPIGwVG6hcRCSfXKe/LpOn6zR/8BPC8EuwQ1mLgQ
 TWt9Bkl51qAlcoZwVcGhTZFDz3QNCjrx1x+ryD8NZH1jsINJ+1gBXwbpOIInRGywuUXI
 H63EZ76Q/fOM1wTjgeEjJ74hvqei2M6u1W2gGdUtScfhnZ6CnnmBdTZUGBuWMA8Lpi/k
 Xtw0ueR3c1cV0Rm1nH6IBQQ8998gic79WmkNAgSS3IKFhYPNeV4/u8IlhS+T8INYWRBO
 jypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706626090; x=1707230890;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzAC52nW2WSo2yIvT/ZXosBT7uuN61VGkmxgX4jvWng=;
 b=LMNhbG3DhVzwoZTDFMAPrPt1BVSyv+I7njmYe+/fy0U+hNy0DDIFX8iYbNaSzh4H0A
 sCZ7RmSIAFNT3/VGBDOEz99yquGm9nhgxI0oTMB3f+/whMEA+zpqYzhjhV5byQv/WrNW
 M06Sd1036N7qMppd+iJQTsqsK7bXVL5+9TORkYwf0ic+e+tNX0V84oUzlzt5DjNfRG8+
 hd9GUSaCZfvoZNh6n9zqZn/U00rMvOx9bPMeFft4Vsg+JwEIrWchgI+0AOS9bHUvrA8y
 JnxrLFFCEM2EF/Es0zJlOy7M9NtGUolIHCybdz77VZ1JuNeDKjlaYAvCMGvpql50SzVj
 sojQ==
X-Gm-Message-State: AOJu0Yx2oc/jcz3Z9fIKqMhcH9n0lOg/P+WWqN5CaWcxnRdYmnXxrMTV
 C8jPq6NGDe/UCrgU9hp87N6Xb6A+aRz5JjakwpwOEKFPH0lPtp8JQCAS7oOEPKM=
X-Google-Smtp-Source: AGHT+IHvfUDzw5tbJbLbNFSJSvmXgQhG7U2NyyI7BESKA6vqPJ4Jz/AlqILeEd46jN68l11fcDgRiQ==
X-Received: by 2002:a5d:64ea:0:b0:33a:fcfd:3557 with SMTP id
 g10-20020a5d64ea000000b0033afcfd3557mr1075743wri.34.1706626089829; 
 Tue, 30 Jan 2024 06:48:09 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 en8-20020a056000420800b0033940016d6esm6880882wrb.93.2024.01.30.06.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:48:09 -0800 (PST)
Date: Tue, 30 Jan 2024 17:48:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Tom Rini <trini@konsulko.com>, Mathew McBride <matt@traverse.com.au>,
 Peng Fan <peng.fan@nxp.com>,
 Shenlin Liang <liangshenlin@eswincomputing.com>,
 u-boot@lists.denx.de, Pankit Garg <pankit.garg@nxp.com>
Subject: Re: [PATCH] fsl-layerscape/soc.c: do not destroy bootcmd environment
Message-ID: <7c3de840-4ba2-4e6e-8f8b-09b90d6b9bc9@moroto.mountain>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3f58dbb3-6e3c-43d9-9553-fe60808a43a3@emailsignatures365.codetwo.com>
 <20240130142656.200683-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130142656.200683-1-mike.looijmans@topic.nl>
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

On Tue, Jan 30, 2024 at 03:26:56PM +0100, Mike Looijmans wrote:
> When an XXX_BOOTCOMMAND isn't defined, the result is that bootcmd is set
> to some random memory content. Fix it so that the function does nothing
> in that case and leaves the bootcmd environment unmodified.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Thanks, Mike.

Fixes: 2141d250f510 ("armv8: fsl-layerscape: bootcmd identification for TFABOOT")

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

