Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4365AC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 21:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B8784AA4;
	Mon, 29 Jun 2026 23:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t+ESJVsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B45384AA2; Mon, 29 Jun 2026 23:34:46 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B11384671
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e9dd333d37so389164a34.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782768883; x=1783373683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTWhk70VUFX6YKud+8XvGgJcSUylz9gLRoN8b/FNVpA=;
 b=t+ESJVsGYf7e3OEszIzLRZ59m3EzNtT9Kqc5KxqOtnWqE6iNKlImUiIpc2Ddfs0Ojd
 Qhp0LK8ZAHXxbQgHuXmfiUDmqfuwZ9wYuPHpf6Bpg73H7rHB882qVlEqtB9aG/C4DU8u
 tK1N5mGEb9mM/nM0OkZtU2/FOOyuQuaEE/aCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782768883; x=1783373683;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yTWhk70VUFX6YKud+8XvGgJcSUylz9gLRoN8b/FNVpA=;
 b=l9tfEmHlp673VOD4/1sFtiO3246c1hO0Qc9Vk5iBHoS2X98IWbwAv7BLLkUHgxRepN
 UuxZxQhSc5jh3G0t3LaTiD1nRtnR/1T0FbZmFr9afWJ9KL7xkfFNIVHRZlbPz47CTfQ1
 8xqg5S3FxXqdeOf+JtedxHy/x+OoJMEnSQr+ZYLeUCLuXODsqLNJs72AJYOpj7HdWqn+
 ItzkClkguaPaZilWGbwCvNLe7ilAQv7o5PiwJpqoc4kawTfoYzKTKW5/MQU2bmkJpAew
 bfl4xKkeG0MTm/N9NdpFhMKacWYFG4mok+qeBvDgSgPhpV+dGl4mULT2sZLfqoBmD+xo
 WUFQ==
X-Gm-Message-State: AOJu0Yw4gmzjTJLLL9+Kocfqm/tkEyPSocEzXhPN6eeyGrfvckaw3AO4
 F1smDjU2eB/BcLiTuLXRkwtTahzTGgSSFPkT/4nzjw5jkcb48Vw/DdswDfz8JAtra0NMWULstvb
 +Jk7e1fE=
X-Gm-Gg: AfdE7cnMc9dQW8RLrGERUrfvOJyWmxMvbrJ73mCz1KbYnjjrDlstVQjLexC6ImtIWmO
 HBg/5U0F79s9QI6xLqTSc2jZKAm7rtjK9PIomx/zcYvuxzJ/odtqqxiVWf5OOMah7Hj5+iU5CJQ
 POIesxRAAZy8NEhlwb0oCWFKV6LCGl5w+A0ycCFk8CbulHvJ/ov9N0bXm/u0xcpiTUkjeuAM77o
 er4DYOL4LgL/DeqwgORXu7LI+KQbs5RvqlN7nOb7pJBM984N0ioFSG4+1Cb+0REQHvFBf1VdpK7
 zdmf2FwFmKKAUgN6LSGPAnoWKVeCc/s+6r3tdMJi4M/XY/faRDnwui2wRfWheQ3JhHkWPQeI4ix
 oPvvNERjG9/qi/oezOEND2nlWVeCCcNIS0Cf2ZMyVRYI2VIbjnWsKkGAEQF35bL5weeVaaMCPf+
 GR4bEhBO2ihSJYvE/r1OMng3GozO7MujOOaywfxdAV+WeCZy1AljE6JYk2YSxZDfGbxprf84ixA
 29WjMGL8hCneLgh4tK7y7skH/DCboGCzXXHJ4o=
X-Received: by 2002:a05:6808:1821:b0:48b:5dcb:85ab with SMTP id
 5614622812f47-495ead5a8bamr1213767b6e.8.1782768882771; 
 Mon, 29 Jun 2026 14:34:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-494c3766f3esm5454697b6e.8.2026.06.29.14.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 14:34:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Tsi-Chung.Liew@freescale.com, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <oh5i3u3rhl5e2ljpquojthtbqykqs4eykbyneap5gcf6pppx3w@ehi4yimrtn5m>
References: <oh5i3u3rhl5e2ljpquojthtbqykqs4eykbyneap5gcf6pppx3w@ehi4yimrtn5m>
Subject: Re: [PATCH] rtc: mcfrtc: fix leap year calculation using wrong
 variable
Message-Id: <178276888181.793204.12407755842161710543.b4-ty@konsulko.com>
Date: Mon, 29 Jun 2026 15:34:41 -0600
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

On Wed, 10 Jun 2026 22:38:40 +0530, Naveen Kumar Chaudhary wrote:

> The leap year check in rtc_set() passes the loop variable 'i' (month
> index, always 1 when the condition is true) to isleap() instead of the
> actual year. Since isleap(1) is always false, February 29th is never
> accounted for when computing the day count, resulting in the RTC being
> set one day behind for any date after February in a leap year.
> 
> Pass tmp->tm_year to isleap() so the leap day is correctly included.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] rtc: mcfrtc: fix leap year calculation using wrong variable
      commit: 1537ec5ceb7d80edaefb55743bb44e17f303285b
-- 
Tom


