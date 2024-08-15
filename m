Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05DFC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B8C688800;
	Thu, 15 Aug 2024 22:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nt0ilhoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA41388C3B; Thu, 15 Aug 2024 22:33:51 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52D6788C52
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3db2315d7ceso761802b6e.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723754025; x=1724358825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SL+GKQFrlpUnvAhphlySxv/BCSAaxSx8yKZsvMB6RyI=;
 b=Nt0ilhoTryLDMXBhZf3/PhgaiD5eqK6nP3P4Pwv+3g5FF+dn1W4fXdRqo/ZS9SWzuT
 4C75+oPo7NfcdnoeQOcwb1bnB/l7cwcfhPQVTY0G97X+8LKn+Ji2YVIctKBco/n9KrHO
 eyztBWvxv7sPb4Gfyaae2tk6q0rC81ND4bf0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754025; x=1724358825;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SL+GKQFrlpUnvAhphlySxv/BCSAaxSx8yKZsvMB6RyI=;
 b=lKipOjwr9q3aWGeHJZLtJ+Oi/9nzSSGH5i9Z/6wq/1VRiAscnqMkTEPgxJ1t+LLM0Y
 KoI7BK3ExgbYLrkZBghYV3PvQTpm+NcS8DziFB7XZiNuctYzECc/IeLrRomIxhsuEvYq
 HD9vNZB7fa+DxyLK2elq8ISKZJizo0ejlVju2JR2bIxZqwmnTTVfifVkLR3CvQDd8eCc
 l2zlWjUdCZhzLzkxbnnUuAS6hnrbd9JnmIH7b8r+jVD32w9mfbDk7Ud55KdUaEQtHnpY
 NgpKkNPIfnOLqY/lq9DuGk0VnnFiLsggqweQEHTRep4wFZUEXWucvJql2k+2SuCK0YVZ
 D+pw==
X-Gm-Message-State: AOJu0Yz0D/Lgz64TyWcB2R9neQumdi7HQKR8YE/UqrszbE2TWH2Oelwb
 sn7tbtL8xl2Yn6DBqPG62OLesMSonln7e7EmTzPVrm6LIYWVqdqv5zwf5LbBz97PvmZFZ8jXpBj
 CE68=
X-Google-Smtp-Source: AGHT+IFoEX0EcEGwegy0eaIcdgKHeHGQQ+Q01bMRgazPjrR8q/s+T+tOPHvqhZB0voW2yyudImy+1g==
X-Received: by 2002:a05:6808:1528:b0:3da:a779:ab70 with SMTP id
 5614622812f47-3dd3ae2278bmr711404b6e.45.1723754024973; 
 Thu, 15 Aug 2024 13:33:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd33ef4338sm400988b6e.48.2024.08.15.13.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:33:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
Cc: abdellatif.elkhlifi@arm.com
In-Reply-To: <20240813155305.446779-1-hugues.kambampiana@arm.com>
References: <20240813155305.446779-1-hugues.kambampiana@arm.com>
Subject: Re: [PATCH] maintainers: Update list of maintainers for Corstone-1000
Message-Id: <172375402425.3490273.14356266946620175696.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 14:33:44 -0600
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

On Tue, 13 Aug 2024 16:53:05 +0100, Hugues KAMBA MPIANA wrote:

> - Add new maintainer: Hugues KAMBA MPIANA
> - Remove maintainer: Xueliang ZHONG
> - Update contact information for current maintainer.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


