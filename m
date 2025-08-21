Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F35CA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 17:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F5C482998;
	Thu, 21 Aug 2025 19:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FxNNoaM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1029480EE5; Thu, 21 Aug 2025 19:16:42 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E597B80548
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 19:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30cce8ec298so1026111fac.1
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755796599; x=1756401399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RStaqBit4ZIjGQnqEmwOnWw2b7mPHT1h3QcZG11iH9g=;
 b=FxNNoaM5dwv2XvKW3YhXwrAeqM5+QilAlf/pAlmdRyazGNf2xzPkhZ/6RciD38BS/t
 GdtWFima8X8zsfe7l6Y63aQpE7VqjslwdO2AkjAKetBD4am+unrAJcbDXo4UVvRA+m2h
 fMgzPUhkjfdyAzA9FPh8P/miIHc4UbA/A6mBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755796599; x=1756401399;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RStaqBit4ZIjGQnqEmwOnWw2b7mPHT1h3QcZG11iH9g=;
 b=Vhg4j0Y6Xh42yN9cqkBDam62HJyJ+hpXQR6dHbyOPWlgj9S6NDf2EyfKtezsVejgcM
 Mt+sx2tbm6pMKJv7PlQMFW/1p2V0A5oKl7n5RPmfC6C4MUaBl1UgxflDslO1+t9AF+3v
 nn6g/3r3CusmcYc1eY6o3l5BmdxEXqgKNyg4SMkZJfjOKQDnNRZ6K9iPpiawT8uxv7rI
 pYqOitozc3/pqxsNFwNX1n/724lVluzljikG/i4GuY1x2J2Smrrb7yM0025k34yZHduz
 u8eVDOdGbBcnqKDlexIs4c5PR9h+CJergLpHDq5OMYMXa3C9CN/H3D0COEVPtN6IUluA
 nGWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRrrNsHWDrnEe2OSs7saB6tkd1b9/nEMnqG9bo7Qg1ReCCInpzaG+cOfwYzKVXedi7rS+7YVM=@lists.denx.de
X-Gm-Message-State: AOJu0YyQu4lToSIVIG0SJER3kTz/20HkmWggRPNTBHjA5aK5w74Mvj7u
 S4OTOe37DttAdXpvMaZFGBFfh9FtYUbdyS+M71z652OkUrIgEQio24IH5vFrxGmVJT8=
X-Gm-Gg: ASbGncu73hB+NCAF4jW0FQqHEbIeezAO+fehQwcR3tNngKhBMOCrxfBK1/vEOHGJ0nw
 EBWIG8EORpVzyug27GRV9Yg8tr7yKh4ksShEgMRooKAsJODUbni1Os7386twamQhUYpS6fKQwEp
 jVDf04fxLbYkPWYiP98BjYgrteo9XEBCS0jdt+FKAKGPGXbOvC2u9bOjuYkApf0jgUn0OKAMIjV
 zdXd/coxjBCzfPRhyI6JtyHekX5IE6RQT5lgkT1DfQDCsGLoRzFEovrYZdeZ88jmg72O8nnmJGZ
 l59Kdvpq1upMS0DDGvMlcILxUlyX12H3qFDc85T7xd+siT0lqyzFgSQgKy8V4VDGA43ACdSsMZA
 Db5wv6V3FkAGk7BL2bt1lxzYkVahbAVvezR4Pjz25smZIZPErt1/+nIA=
X-Google-Smtp-Source: AGHT+IFZe9kuphEtusHIKfTgCwk0xEEqKVzuIBBAQ+1i69H5HadWRD0kT/tU+KaIUPpqKm9iTEICmw==
X-Received: by 2002:a05:6870:7025:b0:30b:522a:71b8 with SMTP id
 586e51a60fabf-314dccfed63mr8980fac.22.1755796598642; 
 Thu, 21 Aug 2025 10:16:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab952d79sm4999909fac.15.2025.08.21.10.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 10:16:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Hari Nagalla <hnagalla@ti.com>
Cc: vigneshr@ti.com, afd@ti.com, b-padhi@ti.com, jm@ti.com, u-kumar1@ti.com, 
 u-boot@lists.denx.de
In-Reply-To: <20250813214705.12774-1-hnagalla@ti.com>
References: <20250813214705.12774-1-hnagalla@ti.com>
Subject: Re: [PATCH] remoteproc: k3-r5: Add support for single cpu mode
Message-Id: <175579659757.3655101.14236181450761488539.b4-ty@konsulko.com>
Date: Thu, 21 Aug 2025 11:16:37 -0600
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

On Wed, 13 Aug 2025 16:47:05 -0500, Hari Nagalla wrote:

> Add early boot support for AM64 single cpu mode configuration.
> In single CPU mode the 2nd core of the R5F cluster can't be used or
> unavailable.
> 
> 

Applied to u-boot/next, thanks!

[1/1] remoteproc: k3-r5: Add support for single cpu mode
      commit: 15642829127cd503838f28254a1f3e080103ca4b
-- 
Tom


