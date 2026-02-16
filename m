Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C188FE83829
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBBCE83D3D;
	Mon, 16 Feb 2026 20:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pd0rLnyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D7B283CB9; Mon, 16 Feb 2026 20:39:05 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365B783C6C
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c65d772cso2905664a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771270740; x=1771875540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVoZSG7zf/woOJaOB30Yu3cjBPGIsxu3z/fDO2j7ZS8=;
 b=pd0rLnyuhSfrmHuJHlF7mwskClFhC7o4kG1VrAoQ4ZaWz0IR/h45/svUdc43m0NhJT
 i4qXV8LfAF3vh1mrESut1bXPpIbRjrE4oze0k57bwI3HLmr4W90X/PcfSD09Pw7n0/zK
 Y8VbXsJ182tjASNCu+YrD1MhHu2R98NqkO1so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771270740; x=1771875540;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NVoZSG7zf/woOJaOB30Yu3cjBPGIsxu3z/fDO2j7ZS8=;
 b=To8VsLZpRitUTsoKG++2/TwM4TKGi/fbmmveFQ5w/N/J9q8z6XlyaZIsxycsGjAdsn
 AagQZfLocJdwX+lUwJAPKRr4UOxSCXqZCAwTBIJwsrLxXal49uZUsaxmqevKeJLZ2mRp
 y/y6VVbjxI0sso5KZwqc54XM+0Q31DUwjQLTRMxqCtHX9oo9yJQLa9jzU/oBA8L8k9rT
 8vOQQbsSkUO7mVWPi9cHFWVXpbgYvFYVyI07NRt0YVr360HrZjXTfBuegIYlhX55lfOC
 h+PzFoTc5912tD8qALN8CUpCa0yd+J7+9UDUueJlRJt4xpsErtGylmImTva3OGr4dYrV
 HkZg==
X-Gm-Message-State: AOJu0YyyH+NBNGDqlAUl2vXzga+8Ooq642wn6+Vv0hP28JDHRaAcg0Os
 XdMk3F2NOmiSj0MvUbNUR3tKHb99rKEsnxmyO/GHPjSn/21z9pNmN5r3a0YeXz//JVDY9FWXfNO
 9d2ZLyCk=
X-Gm-Gg: AZuq6aLog5EkKvfB4MnFoBQ8l3/1zozxOMxhe5S2XJpaD7wIOXdxwKdqtZKFA2roDYe
 fc5qtTlk2xhSYPDX5pFEAKwebcnh/jDL9fIRftc8GphwDo3xC2Kr9bAEZGyGMRfZ+WVM32PKhwJ
 Q2oy/JEY2fVoCjJVcKWAmzxelWFRArPs3iYULfCs5nMa9vkcKMhlRJV6OOXCT8AwcvePjhto2zm
 5lJrM7oDUDHlGkNZCFE7iwkZDS71JIDbcfUm3euh1WQfgiVcBwfHREdNPHrZZ7SIBevFejpuZIE
 LOb50qJ3DG1BPuOcaDZx9EsuqpjXEtag1vOP0OMegSGCkRvUzfZJgPvoQ1JtpupvPZO8YQagd+v
 OGqnxcWPCTz/HqXcgIa0FnY5L14N6ZgqZw8PdciprUFlxY4z154cC1I+7DvjBKsm+JIR4GlTS41
 c1hAdgmKsTc3AYJO6HtHe6MUKZPjl1DBRIF8vXBLdF+N0bRi7B56JNVzpW3kLrL3kDEEkIJqfoy
 24HI2jBMjxp0qja2vIwaZ3hejbzjlYNMnwzrWvG7+hRV3IoZw==
X-Received: by 2002:a05:6830:4127:b0:7c7:cf5:8110 with SMTP id
 46e09a7af769-7d4c4adb8cfmr7424167a34.17.1771270740166; 
 Mon, 16 Feb 2026 11:39:00 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f9483sm14142543a34.20.2026.02.16.11.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 11:38:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>
Cc: Jamie Gibbons <Jamie.Gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260212213410.822845-1-james.hilliard1@gmail.com>
References: <20260212213410.822845-1-james.hilliard1@gmail.com>
Subject: Re: [PATCH v6 1/1] image: fit: Apply overlays using aligned
 writable FDT copies
Message-Id: <177127073940.2634449.5049020223550053543.b4-ty@konsulko.com>
Date: Mon, 16 Feb 2026 13:38:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 12 Feb 2026 14:34:09 -0700, James Hilliard wrote:

> libfdt expects FDT/DTO blobs to be 8-byte aligned. When loading the
> base FDT or overlays from a FIT, the mapped buffer may be unaligned,
> which can break fdt_open_into() on strict-alignment architectures.
> 
> boot_get_fdt_fit() relocates the base FDT with boot_relocate_fdt()
> before applying overlays. That uses the bootm memory map and can
> overlap with the FIT buffer when the FIT is loaded into RAM,
> corrupting data needed to load the kernel and ramdisk.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] image: fit: Apply overlays using aligned writable FDT copies
      commit: 5ebf0c55a23ad740da1ec191ac157c490f207e0f
-- 
Tom


