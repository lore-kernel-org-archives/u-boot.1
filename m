Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3A5C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 19:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 193A482B8E;
	Sun,  6 Apr 2025 21:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KJhl/yrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC76D82B7E; Sun,  6 Apr 2025 21:50:51 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2C282B63
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 21:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2a01bcd0143so4650348fac.2
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743969048; x=1744573848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qu2Q29U6D1V5jr8dnF4sIgkKuFw7g5uU9cF10Rfp/k=;
 b=KJhl/yrT371xBkqwl6m9v5w3ruUSGBQfCceJ56DjUkYog83NXrLb0hSmxDt4YJZA0o
 c0LGyyOIW6DDlyP+++HcOEbfUoOniylxpBEwJC9Ypf5RoX42y60FBHB2kPoTwKgdRJou
 M3ZZ2zDV3tEuYwDCzH5UjEZNqnV0p1WIVqm9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743969048; x=1744573848;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0qu2Q29U6D1V5jr8dnF4sIgkKuFw7g5uU9cF10Rfp/k=;
 b=PdfB3XkobBegtBk2e60x8lthh15UwF5WGkdyDd8I4Fk2iBYGpZAdauUucZzSc64vPe
 L3G2xkdpEzKzxymOMbo1RNjAcHp3orqQvvO+yskMBQ9jUqJSMM9oXtKoorGYdhgB0th2
 MeSr3tsH8nB15IlTW13QvSFjpo3KLMQISmvl0isTQ5cuPOUSJMs42LcBnJxnKJPepo97
 gQPWIC5kIR1RI+4eBWoJuhJLai/QVVbjC1O+cXSmlkflxohp+mxcLsujnMPgBlp5a17l
 Zf5sls65qMgyrFMgi0WPTypH2W0Q2yPzB+8bhIrTPhsGBBgPrVowPa03rEVDz8WLV7Fy
 mYdQ==
X-Gm-Message-State: AOJu0YzxI/KgASivLEBOpH7Ak2CnoedOcB7F8jKyu2UnacuSbRSKgS5N
 drSyzl8nnNMV1yrhnvCA1UAjPPkNyL7so4YtrzTuMATEAHtHlilZEhNooyykxBw=
X-Gm-Gg: ASbGnctFH53nomQDH5Mww3ABkBn5hTpV8S9M1jdOC6Psvt6O64HKviD9TMc9dV7nA/F
 d2QRQoSL/AUnKO5xLdude92flf+l+DaAuAX/PAQSbDDO5zP07Zn8wF+6otwIytB0ARVnvMCk7nC
 p4CdLRlpbSrnyRiUVX68PpBonEdEqLcSjOzD8VhcBB8voKKZFQszJhr8FgVfqHUpydCrdDFoBhp
 fHvjvYKn/yBxcuJ7/+teTpUpPeAfQmgemRp2AepaiLJMBcU6FE7WZZpReASbDFd0CIj/CxNUCBi
 XJmPU3AGETXz/3UXH2Zvin8fffdpiAZIWa9iCJjEQ2foyU6k5osG1sWRBpe6eIPZPfJhDtmPe9k
 Edssy
X-Google-Smtp-Source: AGHT+IG4pu/QpiSXmed6gojSE6BHBxjUWAMe6QaWxuu7IGQ+CkP1KLlvhuNulpIOMgAJd/8IPRqcRQ==
X-Received: by 2002:a05:6870:fe91:b0:2c2:541d:2cd6 with SMTP id
 586e51a60fabf-2cca188ea3fmr6007074fac.6.1743969048319; 
 Sun, 06 Apr 2025 12:50:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845cc500sm1703175fac.18.2025.04.06.12.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 12:50:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250404163617.2577637-1-trini@konsulko.com>
References: <20250404163617.2577637-1-trini@konsulko.com>
Subject: Re: [PATCH] x86: emulation: Disable bloblist for now
Message-Id: <174396904667.1127672.3065240480627438855.b4-ty@konsulko.com>
Date: Sun, 06 Apr 2025 13:50:46 -0600
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

On Fri, 04 Apr 2025 10:36:17 -0600, Tom Rini wrote:

> As reported by Niklas Sombert, enabling bloblist on these platforms
> means that we currently don't pass SMBIOS tables on to later stages. For
> the v2025.04 release, disable bloblists as that is sufficient to restore
> functionality and we will address the underlying problem for the next
> release.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] x86: emulation: Disable bloblist for now
      commit: cf6d4535cc4ca250290a13458014aac4a29a8cec
-- 
Tom


