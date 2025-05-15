Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1D3C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13B982BB5;
	Thu, 15 May 2025 15:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KrBcVGL/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B4E82BCD; Thu, 15 May 2025 15:51:14 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FECD82BA7
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5fbed53b421so1840711a12.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747317072; x=1747921872; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HhFe2/YdHhaOYQxBmc3tzg1pytcfe5/F011zHcAfCZU=;
 b=KrBcVGL/9mbqGIFyeUbzqKx2e4cA+o6QbCJoU2A5rpqB/FXUARGfxiCR5DvJHzWzw2
 +2AGX66du2brVBDCzWUNY27y9PXHp0RJUjjSGfgon/EWz+s3GjS8fe04JEdbGPhX3+Dg
 ZD31AmoYv8yEu1hrsAvz5KZtbXuKyN4ThmpEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747317072; x=1747921872;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HhFe2/YdHhaOYQxBmc3tzg1pytcfe5/F011zHcAfCZU=;
 b=sV9NOekf0mCEFCGOoAE9XZ8YNR9Gc5rfP/DyH5k1sD3jpcUUK1scEbzzhVfn81vDpo
 gjgtvfF5Y24kF6CVk2kjN6tQ6Hu4zesaFl+f8lPtJsVvEDqtQD2pVl2BCYvPae/guVAz
 dC8o4Sf6Hpr/RdAIqC8PmhbB6R3LAGc31X7flpoR31bdknMnobVoOJ0SSEjVACy8xv6P
 wx3jjlRuq1PRsrxPTWqXeiKjopFv9dPIPb7d37yNFGCjAdSpT0PO3kC8s2DBiMqOHvrn
 YY7uB77hVfcWeDmJT7Onz0dNF58vYCLZ+dn84lQ5GozZYKkpKOuk0qhgXYFv3SnT8IUZ
 xIGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFq0K6Pm52oMcjEbW1xJACVI6aYLqUmRZbfnxe1ZxisT5EP/aW5lAp2bmm+LN5OYwort6q7Y0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7z8DxqGX2vSnQNj7T5YJzfvd3PiNrHj0fCuBH7u5cnreZoG7t
 trO4x+j3UegFyNb/xt8dCIX9JxLo8hLt4Vio0o8dqG8qs5RlQKGmcJhkUmfgqfJODaLT//g8jV+
 oDEEna04ONIPU8kcjNv+q0RW4O6j3bzMsK1ZY
X-Gm-Gg: ASbGnculH7KPG4NUD3R+9N+3UYWJ2ar0uXNkems8w8oc9IgcfM9k6nIZyxKBbihCHVk
 00JXh8zfsZp5+VF7UjgjAa6EId3xQTs7B0+2TFJCDswSfFaVXxYZZtmwLJ8DxZVAeIWIC4LdATe
 QVhGaLH1XRaIkKEgR+OwA39aG8zUKyOR0o2A==
X-Google-Smtp-Source: AGHT+IG0TtAxvFNXuOHm1UQdnR0srMtbDCFw/rVr2dJCHGHFktAv7gxr/4/p6520oy4ydBq5UOicMU9pwPeILGo/qyc=
X-Received: by 2002:a05:6402:90a:b0:5f8:77e2:b819 with SMTP id
 4fb4d7f45d1cf-5ff988dc70emr5973339a12.23.1747317071627; Thu, 15 May 2025
 06:51:11 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 06:51:08 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 06:51:08 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250511141828.2367318-5-sjg@chromium.org>
References: <20250511141828.2367318-5-sjg@chromium.org>
 <20250511141828.2367318-1-sjg@chromium.org>
Date: Thu, 15 May 2025 06:51:08 -0700
X-Google-Sender-Auth: L2PxjxSzk-fAcArlyti64nSpHxQ
X-Gm-Features: AX0GCFupXw24ipq-Xqi6QlUKSYnI_YC_aGlW_MqIjVYo-DzPz1D9RzjN8hb_rmA
Message-ID: <CAFLszTghK-t92Aq_5tqOVBnJ9ke8XaUvs95CGJanVST5bGx0FA@mail.gmail.com>
Subject: Re: [PATCH 4/6] scripts: Create a common settings file for QEMU
 scripts
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
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

Move the settings into a common file so they can be used by all tools.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-efi       | 53 ++++-----------------------------
 scripts/build_helper.py | 65 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 47 deletions(-)

Applied to sjg/master, thanks!
