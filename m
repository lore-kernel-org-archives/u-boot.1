Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F88CC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 13:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE90886A4C;
	Tue,  7 Nov 2023 14:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q4qF2Uyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F4F586863; Tue,  7 Nov 2023 14:19:50 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61A7086F86
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 14:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-579de633419so67985577b3.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699363184; x=1699967984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOD6rTygXbHDO1jvb1eGvOWTxPDbzciJ6X/cwtHL35o=;
 b=q4qF2UyfukFqycPFIvjJG5dbxsPPe2vgVf4sfTz+NXrpcg3juWSQ2IS3zaV6T0Hm7s
 FS5uifrwQ0VfapCBL8ZVM75lAbzhVqPjoYediGa79seO50b+2b9HiNl5OWFpiRnwwo6c
 earmgAqhnwk/nsg0etDq9O6FAAlTsqHcrzNy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699363184; x=1699967984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sOD6rTygXbHDO1jvb1eGvOWTxPDbzciJ6X/cwtHL35o=;
 b=P/iyDx+e3J3xcwxoeZytJtrF5tUDz2YRV4h7qzKae6INfgsFRfqP5QXVk8z5Ctrjkx
 25TYN+VriwfpX+Gy6FDCV1tc1OHU19TIUNifzuiZSiP/Z448iuqu0mZL4SsUlXuW1lIK
 RvqnXysF7+ZnhF5Plo1WY6jrNucvzrec/MuBWIFnEbnF/KxM0tUPgrlIoTH7SmeTcbH+
 Z6wjFYcMaH9846DyifmyG7W26prWpeK7YCnj3zdKueStUG5MQGlkvdOQBoutoWSr6Fx+
 AwakOs0GddArp3vwy6JcWn93vNaOFeDYyPV6yY4W9D4H1vGzkZWjsc28CMoRF/EnJ/UZ
 x94w==
X-Gm-Message-State: AOJu0Yzz1LVLkcnRE1A/zhyFVRs16La4kiBbfDMdsyiDgdVO2ZppqzgA
 BQYKH2OWPEi+DfpnKVosbRvEBtReE8V4dLuJJ8s/FA==
X-Google-Smtp-Source: AGHT+IH3LP82NjMCsKe4x9gYJCbqO8EqGTvQidNSiH/AqOSxVII0xrBXfuNAhKZM0ruwDbbkcHDqCw==
X-Received: by 2002:a0d:df4a:0:b0:5a8:1654:4b6f with SMTP id
 i71-20020a0ddf4a000000b005a816544b6fmr14096367ywe.17.1699363184660; 
 Tue, 07 Nov 2023 05:19:44 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 kh6-20020a056214514600b006714f8b5512sm4339214qvb.6.2023.11.07.05.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 05:19:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 0/2] MAINTAINERS: Add Mattijs to USB/fastboot maintainers
Date: Tue,  7 Nov 2023 08:19:42 -0500
Message-Id: <169936316552.191686.2143612459602061081.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
References: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 05 Oct 2023 15:04:24 +0200, Mattijs Korpershoek wrote:

> From discussions with Marek at Kernel Recipes, it seems that the USB
> subsystem in U-boot need some help.
> 
> Since I've been asked and I'm willing to help, I've added myself to the
> maintainers entry.
> 
> I have also added myself for fastboot since I'm interested in keeping
> that functional as well.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom

