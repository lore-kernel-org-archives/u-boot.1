Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CCDCD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 20:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC02A846C0;
	Fri, 22 May 2026 22:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pPsWk0ec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 344608486B; Fri, 22 May 2026 22:37:53 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F4C8469F
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 22:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4855e69a5a4so411513b6e.2
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779482269; x=1780087069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/RkSVV92cjm5VkiuPE21fnnz1WwSQGPw8pHGYgqn4yI=;
 b=pPsWk0ec3OmDgRWa5f1e6zJqHb4khlTyUSHmURvDIKwvAZycHCCPFJqoWJ+6HpDlU3
 MvN0dLNihL055CET8nUxmkBlmn5MFPorOwetXisGXuvq1jEenOU9ScWlqigOb/a/nNQZ
 LVAbMPmqC2XsFeo2JjOsgY8Rqbi4Otp8bJaco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779482269; x=1780087069;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/RkSVV92cjm5VkiuPE21fnnz1WwSQGPw8pHGYgqn4yI=;
 b=RMQ4wwNxbUjSRUo35ZoOdoDTAUnNIlnFJ1i4HZhZSv/2S3H+o5RJyBhP6x38QvXkBW
 TdrL98/j5Fj0YFpPWivrloFNTHwzCJMmFuweVdKmqHIO4b++OWMOibu5pfZmhfQ1nb72
 C1jJ8dZR1qDf0NJfW5i88GzPDTBKq80Qt/KNv64BLIOJ8kwMZjT4jSIiHz6xD94X5nF8
 Ij0aOpkJZGe3Rh2hPegXRiPIe4bakmbFXj7G0S0SCqJ2ErsV40czidVcVYskeJdDTiKZ
 4T7rYqeWeRWSu3JGKgUhMymUaaU1XT8s2wfsgmSmi9xugAtv6qfLKSXFdOa2cS/j5E3x
 JYqg==
X-Gm-Message-State: AOJu0YwTHLWUIWPZC9P5Ong74RivSRAGdSPvwZVS7UFO9vLoKm6y9tEZ
 vrosGMQt7KYupUe/gKTC8MtpkYfTQBYP+Dy01w32dyFyzqgfpExUeKDJsZ9+pGYGxCy+JC564dm
 r0tWKSgI=
X-Gm-Gg: Acq92OGL+M85A1rKUG5b1jfY2MPEEFdeUzhOjxr9nf2jAJN+gUjyvWUmD/2T1jD9EP5
 t28D6AS4kGcxDjc8lpTL6WclCjUn+QZDB6VUKmbWLdVLH+rEaD80dQw92YMrMr/oV8w61aqTAwK
 ujCAv43TNz4irebSgcsHbtY+W/asIXhupF7c12VJN1yGeJYx+x08zZkEyS3ApMCD+0J+XqbIyiH
 dSQCL07ic9WhEOUaOIDVgi7kxvRTkwzTV2LRNdT4FGLInynE/O43Aw1PE1lwILrWlsrrLyN//2V
 4jZIajguVp2zsyaMZCLOK3BMk2+o3bxvJWdaxWkcYFTWKyjlgE2FG6RZYVJwJdFwFm7aFhLYghi
 xJ+XeljeBPrEOnEB9FwnXuYbMKoKR5ydNuQe1/5oLvdO2La4QLm50eoOp0PerX9ond7oXZytbWE
 WpV9B8XjyvAP9VdqoYmwd1TBlgs17e6GsGdUJ/3EjTMTOaV+YpELPUG7bSx9ZSFfxXjV1VkV8gZ
 U2pQCzmPjCpuGZ97o0qeJTUhlBqOeuTwSSv9UqkuPWI
X-Received: by 2002:a05:6808:17a4:b0:47b:c703:4231 with SMTP id
 5614622812f47-48549d59db8mr2754365b6e.16.1779482269547; 
 Fri, 22 May 2026 13:37:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm1090456b6e.17.2026.05.22.13.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 13:37:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260522191319.18644-1-marek.vasut+renesas@mailbox.org>
References: <20260522191319.18644-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <177948226869.2493596.7912425796189280973.b4-ty@konsulko.com>
Date: Fri, 22 May 2026 14:37:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 22 May 2026 21:11:34 +0200, Marek Vasut wrote:

> This is Renesas R-Car X5H support for U-Boot on its RSIP Cortex-M33 core
> in addition to already support U-Boot on Cortex-A720AE core. The first
> two patches also switch X5H to OF_UPSTREAM.
> 
> The following changes since commit 744cf5d4e398c5f657e5c3eeb44d00fa5175dc85:
> 
>   Merge tag 'u-boot-dfu-20260521' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2026-05-21 10:26:29 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


