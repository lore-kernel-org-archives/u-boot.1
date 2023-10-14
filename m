Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D086CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A2D28691E;
	Sun, 15 Oct 2023 08:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mjkgns3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6954F86F23; Sun, 15 Oct 2023 08:30:19 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09C986E47
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77575233633so252354185a.0
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697351323; x=1697956123; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CvmZTk5YTi7gnPGDGI9sWYuu6pT46H5qOElQH1AQeug=;
 b=Mjkgns3HnmPcaL02hJ/z3BTUe1CC5bw52vNl52MuRVWRf3o4WwZCuZ5vrCuEgqtkDN
 z2FT6q68WZRPgXCZ+lbDU1AQM3WUgxY+a3FwVAYbIfN7WNa7Z7pL1+KoR6xj5DROA+D5
 sp+wNla9c8I2QszwiytG7iX0/aLYz5MJRBVOkjXVCcu37etSbvFxaW/P43gW/DMXgTRW
 5jEKSynHC3D6VwEUurveS2kVMvuXbpOajQzJEZtpDjCQrFal6LqrLrKvRVr0qIIs+fHY
 dTUN4Vg59arNn8nWLDWEdx8EMkRS1xGP8NBuBixzndhGdgxKgVkRpp/XrPE9EZMqm8QL
 q+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697351323; x=1697956123;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CvmZTk5YTi7gnPGDGI9sWYuu6pT46H5qOElQH1AQeug=;
 b=aqB6gi1Gd3u+IFUU7B/X7cMk9YCi45TI7WlXfz9Cal5VR3YD3/hVTDqMykqkNnQNKI
 F9HghuP7l5EUfEeNXQ2qlJGnSu4Xvd2xy6ump+NBXxuxkV1wCsJZFR0ynseiS96v6XhD
 nkU/qXYzv6dcZdMeFzEAVXmwxeMHILtqHIm1nPxrSDOt2E2FnXySViSnXlaCZbq85u7E
 F31UIU+DZqeDdCUxT9UIkVK2s5cYxgaomsJSNu66W17IICL0fTGKiXmnMYC2vn+VFhfD
 tOO8nG+rSzSmiPuTyVMk/oiJAPKEmumUa0xpt8xLk4k72EchYU3jKwp7/xcqMyCxDrIK
 5bWA==
X-Gm-Message-State: AOJu0YyREyZBZ+k4pwDDPGfCDN1g3w4iwo0WQIbs8Gkl/bLsxdiR/kiX
 28dh2Ohgi5T1AmNmUWr1ic93Rk0t8wKD0Q==
X-Google-Smtp-Source: AGHT+IH6aSTcniFzB/zHnyUqYUT70MXhrk+biwAReg3qjOncf87Aoq5yOMDc78r5LKEMJNfBtVnE5Q==
X-Received: by 2002:a05:620a:7e9:b0:773:b2b1:6f62 with SMTP id
 k9-20020a05620a07e900b00773b2b16f62mr28220584qkk.34.1697318655200; 
 Sat, 14 Oct 2023 14:24:15 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 m15-20020ae9e70f000000b007742218dc42sm1726212qka.119.2023.10.14.14.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 14:24:01 -0700 (PDT)
Message-ID: <e5d6293e-d855-247f-4b70-eaaecfb7f651@gmail.com>
Date: Sat, 14 Oct 2023 17:24:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 12/29] fs: Disable sandbox filesystem in SPL
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-13-seanga2@gmail.com>
 <4D6EDFC2-8A1D-406F-A492-3F1715C23731@gmx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <4D6EDFC2-8A1D-406F-A492-3F1715C23731@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/14/23 17:14, Heinrich Schuchardt wrote:
> 
> 
> Am 14. Oktober 2023 22:47:48 MESZ schrieb Sean Anderson <seanga2@gmail.com>:
>  >Don't bother compiling the sandbox filesystem in SPL for now, as it is not
>  >needed.
>  >
>  >Signed-off-by: Sean Anderson <seanga2@gmail.com>
>  >---
>  >
>  >Changes in v2:
>  >- Disable sandbox filesystem in SPL instead of compiling it in
>  >
>  > fs/fs.c | 2 +-
>  > 1 file changed, 1 insertion(+), 1 deletion(-)
>  >
>  >diff --git a/fs/fs.c b/fs/fs.c
>  >index cfc781bbb8d..4cb4310c9cc 100644
>  >--- a/fs/fs.c
>  >+++ b/fs/fs.c
>  >@@ -237,7 +237,7 @@ static struct fstype_info fstypes[] = {
>  > .mkdir = fs_mkdir_unsupported,
>  > },
>  > #endif
>  >-#ifdef CONFIG_SANDBOX
>  >+#if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_SPL_BUILD)
> 
> Why do would you disable the sandbox file system in SPL for CONFIG_SANDBOX_SPL=y?

It was never enabled in the first place, since we never had fs.c compiled in SPL
before. This just fixes linking.

> I cannot see that this is necessary to enable the unit tests you are striving for. Instead we should extend the SPL unit tests to sandbox_spl_defconfig in the long run.

The purpose of the sandbox filesystem is to test routines which use the filesystem
API in U-Boot. However, there are very few which do so in SPL. SPL_FS_LOADER is the
only one I know of off the top of my head. However, FS_LOADER is tested in U-Boot
proper. I don't think there is a pressing need to enable the sandbox filesystem in SPL.

--Sean
