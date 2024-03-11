Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CCAC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 740E587E87;
	Mon, 11 Mar 2024 12:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L0KG+RGx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D61987E50; Mon, 11 Mar 2024 12:37:48 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5F787EFF
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 12:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33e8b957a89so882534f8f.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710157065; x=1710761865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tv8/+F3EblhAh/v/gYVkxMXrp4vmZD9DcJq4EpmpuZI=;
 b=L0KG+RGx6d81G9CLSaABoLR8AZR2DKDENRNiV02Dnb+69rLBtDtml0sKMs7AErUcts
 0US6KkGSdk0Kr6a/2+WvzqHavrDS2WMkEmwzCE6OMRKcWT7de75QGAEP4yk5Fjz1i/OS
 o4PjzygRMZqqg98yl1om0fCf9keyyUrdX6amNnVYUc1k+X/xVOMS/5nK7rchdI2WgdCV
 xQXDN9rVQDrp3kA2IDGtyyQCh+0B9xp9rGyZ2lc5gu9cxTVt+xUaAzkM/ecje4+vYXcp
 pldPicMbXgMrYpH8dh3dLaGKKMuh+nGvvYqYCUX0qWFnNTxT7xqwpMNnByIyw4EUt5eM
 c/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710157065; x=1710761865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tv8/+F3EblhAh/v/gYVkxMXrp4vmZD9DcJq4EpmpuZI=;
 b=GKItFKjS/MEYp9A8eeQ9nXWG4ApWO1WnwjLBqlggUuP7c9Rl4yRIoQfU3GN1Uc6ew+
 2JXbTBZ7uviPes5jppK56AvBZOCHQJqBb3gcC6U7AVCQz1vpGczFRxJUbGXY7/u01iQ2
 7aCHuTfhH8uIyfoeNZkl9PQz/mAfE0gCgP0o9H2hZeL1RWNY9XruM1qthhXw0cTENPZ3
 ZVSD7GgpwbAAzZ7mm98yTtqVWBndbiRdX684atHBtyO1kwXeItS6E+SJBclvztrB6Cp4
 1QKesA/UT4tzGrf0yRTXnQcmOBgS7KiJGvDlwkrDCn+kxGbQN0+pZPKQ+fHmv68no02C
 2UwQ==
X-Gm-Message-State: AOJu0YxBYxm7wSYnBrqvmO1OdlZjsJEYa+ylZFi16RukenxA4DQI33J/
 h52Twr79IoVCT7oivvp5o1I1qFs/Lxr9tpVhMszcccpfstDgOziqyVwFPxy2GtDAJwGZ+MjS+LC
 C
X-Google-Smtp-Source: AGHT+IGQexHfx8cJ8Tp56tn6mLaAiC1WbCv/VoFoG6n98LKs1BsJ0GdFw6AZkcvBS+DoYLtqfj6Isg==
X-Received: by 2002:adf:a4d5:0:b0:33e:726d:e963 with SMTP id
 h21-20020adfa4d5000000b0033e726de963mr4663494wrb.17.1710157065370; 
 Mon, 11 Mar 2024 04:37:45 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 g5-20020a5d6985000000b0033d6c928a95sm6272427wru.63.2024.03.11.04.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 04:37:45 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:37:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] fdt_support: fix fdt_copy_fixed_partitions function()
Message-ID: <5b95fea0-581a-44e5-b275-09393b7b02a1@moroto.mountain>
References: <20240308133404.2619848-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308133404.2619848-1-patrice.chotard@foss.st.com>
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

On Fri, Mar 08, 2024 at 02:34:04PM +0100, Patrice Chotard wrote:
> Move variable declaration at the beginning of the function.
> 

The problem, presumably, is that when declarations are in the middle of
a block then it triggers a GCC warning.  "declarations after code" or
whatever...  The commit message is not really clear.

And when I built this file I don't get a warning.  Is there a specific
config required to trigger the warning?

Btw, the Linux kernel recently silenced this warning because it doesn't
work well with the cleanup.h code...  It will be interesting to see if
people abandon this style guideline.

regards,
dan carpenter

> Fixes: 163c5f60ebb4 ("fdt_support: add fdt_copy_fixed_partitions function")
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---

