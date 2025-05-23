Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A30C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AEDB833CC;
	Fri, 23 May 2025 15:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ACPBm8rA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F00183249; Fri, 23 May 2025 15:19:18 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2736183381
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6000f2f217dso12406856a12.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006354; x=1748611154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RRQSdiBpufUF+yqDzFdMWNxBImE0NeFVDoTCUKbNoIo=;
 b=ACPBm8rA97GLrnjd0Nax39Yv+G4eXr+VM3k1pNyWuMVtcPUA030gixoDbxr9EzPmZv
 17m01T+Xu2/+MSeI3Y/iLH6COZHypq+LjezrF6Q2dBhifdUny0htDcADXwenTGYjeea2
 FOruRbzwqq2OXGV6lZMIbdztY01qdwerB2HlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006354; x=1748611154;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RRQSdiBpufUF+yqDzFdMWNxBImE0NeFVDoTCUKbNoIo=;
 b=s+ilY8hieuatUDLrVVix90ydb7HJwDC1hu9et0uXfJxasIB2/s8YtS8xGNF7bypOLN
 0vu1G96uFEjEBIJPs+HDsxseUDirl13dd2HiRhLSXXOMjmZwJBxTfOAdAy2mMXL0tqI7
 tf5napFntMfGVzdAsDVD4k6MPDSsgeO6wSyI6qRn1rTL6OzSZmfoD4MGpTa6+u0MvWJi
 mrjiw3v7hfofD73L+Vrvx7siJh6Gt0H3oZMuMIhJQIvIEB4C3e47MByp2I8HjHr5IGoj
 XjaNy7RhY2ue/gcwlOHx/+Vhomn22RNfiRGCbmC3FDRYS6jc3IHKSr902VeuNSCU9BrS
 4LjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX5iifczDSklga6cqTAZmrav0wxuX3tRkBYYAb0aKNELQBP9gufTu/UrHxEAyUJqwOU7OnsRg=@lists.denx.de
X-Gm-Message-State: AOJu0YyhRflLi2VQOpv4lWBpEfSN55bf2W3SRUPVwWSgQyMbSL5SYxIl
 nDdez5bGXCIbl0DtVwrOVY9WjihF2WrriiPtvXFzZrr98k3rpGpDF7n7PJ1nELWwlrx2aO9Nfn3
 ltlgDh1jh4LN8jiYCGYP0m6hh9r+xmx923dj5fFXt
X-Gm-Gg: ASbGncuwDpsNoxjHy4tRMlv1d3KF+OxOjRSbxyR3tOy+yksPe7oGfQu5EO4puF8FYct
 7E9O8Pf/locIvL8/kPCbKFuZGFckrvwe5XgoFtfR3qqNXR2Fuq8ossYRSgfRtvaOb3XIO0JELU3
 lOyxc03K3h8JlhvEhtBvEvkAEf65xjVYXDtANF/diXN+xT
X-Google-Smtp-Source: AGHT+IEWURHr77GzZlTcXfQaEoLVjNK4OOu8jGkdmlFNsO1p1ypiJxmOOf9XcwE9RdpH8w9IUQ6ECFF+TXyFwvzLgHI=
X-Received: by 2002:a05:6402:5c8:b0:601:fcc7:44fa with SMTP id
 4fb4d7f45d1cf-602916b9dfdmr2407232a12.30.1748006354242; Fri, 23 May 2025
 06:19:14 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:11 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:11 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-9-sjg@chromium.org>
References: <20250504132356.2317305-9-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:19:11 -0500
X-Google-Sender-Auth: P5A4UH5RNnz53wjjhcAnsv_xfXI
X-Gm-Features: AX0GCFsvC-JYIPlXefbyYnXh_vCGDnMkM0uAFWZm_ZVmJ5yf5P1zGLJ14zsnb4o
Message-ID: <CAFLszTj9cbFtnHcg0R4vgCa5qyhvE0ZueH0JDO4tEXTzT_FWfQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/30] u_boot_pylib: Allow disabling colour output
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

When running tests there is no situation in which we want ANSI output as
it makes it much harder to see what is going on in logs, tests, etc.

Provide a way to disable this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/u_boot_pylib/tout.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
