Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59944CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 16:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FEF783FEE;
	Mon, 18 May 2026 18:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AUtV/SX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C0B84683; Mon, 18 May 2026 18:47:33 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF3E83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 18:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-439a8366831so938853fac.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779122850; x=1779727650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xUrHtz8T4TLLhYhpmcRKxQVu6fSsEOJxS5M5jnyBc8A=;
 b=AUtV/SX5pNQtl7aDC/CLphMK03Y82ab5HHjzIACH0Laydngn32SbSBpr80a7YEgN2P
 n4+RTqF6JlqxFZHXHS8aV4BaV59Y/H3+uyCDg9Q498G5e/md8jQa1j2lwmMKHWC/aHUO
 5fpphSOrCcvYB/5Upa/2RfREpcoEn1C0XvQfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779122850; x=1779727650;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xUrHtz8T4TLLhYhpmcRKxQVu6fSsEOJxS5M5jnyBc8A=;
 b=ZR/NyVY/pOum38M15vSYbPhyFz0wsZRjAcKvIVBoLkqlg4OHVrtyTFLcsPAvee/tli
 xS/NXKJFIXw09syDs2c618Y97MxilagXgBqz2mSX7sMWJL1ydp++rdvNrcQT2vXoBL4y
 aAT10dChtb44IGYFvrMwwvpRVZCtmhQWTAzRi4AxP+ObByqD+w7RxqApQ3ZAmcMRMAKd
 5zbj0nPm3V+PiLfO2yxrhcxq17iRpQOTx61zY6xZghwNqOVvAMvmJibDlOzS2e5Lg7jS
 m7Sx8uAFFyf9HKWjIMHRh8weYXZcgKnRtC40CqgYUIqdrAW1Wn2ABksOUtM4YT7dEdMK
 lntQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RP/9ukh8ofhiNUt4yGwyFNe3aN4gY7oj3yheejg6Cscfw0Vn7SkUJ8l9hNnh4gRVP9Egjovo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8YSGhBjeNCaF0AD87ELiM9uyBiaiV+YbZUOn59PObRUm/dMvr
 avhXgrfJHhstDsDyJ2d5ASS4HViVb7zQ3E8yaXIck6ni5Hv/UXautQ6Y0mbqf6zK9oE=
X-Gm-Gg: Acq92OENQhAxJQwBW0sOmqNgg0OIHMKG0tc5K+EzmUJY/JDARLTOyI3JxPr0wzo66Qe
 tCLGRHnkUdIASAfFqu10oxxRkpB+Q5J+5qTvmirZKQ1xRFTVsjOv7AJ2ncmG9H/eUTxNyyyasWn
 XlY5cwI5nTGODnPu42W9SyjbOp9w8S9v9f/e06765IyaSTam0hh0TTqqUFYz4s11xPklV/P2pVF
 0cPE9IDpLFIfD0NPwQPgO5O05G36I1OYAfdGxTFgPWvEgq6V83pWdYbMWtjE5MJ0atGBGF0OEn6
 S7MjzGyaZNCefIkp3fQpF6MA99GndzPrKDCloSqPRaMMvoeVjAh51rV0GfzE5+FUFWCRUVSST2e
 yCcWhCfLwPdXFWq4QXTkABa+3Qf1f/bK28GcAv0CoNzTUObQAZbs9rs1OihiTqWK3dfqLdRRQWo
 ZKEDQNZNZy9j+5I4KZdlIdsPAFkMXdctlDhhfqouPwq1sW8cD36qAsDQKWouzBQONtf0YBTPn/K
 he+JBf9FYxsYqgczXEG2wKgZfgHVc9YLniVlMis7GiSN9oGsA==
X-Received: by 2002:a05:6871:b0d:b0:439:f314:ff14 with SMTP id
 586e51a60fabf-43a2dd6fcfbmr9656928fac.19.1779122850054; 
 Mon, 18 May 2026 09:47:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a957639b2sm4517106fac.14.2026.05.18.09.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:47:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260427135326.773903-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260427135326.773903-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH 0/2] configs: airoha: an7581: defconfig fixes &
 improvements
Message-Id: <177912284924.389050.16908777545321061911.b4-ty@konsulko.com>
Date: Mon, 18 May 2026 10:47:29 -0600
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

On Mon, 27 Apr 2026 16:53:24 +0300, Mikhail Kshevetskiy wrote:

> This patch series fixes an7581_evb_defconfig.
> 
> Mikhail Kshevetskiy (2):
>   configs: airoha: an7581: enable position independent code
>   configs: airoha: an7581: disable ENV_IS_IN_MTD to avoid boot panic
> 
> configs/an7581_evb_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] configs: airoha: an7581: enable position independent code
      commit: 7bb8c707b1cfa4b7dbcb6095592f73bab77e88dd
[2/2] configs: airoha: an7581: disable ENV_IS_IN_MTD to avoid boot panic
      commit: 0fcbe38192a809a7f0f67ce557d6826dcd49413d
-- 
Tom


