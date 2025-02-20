Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE45C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96A6080077;
	Thu, 20 Feb 2025 22:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fq/GVUAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72EC180EC0; Thu, 20 Feb 2025 22:15:26 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F7B8006D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 22:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220c8eb195aso30003265ad.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 13:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740086123; x=1740690923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RYtRZwjAyktbgTPJQ+pmdqSqnCeaHf1cEqxOohxYlYg=;
 b=fq/GVUAOBEQNj/F1nTKsGHisGuUNNouZ8lHfjaahHy/oEhb6p/fQgwmcmXSeLUyisA
 XwZpIsMC43ucT6ppraESPjSTXtko4Uw74AuHdyK8Rw4vPWySsfZNDt05lKAbxIiFLOzq
 A22bjaMgnQCRuKGT+aIATguw0FHWOY6zincY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740086123; x=1740690923;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYtRZwjAyktbgTPJQ+pmdqSqnCeaHf1cEqxOohxYlYg=;
 b=aIahh3XFvy2Hf/iY/vnEL+v+iADtMMwZ35g+w2Kd60IKzdHBRppWd8p+lY2Vdl2JmL
 /kdOut+qK22+pcvhAE6CVjNhXJ6uJ+IyYWIUGevY/ITbbxam+BNzTPwEITtTjtBDDbrr
 YffGlhSlxR7Afpd+A1z0TU4EEH6By+qisNlEyPEXB99pwUUzcCXNsDWpeufa6W/7eQGA
 zIrGA7M7DIv1HZxVuKAKX4Nk6EAa/J9OCubCNQnHCsl97HyguRVVzxEP74NfiC3G5Ldv
 hatsDA9QwdfrBRwEeYwpA8s86LeaoJzVOqtJ1omIHsOljee0dNTgtSsAAoXNr6XLDWK8
 GXRQ==
X-Gm-Message-State: AOJu0Ywk/Q5T4fdYZ666VZqnoApXarb8IekHxlSXVmlmsGsAF/6K3MWG
 sWcQVcWU2iaxkJwndcGqTec8qrY32NHoKogk35/n3KZ3FX5oyul2Ge3F8Xl2jhc9jD2mgnwmbCZ
 33xo=
X-Gm-Gg: ASbGnctxdgZW8XirjRhiPfcUAev5BouCIfqQeGL55F6il1V9htc5X+OtY1bUQda/lAE
 1HtnwCC2qSK29k2PSvZU5nY88aUoC/jBmchXn0YR2J1JyFbKKnMlG0GmbW6XKXAbgzlwqvvOSEj
 IbPud1s7aRzO4brLrxEKAn3MqTPOekodSrnHyIl84Qk9DdDmzbREx5G6ZN0R6sX1mg8t0y+985e
 2gO4bjFhuY5wFfA5xMA+eSGnQUNnTTls+OCr75xxCWqkusTZiwaPcLQjE3z5FA1GcNNyATFC9Ae
 js5X1df+JsLq
X-Google-Smtp-Source: AGHT+IF5unE1i152kG7CjBxMpa/xtNDHDZzKnOWAn7eXb3XBwTQI9VaNo5Ykg492b1TmZmqSxkAoTA==
X-Received: by 2002:a17:903:19e5:b0:216:3633:36e7 with SMTP id
 d9443c01a7336-2219ff5f618mr10043315ad.26.1740086122802; 
 Thu, 20 Feb 2025 13:15:22 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2210005641dsm96941445ad.210.2025.02.20.13.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 13:15:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250217200638.356583-1-trini@konsulko.com>
References: <20250217200638.356583-1-trini@konsulko.com>
Subject: Re: [PATCH u-boot-test-hooks] py/konsulko-labgrid: Add sample
 rpi_arm64 / rpi_4 boardenv file
Message-Id: <174008612173.2953374.14152309617206430087.b4-ty@konsulko.com>
Date: Thu, 20 Feb 2025 15:15:21 -0600
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

On Mon, 17 Feb 2025 14:06:38 -0600, Tom Rini wrote:

> To match up with the sample conf file under bin/konsulko-labgrid, add a
> boardenv file for the rpi_4 and rpi_arm64 variants (cannot be shared
> with rpi_4_32b as we have aarch64 specific example test files). This
> shows how to enable network based tests, including OS boot on the
> platform.
> 
> 
> [...]

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

-- 
Tom


