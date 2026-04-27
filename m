Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6468AFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 14:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF5583AA9;
	Mon, 27 Apr 2026 16:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qB7espTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B59483693; Mon, 27 Apr 2026 16:04:20 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED58983AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dcdaf06498so4364090a34.2
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777298638; x=1777903438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mg6g+YRToozEGUn/7wSpKvB+dM/R1gMOfh82CGPRqpc=;
 b=qB7espTnk8fXR08DpbPcfEEtbhKqZRKirOA6iL96UQAEKbHMNV+J97cwMMO8cw5yOO
 SYJ34Z+aw5bumFLwPRjbWy7ESBXa9h/y+fE6NtvavU5W4RFscz+Ref/25+l6YD/WQNZP
 oaB0WAWoxfwFB7jjkuea3QLmGeHrN5WodUJY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777298638; x=1777903438;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mg6g+YRToozEGUn/7wSpKvB+dM/R1gMOfh82CGPRqpc=;
 b=kvOaWvE0Hl/1qM1FJ+rQ76DZUadOixA4RbKUUsJGFdvaKHGfE8G07FcK7y5JajrXB8
 D/0xbY0IR43HfTuDUZO7sIwtnQpHpJGfPJwsiDg06qR0YMSNEdfKexRgVt0pIirdiMW/
 4tNlJPXBhSRQE+eidI/WTj7mTnbhb8BEQqeABxrZ7QUhoQHoJUHcQlbmf/gqPaAIZA+L
 7WRamZeIM7bm3ScBw+pp+VcPX+f8Atk++kHvdkVZ2ppkmaAu6J4E3BPWRpahK1A3jioX
 1rubCD71q62t3/0N9uF5Zlus8E98BUGpDZthPRStU9/WQdOTiTfTZ99zmByfbTqNCbgb
 uVNw==
X-Gm-Message-State: AOJu0YzwFB4g5BMFo5h5vC2sLyWguEbAFJhqz5ydtT3DuBT4IKfGF2oc
 HkGP7vywr25PIuLtIUjXAo/X49O+QdMFZR0YnYv1fHJX0jRJrozHthAGUyfUcvMFwNu1hiJXyjK
 q9a03PDIfa48T
X-Gm-Gg: AeBDievupmPirZ4HnoA2OCdbJMd84Ywn8ipRC9yao7vlfxwDErBvaTXxYCZNsJYaPZh
 C5Im7DrVyjUEhnYvpkpc3x+s3xuOOtlP8ctnh0z/5AuEqNDGGcGDYVrVoqOOaSpoZ9M66lgML7R
 GBQqCFEl4WuOhQ6hAjGbu6wSlfCvv36MQsyKfgIOg1pjjuwB5iQ5DXAebcgImuGhAyaGtR9Uxc6
 fQxiHIDXoQ3M9BuwuS20FDyxCT2F9kop7Y8pCcOcSRVUjhq6pmPA4yNtU4tQm1Kr+YU3yiSn3Hb
 xuAC7BYsmla590G8CtQukiJeX83YeZubnsCCLs3sc/UqbI5A0KgrwjyGQOGfJA1tenxPmq02x9y
 oJCUE+vuTH9r+4uAwEQ2ckZrYmRh98+iFKJ/3PfzKCatSjAGeZTgsErsiIxZIAodzH6pXnoSvQz
 hvcM1RGhmuVVzw/Sot3VC5hbDgPYOr2iipVf/AoIw/ec7nd4Ty4h3jxJ4yzLR/BF08dvLauTmNs
 vxVgGNryw6ahCknjb88CwHJ12Ek2qU3BCqdz4fFQgcYVp1qhsiyveq46Y1Q
X-Received: by 2002:a05:6830:2b22:b0:7de:495a:cf8a with SMTP id
 46e09a7af769-7de495ad4a1mr10894129a34.14.1777298635921; 
 Mon, 27 Apr 2026 07:03:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de72a3c2aasm5616216a34.12.2026.04.27.07.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 07:03:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260426-maintainers-v2-1-aa9a6d5fa6ea@kernel.org>
References: <20260426-maintainers-v2-1-aa9a6d5fa6ea@kernel.org>
Subject: Re: [PATCH v2] MAINTAINERS, mailmap: Change email for Eugen
 Hristev
Message-Id: <177729863485.3442985.250420724792636272.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 08:03:54 -0600
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

On Sun, 26 Apr 2026 08:47:39 +0300, Eugen Hristev wrote:

> Replace old bouncing emails with ehristev@kernel.org
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS, mailmap: Change email for Eugen Hristev
      commit: 53f8419ce4c939d843d852241a0af1f1325e3c64
-- 
Tom


