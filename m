Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4431BC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AEA38826D;
	Sat,  4 May 2024 00:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T5I5ZuHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E788F883E2; Sat,  4 May 2024 00:21:41 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 218BF8826D
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-69b7d2de292so947766d6.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774898; x=1715379698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLlqjA1I/MJVnolXDYOkfDXtn1my0LNZXEDwRItsnRo=;
 b=T5I5ZuHc4TYQp03brlzDTkLrrR2siAeNidK/iH7i8KZvau1jTInIgLQgKdaRYzPLsh
 0mdXm9Om1rk4aQ0cT8GYqmLl3avB9jp0TyD57EzDwUNq1COvJmJXTN2+9MNZd9rNf5uq
 HiTsNte/UDkc1ftAThDM1AhPPP8+YqYOcOq9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774898; x=1715379698;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLlqjA1I/MJVnolXDYOkfDXtn1my0LNZXEDwRItsnRo=;
 b=Swt8ajHnoy5cP4vDiE/Z3Fyvw4oU+28BIYftr4zOemMqu5IwLJgmp2MImqcsP6vbvF
 PGajPazOvSRooyawb9hqWwEHagls7KCcc6dnColveq9jAn6SE1LAkEQUpwAFgl1qmmHS
 i4BbMuSckivcSScJPQ5rHUthaFjUgx6w67LIHIS/QdaQObh8vO+XHcDVLuLnDekgpBNk
 Y6MFwoq9O6YXvpFz1MCtzGNoFA2RgnCgXgeRAtwZpyr9f0QUH9nQzfiB2T6TCZj0AOKA
 sWOdpQ5E++m/hNSLuPskpo61RCzs+D6Un6Vy7ePqaD0C+W1YazXPHmWo50tbHq0mN7n+
 TbOQ==
X-Gm-Message-State: AOJu0YwMRtukfDZaATWZIxSct/RdYojZa50uYaFZ8GWhpBrCNF6LNgeQ
 inbjJzEpXcavTPqHIHsUDjsldtak9hPOSXRe/OvSemk+Qf4TbbOzt0Y5xM3rVGM=
X-Google-Smtp-Source: AGHT+IH0bmDh7/zFShaY+/gGwQRWROrgjFU+mwvIfu6CPlgQNyHO8wU3XQUVXGhS9hEHVVhamQQKJw==
X-Received: by 2002:a05:6214:1d2a:b0:6a0:99c1:5427 with SMTP id
 f10-20020a0562141d2a00b006a099c15427mr4508266qvd.3.1714774897867; 
 Fri, 03 May 2024 15:21:37 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 qb17-20020ad44711000000b006a0e585dc77sm1557152qvb.70.2024.05.03.15.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:21:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 William Zhang <william.zhang@broadcom.com>
Cc: dan.beygelman@broadcom.com, philippe.reynes@softathome.com, 
 kursad.oney@broadcom.com, anand.gore@broadcom.com, 
 Simon Glass <sjg@chromium.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240503052344.195819-1-william.zhang@broadcom.com>
References: <20240503052344.195819-1-william.zhang@broadcom.com>
Subject: Re: [PATCH] MAINTAINERS: update Broadcom BCMBCA maintainer
Message-Id: <171477489587.2575911.5155575571607366606.b4-ty@konsulko.com>
Date: Fri, 03 May 2024 16:21:35 -0600
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

On Thu, 02 May 2024 22:23:43 -0700, William Zhang wrote:

> Joel is no longer with Broadcom. Remove his email from bcmbca maintainer
> list and replace him with myself for stack protection maintainer.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


