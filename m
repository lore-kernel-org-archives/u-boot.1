Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03938E92716
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 20:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC73983CDC;
	Sat, 27 Dec 2025 21:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gNl2xi0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C26CB83CD3; Sat, 27 Dec 2025 21:11:58 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B46383C6C
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 21:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3e83c40e9dfso5173752fac.1
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 12:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766866315; x=1767471115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2AtMm5IAiWLWXLvPV2Fz5ECvzEmZ5HtEHgxlWs1gXI=;
 b=gNl2xi0EIuIglslxZPdFAwoBaoWdggpFWMgXKZ26pCDufQEk+3O6JgKkEjpDiXjw+V
 fBwDKQlOGFSCJXcctBQdaDaBFtApxbC7bXHouyK5pRX7/Pr8/Xy5wU8hDs2cWEcvnrkN
 RVKbv+c8Ui+ilwLJG1xWxUyQyF5g3TbqD9bWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766866315; x=1767471115;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g2AtMm5IAiWLWXLvPV2Fz5ECvzEmZ5HtEHgxlWs1gXI=;
 b=Dn2Mphj+/yQaOsZrmshFSkgPVU3+NUapb7XGQWKb6J5/5J3oqHM2qhfbLUTo3Q4XkP
 7pyYeZkQy+N1XoHKkOuX+QnqgETdNm2YBqhbcLbL6/cENsKGqyqIeSJZEhiMMYi7Jvoa
 E3oOAwakPSs+FejjFlCxzDqhahItCViMQ08t1xME650adGHRjQBr98JHDzJtCFHtAy17
 Ud8QmncBtbtbGV8Vnm4EoN6EVz/OMf27hfUEsT21BgsaOy7qc7GPsJZsKo74z/Q+LCZt
 cZ8gswxTaZSbhaGI7rntZ+6r/AFYlGaVX4G+Tl4837+IIWhqr7eAkp3AIYcqDkcwpmtS
 1JuQ==
X-Gm-Message-State: AOJu0YxO1wpiCCSCOkMvFFSDxucn2unRS2xWO9tgCfYi6vaxqdNxmDhB
 hgg1IzLJOEa7bPrqfQzKPBIuvhFy+OdSC/TYvrAwsM16nCa6Dp5hEjc+uA6JCdVGReoTdwOTKmO
 SdRctNZY=
X-Gm-Gg: AY/fxX4rh2stWe21uj1KIPQgOLKFDf+2oVauXg4uWgytxf1kBMvZDSdjFv40/f7HE9d
 zUbrV6kNkyM/qT5+/wx7adF4xj2qb9wQVJJijXACrVyGQK4KQPQpggr10rBXkx7CjfLZKYnn14A
 kzsg4ZvXYIUTCRw7MMRiTT2SUC/Gbwk9iyBQFepee5X4qkGsrDS1N6bGX0XWSFdsRsou1w9/mnK
 Z92mH57uesCboXG3yLLu6hz4IR8zySxSsUJXeC0qHa4VVntVs32RdEmN5DSfYKyYqiDvvaE/yZ2
 UezkfKJXp0CiiBQ9vqM7uc026ycWd1NaxnIDp/4OPHCe+9ubiPeyJ9GI8wklc5sChXlD9O4D1Jp
 +di/WpfxoPCAUcBjcyzpLxVA8GAxi6QLKo0+BsDS0pTH3LMvRqP9+Ow8LRULh93T85EqoK/luIX
 7xT8EkzJGzznbuY3oxvIFyb/ZX1PB7RwV1KE5vctA98OgZY2dC
X-Google-Smtp-Source: AGHT+IHXL0TVMk3IwpdLXmEvX9w2E5P37CZWScj5cTVAflX8XlJrt8QluVZDXRBrUPDFibFfBCYThQ==
X-Received: by 2002:a05:6870:868a:b0:3f4:fa99:29fa with SMTP id
 586e51a60fabf-3fda56bf997mr11939106fac.24.1766866314660; 
 Sat, 27 Dec 2025 12:11:54 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d366esm16223040fac.5.2025.12.27.12.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 12:11:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20251121161751.11849-1-marek.vasut+renesas@mailbox.org>
References: <20251121161751.11849-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Message-Id: <176686631317.2992512.2694965427082582275.b4-ty@konsulko.com>
Date: Sat, 27 Dec 2025 14:11:53 -0600
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

On Fri, 21 Nov 2025 17:17:37 +0100, Marek Vasut wrote:

> If CONFIG_OF_PLATDATA=y , then the udevice has no valid OF node associated
> with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_default()
> call ultimately reaches ofnode_read_u32_index() which invokes fdt_getprop()
> and passes result of ofnode_to_offset(node) as an offset parameter into it.
> 
> The ofnode_to_offset(node) returns -1 for invalid node, which leads to an
> fdt_getprop(..., -1, ...) invocation, which will crash sandbox with SIGSEGV
> because libfdt can not handle negative node offsets without full tree check,
> which U-Boot inhibits to keep size lower.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] clk: fixed_rate: Avoid calling dev_read_*() if CONFIG_OF_PLATDATA=y
      commit: 3c43ca3025ef424a484101e265b8427e3a364303
-- 
Tom


