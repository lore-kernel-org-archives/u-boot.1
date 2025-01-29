Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6E3C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 16:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C28E780820;
	Wed, 29 Jan 2025 17:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eH/LXTDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40A4580AE4; Wed, 29 Jan 2025 17:34:08 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A05E807E5
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 17:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6df83fd01cbso28869006d6.2
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 08:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738168445; x=1738773245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EeZpLAshrN9E59bVMLUkdRcwol4P0gNENP1CXRjW5do=;
 b=eH/LXTDVyilEBG+9txntTpKI03dBYN/YhJIrL2qlrhNxztVChn/m5gcO6dxapW9frL
 k7hiAQzuotjOowDxk43ESakl/hJ9TN5I6i4hTzA/QqJzu4Z7BVZ7p+JThBJ8IEniK8pj
 7ivmAHIBooUv/KFDMLVcZupKu1SKyNu7nRNGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738168445; x=1738773245;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EeZpLAshrN9E59bVMLUkdRcwol4P0gNENP1CXRjW5do=;
 b=cfzIQrJr1CAbf29SnFmfIM1bzi1rME+GxiBJrlmfmnrEQf+SI7Wbr9wC1DkVDeRNuk
 AA24+NVMCS6YluW/M/61iGvMCWWXgy39L4uwyn/ofe7tOz1YuTGAJ4hveT1WF62cZIKb
 J6EeA79MXq2advm77L4L0ONTNm68lo3c2GNNGzBNh/Noe6t4t4jrAKKqJqBk+yKAzsdR
 9MhkKp3UgbrqmFn1GTjee+VgOsNbxtMQpEwznp+eEfLLL3HwHwD+ToG8wscSFIGNYP5F
 TPluO9P73Bd+EI+M2joylWh3uOljl7htPpJo8St0QYSHRGHo03ku/Xp+F5ih3CH8rLE1
 5Inw==
X-Gm-Message-State: AOJu0Yz1IGA8kdwygI1rqVpgwe+1g++HcFbNK2+tWrZ5WJGwY7xTozJ8
 pUuBETBjJxs7t3G6OsVZ1UtZhquNCkY8elTj+RzPT/c/H00zg+RXTnyKyfrgX1c17uWgh9u09sK
 3
X-Gm-Gg: ASbGncsu5K5MMyYGagD1rz9VyTCFNHGZ1GMw42j3F02jy6pOC8QdRYSQv4XEhKy/lDH
 0nVrdomzWL3dS55CQjuadanjsTqfhfodbD06pNkH2Nf9pxzIgbJ0h48ELobhqAAqSbNk6kFZvcs
 u/yoqKvg94I6gxtow/1AVu9OpMnZnn/PnZR5AgumHU3BhyaT23sMsO0OCJhKYlepGAwypqcpw1f
 14ZHqLUzHKVKnb43Y/0Cv/eUWAwgNm9iDha4af3aDaZjPp+0JHGBVyl3lv16VjCIvfbBwLEVf0a
 jFKONoZbKZmXAQ==
X-Google-Smtp-Source: AGHT+IHYV/Nlye2zCF1lwsz6JAe5/xzbE1tXnZoGNLv7RjZvu9gGAzBD5PqYviI0UwS2j8ZSSC/NkQ==
X-Received: by 2002:a05:6214:d65:b0:6d4:2646:108a with SMTP id
 6a1803df08f44-6e243bb8c1fmr48150606d6.12.1738168444930; 
 Wed, 29 Jan 2025 08:34:04 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c2b76sm56636996d6.107.2025.01.29.08.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 08:34:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
In-Reply-To: <4cc734a9-3e96-fb51-20a9-e82245227a20@denx.de>
References: <4cc734a9-3e96-fb51-20a9-e82245227a20@denx.de>
Subject: Re: Please pull u-boot-ubi master
Message-Id: <173816844381.2140900.13015364387330698592.b4-ty@konsulko.com>
Date: Wed, 29 Jan 2025 10:34:03 -0600
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

On Wed, 29 Jan 2025 06:42:33 +0100, Heiko Schocher wrote:

> please pull from u-boot-ubi one ubi fix from Michal for v2025.01-rc2
> 
> The following changes since commit a517796cfa5d8f4ca2f0c11c78c24a08a102c047:
> 
>    Prepare v2025.04-rc1 (2025-01-27 16:38:46 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


