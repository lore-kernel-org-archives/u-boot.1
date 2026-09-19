Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9B1C982DA
	for <u-boot@archiver.kernel.org>; Sat, 19 Sep 2026 11:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D149606B0;
	Sat, 19 Sep 2026 11:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ln2-p440pG4A; Sat, 19 Sep 2026 11:16:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7031B60670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789816591;
	b=KFjgseb/WoSz/IHJ+0Ocw0zbFkFr+MgaB3DY4F6PIUmGJvYF9SGCW8RgjkTJULiSAPtf
	 Lw5HGhQdkrL1IcqsWZOTPMWMOevOJsYy8pieNBSLlGH8wzVc+5jE+uENdKhrhET+LsY5i
	 pCzPM+A8k8esDwNjRIkA1WWgeIZkju4svCZrqXrvZ1/TYl6TKXiv6W5GZP4/vGCnG5rIJ
	 e5g8bnBajN29goEXRySakk9Aa3kyydERqzlgAPlG1sjzm7o4X2I56xc4m1n1PZcj1usFV
	 MBjfXZVg3mIk0daFcAH0s6ljQ8oSGTZSsRoSx7z7Fprj9bp/RgAXy85wOVBGJFtjF+Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789816591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=r5ovQ0n/L8/7IfF/tD5pzZ1hbnFPXNNj+AlWQWE9CZc=;
	b=NL9YRspwN6FUQpC0hdESpkhxhwOH8SBg1rBJ8EDRTbCmb1wBlQrHw0rqq66torifqOAD
	 7TyXFzoMU9orXK7nwlAoIwN0uNI/Z6/JLKCCC+NKrMi1CO23s+HlizR8lMrup45qU1HqN
	 RauG6HPQbRcd0r9BNorFlLL7eUeizM6Emg/hle07/jEOQjKpcMsdYK0L+8cIynxTZrIFc
	 nb3XMS2NGYvxeqYxSVSZX7vctBKm7/eb2O4wCOYxJj4pbNeaUFdjsStTO9nVuCNpWO6VW
	 hVdZe5c9mrb8hICDX6W3YIQIZUApTCi2DcX8xo0EUOBUhemYn6WATaf3y8iOkNnfwTw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="dK4GcT/S";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789816591;
	bh=r5ovQ0n/L8/7IfF/tD5pzZ1hbnFPXNNj+AlWQWE9CZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vaLaqiib5FyCYV9Two7hjFYvE+Bqval8K0RCpVM0FcsEECf6PPuoC/gfvU4etB2dl
	 XaagmR2G0BO6i1+VKCBmHUfKsDPTctzU8pPFNplpDoMpjFjUQMBZPbtPAQDNccv7j8
	 I5x7VhsDqrQqiujbFm7jbiaBBvaqCzBbRxszDqrQ/PUQrXHsZzk77+ZE6iXMFJMplN
	 28ZSPwpZ1ObKcwJb2gBpaTpWYYlL3bhDMeVyTw/o5JyVnLlKyQu/EQsJmuxfOr4jI5
	 UYAGGvqod+3xua5RfozyfIMkh/Nweo6KZEwIuSn5hLUdorkK79NtWXa/jhEYjGZYLN
	 Aj6i0ynu8PItg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7031B60670;
	Sat, 19 Sep 2026 11:16:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 650EB793
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 11:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B26E60670
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 11:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8zLlEVOPAdL for <u-boot@lists.u-boot-project.org>;
 Sat, 19 Sep 2026 11:16:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3F18060631
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789816589;
 b=dshRSIfNdk8CGkUnsmJgXlSosRAuILZR1mv2C/eATA98vMc/y4M/H2qyWXOjhP2A1ePC
 hxz4zMNlS8emmbHvXzOHpfua31NQcgU7axSz1YWiadvadoUhCH9P2vxd4dJvgpAEat1Cc
 VU6gP2LguAxxv5Ww3rcpcH6iNAUfiu44ODoytE5zgzNgzOFdyC0aJtXJNrZ1ltGUybv0X
 89jePl+9z/rwOkUEUVVO65LfDUHnW1MBESRa7vIVSkLKKGMfsMAiG+TnKgAgtZAbNtlVN
 AKwEOYzzoSMsp7aoLB10Qo6qtGr6kPlvnogCRy8o+JKfxR7n2Bg4HJvkTTH85/8uOgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789816589;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=r5ovQ0n/L8/7IfF/tD5pzZ1hbnFPXNNj+AlWQWE9CZc=;
 b=k0QhMtZ7mkYsKxdIloWSbfzF8hkv0pnjeN4aJXURkjaTILqaxQZzf+YzCrKjinu/lCcz
 xhXSdmUE5vQoQMA2Q4YTAwwzJ8+Queu7OmcET78K7iuM0+zkhz3jGHfEWlDcnqvLw8oYm
 TXgwdtY3kqW1+atyQk942xvzFITej3PqULzdaCqogbWVZz+BDoJREaQiET/fV+EZ4u74q
 n5vDv2BGC3lyGcRGF6SgoQBzoCfSmiAfKmSlkfJCaPF8sB3rWvZ3rDgZQjCEPbrRqGthr
 kXmgrXyXBbMotQvXhyPW626vkWMArVkjjzMTbcM1JuRFA18yoi/2Qdj30DaK9z5yeJg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="dK4GcT/S"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::f;
 helo=mail-yx2-x0f.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dK4GcT/S
Received: from mail-yx2-x0f.google.com (mail-yx2-x0f.google.com
 [IPv6:2607:f8b0:4864:41::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F18060631
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 11:16:28 +0000 (UTC)
Received: by mail-yx2-x0f.google.com with SMTP id
 956f58d0204a3-66e4aae314aso1234380d50.3
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 04:16:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789816587; cv=none;
 d=google.com; s=arc-20260327;
 b=aa8/P3xmI2+s8NYBAysdGoGEagl0qhw8yAnJ40ReOuhQubcXXT42L8YWXUcm0+uO9M
 alTy/3J2XvHqvaDRhcjLWG+9RZtynqXC2sWTfRsDQr0HSEe5TLazrWvCMKezn0cXfu8K
 DXo1OQJnzj7LRhuNFzDKgsQjL8DVMFIJvJbV0Dl1F08GIHmRz8g3PnkRZVsh6ikv2GsM
 MB8E5pwWSumGoWxwILcPzvbV3ZUI9eVs8zMyiZHB98BePw2qenCwxyptxwAgk7Ll8Rqw
 OZyOJlHX/AD4enZSb6RkRJleNr/jro9aiydHHYwZzTU2zkoPRT4pP9zm/0/1xkxOsXiy
 S/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r5ovQ0n/L8/7IfF/tD5pzZ1hbnFPXNNj+AlWQWE9CZc=;
 fh=Q/JmBOyOgRaCqmGreSpVlA7uIIga3WQ5J8fwwK1ama4=;
 b=daYBe4329igmn9zfeJid/G977COGTS0yBPy+Vt8JLKWfN6ecV9AdCNXTi03/lK9vKm
 B4cdxvChK9hYUwzG/V4n7OMeLP63Y+stNZjh6P0MDgaSBYuZnUxqosZdOQ+lklFXA4Os
 7zlLaPLVkJg67YBQUbi1hCkP+ohSpwkD77XpxXIIe/nbB4BNKR4YaSCZL0Cv9u62eD6m
 t0EcJWnX4uir/ESEWHNTDYFaLBPwgNY5myOJEHoONkRidY+nDcIQGXPV0wnxx472sN+t
 EuWCEvv7mlT9SBqTN20yryddclBZDA1IU/94nbpQGf/R9+6eEZ1AmgEmUGcEWnpy1CtX
 9GtQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789816587; x=1790421387;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r5ovQ0n/L8/7IfF/tD5pzZ1hbnFPXNNj+AlWQWE9CZc=;
 b=dK4GcT/Swwws0/ouAXEtZyq7CjUVZb9tabm+lyUgn9aYOY69iXvl9VeQYmxoNegxdx
 CODiFE4xVD5LfKB/4nWtJCxMIXK5V6kd9dMNWPWD0aFaT5KYOyfB32nosXpbv9D01Chk
 s2+Csf51Woe2muyuIp6UrPk19qkjQEXqBJTlnGNVThecNkr1nm+aGFBf2aghurlGMMkj
 sIrOVipDd3GIUwku57PQtzH39M0x1t+VPz+Tbil5EWw40mZRzD2p2XI9UALvjYi5jQeO
 nC0v9LzUsqs5Z2HT1s43Z13PphdLxrqz7PRpW6i3bdyFBmNJMjP/QiKHGmyzTFFyudLd
 pesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789816587; x=1790421387;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r5ovQ0n/L8/7IfF/tD5pzZ1hbnFPXNNj+AlWQWE9CZc=;
 b=Oo9P+xOOOiMaXb3RuGhwjo4HF2ddtz52AXKiTXy022a9wF6LBMZc4ueLxbiTfStez7
 qdkTDd+49NJ8SChPrIBtKMrRy+1sJXY/VsHQo0qnzLQsGVFn71exgB040CqBXgpLirf9
 CHLoshpp6G4FeGmOA0JEXikQBtDhn8J8r0XTNOvRALIyUqHy8AtqXnrtLiM+Arf1v8AN
 3anedOexgDxRC41mqx2Nx6ZZq4bLvjUzz+itxHdO25qr224hL5pDMEkITZlS+N+cCra4
 +fFoznyHyHLz/MiGc5/wa5DukvJ+dmHkMjAfI6D9OEH3BxcFegqOXhzmuHl758CBKH3d
 9f9g==
X-Gm-Message-State: AFuF++lQ7ZA0woiS6ONGeXF8A2Ybfy90sEpFDtP+Ceh/3PMFmPAIqRPj
 jXDwjQ/8sJsYsM2ciYAgjL5hz//BJLXy9m+Ck6JHrE2DZepLRu/OFj0gXTcD487wSiE21RmDBXR
 LkratDt38BPqvXbTQmZykSfiKBIYHdhvH0i/Q3YOWyg==
X-Gm-Gg: AYBFou2Q1h62vLwFdP/78PjtnZiybaGYe9zPDn5CtY6S8xtpbxIkxtXNLSzTioZQm1h
 8TShD52UzTx0ic+/M9oReqjzVmRCMtXMhqAKdUubT8H+AmCZwb+T42RjZJme+qctyEVLffRB0BZ
 iBSOCX5cO6XwNmuEXS9nHdVZHRJHjWI8bA5BvTWvaSMJNMs6F2zJ8RUH6d104F3d4yquUBxScvV
 wnZLEGQ+Jfna3C4TALOfnCmKT6QEeFqCXmQ/zOxIdVThQLVHz7G12aZSnVyqI6HXa4k5ZyjPjOO
 WPYBxFd9qHHTTSu9QX8Havju+X8rv55uGbO51g+sVCT0SyhVMNw12h4rJWNgUQGxolRzqc57H/r
 6nX0GF9WhxBINgzoRgkus2DEUeml6XDOzYAlqzVbbQO3t0+uyaHy71AQdOn3LZH3ePO83eQZJvR
 a5Rk6QKQ8P4KF/LlEqUUplNUxDMnJ3TNDJWtxO4+E/5tJKQF2DhAFDIea8hR38c4nWujxszbtE8
 9LEld+x5lS7tH/cmKlmVzseav7ECz4mmJLowGSsnB8VFftgI+ghuOTF8Wl0VxfsHn2LDNwSOqED
 x0UKEW4EK0+CKF2p36wH5kIbJauALJg899IDe7RjBfUwQaC3MqzH8kDvfvz1vT28h6xJ7NJb7c/
 BijbWnKrPis7J+16ZejippxpxQ86akR+u+SbzdjNIHLJvUwmxCeomnw==
X-Received: by 2002:a05:690e:b41:b0:671:70ea:46d6 with SMTP id
 956f58d0204a3-6717fea3e8emr1302044d50.109.1789816587333; Sat, 19 Sep 2026
 04:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
 <20260917171810.4122899-14-harsimransingh.tungal@arm.com>
In-Reply-To: <20260917171810.4122899-14-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 19 Sep 2026 14:15:51 +0300
X-Gm-Features: AcwNN1U8i_fPykIPupcRw4TxHfGqS6Ub8bjXYnocboqWzIASc7dVodecdMpzxEA
Message-ID: <CAC_iWjKdcGm6LyHGiEjLyzpy15VycAmu3VjeozoJPuGvDmMDWA@mail.gmail.com>
Subject: Re: [PATCH v6 13/24] efi_loader: fwu_arm_psa: Allow keeping the FMP
 payload header
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.u-boot-project.org, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 17 Sept 2026 at 20:19, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
> Allow sending the payload with its FMP header
>
> The Secure world needs the data provided by the payload
> FMP header. So, let's allow the user to keep it in
> case of FWU_ARM_PSA. This is controlled with
> CONFIG_FWU_KEEP_FMP_HEADER.
>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/Kconfig        | 8 ++++++++
>  lib/efi_loader/efi_firmware.c | 7 +++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 483d2c6dc18..50302a03eae 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -387,6 +387,14 @@ config FWU_NUM_IMAGES_PER_BANK
>           Define the number of firmware images per bank. This value
>           should be the same for all the banks.
>
> +config FWU_KEEP_FMP_HEADER
> +       bool "Allow sending the FMP header with the payload"
> +       depends on FWU_ARM_PSA
> +       default y
> +       help
> +         Select this option if you do not want to strip the FMP header
> +         of the payload
> +
>  config FWU_BUFFER_PAGES
>         int "Number of 4KB pages in the FWU shared buffer"
>         depends on FWU_ARM_PSA
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 290db9d27eb..09d386cdf9a 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -512,8 +512,11 @@ static void efi_firmware_get_fw_version(const void **p_image,
>                 /* FMP header is inserted above the capsule payload */
>                 state->fw_version = header->fw_version;
>
> -               *p_image += header->header_size;
> -               *p_image_size -= header->header_size;
> +               if (!IS_ENABLED(CONFIG_FWU_KEEP_FMP_HEADER)) {
> +                       *p_image += header->header_size;
> +                       *p_image_size -= header->header_size;
> +               }
> +
>         }
>  }
>
> --
> 2.43.0
>
