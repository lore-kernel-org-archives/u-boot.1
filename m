Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13311E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B3E8694A;
	Sat,  7 Oct 2023 22:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XGmt1gH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EEE586DAF; Sat,  7 Oct 2023 22:37:42 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617AF868D9
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99de884ad25so584207166b.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711060; x=1697315860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=14AQrgkwNnBs7Ed+zZt+zxE6n0TOBwXDiz9cL8tLaU8=;
 b=XGmt1gH0AIPKbVo70fIKFHU/mPdwTY4pZ1aS2/nGyQLib3ELH8DoLUiJZw+ErnujGk
 zFWNj7fuIuQUaCm41MrvXCs3Uo4Tkp2eIQKqyIqrjCeCYAssuNWO8AnTIM7e+J+mfEQQ
 niAhP20Di/HHDX6qKY8ZqpuHWuxlWiw9z9+9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711060; x=1697315860;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=14AQrgkwNnBs7Ed+zZt+zxE6n0TOBwXDiz9cL8tLaU8=;
 b=QHw/37HCSl3kxBBjS5nYvNwTFcB+IR6xFxW6kY1bJ8dFuhE1wojG5mvcr01J4+mKSY
 Sa7xZTlyrDvgmJzkOztkrsNEWhoh2gP/alac1xsTs5x6IVbrwZkiOKjBAMe05EjYQ4MS
 SFsxM7EofpYdbgmT1v9190voxK+L6/JVEyDaopPNR5y/+xU9zQWTwfzBNBWMxSVKiE7V
 8NcWMpGIWSzhUI57rjXuQJD/vF11UxLUuZ9mNu9OVH4aNm7Sraaxj5eOjDf5nSww6BOr
 lKKWE0X8NWlRi6UqX/DQylrueBvo8M9XxmZDmTHLFI8XCa1tMvl8QhdeVrtqG9/1ntBT
 yXFQ==
X-Gm-Message-State: AOJu0YzyiD2i7geFizb94NUyqCqeN8RRAA2kzTKxxydbEW+ohaVNgRaQ
 603EMVOa/iCkZBb4DWQtatBMWJyzaSnM/3PvVA85jw==
X-Google-Smtp-Source: AGHT+IH3YIv8VF2Kb5ImIu7dHhoFxqZoAwdKRd49h/2K82SpGWBH/oJrGW3Gqk1wp5LeyUgrR43hf6ntG03cHWMbFA4=
X-Received: by 2002:a17:906:5357:b0:9ae:7681:f62a with SMTP id
 j23-20020a170906535700b009ae7681f62amr11082286ejo.44.1696711059856; Sat, 07
 Oct 2023 13:37:39 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:39 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2QqvJrJgHp1nPKCpsh36UPmmbHhrBrMcmXP_F-UEXiFA@mail.gmail.com>
References: <CAPnjgZ2QqvJrJgHp1nPKCpsh36UPmmbHhrBrMcmXP_F-UEXiFA@mail.gmail.com>
 <20230923194424.1739224-25-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:39 -0700
X-Google-Sender-Auth: tSTY4R6swzhAb70ToI5prU6pR0I
Message-ID: <CAPnjgZ1y8bJVNvyEjQz-BmLyy2TV2_qtSw1xZwo9dbPweohS2w@mail.gmail.com>
Subject: Re: [PATCH v3 24/27] moveconfig: Move summaries to the end
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Write the summary for -s and -b at the end, using a unified format.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
