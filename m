Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9459CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 15:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2628488F;
	Tue, 19 May 2026 17:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F+0AJuTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30F448488F; Tue, 19 May 2026 17:21:08 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B54284870
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-694891f8f62so1966365eaf.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779204065; x=1779808865; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gomXcHTarkqIzM4C7gBDOPrYCsJUislnHJ7BprnBeT8=;
 b=F+0AJuTRXvOgLY3KxAB2UCE6AkmB1dEui1PD2q459YmHfyrsyET6eVHTPhV33uq+is
 Qd7d79IH/pcA08/R7Al6aIC/gnx19L+AA6j+jdIPr40XX8YaFDzyzwkQoycDGxJp2JUu
 QfWI0VkzvlptS0K+mVeYtHvYjcvLavvOGEqbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204065; x=1779808865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gomXcHTarkqIzM4C7gBDOPrYCsJUislnHJ7BprnBeT8=;
 b=eJat013vKpDMpzO0hkjRKZ9VFhkughJxzcCrSHUI+FJYkBhmiWvFZXVxL7J7ZnaE0R
 4wxOx7RJoYhNLiovQBZevuHrbKxRWGAQ3SoV0MfUxIV9wp28QuK0btQhjnrh0MPzujc6
 wJTcLEWXiJ1huHyGQSOTwqOMnfEWriQeh8tCi2SqeDks3YWDmlWumna2paM7sJLXe4vO
 98uXRNKOUXdDBJcwMEXZAo7rTHd1Ln8PdnCJdMq6iLaMbxKbXl08wnZDNxUFA/0M6E/L
 gJpajuNu8mQvJ/yMKrhDReFPxMk2yeWRg4mfrtH/VLMLkKQUQC3QCbMZB1WTYV+5S9jy
 K7WQ==
X-Gm-Message-State: AOJu0YyFAA5c1geQbMaTwxBkjeulKiA222b09Ig1rUkVduI4yWJzrqmN
 Juj7HxOnNOxrxq8fpWc+po+m1dDWDfAZpNoEARj+TDIC7FiyT+PKxd9qPDgSL866je37c1Ii0rx
 U90F+GZjt7aat
X-Gm-Gg: Acq92OG8b1ElZ1rsHiUOb1B1ldKW1BCS1jjwMoHhM2xpMhl8LT9lMzHONG5G47YxU2t
 4Pbrlz3QAhprh16R17SgazbIQUAwDwNrF2AbyjXap/ynGjuvq+01vDlVLiOwChJRLeaLCtz8tGK
 ySCO8A/165i+cv2RfVMrBE8lwVMxI/1OS3eYDNPKun/Wvktd1+dA71KJ0xrZDt9O/6W+KFFYQrN
 qrPitYxNVjqBnDiz4BHQQGVmp3JAuRe03glCQGPLsQKXBRL/TeGTsf15gYX78WPesxgeD5Q2VeU
 UBgos+cFO1N6Zaqpg51mbmjWL+AR8jEsMlcCttZhrStYkAQ82Wg3nnji/+SaMkM2Ha8rSibTSig
 QMMmqj/1jwQM7dv363TsmyAh1hXN81WZLmX03nnQcdUfiPBCFZNxQ4KuyknCTJZgAAnygN/N2QN
 452GN+NEM/gfMz6UYCzKDaocI0IBmVUVkrz34T+axwn/m9SQksALnTpqiXdqGb93Lc1iRs4M8+Y
 /a9qoMvcKLueJwMaDtLGjwhbNJlwFK+H/eVC3dgEH5ss33ryJaeYx+Q5PRvxTNhkXdrUknYjuaR
 rtl1ScIM0A==
X-Received: by 2002:a05:6820:1787:b0:696:8278:c619 with SMTP id
 006d021491bc7-69c942b4ccbmr12696977eaf.6.1779204064750; 
 Tue, 19 May 2026 08:21:04 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a9576cdb2sm7170167fac.16.2026.05.19.08.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:21:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 0/5] Remove some empty bootdev_ops structures
Date: Tue, 19 May 2026 09:18:15 -0600
Message-ID: <20260519152101.716714-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

As part of Marek Vasut's work to add static and/or const to structs that
should have it, but do not, it exposed a small problem with the bootdev
uclass. This series fixes bootdev_get_bootflow to not require the ops
field in the driver to be set and then removes the empty struct from the
places which had been creating one.

-- 
Tom

