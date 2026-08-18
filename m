Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26A2C5DF74
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 14:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1466980984;
	Tue, 18 Aug 2026 14:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T4zP0yvc0jmp; Tue, 18 Aug 2026 14:04:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B5E2810E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787061848;
	bh=35J6xTJgNgPz3k0Oi6jzZjKM+du6xTLJMIE/QYEfJ1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RLg3qEI8+0zfDSD0ZWuE7nMEGEjjaj0/75q6dXVPfOmClfjkobVKonkSKASixW9NG
	 FT6FdOLO9x8RyEUg+R7r+yaJTr0EKq/FSvUUssr5KRdblN/CMQQVqYCPgav+e1vhiG
	 46ZHBgUX9kZGEL0hBzIoBXyap4USRxr/ZaNq54S9G+A1HWzu+kG4EnfQQRqNfY92wt
	 faWiF/JjftnRtVoKlN7V6d3plAZbC8iKlBCUK3l+D6h82FQZ672R6S/lrQmtTO0fc0
	 Y63oOB41TDLvr6G8qlwvaqwpWEeIYLVqfL+TSwfRRGNXjTb5WO+nCgCV8OhlM5f8/w
	 RKUfAHwX0+Vow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B5E2810E0;
	Tue, 18 Aug 2026 14:04:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D9DAC237
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF67A407C7
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:04:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2EN5focONu72 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 14:04:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 17DA240768
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17DA240768
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sJ3y4eo8
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17DA240768
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:04:03 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4af81963f35so2928797b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787061843; x=1787666643;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=35J6xTJgNgPz3k0Oi6jzZjKM+du6xTLJMIE/QYEfJ1w=;
 b=sJ3y4eo8YEEntnJMAmkXZbIUPcFGdNrBEcPSmd4sMbx3HGTtkjmHTWcCJnaFX7dVFB
 PVB0EfYMLr/ugNhJWSf4sRwGUgLX+9AxusQJIjQ8kg+XxttER56y53PTi6HLptZhe6Es
 vukQK+Wh4j7w0/Wvn0NlH3wkhl83hbM+U/lIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787061843; x=1787666643;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=35J6xTJgNgPz3k0Oi6jzZjKM+du6xTLJMIE/QYEfJ1w=;
 b=FYZN/BR+MWmdVUdIy2EnYNW1B32fnm0awcpDcSoBehq4a2wzE/w4LpAt7IB7NaQfrW
 xWHwW7Rgllvw/kK+WGCipEdNiZzMQ8lZSd8LtEhg/Elfe3nT5/AYpjEv7zm8yrj67yN7
 7VHgzrHks0Xug6UsZbwprqwkPBmcGLA8aqT+SOCyZy67dn5Vbpd4h15IbwUUBiO61W+4
 De4RAC3rpVqGwOK+hbHc+rYCiaXfAjEyOpW2eGkZVi34uc+uqz8Iw5Ub6Dz5wrmPG/ms
 CEOO9r4slFx0qIvGFQcNsbfEUqITIMFuP/iVLtvNNHDrdDnQ8VQgc3EI4lpbiDKS6GYZ
 H1Zw==
X-Gm-Message-State: AOJu0YxlBlrsVLyngENECUsmiyTtAls9zQMoXAoQOaYq3HdcWTJvSVAF
 9lK2Ah94h0f2reigZ60QXMqS+nZikT+1caaXgtMqTMN1RtWECAYd8jMuQy1XBDvYFbw2LN/Tx/8
 BSOG5Gtk=
X-Gm-Gg: AR+sD133Q97WbzMgBGy2/UA9MP/TPtxcogpmOk/bmv4KURBs0fCTx+Yk8TJYv22qhaF
 YxKQ+RZ7bbSJW7Xk+zDDCkLPPQuBY5jyTF44+AezC4YMjrqyBzzCNhwVrDsMDsZIlSdvnqUmt+k
 2pHP3s6ISrlTI2dbRlnGGXrrpH5GyIk3Kja+HJgNuHu82xmKy9c0gQvZGtr+jwH/FP9YVkad0ll
 Qg9fslycvVpU3TkS5k2kIGjff3i4cN61YC5/IJJUc1mRbmYdlqAadLSc2QJ8wLzzhDjM7tjDCy5
 MABu+uhj0TPMss15PRd0yJ+DKku4wuO1g5VrNm0H1E5l60kERwGzOqMgBoVykbgWf8gfWNEAJsH
 oNgzjii1+UDBdh3R9B7AdhSu6jvbFpU30CajVozBZ2O1fPpP5YtgoL0UcjuO+7X2vEkEMSK+pZ3
 T26+V5VVHompDB6gA5ltCRilzSYgtLXSJsM3VAsa1Im/ewSul0CjpM33mpgumiD0x5nTe33Bn0c
 V81CDcWix7+eMaNqU19g94IYfSFkJHUcZQWsOinmUgHa08aECWaaWg0NjLmgxupocWmPxe+N9sx
 1d2cvs7Jcs+NPjzBHI0=
X-Received: by 2002:a05:6808:c1ac:b0:495:fb79:7712 with SMTP id
 5614622812f47-4b297213a80mr7757790b6e.0.1787061842750; 
 Tue, 18 Aug 2026 07:04:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b296049275sm3388222b6e.12.2026.08.18.07.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:04:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260810204828.2836359-1-jonas@kwiboo.se>
References: <20260810204828.2836359-1-jonas@kwiboo.se>
Subject: Re: [PATCH] global_data: Only include driver model fields when DM
 is enabled
Message-Id: <178706184172.660775.6342474262088959100.b4-ty@konsulko.com>
Date: Tue, 18 Aug 2026 08:04:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, 10 Aug 2026 20:48:28 +0000, Jonas Karlman wrote:

> The struct list_head dmtag_list, struct udevice *dm_root, struct
> list_head uclass_root_s and struct list_head *uclass_root fields in
> struct global_data takes up 24/48 bytes of memory on ARMv7/AArch64.
> However, these fields are only used when $(PHASE_)DM is enabled.
> 
> Guard driver model related fields using CONFIG_IS_ENABLED(DM) to save
> memory space when U-Boot proper is built with DM=y and xPL is built
> without xPL_DM.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] global_data: Only include driver model fields when DM is enabled
      commit: 41541f47a3af93d76d63c2d6d1f1c859fa3dd61a
-- 
Tom


