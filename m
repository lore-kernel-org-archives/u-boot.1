Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A894C5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 20:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 497EF60783;
	Mon, 10 Aug 2026 20:53:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dRm6_hfhQfkm; Mon, 10 Aug 2026 20:53:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 993D260778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786395215;
	bh=Z7hY76XxdKvxGILECEhVV/TOpFQK+KrQ41zO1Hud3Vg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J+N1lmbGbC/L1xS9licQDgxF4uOeut5Ama30wGHdblqC+mWFHjfOw72BellAjc558
	 xSZXcvRHQj2AVKu+8E/JLUJnMQkIR8ogIGgZo6jbivUFXimXg/pbEQVhW1f3S6YIJL
	 s+nj7cQ8kltUrH5JztpHbQosPF6Eyz9rt4CSYEa0FXYvf3tkf/WKLMtgc6lI1RkYct
	 eAY17IiQQtYPUw4mB/4zQPQ3v/UnwHppee80JcW670yYlF2qsohaxesQMjpwgpP6Xt
	 QQkQi/+JOmKTaH2LQ6DpO3dzNR9jkH3lQ0dJCQNmsy7GB1BSJoLO6ZSUQYKcDPZTmz
	 0RUrpj9wcK5Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 993D260778;
	Mon, 10 Aug 2026 20:53:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B4F2910E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6D3D6075F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YcRUqhHbKLD2 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 20:53:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EE4A560756
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE4A560756
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE4A560756
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:29 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6b046fe079aso1389412eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 13:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786395209; x=1787000009;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z7hY76XxdKvxGILECEhVV/TOpFQK+KrQ41zO1Hud3Vg=;
 b=FOzpf3xgPXrwMxjOR3TYnGIsUT0Ik+zP0Ad2O7zDF2vRON7E6ACVXhFBXI5aJ4UsoN
 IEvRBLtF2z5cL9NUziNaM6K0uKL+MpWAMm70qC3FNTVIHIMt48VZlhCsTWlGHFtVK+4v
 izXaTcEC1ZYybWqTCoH4h+/TUUMC83uhgsVjLm9bxBmVM3ZDb//co+wx3xYNYELryXJr
 8vz/i3474RAgN3cxLsjvu+V/Tc3K33Pzon6ZqhITa36my1orHSQQbfHlbBxF2vyyBR9r
 PFB7DIlUcmkEZZ+XgclPHo4dVRgDOK0DI0e8EmZeWg6AjtL92YUqHZrNnWqfFmw2DAbk
 V0aw==
X-Gm-Message-State: AOJu0Ywhbg2bFSl0BZoeMAK5hIMtT+W+UM920Rls29hT0ctmhU5hYmOx
 riGjinn4053P5KS8ujfEqGuwAiYVB7xRNvyt2nmO01MRyNcaZ9UmgCYHxC+t5NN54iKlsN/f54T
 l8dAwT6A=
X-Gm-Gg: AR+sD12eLxeJu2+ypUi2oYt4EDsebkJD1N08YCnNHAH9xDJoezvkF9Etka9r2v7jv5u
 1p1tqRjm8G/w9LbBQE7L9J40fc+RPUcbqRgJq3J2s8eQ+lFPrTv0BqW8NE52U3hfQ3fYP8gEA+G
 t4MHxNK6HIKzC/OFxQpQHHt8k1Ez1mSvwHcgnBe8bhFHWizyihLdK9BHJlUmrcSVYQmek84x9eJ
 nHm6Wxm2Bl69QeghE52d6JwqKYrlOawnPlkYLi2wQWCZpSxe+yrCyVs4mft6AHCqRWFmq9b5/4o
 jSLXeyGEAlP9242D/ZF88DWbxTdpUQWKtUwQWlLnlvZ7nO7RHzMmjQZIZKQ4vEauGgZ0QzIIWAR
 ghxSzeoj/zcA4j2PjbCyvvnPMbvFtQ+emc7FLdwhEzuiGoO/ltTxihPsaZT+hm1oFmitYwtv8R+
 KJGv1HvcAFbDj5nBDDK1f20uvOc9iSW3d5tp+p6Kntj8rQQ/oJaaHN2fIFn/+pq9ckRxkhvOwzi
 a4bGAOkBdJxywVscTeD7dmgtkpnC9g+eCm42eo5Mc/hAAC+97sceVR9T3TmcADXJuFU5Ya/WNmN
 gWeRVK5W
X-Received: by 2002:a4a:e847:0:b0:6ae:8a52:ffa5 with SMTP id
 006d021491bc7-6b0352ab534mr13434738eaf.23.1786395208860; 
 Mon, 10 Aug 2026 13:53:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a76701sm9061652fac.5.2026.08.10.13.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:53:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>, 
 Rasmus Villemoes <ravi@prevas.dk>
In-Reply-To: <20260724220704.232438-1-ravi@prevas.dk>
References: <20260724220704.232438-1-ravi@prevas.dk>
Subject: Re: [PATCH] bootretry: only reinitialize retry_time when bootretry
 env variable has been touched
Message-Id: <178639520773.1450255.3966056626673100415.b4-ty@konsulko.com>
Date: Mon, 10 Aug 2026 14:53:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786395209; x=1787000009;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z7hY76XxdKvxGILECEhVV/TOpFQK+KrQ41zO1Hud3Vg=;
 b=W251naRI79+aUX6WTX88q8L3adPAbBc/24Da34A38wEci0iA2RDjoga1gGecyVIdGk
 eTxQbwt2xv3PcNbfhc8FY3YKhCI4powZ0O78NcenRrRPrN8xtqti9S3n+A6BcXr4DjT9
 DyEWb42WTCgs5qtvgvmWVHD4A/RN5hgaakNgw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=W251naRI
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sat, 25 Jul 2026 00:07:04 +0200, Rasmus Villemoes via U-Boot wrote:

> Commit aa5ef3c0a75 ("bootretry: check for bootretry variable changes")
> broke the feature where one can define different keys for "delaying"
> versus "stopping" boot. The way the latter is implemented is by the code
> in autoboot.c calling bootretry_dont_retry() when the stop sequence
> has been detected, and that simply sets the retry_time variable in
> bootretry.c to -1.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] bootretry: only reinitialize retry_time when bootretry env variable has been touched
      commit: 4cb0bd4702a623d69648496a352744e81bfaa95f
-- 
Tom


