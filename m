Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43FCCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE88E84534;
	Thu,  9 Oct 2025 16:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QVPVxODX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A33E784529; Thu,  9 Oct 2025 16:18:57 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91D94840D5
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-43f8116a163so537442b6e.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019534; x=1760624334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0Q+ZBdal9bnApVQ1uxllmNa7rRkEg8DYIx0r16x3z58=;
 b=QVPVxODXpwGuVr++8CBw54DC4nNpfL3jms0bqqn/JBhImSKS3QImrJsTVzxH84Nlo+
 /c2ryeAZtW7gXX+3uotjIflX8mhidnXsCZD+K7toQeosSooZrQkHOaNrxVrpPjw+Bo1K
 wTX/+msDK8LHi4TFlP/74QPF4HeFO0r8DE0rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019534; x=1760624334;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Q+ZBdal9bnApVQ1uxllmNa7rRkEg8DYIx0r16x3z58=;
 b=wINdG+iVtY2/OqNwSqiU6+Qbsdn4TZSUWDF1xDqsAHdiqQfoSf0khFpo1gnoJ1/MaG
 jFY6XIhL5Hm0XSPN0v6W9wITVUzlpzKO+ycMhkk4e6gqYfXTQWQNnDjtHEOMzNhmR/AY
 10JcZ2XIp0+oewUMOQNpD/vqPpTiZVrhGocN9kyss9ND9mlg/vzWTm/uKNBMHci5EGGJ
 LAqewhPVPX67a4IEIKDeUP5lq5Z0sf+eIL1J4OYSacCsb50wKqkV92PezrsCJFHFsLx+
 ZwMaO/5lihO6NAZXjLhokzhHLGJF3Hl3DSo2WwVeEpIozNUo3v7b3hbJHvcVzCgwyAgg
 B5Sg==
X-Gm-Message-State: AOJu0YyW2a4lgi+ujgfa+7QNU60sZwTs88G7JU1kUtnjCh1es8gqbqL/
 Yqd2BnGmyOF/ofY7hlRvgkXcGzzwE5JVzzxIzFvXjhc2Vgk3uBbb/kQZ+InUvvGqoVFk7YZBj6g
 pdxY0TFY=
X-Gm-Gg: ASbGncvOKKWGGOPC+4dT+FghYjXsLmmbuW0FAT/Al1wKDl9aj6B4bIvL7Yf5F2kANf8
 M3n/Iu30mGDzi1mRmCqzWa8+xAEp2/2eM2jag2Sop0+Kdw5gZbaPZKmAs+fLjNHCROueVgkIdtW
 S/UNx0fpUtjbJwOPN9YpjqwEbhAqm3bLtmThgb6YH0ZAG6uLj7tXBIP0souHZDNVzyKJWO36d4u
 jngUpRL188QoYIxvZJwuYqRfFLmOELMN7WvKV4jVZnWcM+buSRqTLAdtq5RKrNyNEjzXe+eL2lk
 04ayJb4uaMgcyPs6hx3GrBmAzqgCf66Cb0Bb9phgKeujLEiKGddtcHKKxggVSAUc+I6vOvyyGuU
 s0QzZr0K8vO0UvXmHFSCCCDLTuwC2THfXWXiVhCAyKR7P28QkDKydF8C+my7+IzNiX5Qo91YCxi
 R4tOUZjumZ
X-Google-Smtp-Source: AGHT+IE+7L4Sxwiu69/uAESWXu6OsADSIHMURrJlhGciISJPftCzLj4vJNF6W+DWobGv0pHrNHj8SQ==
X-Received: by 2002:a05:6808:5283:b0:43d:24b7:2b8b with SMTP id
 5614622812f47-4417b2d0917mr3942975b6e.9.1760019534216; 
 Thu, 09 Oct 2025 07:18:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:18:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250925205128.3561934-1-trini@konsulko.com>
References: <20250925205128.3561934-1-trini@konsulko.com>
Subject: Re: [PATCH] sandbox: Add more dummy cache functions
Message-Id: <176001953335.3159859.10551352103827942391.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:18:53 -0600
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

On Thu, 25 Sep 2025 14:51:28 -0600, Tom Rini wrote:

> In order for cmd/cache.c to link we need to add dummy icache functions
> to mirror the dummy dcache functions as well as another dcache flush
> function.
> 
> 

Applied to u-boot/master, thanks!

[1/1] sandbox: Add more dummy cache functions
      commit: e5fea3f3b9f41c76287328223b934644fc50cbad
-- 
Tom


