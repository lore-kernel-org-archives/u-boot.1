Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315D7D6DDCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7EE8969B;
	Fri, 15 Nov 2024 05:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pq032ChF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 583C789326; Fri, 15 Nov 2024 05:27:46 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4736C89353
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-460c1ba306bso9209401cf.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644863; x=1732249663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oSzg3W9FIAeqtKMVT1P5g9TU1xOu1UJIunKNwK4LW4=;
 b=Pq032ChFexNMCzqNwUJ74+lGxIZNu3kZscG7169slr4sOKoGlZnA8O2ost21EjeRaP
 6y8bzJUODlbv2iHS20axWxxH6S/c68NM3WLB124WILXDfPKq4mFCNfVLzVsFNQPCIiyw
 5FUKsIEW6Ydljg9NzgThDOQbb6G2AOBmceCAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644863; x=1732249663;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/oSzg3W9FIAeqtKMVT1P5g9TU1xOu1UJIunKNwK4LW4=;
 b=LIwMHQ1/97jwogIDZ4j9A0TPgob3QvgrCqkDsaDy3foMlDoz/OBI0fG4/m/wTU7pas
 TuDw+dpDjviYwTkxvi0TgANABkw5Eei8ry2rrd7ZgNfpdzkCMEvxMInHscA5WKQBhVR9
 N09cFxstoYGcehJshuMrLqheLjYZF4EoyRgjTe3Pv7VLGgJwnlCDmG7NMcyHB0EFVDsQ
 1TSZRlNh4M7kiNu2CFCIj5Fwqdg8l7TMLU2X9goNhuPJQoGwtW7YNAX5NuRWcKiqjSCP
 0YkfIXd1SAWBaiVnHtLn8VJd7hrzPCcnvFDD8IA898inW1VnabXh4XdYGaPKkEWXYxc0
 RSLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVUe+XRfA3bBcIP0UdhMZ/N2hKLtlb5wmX1ir6+YDsuKEOtObWY0dKjpzygne5k1qbbdA97LI=@lists.denx.de
X-Gm-Message-State: AOJu0YzyRxqYNR5O1k1s+m4S/2pPLvgM/FHjKhPt6lLZJey4o6jSXmhL
 wcHuJdksIobF6MGi/zO7q4pvwSKhU/MTutj19MJgbRZ6bsnKWwqnPiYuoynJh4YjwzAX38DlKZm
 0OW8=
X-Google-Smtp-Source: AGHT+IF4d5Uly9VzaCWVPqLqVNmOr11ODtgNMUFJEmBz2UnEZ2Hd/5e0vwVD1Xr8SohFwzmy+CIpUg==
X-Received: by 2002:a05:622a:191f:b0:461:13a4:e901 with SMTP id
 d75a77b69052e-46363e24d39mr15125581cf.30.1731644863201; 
 Thu, 14 Nov 2024 20:27:43 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:27:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: n-francis@ti.com, afd@ti.com, d-gole@ti.co, sjg@chromium.org, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: d.schultz@phytec.de, u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20241030164815.1763506-1-w.egorov@phytec.de>
References: <20241030164815.1763506-1-w.egorov@phytec.de>
Subject: Re: [PATCH 0/6] Apply SoM overlays on phyCORE-AM6xx SoMs
Message-Id: <173164486045.1205089.1095013417934653304.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:40 -0600
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

On Wed, 30 Oct 2024 17:48:09 +0100, Wadim Egorov wrote:

> Our SoMs are available in multiple configurations, managed via device
> tree overlays. To determine the specific variant in use, we read the
> EEPROM and apply the appropriate overlays during boot to the device tree
> used by the OS.
> 
> Apply overlays for phyCORE-AM62x and phyCORE-AM64x SoMs.
> Future K3 SoMs will be able to reuse this logic and overlays.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


