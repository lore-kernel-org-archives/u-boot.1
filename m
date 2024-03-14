Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7DCC54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 11:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 464C887F01;
	Thu, 14 Mar 2024 12:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O1+pGweY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FAC887F04; Thu, 14 Mar 2024 12:29:18 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89D4887C61
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 12:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-413f1c0d30eso3052205e9.1
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 04:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710415755; x=1711020555; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2EVJ33OIH5iazxLexO6FAnps9GLb865IdG9xGIVMCJo=;
 b=O1+pGweY+NnwkoV8lSCZlpewUrzULQDMyf5zvutOXIkVTp1z0dLTzCWC0Qoum0F/wx
 9dW3wUFrIee6NluNSY/SugRKwV/SVeE+XxR3gEznhE9065E3+gzQmV+ZX+5pCdC3VPta
 K//wXus/saf6EINSSqfCIRz4Q4m6TSwQZVdoL9Tvh7bwoxGeA643GqfrJsKLl6Yuupgp
 p9K1BxIscsOEsVmbiK5jpfzmkMvMHtgyl6SQP325WxzB7gel9PUMBTKnKqMSfiK4Fu1V
 YCqJ50fZ/MY5zWRCn050v4uD5TGl+7AJLeCBb8OFun0OfO3DU3H5KRaB0yFZGmILOqcX
 lS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710415755; x=1711020555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EVJ33OIH5iazxLexO6FAnps9GLb865IdG9xGIVMCJo=;
 b=XG+ZvndLV7eWz6UPDSPwZK7vTBSiot77GKyzAAvhB02ZyFdi1FPQ5U9fN0PYkHfCnL
 5UI8KNf6giWro7ycK+EUYkJcG6F5V0dUOjelc/0anGe4tZt0E7IUWNAxKubXTAKv4M6w
 Ie24+SH1Q1tXAsBDvXlJxqqs5gyH2SMsAj0CPsUHRKT6tuLg3vye9kOIlI07eL1RY6BU
 WuNJnn/BByxk05INCiWl4GKu9BEAJDpjiMjCK0oZr30OCQvMLBnu92zFHC2L8GC739gn
 TcWYGtfrLSjlccHeOGpbQMSQwHOD7glILpM5cgZ+8GFcsJPRdVkokOdPU2P1238KevRl
 DWKA==
X-Gm-Message-State: AOJu0Ywyw0TgX5ubnKwkbA7/P51GVuKXk0qdv51xjaL8AJqji1dj0Jdw
 zkMuwULHVoc/mQsXoHJP/sQpjgmIwDtgbzBlH6uvCBfPr3NLH1S+n3uaXTfvoKY=
X-Google-Smtp-Source: AGHT+IFf4+1Dncq10wtjEKk5EAiI7AI+tq3eAoezxxM0nYnLf74x+3hGKgaloW/G/3h9hGDa2cP7AA==
X-Received: by 2002:a05:600c:19c7:b0:413:1212:3eed with SMTP id
 u7-20020a05600c19c700b0041312123eedmr1272228wmq.3.1710415754798; 
 Thu, 14 Mar 2024 04:29:14 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 a8-20020a05600c348800b00413f52889desm1086290wmq.3.2024.03.14.04.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 04:29:14 -0700 (PDT)
Date: Thu, 14 Mar 2024 14:29:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jixiong Hu <Jixiong.Hu@mediatek.com>
Cc: u-boot@lists.denx.de, jjhiblot@ti.com
Subject: Re: [PATCH] fs: ext4: Fixed file permissions
Message-ID: <6c3bd10b-1f35-450e-9371-7aec216c1097@moroto.mountain>
References: <20240314064130.25113-1-Jixiong.Hu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314064130.25113-1-Jixiong.Hu@mediatek.com>
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

On Thu, Mar 14, 2024 at 02:41:29PM +0800, Jixiong Hu wrote:
> Modified the ext4fs_write function to create a new file that
> inherits the inode->mode of existing file. To fix an issue
> where file permissions are changed after modifying the contents
> of an existing file.

I'm not an expert, but honestly the current behavior sound more correct
than the proposed behavior.  What's the issue specifically so we can
understand it better?  Also bug fixes need a Fixes tag.

The patch has a number of style issues and the existing_file_inode
allocation is not always freed so those memory leaks would need to be
fixed.  For the style issues run ./scripts/checkpatch.pl on your patch.

regards,
dan carpenter

