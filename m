Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE15C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 391D6878AF;
	Wed, 13 Dec 2023 21:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E4DU5Vrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2958187878; Wed, 13 Dec 2023 21:39:20 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E4B387876
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50dfac6c0beso5352084e87.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499952; x=1703104752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZI3jbjJ/xU5wGbp7VNZ0/yKlqcj746hKvWnwe8rcIGs=;
 b=E4DU5VrkmYZrAZb6+dIRqcdAMtVUCdINtlfTFENf3Jh3KijhUxwGM2nAvP+KIn7lAE
 ziFwKmokS4dP6kQVr4rNmx9I+XMND6wwgvssCnIF3iSnL7u2961Zt9i89UfsQNGfIAnt
 zXZJWTPctS0SfL9tHg2Pfcvc402hjb3CUmbi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499952; x=1703104752;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZI3jbjJ/xU5wGbp7VNZ0/yKlqcj746hKvWnwe8rcIGs=;
 b=GK0QlQsHkMxf4/rYzKJcN3k6ZXMQv2eUecRkXHvUYlcumvYe+rYAUNFMCck1VuGAmx
 PnSclH3AeZv0DX3jdTr+FEaAFRGuk4/qeACFXw55fdH+VaTSKxrOrMOWR9h308KmGY6c
 E9zT6diRNu32WOFKkVLqpRSN9KVyLF8CAu36GJ2BKwd1LIQoKGqjwa2gddgzgC3JS0AE
 /NDP9pU8klVFW3Dy1sjRLj/fDXTqk/oHWzrnue+ahRn8FbFbx05hLGNRAVuEmbF+ISPh
 1dZvvbH6DENosVlXsv5l2/Sgvn59m9+HaNnh9+nUubc6tZ539As+NjN4thDxC1+fgl48
 2/IA==
X-Gm-Message-State: AOJu0YwlwkiCf4Q6mmDZMCVhnLr6SbmTpBH0u7PKXQiFI4eMnrM2p342
 qbCmjmxrNflPbZtlgSxDTUvsEoOWfPXR+dz96OuNT+e6F/q/UHNfooM=
X-Google-Smtp-Source: AGHT+IGGkfXUlUrerjkr2ZFjytX+1+NoB0S4Ppi2widLvR2bh+kSa8vFZk2PKfqzyEzkGlYYAwlIlFti8Ta5hhqjXi0=
X-Received: by 2002:a05:6512:6d:b0:50b:d764:966d with SMTP id
 i13-20020a056512006d00b0050bd764966dmr3690823lfo.81.1702499952362; Wed, 13
 Dec 2023 12:39:12 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:08 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231119153611.639252-7-sjg@chromium.org>
References: <20231119153611.639252-7-sjg@chromium.org>
 <20231119153611.639252-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:08 -0800
X-Google-Sender-Auth: yiPFqcztkuaOc3NYm9K5Fvc2rHY
Message-ID: <CAPnjgZ2ASRyRe0_Oh5Dkx7S=LbrY_Nztj_k4c0=P=KHnG6hYBw@mail.gmail.com>
Subject: Re: [PATCH 6/7] patman: Update the run script
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Patman now has its main program in a function, so update the toml file
to match.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/pyproject.toml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
