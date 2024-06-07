Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDD8C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A0C88516;
	Sat,  8 Jun 2024 00:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UPuXhXkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D56884F9; Sat,  8 Jun 2024 00:03:49 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A62BA884CD
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-24c9f6338a4so1331168fac.1
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 15:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717797825; x=1718402625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PKmVQICqpiKiX+KzLjs/8EWiC9cNhoZcm2sfkAau4AI=;
 b=UPuXhXkMnNs026SqDXVzOlccryQ5IDYPFhx78m45a6af8I1r03DrFJdvkoJmeWerxo
 GcGu58SNXrBNDix8OefEuPRNV1xaCf2NCU1cILz9AL1839o6T73QJiZqPMJxattWGFZc
 TgdC9KpdhbJNnwqB+MtFWLMpyTeq/L3c8XUow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717797825; x=1718402625;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKmVQICqpiKiX+KzLjs/8EWiC9cNhoZcm2sfkAau4AI=;
 b=BdRNjRS0zBxVI8gOx8+6Vh+KFqZdS8CbduTgONeXSDwz6ziZBeNMpsTjbfkM8c39zf
 pFzz5zz/kCaC7WNMCfNlRDy9HRPi9Zi/hDOC3E/o1BCswCiKMriIvdlgGguLsVz/of0P
 WAViPiV1jDV/rjxFjYbsBg2VdX6Sk4zbEnmtJGruVBip47JqawH+bI2c5CK1X0PdBCJT
 Z+1bMWcCkW9j38+ZAsCikbZWu0ptyHi56YWjUnaJ+8d+TCqKYKP0Dj/ruQMvMfsmteHK
 dOd284jEwwpYjTa9mX/jddxGDzYoXIYAJW7XOboe/1gT04fFz49MwIMdMl7NX/L4Ucur
 y3Jw==
X-Gm-Message-State: AOJu0YzLgJ4I9mq6adcw306V3AX85e9rEf+PKorifTbsPxOfRZ1eYb9X
 MJqRT8WZMIW+uSqUuc3GlTeJpmDJqmi1pT4771xA90V01/02hL7E4ASWDOEC1Gg=
X-Google-Smtp-Source: AGHT+IErRu9uBQNFHFVjBGmGcLkT2h36olWZ9fAAzG0MVid+0OpeoVM5KltVnf/r9OzYk50JDcIbOw==
X-Received: by 2002:a05:6870:d6a3:b0:24c:5e17:b9fe with SMTP id
 586e51a60fabf-254648005demr4001479fac.39.1717797825417; 
 Fri, 07 Jun 2024 15:03:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254951da4d4sm58415fac.47.2024.06.07.15.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 15:03:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20240522061827.601699-1-d.schultz@phytec.de>
References: <20240522061827.601699-1-d.schultz@phytec.de>
Subject: Re: [PATCH 0/6] PHYTEC SOM Detection API v3
Message-Id: <171779782470.4156831.2064688046515488352.b4-ty@konsulko.com>
Date: Fri, 07 Jun 2024 16:03:44 -0600
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

On Tue, 21 May 2024 23:18:21 -0700, Daniel Schultz wrote:

> This patch series adds support for the EEPROM v3 API.
> 
> V3 is backwards compatible to V2 and therefore, the V2 image still
> exists at the beginning. Only the API version changed from 2 to 3.
> 
> V3 is a block-based memory layout organized as singled-linked list
> with different types of blocks. This is a more flexible approach and
> allows us to extend it by more block types in the future.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


