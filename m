Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E91C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 17:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E590988729;
	Mon,  8 Jul 2024 19:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LcZnqFYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56FA2887C9; Mon,  8 Jul 2024 19:41:34 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A57B87919
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 19:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7035b717880so1308574a34.1
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 10:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720460491; x=1721065291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbmIRsscMMzsRRqTZJrkxVcN+QR/d+l2GHdBrKXlq0c=;
 b=LcZnqFYmihr3U1tFcapaefQ9S/cMYfM/t4SlGThH2Cx6v/Pmagey7go9h0UmBShZmJ
 8y5rZ0+rsNMP5FfFuZh2eVzjZlicbYvzMOZz1Nvd0dv0ce7voDrSy6c7E7rZ9htp2U2W
 FfvCdFs64TWXY0s5fGi0i20fXSaiLWgFpDyB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720460491; x=1721065291;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbmIRsscMMzsRRqTZJrkxVcN+QR/d+l2GHdBrKXlq0c=;
 b=Thp1BthCiunfQkc4L0FVUW95E+KrmcYKWtBFRviQtfx8ND8uSHmfqCX0aYtC6IYTOP
 EysVl9nd7HLd7uhKsXZepPQNUWowfIEAjury1agL17OxE7dw/YCRrSAUFw6S5bDr1Dw/
 bxNhy9K6afT0aQ0udI1RJ6miq6GABEECPvaw0fXLKhL1DoIrCgrTLcgVh0yDJi+fbjgX
 GusMd9YcOwNwOtkZgLMl3/2to5gqnJXCnkKLRX/eic8Fz+sSN1yhfpEnhi9X4NM9D4RH
 Jft/K/MvGU97Yfw9+T+wBxFFwdBZ2mmGOsc1w8XmhZUhZ6Tz2aUXxIodZdMf7Fe4PoBA
 3+XQ==
X-Gm-Message-State: AOJu0YzaMSnGp960+/ypqaUy50G5+SINwpub5KDfDbYt9zRzVO+7GE3/
 wp+Gfzhrfe2XwXY0VGjROmRfor0c3T3F2FbjR+5aW/VtBL/gezksWigZuEmvIMg=
X-Google-Smtp-Source: AGHT+IFkslrtsh+a8cL9JsuKWGWBWx1V8rpt8EtYPfVCCkx1/TMDSX3OqYY6u1gWRioSUiReVt4aFg==
X-Received: by 2002:a05:6871:3a24:b0:25e:d32:83e2 with SMTP id
 586e51a60fabf-25eaed3bb8emr18951fac.23.1720460490912; 
 Mon, 08 Jul 2024 10:41:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25ea9ff9394sm92260fac.23.2024.07.08.10.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 10:41:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240705203407.1871563-1-trini@konsulko.com>
References: <20240705203407.1871563-1-trini@konsulko.com>
Subject: Re: [PATCH] Revert "buildman: Always use the full path in
 CROSS_COMPILE"
Message-Id: <172046049028.2143716.4320562528783911852.b4-ty@konsulko.com>
Date: Mon, 08 Jul 2024 11:41:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 05 Jul 2024 14:34:07 -0600, Tom Rini wrote:

> There are operations in buildman that result in running the cross-tools
> (such as performing size checks) and now that we have not modified PATH
> to know where our tools are, these operations fail.
> 
> This reverts commit 6c0a3cf75f72370deec3ee516a9dd377397af207.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


