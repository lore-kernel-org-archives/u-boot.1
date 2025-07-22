Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2D7C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 19:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D7D18346A;
	Tue, 22 Jul 2025 21:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cFktu29z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6448331F; Tue, 22 Jul 2025 21:46:13 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280E683439
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 21:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73e55e829fcso3344136a34.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753213570; x=1753818370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcuTJSbe1ve3dxkucIlDL/THxI+ehpH7bq170KYWPfo=;
 b=cFktu29zU4BDrkEkPNFwLDAk+6YxBoIeJAveL8JBfYkUaF9pCCPPivs3X/HE5rFr48
 Wv67mN25Wc/AIqHcUMaMWfxKxp42/nOIzmg8G+0x/a9/gcGjZo93FGBkvTFbh/AEri0j
 Qa0xvkKO+F5eVkbpnI5G5+h2aQDR48BqMRa2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753213570; x=1753818370;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcuTJSbe1ve3dxkucIlDL/THxI+ehpH7bq170KYWPfo=;
 b=iHZDaTTnEsZeESeGqzkNFQpLw5ZYrDkkxVv6DoumAxE/C99wduXVYqmOyG78efIEYE
 Szha/RN5CmmG5adJrV0O0tqbJjwZa8/LCCS4UkAOa6flIC967Tv0P+5fAZtCsRvaqbg2
 Yo7aiWCOc3vjLOvq9ZjILBaT43g1E08SbsWjZgKg9YV6a2+r9gyulxee4sBy6DQW3Cm9
 P8ulU2IBWIghmkv/anAWjoHCPqOQU5HGAib/1u2GD0Vyqq3Kz/uazHq5uIBLYLfU1+wZ
 ju9/UshuNOsoCZT4gT2ZrQp4IZ8kemuatG7tNUZnABiEnD8rJxmfKAcWU+kvK8hjO3or
 dIZw==
X-Gm-Message-State: AOJu0YznHGYNtOvrlF5kXRHc3YOsnqBlwwRYu5bSQkL12nlNpplVl4z4
 XBUuj9ktPMQ9XGEsV1OSW/Hdzf36OTfxzX4NpDHf9lyYWBqW4RC5gC0m7OIG+wh37O0=
X-Gm-Gg: ASbGncsIQzke+9ui6TwqvXrljNYK8GzNMMQZA70v/oaUrFto+4XPaXjrMp/Y/4foXM9
 ynMuZSbSSaeqjnWggvqlPwDrv742lFcMfZls4jNekXp6ewwwbSF8fAgXk8KwyskFwF8rlCyNHQc
 M/h0tsdz9fwdieq4J2zlsxLWp4icV1OhgCdtHt7vq7I7AR65pS6at+u/Ea2oOSvcldXpIqqYCmn
 pUc0ozOod8tiB/Nosgr+sDdhy+ECFgryn3HNofNR1jWPwn99pyn73C5k7YdYXt0J6ZDC1TO3X9+
 FgzNDxC48UC2ZKIO1aZtBYKTkFEQLhmM55k8iNbrZi8hIz0OhE/gC83R0KpqAEmxPyYjyBUccFR
 inMy5YJ2eQcsWAoh1vZ1z0fWL9GoKn9Oc7j/B2BZn0iKNApKiOxuHm7I=
X-Google-Smtp-Source: AGHT+IH5O5RFmvWL2jVmE6IZrKHmlQdlZcZ2OMobEifBl8uyimKZKuLweRSCeNFhBemKE0p3BE8HYw==
X-Received: by 2002:a05:6830:2aac:b0:73e:9da9:bf0 with SMTP id
 46e09a7af769-74088ab2ce5mr398865a34.13.1753213569856; 
 Tue, 22 Jul 2025 12:46:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0c3fbsm3749811a34.30.2025.07.22.12.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 12:46:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>
Cc: u-boot@lists.denx.de, Tim Harvey <tharvey@gateworks.com>
In-Reply-To: <20250715-binman-typing-fix-v3-1-86739854cf4f@phytec.de>
References: <20250715-binman-typing-fix-v3-1-86739854cf4f@phytec.de>
Subject: Re: [PATCH v3] binman: Fix typing for python >= 3.7
Message-Id: <175321356904.77222.11358293167435240326.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 13:46:09 -0600
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

On Tue, 15 Jul 2025 08:21:24 +0200, Yannic Moog wrote:

> To get the [] annotation working with python 3.7 and 3.8, import
> annotations.
> 
> Tested-by:
> 

Applied to u-boot/master, thanks!

[1/1] binman: Fix typing for python >= 3.7
      commit: 187ac12927c042a982961096c9a418287b8e97e2
-- 
Tom


