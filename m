Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B0BC44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 20:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D783683946;
	Wed, 21 Jan 2026 21:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SVBs/BES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867CB83A1E; Wed, 21 Jan 2026 21:48:46 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5BA1839D5
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 21:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7cfcebf1725so167362a34.1
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 12:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769028522; x=1769633322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTJAlCpF8m/Xnn1Uwbz0TheWy416eem6a9q3LT+LzNs=;
 b=SVBs/BESffR9kTJpv4T7ox0OtU3QRhiEGNdnf1l1E0MtZN52MQwDT2KrMxTLcn2Kha
 3DPjP9dBHrd3K97xajhgD6KdzF4StX7xc8tyB1kMLHDFst4SrXWiR8PPFJvl0pEG5To7
 iZPsxon7jQKeozYwRwan65QcOWHyYGfsXnF/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769028522; x=1769633322;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VTJAlCpF8m/Xnn1Uwbz0TheWy416eem6a9q3LT+LzNs=;
 b=vnB72dEeRtQbJ7xQOGBAmeixBIps6A4adtYnxiHQzSlzyA4XI7nprP+ssT1nahS9K2
 1bwhCYTC1UVwFqcymj7wcwNMBx9s9YggxX78YPj8Pj9fPSoIlACRsPEekPVRVz39+My0
 pygSKueOUfJcXwQ0n4DBQWLhJFnQ6W5lxabtheT03vkLATlLjH7niYuLU2AgFMoR06Fe
 B3HmetIIRe3u5jL/CB6ZqnBYJlP8B6DKDQWq17isz+172iVgZGPn8i2xBCvHuDGgpILL
 +FPkzxKaiavaXNcy6MSDBQ5mbmUIzLpV8tScKk8U6Q0H6Lp2g0FmJh27+4xH3liUj8ob
 PiDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTLz8N2BiWzPxW1+8ZAmYpsLwGYJEErrGV6E7KB3CM/NlhZcP/WPPY6/ZjKh6Yn2FfyCApUFI=@lists.denx.de
X-Gm-Message-State: AOJu0YwaOv5hZdE/J2n/xWxOpCCfAvPzQyJ//MSFNgLrsSiF6JzVqrQa
 /0qBV4034SpFyQwPGcYbXSd07TJDMvnl39YgDI/43L20hKZ3Q2fAn2h90BmibWOU+QqAJoeBH8K
 i2J7xU6w=
X-Gm-Gg: AZuq6aLYYShEiW4DNM2bQ+od/jILfFFqlPoxqp3xovuo9vSfAmhuDjJ7gm4zm0GiEf/
 bG8fNbJ2bQeGyVSNzJto3/MmcS80ZQp6rupUmMUjcG50FxEk5iiXnzVymx40QgubzG8NfwKngYu
 oEPYvdT7gZMS8akRuGgJv6pZiat8MMujnl9Y73d3BN9VFO+tdxC+Ilf3BldfbGtHbAQ0HipzENU
 1IxBy5q2H3yyAyMbtXXCiSe1WQQ30McYgCGq0izE6O4wK26IdFWRT1HKNyg2pLXXwu4KlhgKHKf
 bkS3/hs5D8NopQ+OThIhULgWpgkhHfx2LKRb+MOheUKzX+Ajgy1SvBfjMmOdfy6Ki0o8CL232SZ
 kXAbyadbP5oCjBW8SVT1GiFiq+DsmU/iWkxkiVUl2NIc1NFq296H89PtXyCqDTHa43tuUvMzc2w
 +nxpGloJgZGIrJbXt+6yphyxd8m7fRX743t4E2erb7DFbRNsPQi6p9KvHvSLWYCNtSFKEvMFjFQ
 9HvyQF8niu0+HSTAuW7cL0Y4copV+uxzH/zGA==
X-Received: by 2002:a05:6830:82b6:b0:7cf:cebf:b41 with SMTP id
 46e09a7af769-7d140ac22f4mr3347917a34.31.1769028522413; 
 Wed, 21 Jan 2026 12:48:42 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8e05sm11134487a34.6.2026.01.21.12.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 12:48:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260113-pinctrl-mtk-fix-reg-calc-size-v1-1-3846c53fe010@baylibre.com>
References: <20260113-pinctrl-mtk-fix-reg-calc-size-v1-1-3846c53fe010@baylibre.com>
Subject: Re: [PATCH] pinctrl: mediatek: set array size for reg_cals
Message-Id: <176902852113.661474.2197988569768974774.b4-ty@konsulko.com>
Date: Wed, 21 Jan 2026 14:48:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 13 Jan 2026 17:25:52 -0600, David Lechner wrote:

> Set the size of the reg_cals arrays to PINCTRL_PIN_REG_MAX to in all
> affected mediatek pinctrl drivers. This is needed to avoid potential
> out-of-bounds accesses when they is used in mtk_hw_pin_field_get().
> All array members need to be initialized since the code loops from 0
> to PINCTRL_PIN_REG_MAX - 1. mt7622_reg_cals was already defined this
> way, but the others were not.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] pinctrl: mediatek: set array size for reg_cals
      commit: e63e2e797e3ccf85a8394425e954c06e435c161c
-- 
Tom


