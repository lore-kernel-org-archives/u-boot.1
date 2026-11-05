Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07075606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DQwN2P8q;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SfGG0RFY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4DB66083D;
	Thu,  5 Nov 2026 09:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vK3dsNyBHHdT; Thu,  5 Nov 2026 09:35:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DBD056080C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793871342;
	b=O/eirlGiCVmKaYJZxH/3LAn/Jg5mOJ+c7ycc9ZveCEUrBdk3pPrqM434p3CL2WvDujgh
	 kPN6b04yX12sFf5YG3juutDTWtsMO3UDwHfcNqRL+8l2JY33GneB7Hg7pDDhwptskAgD0
	 1wX3QmtcalzHqchrJppk3cZYyp3z622nP4P7GLT6GzukvRfLAkkralz4Lqvu/YYeGJWat
	 APOWe6ZCLRxGpga8e+SL9Jegw0nZ3L+Es/CP3tvA8rY1AyT1djLAUlryeW7d+77xkawkk
	 /ZjZ51667gYtSt+cKW51PCcrlXDcyvgM4MfargEfyRmt23EpPt/+F60WBohg6dSDXsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793871342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4JamVacsH149Jl/1hP4sMXFx5drtRHpGcZMk2lIkQK8=;
	b=O3u7qWKB0iec4skIpgWodgY5LZ7V6vLeDH1HAtP98sXrufBNEoLIGfNY+17KMp1xP2AS
	 GV42tXqOADUJWS7Q786PKGhz8eLG8E00DAq+wp2tXtWUsIptD1EnTBEYKu6zvVlNE4PFW
	 Qd9aoVD5F3Id0e3yC7YLVeG9Max0zhf1LgfuGouUM1B8N99IE8vPWSyO5Bl4qrmoMnsqU
	 1VziwDrxaaPFM+ZM2IgnlDCIa3tFPp7CmwBNYrqXKUUhKdB/AEj58SNSR7po134HDVSKY
	 UTM7Vrj5bksDsDyLXtD89Mk0o9G3QRwRBIw3b0nyP3200vSm4asLzVi5bMXiQzSPltA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SfGG0RFY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793871342;
	bh=4JamVacsH149Jl/1hP4sMXFx5drtRHpGcZMk2lIkQK8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DQwN2P8qgQj44GCQ+4UjpqsbqtNLq5xCGgH21Ai5vKTumOV7aS3KDgY1J1KWpyGWE
	 aKju7yjGMFqcbl/eDZJLk5ljgFqnk0EXsei4MQflc0JOCmFF3LVHm2uB2C/HcIQeWc
	 R/knm3HflE4yMISuxD/TpEbryoHTU4o3OyBY9QRGXPvCaJgvGOb17NyIDuPRhrP8QZ
	 sEIy/pwtisCd/4eWMOq97sgkzKa60cWVDwon1uq94SMM3rLkkZxW5SZuDaBYQPGv/m
	 tH5D6mfJ8IY7MMbnXhT06Tqgy88cGC5H1oFBnXFtFuKtPFkLGE6zwH3saBgPWXaXlZ
	 1egi2MmVD2MfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBD056080C;
	Thu,  5 Nov 2026 09:35:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 810D9177B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72A076080C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lgE8pAnwm-mf for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 09:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D7A560697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SfGG0RFY
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D7A560697
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:35:38 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b12b1ee403so12214997b3.2
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 01:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793871337; x=1794476137;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4JamVacsH149Jl/1hP4sMXFx5drtRHpGcZMk2lIkQK8=;
 b=SfGG0RFYL7+p2htn4nwPJtKE6aHrJOM6dpB8r+yjwYx96WFR4t/Obj6BDY8kYmn+d8
 WRBZfWV8zTMF3HZlPhkXrWzDBKlCaY5aA+Ppp6HvDREfDTEHjhaGoLmioa1KhS/jxeB8
 erZS5jKZMvxZhF5klYk5cgWVr13yvKWUPvBUD0vTVW7UBB6AX87x5w1Xlpyo8Le2sODG
 gMFLsgY0Qxm3/3N8LXuZhp1K1G9lKK7Pigqcry4VDAJKp38cDygSkQ4nkSvgX/2sxxcn
 U3jWkhP26vTNiy1C6VcNz6gh+RFx0Xf62oURjGbwd/jeEkM6+ZZ50QS2+GNzxj3HX74u
 A7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793871337; x=1794476137;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4JamVacsH149Jl/1hP4sMXFx5drtRHpGcZMk2lIkQK8=;
 b=Igdoel4mFrQjFVsh/bA81EqbUg67kaqXcWTEmoY1XQXlNlq5t7h9Wkch3p9vSES6KS
 fwR3Kd4ShDzV3/6rhewDfA+0HP+MhfoK3x3OgQFjIotIxnvSRycOaf52a5aaeYAJrci8
 H9FSHjsQorFyrSH97BD47tabuMm8tI+7Nkknuwm6SGkrlm7DVhWEU1FnY729HAWBMkEW
 LXQDk9uHaFCVNRzIt9kWd+kj9mINBXHi/Z0+SfxGT3lku2rvty+8sRS48RECYTKg0AkS
 WSbW/20BDXBfeec1Q3o+21MvioZ8dTlqpkV5mj5Nav9c7KRbVlAd1mtJf84p/Be4vAXr
 RoCQ==
X-Gm-Message-State: APuU4Z9zzgyCHU94Bv4qPI5+fSgX2aoAvCu5Bl7/DTeGxGVPF9JIBP25
 9HLOhr5OhQumoDLgPl99b6fviyLLvERqS9ImM6vExS+jrnCVfwSUDiTfSvTIh88QF5z62auylc3
 HYT7L/dZm7pimHms/ch1qde/61Yf5sNGMcZsP+hHZ0Q==
X-Gm-Gg: AYBFou3A3kpb2ZhbmRxDF8alON49vM6pdcSKM3vTU2dGyEH3pFyq5kUrvfulSnuV5v5
 r8bwzST48TIsUK5O4hvi3XUuONroMUVK7KE473rj/L3RXRieYotRD0CT6a0mELZt9ukmA59sFcR
 F0UJ+mufurSAG1bD8WDv5dhhMQosFjmsjCBshdB84fS3GOY9ZBlrs4ZhFguS9pIjYEeXadtaL/S
 SzhESkjY6Kn8Ztq0zv2B1AB6b4dZKuR88xolb6u4VQuWFiVeNRpCvybnbTXyGI57WFIC2hmMm65
 iy+5kkkQXRuaETgcc/roy+xYDS3XAN7QbpNtFb2Mx3FVcLgPcrhXPcw2TToYBuBk61QTrIttQkU
 qbXEc4cXmT3Lw50tBuBOkYG1naEsFKWJP0HPejN7NgvINiWjSioAXgLgzxdhoDx6YY+TgwXMDwa
 Wm8gHbVc3ZdNY4BkTmpOrLEU5XNss2S+mPKp6zlH/EdR7og4/kegnGilXyvVMPMOtCAkaLx5oJy
 uQGOTwJ6pF8li/UTu+yPqihG16EsxJs6qKjKbRrr3OIEfRnaCvKAI5ntbgg3w3zMkrk5eTmYMdB
 QfVgItddbNSn7tdjgJrcGclfHgrVwQ4JAUrxeShLxJh71ZS0Avol8jdzK9OFaocZmj2CQ5ikQrx
 MWwCkFs/IqEUZ/B3/y+rfmjm9IVvrkXKoM6le1GGWWeUnJHkjTidRFmwfiQoB8+KaFgcNnibA5Q
 NLzFrdzQdbnHQoTIYCwgrpA3KpWeRBqJkd440=
X-Received: by 2002:a05:690c:7482:b0:8b0:e238:2719 with SMTP id
 00721157ae682-8b2b675b923mr150574597b3.31.1793871337113; Thu, 05 Nov 2026
 01:35:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104094238.519111-1-tkirchner@emlix.com>
In-Reply-To: <20261104094238.519111-1-tkirchner@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 5 Nov 2026 11:35:01 +0200
X-Gm-Features: AclHuK9wtH0MoWpEV9z6-546dTl1hnefnfKfIysmCSL4fp5yB9eQMTxEpDBluGw
Message-ID: <CAC_iWj+5qjivBQYL_3-J9P7AU7fqMky_GuWn4+48RaaNhT-Jeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] tpm: fix handling of PCR banks unsupported by
 U-Boot
To: Tycho Kirchner <tkirchner@emlix.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tycho,

Thanks for the update. You havent appended any of my reviewed-by on
previous patches.
I think this looks good overall now. Can you send a v3 with my tags?

Thanks
/Ilias

On Wed, 4 Nov 2026 at 11:42, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> A TPM implementing more PCR banks than U-Boot knows algorithms for is
> currently rejected by tpm2_get_pcr_info(), even if the unknown banks
> are inactive. Ours implements six banks, including SHA3-384:
>
>   tpm2_get_pcr_info: too many pcrs: 6
>
> Once this limit is lifted (patch 2), the existing code for deactivating
> unsupported banks with CONFIG_TPM_PCR_ALLOCATE turns out not to work:
>
> - the result of TPM2_PCR_Allocate (allocationSuccess) is ignored, so a
>   refused allocation goes unnoticed (patch 1)
> - active banks with algorithms not listed in hash_algo_list at all are
>   never detected (patch 3)
> - the fallback in tpm2_pcr_extend() deactivates *all* banks and does not
>   reset the board (patch 4)
>
> Patch 5 deactivates the unsupported banks in tpm2_startup() already, if
> the TPM is actually started there, so that this happens before anything
> gets measured, also for users which do not go through
> tcg2_measurement_init() or the EFI TCG2 protocol. Note that with
> CONFIG_TPM_PCR_ALLOCATE enabled, this lets tpm2_startup() fail if the
> unsupported banks cannot be deactivated. The rationale is that enabling
> the option asks U-Boot to manage the banks, so failing early seems
> preferable to failing at the first PCR extend.
>
> Tested on a downstream U-Boot based on v2025.04 with a TPM implementing
> six PCR banks, with the unsupported banks both inactive and active.
> Build- and unit-tested (ut dm tpm, ut lib) on sandbox against main.
>
> Changes in v2:
> - 5/5: deactivate the unsupported banks in tpm2_startup() instead of
>   tpm2_auto_start(), and only if TPM2_Startup(TPM2_SU_CLEAR) succeeded,
>   i.e. not if an earlier boot stage already started the TPM, and not
>   for TPM2_SU_STATE (Ilias)
> - rebased onto current main
>
> v1: https://lore.kernel.org/u-boot/20261029150906.1558380-1-tkirchner@emlix.com/
>
> Tycho Kirchner (5):
>   tpm: check allocationSuccess of TPM2_PCR_Allocate
>   tpm: allow TPMs with more banks than U-Boot knows algorithms for
>   tpm: detect active banks with algorithms unknown to U-Boot
>   tpm: deactivate only unsupported banks before PCR extend
>   tpm: deactivate unsupported banks in tpm2_startup()
>
>  lib/tpm-v2.c | 76 ++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 11 deletions(-)
>
> --
> 2.47.3
>
