Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D97E7C4E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A0578763B;
	Wed,  4 Oct 2023 19:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ONQkIFTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743FC87628; Wed,  4 Oct 2023 19:58:41 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A746C8761A
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so88013a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442315; x=1697047115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bo9sVL3WKCa8G089QogzEUj3m5sXdc1ZiUoW+wR/oNU=;
 b=ONQkIFTBBE13Lzk6r6EEifs8mmcrIXRU7rLgqMs1VWiLzljRNtvSe0AfzB+ex/gYF3
 auk7XEuXYgz8DjZv1qI99SM+oqmyOyq5hj1MjOj/DEfpzOnHT1QMjLdIS3kTvKB2T8fB
 EBmCrBJSUHu4j1RUpYEAmnIJt/zI9hvmsuZHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442315; x=1697047115;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bo9sVL3WKCa8G089QogzEUj3m5sXdc1ZiUoW+wR/oNU=;
 b=FdjGH0Kwo81Ga2ZvWLnDz8fwuSleIil9sqx7WSE0SwobEpMmwmDD8zaGYS9rL+9ZJ9
 6BeWBiARdGeLXg4gdpQh+ahEZxmdhkKvjr7+D7brHvcA96hSSOB8wtD8QKnMrQi2Xm3w
 7EOI3IMXNKXg8htdMWo7v4y7ylV5rslr6XYawJG0t8uKtM8+wGXnb63kOSoxy3FIgNPI
 wKBXbtzIiZ1qDmSREYn3sRC+7MQBWaXD0uoTRtHSVxWFnH4PMn2rKZkWqXJCS3yH4/uZ
 zNoFc9wbtJ0vfNHmwjJVBIBJtfk8idiqKpS4PExJ3bBROZlJ0SRgtE56u3BWQMtey9Jp
 s21A==
X-Gm-Message-State: AOJu0YwoOKmZBPNiFCz9qUHG1tbKzd++GXxRzD3qWqXczjuX0jBYeq7r
 +4rFJiOZoOooRVP9aJEpsn3cH9GsD8pdKZJ6ewth5QN4MWaEMxIk7LY=
X-Google-Smtp-Source: AGHT+IESYw1CIWFbzgh+mhEXPhe6199iag3v7LhsedKApnKR6Jzb9ilr4KGlavP64eJQsm8y6taVKxe10c+9iLBRf7c=
X-Received: by 2002:a17:907:2cd5:b0:9b2:7449:c734 with SMTP id
 hg21-20020a1709072cd500b009b27449c734mr2845594ejc.22.1696442315652; Wed, 04
 Oct 2023 10:58:35 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:34 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-14-sjg@chromium.org>
References: <20230923194424.1739224-14-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:34 -0700
X-Google-Sender-Auth: MpA1DoCIMm7SsKvWNojv6CzmCAo
Message-ID: <CAPnjgZ3AXRPMJSWDFDXuERVrrRowGJgvjufQF21VjGB0zfohVA@mail.gmail.com>
Subject: Re: [PATCH v3 13/27] moveconfig: Correct use of members not declared
 in __init__()
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

Fix these pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 4 ++++
 1 file changed, 4 insertions(+)

Applied to u-boot-dm, thanks!
