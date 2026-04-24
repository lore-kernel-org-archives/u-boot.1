Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0457FFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D14284255;
	Sat, 25 Apr 2026 21:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SbPbB4yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 972CA84308; Sat, 25 Apr 2026 21:22:45 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7CC84150
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-8a58057d7baso106716986d6.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777144962; x=1777749762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8ZnKAXLlkDWEbd9R8is152JgwePeEsgzwkCXKl2YNI=;
 b=SbPbB4ycDZMCiCKAUjiCBOYkd4TXxM/7EJWivKKJDP70hQvbeyaA5lS3CK/o413ziK
 OI/8DefjsjqoQPJZYVSNNk/JpMG+CJa+QY/ThgwKSGz31fNr4dAhan8C+Ph4IVXvvJaj
 t9A7HR+Hl6DZlyNt8sxEdRgHW3inuO6OpiuNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777144962; x=1777749762;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8ZnKAXLlkDWEbd9R8is152JgwePeEsgzwkCXKl2YNI=;
 b=qz11m5LY8VomUIsLGs+gCusfrcaBLYj1S9wwe299XwmrG9iiV7wpOcp8wMPRtqNXOo
 OaamgedP78vVHsULP2DE8hb3vr7v/+Ml7odu9lxQz/ccWnP6x/BbWcdHkfFF5ACy6L2p
 kQ2dfukVsS0W7e8jaaw49pDw24yCL6KUBxS355PXcZjsZYe1A5/IxXOVwgXkxocDqW6M
 fRBRslqt+s9i+8w+6GeDviO8esAAGcm0Fka5g4x7a0LOjtHFBgn5uGPt6NCnAaFJ6MRm
 x0wZ136ThMJ27cixUxz3RUA26ITHLnRmLUuFXB5IVKHy2aOEYAvff0y2urbkSe/ea+A2
 ub0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9i5gNrrMn0JtYT+7pM30y6IC7R7ZpmTusv8HrAGkglWZjP0W7E1W5U0/ImQNc4yoCeh4W0VOM=@lists.denx.de
X-Gm-Message-State: AOJu0YwzdvOVbTGfX/OkkAnYXhj+kuIkEZjki2r3IceZb4zNS9e7ZWo+
 j5y6hjUlpeURwtij7s9bIq4qOVbnZFPCYmIApuWdSkntnP/cciVQi05//bO8Foi14uaim2jnLcZ
 86RMmBbUVZg==
X-Gm-Gg: AeBDietES+NSvVn6XhQLbw0A3qbQqqNe2AbgevIafp0IRXinFwKBFmCwxPKTpAUi9w6
 iLm8lcM1klxYlfee2uWZTa39+Rq6DSFkmZRATxwX9/Em3xLX7ro1UwPuolCqvIrjIggnNkpm0xb
 jFA6M/EBKfEKgESDnOMZI6w6T+dnUWbq3wwqKohmpYqcVvAtAK+M46LINfQjHZlOhoZoNAiWZaQ
 GcO9p9dC04VmiUiM2kxe0IbLtwhmuY9Z0Itz/UmAJokE+BtSLPZW8LCe0qlxwxMRciDjmsHw1N3
 ZDNvfr/BsOwQusIqErQbzq3kpXYP/hkd5r0QNpqaRYlrNZPLGfEGyLX4sszQvko77nvxxAFE8cy
 m4ogdXA/VpodbW6Q6n+/nGOb+oSBzvOl10qpWcXBd2anKk3Z1R8C4F2cRT4DZdhCUPhy4XoD4am
 37lPXshFISOREbcEKz+iZf3MNS9kju3g3jeXeXf1EVpL0esIML9fQUOOXNwmBYpieFTqKm+nnuZ
 LNZK9gPCQSXaYqMP4Umi2Jii9aq5vLk6doQwOxOdG1GxGbFXcjOsf86mIyM
X-Received: by 2002:a05:6830:67cd:b0:7de:4f6b:9e10 with SMTP id
 46e09a7af769-7de4f6ba281mr5401892a34.0.1777056654832; 
 Fri, 24 Apr 2026 11:50:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc975034e7sm19832464a34.6.2026.04.24.11.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 11:50:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
In-Reply-To: <20260418181510.51490-1-heinrich.schuchardt@canonical.com>
References: <20260418181510.51490-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] scripts/dtc: avoid discarded qualifiers in
 overlay_fixup_phandle
Message-Id: <177705665410.2527258.6800784302117606631.b4-ty@konsulko.com>
Date: Fri, 24 Apr 2026 12:50:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 18 Apr 2026 20:15:10 +0200, Heinrich Schuchardt wrote:

> When building with GCC 15.2 the following warning show up:
> 
>     scripts/dtc/libfdt/fdt_overlay.c:422:21: warning:
>     assignment discards ‘const’ qualifier from pointer target type
>     [-Wdiscarded-qualifiers]
>       422 |                 sep = memchr(fixup_str, ':', fixup_len);
>           |                     ^
>     scripts/dtc/libfdt/fdt_overlay.c:432:21: warning:
>     assignment discards ‘const’ qualifier from pointer target type
>     [-Wdiscarded-qualifiers]
>       432 |                 sep = memchr(name, ':', fixup_len);
>           |                     ^
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] scripts/dtc: avoid discarded qualifiers in overlay_fixup_phandle
      commit: c6faf583c4c2b237c42b7797794d00424248ea0d
-- 
Tom


