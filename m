Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFB3C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB64832F0;
	Fri, 23 May 2025 15:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LoKJDq2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A97830B4; Fri, 23 May 2025 15:18:37 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC16C832B3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-601aa0cb92eso8412586a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006315; x=1748611115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aLMHIfOMPTa0w87a9/aECqhMafOgBRISkzMvHR1s1O8=;
 b=LoKJDq2g4GfWGuqXNqZo/I50uoUJGGNhRbcpYry+uBBjmEKA3cEZCG9375iJYmAiPV
 SNzawOl9ZJfjM5igOH3ZXFmNA656RFrDRq8bWEuHIp12WtLs4NOV/rtKvfxIr90esHTC
 K0zmFZn5wRXeg1rTCS7lINqAQwtUSiKUEQE2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006315; x=1748611115;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aLMHIfOMPTa0w87a9/aECqhMafOgBRISkzMvHR1s1O8=;
 b=nkK4bh8JxlOpwBw6MjTvNMac40UOrHdIOv3cDRiyI5OwrOdw9IPh1uchFZ3EwcWcAz
 yA9EDnfc2J+f+REDyUKeCj+CEgjTDL9sevYNsjSrVXZJuV1vOcr++1stAxLEIniI1KOX
 kruoxROfwpOIWTdEb7VvQPtdSnAtDRZQ1mMIsxYvJyQoXokR3VNznEoj2GxJpJ6Z/QSf
 GPwnMTSCekboCLxewy8HLzhmSHKJwptkDwxvTO30B3Xb27qHjNQ9JprtlvcSaSrmjtoK
 iUd0NACg2oBdV/K844lP0ZDpOLhMjwvNwxqcPo9O9LVQYXLy9ZMGxbWLoFDy/PtvG+FH
 5epQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxX0wfAvztV7zK5EP4NZPnZWgqau5XJQsdfkM74fctg/bgb5C5JocYWUjiju0WgBawL4hkDJU=@lists.denx.de
X-Gm-Message-State: AOJu0YyBHuH9F8eU6EYeX7V+De8lE+qqsggxY59DypFhUgsoZQ2CNRPt
 c0LdFOyJPOtaajSQyF3pCFGYJeJpixXYMwV+XC3mzqSVXb51dL+WhHlYpieOctaC2D3mSsPhhSi
 8OBypc0lMLOMwHsO6J9z1YgelSapVJ4KvZbm8Na24eMCYb9/+Ryyk7ZUR
X-Gm-Gg: ASbGncs7nMSI4AvqMT0lWgx73dU8JFKB5pR7pXpauIbG6Hus0NXEYH/3Njm3W+Un1/R
 v52gMhNcg5T5fJ8F859+dYYTu9HsG9yaX4J6Dh9tosh0xUmPL7J9doD87URz/jQn3nRKk99Zqfe
 oPHp1AraNP5L+OUZMGRkAby/ObP9GJofbJnw==
X-Google-Smtp-Source: AGHT+IGECJkuSvUjw8C+DKROGv6WDK6Vsqeah4vLYHPq8B8GKUk+jKvZUIcDt3OR7rSWAV6KN4rT5AMYAM+fGtxC3Z0=
X-Received: by 2002:a05:6402:51c9:b0:5fc:994c:b6ee with SMTP id
 4fb4d7f45d1cf-60114087657mr25420873a12.8.1748006315224; Fri, 23 May 2025
 06:18:35 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:33 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:33 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-23-sjg@chromium.org>
References: <20250504132356.2317305-23-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:33 -0500
X-Google-Sender-Auth: h1PxRxP8PSCaCsij5KIPq64mwL4
X-Gm-Features: AX0GCFvkBYlSQJEQzvxlo_7YSYe8Q39pmuRGdCJRnplGrWaXv6wQecLwrdQp6VA
Message-ID: <CAFLszTiTZriyxM9Z1J0kGA73SUm-A2esbYWYfKy3zcpGkjnmAw@mail.gmail.com>
Subject: Re: [PATCH v2 22/30] patman: Adjust how the fake request() function
 is provided
To: Simon Glass <sjg@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Instead of passing the URL and function to each call, put the fake
into the Patchwork object instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/control.py   |  4 ++-
 tools/patman/func_test.py | 41 +++++++++++++--------------
 tools/patman/patchwork.py | 26 ++++++++++++++++++
 tools/patman/status.py    | 58 ++++++++++-----------------------------
 4 files changed, 62 insertions(+), 67 deletions(-)

Applied to sjg/master, thanks!
