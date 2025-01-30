Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D87DC0218D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 23:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5903980F1C;
	Fri, 31 Jan 2025 00:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xdvt33uZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B34805D7; Fri, 31 Jan 2025 00:02:27 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32AB80F0E
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 00:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71e2764aa46so878123a34.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 15:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738278144; x=1738882944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tX8PF5s38z0WMLNURrT58rcQ62DNfOI08+r+RqPFQLc=;
 b=Xdvt33uZ1F8dGvUyZLbUMwh0SV3wGY1A9wCLnpRUrMZEWkKGmEF4/l0+RlzHXWk8Mc
 YT8vxycAkuOeO0svwAtdar8gJG2iVQqzTAS5gTer57hH3hQG6uaMKH/KB2jwZfw3GBq+
 kFzw0PHpR9crbldU6EynCIFatc64ARpJAAvdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738278144; x=1738882944;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tX8PF5s38z0WMLNURrT58rcQ62DNfOI08+r+RqPFQLc=;
 b=xROvX72Wsqoczucr8T046w4KMX5DTho8+WmeKWpFvj7kvIUl6vewme4F0PiKESStlN
 QVadTzbMVUvk4F7SwiIKxW/FmfaVyBFCD50PoKJSKYdRqreddTfAq89RO+1GsCxQSxfS
 hdNMbt6PK8L827XeZg5yePbPzLE9TfONV1XohlRaVuTmboeltUpQClaLsz5syEJxxThl
 aJ/4NldfgX5S4cm1bZM+8x8/TXp+/b/nOPUBY93LkfbZsH/awdwpIozWS6MFxpbWoqmi
 zittKrwAyTqGrbJ7cTpnh8jU/m8F0ta9Ir0WJh0xqdB6k65Rsc0iwJN/LYM1drNpPWnN
 biVg==
X-Gm-Message-State: AOJu0YyATIQlR3Ux5oJlraGCWgkW2v6gtf1bTDC0AJ+6765GsQZdNkSb
 LsYnceoDVh2avVIYssesC/4WxvDV/eht7Ek2B+gK8eFPiCLTIQ/ozbgDA70kKMqUhZjCew+6WAp
 z
X-Gm-Gg: ASbGncsyz3dXjy4KLpIyW7WC1Xb3e3G8e2KZSbhsju39ZOvzoi1/pMvimcsXgKrN7OR
 EurwAYwjftm3kQlpymte/0XgyTTkroJfQaX78AgikoyQ/+4KISDxh/OFwjFPyP7HDxh/K2iuale
 QlljSu1grfB5pQ+6HBRUN3pkv5uxPOWssPDbKLldvgWcZze2o9tOUQZ/CuQqFwq93e/eyAfTdGt
 rkH8xfNp09VAgvnq98V2NGuY2MWRhXyl274B3086+cXbtsDTBiPz3efWarFatYdxTcN/8a1fDVj
 rR/tPHKLy7grNA==
X-Google-Smtp-Source: AGHT+IGfvomVgCSIR3S80sw/pyeuEi2F4i3gTlyjkG5GdfaEvM7yeFOc/xyZLR77EegD2HebEz4Azw==
X-Received: by 2002:a05:6830:4703:b0:71d:fa78:a5ee with SMTP id
 46e09a7af769-726567613c8mr5964402a34.11.1738278144402; 
 Thu, 30 Jan 2025 15:02:24 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cda0fsm564725a34.25.2025.01.30.15.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 15:02:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <cover.1737621362.git.weijie.gao@mediatek.com>
References: <cover.1737621362.git.weijie.gao@mediatek.com>
Subject: Re: [PATCH 0/5] Add support for MediaTek MT7987 SoC
Message-Id: <173827814353.2499127.1843985702962899289.b4-ty@konsulko.com>
Date: Thu, 30 Jan 2025 17:02:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 23 Jan 2025 16:54:42 +0800, Weijie Gao wrote:

> This patch series add support for MediaTek MT7987 SoC with its reference
> boards and related drivers.
> 
> This patch series add basic boot support on eMMC/SD/SPI-NOR/SPI-NAND for these
> boards. The clock, pinctrl drivers and the SoC initializaton code are also
> included.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


