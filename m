Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B270DD2A555
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 20:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EC588DE1;
	Wed, 16 Oct 2024 22:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="faa0eS++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64A1D88DE6; Wed, 16 Oct 2024 22:07:51 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215CA88DD1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 22:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbf2fc28feso1395376d6.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 13:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729109267; x=1729714067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQRWXmP7PGfkfL+QSm2LKCvzxvlsPWVzPg0VyYxSWhU=;
 b=faa0eS++NyaV2+jLvaGUSaAn0ZOmTt9W4Q9gYaoXgCFTNhdbo4HNn4Qje3y+iH00fA
 h/4P1TZ6l+Ljf/NXSccVyDBx8M3oqR1bu/P0rubcK3NvsziaIVuohoUd3RDIVVk/t6mA
 Nf4I+7bguLCbLdMCq1SvisdDePZkc9hgMJjAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729109267; x=1729714067;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQRWXmP7PGfkfL+QSm2LKCvzxvlsPWVzPg0VyYxSWhU=;
 b=gv/e5+tKb/TGCyjqf6sdO9WiNSn5+uFjzYwRSej25zR9qjRcDKaKW3fGi9tpMfSG+d
 MjcoPzsbO5+PR5EKEisVt8V1m7rVCMFL1OyzJFORqNV7MTzZggqa2iDvDm8gnNoMrjhb
 yMVkAUeEI5FxbisoBAH5ezZLhExV0JTa3XDIKENcoBvbtgnPbygkZzUCO6t8dpZI532M
 TvxxwJbFKJQBQUUpIONmP6caJXjHox/YqoQReKo9QvYcerQiMSxuW6cyyHimdMFQvzOg
 ooVavXHFos7OTSpinKmNbiSiLdbl3E3mwceq578VmOE0n3h6n8IKXOwPLIASU0Q4wJHa
 NFwA==
X-Gm-Message-State: AOJu0YzAiuin8IB4IMsMKtwpsGYr3F4sYJ8zV97R53i+Sgefq2fOtZ2u
 4ii3IrMtsI/31Hj2roYCdHvMMVrL34KoBA7pRqHEzyfCdz/ohwytWGDmfGnwNhk=
X-Google-Smtp-Source: AGHT+IF3Vj0PzA9D2fRI2iRsTwnf4VuaYVP9/3aQOzSsh/OeYa1r8lsZ2YowJDmYltmQlGNUeC47Zw==
X-Received: by 2002:a05:6214:4303:b0:6cb:e9eb:1b24 with SMTP id
 6a1803df08f44-6cc2b8d523cmr68225626d6.24.1729109267212; 
 Wed, 16 Oct 2024 13:07:47 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc22959be8sm21338836d6.87.2024.10.16.13.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 13:07:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
Subject: Re: [PATCH v13 00/21] Introduce the lwIP network stack
Message-Id: <172910926540.24133.2953899765717446506.b4-ty@konsulko.com>
Date: Wed, 16 Oct 2024 14:07:45 -0600
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

On Wed, 16 Oct 2024 11:56:22 +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. and
> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> so. With that it becomes possible to fetch and launch a distro installer
> such as Debian etc. using a secure, authenticated connection directly
> from the U-Boot shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


