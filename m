Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30F5C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 01:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E61948868D;
	Fri, 19 Apr 2024 03:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KUxhnk06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0EB88692; Fri, 19 Apr 2024 03:57:57 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF95588208
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 03:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4375ddb9eaeso8825391cf.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 18:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713491874; x=1714096674; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fX8eUB7iuaNoFmPrre0iVweztd32ZgvgxpIpuRh690I=;
 b=KUxhnk06qpfhcRceODSxmYHh6BP0nKjWhiZvgXpmJiE3L5bQr2QBbAjmpvd+/+B/qe
 1S9F7uA7kZuwiG7EbaXlWe6w5KMlIqvwRUpd8dhGx3NdrMP8Ir4uQebpQns5VLDB0uIX
 8SCnI9lPBphDNDe7Qi/fXz/7um3p1IHXBgir4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713491874; x=1714096674;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fX8eUB7iuaNoFmPrre0iVweztd32ZgvgxpIpuRh690I=;
 b=tbcsU5J5nM3pUUVcIeP3ThliEv8BUHRxdlJKUWham9PAhY8n5HoWmcjbViwMd5MIe1
 fCiJi94xJRoqFU/Kf1kdwDwP6wgeDtOI2LwS3hBRhoJIgpVPPLBTYIP06mEkvt4FCZjE
 1/kiggbdr35OiZjdv+kyumOxCI+Z41uVWwhMuINrq8r0QA4dvKlni8d6BVOsIDISTEqN
 0QXgM8G3k8Ce7XK072uxtsIgiuELnDeCn6tCjn/KE/cqxvJzwamH3F+Ik3E7BrXFUVtm
 mnr7PPxy0Q7UOlHhKh0WpFvNulYcRbN7Q2Mmpw4mLCND/hJM0Sc1wWGXLTpEzsRaR44x
 Viiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXISiDWZSF91mdFaekRAfqKeYiJbe778yO6cG9qrr4Bsl27F6+ancnnxXRm5ZdOR4GS4hPSRBzpH4Eais1Nb5Ksw0Y9zw==
X-Gm-Message-State: AOJu0YxtJkr91Psk/mc2PYzMdvAkF5idj9nE0mOkFAlIkUWJgBWgDzfL
 qEDKcUbZQ2QC5LkJa9XXrtGkySiIjq7Ip9e7+TX3fo2tgLPkzKyjQvqtrQI9f+Y=
X-Google-Smtp-Source: AGHT+IFbu3cjPgL13XUWen9ubqFRYllzUS3s45ExHOCEh2DYfYi+apF8GviotXOnI3Gw42Z7s0hWtg==
X-Received: by 2002:a0c:e889:0:b0:69b:7f66:ea8d with SMTP id
 b9-20020a0ce889000000b0069b7f66ea8dmr790671qvo.5.1713491874567; 
 Thu, 18 Apr 2024 18:57:54 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 b4-20020a0cf044000000b0069b1e2f3074sm1167777qvl.98.2024.04.18.18.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 18:57:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjoerd.simons@collabora.co.uk, Govindaraji.Sivanantham@in.bosch.com, 
 sjg@chromium.org, martyn.welch@collabora.com, u-boot@lists.denx.de, 
 Gireesh.Hiremath@in.bosch.com
Cc: VinayKumar.Shettar@in.bosch.com, anaclaudia.dias@de.bosch.com
In-Reply-To: <20240408060119.3675-1-Gireesh.Hiremath@in.bosch.com>
References: <20240408060119.3675-1-Gireesh.Hiremath@in.bosch.com>
Subject: Re: [PATCH] configs: am335x_guardian: store boot count in AM3352
 RTC block
Message-Id: <171349187313.1524174.2945773589011180939.b4-ty@konsulko.com>
Date: Thu, 18 Apr 2024 19:57:53 -0600
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

On Mon, 08 Apr 2024 11:31:19 +0530, Gireesh.Hiremath@in.bosch.com wrote:

> store bootcount in RTC block scratch register
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


