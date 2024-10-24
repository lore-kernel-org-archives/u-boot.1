Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F51D10374
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 20:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1BF88FBA;
	Thu, 24 Oct 2024 22:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HG6NuIxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA63788D61; Thu, 24 Oct 2024 22:43:01 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F03788FBA
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 22:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b1467af9dbso98709285a.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729802574; x=1730407374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GthUmOfBvUNuzUhy1FrX37tRl9jbzHOJ1CEvlEjYhbE=;
 b=HG6NuIxF9vPz+Rp5J95CfCrUIKzHEp2XMww2PyenIXxaMvHlRH6cS4vW2oQfk9bd5i
 BE5iZtYVyCxeyRVgzDoZxpavxt7Dejzr4rAkus7hOkJesWV2Q75JEFvZEe3KIELqb9wg
 mZik/nGpvcKt5D1XEAGPco/+pSU0UHAPCKXEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729802574; x=1730407374;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GthUmOfBvUNuzUhy1FrX37tRl9jbzHOJ1CEvlEjYhbE=;
 b=Pthj/sdUOYcYYrvuNK/vjcZUd6hAu9d6/btTVi/8/5NArprhgLH6QTVauouhKJBcaJ
 XUDe/wucLnxR1hkA6rpSCd76kOf+C55hTHhT3Ryx/rXjLu8sEwj8fYuZJBIL0gr48z9R
 oiYtF/xXoFyZX7QCgBWiYgyk0/O+936QkBdpdUFP+KP7b5RXkDum4l4xKbZ8WoqqOxTd
 UBOGhMRjvtoxYz6R1pszsv51vramRQyjjjb+XzdRmpKHVMNLuuwru7Abm/OawJiTVvyw
 1A6iXGY2oyNsN+YL3sw4xTUgOEPfCcTRl7EuErd7qiye8lqGmkOT2JrslqIgmAwZvetf
 YXDw==
X-Gm-Message-State: AOJu0YytuQBPaZSQ/lZfTPhq1X6pMAq5+y6CNsSRtMflIVU9jwMUKkAW
 7fjAuKinN5AOoNpxQ5bpD/RpORruHsqxV3gL3PPs1e3JYasklsslcriEhzYBpVRNjF9QfbRmtco
 EtIOzgQ==
X-Google-Smtp-Source: AGHT+IGVEX9DOaUKblPB8r1DVxdAlUxfenZmqQN4g+BMfO8OLnBrdGdtqGLOBzPnubFKKRuMTSqi7w==
X-Received: by 2002:a05:620a:24c9:b0:7b1:547e:c969 with SMTP id
 af79cd13be357-7b17e54007fmr937812385a.2.1729802573955; 
 Thu, 24 Oct 2024 13:42:53 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659c0361sm521428985a.19.2024.10.24.13.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 13:42:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241020154323.43308-1-marek.vasut+renesas@mailbox.org>
References: <20241020154323.43308-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] boot: Introduce BOOTSTD_MENU to control bootflow menu
 build
Message-Id: <172980257256.160410.13884385721078297512.b4-ty@konsulko.com>
Date: Thu, 24 Oct 2024 14:42:52 -0600
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

On Sun, 20 Oct 2024 17:43:12 +0200, Marek Vasut wrote:

> The bootflow_menu.c code depends on e.g. scene_txt_set_font(),
> which is only built when CONFIG_EXPO is enabled. Introduce new
> Kconfig symbol BOOTSTD_MENU which depends on EXPO to prevent
> triggering errors like these in case e.g. CONFIG_VIDEO=n :
> 
> "
> boot/bootflow_menu.c:158:(.text+0x8851): undefined reference to `scene_txt_set_font'
> "
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


