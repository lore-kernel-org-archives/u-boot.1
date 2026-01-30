Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D21D73EB1
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 03:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A9E8456C;
	Sat, 31 Jan 2026 04:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fwmEy2eU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C578456C; Sat, 31 Jan 2026 00:15:02 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 096FD844F1
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 00:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d122733808so1141890a34.2
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 15:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769814899; x=1770419699;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F9v1UEdMdusCF4DBTV0fSCv5TN0UmeHJ8e9r5lQpA2Q=;
 b=fwmEy2eUlb6MWZknV9AWz6cfB7fYNdQ5FKbqaIFcmqANBzt7xvW6/UpYDlM8kv7Boq
 RjghWQpK0IPiBjQoGLMKytwH32rYZlXxWIAsPxhxCJmM3XCXzHUlsiT3iW3Tfj5MxKo4
 0Kq/ut0EwgCQIGGgK7tmHOX50+fpArxLj1rBIyzUbLFAv5YUGA5oWog1JwhYhG2p+vn6
 JIfiZgCuQwOr/0OphSFHT3c1+HfsjOKAkfSbYeZmSbEFujJEbj5hB/X3dQwSMtRziGKO
 icVZT5x9KS7cEhnALwZxqJ8yQVkTxKIvP7ACbXFr+7MGoLOZMZ6MeNw3/6HFiXfRncpu
 2+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769814899; x=1770419699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F9v1UEdMdusCF4DBTV0fSCv5TN0UmeHJ8e9r5lQpA2Q=;
 b=wjIuDtsDZjAKe5sje8yn6F3trp5d4vP+dVgWkXeplmVlPijSdNqd0nGyRlzx5WdZCc
 Ok/OLJQCq26DFc5mRZm/DKCEXJUsyI4RKiygnA9Nt3rP/i5ZJkU2tsTbxpTDBJZfuOiY
 eX9Y0ghdM9cG1r4xlOLptVUWwBCfU/jTniPVd6UjomVgtobWyECMOgHaWHIBygoQ7czF
 AL0zvIY3ufKBm/DtSTgZdxjTZbFq8KFECml3vAHZKAZY59oIgYbGEvI9rKc/jkqlmtBv
 SbpCY0UJvOZTZAFxQSa0r0nM/NkxXqol8vg+qCv83XuJythVeda2buPFnLM/8EWpcDOv
 0ufQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwv9RXSiH51mMZg1PmOnRLIOrC7Lj0IiD8OasxMZt1IjwAgsr9RsvlXE1lWNL3bENd6GBat7A=@lists.denx.de
X-Gm-Message-State: AOJu0Ywbd7wl3P5KrsPmwzCeCdWQnaOxqpsbPOWJ/jc9mNcs0Oh2a9Rq
 y5x3V68hwagRKxG9f46Vd0AMC4Dep6QhbLmYUhz+XhOeWvSqE3hm8QHI2YyS2H2RisY=
X-Gm-Gg: AZuq6aJ2RDt2R4AYBB0w+2jMZu5k5Jsr84V50xNrEPS86utGcHXJ3XCEHonEAWvvo2a
 rDn1GVkOOq33k7qVZHtPmzcbDQwuovjuXToh2g82jSvW9YwgDXoCpNHHX/HK3SScrcmBDnNho8h
 OAPJthZV1jYn/lmVp+0sza0ZW+fHgvI1wGwcRjOIN79338DfqubjV3T1vhfBqaM8i/a2OKgCYgJ
 2ACbM6T915ETbYipocd60W/C4/03SyxkxYue1PSBZd4+OxvWOFKgzUuZY36JqyFuEnQ+V1m4dn4
 GL/zYxXvq5O+LV5v5a5RYAXUjGKteIxBUiGboh5/n7nyKXxd2oLyYO0RVHsr1VHe4DLm8WF2iMz
 8cPec+tfp9+VTJhnwIZpje2DFWIBKbnkytnO+HNDYRk5bIpeqbdDopHoNc/cBO2+OmXL/EvDP59
 XCdFfzPiQipfwkQrotWlMl0G4yehf7nTVneT2Zf3ciZLHYxH7H2zxFjQ5EbR9J
X-Received: by 2002:a05:6830:3814:b0:7cf:db31:1b7d with SMTP id
 46e09a7af769-7d1a52329f3mr2694957a34.5.1769814898722; 
 Fri, 30 Jan 2026 15:14:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e8db:4843:341b:7a44?
 ([2600:8803:e7e4:500:e8db:4843:341b:7a44])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c7ffa49sm6207431a34.20.2026.01.30.15.14.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jan 2026 15:14:58 -0800 (PST)
Message-ID: <865388b8-1f78-4b91-8ffd-1155fc2643ef@baylibre.com>
Date: Fri, 30 Jan 2026 17:14:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mkimage: fit: align DTs in external data to 8 Bytes by
 default
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anshul Dalal
 <anshuld@ti.com>, Aristo Chen <jj251510319013@gmail.com>,
 Beleswar Padhi <b-padhi@ti.com>, Bryan Brattlof <bb@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Wolfgang Wallner
 <wolfgang.wallner@at.abb.com>, Yannic Moog <y.moog@phytec.de>
References: <20260129035512.639362-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260129035512.639362-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 31 Jan 2026 04:27:55 +0100
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

On 1/28/26 9:53 PM, Marek Vasut wrote:
> Unless specified otherwise using the mkimage -B n option, align
> DTs in fitImage external data to 8 Bytes, and retain alignment
> of everything else to 4 Bytes. This should fulfill the DTspec
> requirement, that DTs must be placed at 8 Byte aligned addresses,
> even for DTs that are part of fitImage with external data. For
> fitImage with embedded data, there is nothing we can do, as the
> embedded data are aligned to 4 Bytes, just like any other DT
> property.

Could we fail with an error that tells the user they must use the
-E option for dtbs? Or at least emitting a warning would be better
than nothing.

Not for this patch but for broader discussion, it sounds like a
`/align/ 8` could be useful in the devicetree syntax similar to
how we have `/bits/ 8|16|32|64` already. This could (eventually)
solve the "nothing we can do for embedded data" problem.



