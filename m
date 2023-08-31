Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2CEC83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 00:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E0486546;
	Thu, 31 Aug 2023 02:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l0gg8rIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD8286547; Thu, 31 Aug 2023 02:38:17 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2067B864AA
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 02:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf1876ef69so572865ad.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693442292; x=1694047092; darn=lists.denx.de;
 h=content-disposition:mime-version:mail-followup-to:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XQUhbbz79+heSXFS2wnp964esnZ8s/q5BRPQAWYqXYM=;
 b=l0gg8rIqrkiUETczWa9ztTqXVTjkWKjNko9CyHmwNcjHMKiFo7CPP9daQGnd91pp5O
 7XVnbvYCD5S+ZTGYn0sK3Oyh4+b1ZWxZ1BK1YOcmQwox/7atAQRqcnJu9dKxuRBjTLHU
 aRBP3F/7NsRTOAZbTZlHVW6Gy2ewnowX0xbMCQXLaTh1YNtQQPwrGuhcHGv03OZrJqBp
 k1vlW4jlAVmnXJGVXORSomAy+whj/gIwkgD97V1LfjvwmcG0BerkDjG2aZnbcsOg9T8P
 ohWnZYxxkOfTdFEAbo6t1dgq2MnVpE8uArSPmqix374gS0Qm5MgQp2Ansb2QA3294bkv
 bFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693442292; x=1694047092;
 h=content-disposition:mime-version:mail-followup-to:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQUhbbz79+heSXFS2wnp964esnZ8s/q5BRPQAWYqXYM=;
 b=dW4PAGYaYhLdBIl5KVPNxEXjFb5m4EHCs+nk2hgg0LTrEQR0QOQk90ca9ClYpfKZGD
 qfg7A+Lmfl2zuZCKV0c+wB0Qg9Y7L+xlH/p0w4pHZves9JPT9ScsNYuZcRQYX16ACuOv
 5qm10tf0VWOGlyTk6kll5aq3DEEm0qIU4Otm9YKTTc4XP27XAGugeqGmNq6j1vIHNasu
 uooTJTys2u7lAevu+FpOGTIE/60xJbkSC5vfPuKDk5SHL+O+oDDpcSD1o0SLNYVLPrYe
 4G0VugIOqYuNkPDmILtkSKTs2hSmmH3v7mobv7uSge6VObTUFacu29rJB7CvqsXdxH94
 fd4w==
X-Gm-Message-State: AOJu0YyAjPmoQpNqJy3d7iMIXqjPVLf8/I3ent910bTtSLxv6m3/Nib1
 YmgJq0c0yxDktdl+7ODLlskPmIA/IVNOJw5WGjgnrw==
X-Google-Smtp-Source: AGHT+IEijIUjBIQnxeOORpFTJmWZ0lVtbfYFdGR2zX8Ziq9RCUPKtZHmgOSqZZcRgJeabXbbrv3n1Q==
X-Received: by 2002:a17:903:32ce:b0:1bf:1a9e:85f7 with SMTP id
 i14-20020a17090332ce00b001bf1a9e85f7mr3943920plr.1.1693442292241; 
 Wed, 30 Aug 2023 17:38:12 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:15e5:d5f9:7b14:839d])
 by smtp.gmail.com with ESMTPSA id
 iz2-20020a170902ef8200b001bb9f104328sm92300plb.146.2023.08.30.17.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 17:38:11 -0700 (PDT)
Date: Thu, 31 Aug 2023 09:38:09 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org
Subject: [RFC] make sandbox UT more generic
Message-ID: <ZO/g8T1ohHI23xM8@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 u-boot@lists.denx.de, sjg@chromium.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi,

I'm working on implementing SCMI-based pinctrl/gpio driver,
and want to re-use sandbox UT to test the code. However,
It is somehow sandbox-specific (with additional DT nodes).
How can/should we make it more generic for other targets/drivers
rather than just by copying the test code?
(I have already created a test for pinmux since there is only
one existing scenario, but gpio test has many.)

Even if I say 'generic', my case may be special since real
hardware (device drivers) cannot always run all the test cases,
while SCMI-based drivers potentially can with a dummy SCMI server
for sandbox.
See:
    drivers/firmware/scmi/sandbox-scmi_agent.c

Thanks,
-Takahiro Akashi
