Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD285606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QVru0+lD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EXMND43/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C4EB6065A;
	Sun,  1 Nov 2026 17:09:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZ36rb_nFt1g; Sun,  1 Nov 2026 17:09:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9324605EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793552967;
	b=RlNzv191h999HcT696Hl/m09y9b677/rF6M6GBG3U5wWSJ3Z0oG/E1zTZeuOAeD0am7r
	 Q09iQhiehTtPtbYosa3fblv63f8fW+j5ojQSE8k3TjFxg0XL1Rg/eh3pEPa0fvgzJq+w2
	 iCoSlCdZk6d59JGtkj3pvhUeytmAFNDKd0pY5vM1WDTrhrwXqyv+4goXa7RM68YfaEbqw
	 YsuKcDzyn1oVg1WrYMJB3XWofYB1ebLmwXX+iDzcU2YjlnoAgjvvr/3I2o0zCQRL9vmpc
	 dSaIm2P7+b6Ts8yFJF1yACtMK7Ygn32DC8NgHxp572nA0wl9Mg4wcdsC8ufSg8t1V2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793552967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ohuNS49JhwD8brDBr5pd+2lFZYohhXi1H9cGaLn2XjA=;
	b=r6D3HF1JnbvW6teBgs+SVwuEhVuwFzTAuTy/iPbLcOO9Ld9TLdg5WWHBjhywvDS2Dzv3
	 tNRAtEWGEvirV1T+SnoVYu/Teq44V4l48G3j8ctihc62ewSRAxRJZs3XwQ7OXInhmFZIm
	 ZF5uqOIuNGKp1MUV0pgpRe+lCpeySaHWzksjdJRJABt+hSn3ie4pTmoKClXgZW1cAXscb
	 hGnZif1thL73I/W0Ae5n48NTjzT+OocuaKJHCQx/xM3xWXzDhoP1ruqbkggwQdq70LU1+
	 mt4l/LfxnOEtNgNccVAVlW4YwoSIIjJwjlO6oJ6XeyShs8g/bOqqtQEpBbuoV5PHBkg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793552967;
	bh=ohuNS49JhwD8brDBr5pd+2lFZYohhXi1H9cGaLn2XjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QVru0+lDDlndWauXNKg90OPGd7kdIZ3DdkQe+tbVfQEHCzLijC7r3KssyHycMOJGH
	 tQVzfOYIoNX0RsZCxrcEf08iMXQdTSnAWw7MTYKbeo3+u2LEfyohO7zcyGOc67Ppad
	 W0wF5L/MP9xy/j6jHKa1kNe0o/IP6SsBYmZNmiYk9LftRwDU2TPfZQiwbZeK79gJ8m
	 +WPmGguNWutyCT4jhC1c5LyAI6PHOuPbxiN2DEN9o+qkdB4MuabnM5yfc4IzwJuEed
	 wQDVqibSqPGrNLHpE6owWBLkeV3mbEem9prd4fOG0MHtCWKcFovtSo3KtPa8DmL2VS
	 I51jSFlaVIKVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9324605EE;
	Sun,  1 Nov 2026 17:09:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 999EC380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A42080D47
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:09:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wK0FOuZLu6q2 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 17:09:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A940780CF1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793552965;
 b=DKT9oY0+GYfQUm7UYV9CIN7OKs9EzHJmWLBYgojjballbIfHBar3GhvE3vfN15PmikAb
 7t5OMJC+iimo14VB/r0WvrxOdVXbj8c3Lk5aw67ZF5GjIQ4MIXsMywadrrW9vJJ5NUceB
 jfFMyyA+kl5IbATOJLyyjVtwaw79iIXPm+qbqMDtbms2auQM7AhkanNapSfSgzH66lvEe
 mR6/yZF+yoo0S3AyWrms4JzopACCb+XtjSOzO3nKpEDfrZHuLTb+UbsiJnkF2Fy8rZPVi
 +Qhn2B4NsExMrN1/gYUqKVk+sk9VY0ub33p28u85hnWKna+wFujbeedv2XxJIje4UBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793552965;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=ohuNS49JhwD8brDBr5pd+2lFZYohhXi1H9cGaLn2XjA=;
 b=iDUhiNXwBDn0wMx5cGdpoWwB67Z3HJYdna78EVBJvfYemge1q0Bv5UDoJKRF1fV8OEia
 R0E63vdXelJ9qg9uS5endf4E1V6rK5vafW+nYWFci6+jfSPIV7IIZQIo1dZAPQerSiuLN
 qyuS+byo7S0FNStjXl2+jXr8BdYXQNzQJhyjfQIdk8akYaM324jT2O1/jl1W82cFlkRdF
 mdCD+wmlo0ZLpcsfwyW+LFnSMjXUjkZ/K1AoPWctFXGxeJ7vAtITwDG23/KUnPIwpOyfh
 Bvyxz85wtBU8JVxBnO4WPV4lYJQk5BR0RARdihKLxu9pi5bN+C0o9WyS5Wp1mroFfHQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="EXMND43/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=EXMND43/
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com
 [IPv6:2607:f8b0:4864:20::132a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A940780CF1
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:09:24 +0000 (UTC)
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-36a2551d7b5so4273867eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 09:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793552963; x=1794157763;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ohuNS49JhwD8brDBr5pd+2lFZYohhXi1H9cGaLn2XjA=;
 b=EXMND43/qx7NqLrFPrJ5uFB0ZalG7EbuhTgEdWNKgGVvT+FHzvL0b6ZjY2sK2tA5uu
 w88djlbiyrnwvO0OSBIwuGLBxDeVvvONnk5EKkvM+dZFJfXBANka9YueYO0S8yBKuUjl
 fV5uIe6GcgQzMWRFfhHHCMPHOHGExleTCFP5ilVlwTKUhp/X/Pp85T6E+ES4fHJb6ahj
 sRKLImPGmfR9G4VcOmfywUKQn/Wt1+mE2E/J2+Tu8RPVuTrOfe29TFFIvSqLge3HSJIE
 GWn//I/SawodpRSWEaH3+FyiE1XTAT1qQYaLXC0sN/WCQ2Gi3pISUxuG/zhRxbhP5nCv
 TICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793552963; x=1794157763;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ohuNS49JhwD8brDBr5pd+2lFZYohhXi1H9cGaLn2XjA=;
 b=kBuUDEAG2uQ4dVsDHEE0c2aPaEacZCNRxhwdI8wXYo1lzB6+2doYKrLTbdpG/Te3jp
 0bSI8IMri5x6Ao5s5rzFtWu7QXEhyHXk2OxCWpA5LAYrMVl0Q9Pfr4AIzGUPNX41u2gG
 Stysn+kg14kg0al4B69uZGEc0j+JPocODObbVO2IGxz7H+hSEduJdrPTpcADpen0VkVY
 64Lfucnw3ZutM6twHSyHwAnrhEUC/s+9iuqFAH8ber4LopFsNdUhJ21jsfxOHyKJRYWz
 gP1MWQRPip/VTL4IbSry1Y/PcEVD+zXZEpKC+o+AfQ0RRjQQEAU7OCDx1lBTBNcBd/zs
 jhrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwx/9K7Cf9XrIba1E9CMKTkC7e8pI/V5I9Il5ldNnESb/UVd38n+c9FTNnBEpyRsFCJtfy24ek=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJP/gVCJqXM9iAhD1P34Hi8j48fOWNKoySHUSEAri+H+bEZnIjX
 JW3CwDEdXT9Ztj5j8kYtjtqBXZB15agV2YRJBCUyvBU8yd9lMmtMHI2Q
X-Gm-Gg: AYBFou2c9FoqoOZ6ekftRLHlsvuMsFBA5AvbqshGYFpeKhyJea3TCAJLTOtP8hzXIIM
 Y7zbpJhF8d0AnvD7j8sgW2vIoEW8jZtrkdnUlFvMw2shd8KHSDss7XL77xL5d9u+9U9pBUWhCyS
 3JtqZ6uZC3FY2Vqpl3IcFS3q0+CsAypliE2Z1KrXcUluRc9pCtbWh1mJUQeibVEI2YDATO/HQJX
 ub/OBFcmJNfm2sE2Qez34zhQTI5E8lZ4AyGcv19hYz1alm82AIXkUJ7sWmfZwEqGkL6s35T2Rnm
 lyioCmoDLSNHBrsyvDZ/3cjGqGiKEWMANE7J7H7glglj6k4d9AQmOTKp8oE26VuSe5A6VJ+BVlZ
 6ePZSWINw4IEgiAjcMT1W/5su8hujZV5kdXKbjj/EiLdt054FOvGuYnx3t7dxarfNGq8A9c5RPf
 2gOPlhlOs3lKuUw8lj5QaCjatEMFGUwes/mCBuUDp9mcZmeY4yn6AHQpW3lME0zLr+yc+yXwSli
 W5xbutZPzdNm8wzzxC78wRAuLaoQ7MiM3ld7zsrqdmTBlJaT5eO8PEihTOd14xfIPz50qaDx1oI
 tTTUl486leEmhWpCeLCyRv2L1bmu
X-Received: by 2002:a05:7300:3b05:b0:369:e8a8:b9cf with SMTP id
 5a478bee46e88-36a3002ea8cmr21714344eec.11.1793552963380; 
 Sun, 01 Nov 2026 09:09:23 -0800 (PST)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a61a0csm34138014eec.22.2026.11.01.09.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 09:09:22 -0800 (PST)
Date: Mon, 2 Nov 2026 01:09:19 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 bmeng.cn@gmail.com, trini@konsulko.com, xypron.glpk@gmx.de
Subject: Re: [PATCH] doc: virtio: Explain how to reach the virtio RTC
Message-ID: <audyP93uq7UvRDUq@google.com>
References: <20261028102343.1747940-1-alan.tseng.cs@gmail.com>
 <20261031150207.3315527-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031150207.3315527-1-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 11:02:07PM +0800, Hung-Chun Tseng wrote:
> The date command only uses RTC sequence 0. On the ARM and RISC-V virt
> machines that is the PL031 or Goldfish RTC, so date never reads the
> virtio RTC unless that driver is disabled. rtc dev does not help, as
> rtc read reads raw registers, which the virtio RTC does not have.
> 
> Say this in the virtio documentation, and that x86 needs DM_RTC.
> 
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
> This is the follow-up Simon suggested on v5. It applies on top of the
> v5 series.

Why not send this as v6?

Regards,
Kuan-Wei

> 
> In my reply to the v5 cover letter I said the doc would point to
> "rtc dev" and "rtc read". That was wrong: "rtc dev 1" selects the
> virtio RTC, but "rtc read" then fails with -ENOSYS, as the driver
> has no register access.
> 
>  doc/develop/driver-model/virtio.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
> index 30df0e944..94d3dabbd 100644
> --- a/doc/develop/driver-model/virtio.rst
> +++ b/doc/develop/driver-model/virtio.rst
> @@ -81,6 +81,14 @@ on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
>  The VirtIO RTC device (``-device virtio-rtc-pci`` or
>  ``-device virtio-rtc-device``) requires QEMU v11.1.0+.
>  
> +The ``date`` command only uses RTC sequence 0. The ARM and RISC-V ``virt``
> +machines also have a PL031 or Goldfish RTC, which gets sequence 0, so
> +``date`` reads the VirtIO RTC there only if ``CONFIG_RTC_PL031`` or
> +``CONFIG_RTC_GOLDFISH`` is disabled. ``rtc list`` shows the sequence numbers.
> +``rtc dev`` does not help, as ``rtc read`` reads raw registers, which the
> +VirtIO RTC does not have. On x86, ``CONFIG_DM_RTC`` must be enabled for the
> +driver to be built.
> +
>  Testing
>  -------
>  The following QEMU command line is used to get U-Boot up and running with
> -- 
> 2.43.0
> 
