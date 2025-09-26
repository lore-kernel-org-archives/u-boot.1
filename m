Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76876CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 745F48384C;
	Fri, 26 Sep 2025 17:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="stvo4+/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87ABC83855; Fri, 26 Sep 2025 17:57:14 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7335B8373B
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-42592472002so5971035ab.3
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758902231; x=1759507031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHVnlwi56ro+yC/6cdxA9YFOp4r1ZpKiPBGU4j7YgWE=;
 b=stvo4+/KB3gTegUYMdMkgfPTrd2UovSVxhpqDe3RZEUVU2znPWWbxqn1v6oSuzhj9k
 9EVpYeytAsHicJ9BP48iaDT9eELekUYqf8XOncNsYUjkxK9ITfxoVP4s+SL8MMVaFmFo
 vorbdDyJLTiDHfUo9ru1Bv0OSKcl4eM1RF+uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902231; x=1759507031;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHVnlwi56ro+yC/6cdxA9YFOp4r1ZpKiPBGU4j7YgWE=;
 b=Nw1CKc6K5YYqqDypDC6hTWAjWCSKc3QlmbwCtmrNk/Q6HPid1vyVpn55zVFLxvw8WG
 esDRYMC4AbhnUZ62cBiprtFFdQ91ZVxFFxQNVllqcu+LU3VlqghqHFQND7b9ArhCIt9/
 6FrUNgJ/14wa4VEYKnUg4aqnndETfFC6bw8cOleAynQVqYhNSDIankMPn0wOxx08+peu
 AQzri3+H1NdCxhXrN9l34MQp4EK3VqxE3hZItoJ0ofnEu4ThqF41H26m4IXCQPineAOi
 dSC5KnCJUC3E4fsdVdx9wDMGIgpJ5RjquEYNi5pnhX2sNOfUULawPxvPLUR7ObPBCL3b
 SZ0w==
X-Gm-Message-State: AOJu0YxjN8fc/PK+JL8Mwmgsd9ykqkO3Wdkh1LIYAXJgm5vdAs1t8ogD
 iiDO24U1lydnw5Ic8nmB4v8O41xr5JnXBQyaojm86pn9T2R75jCA2KosEi0bOtFcgb0=
X-Gm-Gg: ASbGncuI/qUDg5CrvHiKnkVC0yz6aqtiDhFfazNS+HkVwiOxL0Psa1rbWk2KmA3MXFK
 ReMjVABNe45Xar5lm45JlymfJARMb1UTw4lLt23YL/0lD/jRbeYWSTx65jYlWhYY6EnY98osX67
 U2Omy9iE9PJFg6yAwDj62bFyLbfKcEdiAuLTR/KWJsI7KAy4B9KrdhPMdYg9tCFSeLeqjt+5TgX
 84JaNq/1g0WSZCnetwe/SoOy49gOUzF3u3EL53qe+4sXev6srkKQSEGf9Q3UYVwWk31qoO6wUA7
 2iNCo1gSMEk4IENalDDpEKQknSFbVcs8JJve9jR1unLY4lds7REyE9lO7KytV9gC+VYixfiS0Fj
 W4H+5jKUeMj2pxADdQdcCioqswUU6dDqsbicflPtibotd7OwXxX2ACQqO+KGtDhqED2+W1VciER
 wB
X-Google-Smtp-Source: AGHT+IEsT28CPVUFElqdzZCCf0FxGYbFu4k9QmpuESr0lxJF5bIYnD9sTwSosxoovKoo89+TPVD7ag==
X-Received: by 2002:a05:6e02:3813:b0:424:8858:6ba9 with SMTP id
 e9e14a558f8ab-4259566c92emr108713985ab.32.1758902231087; 
 Fri, 26 Sep 2025 08:57:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425bff81253sm23502615ab.34.2025.09.26.08.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:57:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20250926-maintainer-v1-1-3967fbd79dca@nxp.com>
References: <20250926-maintainer-v1-1-3967fbd79dca@nxp.com>
Subject: Re: [PATCH] MAINTAINERS: Update MMC/POWER/FREESCALE QORIQ
Message-Id: <175890223025.3683518.7730975055657817838.b4-ty@konsulko.com>
Date: Fri, 26 Sep 2025 09:57:10 -0600
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

On Fri, 26 Sep 2025 09:57:47 +0800, Peng Fan (OSS) wrote:

> - Update MMC entry to match 'mmc' using 'N'
> - Add myself as POWER maintainer for regulator and pmic patches. I have
>   started to handle relevant patches.
> - Update QORIQ maintainer. Priyanka has moved to work on other stuff, I
>   have been handling this for quite some time.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: Update MMC/POWER/FREESCALE QORIQ
      commit: 9a20a4fba587956225ebaf3878f48e70a2f42ced
-- 
Tom


