Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55BAC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 17:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ECE3801FB;
	Tue, 21 Jan 2025 18:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VRfjwnOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB4718076E; Tue, 21 Jan 2025 18:34:15 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9EC801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 18:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7be3f230436so545309885a.3
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 09:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737480852; x=1738085652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YucFiXD3U0kkKzEkTUseb9IIWiIoh2+UsYFE1GWr2Kw=;
 b=VRfjwnOCOWpeXE5he1D8IzB+d9ZQMnppHTE8xZOgQCWzw7gfPh2HsAEsweSlC9Aic9
 LxXWImxIKILGoFPF78SPogOTIYuaUMka1YnHaliB8hUDr4ohIk7isGShKeHS1brHbzHT
 XRdr2Y5mTC/K1DG3Tw8kvtxY31CJPpO4Hrj8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737480852; x=1738085652;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YucFiXD3U0kkKzEkTUseb9IIWiIoh2+UsYFE1GWr2Kw=;
 b=hGZmjV/aYvfwY4CLRJYja4GUhOQOUu6yONIqSdqjoFClp+4fSOd+pRug4gRV6iJknC
 08+LE8V+yFA0bto8aljM4eHRpdttTF5dtd+ptZIwefFdKM/o4qoYTmxnd9VwRtHAQ9ra
 jh8WhCmuf/9AVYBbt/Dm24VAvzlsWuEdBvGrjn2kPHgoHqf4FlLl1K8f/Ogb5PQnqLXj
 bKqPUXRHGTTYCkqy8CLZoqA4WWTOfl1p42F5L36fxIlqj2evc9QxnFpgmz5dILHeHK3z
 aH2yveczZmZrGo28P6mR9u8o674jURrucqkruHaxA27QREqcsNbo8ehWMJDjx8dTHevg
 J2bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/SD+qRLYUdZWbN5/E3Ot+pDMLn3AzjsfJsIGvs+38qqmVq5OFCaqQOWCJuZZBJdfmJq8YDxY=@lists.denx.de
X-Gm-Message-State: AOJu0YyPrO2iUgEZXZzMJBiylrRxlPxWfkzcVYxbQUVXRfX0ImsXbCBs
 TbzKdR+8ENDxqMJSL+D69p9tl5/dnCQwlvdQEzH1yHue5TDr7gZxQ3MJz5Dp5Ls=
X-Gm-Gg: ASbGncsX8S7Ww30krK38L4dMLL88oSCnZvHGm2Ujhp6rB2qb/d/XeWgizkqZewewgfS
 v6t9PUV7ZQq4qYc/pKSqdClhRDPXLYkGC6LZSD86kj0oI+sdxzubCNrltEaGT4JYmBprnThyBlm
 AapSSDsXNU9UMSZ+1SUGOJfA94HEIuK8HgB+KYIz0lfhbGD6GmXxUWREEcyj0QyDOBlH0FZFTKi
 RzYzGX/TN8/Hu80YUKqr+PuYkf8Rna8DPaNuuLuut8ii1zjqC4oi/x2n78iZTd8ow==
X-Google-Smtp-Source: AGHT+IHLWHgH+mLnM51ncO9rcz1t4ISOqFey3R982xb+kAsPBn1mO6wdXNS15HzakLzMrCFYWCtUHA==
X-Received: by 2002:a05:620a:d8a:b0:7a3:5004:43dc with SMTP id
 af79cd13be357-7be63278ea6mr3143522785a.40.1737480852584; 
 Tue, 21 Jan 2025 09:34:12 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614746f7sm578462085a.9.2025.01.21.09.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 09:34:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
In-Reply-To: <20241220003759.89252-1-heinrich.schuchardt@canonical.com>
References: <20241220003759.89252-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] acpi: don't fill FADT, MADT if CONFIG_QFW_ACPI=y
Message-Id: <173748085140.2982616.2467615183465362432.b4-ty@konsulko.com>
Date: Tue, 21 Jan 2025 11:34:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 20 Dec 2024 01:37:59 +0100, Heinrich Schuchardt wrote:

> When using the ACPI tables supplied by QEMU, we don't need to build the
> FADT and MADT tables in U-Boot.
> 
> This patch avoids a build failure
> 
>     make qemu-riscv64_smode_defconfig acpi.config
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


