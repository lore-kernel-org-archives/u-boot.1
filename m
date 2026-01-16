Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA83C982C3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 22:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3B68394E;
	Fri, 16 Jan 2026 23:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FPSju5fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E795883956; Fri, 16 Jan 2026 23:22:44 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C75C83935
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 23:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-459fa8b6044so1585056b6e.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 14:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768602161; x=1769206961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8nk2LpG5KlvXbBlm0hGiI3Q/+7oIrxgLRJrdwQQVW6c=;
 b=FPSju5fsUj8MzT+qx3NDOmkxDrGyinnVk2A491spAyq94+9z+ls4XHbjE35lqnrbGo
 eJTa3s9Lh/zAr8eG+lIKEaoNcZLgVTkbBUDrC+8u3LLmRt4bnzCiidpC+JtYoMWaH8rE
 Sc6+OL/CzviOW/Uergi4RURA4PFYuw0s7jADU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768602161; x=1769206961;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8nk2LpG5KlvXbBlm0hGiI3Q/+7oIrxgLRJrdwQQVW6c=;
 b=iKU3jKWBh0ao2AhsxR1M8GXFFHmJuGru/Uv4pzgmlkSAaKuKQNp1eM13r/fPonw0t6
 oF8H1y2lqGefkVw89fB24heGnzOchvxazMs1z3kdmEVtzF5fte9pJbYDGaIljomlUmXs
 FPVWXFTteLlvrPdUllYCskv54jL5gL2mTAcGHtO/tDR68IXDdO7qczCsbrPKkpY2+XWj
 vWKNQxrMDUISv3Xd3bjlpPEVnq0xSYq3f8p8dHSOspVPec0qSaBJXFTD62VSbdb6Owq5
 yNz0SGDzjkupOo2wiOm5B0iNqMQ672EvDJyHvwwXYjtAuen2X6VAM3m6+uEXY5i3p968
 VSiw==
X-Gm-Message-State: AOJu0YznBWL3GD7rfz83oVmslRoWCPZ0skx5mCYq9FP9KKb8h9b9HPHQ
 a5zwUFonG5BlqwTk3TOZRzGZiQHolthugRwcGnSlv+yKdNn5xDoS/aKY1s8z2be133WY43aYo68
 b8Juo5ZE=
X-Gm-Gg: AY/fxX6n2WmQ618+USb4JWi+nnS40sOiYRJGsmrBhSBR3x152MiCqLB8Vsz3Jkii6na
 ATbNHGbtR1N7K5MxWKHpdY/4FtvoCQYN1pHwIhL9Q5/GEy3svjP7JRc/sw41DofoFJe3BjkqOS6
 bNarvI3TzQNR8WCEmcX+E5S9bwoJK2foJmMBC4qK9ipXbSkxuPeFpVIW1O4+oGHoYt3CJuidwdA
 OuNCdbrP0MFVexQwVzJXBcxEqbxXAj9tCB1HYNqmlfEJX4pKHAiXJ7HgjyKqs7ynvo9K7BA7BnE
 zNY+gBA8exSMO3+79Z15v0l+DYg7NBeub2IhZlfKAVgQ2UYNxFbnjWugW5c2Z3EQj8JYS0fcgCk
 q2Jp6wFbKMuF4pdwi9HkuUkCvDNZBwWUg1Jw1tiI5m2iYeOHdM9d26dJsCnODz33OO5JyOJ9xfH
 Mbyzmk1iKrfK3ETHQ/PAhmaedEeRb8B5yAOiNedUuUCAoTcwcF00y/B6PlbgyX8RMFoeEbWPerf
 ZRsaRyI4kwNYdJVCi1BBN+O//CPHAX+4wET4g==
X-Received: by 2002:a05:6808:3992:b0:44f:e912:eaa3 with SMTP id
 5614622812f47-45c9d86e8cdmr1714092b6e.32.1768602156507; 
 Fri, 16 Jan 2026 14:22:36 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9e08df1bsm1933917b6e.22.2026.01.16.14.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 14:22:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
In-Reply-To: <20260109112428.262793-1-t.preissl@proton.me>
References: <20260109112428.262793-1-t.preissl@proton.me>
Subject: Re: [PATCH v3 0/4] fix integer overflows in filesystem code
Message-Id: <176860215593.1279379.17854904399589439558.b4-ty@konsulko.com>
Date: Fri, 16 Jan 2026 16:22:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 09 Jan 2026 11:24:37 +0000, Timo tp Preißl wrote:

> Changes in v3:
> -added missing variable alloc in fs/zfs/zfs.c
> -small coding style change in reply-to Simon Glass's review
> -reversed size_t to int in reply-to Simon Glass's review
> 
> v2:
> https://lore.kernel.org/u-boot/20251231100831.119142-1-t.preissl@proton.me/T/
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] fs: prevent integer overflow in fs.c do_mv
      commit: 99416665f006b925db12f6c02b11f9da02c10c5a
[2/4] fs: prevent integer overflow in zfs_nvlist_lookup
      commit: c8f0294285f6588322363e1711bc57118e6fc9a3
[3/4] fs: prevent integer overflow in sqfs_concat
      commit: 870aff99a279ed428c5a2560b2441b3079ddb34b
[4/4] fs: prevent integer overflow in ext4fs_get_bgdtable
      commit: fc16c847a1c9c6e0ee1f605849cc500a04c21602
-- 
Tom


