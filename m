Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A20D17148
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 23:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 361DA8899C;
	Tue, 22 Oct 2024 01:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a7YA41aW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D54B8899C; Tue, 22 Oct 2024 01:31:51 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 449DD88F28
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 01:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbf347dc66so27284136d6.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 16:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729553508; x=1730158308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08bvzKec8Pm5GrywN78dSUb1kVREjgE/sOAREgl+pz0=;
 b=a7YA41aWrCAjb2QQHmhc7C3lmHzf1+GZB40hO7LUlaz1ZOqhQ5gFzJAeNOxvzRiL0w
 rv2n/KT5RCa3iQRrZ62ldsHILJPBLjfFCalAzTvTkjjTa6H9qBGcH2rbMQCG55bVc7IE
 xKHMssJsa6Th3YSYV5kwEa4E9vR7K9fzpPlmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729553508; x=1730158308;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08bvzKec8Pm5GrywN78dSUb1kVREjgE/sOAREgl+pz0=;
 b=MKN1EFbbxR++gPX3YSBIBC0nG6SncsKC9D5st3oies9TZD3JgFMB8o4C8mBt86ZRZM
 p2tLoG2BEFktx7uPX1AuxtJ+pbBlbUdOGewY5gl+drUUO0TJtOh8QghH6fjP4fQSqukF
 Z5vsYa4iFdf3oztEeIAAEuj5bDt1Ibz6WTTkggzZWeoCsGso10o4+oBke5ycFZ30+tOG
 Jnbo8s988yKrZi1vhDq5QpeSMducCPifUoFAyUHRUJfdnpbJVSJrsa/lLnaK+Qca90bk
 tDwRbTn2czVxrx+aAetbqAiM3CXl2SfLO1FkQd5ZBmr6UbLoSKiZSgo042TDLyhJdqC0
 cdKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1yF2aUGvXEs84IjS+CIRKa+v27oa0ZYUcT+sW8T1BzWcBGyqAkjwe3fSUGNcm5Qfy+cTJ2jU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzlu84KypURXStW3sidQOmIMEPj8yXDRfe3JkkhcN0i1pN57PY6
 rTMDlMWRlmMHWEapFh3VFGoCH2WJavIZ7Vj2g2MzuDdt2BkCHQArplsDEa8VMDs=
X-Google-Smtp-Source: AGHT+IEcPK6HzSvuoglWkwgV6FXcHXRjudQG96U2614J6p8p2gLuvXW4jhBaJ8+t4coMTfx9ccHNpQ==
X-Received: by 2002:a05:6214:3c9e:b0:6cc:2416:c247 with SMTP id
 6a1803df08f44-6cde167f083mr197639196d6.49.1729553508117; 
 Mon, 21 Oct 2024 16:31:48 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0091bc5bsm23186126d6.74.2024.10.21.16.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 16:31:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
Subject: Re: [PATCH v4 0/3] dwc3: gadget: properly fix cache operations
Message-Id: <172955350574.3031532.4179642258271087474.b4-ty@konsulko.com>
Date: Mon, 21 Oct 2024 17:31:45 -0600
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

On Fri, 11 Oct 2024 16:38:23 +0200, Neil Armstrong wrote:

> We experience huge problems with cache handling on Qualcomm
> systems, and it appears the dcache handling in the DWC3 gadget
> code is quite wrong and causes operational issues.
> 
> This serie fixes the dcache operations on unaligned data,
> and properly invalidate buffers when reading back data from
> hardware.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


