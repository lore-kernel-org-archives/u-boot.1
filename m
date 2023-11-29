Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D18C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C50A8778F;
	Wed, 29 Nov 2023 18:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V0p8ISc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69EAB8772E; Wed, 29 Nov 2023 18:48:04 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 135038779E
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-db3fd3e971cso6739683276.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701280078; x=1701884878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ruISmGArzGcsBccqUUu1AYZG+a4+IBq9ZueHG2cV7Ag=;
 b=V0p8ISc85+CvdpcQ0AOezctkq6zwv63ZSKj1EgEMTR3U7MpkTErAUkfYIsfMUv50en
 QNBme8NE+Y3+ll+U7j+EqyuKnwfuluhirF63qs9gfjYzurfurjg5m8b9tU/U8NiW5zFp
 xqQ1P+H1M5TvdlwUk9X+Q/XOAl5j2IrMyUPe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701280078; x=1701884878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ruISmGArzGcsBccqUUu1AYZG+a4+IBq9ZueHG2cV7Ag=;
 b=aHN1MQiayBZc2JS84vupm1FoXIwJOY8BHJzZFcL3jEQ6Fo0w3f7FhjO2Fvf5kFcuPv
 07qq4AEE21q6I1MhluQ5mqgzKV+9+UBbQQhuaszo4owui46MARdhfYs7twEVrvSSSOB3
 ZqQY4ZisaotPFS9p70MA8NaBrqxg2LKmNzjqhgyYcCIccAdJONKSkDTQmxdqgq9CDNE1
 YCR8XPkbiF8RSF3DHNUKA7DwrHE3h7VkscDCyQ6FNWYU5ET1DTNZ4akB5BwGnhW8Rv+i
 DF1YewbAFXeOj4TcLjPf40EstQUro+uWRqs0jzAwvDWSG+qoi2O8a1gxXGj+jf3qzUvU
 Pdsg==
X-Gm-Message-State: AOJu0YwuONJANL60jJdlWYI1g5FGnV3KhKajYWH3HTgWO6wiQXlGKS1t
 APJPbJlp7uuA1IFOImyVnDyjEgzX3kxYGQnlOttgoQ==
X-Google-Smtp-Source: AGHT+IGIMp85TIoKV2QbrboDqBkC1V/H5AowIFhzLMaxCFUm2wkUF3kVQMihFxy0SFf/xb5rIZ20wT16rHvFCs1l9P0=
X-Received: by 2002:a25:2653:0:b0:d9c:707f:1f4f with SMTP id
 m80-20020a252653000000b00d9c707f1f4fmr17964984ybm.3.1701280077500; Wed, 29
 Nov 2023 09:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20231129004850.2542811-1-moritzf@google.com>
In-Reply-To: <20231129004850.2542811-1-moritzf@google.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 10:47:33 -0700
Message-ID: <CAPnjgZ0a8BnVvT_XPW_ATZV52F2_JjUYynoKb3O4vMMm=MSPUg@mail.gmail.com>
Subject: Re: [PATCH v2] pci: Enable dm_pci_map_bar() for 64-bit BARs
To: Moritz Fischer <moritzf@google.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, bmeng.cn@gmail.com, 
 marex@denx.de, xypron.glpk@gmx.de, stcarlso@linux.microsoft.com, 
 Philip Oberfichtner <pro@denx.de>
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

On Tue, 28 Nov 2023 at 17:49, Moritz Fischer <moritzf@google.com> wrote:
>
> Allow dm_pci_map_bar() usage on systems with CONFIG_SYS_PCI_64BIT.
>
> Reviewed-by: Philip Oberfichtner <pro@denx.de>
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> ---
> Changes from v1:
> - Fixed commit message
> ---
>  drivers/pci/pci-uclass.c | 11 +++++++++++
>  include/pci.h            |  4 ++--
>  2 files changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
