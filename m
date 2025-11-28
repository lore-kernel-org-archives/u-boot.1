Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87438D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 17:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 324F183C7B;
	Fri, 28 Nov 2025 18:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tkrRPOqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04AE883B4B; Fri, 28 Nov 2025 18:41:30 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 599D583BD2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 18:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c75b829eb6so1371765a34.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 09:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764351687; x=1764956487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+/UEzrM0VVG7t41UZj7xm907PT+3687bRT1QEHY18o=;
 b=tkrRPOqB7IABSiwGmfTJ9AQSblcAadhFZpIeCtGDJvHEGC9vQjTts5FugimbnS2mO8
 BSbzrTfbfWuifd7j6tTsqYS8TmBkhWoLBzpikUijBuRRgEWkiTgx/ZDvC2Ix547gnHgd
 YNAuk3Xul4I8HVoWzTswH+qpiAGTzhh3bkOYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764351687; x=1764956487;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1+/UEzrM0VVG7t41UZj7xm907PT+3687bRT1QEHY18o=;
 b=EzH5QtPIc6fa0H3oeC0z1okXGmxcXOQNhaLVKE9/sZUIVsnDvRaa5dach20HOarkol
 yxuhPhwYSDbSkU/H/NDUVS6cb4IzlhH/6acS26IJqpHcIftraiPQE/vCLAVcZuZL2hAR
 7GU16vVSKv+tGLY9gEsvGOUO6mAIc0XdwQQ5e6fSPH7sOpBVBXcqFV3y+YaSzzUVF71h
 Zct9tubPaisYKNCrd/omLYwtjEzV2fnw98JPDE4G82n0Now+Xn4kRCVg1wEzC2W55Exl
 h7O4cviyUoDAonkqc95Pc7pfG96hjeF3/Rdg9ULAd/qPd3ElCzGeMFmemGswtgdKHXai
 SIqQ==
X-Gm-Message-State: AOJu0YweaBgLV6A+gBYdc78IJamrIDPGJgJh7XvR6X+yu9LoJWIHdCr+
 Tgpn+TU216gyy5a3hn6KITQ430yg7CXLlHmvN4IjF6EgzVsj9Ds/BP075oUtBGPwDoc=
X-Gm-Gg: ASbGnctOiR8cJeFAlNqyOZmSjHUGjkis8fz+hx+6UZ9hFvd7zsT7Kp/10GMLrGLMd/7
 WTwvcvFU8t2iwhUR8GEMKiHyQUIzMHqfnuhxx8ght/hUHLhwJyXQZXP9+3P7qaHpivtbgurTkrB
 Th++2QspURG68YLQFXGqnBKL+2tF+Abo57mYKpTuuKki+iTqJw+dCZJyr/vjk/kiVxy1VatFBtH
 weNccENuwdxQYfBENkXtA+379QqmgezcQZL/g1JqXcQuXzkxUbwsCtjIybBbh/N2QEqVMoXGtzy
 uBB8b2Cbo4/WPVJFzJvtWGUzhCjh5KuHf1mKiHltCCLM960oqWToemIJYT5wsm307xquU+Si46R
 9YBbl8TpNAf4xlMiLqjafE9Se2EW4vFa0Eo1xHctqC482ikCc2YaWF75AqZFIDmKw1hNPhYRZKe
 ElCnZfbSi3urJ8QhgFgCEi2O4k6QZOEmi7lpdQTG15JTaGULCh
X-Google-Smtp-Source: AGHT+IGFG0s7xcvVMgeH7NZBZx5C5t2XYenPDOUQaatshIQUn4oRolA1MaV+ZadIagESGhAoDhamaA==
X-Received: by 2002:a05:6830:448b:b0:7c7:7f73:d2e8 with SMTP id
 46e09a7af769-7c799071ce3mr14431637a34.22.1764351686996; 
 Fri, 28 Nov 2025 09:41:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0f650sm1771543a34.23.2025.11.28.09.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 09:41:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
In-Reply-To: <20251116001455.674808-1-marek.vasut+renesas@mailbox.org>
References: <20251116001455.674808-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] xtensa: Assure end of U-Boot is at 8-byte aligned offset
Message-Id: <176435168614.233357.6251523237761503839.b4-ty@konsulko.com>
Date: Fri, 28 Nov 2025 11:41:26 -0600
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

On Sun, 16 Nov 2025 01:14:32 +0100, Marek Vasut wrote:

> Make sure the end of U-Boot is at 8-byte aligned offset, not 4-byte
> aligned offset. This allows safely appending DT at the end of U-Boot
> with the guarantee that the DT will be at 8-byte aligned offset. This
> 8-byte alignment is now checked by newer libfdt 1.7.2 .
> 
> 

Applied to u-boot/next, thanks!

[1/1] xtensa: Assure end of U-Boot is at 8-byte aligned offset
      commit: 8c0d78ddc4989fe95337b20e392a76e796001eb6
-- 
Tom


