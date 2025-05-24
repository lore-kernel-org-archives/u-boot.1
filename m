Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AEDC54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D34783559;
	Sat, 24 May 2025 07:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ct5+KNK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC99835AA; Sat, 24 May 2025 07:06:01 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D5DE83477
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad1f6aa2f84so105542166b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063159; x=1748667959; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=by/DxVfRFE6Dyb6vNOZ0A26LxULmSkVJOtgqRcD54Zg=;
 b=ct5+KNK69scNxm6DLLn2fIvrEurnw55djaDnGI4063rTdY3Fd5xSSbqwU4/geaOpE6
 MO55zfemx5jr/Q3ldh9W92+trFhzicc7PHpaYwSkaT9CKrItUY2BBbK4Qk41NId45udL
 5T3RTSzUw96XvTjv0ALEYHblIqfggQDGYvo/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063159; x=1748667959;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=by/DxVfRFE6Dyb6vNOZ0A26LxULmSkVJOtgqRcD54Zg=;
 b=A+653Bx787klKmkY2JiCUu/IT/W/3nd2CTWZEEJYFUYlQy43FFb8MQHgDPLanJ49Bt
 Q9ibKrDVgCwjq6JkB4wu/xUZavW/muMy/I571L2dlBbwzAbx1qKxTrLG8bKwU71QJnnR
 ZVpDysGEB0WAiGO7tb/5HtG5OpyDvfwYVO3l/ekZXXadTlkuOwWO0OhiaD+5Lye+bWpa
 BFh1m7wOsy/15v+LQHKjRVYRF3rXBWlQC6skooqtZz/rAH3bWjo82LGxmNl7rcHryYBR
 RTjo/fuu+tlFDRsUQVEUAU0tRK2AZl1bCxihdpJoIihdUjPuCXFWC/OXOy83YYjZr67d
 YoGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQh6JzlcpoLMN+20cLO9P6wb4SbyXIXUL7CoKrspMQ/DfKWqsP4HcXhWeL/pKWPBpJR+j/DPs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywcavxoqs4N8hOxHJLRMHXxBvm3r7Qv8kxLe50VXBYf9nfGvpio
 g9IZkoFTT68m79tAENW+LZr4SZFH5ynC+XJkyBbJMKM6t6hXJGd/9hKZrdbByQ08dnaCPopV2QD
 lPJDUkBS72erF4sI+Ri5T+0asBcMOzglBFNhM3+wOa0tXiuWayoWhmDkw
X-Gm-Gg: ASbGnctM1/Y4kTHT6ZXqOahkjxVZCHvGZG3a+Afbfy2BpgRyc4+8lXGCluYtDboDNL+
 HAWwaVGOBIzT99dqZM7CEh/aRriwthKZB7FDJtDHnbwDl7XsIhlObL11ZUkVFnrp/M5c6z7WPLc
 zyssSjPspO6QLg456zTXRegQAFM5TMJmI=
X-Google-Smtp-Source: AGHT+IHhDUny0ezLNV3yw38T1k0ZhmpotHkK0+Ze8TSfedw4AszsdckLntgv+qv1mFmGxZ42h3v3hDGFIFcRDCL+TmQ=
X-Received: by 2002:a17:907:1b27:b0:aca:95eb:12e with SMTP id
 a640c23a62f3a-ad8599ed438mr133773066b.24.1748063159148; Fri, 23 May 2025
 22:05:59 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 01:05:57 -0400
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 01:05:57 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-18-sjg@chromium.org>
References: <20250510110535.1453745-18-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 01:05:57 -0400
X-Google-Sender-Auth: Iku9hILeCiw4oCnrfM43xWf-VGQ
X-Gm-Features: AX0GCFstk6JRNlbUQzC7va5JyZx825100eTEC9rrpu8eR1LitSA-N0DlvW3IaC0
Message-ID: <CAFLszTiZq-cJ=z1dnwr5rR0KuEuQJzTH+8vF0ucuzUXLOH5+PA@mail.gmail.com>
Subject: Re: [PATCH 17/25] patman: Introduce basic database support in Series
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

This class manages a series, i.e. a group of patches with a possible
cover letter. Add some properties for recording basic patchwork info,
including the database ID.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/series.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

Applied to sjg/master, thanks!
