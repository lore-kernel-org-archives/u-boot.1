Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1F5D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 17:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E4283C51;
	Fri, 28 Nov 2025 18:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GCTh99Al";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69F7E83C19; Fri, 28 Nov 2025 18:41:29 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A61983B4B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 18:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c6d699610cso531130a34.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 09:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764351686; x=1764956486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXVMud6Jya7Nex+9rIJMfqieSUFRZy0jidjzS6Gojxc=;
 b=GCTh99AlPHzxcM97m+BfWooBa/xhXEcRlg+9OXgzVRY+X5oKmmLdwgfnFCZiKbD37U
 aBBOsIOcViO0Y1FARAgfzo4PJGjjT820Ao9b9XE1da8MM59s0RTUPx8qoGBxl4W1vzYO
 HK1Mnt0s3d4EK69B0w4mUj9UaK+pHcSIBAZfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764351686; x=1764956486;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DXVMud6Jya7Nex+9rIJMfqieSUFRZy0jidjzS6Gojxc=;
 b=lE/El2XIQj5fIR5nFwr8nSOM1f+tI8RP7V5qZjlpWWWzWRGjYNfdJCPbaKYJkQSipt
 jUPIrbv9oeIJ1yXVva2JvhhwCFvoykKlSLvIFlON0BClqPJY24wRWSocVLImvRhaa7RO
 gFI7ljJQ3ROoMuU3/7zKr4D7boFIJSxnp249dCH3oVAI1EoX56nABgYzRq9USDlmpF7d
 Dr353emWFYZiLP4eeYOC/tcytWP/YGRyd5iDLI1iDGDmq78ILAM8NL6WuqyHXln42/i4
 hTGW0ipYjGQ2rYJq9Zs0Ix/lwWRGuIrtm1rTu5uULVXHfZl5X9UUL9t9mAK5EEPYBV9B
 ROUg==
X-Gm-Message-State: AOJu0YxHsFJEURapfeJjwFiOc8DND78DpFWxzKFz9HPLZCC8G7DbUubM
 bMc5eT2bZWfBZjy3tfsoponc5AaznI359PcneoswjQ7XK+wRffYb7DaLzzdrNSnecGKIW41d+6d
 7OdgfEt8=
X-Gm-Gg: ASbGnctL1WGYOdMsu2fhvT3tmOJt4+26wYP7f5cahmIEwph7lDX0cx+oczAnnJAMs8l
 M/C9CkFmE7JgI7yoVA8FGMxx/UE2dlStcxsOew+TDcY66QyavoOhSc4dTDVbYTzXkB0H0j2wNa3
 pDC5aRULKTcv1+pc1nniOQ9B5KsRiQ7iTH/uFhrIxqWBkzgK4plSvbVM7ViiZOXkXu5NxkEytL8
 DajyrV6zkuvaS5oNbuhq9jS9Uy8VI/cxXED3c1rQqj2Lsbd2HRSDonBNk5wWOxarxQq49zXXJhl
 paUI5t/m5LRQD9C5wQsxuy/McvK0+W8PQph12UdHC3m/De3VSwamzZq1fjPvk5z41pDVwsxkzRc
 Zl/HSiKBO+2i0kx3hjD3AkT2ujrYFWT8BEycibxWxTEBt00ALXbsmciidG6spla6XcyKByMht/7
 EOOim/K9hmAiYqD/pFcMH/UOeRT3s3krczkMyu09dzpYmZyo/m
X-Google-Smtp-Source: AGHT+IEkgiLLIcg9k92pY+MaHACUyfaa6AbUd0sURSQ1bo7opX5z5CMC0GOmdsNqUpSRQuk4sWKrtQ==
X-Received: by 2002:a05:6830:6d86:b0:7c7:7c64:d9f4 with SMTP id
 46e09a7af769-7c798f9df31mr12326642a34.9.1764351686013; 
 Fri, 28 Nov 2025 09:41:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0f650sm1771543a34.23.2025.11.28.09.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 09:41:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20251113115811.947992-1-marek.vasut+renesas@mailbox.org>
References: <20251113115811.947992-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] test/py: Use aligned address for overlays in
 'extension' test
Message-Id: <176435168504.233357.10150757424515024306.b4-ty@konsulko.com>
Date: Fri, 28 Nov 2025 11:41:25 -0600
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

On Thu, 13 Nov 2025 12:57:52 +0100, Marek Vasut wrote:

> The 'extension' test would set 'extension_overlay_addr' variable to
> decimal 4096 due to conversion in python. The 'extension_overlay_addr'
> is however sampled using env_get_hex("extension_overlay_addr", 0);
> which converts the 4096 to 0x4096 and uses that as DT overlay address,
> which is unaligned. Fix this by setting extension_overlay_addr to 0x1000
> as intended, which is aligned.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] test/py: Use aligned address for overlays in 'extension' test
      commit: f74353099016a22500830adda2bb0558322b414c
-- 
Tom


