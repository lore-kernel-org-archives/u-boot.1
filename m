Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19B9CD5BAB
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 23:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A148486A;
	Fri, 22 May 2026 01:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YKXhgN5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EBB0846CF; Fri, 22 May 2026 01:28:07 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C3278486A
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd3eb594960so808283466b.0
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 16:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779406084; cv=none;
 d=google.com; s=arc-20240605;
 b=RHAC9GL04G5DZXi27TiXYdG0Xvcf0QBg5LHsWlQgcBA1B5PHtcqY8J6vNqAwFTwTY2
 WkMZu/r5xcehIgRSMgmm1jWgcqK4ALxmsQziDxfJYqEaR13ZSKnP5lHNC0PpUTHbwkAn
 7YlYlV6kGdBm+Jko6y85WSkOgPBYom+p4zpnwKGGX/bX968qu+MrKHQ+bnfNMWd4z2IO
 iQ5SXomMQm7rgldHpcQSNVkBYZyqOlwuNj4AWPH/KCgbwGkNSCdlOOGxprzQpSoOBrz5
 Dexpt9Wx7UZClelUn/nI9UAX79Md33QphC4Pmy0j1OhEA+vg7JwEUcCUHOBLws/vIwVf
 tWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gcyAxBRghKE7q8PWNoTJd41/HRxWF+PZAuc4y/6oUis=;
 fh=UkYpimHuii4GqZdH6RdYCPYjv6GSF2hCxymjSk0mzuY=;
 b=R2eJ4l/bUOXRH8wH91/w3QqbSu8pzFyWfJjoKPZVtmENDLbyCODkI3n2YYiXGzJsiP
 l/adt5VrmaSjYNLjM9crlhKg+1zqouZtnVsaXaurjVDE/tGjeXP4ApWxRlWk0v7vs6MB
 0v+6WPJzSqF0I/0PFVppBrzEHrYidjMslkHrcoMIULxVZgaL8njK9qcM7dKIrcHXs1XX
 OycHSOX/nH/ZC1VmWCeFzGHQQRl5qgE1jde75wgTo1CuzeO+G6DGeRRLSAIIvz2QpBU1
 Iahg/ZsCRyaVTwvZGUKqpOxgBtmRiJGlAE0bUMRIJpICUOXHWzuHRNCfa1uF0trAHNGa
 EmCA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779406084; x=1780010884; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gcyAxBRghKE7q8PWNoTJd41/HRxWF+PZAuc4y/6oUis=;
 b=YKXhgN5kYoSS7c7jEt1BdC/hjFR2brbnzoUA+3Laf9M7PEKFBJopRMfbqsTDewiBPS
 SwOgtiXeDQHSqt6SL1nXA+R0sVODGPq1R4ffUaBGDwmropu2RVNs79cgxEPl+VdCY2Hw
 09bUhwCSJPSVHrHTd19n2WdeqHQnkOms5IN2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779406084; x=1780010884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcyAxBRghKE7q8PWNoTJd41/HRxWF+PZAuc4y/6oUis=;
 b=Sf6+1UgF6kfrc5t51LNWz5PN4V3MuOG2d+u1/nqmgM4ZD86xFZ80Y55yAVGKqiOG7M
 efUaEScORHQaSviClIlw23SkASOmvv3qn+3KO/7q0pCk/CbmwuFbUUMfw7HgdZHkRKlm
 r8Z1u/RsmtT8L910jAvoaTX5uxtoTbhaFVm0/frN9Rl5+gt02fuH8UJU7Xw3MbfoSEdW
 dB3KByouZh0Nv0ccqpTKMcpWpPJz5bzUoKzbkWVJhsz42pR7ZL90yHf1FPxq9b8yju+7
 Gl2Fp/W5LFiCKEmmBrRkpJV3pyRSg7t+7cyhpJB1Q6vCV7ILv8BkVSCVaO3O615X2kM+
 hNMg==
X-Gm-Message-State: AOJu0YxGq68PJ2uSHVtNn7IEIwwA/DhNPmwLHZhJWAU7X2jv6C+yYAlZ
 rLPXnqmK91LgVvmJQAJukZF5j3t/xNLJIahKKWJF7IhIi3pp/Dd+UA9z6P92mPcBk25/nPX2HSP
 tD1RPY91Jt54nTxsn/4bVZyZI4mOL6nuaVfa5RTuc2pG2pLyh5ks=
X-Gm-Gg: Acq92OHWMZdzWFg11V77d+z1753lkxnas61wfdkbw+JSYBRAc2JC3FpPTiho1e2MOoj
 vKOrl/Z6oYiMkmUf2ElSolYl6XCweTMwD4wICMzv8A061SGsFQP8mSGGO1hyOkT2vXvFWJySADW
 exLdYy7FwpylbuhsLN9+K092oaVMDr+9BPYSOe4oUJsucqvrsHVlKr3cHh93SMcboioyJzxgN1k
 qKQjzrcGH1/rK9rxN43S9UwWgK8vdF2DN5qfENSskh+feq/Zt4AXMEzmMwdwvkNuwzQ8wTacUI0
 mL3kILZA+t15gMAm9+5yTigwC+Q=
X-Received: by 2002:a17:907:d1c:b0:bcb:66df:819a with SMTP id
 a640c23a62f3a-bdd267cb1cfmr76620666b.40.1779406084599; Thu, 21 May 2026
 16:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260519152101.716714-1-trini@konsulko.com>
 <20260519152101.716714-3-trini@konsulko.com>
In-Reply-To: <20260519152101.716714-3-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 May 2026 17:27:47 -0600
X-Gm-Features: AVHnY4JBkKf7l7ve2gB08yBVaSGYE4U73vgo2_sWXfOJ-rIwwZLZzXAWcL_gjTE
Message-ID: <CAFLszTixPVv7n9sTi+QtKGQ1FcoMmAsLMv9x6bzoqZC6ucpQQw@mail.gmail.com>
Subject: Re: [PATCH 2/5] block: ide: Drop empty bootdev_ops structure
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On 2026-05-19T15:18:15, Tom Rini <trini@konsulko.com> wrote:
> block: ide: Drop empty bootdev_ops structure
>
> We don't need to provide an empty struct here now that the caller can
> handle this being empty.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
>
> drivers/block/ide.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
