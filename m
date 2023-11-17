Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E999C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F97871B4;
	Fri, 17 Nov 2023 14:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AWJj5Jt1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C72FF8701C; Fri, 17 Nov 2023 14:41:05 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F8D8708C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77ba6d5123fso264575985a.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228458; x=1700833258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mo6M8sdtGqk3WtdWEJFgTa8/MV86+2VlOvnF5ExFX5M=;
 b=AWJj5Jt1shShGcsW1Qs9N0lLwqcSUZHJ38UL8od8y1H+qlvU3H6d2ueR2nTw0YR5q8
 SYgqoI9JuyuLrxEsKVnaxlWNxaXM/Vv2Ftd9UBgQ7Zu/ExQyhGWn3U8VDjIippcmnvJA
 ysCzg+IgJ1Di/Fjh5+rZjxrsxpjSgz31BzSls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228458; x=1700833258;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mo6M8sdtGqk3WtdWEJFgTa8/MV86+2VlOvnF5ExFX5M=;
 b=sDT1FYcKW3a9o/cdIdzo5Wz416piPMwVVAFS1iXKZmuMo+4hUWFEx7DsGtxVb/JAEL
 c1CYVeKB7f4u/qT8w1EXv1hgi4AbsItygHFAIdrAy5MAOwKok2TzRVE4CvTsBH2NbnJh
 fK50fexpn07CqvPXZcHVOx0w0kU0DeCAuImLi/y5v1rZ5SXsK1YLfOPoXNJMyCaiOq/V
 KZk1BWQXEwVb7nvbJrdiKAnM98V9/sNpK+imI1g3sa9ttqy0BuXTrzHFIs8zEtyFT74g
 UNinn40Rmzl0cMIFJV+vbJrdSbKUwHqPwmfJh3La0pcC0PMgXfJNoEu6nlFI62et8xwd
 nbkg==
X-Gm-Message-State: AOJu0YxVCcSgoCpukBhFuy3gNWmFP9IUN1kZao4VyxglIa9M8qHVjC4d
 9ZzWAOrwvH6V8b/5Y2q08biEbWMz5KCDYQJGW6Tmvw==
X-Google-Smtp-Source: AGHT+IHBEvC+oxJsd+EmFcX8nVipSUU1xK4Og7xEN1/N+XGtaVY49P7YJuCSo2ZLNozLbGYrzSFBRA==
X-Received: by 2002:a05:6214:161:b0:66d:2ec5:c1b9 with SMTP id
 y1-20020a056214016100b0066d2ec5c1b9mr6685119qvs.11.1700228458052; 
 Fri, 17 Nov 2023 05:40:58 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 lw23-20020a05621457d700b00670f8570a24sm633820qvb.23.2023.11.17.05.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:40:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Eugen Hristev <eugen.hristev@collabora.com>, 
 Sean Anderson <seanga2@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Aubin.Constans@microchip.com
In-Reply-To: <20231105022742.632175-1-seanga2@gmail.com>
References: <20231105022742.632175-1-seanga2@gmail.com>
Subject: Re: [PATCH] arm: Enable SYS_THUMB_BUILD on AT91
Message-Id: <170022845734.752997.10698883770687016451.b4-ty@konsulko.com>
Date: Fri, 17 Nov 2023 08:40:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
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

On Sat, 04 Nov 2023 22:27:42 -0400, Sean Anderson wrote:

> Several AT91 boards are quite close to their SPL size limit. For example,
> sama5d27_wlsom1_ek_mmc is just 173 bytes short of its limit and doesn't
> even fit with older GCCs.
> 
> All AT91 processors should have thumb support. Enable SYS_THUMB_BUILD. This
> shrinks SPL by around 30%.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


