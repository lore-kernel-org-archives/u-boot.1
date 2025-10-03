Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90C9CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 22:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D031838E5;
	Sat,  4 Oct 2025 00:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BfHwl6ZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32EC883927; Sat,  4 Oct 2025 00:57:27 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAD2838BF
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 00:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-93ba2eb817aso22983639f.2
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 15:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759532244; x=1760137044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVdgYc/450qQClrsIPJxAO6JSrb1Xt3+r3RFlZkiUfI=;
 b=BfHwl6ZUs1nbPiBSvaUAT+umk4sDrLSXsviukeW+vgPoYo85zL0qZ4z+ooEFTvNKSk
 I/26fOmOcbU1UzdAPLR5RXkJLiJROMa53DDsZe8NEdt222330UjgqlvLNxKArHE9XfwW
 93kPsRO6w5zzkCviR+1HdJZOKB/aMRWM6vCOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759532244; x=1760137044;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XVdgYc/450qQClrsIPJxAO6JSrb1Xt3+r3RFlZkiUfI=;
 b=QVUxhsSEFDDrT9sVw6BGUa1DpXZtTLGxuQ1JkWojs5uxKyN+Dce5T1vYWezqd7ykFA
 WscqZLS+3yB7YCYALSuPWK252YL9IA/qaXSXKtgqz9Yjjc4ZCgI5oOY9m6kweI8BpS6j
 /ZSk1CUqT+gxrwCa/iA1asq1U9dmdCYg8XEUISk3RuYZNLQfibakBmtr1Nj8EUODhqMl
 rYiaO4JNe2tUi9iaDTRsouY80ea0jMJWwz97P+46uKKrXikBgCiUx7VGaEcRCd17TG0q
 BQCrJxQNOWvfqiPOldAWfhx9K6BNdg4BZnM+DNxyXWrrbaR0+Np/J1JO3CjhMPQV/ctl
 8nLw==
X-Gm-Message-State: AOJu0Yw/nXwipxhWawSXUdvU1bHsbkOJxu2dxKibsb4gWHic8Jj4eCwV
 /UJSCxqECtdj5XQOcLxku2rrL6Isq3PP1p0fNN5WJhUvdycFWxD575AUCDY3StCIC7g=
X-Gm-Gg: ASbGncuDucrX/QzR///8kJymW5tyUx+nzcZUUK1SNvYD+Q8EDL6T1m0welVSlpxw4w+
 6gqgiwHBOaYoIDiy0UCF13xfuB0mnDVJPlMTyuiuBg133sJDDuevfz/4AvWNuiFSWK09lo/T6mZ
 hrFIQtO0tgeMbh7JZ+m5VS0+mwpm7ROnprkor7Xa6qRAlJyciF0Hpc2OhiILeB03M2/Uu95B/S5
 fY4wjQOg/FuSimoH/CS2j9/i6n2y5OG1/QP7nB9j6K9II4mEu/soC6ljE0j2rKTiqZZvbr/bVi5
 +tKp9v9QUobmIJUgmeOtFp0RoAtg0w2P+wcuHNUqgmI3ASjXF4IgnTeavTWA/KN0byCHgilOJvL
 1i8O17YrSCghNfEJtoJaUmT87EzvMzZecuMJtez1N4FjAONrBChKIYa9c61k+gnvlzAqieBm9AE
 x4to8m/Ilr
X-Google-Smtp-Source: AGHT+IG+/1d/y8vSJBRRBpS0uljrm1AZJOykgrxiwUjAK2vp7F46SRNs8dO91mwjq+P8UAmlTFzM0w==
X-Received: by 2002:a05:6602:2b06:b0:905:2ec1:930b with SMTP id
 ca18e2360f4ac-93b9695e452mr658025439f.4.1759532243729; 
 Fri, 03 Oct 2025 15:57:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a7e3a3ae8sm231743639f.7.2025.10.03.15.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 15:57:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>
In-Reply-To: <20250919134308.122437-1-wolfgang.wallner@br-automation.com>
References: <20250919134308.122437-1-wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH 0/3] Drop ATAGS for B&R boards
Message-Id: <175953224173.2203583.4013095754843447257.b4-ty@konsulko.com>
Date: Fri, 03 Oct 2025 16:57:21 -0600
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

On Fri, 19 Sep 2025 15:42:59 +0200, Wolfgang Wallner wrote:

> There was recently a discussion on which boards need ATAGS support.
> The B&R boards which have this support enabled actualyl don't need it.
> This patch series drops the settings from the relevant defconfigs.
> 
> 
> 
> Wolfgang Wallner (3):
>   configs: brcp1: Drop CONFIG_SUPPORT_PASSING_ATAGS
>   configs: brcp150: Drop CONFIG_SUPPORT_PASSING_ATAGS
>   configs: brcp170: Drop CONFIG_SUPPORT_PASSING_ATAGS
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] configs: brcp1: Drop CONFIG_SUPPORT_PASSING_ATAGS
      commit: 5c9dffa40525e86d3b511a53bde0f43b72cf0719
[2/3] configs: brcp150: Drop CONFIG_SUPPORT_PASSING_ATAGS
      commit: 92c2effbbfb7b03f93f988273550f6b6079fecdc
[3/3] configs: brcp170: Drop CONFIG_SUPPORT_PASSING_ATAGS
      commit: de8f3868102e420eb229b090597101d5f46dea2e
-- 
Tom


