Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8F9CCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 17:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2C2C83C02;
	Thu,  6 Nov 2025 17:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BtKy5Zan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE8683C14; Thu,  6 Nov 2025 17:59:50 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 668C583BCF
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 17:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c3e2221217so756350a34.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 08:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762448387; x=1763053187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhXT5DKFhc07zyVwFACIjsUHJVZWSqR6ozgq7zGIWcg=;
 b=BtKy5ZanXBJ+mZUWNsRZq4DGclKcchJoArhUpmTa5pGIeUKlwumlF5UuCRvtuy+aOc
 KSrD5OXf/FUOv8iqzyADi8hoGqx9T3BU6bQ8V/YYW6RsDOqTiJffNsneNgVRZmZiag66
 NtuS2IcTD8rcB8AklfZqGJcVHJXFwMcCfWTBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762448387; x=1763053187;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DhXT5DKFhc07zyVwFACIjsUHJVZWSqR6ozgq7zGIWcg=;
 b=dGriLMiwsT0OgZj6ODkWrwE6Vl5dwJIJrwDV0cH3kDkZSpU6F+nZA/JBS9yZkoNM9v
 bLRQsoM6fruxcMBO2KOrp6+ZAlyig1+WR4W2g2uz3VC3pLcnX0wCM8/3tw5HmA8k9OTt
 UPTcSVsMtmXloDgvY3MLjzvHOKd2NtQGp8zjz7JR5ncfV7mw2/31t15rCbOg/3crD+Zo
 ODcrbelDb5oXkc0xQ32gZvGOMpSYt93Bwe6f/pgkoxqs+xd4UpfIMWXVy7ol/rN6n5m7
 wTFz6a9oqUW+G8pc68frHWOBa3ZrlmflpEILcqNwJMkf8NEO4TIda5qQJqiG2vD/SIeF
 qsGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq106oKBkA0uZTFVQAFxpmHwbuKy9tNV3i3jYjFhyYHyRjVw8SQ4UPVdx3TOcsca54RXZbV1Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxdidOH2N0nBnPY11Ok+o/TBATTk31YPRcq08qHQKJ1hU6sLhHa
 t7z5Cvh6prlhwmBFcYA6/UIozue4bH2qdlwnKgk9rOUvi3JjnnKelm6rC2DmyMqMs4oFsrpkJiG
 VqsnkaK3JBA==
X-Gm-Gg: ASbGncvCHoEi62g7/LL1yq4b2FVbdO+EZXr6LrvzcfpnWNW35GGMj4vrdk0HJ2zC2/y
 So2gLjzxP6Nl7PW7nL+zj8ssiu0mr9J4nKSzw3UZ6jJ3vQrpEmK9PPigv1pW0ZC/4RqpqTsocfR
 oc4uatcQ9q/GSWGFZyMAFsP41CRw/dB9rVF0L6UiMYutZD/P93Nfmrzu16k1XBO8tXtOuyLT94j
 +37uGLBrwi7XUuL98Q/1fk013XY64fAfj+RuSWiXguoQuV20PVzdC8qbUirg4RArsYq1+9O4Fq6
 iBkKKyims4yUN8HAiL9TTGeIGzqvuYeWADdaGqKFeSKk6a1tMm2RDJi3mxpPCKMS5MAxVU2jX+T
 Oavo+nvEqKNqHdXNmVc6UO8b0zTAR5207YClwZo4LaJmPLCFJu+e5YehrpJ3UBqWLAi33/60yYs
 8gcLjLwZQjaumbCzyx831q3O6696Xa3t9z1znm2Rpz3TKX8ku7
X-Google-Smtp-Source: AGHT+IFf9jcLE6LiFmtoNyeX6kd6VauVhShJdHMVhqttvkB6vycAGYyj0w1ei7P9tnQ/DEf72/jhrQ==
X-Received: by 2002:a05:6830:6aa8:b0:7c5:307e:3d8d with SMTP id
 46e09a7af769-7c6f005b8famr130345a34.30.1762448387177; 
 Thu, 06 Nov 2025 08:59:47 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f11323absm24819a34.23.2025.11.06.08.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 08:59:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de
In-Reply-To: <20251031195253.621971-1-heinrich.schuchardt@canonical.com>
References: <20251031195253.621971-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] acpi: use U-Boot ACPI vendor ID
Message-Id: <176244838628.3056677.13042049609610671230.b4-ty@konsulko.com>
Date: Thu, 06 Nov 2025 10:59:46 -0600
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

On Fri, 31 Oct 2025 20:52:53 +0100, Heinrich Schuchardt wrote:

> The U-Boot project has been assigned the vendor ID 'UBOO' [1]. Use this
> vendor ID and our release version in the ACPI table headers.
> 
> [1] ACPI ID Registry
>     https://uefi.org/ACPI_ID_List
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] acpi: use U-Boot ACPI vendor ID
      commit: b790f31752d7650d5f557509f17b1396f0cc1f70
-- 
Tom


