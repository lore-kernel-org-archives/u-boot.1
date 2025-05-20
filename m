Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3277C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 14:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2502B82C96;
	Tue, 20 May 2025 16:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fj+YxRMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F06B82CA0; Tue, 20 May 2025 16:42:34 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F2082C87
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72a4793d4e2so4225067a34.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747752150; x=1748356950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ot5jC//XeV3nSSb1TavPHBgD82s9bkBh/h1scYbmGfo=;
 b=Fj+YxRMHn+n14kagq2t+8A476jtTOTkJTikx7ziTAOb4aJFpfGGqwjLFWUeJSFU6gZ
 2Otze+n3vNylzjvg3tfbp9PxZk9gDG2pC6+JPWQHJN/UOl9ZsbltfwrywvqEOVJM6f8Z
 dAiob6BbBTGQ8ClOxGRC35B3eaicWNau1S9v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747752150; x=1748356950;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ot5jC//XeV3nSSb1TavPHBgD82s9bkBh/h1scYbmGfo=;
 b=Zs+mM10MP2qwgrcLH5uyV0lsABmLCH9t/PQFgT/l1TcHSgDwpl6nTwGprP9yLKOyND
 VN9DqEsUoX5dV4cqLm9+gLizSXLnqPtE3WfMEpVw+Yfr0GK7EihNTUu9R+ATd1vFo02p
 pe4DQD5alotmH49vo4HvZxd26LmbRb8h+cyXGSsWt1bSZPDfZp+3ffapdsqiv4QmT250
 wKBIUUvRf+q9xWbJb3NqZc5lyIaiEhQLB6stanZKgdcqaraTqVw36/CNbso1N2Rxk6ks
 MpNXl/PBxl5N0oPBmInIQEZIQP+9aVWDzS8g4sq8cIyIEMaexM9EYSTFOeALPaTGm5aR
 FIAw==
X-Gm-Message-State: AOJu0YxrjBuCMvvItunnkZzjloaWnR6iYbMivMjCK6D53eHCGSorKcvg
 c6vZxNBh6cTAQQp/IETxfwjsxY1Rb3x/lAaMi8Y9wDHpUkMxbDG8bibw6wqkjsAriYt4zK6UpR/
 HiOy4
X-Gm-Gg: ASbGncsgiqbRjhrO8esU4FSCk8GwfJxYV7csE7M6Zyq04euuNkNfl5bPnc4JXbQEJKf
 b5+WyQiilZykkXzZBdAJUzThvmhpRB/HoUO2TMOyctY+5NBTIRGATX+EG3JBGFzjDKX9RHYFUiu
 /cGz4eT1iq916feke2gMsWDodKn1Y5Jpwsrajl+38DjzTsORc5ZQK9vlwUsEwa9zAhVE2DD5rmZ
 I3iIV4tgWqaAX5X+fatYAWkzrUMe3/X3KR65H2jMXjyQVwwd5uQI9bAr+G4fwKnkTGOmm/BaN80
 UH9B2TWN9nlZVWJLNjY+Uiw+ykUawNckZEpGHLW0XENatQYujC5M+wN1Z97pMGPHtLcrq4uGKIu
 zw+56xe11ycUGpyeOUgzv2w==
X-Google-Smtp-Source: AGHT+IE8Pf/UU3rhw6jG0E65u9ulh5MRI9bPkRG7t72usI1DiQAuoGxrnikQ+ezMTW77vIK8vfHi9A==
X-Received: by 2002:a05:6808:11d1:b0:404:a009:630b with SMTP id
 5614622812f47-404d88cb4aemr11150113b6e.39.1747752150417; 
 Tue, 20 May 2025 07:42:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d97d5dd4sm1754864b6e.6.2025.05.20.07.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 07:42:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250520153336.GA23450@nxa18884-linux>
References: <20250520153336.GA23450@nxa18884-linux>
Subject: Re: [GIT PULL] Please pull mmc-2025-05-20
Message-Id: <174775214945.1613442.17189949680253749618.b4-ty@konsulko.com>
Date: Tue, 20 May 2025 08:42:29 -0600
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

On Tue, 20 May 2025 23:33:36 +0800, Peng Fan wrote:

> Please pull mmc-2025-05-20
> 
> -------------------------------------------------
> Fix mmc cv1800b build without MMC_SUPPORTS_TUNING
> -------------------------------------------------
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/26241
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


