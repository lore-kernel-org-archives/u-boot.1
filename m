Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092EBC25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 17:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45AE2882AF;
	Mon,  3 Jun 2024 19:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WSbGR1aN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 320E88834B; Mon,  3 Jun 2024 19:42:01 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A2387EB4
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 19:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6f8edde24b3so3008372a34.2
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717436518; x=1718041318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhOpN1j3bUh23Ir7p0jwLMxIeN55z03CqsaUIzZhCHI=;
 b=WSbGR1aNsCkxQIEbdqCvpJadX1R/mSfDLU1WDLUjDG4T45PjdekARRvVe+OP1nI/t1
 +2M19q71jMmBy1GkGeEXa+W9MvpXeuzqNTc03YnjNCEl4JNXujrblZFL2FT8P/ulEMQL
 9cZLZ9mXzrBeqt7xjdi0By6VKgsZtjc8oXhRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717436518; x=1718041318;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhOpN1j3bUh23Ir7p0jwLMxIeN55z03CqsaUIzZhCHI=;
 b=ZHMPN02bZ7bxiR5aNw16GxuDPnxE4UYB/8pGlnwHmcR3ky5IRyEhZ518Okr2A7DWYl
 PFBehYTN1a9BF+1o3Nl1uMYPJtrbaOjCJL5zQVtqd665I8UKd5dCRYGwRUT5M1buowSZ
 RUZ0Mn0MZdRKhbterbbcrnDOBfPJODwsg3ueOFlJqYNQcL4HmXeg37YjpRk0tsbOL43r
 pZ7KDgI5RmLUWqS52V/yKbwf/Yp+TLFfBUgeZhCQCeeYKEz0rKx/dFMBpvc3mA4vpt2S
 zurU7jhL37CGHgxuUoj5D3SftnIZVkZ5vIcsQ+zIhYpgedbChFmkErLsxw4H+L2oF+Ds
 FZuQ==
X-Gm-Message-State: AOJu0Yzs/3WJzHqQtifWH41DXLA2QCDNbKbDHwTlYlH2n0AB70Ei5/xw
 h9NwoKT0eHI3w2Cn2XnHwW6AAvHzQBTKp/WgrjpiS8p+6DDBGl62jqVllA9YnKo=
X-Google-Smtp-Source: AGHT+IGcsZF/Oqre2rQATG4CHjqdxzGM8oUAKJ5fy7vNqgerJG40yt9PP3Isi6N1ZQ5eJtTj/yMS1w==
X-Received: by 2002:a9d:5c16:0:b0:6f0:444c:d534 with SMTP id
 46e09a7af769-6f911f2425dmr11899430a34.5.1717436517630; 
 Mon, 03 Jun 2024 10:41:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f91059cc97sm1523261a34.63.2024.06.03.10.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:41:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Javier Martinez Canillas <javier@dowhile0.org>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>
In-Reply-To: <20240518130622.219031-1-javier@dowhile0.org>
References: <20240518130622.219031-1-javier@dowhile0.org>
Subject: Re: [RESEND PATCH 0/4] omap3: igep0x00: Fix boot failure and
 modernize the boards support
Message-Id: <171743651627.1565845.12755270495736547272.b4-ty@konsulko.com>
Date: Mon, 03 Jun 2024 11:41:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sat, 18 May 2024 15:06:11 +0200, Javier Martinez Canillas wrote:

> I noticed that the IGEPv2 board did not boot anymore with mainline U-Boot.
> This was caused by a driver change to allocate its platform data before
> relocation and U-Boot not having enough pre-relocation heap size for this.
> 
> This series fixes this issue and also makes the board support more modern,
> by enabling DM for SPL and migrating the IGEP boards to use upstream DTBs.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


