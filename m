Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A68ECAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 22:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7AEA833F9;
	Sat, 13 Sep 2025 00:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H5AF7AjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510AA8341A; Sat, 13 Sep 2025 00:16:36 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B908833C0
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 00:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7459fa1ef2aso2468112a34.1
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757715393; x=1758320193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTIc6pIUgj1ZQ9NKjdFdm/97zi6fTiB1bBaoAUrf0O4=;
 b=H5AF7AjPgw/GoCt+OcJtL+NvU2FViHUQv5M2Qx7UZULj8B0ZbTkf03V/88e+u0E0kF
 BpZJnp5oGxgjYy8K7eD16dtkt+sEPDuUE7GQod+PgAXFeVg/D0ugYsqwrGU8Y5H6uWvG
 VUrA8QDwGxbbk39MMvaADNeTCKKdMXa6BD/Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757715393; x=1758320193;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTIc6pIUgj1ZQ9NKjdFdm/97zi6fTiB1bBaoAUrf0O4=;
 b=q5TNGzZzzTgr+EPADAp9oNNhnyEtOGd3rILrJMQ6kM82UXjw3wo9JUKu7yHWJKiwPN
 BdDIYAvPc5RgdN9qQ8DQSgajaOf75VovzHsEUBQMEMJrnKjdu8u/xHWFcq7+3hg/beN2
 iTTy8ZMoPYPLsBDuheTsyOUSOnNVm99o3tJO2IRAPNF+pkZykfU5NPRL6yWcxTXBpku5
 FFWMMeVvegHkrHnAm1faI91DE++1Yv8EfHU1ywTDBswGhmOZgvIIRaebxayMhFPkRTeK
 UXbv3wepa2upMphS1YyiQl6xtVZY7lpPUMPlompGMokHjIQ2Boxkg+3FA41N+WsXOvrR
 WluA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCUPK87COLSC/28holetREo/N4FyGvzP/GohNmolmyeJpjkCVXglp+mHpmDkOYvGCpPv5a9Pg=@lists.denx.de
X-Gm-Message-State: AOJu0YwuYiQEjb/luKZJnBfy1JiZZVq7kK9eZraNzU5AHxPr67o//7v/
 rIRTYlV0rvyPCRT5g7RkS4twxK16xToUl6b/E8sjQr8O11gs7HckIr6R3xX2KH0tfoU=
X-Gm-Gg: ASbGncvghg9yM0DLt4NlKSuRSOBvvvDjfNM8jZ+Y4Z5ahLHnMtfbS1Ri1Er6lzgJZ+Q
 CFbxZ5MJM3PWMDH89qw7VPUiGRM3EWo+ZZ9UskJYm5EVeNXxeEIgytYpRsVdNILIDQBPfAMt+zC
 1WL0WJPjc5zkPkSGcqhqn4n8hP5mqZBLGwF89+MHgvkKFrY2bc//+cOXik6qB6uzeSug3w/ntHN
 JL8kQjuP8pYlOLz3mg31g4qcykZCVornWkP/u0CVYfltAfMG6hbl0sIl8dRv2UvIOl1/m6aldy0
 N2tWZFcDXWFfBdEaHRTpVz0CHbO3J8GjEjHsXMKxlfJ39AAQgAaC9K0svmK1ZpEWym948nS71xM
 Fj9zba8fqLWa90LZlyXfW+4tvzdma00ZrKzG2nEV4mEnyV0jivo5tUP8=
X-Google-Smtp-Source: AGHT+IGHG6X0kLzqyt6fi8T/4mU33q7rqQcvfUlz62Tex8kc6z0NVJurB3ky/FChR7uAMjLYdzwJMw==
X-Received: by 2002:a05:6808:18a7:b0:438:2440:a594 with SMTP id
 5614622812f47-43b8da71b5emr1690586b6e.47.1757715392957; 
 Fri, 12 Sep 2025 15:16:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524b8a399fsm1268326a34.24.2025.09.12.15.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 15:16:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Harrison Mutai <harrison.mutai@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alex Shumsky <alexthreed@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
 Raymond Mao <raymond.mao@linaro.org>, Joshua Watt <jpewhacker@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20250901170308.805653-1-heinrich.schuchardt@canonical.com>
References: <20250901170308.805653-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH] bloblist: adjust default bloblist size after reloc
Message-Id: <175771539118.4138777.15829755714037796378.b4-ty@konsulko.com>
Date: Fri, 12 Sep 2025 16:16:31 -0600
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

On Mon, 01 Sep 2025 19:03:08 +0200, Heinrich Schuchardt wrote:

> If neither CONFIG_BLOBLIST_FIXED NOR CONFIG_BLOBLIST_ALLOC is set,
> currently CONFIG_BLOBLIST_SIZE_RELOC defaults to 0 except if
> * CONFIG_ARM=y && CONFIG_EFI_LOADER=y && GENERATE_ACPI_TABLE=y.
> 
> A size of zero never makes sense for a bloblist.
> 
> When using QFW we need more than 64 KiB to host the ACPI table.
> In this case CONFIG_BLOBLIST_ALLOC is used.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] bloblist: adjust default bloblist size after reloc
      commit: 559f11e66cf78a7cf57100086bba11a5a516cd25
-- 
Tom


