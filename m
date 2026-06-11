Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6504BCD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 17:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896498407D;
	Thu, 11 Jun 2026 19:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T5g5zyg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6326784664; Thu, 11 Jun 2026 19:54:01 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D6F3839A8
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 19:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e6b571750bso117865a34.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781200437; x=1781805237; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOuiJrJHJMOAjttDq/5jTqUnvZ7Dhnh6uAWxAGCOqoI=;
 b=T5g5zyg6zHopP2DQMMDfvgTnoHTVWrGiqZI5Ji0Ae1FYw93dWFkg5V0ozhUECo2ibT
 74GvVcdZCwmeC7w4QogN4Bc5csRy7UwxhRWF4ruCxXX6ktlEcPHxjfSoRv9dLCL4m+v5
 +KSV2ZQ5V+xVc9ldLt5wbu4+93/VOh4sm3RLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781200437; x=1781805237;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tOuiJrJHJMOAjttDq/5jTqUnvZ7Dhnh6uAWxAGCOqoI=;
 b=hdBVP1EabZatKrcN10UmJIH8FFKDX1kwr5HP7lJ+J33t3AAS1eX9OUy1OpTFyjXrP9
 RDGQCZRK+Wx5rYTfVBNCXKDrG6Nx0B31BlJ+WbuRZw8Dlh03sc3lKOJBARLBNwxba279
 gX5fEheh1f4llFNGZSqecyOat5FStjUu2Q03UyTAgBSTxwueCYNCIK42dIHQk9gFVSxv
 lruh8Wzs7/VyqTX2TSr6tNnYcmcs2qZtKHkfEI13Ybjgb1Q4eZXLbp9eiPxsJMXvFAos
 t6GkXJFsNFJJvUetpCOnfrHeFYGG8xYQVxHON4OtlPI0Hn6DCiVdistVHihGi37t3WmR
 7i+A==
X-Gm-Message-State: AOJu0YznENyXhhQ4RxYhKjPZIVygbdu2vWcl8PvrdKSjAFvkHXQmSZLD
 EX0WBxAq50mrszxEgZSv8jAKMeEa8P3ryMd5A8bOYdT/o/eBCRutgRc8gL+1RqaLkvw=
X-Gm-Gg: Acq92OFRDnVAulqNvSsN7Vea4PELSpk6FQB3o7gvfwHzUuSNUdGXkrdsah8+UC2Jn7C
 vTd1pGLowNAupgXjjX6Yz9Ip+ThoEJJmZCbevpyS2ED4wTWnRdGqvTZaQ2fksRdjxcpbIEppqC3
 5/lnCMYQ6YU3b3kdy+INCwlp127jH1amcB3icehPrfaUO8lw4d8xGlhNH1hq6Fs3keHv7ff8a/c
 C2eWHD+j5MLtiUphekYvuGHpmk3IJ0yjh9t4MCO9eOTn7WFLl6NZQ8UQ6MsJhXo/4mbjzB67dnx
 YX/zJzKc04BHOSqZ1gEQ2i/J84CiAKYSfBRMLMg1VzX6RbZ+ksTvfxHNWIIk7488xoH1zOJ3kwH
 wKK6ah8sJzemYfVa9viAF1Nk/NV+QskPE811k590prHNJEqvPGElePnCzbOrH2RdynR6yyfqfaR
 L5fwPBoomPcQ08/Bu8uNDYF8x/mYpXUlUAISumNLZmDOEv7IHZf5o+NaVC/0IAKFmTJiFOL9Jie
 ljqEXH7GCDzPfVSJ86GQoFfyzDQQxZAXZE4IDcs5ZZu9ow=
X-Received: by 2002:a05:6830:3c8b:b0:7e3:d29b:fea4 with SMTP id
 46e09a7af769-7e77359a62bmr3218631a34.22.1781200437706; 
 Thu, 11 Jun 2026 10:53:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e78144822dsm41452a34.2.2026.06.11.10.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 10:53:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260525-core-v1-1-18ed41193b4f@nxp.com>
References: <20260525-core-v1-1-18ed41193b4f@nxp.com>
Subject: Re: [PATCH] dm: core: use DT region size when mapping device addresses
Message-Id: <178120043698.523278.3584886273678253946.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 11:53:56 -0600
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

On Mon, 25 May 2026 11:09:39 +0800, Peng Fan (OSS) wrote:

> Update dev_read_addr_*_ptr() and dev_remap_addr_*() helpers to use
> dev_read_addr_size_*() and pass the DT-provided region size to
> map_sysmem() / map_physmem() instead of 0.
> 
> Ensure mappings are consistent with the size defined in the device tree
> and avoids implicit or unbounded mappings. When the DT does not provide
> a size, the behavior remains unchanged since size is initialized to 0.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] dm: core: use DT region size when mapping device addresses
      commit: 53e9c41847c24b422ecd21421204d4e6a0c07d76
-- 
Tom


