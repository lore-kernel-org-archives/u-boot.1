Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056BDE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83BAF805ED;
	Fri, 20 Dec 2024 05:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BWTWxP7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C9180600; Fri, 20 Dec 2024 05:06:46 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D5C08036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso289627866b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667603; x=1735272403; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eIB3r2i0hv81uMYTQVd7/Cv9Npghy+8yvk4vSs2Jx58=;
 b=BWTWxP7q7ZM5kk28uc+SgrsenOZjH8dtvqAY4dlIZD0GwG24DmNbHwFGdD3qCOeEtr
 /0lS1RfMDMd445QsTLPPskuZBFCofyYggvN1gYsorUkYXnRXCTCTqqeTfjh1+lprhfsa
 2AWiB6qqisMV4areRUCc7IBHqNNvbZvVIhn7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667603; x=1735272403;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eIB3r2i0hv81uMYTQVd7/Cv9Npghy+8yvk4vSs2Jx58=;
 b=C4ChZ+a4N8uTzNZ2v+rjLocGe7t8svAAJEGbPD1o81G5a8QzTg6nbx9yQgDZA64kd2
 wpmpcyFFj6g7CTiN9kcKyabI1rzUGm6UZTLcItrNqBnlwZOi+ApfYR4UBlJO1ZOfOTX6
 Yrd8zxD3zdIbS5sNw7cHcX/miK3KdsdnegnRZD21aeRwxlT0V6MCmBnhf9k5nfg1wv59
 vn30psOgXxRxrvisFOChWEZcVlEXnY2FdrzynmaMqp+X0WTy7F1++ww8FSCX8GisIfoP
 yH/qozC9ws6e+VfyezC3SrJVIveP+eqMED3/3Efvcs8PegsC6TjYiU2sRKk/CriI2M6D
 Fm5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPFl28d06dxKamjXubcCCF6+AoWogeoF098K7C0AKJhhTCRYwWt7wgMBm44XhtyLpXwU5czpQ=@lists.denx.de
X-Gm-Message-State: AOJu0YysmS88mdjhRnrD8fJlCEUm/7DoFCxf42m5c1I0b1fvSxHykzqs
 2N8RGa9JCEvgVtTIDpMcAqPXfjRAjnM/Arj15vf/yoHq/rku93SggT/9GLH5CnbeyueeKLgMvqf
 VT4V6DGanyQfSOQOXnbSRbrYSy/q4NVuP2UMu
X-Gm-Gg: ASbGncsaZ+9Dc1YWl8pNUE3FPnPppRCMGW4rA0VGoT3ZeCA+Hdlmz3lnODyZPRsmwOl
 Ua4X5QO6WEQzPqA6vVge1RcnGIOUCA1M5E9ilEJE=
X-Google-Smtp-Source: AGHT+IEl9ZbUyZGVAb6ANXoJ9JHguVVMpPk7omP5dt887OW+CZY+Fnh1iIFRT5hbTBGYQIKhXVxDPV082VXJASqFS9c=
X-Received: by 2002:a17:907:9711:b0:aa6:7c8e:8085 with SMTP id
 a640c23a62f3a-aac2adc608cmr90212266b.15.1734667603565; Thu, 19 Dec 2024
 20:06:43 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:06:42 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-9-sjg@chromium.org>
References: <20241206023626.2456858-9-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Fri, 20 Dec 2024 04:06:42 +0000
X-Google-Sender-Auth: xkhjDX6gMkCP_7H66Ixvk3gA2-w
Message-ID: <CAFLszThxorzauZb2L-Ztsc9_ngxaxtJtFgvsbBiqxA87Xf5hCQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/46] x86: Drop the unnecessary base_ptr argument to
 zboot_dump()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

This value is include the bootm_info, so drop the unnecessary parameter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/zimage.c | 5 +++--
 cmd/bootflow.c        | 3 ++-
 cmd/x86/zboot.c       | 8 +++-----
 include/bootm.h       | 7 ++-----
 4 files changed, 10 insertions(+), 13 deletions(-)

Applied to sjg/master, thanks!
