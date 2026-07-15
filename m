Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3286EC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 13:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7A084AED;
	Wed, 15 Jul 2026 15:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oG+cYP+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12D0D84A6B; Wed, 15 Jul 2026 15:59:47 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7EBD84AC5
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7ec1e9d3359so1960613a34.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784123983; x=1784728783; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eDZHRFyDaO2+V0M2KbvnUfAPdhXxOtpj/2wVo7rNhpo=;
 b=oG+cYP+BqlxQTyQMUeInAfx5RgwY6mRqyLK3NEqOu5oOpxLe3f3l0QbcJgzQ7LHAoV
 DhODpU2S1jYnvkjeH3NNrX0YX9BB6pYdc9FeTDcqDMR/PCZwlRKdExcL5YSKrnzui0Ie
 6lPiO0sO8ujrED9QdhYwZFb8lxSKhYRoyXGy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784123983; x=1784728783;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eDZHRFyDaO2+V0M2KbvnUfAPdhXxOtpj/2wVo7rNhpo=;
 b=Fmsboqq7hcarE9TQplWuKHQ7+HLxcL3PjAudRN6B0FCAXsRdAixLUmpEIgQcTilmqG
 1oCKBN21B36SfX9zZgDOIlzRzjp8fBrsQ4tooTj6WmGBPf7Z2x3x8SnD+0UhxWITB7Ie
 7VW/hZzqcsp2nvpjjo0BBufo4JQshLJmB9WyRkfnFj8UPVJwfBpTwxRvb4Qx9zNlm34P
 vRmfi63/ntCjrhtH3ugDBw7yGJHIFyCNRuoQkgSEMXVNDhTqNQgRvkrPJGqAD2SfSY5A
 HzA9GjTieZeDotVclvmZp9GXCdcwhZliqYJ+F8VIHTwOeTXlonhh+UDspUdYeWtVBa8c
 Da1g==
X-Gm-Message-State: AOJu0Yyg23mJKF8D//Ixrb0R6i17AWCIL8TVJ//KWjACKeWqz3/1V1pL
 SZ8peMl8Tuyw3KXRblNgrDo3X0NjkRL52SteXguxmVisbeNXzEmVgS2MZFZlUbYzCyM=
X-Gm-Gg: AfdE7cngz8rqC6azWRZG1z7yVNv5+rdTfLVYXonIo8qv7OvUkdvq8s1PKKwEqpQUVQB
 cPG/6d2JJEsb7hVRbQDVBO+qv1ZFX9DO8FQj6F9jrVhYVcqS75HsfYZVWsTJKuHYaWpx6sYr6FI
 Y4tlvp7uyoGmTBxNAl9VEsuoCs9fqZb/h3stxJUlhOdcrFhIsDvjN1cA9f2fbhKijErjpRDdCXr
 Ef6HNigxE/X/vx67Ip6SCZPte9pSAvn3T2iwBd5eoNWbGepyIAlExN1+ggmBX5PUPXKOxbIrfOM
 2VeNwbMugD39h34ipdzol4Jy2vpTcMUiWfUuFsg6HePzOERhS/YkrDI3FQbYMUWk+sBF+TPMRk7
 vLkW6ugfnyGwU2nL9xJ+PEeer3NAKLTr9774jBNH30VzJQOpKHgedSyowwBCsVNPtP9ABLchhvK
 jdTNspzCxb3cu48fxwHrqdRBbpfDSMYXs2poqp9gTEFkpkLFYi8NjBZVoYB/vv/nwE6yuaYC8/x
 Qpi1vSbeXNnryQcQBrhNc3c5z7Tx50jlgvq
X-Received: by 2002:a05:6808:1246:b0:496:6b1:cc77 with SMTP id
 5614622812f47-4a4728c79d4mr4677566b6e.32.1784123983278; 
 Wed, 15 Jul 2026 06:59:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1afbfbbaasm16162301b6e.12.2026.07.15.06.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:59:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <20260702-qconfig-check-for-db-v1-0-f0b96bf8fa44@baylibre.com>
References: <20260702-qconfig-check-for-db-v1-0-f0b96bf8fa44@baylibre.com>
Subject: Re: [PATCH 0/2] tools: qconfig: print a proper error when database
 is missing
Message-Id: <178412398231.44767.821312389794768442.b4-ty@konsulko.com>
Date: Wed, 15 Jul 2026 07:59:42 -0600
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

On Thu, 02 Jul 2026 16:04:40 +0200, Julien Stephan wrote:

> When I first ran ./tools/qconfig.py, it immediately crashed with a
> Python traceback because the configuration database had not yet been
> generated.
> 
> This series adds a simple pre-check that detects this condition and
> prints a clear error message instructing the user to generate the
> database first using the -b option, instead of failing with an unhandled
> exception.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] tools: qconfig: print a proper error when database is missing
      commit: e24624017f49dfe22845316ccd11b8c4487c2022
[2/2] qconfig: Rename the doc link in help text
      commit: ab106a8564811b0cdbcec4b2998145dc5b304783
-- 
Tom


