Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FDFE7C4E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE718760A;
	Wed,  4 Oct 2023 19:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DFCbQEYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F83875D1; Wed,  4 Oct 2023 19:58:32 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F9C875EA
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9a645e54806so22940066b.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442308; x=1697047108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bFIy0eP6e/3iPUWjyIoKCqAn5e+/tFU2EMei8PY5W/Y=;
 b=DFCbQEYCOzdyA8h6rgLOG+raR7fXwGs2MsHCkZag50xBdJ7F6gjjOGbiIAtNa6KESb
 M7QBYd50tNxRGAVkCGf+9icHM0nqaTLFuVLhWEEeAWUjCpMaCrkZhqfZxWHrdhEZVX1J
 X6JIodr5Aqco2TCQVAIZJGy+yZpGEnfhvyp1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442308; x=1697047108;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bFIy0eP6e/3iPUWjyIoKCqAn5e+/tFU2EMei8PY5W/Y=;
 b=f1q/ulIptTeGWovzsLDaHQl5mQP5PcQEsKXdr7Uh/wSlXF2VnVC4KN0kLntkXSSxZy
 xyzLTMk+RYcFdarVy/HbDUiHklIR7FFanYArcEsgMSkjM6Wg/X8ACmGGZ2MLHCllLXRv
 2n31t2M1YMzz73BiXJMGhOEwEOu4UL0gv8OFNUlHLw5UyaR2cs3sKEA7scFTGgWzu2P6
 iCbIIlrjCvcc7ZRN0EBOJRl9Zlz3dMxkXeTXLFRYbXXHMPz7uQTpzxUCWoiwCt37GGYh
 lSvq8wTl+rvA33eeQLcvdyuiXGocfBRI06sB015lSDQMxeU/tWh0QYdg8lhiN5jMZoBj
 LmAQ==
X-Gm-Message-State: AOJu0YwwHyTCNiedXQNQUsXraz0AqSPdO45CuHimUsBFHwCF1PVhRzWO
 e/STKUh85OHcwd+1UEO1rBa5w5miAaqIyqFJx55KMA==
X-Google-Smtp-Source: AGHT+IFSMQvEqVz2GflEQzt2qOFmiWbdR+kUgu0UD3xN1Ie66o/ONsuCMbHV0jyN3IB3u2PWDnyB9l17MeBWFcs9QEA=
X-Received: by 2002:a17:906:74ce:b0:9b2:794d:6225 with SMTP id
 z14-20020a17090674ce00b009b2794d6225mr2712780ejl.56.1696442308460; Wed, 04
 Oct 2023 10:58:28 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:27 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-21-sjg@chromium.org>
References: <20230923194424.1739224-21-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:27 -0700
X-Google-Sender-Auth: dvr7HOh-uzhtNVqSpqJ43k9FugU
Message-ID: <CAPnjgZ2VVry=4tUo=qeTOcMuCkkwfgB4jX3=7c6qhWqJ0v5jMA@mail.gmail.com>
Subject: Re: [PATCH v3 20/27] moveconfig: Use u_boot_pylib for terminal colour
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

Use the existing terminal code to handle ANSI colours. Enable colour by
default if the output is going to a terminal.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 92 +++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 54 deletions(-)

Applied to u-boot-dm, thanks!
