Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238C7C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 19:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E82988579;
	Mon, 22 Jul 2024 21:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O48G9rqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F13E83989; Mon, 22 Jul 2024 21:32:03 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E630A87A09
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 21:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70368b53cc0so2349350a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721676712; x=1722281512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JkYgGDtlhCr0T7sY0BAVJDGRtg2GIOKoh+c6XWuOmGI=;
 b=O48G9rqruTftkfpljTyqO7YwDCjIO81w7W6VxQMXpaHO81ac2GIYKYX+rTmLFI8bpD
 B02tu7Z2HemMsy8R0wgrdXldqvZ2Myp5cNLJpS8Y0V+swBs2YReXCftM2W3CXn/DGSiN
 WAR5IZndhO9C8Wwx87RB7CUeSYgkov95Fmz/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721676712; x=1722281512;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JkYgGDtlhCr0T7sY0BAVJDGRtg2GIOKoh+c6XWuOmGI=;
 b=whiAw46bDwsqqh6XmgfZnlF2uPC7tqNw6VFe6dFMdIwuaQnEpC6zowdcXm4WVrYKzD
 2Bngdu1iMnNiF//AQ3YG35p7RaWtsxml21EFh7EZDOBD8KXiPVSWR8hykifZCfV/iLWn
 fKWReMY2oElBP0rgwDSmabJtQUr5frZyXY6kVUKGBx5BDBCODyg+K/DMo9ehI+VenXXV
 hstEmbtysxs6PIz8+yrm02IcYEPsA+XCyONQyY1JAMDS+XiOJwstUR3zjPWe+KOuoGvD
 ylqXRV2QRjvNDxSgY5iCJ2UfUXDMt/hynPM4cH3UuWhbsWeH6z8COn8oT43omomR/Oqq
 cw5w==
X-Gm-Message-State: AOJu0YzbrH4BBUvI/zxgUqWFuKYVkQuO9JWQqlma6hDl4y/0TPj2Yirl
 IUT/AJ8U1erZhORlE43xIycZ5U0veCT10Yz5BsBK7zpLrRoq+cSAhXnfg911Da4=
X-Google-Smtp-Source: AGHT+IEVyjM3lYq+zeZE1wqmPPnlRh6Pb3NlE2nnszSPR44h7Y8OsL/OL4flKw+XlmtuNf0NFASbyA==
X-Received: by 2002:a05:6830:2651:b0:708:721b:4077 with SMTP id
 46e09a7af769-70900983995mr11077863a34.23.1721676711703; 
 Mon, 22 Jul 2024 12:31:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60d68c2sm1651550a34.36.2024.07.22.12.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 12:31:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 01/40] drivers: ata: Remove duplicate newlines
Message-Id: <172167671085.1260831.7250347256928773987.b4-ty@konsulko.com>
Date: Mon, 22 Jul 2024 13:31:50 -0600
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

On Sat, 20 Jul 2024 14:40:26 +0200, Marek Vasut wrote:

> Drop all duplicate newlines. No functional change.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


