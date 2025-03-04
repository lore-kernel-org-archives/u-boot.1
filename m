Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16720C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0709B811C1;
	Tue,  4 Mar 2025 17:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mN2FLMdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367FD811B3; Tue,  4 Mar 2025 17:57:36 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F42E8004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6fd9d9ae47cso4642317b3.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741107453; x=1741712253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8x7+t6L+FlG9XJlVau7y1D0ud93s4nLIc+UK6cHJ0Xw=;
 b=mN2FLMdPdedDlFRvEg6IYjTNmP8k97Lj80XYiapbHGUbXk19z33uSIFB7EEr0kQ39L
 7LzOk7cim6ve+59T2tSIIFXKJnzXWoeZ/aHXCBjmVaCoG9aP7WZJUfYTp+tjtmWwjxt8
 ibucZi869P6DAU09AYnslX4Siqc8gMSCk9cnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741107453; x=1741712253;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8x7+t6L+FlG9XJlVau7y1D0ud93s4nLIc+UK6cHJ0Xw=;
 b=MABz3EGcwWYT7GkRTS/mAkY5zGmKBrcGC2GsQ2ahfFaNgAUldHRQvmKOIZcD6ZLJjl
 Gy2zyBpnCk0P3fSaOMwvgeykclRSjaE60h0QtcU0+5Nl2ivkorBQ3HfGnlGffloPQHwt
 55yYmhccrST+NLldjA019QIMY8WgEv97QkQ03600PCGLO3JCax2ZpWIMyDi2/3WYA4n7
 b6vJOOToNBq6OvGncNB6UQNjJ7MuquHy0sqizFqpLoW4EFOwUoHUrWjM9JzKuxEyGz+q
 s39nDfzHuOktjimPGPgl8Wqlyv544t17qhchH8h/latZKOe+Cnd4OrAqNoCMupE7C9Mn
 laWA==
X-Gm-Message-State: AOJu0YzX3GXns9HnEhq+0kikAQgGeMp4tZQZSnWXaHbulqVfgA7fNt7t
 U42rYC/8mNZ5yhXtVjt5+P+kpAapQhczvq4ir/9drS+chihYKxOE5M1zNRVGB4w=
X-Gm-Gg: ASbGncuhkg6/CEtxUhftXBJFwtfiEyiskBFxJZOogqhaXrsPT1p0rlTU6ttILdb8RvP
 xeEkBUulGLWDTXS15bqeHXi7JZ31HaZ/NQg1zNfLo5ddN1x5sIaIMKe2NWOzuvIENTxPe94XOUh
 82/I34+zCV+bIZNb9sOIshTAPFGS6ngf56mZ11gMk+S9IlCCS6GTTqZXz6Cu70nAzT/U6lswu8M
 ERs8i+7zX7dIENJT5nZdTNMKnscoM3zoNJJ5hGGZ9YJ31cl/Jflo/Pu7Sq6sgfdPk9Z4j5ET6v7
 Mon6tUOj54Wo7UhZ83hhgAF3fwI2zB4O2E5NwAFrhA==
X-Google-Smtp-Source: AGHT+IG/XHUsOObY7SKgLDZpJblc7ygRWQV4Zt+tpYChBNh2pBomLo8h9bQwoXUZGKtuJvdPxZtPqA==
X-Received: by 2002:a05:690c:4b03:b0:6f9:97f7:a5c4 with SMTP id
 00721157ae682-6fd4a0c29f8mr216277507b3.29.1741107452942; 
 Tue, 04 Mar 2025 08:57:32 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3cb9f7casm25268957b3.108.2025.03.04.08.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 08:57:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: francesco.dolcini@toradex.com, n-francis@ti.com, s-k6@ti.com, 
 w.egorov@phytec.de, emanuele.ghidoli@toradex.com, 
 Stefan Eichenberger <eichest@gmail.com>
Cc: u-boot@lists.denx.de, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
In-Reply-To: <20250303181618.41802-1-eichest@gmail.com>
References: <20250303181618.41802-1-eichest@gmail.com>
Subject: Re: [PATCH v1] board: verdin-am62: fix missing memory fixup call
Message-Id: <174110745179.1812793.6051574103571645813.b4-ty@konsulko.com>
Date: Tue, 04 Mar 2025 10:57:31 -0600
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

On Mon, 03 Mar 2025 19:16:03 +0100, Stefan Eichenberger wrote:

> The commit bc07851897bd ("board: ti: Pull redundant DDR functions to a
> common location and Fixup DDR size when ECC is enabled") broke DRAM
> support for the Verdin AM62. This was partially fixed with commit
> 3f866c47b582 ("board: verdin-am62: add dram_init_banksize"). However,
> because fixup_memory_node was not called, the Linux kernel was started
> with the wrong memory size on modules with less memory available. This
> resulted in boot failures. Fix this issue by calling fixup_memory_node
> in the board file.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


