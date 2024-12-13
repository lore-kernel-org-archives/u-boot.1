Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9095BE77180
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 23:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF3480141;
	Sat, 14 Dec 2024 00:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jv4KL1U+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42B2880141; Sat, 14 Dec 2024 00:16:52 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF57E80141
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 00:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4679eacf25cso12258351cf.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734131808; x=1734736608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H9wdcU/k+WobI6ivOpiJKZRLozImxQh+y2ATYl23jiU=;
 b=Jv4KL1U+OeJzZgZWXp9WWfepPPEiKmxoo5pxXzOU4AbmL1i5LhXsPerZD8/gN6p1+j
 7glsrdcXhWfVmUrllI/zaa57RB5ziETJ+6ekb1tP/IWjBRyZLQMxEe2BD6popmIXU8d7
 DPI32x4wB6tcYSugi5ClbHpkMXgr/EjVWt0Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734131808; x=1734736608;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H9wdcU/k+WobI6ivOpiJKZRLozImxQh+y2ATYl23jiU=;
 b=CSrM37gBOc6BfdjUqTjFfTgcZcF/Lph1ZhxTROcT+qbPcYH94u8chJ0jj9RV5CeW9+
 7x1ACzjIIz+XYtU3GH4+7/OxPkR+k7J31rGgVWw/duH/vMk4z5UJjAQpQqnHWqOWtiot
 WYuNIYURhwqrVHxIlyOrKW/tyAo3sNHf5usoETKlttUN9B7PkutFzmrjpx9TVz+24CLd
 VmV9TLshwF5bvX4gx4ODeJBbmD5gpk2BgN7bZeE3bOs8yCGNZPP8o2TKRzXwC6pKCuDV
 T6e0Y+9qZ5YolIugXMjfKm4H/mYnKhfWsfPBYnJf5vXxJx/dAP5X4UIlPl2GYPsDkYEQ
 y8zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwkadDsxIm0Uo2PDxhnfFQd8ctRtZaiyKnLXjoOUj7uLdMlJD3T725tSBryCiPH2qjFqagcZE=@lists.denx.de
X-Gm-Message-State: AOJu0YxLqJC02pbqskcbKfhm7mNjT2zqFnftMujk9a3qcQbhHq5Wf3do
 lwqqgHGAB4ZKEPX/PhyT4c0PVotoTGYFsU+u37GdPScdrmZeezemh5c34EgBXs0=
X-Gm-Gg: ASbGncsruKfCuja11S4ZlT9TWss+u3YmgOvnE828acTYtcjiAfytU3FxYxGLIOc8c2l
 y54/yq6Nxx4os2RWUMs11zM3deEa7fpXZtE6GKYjumFmFMSjPiX/zV+57+jPZcf6MW/j78r4evs
 hlF8eDbtOZECpUCuIkww8iAsKys52LSt9nIFhqiyCCqJA+DL35FnTeRTED4McaZiCxE7c7IyHvp
 nQoOdbPtLqbFX0aEDMWXPDC+44lankCfeSgw7/7WMDwsTNKvBgzF5Q=
X-Google-Smtp-Source: AGHT+IHsaHSGL/CKennGouUzDhLOH3gt4VthvwwfH0QCqJkAI0Rov0mGHCIQLbk51t8BZs6OJLGTIA==
X-Received: by 2002:a05:622a:4185:b0:467:7472:7ac9 with SMTP id
 d75a77b69052e-467a5758359mr87015171cf.18.1734131808729; 
 Fri, 13 Dec 2024 15:16:48 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2cbb69asm2690171cf.39.2024.12.13.15.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 15:16:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, Udit Kumar <u-kumar1@ti.com>
Cc: n-francis@ti.com, u-boot@lists.denx.de, nm@ti.com, m-chawdhry@ti.com, 
 j-keerthy@ti.com, p-mantena@ti.com, j-choudhary@ti.com
In-Reply-To: <20241126053426.2627686-1-u-kumar1@ti.com>
References: <20241126053426.2627686-1-u-kumar1@ti.com>
Subject: Re: [PATCH 0/3] J721S2: Enable ESMs and related PMIC
Message-Id: <173413180706.1760624.5157121063405114863.b4-ty@konsulko.com>
Date: Fri, 13 Dec 2024 17:16:47 -0600
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

On Tue, 26 Nov 2024 11:04:23 +0530, Udit Kumar wrote:

> This enables the ESMs and the associated PMIC. Programming these bits is
> a requirement to make the watchdog actually reset the board.
> 
> Logs
> WDT reset J721S2
> https://gist.github.com/uditkumarti/93cfe863d1f3fe3abb82b1821105f274#file-j721s2-L2708
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


