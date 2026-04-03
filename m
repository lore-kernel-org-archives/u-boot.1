Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3EAE8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 993348420C;
	Fri,  3 Apr 2026 21:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X1WQcCJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91E2B8413A; Fri,  3 Apr 2026 21:47:29 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4543B8415D
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso1478896a34.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245646; x=1775850446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KZpUEXZS7fkTQYh5J5JYWO94BKdoMMEq0ZrT8hb6/34=;
 b=X1WQcCJN//N7wWFjtkYJHPd6N3zoc7Wyjqa71GUQg4pn+ni9HHznAMVp861VN3Nc26
 DfX2UaIun1CS2IqmlQ5iF+gz4l5u/nKoz247rIWEB9DI9dOg6NVTze4DTARHy5P7pq+9
 WJzTJksqte0xwUEZm7T4unS3IIDxE4rvxzZis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245646; x=1775850446;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KZpUEXZS7fkTQYh5J5JYWO94BKdoMMEq0ZrT8hb6/34=;
 b=s9r+wDDBhR3GjmW2LxYu0TvqClZDO7xp8ukNf/A2itok+tV1Ej+3mJDIbXPRuYVeax
 AM/siEOTY0SLgLyw+pFyjdtyHz9Coj4T+Neo2PGObP+XJk+2mYNT96Dz29JFmia90Qo2
 JBotpMvhGG/fT/qK2H+iX9/QfuDO4Hy5myRBQJnXdidcinb6kzWokPG88Wtk6KUAPldA
 R1ydX9MuuOIJpFinPHm4HikAdBZv53bxe5QVKxgmifgqMkOL8rQhY+M03t+zfRWl46dW
 CVXhsQGRqZL6zFZyrC60wmrScFrtE7MSPy5LGWZ6vzP4cAQ1gYZ/YIKTUAERacpzT0DD
 G++A==
X-Gm-Message-State: AOJu0YzPbGBeKNLbxxZIYyELrdUNwmvKSwPpc3dTb1YHwMBT0O1QHWNf
 8Hll/w4WXGqUpz4JcJ35lBYpXqBa8BsTj2vFn1mubE0++iE6LBKY8IG0vQ8ecJTeXJ2Gs7HtCPK
 bRIJIpPo=
X-Gm-Gg: ATEYQzzTN59bQ+RjSWhQp95Pn4QwDukmR7/8n0g9VGZeJUEBVMsBo0hxPACOAchifge
 Ue3cEhd1LOZynKHUClSrQKStfS0R2p43RY9EIK801hIbkHLhZb4fiw0mLDPzjsTI08Fk+2t+Z3K
 sSC+cQDbLQ+AqPEf5TcFQXglEqapoBifn/uQqbx3kALdJpd2lZoT7U9e++5Dd2JBOVb+5rVM+jF
 NZT4G8j2KawclYRqDqcp5iLBqS9iCy0cmnAPKPkkPxiJ54JG8SefRFxsQcCeJTsaDTuKhAmVwti
 2582lSP7PkSrrvOJi0zWiuR3dC77Z+hzaacF6f/hnPndfgrwnPdAIHYdOu3jWpU1Ki7xa3SI0WL
 0qdki5cwV8i4o9t9/KqKZjQdGR7nmOvS54nk1z5tReLXsHQOavYZ8Az3lg+0gBc/t/5GTmCh57O
 rP4D1J4aFl6l8RN45wehbY+mDwuJDs83kBOE2icPNSB1nvW/aculub1fc1/NnjhC+GMcSUVht9R
 VaMXF7KjYCL/32h84yG7a+TCOaLLQpkTV6KH7wPSsJzGiM=
X-Received: by 2002:a05:6830:67e3:b0:7db:a832:b329 with SMTP id
 46e09a7af769-7dbb74e94aamr2479332a34.21.1775245646030; 
 Fri, 03 Apr 2026 12:47:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205356.3789155-1-trini@konsulko.com>
References: <20260320205356.3789155-1-trini@konsulko.com>
Subject: Re: [PATCH] acpi: Correct dependencies for GENERATE_ACPI_TABLE
Message-Id: <177524564551.2281750.569714216895902702.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:25 -0600
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

On Fri, 20 Mar 2026 14:53:56 -0600, Tom Rini wrote:

> In order to build this code, outside of QEMU systems which instead have
> provided tables that we use, we must select ACPIGEN as well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] acpi: Correct dependencies for GENERATE_ACPI_TABLE
      commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
-- 
Tom


