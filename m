Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF0CCDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C28D86EE0;
	Thu, 12 Oct 2023 04:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VcPxTYwJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D28686E5D; Thu, 12 Oct 2023 04:02:07 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10FA586E2F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-419cc494824so3349891cf.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075977; x=1697680777; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Jwiy12iT3vCIhs7fccubTcPbAIbNpRTt8cm/lcS+Mk=;
 b=VcPxTYwJ6ru/2qRSRxzsnqytJnDAOTZVU9iJQy5FuF5fZdO6XO9I7IRP5E4yhDIXku
 EAD2MJLRyroU9BgNM7K5FUr1QFMqppLz5WJws2GxzUnFSto6r+GiXfDTnkAGnPaxPU1B
 5g+msU8GS75A4c0x3psLFJjkKTtrJ5vm6tBZN2ykxGYMjgtf1R1RyRXjfgEfyj2wE4LL
 3ok2UbsH54ruBs5fYqIHmkHrEGB6y4se0TnHO5YpHncjHqJP7WcnMruVq9/sgw7s8+D3
 WK/lqJjDsfuEzjaOTLbi0w9PU7a9DRHxMBIVkaTEsX3gv8JsMAWIYlKnvxoyYMOIZKk9
 Zi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075977; x=1697680777;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Jwiy12iT3vCIhs7fccubTcPbAIbNpRTt8cm/lcS+Mk=;
 b=LbJtgs12by3jNQlqubAyVYANXWrijMShNo6TMULtV1RbScQ6p3Xo6ha5Vuh0DE8I/A
 1sfwjY7tvm21VYBKNGpN3p7YrQgoZEjOYSbMaykifsmtYZph+WVh2CMnj5v/vA+63e+X
 iZfwYMkrNj0HEOTwTTYRZX0psPXdebYl7jEPStsKMVwiOzBaZKIeTJnfnT50lde+iEEL
 T6glVH0VvzOYMeRlvju/WUTSY1d0QcZ43XZ02Xu+n6N51ewKpk3k26zQPtWIDniXpIyK
 zOl+pKZqb0jWCMQXbjG9klfExrPErpRjHQ1moipLc3aFvCNC+Abfl9WbAGrHaCwnbn1I
 lM7w==
X-Gm-Message-State: AOJu0YwO28zUI/miOA+0157scNsCLmtCZVb8rsinMvGgu03Vton6Jj0O
 lEYPdqc+GttMjw2S5bm1SCmtB1V2sxMl8W8c
X-Google-Smtp-Source: AGHT+IFSMy2o28fK9p/j3iQ/yEuxq01F/fiNy2BO5w8hIKZU29K7230T1CfIo15zchoa7vETS3LrCQ==
X-Received: by 2002:a05:622a:188c:b0:418:224:db06 with SMTP id
 v12-20020a05622a188c00b004180224db06mr26974952qtc.50.1697075976766; 
 Wed, 11 Oct 2023 18:59:36 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 e6-20020ac845c6000000b004181234dd1dsm5743433qto.96.2023.10.11.18.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:59:36 -0700 (PDT)
Message-ID: <aad2d454-239f-af42-acd7-867da9f99484@gmail.com>
Date: Wed, 11 Oct 2023 21:59:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/26] test: spl: Test some load methods
Content-Language: en-US
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, uboot-imx@nxp.com,
 Anatolij Gustschin <agust@denx.de>, Fabio Estevam <festevam@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Heiko Schocher <hs@denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nitin Garg <nitin.garg@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Roger Quadros <rogerq@kernel.org>,
 Stefano Babic <sbabic@denx.de>, Vignesh R <vigneshr@ti.com>,
 Ye Li <ye.li@nxp.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/11/23 21:56, Sean Anderson wrote:
> This series adds some tests for various SPL load methods, with the intent of
> helping debug v6 of [1]. With that in mind, notable omissions include NAND and
> ROMAPI, which both lack sandbox implementations, and OS_BOOT, which I have
> deferred due to its complexity. Semihosting is also omitted, but I think we can
> test that with qemu.
> 
> In order to test all of these methods, we must first generate suitable images,
> possibly on filesystems. While other tests have historically generated these
> images using external tools (e.g. mkimage, mkfs, etc.), I have chosen to
> generate them on the fly. This is for a few reasons:
> 
> - By removing external dependencies on pytest to create certain files, the tests
>    become self-contained. This makes them easier to iterate on and debug.
> - By generating tests at runtime, we can dynamically vary the content. This
>    helps detect test failures, as even if tests are loaded to the same location,
>    the expected content will be different.
> - We are not testing the image parsers themselves (e.g. spl_load_simple_fit or
>    fs_read) but rather the load methods (e.g. spl_mmc_load_image). It is
>    unnecessary to exercise full functionality or generate 100% correct images.
> - By reducing functionality to only what is necessary, the complexity of various
>    formats can often be greatly reduced.
> 
> This series depends on [2-3], which are small fixes identified through this
> patch set. The organization of patches in this series is as follows:
> 
> - General fixes for bugs which are unlikely to be triggered outside of this
>    series
> - Changes to IMX8 container images to facilitate testing
> - General prep. work, particularly regarding linker issues
> - The tests themselves
> 
> Mostly-passing CI at [4]; I have since fixed the typo/missing cast.

CI run for the series as-sent:

https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/18092

(hopefully by the time you read this it will have passed)

--Sean
