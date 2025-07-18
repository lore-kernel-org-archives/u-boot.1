Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA0EC83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 19:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0518367F;
	Fri, 18 Jul 2025 21:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FnRxibYE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18CE583700; Fri, 18 Jul 2025 21:43:33 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2010836D1
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 21:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73e82d2e99bso604044a34.1
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752867809; x=1753472609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXepa+g+L/LbXa8OgDKrTQcsWJvyX9K74N4N7N1H8KA=;
 b=FnRxibYEkf7fzmgzHFGuVJn4wLRAS2CoQ73scujdLxPl2Ol2FFcDf598HpNESoZP5T
 HbDeR1XK28GiqoVob+Zr8+7iEIVWSuT34NXFTpvmcaUKk3onKa5JuL2gtg2PvhgM2UKb
 y8G+M5OjwJaZm6saZmCdCYDag/CzUTqBFpFCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752867809; x=1753472609;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXepa+g+L/LbXa8OgDKrTQcsWJvyX9K74N4N7N1H8KA=;
 b=lK+ocGlsDtYmNYqHCGL1sFNiMCkOAWQ7VMn+cXt+7gz9tQVO4ZEzIQTpuwpV/X5iHC
 Hs1pIcuHOWHaU9Z3YuQs59ISNUr1Qui+SnOn2p1fG0V/bVdl1Y81T0ISYhOEvcBkc9sB
 nrT54dFZDsq2paxn/wgNl4bvRV7g/GpDDz2WqNP7AwNJUksTjb+S/QwAyLCfgS8Osw0r
 XKgvv5DKeqCDzHZZeDoB+cp4mgKGLgP7kkBI+4EZllLyNRB3vsMoB2Ms+MT0szbtAIu2
 LrlCpxZZ5BcOyEeC2uf/HBOUcbDwvGmpDThVnxV+L6+1Q0ofbA0iZuZYdMb9dlTauoEa
 ap3A==
X-Gm-Message-State: AOJu0Yz/AQ7EGZiiEdXZZl7DH95cbVgiFEoYLqY71TRWkQtQI1JWRmGL
 a4OPpaHn2/wM6RheaTroeyEJjG/3BGR4e1bQ4LhXO9tXBNC3iSmu2zyMX+oD+mumg7gjIeHlHG+
 uXhSLWpg=
X-Gm-Gg: ASbGncueI0UuaDTMtsg8PaSxW0HxlBJhBC5LKm5Yl+V0ofUoWYiWHNzrC6JVH1og5vf
 rVw9mpzCTmTCTvrEzaa4inRANvZladJqTzeP8IxOEqNflQQim4BofxX/F5V4uUGVbXE/dtUBpUs
 C48Ug+iER0UdYTlRWYFsz+b0fQKrzZhPsMt8PFn1932/pPMCZEln1oT53iS4LQzBcJgRHMJCCFf
 VHJC2Q/3CkCRs8w9PXTjxwKgpSoOaODSJV1yuLO0lNFW2IA2+F2nD1UGyej3BbQJNpzKIJVN2Wv
 IxWZpj7akkabIsgKuRWwNJ9LQzIgR1xyh2WyON76qEhu1cHO3wBSV7Us2FWy2NUQHzscyx/szjr
 9iQhzWowHdbxtBoeadOH+yq7i8fY1HaIaZ8MsCZNwFn9BavhJQ5B601s=
X-Google-Smtp-Source: AGHT+IHGo2n5TdUrYcG4ZCbLPtCriu/2V1wC4uMpExOeLj+lYnC74nkD9/kADglYT+k6OzZ01O5erw==
X-Received: by 2002:a05:6830:7309:b0:73c:beef:ef80 with SMTP id
 46e09a7af769-73e7352e8c4mr6614730a34.14.1752867809488; 
 Fri, 18 Jul 2025 12:43:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0be4csm871076a34.39.2025.07.18.12.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 12:43:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250711184336.2248130-1-trini@konsulko.com>
References: <20250711184336.2248130-1-trini@konsulko.com>
Subject: Re: [PATCH] python: requirements.txt: Update a few modules for
 security issues
Message-Id: <175286780818.1647311.14133328026620342275.b4-ty@konsulko.com>
Date: Fri, 18 Jul 2025 13:43:28 -0600
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

On Fri, 11 Jul 2025 12:43:36 -0600, Tom Rini wrote:

> The GitHub dependabot tool has reported a number of issues recently with
> some modules that we use. While unlikely to be exploitable in the way we
> use them, update various libraries to the latest.
> 
> 

Applied to u-boot/master, thanks!

[1/1] python: requirements.txt: Update a few modules for security issues
      commit: 15d99b3bf5ec76e12b5a5ccdb9b923ba87fe6dab
-- 
Tom


