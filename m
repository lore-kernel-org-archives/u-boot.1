Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681B5C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27BC48331B;
	Fri, 23 May 2025 15:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DtEFEiID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27214830B4; Fri, 23 May 2025 15:18:45 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E597583311
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-601a9e65228so5946607a12.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006321; x=1748611121; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QFEJfHMXd3Hrj776i2j/aFwEhMcgu0nUt9Rx3vBWRoE=;
 b=DtEFEiIDzo4NcEicFHRQ5DcjDdFIwdahr19qvZHtmXaMx5bmfTpEv6YQMSeMJ1tlNb
 ZD+TNRQGCdbzZti3IpwKBCNjuyp2vkFpO0FYZku1XL2Ys1SGPy6e73+uqGnoIn6Llieg
 9QKphIJhbgByahZoqnpPUKTvWWoN1rXPdaxqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006321; x=1748611121;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QFEJfHMXd3Hrj776i2j/aFwEhMcgu0nUt9Rx3vBWRoE=;
 b=RrPCt+Ie4ZSTrv7Jw9+SERHwdWOCL4MItevCH9tBg/JiiDZLumZC3Kq9jBss+uFu0q
 njCrGlWEBNCNuMxuGPXZRJ06oDe0C/t6AtQRLk8lZbWjVHEo9m3lrTKHexGZYiA9QjU/
 10i6Ow/h8Pt+SzDzM67+IToTf8SVDyfToPJVUZcpXcUKVlcYZH5aiMWE6JDOdGoJSDPy
 ny9yIGTudlcLSyH/+p1mNOJ9t855pfXXh6ht5IMUZAzEZqFQYELaJ7nFlf+Y7HspiBe9
 NLPNOl/MbTP+u/Rj0jeXjGAgii0jfTdLIXh/Gh2UwJ5Q4VqZYyFRdR26eOVucgtFlI/E
 YMyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkma0OUbO4hZuwkQgbka3sODGScQYJAtK1D9ggQErZKaWYE2L68ef4iee8iM9UgZoRtublyuI=@lists.denx.de
X-Gm-Message-State: AOJu0Yys419J/C2vw2+m+mEU5t/OVff2G336eD4RDEvjmEl0Om0TCkqu
 LL2jiffMWYAH7xBvnur6GIwmZ/8COrwN9/HGrMgo7bNEI52cfYo6pEsjkOjCge4vVLTozUTz3bL
 J61Vj6GZddfT+CRAYM4COKT+yM2L18Phi6bcMu6br
X-Gm-Gg: ASbGncv39VcrJiAu8nOVMVSAgAwuiKoErBjkvqV+3NgwUkbtsoetkQXtHBTgf9BU0Ux
 C5ouEedGw6R9DRF+gVXbpZOcjd2e3CihEv5JZwdbcEYzyAzJMXbUoS70mHpkIFmxC2R7BH+r1bt
 LDPFwIlSMMfKi44D/JAwYFhsqxN2PUQFJOUQ==
X-Google-Smtp-Source: AGHT+IFn9oxt8vwFHZZS5wdgeMIk6WDpy5JDWqv7XnvCsoy/AzJMWgFWmTXymnzTW+/X8tQ/f7FTt0FjPe98DwufFec=
X-Received: by 2002:aa7:d399:0:b0:5e0:82a0:50dd with SMTP id
 4fb4d7f45d1cf-6009010e9c0mr21789953a12.27.1748006313261; Fri, 23 May 2025
 06:18:33 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:30 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:30 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-24-sjg@chromium.org>
References: <20250504132356.2317305-24-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:30 -0500
X-Google-Sender-Auth: f-LyjG4rPo0yq96aIBZsS024ANQ
X-Gm-Features: AX0GCFvbP3h8GtjyE1cuzEtftRNAB4QjjbGsWtyrNUXo-Nnecg2zZzc-tlVdd5k
Message-ID: <CAFLszThkNQnaOq8oWKjNvKfL3f=WHgghGO+aF=tY2=BLkamfYg@mail.gmail.com>
Subject: Re: [PATCH v2 23/30] patman: Simplify test_find_new_responses()
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

This test uses the find_new_responses() function which combines
accessing patchwork and processing the results.

Since the test is aimed at testing processing, adjust it to call
process_reviews() instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/func_test.py | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

Applied to sjg/master, thanks!
