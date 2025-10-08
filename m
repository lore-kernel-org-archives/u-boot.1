Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A4ECAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 21:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B9D840B1;
	Wed,  8 Oct 2025 22:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aU1Q811v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30EF8840B0; Wed,  8 Oct 2025 22:59:49 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2B6183A8E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-643cd58c678so162727eaf.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759957185; x=1760561985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DDWVpeJJaVoEneIlrRnSV6PN7bar4K2CsvLcQQFzxk0=;
 b=aU1Q811vl2ljv0xKNLA8pB3NFDr7sIWr4K+x8nNlDd+dg2OVTMOvGZ6rk4p88FnefT
 BOtL7A6woanC0wk/xG1kpYlK9/D7v7oxRq8tfkXAalu/Mgi6dhDV3k3lx8FjRWa4cPqq
 doHMYHPPdpCV4bSFlqH88b97Pg59VktFgJbnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759957185; x=1760561985;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDWVpeJJaVoEneIlrRnSV6PN7bar4K2CsvLcQQFzxk0=;
 b=EWX9UJp4026vXzw4knGpYaaRoM4b2sKet1siQvjuF1OBOkbnDvVY9Z+nbLVNXwgX9A
 e3lW8mEXDp6M2iU8T9/7MwlmGzkY+LmBMU3v5ww8qqWD6RUHn9vIvmgWHS/TXY/aCQXC
 RnPdsXA3v1BXOVM+zOqwom1Rdib/++YSvZniDLo7Dh6xVW0QSC+XPIASBakOQeswRvXS
 oPzNgHiZgrO8ZYRgBYsXZkUjzuQSN0lbrqLmoiWHMDaNyWwPDEL/RgxMO5GOe4WDVM79
 55bjIDs69cwE616efqtUqKAfsZCU2b0HX5Epe+5AKxgcdBTxo4uPXTPsYRE0hRWjuVvh
 Hu8g==
X-Gm-Message-State: AOJu0Yz5VBDBreq0IGpwylp6+FChsydE3fWXnZQginwjIJxfCyhQriGf
 2nG9HaWIX6+PD9XNO9V+p6CR6saJ7Uu+9/knVD5cBTOwMNtnH93ec9U6pb2tM1gaP6A=
X-Gm-Gg: ASbGncsQtb9U2+45Qn7tESzVh+RZSlYYORcDqutWO+8FikFFpMqEPmwG3alTX7e3YdB
 VzI9QR7cgSOAVrI5EtiDKTMuP1Q+BzFFpAS6G8unfq3HSmy1oX4vBVUSGo/ESmBxj9Nb8H75o4M
 X5LBaGo+0a2o5LB9clPT5bPJ9iTuW/DrDVjfwsL3UMa3aBgFN8dXHaSsbMk0ZyYDJCFgsvNaFtk
 YvYiHPyuCVMrbsjSBKpTFUOVgQ0t4fda3ODV8BQhr6Xo6q5kCJlwkLSwN0hAEND7n27dpGf07iW
 GSpmJ77hsFLgEYAseAahMRZyoSaJvmk87Zoxp4CCvKDkDdP9R2gHr2boQC2a27szPYxRP0tT1dA
 vg10j43oJEYlfhJloeatvODUpQv0tcB1FY272vIoWCn+FCbqba0Cc3yMZtHFg+EZ9LwkP2TRIZh
 FFfLiheE68
X-Google-Smtp-Source: AGHT+IE0aoPoPGdWRvfMtnto5DZabqp0OiqpODfnApJfenCFBqRWOHSgtHNf9wPEcW6uZomM3yy6Eg==
X-Received: by 2002:a05:6808:188f:b0:438:2629:2fca with SMTP id
 5614622812f47-4417b2bc87amr2603954b6e.10.1759957185547; 
 Wed, 08 Oct 2025 13:59:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189a67d27sm226052b6e.23.2025.10.08.13.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:59:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250925205620.3562599-1-trini@konsulko.com>
References: <20250925205620.3562599-1-trini@konsulko.com>
Subject: Re: [PATCH] thermal: Make U_BOOT_DRIVER entries unique
Message-Id: <175995718477.3059512.11237960273893806559.b4-ty@konsulko.com>
Date: Wed, 08 Oct 2025 14:59:44 -0600
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

On Thu, 25 Sep 2025 14:56:20 -0600, Tom Rini wrote:

> All instances of the U_BOOT_DRIVER must use a unique name or they will
> lead to link time failures due to name space conflicts when both are
> present. In this case the driver was reusing the ti_bandgap name.
> 
> 

Applied to u-boot/master, thanks!

[1/1] thermal: Make U_BOOT_DRIVER entries unique
      commit: 78849ecc185610a89e2294265f42b75f84e4324d
-- 
Tom


