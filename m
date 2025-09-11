Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAB1CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 19:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FCE183403;
	Thu, 11 Sep 2025 21:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LRTx4ogU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74665833D1; Thu, 11 Sep 2025 21:25:46 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96FCC833E9
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 21:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-88432e1af6dso82227739f.2
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757618742; x=1758223542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WyKaLxkptUU8zM9Ruo2F9J3CR4dFHVaaLRh2wt1u3Y=;
 b=LRTx4ogUiEUGaKgbffEzprIA7gKWlx6wWO3uL7OKlRjacoOZ4G8X9tlUsxjrzlwh/V
 g+EQa1IgssLyBm4w+YXD5xsbAvWKij99uoOlJFjKMEHdk7/dJ6V/b5tmhw5IH4gjSvaD
 vuEyF2lOxJePxIlScVUukzbyYgOs+3TQfAfxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757618742; x=1758223542;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WyKaLxkptUU8zM9Ruo2F9J3CR4dFHVaaLRh2wt1u3Y=;
 b=anXmJznwFl+5ZfZfOTOgvzUAl2V+zg4RQTaGdNeM9XByv6rsK1W9hMKgNtGpAM+1Fe
 Tdvhn2QhWEuixXFF8v381w9evZMOrqazDPf7C7up9G01NoitNCYtwtea/7zZvxKb6baL
 PzqQEdpHdclP2JtZBtAaV85lILDcRq7iJZttmdno8IVFAZkUUUebKtJRTSdbmFlaDoXm
 mIDqtcU0eM04vtCKvkFG5uWC1Y6OutV7wXVrlSSQ7pJyOUk95v2C/eiAVxU1l33ClGfz
 9kMg3r6Bt4Ys1RgCpYQzbHlAnvW6sk1FZjd+/s1JAFnL4EYq+k0EcUUxoyiP+Wzg3Svg
 4daA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrYPhX9JZM9jScNapG3fh8Wvri3L9ROulmwW4UdTeCyGonICho7z7OOWz19bCZW2E9cXKhZmo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5yHP9s4Zp/Yc9uIK1tLk8qS9g6rxeLoKcZauLRnwuoA9vc0dG
 snPUmp4qByfwzyV0wh3+Ljn1y+fchEjudOBgU2FddbF2pumgY7sarUbFW6icsj/CPbk=
X-Gm-Gg: ASbGncu6OBhndXjv6OuiR7p3TWwTOLXan9DgWB2CGuh2saXuWeTPvQF5wE0iSRJh26+
 +vk1UH0TzvClx2/k3qToaj9bxnbLrenisk7a249PVQ29Y448RgglKVUENqXKepIaW4E3Ooz9dC3
 cnebMnbPPyKV2KXAFYNybtp8McrSE/bks4SgDCth1qLlmWzLMAoFBB1eQpa/o13NHFUygb+IbC7
 MhEUM6+StpK2wzORvxCZbkqmlWI4Q2wgG3t6VNg0h11ORPi4Jdiq6G41D34OG6HhiL8vXYErMtD
 ONptFVG8bEkNIJwuTDi665xvmMjqri+l+7vThPkXPSuTXBsAEmmgJadsMfxAlo2Vv6cB14yXfZW
 qdPp3gUUIWrO7Rcez1pz2wcwtwQDSWrLfA7ImmZ3EHEDLSZl8LH6QHw0=
X-Google-Smtp-Source: AGHT+IG7hPCbaVlcASIts6nH6vvqTzss7bkqKSoVBpCQjfQYxF1LXLGVaw44TLERl/nrJqRg9C1F4A==
X-Received: by 2002:a05:6602:6b83:b0:887:14fc:4f5f with SMTP id
 ca18e2360f4ac-89034331e28mr56258139f.10.1757618742325; 
 Thu, 11 Sep 2025 12:25:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-511f2f391a3sm854305173.25.2025.09.11.12.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 12:25:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20250825152310.1847708-1-jm@ti.com>
References: <20250825152310.1847708-1-jm@ti.com>
Subject: Re: [PATCH] board: ti: am65x: Overwrite get_overlay_mmc
Message-Id: <175761874147.3939245.8584103221233467109.b4-ty@konsulko.com>
Date: Thu, 11 Sep 2025 13:25:41 -0600
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

On Mon, 25 Aug 2025 10:23:10 -0500, Judith Mendez wrote:

> Unlike other K3 SoC's, am65 SoC has the capability to detect daughter
> cards and automatically generate a list of white-space separated overlays
> in name_overlays environment variable.
> 
> When applied during boot with get_overlay_mmc, the path to overlays with
> default distribution is incorrect where path is currently: boot/dtb and
> the overlays exist in boot/dtb/ti.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board: ti: am65x: Overwrite get_overlay_mmc
      commit: 8633643769b5d5b30567b89a1c0fb00b8f2ac7b2
-- 
Tom


