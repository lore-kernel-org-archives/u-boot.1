Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB56C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C71BA833FA;
	Fri, 23 May 2025 15:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YtIhgfoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC7138331D; Fri, 23 May 2025 15:19:35 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CFE830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-601dfef6a8dso9902728a12.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006373; x=1748611173; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rdXyackyZCLvnDuLg46aBEh259K7yyzScIMk4He3Oc8=;
 b=YtIhgfoWE5EYNRe1m/oNnquAx0YVhDDz3Xe5Or+52GYMW/4t8ECYtrYtN4VDF2DmNJ
 GwhUHgD0x6v59bA+sOZ3nm/y5AS6CXutWp3TgAzCdjVhRrcm+rdkRnJOjcdKv7OESaTC
 3XlHzob7Cqa4KScrM9PJvFN3O1rHh8mwySX84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006373; x=1748611173;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rdXyackyZCLvnDuLg46aBEh259K7yyzScIMk4He3Oc8=;
 b=WVq7hCJJRCkS6dg7lY/3P7ZbpW4gyGDffV3wcFvEUWTILAcqmqEjZtnf9Y9OAdb16Y
 xplGMlGimV1+bQtoM8RlGQz6SRO4EMHXx+pXBEWJJ6fwG00GbvcM6N5OfpGvy4O14i7B
 KAdy+iWsqAG+v2SnvwrEjhDwC+Tvnz9kvFsie0KMD8v9bGSvHzagMQvR37vNvtOmWtAg
 Y/I/ipwpHhQSxuyjOMi0zVQvR9W/IQi48C7TuBHAyDuszvqAXCeOR2y8eKMk2sosNZvQ
 fW4ELDtzqVjMbDNlTyUIAjA9JLVbg7oqoEfg8KHo72GwXp5dXtb3fmCLsEMi7a+IqquQ
 s1Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE1hkWIDVDWI456ehK8aCesnau9EEvyVYwPDgULke4g+MhglanoUE5gSThSWNJi1oIUTd0fq4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5Th0XPPYcYifNlFu75Y4oEMOIJkhD8Fz6jkKdI1DGmY4eOCiA
 KoQSj+0QCPky0BfVaGP5hW8+hPmF77BczXZxo2hRfsjYBaNhNeN17UW/jtFMU3eUXcR19+x2wca
 caK3k7seBjIsRlO4SXbv+AgTeLu2HjYBy2CK1gan+B5nLcm75IxeIBuGO
X-Gm-Gg: ASbGnct9llpiKALx7gmWRfShFlhUmrE0s61HA34cX6OWNJte5mQ3T8ZxWtgvs6PKZpl
 ZQwPpg8xHGKpBEiMiUc9yPwqOaUwGan1Q4vFJ3Fh6sV9iE3yAyhK09H8lNhYf2RWkZmT+F/VqCI
 b9EIGzDynQ0k6Dq9SkSv0BrtNZeKvDWvP/yw==
X-Google-Smtp-Source: AGHT+IFMNAcp9IwpFzguhZKpqTfa5UwDezHmSHXT97zUoMrXe37r0BhwebNrzD6pDiyHZoOV6pRb/eeVHC/7tjXsyPE=
X-Received: by 2002:a05:6402:1ed4:b0:602:266d:5865 with SMTP id
 4fb4d7f45d1cf-6029164f831mr2549645a12.9.1748006373432; Fri, 23 May 2025
 06:19:33 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:30 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:30 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-2-sjg@chromium.org>
References: <20250504132356.2317305-2-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:19:30 -0500
X-Google-Sender-Auth: Lbi8zXgpa65aN9iQqszvGsaXyik
X-Gm-Features: AX0GCFtYfAdSvYB6OyK_uVzmeKLuBOQky_HxIwwZbICehKjGq5ehnVU-mXASGkY
Message-ID: <CAFLszTi6LwvSoNtThF5DzKjJNFzJxB5rk5DjYi9wzsfkiwwjcg@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

It is easier for tests if the top-level control logic is all in one
module. Create a new do_patman() function to handle this. Move the
existing code into it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/__main__.py | 49 ++----------------------------------
 tools/patman/control.py  | 54 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 49 deletions(-)

Applied to sjg/master, thanks!
