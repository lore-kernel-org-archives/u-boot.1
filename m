Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C98CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F485846FA;
	Tue, 19 May 2026 15:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DenqrbyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D106284713; Tue, 19 May 2026 15:35:12 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F8C846F2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dca5f64e86so3069499a34.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197708; x=1779802508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j309R2HbobjyluxxeJyzK+rezm/stjshppnMwPgsJAQ=;
 b=DenqrbyBBpmc0HoIhT+xPrRZyOUBS2C+NoxallP1E0YigBdUVDdRJX3zWAlO9UcORe
 SjRWGaQcBQySGYNlmATCaIyCqHqdxF2U7HYpZce/z/oRbRn2yIiZL7aXlbIP3xPL9NFD
 B6AM2VZNyL7++TWO2J1zA2f9D7xQJcfKgRzkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197708; x=1779802508;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j309R2HbobjyluxxeJyzK+rezm/stjshppnMwPgsJAQ=;
 b=URFAkZ5B+KhypvmCvK7Xp6suloi7CWDZ4bhTUkGRxcWDezFgVq7Wlg8DJKY94T7Jf+
 0sdGQCltE83oX3IPBn6fzPW5ZDfyz6azz+IkkmpMTYkuKptSI+WUuhI3qFD/kc5FQrod
 HASmgrbyJ0x+mljw5qCmlV0duEj8Se93JA9dihZiTnvxbNm1Z8UJHc8e3wtB1AOU7tiP
 WupX4lctdJsD1UkyJ1RcaiG/hTX37xrZgrBNvE7gxrTtDQphDHl2swkFB8v29ECmHohr
 i71SJBvTR71xB/D/56u/bbryV9NRt2jtby44gZ0esgN9f5g1ZMThLQxqwwluP0aTAbNT
 wFpg==
X-Gm-Message-State: AOJu0Yz1ZHmam5uLVgffJJU+rFF0yiY2fsGy+xjJX0QZt6cn7vA7KZeU
 5u9NCuMGTqaaD42ihoJtIF1TI8dwen3MpBaGNexNtfkFbmsQEZ0KXktZ1fAj33ygQuDdEUm3N+2
 HdkB5dIC/YRqC
X-Gm-Gg: Acq92OHul9aUaMZInHqLS8V1LrIJqVcQey2xfdo1NXg9XqTamkbZgCU617JrbbKBXXx
 Vm+A2lvPevpDeAY7wtVAHK6opcbuTi3NYAXmgoIc6gNsnLvXqqA4yAo5LR+pzwqyygpCvZPAFfu
 iU3HORS2qF2K7UsOvSeRizxTSLD6Ix/vkhHKKiDNq+BpqtKdvaK9csMFAWaeSPGu5ky3HlG/wWF
 tut6gVeKCslQNT1cPtn9UcMWAS2W003gOU9icN+5/teYLss6PHQ9UhZfVVDzTRybTiiNTI8EBa5
 3ZM7a7kAnzLWVOWJr2180NRiJRCasrRH4WocyC+e+7bXHId2vjlgQv/AyAddM3IwUf6KF08Nxvb
 jhzhtocasWOzwO8vjqXATQV8SR78KrlUikdicOZdu3bE/ByBtsVWwnSF2nFL7vtMmO25B8goWt8
 Ugom8IqglooIC45rIv9FSRwb2hu71y3vf0miI8R6s6d7U0J07E0V1PufjhdhsOYcdEkF3Pyx85h
 nLjU44S7lNoJy2wpjf0j/FbA+4KvUY5wxNEoyxNLOVUEPTiPg==
X-Received: by 2002:a05:6830:2b22:b0:7dd:b184:1338 with SMTP id
 46e09a7af769-7e4ea06248bmr14065159a34.6.1779197708515; 
 Tue, 19 May 2026 06:35:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
References: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/3] misc: cros_ec: Staticize and constify driver ops
Message-Id: <177919770749.672258.14426989382379728010.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Fri, 08 May 2026 00:07:14 +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> 

Applied to u-boot/next, thanks!

[1/3] misc: cros_ec: Staticize and constify driver ops
      commit: 0bda59b1fac580accda9e810cebead29585e6a5c
[2/3] misc: i2c: eeprom-emul: Staticize and constify driver ops
      commit: d6a87d042e55d989751fa70f45d44dc230eedefb
[3/3] misc: x86: Staticize and constify driver ops
      commit: 9ef7c13308f685ebc701f1f0e3e686034ddda87e
-- 
Tom


