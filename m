Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A91BC5472F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 18:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56A5B88A46;
	Tue, 27 Aug 2024 20:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hsW7N51D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27FFA88A6C; Tue, 27 Aug 2024 20:35:45 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACF9E88A3E
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 20:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-45327512c3eso32352281cf.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724783741; x=1725388541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hawh0c9aiIP5EE3tILPx/RcLDJoqn9N/NuVPqcfXCHg=;
 b=hsW7N51Dh/PoBH8ZRDjWjLeLXRW6+VtyastTYR+q1hm0EDAe1UZnuAEyz5Ty/LR517
 +t0Um8ABsrCusI3tQc6DKVacI+Vi2x9mX7S7m6BzSpN3uYQIQzEfMb8PboUPCSM/oWGL
 iFl6DYRh3UqGc82sXiNRtlOl7OPRq3Gzpbc4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724783741; x=1725388541;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hawh0c9aiIP5EE3tILPx/RcLDJoqn9N/NuVPqcfXCHg=;
 b=lCjnCnIMIWjOvOub8KlLKrpOUfCfUaRkzHOukoqNzqpplqILpj3C4GAITgpqQ/QoD8
 MqK//YMQHzMFtQTIu5pv57ZXaTR10KOeq7JrXq2WSohrS8F1/BIDybMKpbcKzpfxjDGl
 x0Myk261IwgLkVlSyQftZX3ZneEt69VcesyQtPqeQSTPCHKvkk9CVPTwTXTzZVOX4lUM
 PDeYX7Si62QlWoTaMNdeiUtbT5p/DIOgIQB4WNeTpDsIj729oEhCaY7Ms4BlAGFMKx3K
 T7PCXNy/MJTnUh7gifTrrZEqRQt4mfJzGITwn9atTWsE3h6vMOw7uvYMvlDb29AXXLsz
 igaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+AJ7SYgqEZsH6TKfY/uhqjiMi0MtBZilAwe/SONNZSEUQhhqDrMB5pSJ1MwUa/mUjLoFbYVk=@lists.denx.de
X-Gm-Message-State: AOJu0YzbupZzc82ULptR82mOEa7GkhoQ1aq95GeG9WTzhAoUeifUsjxG
 eaQI5smFDV3A7WQHZwj+poauxNwIcdM023YQ1/Bs2PagvpsHTlSzZIaW79P8MD4=
X-Google-Smtp-Source: AGHT+IHEFSV6ijDyhdegNmwpWHluB1MmU8XUgvn6tGAMAS6YZPsTnc+5SNZpnWX4OrR8jrwJXuBCRg==
X-Received: by 2002:a05:622a:610c:b0:450:180:11f0 with SMTP id
 d75a77b69052e-45509cc1762mr130118021cf.50.1724783741246; 
 Tue, 27 Aug 2024 11:35:41 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1c9c9asm54635271cf.89.2024.08.27.11.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:35:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>, 
 Tony Dinh <mibodhi@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20240808070803.57438-1-heinrich.schuchardt@canonical.com>
References: <20240808070803.57438-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] ata: dwc_ahsata: create boot device
Message-Id: <172478374015.2927671.9083718953730377064.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 12:35:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 08 Aug 2024 09:08:03 +0200, Heinrich Schuchardt wrote:

> For each block device we must create a sibling boot device.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


