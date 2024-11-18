Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3932ED49225
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D56689466;
	Mon, 18 Nov 2024 15:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KRAUmVig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA26789160; Mon, 18 Nov 2024 15:19:40 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B45ED8931E
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-460c2418e37so26530871cf.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731939577; x=1732544377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQR1GsVm4CzkmGmkzC75HjIqxoWVEqho9Tv6mQxESrM=;
 b=KRAUmVigVNrsEvu6tcn5Y5ZCfk5y2KRZD5zdehDyk4UUWzd6g4iE4vnTyeE9u8me6x
 YLdsoa5zsSKhskjoRlRBZCQIWU7hEQE4sXCDUvBCY7vo3UKyHrk+vtHAxPzWRyFyLGcl
 1a5M4KikzMwhjzJccc5Mifo6iUpoQFvCtcdFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731939577; x=1732544377;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQR1GsVm4CzkmGmkzC75HjIqxoWVEqho9Tv6mQxESrM=;
 b=upkI8r6sfBxhaZWQWztN57SsfmuQY+Pzi76xMhd3miUSKXFB+SGh8DHCcQP5fFgWmy
 +2bjc5sS3GMqdC8uwiV2DKVoJpmn/XOcTE+oaOfzKmd5tze1//1l79trtjGTBuFmunm7
 CBZkUpz0iN010PehPrSFBXnsW+x6AtBAKebEH1cN+7qSGVjgYyV9FkpAaFVhcdcC7fm1
 ru1JTru+pzl2/DDkqYGrif/kmIdXjwJni/BO2AUIGNCVfb/miYJyo+Gd/ghjGlgjERKr
 iUyF4qcQUWYWK6n/E3CX3h9m4AEwfKDcgH9BlQ/XUbDGnBP7fgdQ89evo4D/uzj/EugH
 YWHw==
X-Gm-Message-State: AOJu0YxQ5FCVhC3KbBaMxdNIX8Bno8wjfnCx6epGu+qHJ6gVUt9Dj6UP
 nOIZ7e46xYUHZlto2u4p9gluQwRqw16v+0mZ863Za6TS6quRmC5iiYWAB+uiZDI=
X-Google-Smtp-Source: AGHT+IGr4iuOgqeXZwjp61EWcp83N981EEHdn9MtvpB4rz5v22DNOOiGGYe/7bHGILB+Ryf/QPsy9A==
X-Received: by 2002:a05:622a:1927:b0:462:fc73:45f7 with SMTP id
 d75a77b69052e-46363ec0c8amr182077351cf.47.1731939577694; 
 Mon, 18 Nov 2024 06:19:37 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24e44sm59075981cf.59.2024.11.18.06.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:19:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Ion Agorria <ion@agorria.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20241108163612.1.Ib408a6723ba954c932968419678bd45b0767a470@changeid>
References: <20241108163612.1.Ib408a6723ba954c932968419678bd45b0767a470@changeid>
Subject: Re: [PATCH] console: Use printascii for lowlevel debug string
Message-Id: <173193957628.3366111.6143494542279913856.b4-ty@konsulko.com>
Date: Mon, 18 Nov 2024 08:19:36 -0600
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

On Fri, 08 Nov 2024 16:36:23 +0800, Kever Yang wrote:

> The lowlevel debug with CONFIG_DEBUG_UART has printascii for string
> print, and no need to convert to use printch now.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


