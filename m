Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D30CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A976A83D90;
	Fri,  7 Nov 2025 15:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DGDXKQeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B67983DA9; Fri,  7 Nov 2025 15:17:09 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B4183DAE
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e284c5fe0aso318764fac.1
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 06:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762525026; x=1763129826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPF1T3L26Ldbl6T7TCw7KaLovnAZEIvWD1gX+awUW6k=;
 b=DGDXKQebtaAUE7FDB8rAYJ7ts3ZG/cYcWOLFw2vMvrunUM4Myuu1bqOxLnAGmMnXkR
 9yJNTlB2pj4k+3GkW/85vRFl2cDkeWbf8VUpsyusrRYiG3tK3x5LvKnCbLbjBWv2kwLl
 QwW2qQPeXOfE2SghYYRMEZJqv9ryr3BrF+hDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762525026; x=1763129826;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uPF1T3L26Ldbl6T7TCw7KaLovnAZEIvWD1gX+awUW6k=;
 b=SsMrMSstFv+Hy6dowIHibdCLNGC/dUsO+pH6GC4Nf3xiepDCSIRz4TVh9y3fsIvcD/
 8df0oLjzYV0S2mqsFslLvA694feH77Yn6r2RSFGajBnsiJl/seFfOEtMp1tmlKJxJ74D
 6VUKv2V90vg95aN6rOmPQenwlMvsKVCf/DONMUhzxy6QpDHywa6C+LfIbEcVimN0qJ/+
 IICOLNRdt7ABkq/JU/cTbp0YfFuqIa3gDwQaR8Z20Nu1Pb4I0fwSXFl/G2Jfs/CSjxvM
 VeqLeM/DkBI02elkdEp7jCx8mY9p89u2gu1uQxvasZAQ9dY/I4C4uCHsfl912XfHLmle
 YRoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy31I8zrwLOLdmMbbsybAat4o+Qrs0Rp49FNsKaLJhS+xSIjmj0qYSYDwQaz9vSpfFim41Sms=@lists.denx.de
X-Gm-Message-State: AOJu0YwoSnNpfPrFQWA79yoeq7jPAhNLa9X5cZhMxKadQukkcAkxCcSu
 UdyC2vtqcY9AUqVgyNZc1i7u0FoOqGJP8GmslzgFMsWiCnubtIfFY4hjXWqr1iGmCtk=
X-Gm-Gg: ASbGncuGhxPBtK42lRbqxqJmM5LR1UFB89LP/KjHsE7PeXGJDFNGOQxG3ti2+TUL7Hw
 /EmVoTJopviHF4P6S+iuMfldUIRbOlOzJAHfwd+fliqIIyJe1vTAezVy5LAaGsFmNKttdflTt6S
 mqi+R8PVwOZf6Y2YUTzMR+Ygly+kNzhv31QDTOphfRJuWIqSYSNkRlynQ44qKEVT33eyaZ4fik+
 k6yWFw7HsVwP+wwOQKNMf5J82fVXTZTU4Tdw0zE28Y5RHW0bvbe4tWCYnil0q+CxAQppL4r81st
 PivO4H5joAeP0WMosrtZiDIqTvR7amXjandp2w7825GJfEqWUTcU+DatrUtQS21FUZ+lQKIaTPG
 xrboHZMnwYbtC8al6Pr8mL0o1LTPw7qDnplaArY4BONn5z+aIwRGgwpc7/4ZmfQqW1FF1N+RVYn
 DDCWucWQBE2a4RJz9sL4RBA3Q1ag9163vKyce+/Q==
X-Google-Smtp-Source: AGHT+IHS7EmE6i5Bhcv8eKZJyO1hpxvzTdcHCU5w5hr4ZSH99bRWiL1DAp3p1hBTFySXkUKYXBhsWw==
X-Received: by 2002:a05:6870:a79b:b0:3d2:b176:8f2e with SMTP id
 586e51a60fabf-3e41e72c170mr2375559fac.44.1762525026046; 
 Fri, 07 Nov 2025 06:17:06 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0bb8dsm1479692a34.6.2025.11.07.06.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:17:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Martin Schwan <m.schwan@phytec.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251029-spl-fit-full-check-desc-v1-1-ebb42c9d97bd@cherry.de>
References: <20251029-spl-fit-full-check-desc-v1-1-ebb42c9d97bd@cherry.de>
Subject: Re: [PATCH] boot: specify SPL_FIT_FULL_CHECK applies to SPL
Message-Id: <176252502513.3410992.12256787929053608323.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 08:17:05 -0600
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

On Wed, 29 Oct 2025 12:08:58 +0100, Quentin Schulz wrote:

> SPL_FIT_FULL_CHECK currently shares its description and help text with
> FIT_FULL_CHECK which is quite confusing, so let's specify this applies
> to SPL.
> 
> 

Applied to u-boot/master, thanks!

[1/1] boot: specify SPL_FIT_FULL_CHECK applies to SPL
      commit: 3e68c01baf80c66d0c94be753137f01fba29632d
-- 
Tom


