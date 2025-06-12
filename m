Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA742C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C1F182BD9;
	Thu, 12 Jun 2025 16:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dxw+EUU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B64282C4D; Thu, 12 Jun 2025 16:34:58 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74252828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7304efb4b3bso668904a34.0
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749738894; x=1750343694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5yxgcxATPYoQYruSw+kcCZgVrT6UdsLgKCWe4s9C0Q=;
 b=dxw+EUU7LwMZp3XGBitRzjM2sIfSh5B41x1sMQKTkUSV7OO8gzsr11kL89fFElxHVX
 COiEM+JfvXbF025oXIXBO2MmO3/rzrOljLW53tSPflHkA6sjV/alvVnE/jPqc4+SRQ+j
 MeKt0QveOU2hPlcMEZK44yhCjgqaz4VJUGt00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749738894; x=1750343694;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5yxgcxATPYoQYruSw+kcCZgVrT6UdsLgKCWe4s9C0Q=;
 b=k4+LKYTPH/CrcIJXcbYJjqsxtYzw1i962F0ITP0ZlOkqeiBmAqeRR800MK2EH73OH6
 ndF1vaxCipFrtgbBrxrnW35/A5xU3mqgaS+v2mFO8x9tWPHmDdKdAsG8RyVglYzC5dPv
 D3lMlWrkmhkrYZ2mU0/cSCBhotQcEr7luGaXl97phyt8CFFgNlrM617k0GyFVdf9PpIC
 yyUJDcd8/55WgBD2kkddmHoxE4X7Wo9tXCnCsrl41ZA7YpNkTO90HFX0pBRs94paP8d6
 gx7zxWCDG7MjaYegPtmmaMHgDHyATgIAflrKPayQ87mV3fnKSIqdMyO4iJ7rUqPkT2Xj
 tAXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaiWOl9vX0StxzQxinOlCtgosdwKgj+CafXYWN3YCYsjIUZto19GwpL67jl/iIih8MUN5GNZk=@lists.denx.de
X-Gm-Message-State: AOJu0Yym16UGIRNqf7coY+zTQX4IORiV0UpfxjOadAFzW0Br+47TWvGc
 3xle7II1yoHpDXbga3CEoboLkTokkFpWvf66QNEUk8AsODmLdetAOaSJDDQIC0CgY+nZCcKT5mg
 e53GHtYY=
X-Gm-Gg: ASbGnctBOH9R0yoaubRnysPbZgxEbso886D/Kmy1zMK3ullG1kk6wTLIptoJ+/jOcFi
 xiIDdXDOlUofh0Dr3AetnC639jMTDR8wTMZJQR9/KZ9GNys4wLrQ1EHzUz649i3EeaT1SVNEmqL
 vOsUZHiIZUDvtZWy9aeXeUHKPsP3eucHQownVLzRC1PHH6FYLXet4CO9G+t/0PHR5Een9GZoqzL
 NWvoIecUrlGrDSZ7g5L5Rd7l9/mE5NwFU8bYLWDZKtl92xwTDam6dQUTfm8UvpHnZgcDBXTDj4R
 +Lr0UgicN34KEo4S2JxI+mZgmtvAssChlNRXq2GAv2uIJ0aOo8Wecoa3fzK5JF/9b869O0pBYh9
 0EDK3Cre3XA99u7fuTrZsGQ==
X-Google-Smtp-Source: AGHT+IHob5vMPFHH1b02aGZA/po/67jem8SM1xdYmAxB0Z4Zna+hxyAWDkyVBEFMvGzTAlrs7PZDLw==
X-Received: by 2002:a05:6870:46a4:b0:2d6:209:8a6 with SMTP id
 586e51a60fabf-2ea96bbae67mr4379760fac.2.1749738894141; 
 Thu, 12 Jun 2025 07:34:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab8de67e9sm319217fac.30.2025.06.12.07.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:34:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>, 
 u-boot@lists.denx.de
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 00/13] Update the kbuild system to 5.1
Message-Id: <174973889260.204623.16659773282498326479.b4-ty@konsulko.com>
Date: Thu, 12 Jun 2025 08:34:52 -0600
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

On Wed, 11 Jun 2025 23:24:27 +0300, Ilias Apalodimas wrote:

> Another series backporting and merging patches from Linux 5.1 kbuild.
> There is still a gap that I plan to update after this series gets
> merged [0]
> 
> [0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commit/5da099cef04fb5c02dcafab8d1bab8ddc2855765
> 
> Changes since v1:
> - Rebase on top of next
> 
> [...]

Applied to u-boot/next, thanks!

[01/13] kbuild: add -fno-PIE flag unconditionally
        commit: 7e81e690d7276283d4a4d988fa47e0965c62c433
[02/13] kbuild: add -Werror=implicit-int flag unconditionally
        commit: 0ebda5f1f0c96679a7d6d365016ca9294a1c5dd9
[03/13] kbuild: use assignment instead of define ... endef for filechk_* rules
        commit: a76fb6981fb502717c7a5b7a601ef5c4c4dc17a0
[04/13] kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD
        commit: 3991f85e4cdcd721c91d376468e5396504e2199d
[05/13] kbuild: use -Werror=implicit-... instead of -Werror-implicit-...
        commit: c4a52fbb674cce8b85d9a9c62ba718de7803e176
[06/13] kbuild: gitignore output directory
        commit: 156fdc57f7a2d7ab578c8c52c3eb1108d6e0af4e
[07/13] kbuild: remove meaningless prepare2 target
        commit: 931f04a85ad40cc4f96feec1cdd05e0c44cb3bf0
[08/13] gcc-9: silence 'address-of-packed-member' warning
        commit: 057a53b570a6896b9337169645f6b2cc8d0d218c
[09/13] kbuild: do not overwrite .gitignore in output directory
        commit: d1b6489ef11bc89145e9fcf1d0f05d89a934e410
[10/13] kbuild: skip parsing pre sub-make code for recursion
        commit: 27529f1cb02d8a55ce8de594f15a8d9e7aec0bb8
[11/13] kbuild: mark prepare0 as PHONY to fix external module build
        commit: 4a247d1376302ebdb05af3a15a1788b987d53a1a
[12/13] kbuild: make 'archprepare' depend on 'scripts'
        commit: 45acf56e59a38275fcd4662eb005d910f65df4b5
[13/13] kbuild: fix single target build for external module
        commit: 070b81458aec02f0cde69f87b28fa82c5bb8e906
-- 
Tom


