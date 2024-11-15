Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512EDD6DDCB
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA7B896D9;
	Fri, 15 Nov 2024 05:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FZO+Wod+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33FAF89689; Fri, 15 Nov 2024 05:28:09 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25455896C3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-460a415633fso2164261cf.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644886; x=1732249686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oqgpBcrcb8gBOWtpG4Gw0BCiYFg3E3Z9UmS1eEyJ3E=;
 b=FZO+Wod+aAsoco8haBX6lP2jouYjDNxZQ2Pc1lATYnfFUX+6bmLv4w8PVnga1jp4kc
 Z7MTNOUIfbtPS2jgMhdq6Vs7Z5x3pmS5AqXC1/fktOfkr3ILymXE9W6fFyazZLYJmsQQ
 2nH7WpHIPJ6iXU/ddYhhd8qJj7ZyUHhO4XL/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644886; x=1732249686;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8oqgpBcrcb8gBOWtpG4Gw0BCiYFg3E3Z9UmS1eEyJ3E=;
 b=GIm+7Hdw+ZptCoEhnXMqt7Zs1phW/ZeXmm+TmzG9yb1rghcmkYN09OZicI9WQavfhg
 CHSimxRYCuclsAjLezY6ui2nHWhV3+XbsSiiRln0C2m1L2oy8euC5KmSk3VYRzMy8Elm
 81zzOuKW09+/4rchJAG2l10TQwLN67uqrKXWMPlkUwniXXSXV1EQyNH9hyn+ac83ei40
 Aavyy6jA+6sv4pXFwlQfEnn093WfpgWJgAGVKNLR14hTFy7+l5QM/VKSKw4Jjm1bvThO
 eq6vUmJWPPfidQzULRwhpFzXCp374quitqIIi5Rtf3UV6SnTzatL71dV0g2ZMzF8r/Gz
 SlSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhcrtQjrNVyyfhCl59sqiQOvD576vE3/MJ+njYLknQltRBzcTCheItxU8DURWwNcW+Aj+aWVQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyQmqsGkxDYfzRuSC3lymVx8lgrRAMMK0G+Ho93X1t/9tsV/m48
 nmoSzPO8pe2rNUnApog9xoDpRTqH7X6hRt3mSw7grH1tU8UEzqJa2kEfMBSFlQs=
X-Google-Smtp-Source: AGHT+IGCZmYIpDOTaZXzJqCVgbZAAfM3QmKgRnq9MtpiY/maUzAHf4QsOL8dS81PFIjbpexTZ3E5Sw==
X-Received: by 2002:a05:622a:348:b0:462:b639:4b78 with SMTP id
 d75a77b69052e-46363ebfd52mr20028381cf.46.1731644886073; 
 Thu, 14 Nov 2024 20:28:06 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:28:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20241107101443.45176-1-heinrich.schuchardt@canonical.com>
References: <20241107101443.45176-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] lmb.c: add missing comma in lmb_dump_region()
Message-Id: <173164488369.1205089.11538192439822061231.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:28:03 -0600
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

On Thu, 07 Nov 2024 11:14:42 +0100, Heinrich Schuchardt wrote:

> In the message string " %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: "
> a comma is missing before flags.
> 
> To avoid increasing the code size replace '0x%' by '%#'.
> 
> Printing the size with leading zeros but not the addresses does not really
> make sense. Remove the leading zeros from the size output.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


