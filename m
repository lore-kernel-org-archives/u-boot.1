Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C1DC47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 01:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39CCF87D8B;
	Tue, 30 Jan 2024 02:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BEXJ/21/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 084C787BEE; Tue, 30 Jan 2024 02:54:18 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7491E87BEE
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 02:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-602cd92a75bso34407327b3.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706579654; x=1707184454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuP+yad/doOzrcOBJfUc3uit5OsQREhQsPmiEW7n3cU=;
 b=BEXJ/21/TjPAwq0lqV1kUxOt8MYRuu6C9wH8FIb1+3xYtaimsIHKPFN/A2kt2Ya/gJ
 aALNclpZWMWxysVxc49zNfm1nfHl767K9zwne/KgIOKLZc1I7ZZNfljE3zkRzuDcku0a
 JNAEJH6jZF4DsIx1DftHF+0CsVOrrt2kAl6x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706579654; x=1707184454;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VuP+yad/doOzrcOBJfUc3uit5OsQREhQsPmiEW7n3cU=;
 b=E3mJLCyUhmCjBxlV6s2gqb+xzxR8UeykEHFOTE7OodL2CkF34ACBu93XloOujdi/0O
 uJQFiHTK6//Ts658vQEhGM0hve7+o0/5iTpQ0JUJ9AxzhGVtw9DP9HI7F5BC5WyGpgta
 saVRYAYSxWWfwbbdGR19LZ9s6X3zdiYZg0apbdcpmdaywpRgjN9SagH3JItXvwJftEJn
 M2ozHRYRrNlmUZ7jDRC7mGphuAPHCyXXH0TE2cmOvMy8dyAtiIrDQRtrOtC5977SGNit
 1zg5XxgJUFLiY/zs8n5/8ttPwM9umeNF0p73gFq7/9HI19D0vK2RiddA/cRoKzHlNg1x
 ew5g==
X-Gm-Message-State: AOJu0YzVDPkIOPyoyyA/QVY/djNSdia52o3izp3C9D8dYiz+Xi8VqKAW
 rwDglJBC7ZPnUwmgU/C0+BVWB/UzSq/zWZ8gYNf/4/CN3w2n9bhe3CJn+e4iAuvwb/OD89ifnUm
 h
X-Google-Smtp-Source: AGHT+IG8a/Q/ZudkiE4AduRqcPCMn6gAyaGhC9F3TjoamtTjW+zAwlYO28eSNzvSUrHxMARj9Fv8kg==
X-Received: by 2002:a81:e205:0:b0:5ff:bb43:2a69 with SMTP id
 p5-20020a81e205000000b005ffbb432a69mr4436247ywl.40.1706579654106; 
 Mon, 29 Jan 2024 17:54:14 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 x124-20020a81a082000000b005ff93c11cf5sm2881712ywg.100.2024.01.29.17.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 17:54:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240123-safeconfigparser-v1-1-1312af945f47@theobroma-systems.com>
References: <20240123-safeconfigparser-v1-1-1312af945f47@theobroma-systems.com>
Subject: Re: [PATCH] tools: buildman: fix non-existing SafeConfigParser in
 Python 3.12+
Message-Id: <170657965345.1823400.12107325585826343279.b4-ty@konsulko.com>
Date: Mon, 29 Jan 2024 20:54:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Tue, 23 Jan 2024 18:57:01 +0100, Quentin Schulz wrote:

> SafeConfigParser was renamed back in Python 3.2 (yes, no typo) to
> ConfigParser[1], but it was still working as an alias until it got
> removed in 3.12[2].
> 
> [1] https://docs.python.org/3.8/whatsnew/3.2.html#configparser
> [2] https://github.com/python/cpython/pull/92503
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


