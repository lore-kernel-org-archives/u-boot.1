Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C305E69E8C
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 19:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A6F389492;
	Mon,  2 Dec 2024 20:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="abSBWjvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FB2D894A9; Mon,  2 Dec 2024 20:58:53 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77310894B7
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 20:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-46695dd02e8so48438151cf.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 11:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733169530; x=1733774330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zkm0YjjOMJpatU7eGEWkj5z5azQbBRuF/dajslDOvl0=;
 b=abSBWjvjOfUwLE2WkMQLAxGdElN/dRKRCqLPdT4uZn/XK1p738Pl0R80PEtoVmEoZe
 teapxKwkDoDfEo0UrhWhfhPOpJXz3eeqiyO7VDYc19a9VgS5J3AWOOp8tV8wyg8VHYB5
 3MquEknUnEdqsB4RRRLQ9Y3ZqUUgb3m3vaL8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733169530; x=1733774330;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zkm0YjjOMJpatU7eGEWkj5z5azQbBRuF/dajslDOvl0=;
 b=q3ncjYA0YzWXmsjXuo9DfhkT/sv6DwdsNChyux3L8TOOY3mjd2sPh+gII+DapTbmyQ
 Ra/Kacd48sVIWbKSJlDyZnhoimijH1UJ1YhvUugMM8ma7/qfLa2wJZoqgNulK9WJ7HAr
 Egz1Jsaj1M+2QCvBwkHk1x2Rn8QNN7vL5o2Zq7vq65+AmxRAEFC/RQnsa76dyhmD/7YZ
 kfAYcOAzVEr5hVzBHfVUVhegYAANwdmBBVwTZg/2eUcks500Xbf9wLymJm6jaq0/ptkH
 g1v2du/yUOzL4tG5lmvcjIta2kLAOPVXLuzt+mHcEOOqepyxTCwB+5s2TTB7DDZTmU8G
 GxOA==
X-Gm-Message-State: AOJu0YxMiUoQr4lg692WBH5dnjXwM2fAv7Bfb+pgWde0H4zsLm+3qfGU
 VXdcGe+oiYMVCBVmh8QXiBiAgCMT4Kdp4Bf/xi82NyqeJPs1ciF/xiq96PU7JBk=
X-Gm-Gg: ASbGncvJ6SEuis73KbDS0ITurtrDgn01t5ZueB3f93Cdmv1KTGY0cnlKJ74j06q4lZi
 gfa7wBfjLdsSsERVC4/mckbQOt9ceAHPmeXLhEm+GcLMX16DmU79c0KNyJu6s2DW3rDhKeqpUye
 70wEUr3m+wmyqsvD5yp8SFOz70HU/w/Ft6f6F5U0eHpzL9nSQQU523O7lyKCUxDxosYq148+qDr
 WfGjmL3U1O4Gf3i4NKlvvr769i5DOLZPlr1SvW44wvnmThC
X-Google-Smtp-Source: AGHT+IG+qMnAomf5+k46KaqJMhcYEedR4mkgt0+/1qYL4f3fCZTlsTWZnzPxfIdrjpYM3PuJRuO7lw==
X-Received: by 2002:ac8:59d6:0:b0:466:8616:2553 with SMTP id
 d75a77b69052e-466b36b839dmr393460781cf.48.1733169530363; 
 Mon, 02 Dec 2024 11:58:50 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c424a31bsm52870641cf.82.2024.12.02.11.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 11:58:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>, 
 Stefan Roese <sr@denx.de>, 
 This contributor prefers not to receive mails <noreply@example.com>
In-Reply-To: <20241201144240.1664398-8-sjg@chromium.org>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-8-sjg@chromium.org>
Subject: Re: [PATCH 7/8] Revert "global_data: Drop spl_handoff"
Message-Id: <173316952838.3421598.11685939432742035788.b4-ty@konsulko.com>
Date: Mon, 02 Dec 2024 13:58:48 -0600
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

On Sun, 01 Dec 2024 07:42:35 -0700, Simon Glass wrote:

> This breaks chromebook_coral which says:
> 
>    Video: No video mode configured in FSP!
> 
> This reverts commit 2e9313179a846b581c0fc3f6a49e19f3d343efa8.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


