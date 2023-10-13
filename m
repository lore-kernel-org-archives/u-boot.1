Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFADECDB483
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 01:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA4A86F1F;
	Sat, 14 Oct 2023 02:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IXMiXnjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B100486F50; Sat, 14 Oct 2023 00:03:41 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED8586F24
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so520463566b.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234440; x=1697839240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cpCsqANH/l64VlkuxpqZupj5Ij/X4pixOUjqSqJ8PF4=;
 b=IXMiXnjQrarZwXKtn7XqEMj3Rly9yLODYgds6jtZSoSuUCtWCsNerXxx4WRu0R2oYb
 2XkDRnEpVZjy7zgsiZvGUD4SpXsYxL19WnOJUL+iT8CRrFxZfPbmf4uXPErf0fF5I3Ea
 JbBaFIBJKJiSCUxG4wYBEXjPEMwB8tbnu49ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234440; x=1697839240;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cpCsqANH/l64VlkuxpqZupj5Ij/X4pixOUjqSqJ8PF4=;
 b=BSlAUjQc1GRW8x/e/HUfs74Gk5Xmzp3Zz21V0TffBmVDVum1xjcsD8yLgi8SwV/huz
 0C2+5fLebHj06yqCt9rg2zfsRk5vcPWUpJehZc/zURZ4VtpauvWIbDBqxExkU4iSN239
 fc3YdUmPXHQ7IhlkjAmQa+iGlHGD41TLUxukHPbZTdLhm9OgfxMlqhSZfBp3SfYgPUZT
 XJM3lgwTKMxDsK4se7ArOv6VQ4SDh7lTlH2WBYSZzAVjXQIft0pWV2sTW6gCo0t3wSYa
 PJrSWo8uATPzAkHmDtb6n7eRjDCVJT4a+d83LTH9HuF6/qP2R4Il3mVAeu2GSlmmjTDF
 cLKQ==
X-Gm-Message-State: AOJu0Yzu+Obnh+cmUZWUxKd/tKuuy335U5f0TkXH6Pb4jOL8PGLPOWjp
 Up05Z2gagpclvRD8QH/xyH64GRshn540Xpd9au02fA==
X-Google-Smtp-Source: AGHT+IHXUc6tnuTtfpMcOHWh0yuCZacGIGWdAP/8mguFCasI/hHbK1EaRXxRcm6UQpdkH8r9DLEq6dADV40RyeQTmhA=
X-Received: by 2002:a17:906:fd89:b0:9b2:b808:6a1c with SMTP id
 xa9-20020a170906fd8900b009b2b8086a1cmr1133284ejb.35.1697234440266; Fri, 13
 Oct 2023 15:00:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:37 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231010091059.375036-3-sughosh.ganu@linaro.org>
References: <20231010091059.375036-3-sughosh.ganu@linaro.org>
 <20231010091059.375036-1-sughosh.ganu@linaro.org>
Date: Fri, 13 Oct 2023 15:00:37 -0700
X-Google-Sender-Auth: 77NKpilPxC9TKCGuXDPf51UnFwI
Message-ID: <CAPnjgZ2CSCq60ZRzR0gZexHQ+crSzhKL0vPLUefVcVEiqTWXaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] doc: capsule: Add documentation for the capsule
 dump feature
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Add documentation to explain the printing of the capsule headers
through the mkeficapsule tool.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V1: None

 doc/develop/uefi/uefi.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Applied to u-boot-dm, thanks!
