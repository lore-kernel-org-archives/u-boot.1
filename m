Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5309CE7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E362687637;
	Wed,  4 Oct 2023 19:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mnmsOvOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1038761E; Wed,  4 Oct 2023 19:58:39 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F30087610
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9adca291f99so18143066b.2
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442314; x=1697047114; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=28m6NYpt9kFeFyeqSxWPIPkNsb9zyPrYOLP9PGJqpc8=;
 b=mnmsOvOxA/lBFQd+fQEiettzKsHE6IngMQ9PmY5zeX1Ndc3bNtR66dEjlv6dH2IvQt
 Nf3AfQ7L4ihA6lsPHmZyBjfoSIci2fGArA4aA6HzJXLcVnlXSF33he/62/S9rAvf7iJK
 By7lXLMe2eHl5RGNZbYlTOCYdvbD5aOa9WUQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442314; x=1697047114;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=28m6NYpt9kFeFyeqSxWPIPkNsb9zyPrYOLP9PGJqpc8=;
 b=reqV/AiKVVxBndSe24Av5OQkcP9tfTIb0iTK8lB0cpCBllmJx81hqeCUPq2K5E4NdQ
 aW8+8AaVEg/NlLu3X0qhyo+52U1TAFqHw+hpACfk5Z4gDuhmFgDo91vB9cLJJrbqoWyY
 wOtt+XCv41HbFFnQIrXmSRj/P/zcG98e0K/T1IqmoPArmy4n40QFEXQUcRdMwfTmDBdR
 sVfD5mgNHbLUoANOZSFPBJQ3hplqFNjsJZX+PU/G9srijaS19n4E9lBo8pWKGGC0tamZ
 uhEYmTpflDSJvTvt1UFVVI10Z7MWCnC6Otx/GtIEafnbyV3iS1CbFt1KxvDJA8uf5sIU
 4ujw==
X-Gm-Message-State: AOJu0YyrUGUEeQYsgLMM3gj1+HCJOjcGRHCzyaiQjh99mU/n4+Q+rgNJ
 RaYUd7iMkjY9l63Xb+eGDclwV0B6U/rPf7i5t7Ijiw==
X-Google-Smtp-Source: AGHT+IFwgvIbU534u3/Q1roH1uT6AKNLWOVorZpXIApu5yiScVdk6kQRhEBYC0NavITi6wOfMNoB04m1CIrLjtAvMQY=
X-Received: by 2002:a17:907:778b:b0:9b2:df16:851d with SMTP id
 ky11-20020a170907778b00b009b2df16851dmr2384451ejc.57.1696442313970; Wed, 04
 Oct 2023 10:58:33 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:33 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-16-sjg@chromium.org>
References: <20230923194424.1739224-16-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:33 -0700
X-Google-Sender-Auth: 2bSFsDhUhKAzRVnIwBl_Kx_1gNk
Message-ID: <CAPnjgZ2hz+Vc=isBExOUvdbqF-9WC1PgKPfMAnnhjXkR7DXQ4A@mail.gmail.com>
Subject: Re: [PATCH v3 15/27] moveconfig: Use an encoding with open()
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

Fix pylint warnings about needing an explicit character encoding.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
