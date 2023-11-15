Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7357BC47072
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8BB88743A;
	Wed, 15 Nov 2023 14:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hmHd9NSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 031B18720A; Wed, 15 Nov 2023 14:17:07 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F5586366
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9dbb3e0ff65so957657866b.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054223; x=1700659023; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xmX4QaKV4WkOZSmNuCIV0PVDwEfipn1BU5VApSJfANI=;
 b=hmHd9NSPIZInisWdROgm3AmDuFmjTRhy1kCwamYhHrAZgRog9mTq62IiKisiD/ACvC
 Rdhl3t86h+v51ZFaRvcygx3xmu04CPXdg5xs5v/VJmMzjzEAEuJfDiUd4j4Mz7IfNEhj
 7NBS92Ee0tVu8vAGqNCtHRDrHF4FtsCYHze3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054223; x=1700659023;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmX4QaKV4WkOZSmNuCIV0PVDwEfipn1BU5VApSJfANI=;
 b=eJQajQWI1oteTU9yYo/CPmvgvnBJwFi62Fh7/DlHfRebsAykWurtIBeYmQmxTjNscj
 rIqnp1dP11Ex1zwUposNbf4DPjiHKXxmKqM+3GwXtWxZ0WgMYIlP8T87KQ99ntPKIQQJ
 Nngp9F9h8ct9SClN8mSsYFvSnuPOc7xAWJK6ODjolx8LdwXwhMGxydtxNnNVjEmJML/R
 1lor6bn7LIuHwrX4mr/VEuWsc1glcWLEe95TtqRObe+9doU1iw175bvNXd7L5Xy/L8kC
 NHRMDrKwzEBzu+mPQf8pyXTWdkPleqTIhtxCkk4+FPx8N8RHVvjc+odnAuiWITjFuyrh
 steQ==
X-Gm-Message-State: AOJu0YyHtgnaw9VGbEsEBdLhFbqFc9yvjGZqujaMavzBIbwMqyWilGgq
 WWFyPdEOhM7P9M1fPNM7PQnATl2uPr1TqPhQikoR9htZMb96fu/LlHU=
X-Google-Smtp-Source: AGHT+IHswpZlYzeqGC3f92PVJgrDfoUE2S8rbn8TlIsHxsrJG8DAMFeChSB7o0HaDkJlFJUs7xzt1lgKGkQTAm8yfIU=
X-Received: by 2002:a17:906:ecea:b0:9bf:6200:fe33 with SMTP id
 qt10-20020a170906ecea00b009bf6200fe33mr9357282ejb.16.1700054222808; Wed, 15
 Nov 2023 05:17:02 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:17:01 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231104162527.1736401-1-sjg@chromium.org>
References: <20231104162527.1736401-1-sjg@chromium.org>
Date: Wed, 15 Nov 2023 05:17:01 -0800
X-Google-Sender-Auth: PDqJyne4MVV7CHrXRJ_mnUKaXdc
Message-ID: <CAPnjgZ1d822eF2dwZoLUA8xTniaS6-7PBZY+EHiApKCC_iejMw@mail.gmail.com>
Subject: Re: [PATCH 1/5] patman: Split out arg parsing into its own file
To: Simon Glass <sjg@chromium.org>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Move this code into a separate cmdline module, as is done with the
other tools.

Use the same HAS_TESTS check as buildman

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__main__.py | 116 +-----------------------------
 tools/patman/cmdline.py  | 147 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 113 deletions(-)
 create mode 100644 tools/patman/cmdline.py

Applied to u-boot-dm, thanks!
