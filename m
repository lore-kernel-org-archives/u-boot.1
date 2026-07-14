Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB24AC4450A
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DABB84D69;
	Tue, 14 Jul 2026 19:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UMGljLYU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2EA384D65; Tue, 14 Jul 2026 19:56:10 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A52E284D5F
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7eb5a9f02e8so2290354a34.0
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784051767; x=1784656567; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=afuplvO4mPGQnYe2tTr/xOV3raPU/PETYvUcKOtS3+I=;
 b=UMGljLYUrsWHZtKcSXO6CfHv46L79OEneVpKrhxTl7ozAL4UnaR6jilkqBnKioNqbO
 n2fbLR2SRW5sCgk2H0w2NXzb+Q0+r4IH7MOzW9derXYfVrkNa+NNxEbPoIFnpFYwcV3X
 I5Tw55etRlm9wmwdJi7Pn0mh04FuZUD4miZjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784051767; x=1784656567;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=afuplvO4mPGQnYe2tTr/xOV3raPU/PETYvUcKOtS3+I=;
 b=g6MoFRyZOTSlZWTR/p1QgriDPIn25RTkWW310qrvw5Nxl4usAtgVn+HwAAOnazEhGa
 1OkZ+rnXGcN16B1AiXPZamsv6n0zk2GviYECp4LPXX5QjO7V+sWGfLcYUJlYctYJpcyB
 I6xkDUCOCacNJjyAXHi/yS29djxJgbwv4h2RY/tke66Ka1G4keAG4PG7XmYR1nWzVeg9
 5RSASmfCoTGxL2CT/LzLvn+qGGC4+NTBoz54hPossWKCN4FtCoNTny3v7tGmTEgoxs50
 U5w7pYwSvo3SK/vOl+So+Hr8bTa/MJzm25LdFvLuj71w++VmoR+cCXjLZhNQ6Zduep8h
 m3Pw==
X-Gm-Message-State: AOJu0Yy5p0YUOH+8xkEJ/kI8qSyN1wnw0EqlBwBkZfIbAIzcHzr0YABj
 Ej+wud3eWdiRi/Hx0ogd+NHGWiVALqCKjnDx26p7SPcT0q6S6wfdOCUqSh5m76/MU7w=
X-Gm-Gg: AfdE7cmdLCvbo16aU/559pUOngPSSPEkxSqugyz2CNMML4ZhbuR7F04xiNRrbY3/bjs
 XShrClbVcs8SrdTB2Ts81rvpIWttfHysmor8Rtf5EgOyldaolls9QT3hrKEkiAP++gjqJvtVY0N
 faNz7+Dhpxtpvhbrbh/LJ5YmI34X4WvzNDbJd9lRPZXOWQl7Z/+Lcvjg7oCdycLataC9XHoUUPQ
 noEQCf8QjVKDeqjbnErX4M6be8z+iuN8GB2QXtu4LJV06b41FFIlKs0BhaKr7J1XFnRjFK0QFSj
 FmFtXTS73v/MvCBLr5N+AS+3Vvw2dHKElcizAtCj6nECEokzFCixFzca5b0S4lUmI5yjuqWvEQn
 vpITo4XaRF9ryjTHVf5iYLYzjkE3zseuKiDIDgcEi888v2iHU5xYTbibWq+/KpdqLap0nL3pqp7
 uAQYWsFmgr4jNAM7sE1evugMArJVbTkaeDown9R+Bvi39XqszTsxJxqySu8eNq8VY+tllx26Wbc
 JML0SaOEkq2pcpTrHdJDQNGtap44D66M/JS
X-Received: by 2002:a05:6830:6aad:b0:7e9:f0e6:fd55 with SMTP id
 46e09a7af769-7ec09872360mr7837748a34.30.1784051767375; 
 Tue, 14 Jul 2026 10:56:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcae206e2sm15597648a34.2.2026.07.14.10.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 10:56:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Daniel Golle <daniel@makrotopia.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>
In-Reply-To: <20260626001823.1746868-1-james.hilliard1@gmail.com>
References: <20260626001823.1746868-1-james.hilliard1@gmail.com>
Subject: Re: [PATCH] cmd: fdt: keep control FDT during checksign
Message-Id: <178405176549.3971373.17737267899829218949.b4-ty@konsulko.com>
Date: Tue, 14 Jul 2026 11:56:05 -0600
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

On Thu, 25 Jun 2026 18:18:21 -0600, James Hilliard wrote:

> The fdt checksign command accepts an optional address for an FDT
> containing public keys. It currently installs that blob as gd->fdt_blob
> before verifying the FIT configuration.
> 
> This breaks verification with DM-backed crypto drivers which have not
> probed yet, since the later probe path expects gd->fdt_blob to remain
> U-Boot's control FDT. For example, an ECDSA verifier can be bound from
> the control FDT but fail to probe after fdt checksign points
> gd->fdt_blob at the key-only DTB.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: fdt: keep control FDT during checksign
      commit: 58c2284a1a90d138f60364caf3513dda5693f8ff
-- 
Tom


