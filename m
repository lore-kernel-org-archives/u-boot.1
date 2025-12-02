Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FFDD1266A
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 19:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB9BA83C64;
	Tue,  2 Dec 2025 20:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NVS+Pl6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B06AC83EAE; Tue,  2 Dec 2025 20:30:11 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962B183C01
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 20:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c6d699610cso1603960a34.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 11:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764703808; x=1765308608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XV9bPpEuN02H4Y1qjH8MCfXMsU+2aqtS6jgvsJddrM=;
 b=NVS+Pl6ekXeW8GjryX3rDEUmXU4fCbeRlEoIlmVPKVFFqjrDPg8hBEqgVxxGnkWFhA
 FOmqz11BITtYH3b2ncJ2zy8DzSNnOvT33X7uSZKCOkF6U4nDt/Gsl0elM3JgxffzA5BV
 pEAJlvP3DIZq6WFYp8f11fAbwrpLu6xZyeUqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764703808; x=1765308608;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1XV9bPpEuN02H4Y1qjH8MCfXMsU+2aqtS6jgvsJddrM=;
 b=W+4Nwe32vrW1BzTrTYDg4RVSQTAhJQRchAxBeJzTzAOns0Yx0SXuF1VyuZWrsg8Zt2
 adUzQqEk3NzNZHc2UCkQuTW3B1JyFRI0X0HTj2x6u/i8F/Z7SR1rXWLpsWiJ0AcL/khc
 KPBtKy6MV6W2+N5wX4g/1hD9+zySGG7imAPQ593CqWel27pFGomyv5a7Gao6BwvlqeAH
 1K7iQk/Em7ya9o4PpEA1yHxL2hrgqJf9tN6ut5bAsHyAQaIVaIcZV4aPPuF0JiRrYlH8
 3NOiOkAyNnw6sYeWmyph7dnYjP4onDqsjI2RnBHjV0JTusAxFPn8JZndjpuOMBzROlxe
 cVmA==
X-Gm-Message-State: AOJu0YwuGCcFhE//pZ8T/TRsN7ac3LcdN13mKW4/ggwi34DG6SZ+2gW5
 w6CG40H2ClQA8z3RztnPoASjUeDqnta4F4TPIFDvd4gOZmkp/4QFhtOZ+VEcMfhOxtvwVrWbZGi
 ru8H/tFU=
X-Gm-Gg: ASbGnctdMRYINsHPYPQ6zQ1QjVUOdeJgnVk6g2XYEhTubIZsaHsdFjkWwWJsyviHp9D
 yM6XFlRnOH8DcYV8dIv/WkbJP/fCGFuF1PgnO2ac+KrQAGLwrAPzyFuq/ajx0R961Ds5+QiXs3j
 OQO3Fpib8myNfkSOk7FFK3BZ6YRT8QrXQptAHNmwgrRnQTQsvC7Q/hFrvabNLy6NmAky8ZVl3zT
 qfbF0hW+6K8PgGbQsNOCzGC4Jtpe6hllyvs01fuG8Ej58N466uAUiSlbOp6LqU6fFDQvqcT2C8e
 ffTXLCOgipt0XM2gK9//HxfxRpW9EhMyQWBZZpekWkTheHcn4vE/8bDvgbMeJbOU9EGXggyXZDR
 I4PreA5Ljd5vzSdnXZ5zPAPSCUGi411VxRh6tMmHEoneymJNGbDU38t4PGOHIoWfPwPquQHK8nw
 j6ZoIFzYGeVHrcWDZ0jgYQSNLSOPECqZsAXWZFDEnkCjxwsuZtNgMQYrSttEs=
X-Google-Smtp-Source: AGHT+IG+JmZ9aiZbXxKiupXwIzNInQVh3D9CjnyitCizTIb/R0uHTBkgHg0JzNhI6mNFXP55Js0LHA==
X-Received: by 2002:a05:6830:442c:b0:7c7:5f6e:f260 with SMTP id
 46e09a7af769-7c94ad584admr624813a34.5.1764703806850; 
 Tue, 02 Dec 2025 11:30:06 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fceddf6sm7126974a34.14.2025.12.02.11.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 11:30:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>
In-Reply-To: <df70d986-6bee-4f90-a146-85388114753c@linaro.org>
References: <df70d986-6bee-4f90-a146-85388114753c@linaro.org>
Subject: Re: [PULL] u-boot-at91-fixes-2026.01-a
Message-Id: <176470380617.2652906.16000893406304786304.b4-ty@konsulko.com>
Date: Tue, 02 Dec 2025 13:30:06 -0600
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

On Tue, 02 Dec 2025 17:30:07 +0200, Eugen Hristev wrote:

> Please pull tag u-boot-at91-fixes-2026.01-a , the first set of at91
> fixes for the 2026.01 cycle.
> 
> This small fixes set includes a fix on the mtd pmecc driver.
> 
> Thanks,
> Eugen
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


