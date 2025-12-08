Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B19DD3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 18:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D804E8399B;
	Mon,  8 Dec 2025 19:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FFBDgn1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C511B83B30; Mon,  8 Dec 2025 19:54:58 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A412B838FA
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 19:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c75fc222c3so2392919a34.0
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765220095; x=1765824895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpLERGDY3KJuhipIxbrfzfw1fnHt00wHSdPZ3lujfxs=;
 b=FFBDgn1ErZ8jmQPevKqdZUVGELmCCGm9p3WAwiBrDyabj/N3/V2TEVpUJ/wzoU3ey7
 7PEVP9jFRjiYkmPwqFxycj9o/y+YM+pt05vYX/AALk2aCIEpgp8Xp984mCFLQULmGTbT
 +qBBqzemqmSCZhspW2Gf+tqVQoPOoHK274JiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765220095; x=1765824895;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gpLERGDY3KJuhipIxbrfzfw1fnHt00wHSdPZ3lujfxs=;
 b=T2n9Hae7WXq+5vQRhbXlg+1a7xGM87Czn7j+RlVtJ6C+hGQOWqeDQhG9vSSIXmaPsr
 YCLaXRLxbOTRT9A+keoUaKxp0aKPc3vGAxl/lxFc0fOv5NqPnxjGxSPCjfilM1E1fDe2
 gjBBPSBCgj9hg0bcocnfzJJXw3al1gnjcDfKrqzMPDm5nfJbxgyljL0hHhW9SkhX+/9X
 Ph7atWHkHsT0J80QxdG0lSpoHeOoMdElMRhF8B+I/QDQmul/RPn5ZnltO2hTwVLehJG0
 uH4YJWqFJQEFIDF9S+azVsnAOsOwtitWO/fC/YcjXVPcSVys8suo8XurRmqbZESAPYAe
 f4vg==
X-Gm-Message-State: AOJu0YwrJlwTc4b3uM4gLnYkMJwEqr0C+5rRvK15Sr3Y9pHwbAp1fd7K
 zxLIsEhqzYBJBQTx+LktTToynglSAxrW+Pnqio2vdG2f3J8PvZEDM9jKGtzvt3BAu3QzZl0Jej4
 p0XOQZLM=
X-Gm-Gg: ASbGncsy2bZlIfivPRkGSgzpPdc3HivuDNFPspojr7ymU+SaliEPvUK+J4bHtGNTTlq
 821I2z9PtiAbtJxsRCzLHSsISs9oXDkzmswd3TIKJvrjoTiRjBD8uWkVzLLPWyRNyV7liGvxAqJ
 cCcV4gFWqdupTZVnYVZjMMy5G6iruWuz8o0J7miwa76SynMpmnX34xImBkBNnNCh9jhGE2kVWLF
 +rcT248hzIkL2vIk+pPpud8248qQAv/WX5ZLgtvbLpXMWjQDdL6HjZNovvuG4W7g2bM+I52jb9N
 Ziy7MeEiD4tter3bGR1tGnH/SwkwOmct95N40MNEwxz8+iwQ20bi6ZiJq1XZzP4DecRPqq82nTk
 8Gcw9GYX5n3XXfP6l4jcdjMeydPItCaj+s72BomhbNkHNXC8+PL51cMrGdUjL2twRXOqpEC/ZmM
 Fa7k2eKxoAjzqskITKKxuGE8gXIblPOh3b3uLt7mSZdPlBiNOa
X-Google-Smtp-Source: AGHT+IEayOCFYTMVJ34C8VMJaUR5f0Pf6aM1BI9T6a6UthTCzpX5av83mnJG7NR+IauF3kIHpzmXAA==
X-Received: by 2002:a05:6830:3486:b0:7c7:7882:8ec6 with SMTP id
 46e09a7af769-7c9708c2831mr4393898a34.36.1765220095420; 
 Mon, 08 Dec 2025 10:54:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a91eecbsm10890864a34.11.2025.12.08.10.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 10:54:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@amd.com, Michal Simek <michal.simek@amd.com>
Cc: Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
In-Reply-To: <448e92ada514c3c043838404ad063b275b1619ad.1765202062.git.michal.simek@amd.com>
References: <448e92ada514c3c043838404ad063b275b1619ad.1765202062.git.michal.simek@amd.com>
Subject: Re: [PATCH] arm64: versal: Fix LTO for mini_ospi/mini_qspi
Message-Id: <176522009462.376851.3859572695700607355.b4-ty@konsulko.com>
Date: Mon, 08 Dec 2025 12:54:54 -0600
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

On Mon, 08 Dec 2025 14:54:24 +0100, Michal Simek wrote:

> With LTO enabled, mini U-Boot was hanging during reloc_fdt().
> The initial stack pointer was placed too low, and the FDT memcpy
> destination was carved only 4KB above it. This left insufficient
> margin, causing the FDT copy to overwrite the live early stack
> and corrupt execution before relocation.
> 
> To fix this, increase the malloc heap from 8KB to 12KB and raise the
> initial stack pointer by 4KB. Together these adjustments increase
> the separation between the early stack and the FDT region during
> the pre-relocation phase, eliminating the overlap and fixing the
> hang on mini builds (QSPI/OSPI).
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm64: versal: Fix LTO for mini_ospi/mini_qspi
      commit: f2c148e0df3a50c74130b4cd0c9bd3d02ba375b2
-- 
Tom


