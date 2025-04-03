Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2748AC36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 02:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61EA081FFC;
	Thu,  3 Apr 2025 04:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HmlSxiMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E78AC8035B; Thu,  3 Apr 2025 04:00:01 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC8881E6C
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 03:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2c7f876b321so119416fac.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743645598; x=1744250398; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JmWo9CCpqvnIiRmOCy9Y+X1XzARrE5hd9Lwv+7zAF3s=;
 b=HmlSxiMZ/3SthRRwzhXbqQCukfZWxyGOwdhIwso6r23i8XXbCj9UEl02ymtkzzlaPE
 LDeiLiEd+vaIFE4LXclOGdV43AZ+70q7H3sLu/tCdmUo3PcaPmVPDLJWTRd+hgKLill0
 1oufziX3k7Q9kyxknKCeo1a9lBgb5Sr0oClpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743645598; x=1744250398;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JmWo9CCpqvnIiRmOCy9Y+X1XzARrE5hd9Lwv+7zAF3s=;
 b=CWbeikEuE2FGNNYy4FzAmOexRKLH2/zfxGr9BCsTpn3CI7VrOGjG26aYFHjta+Txvg
 5FxyPw/kf5I4im7b1dV9p8uxsAAzNtWkkA1hicXUYBRatROzVTIaNeOcNJI0HFgFL4/y
 kALwK0w+9Q0blNMIvcg1vr0uIJiSq9iOTVb/12oljZcv8cVs/SdL6RnAvi0LEphpMDd2
 Fa41Rd5/5m1UfdYgi+mKQFLo+OwEgk5MHJprrmAt39VffKmn2QUYCAhiqg+Jb2Wf8KGd
 VZppzIy0IbWHv4lmxPUSr9/wfI97qiQ/xJBZhGxCnvv0nJURH4I2aJ8nSD/k/+/pUdK/
 GU5A==
X-Gm-Message-State: AOJu0YzPO71ptOLwsNtBc+LcNvM25fRmWe1//9eaoZEuUlKoz4k+A1g7
 pYVoGJLBurhhJ2ftXI6QRstIHJe4rJXlNcuhly20z7ln02MX2wnwXSOcCckltLitvyJiRdUJSuP
 G
X-Gm-Gg: ASbGnctTSkRWBxw2bnzuLu1me3p32r/DQqBcpE7XKroV1Z+xmY6oUuF4pF61l2Mlm7H
 Wf61IqPCWNCIaGpr4WKDTvutgsPO2rO+7j5196WH7gu3bEe5EvNQ1llw5V402ZR/n8eoCpAznJQ
 snVGSOlNXd6pPy9BMBgbU6ADKxsLGO14PajS5coZikUQZK4CaptZyVF0oG0tYtplXnUsXUCVg0U
 Fff8xl4M1gFgoMEwtSArliOKKtFm6gxPwqT/TjsuVXiIVx3U1TM2U97uz923Qoq0BEpEEuD3+XV
 LyVu90qn7v9a4a0A4ahmvRuDMo6ClWrzfF5lOF2qZBkDb2fiWaRccI7RKuiEtvOyPcFbJhhZKpY
 uicjsQZhK0Z1pKc0=
X-Google-Smtp-Source: AGHT+IGN5bRVlJo4gDkqw99DZVI6tBqr2UNhrT60J5Gvt8Kc/1li4jEZ6YqUrcpkronXG3ok6J+jsg==
X-Received: by 2002:a05:6871:a402:b0:297:c04:9191 with SMTP id
 586e51a60fabf-2cc7f560487mr680190fac.3.1743645598189; 
 Wed, 02 Apr 2025 18:59:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc8463aad0sm71775fac.29.2025.04.02.18.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 18:59:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250313171729.2126283-1-trini@konsulko.com>
References: <20250313171729.2126283-1-trini@konsulko.com>
Subject: Re: [PATCH] onenand: Remove ONENAND_BOOT option
Message-Id: <174364559712.1379294.1655186829289565442.b4-ty@konsulko.com>
Date: Wed, 02 Apr 2025 19:59:57 -0600
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

On Thu, 13 Mar 2025 11:17:29 -0600, Tom Rini wrote:

> The option ONENAND_BOOT is never set, so remove it. The option
> SYS_ONENAND_BOOT was never migrated to Kconfig and any platforms which
> supported that have long been removed from the code, so remove the
> reference there as well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] onenand: Remove ONENAND_BOOT option
      commit: 177d73dd17705e77b1830a7354425636f617666d
-- 
Tom


