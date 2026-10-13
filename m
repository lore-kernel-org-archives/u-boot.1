Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219E0CC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 14:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCED6606FF;
	Tue, 13 Oct 2026 14:05:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cs8_XVEqJBeL; Tue, 13 Oct 2026 14:05:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1ABAE605FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791900354;
	b=EJIWMv7gu/v46NYJSY97NTEPfuLwXFUo8hmEIzK9p3kJhBauXsvdkbQuMEDCJv9ZLCyQ
	 oJasTiWAYL9SELMYK0dVa+7bKowJ7dsp5otI/KCFrYlpXCCOsw5DjK3YNXhfu8nSxBfnX
	 0TFgQ6WJBUeEFAymcO9cpCwckhKJ8rphbfcVRzQz10FRBTxCmqOYTBnDCOXtCdinSe9FZ
	 hL4YCyziUe6OVRYKmlyUXHo9ubkFznYtCkQV3CvPS1x1EnprcWP7QkPmDSqnMi3zFy8Qv
	 ufdxasuLZiOsrtD8EZJcCwEF/PUotZ1wi5dT/YgoXPcPSvy6UKmXAocZCuwiDHkzzXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791900354;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t1isco/kWFONwIfLhtYu6vkFEqIYgl1r05crSGGJaRM=;
	b=tEZ2+Ln/up1/YFPsVnnGAXPzC1lBjRhTL3F+BfPmLYt9ebm+QZC2w1Ud4GVUFo/FwZa8
	 HtV4i08hebe2NJDO0eEx4ndyUn4n8JWr2cP4WeOx2Cm8511qvJ7pfApp+uusFr4GZn4ZL
	 x1wvZBA8YTijGQbqLMBF9uTsId88Or41wdluOQQmdpgg5nhSqFrcFGliV677THxeZMGK4
	 pka7ycjogT6kf2JnvxJ+0gXMFkOF6VO6AB8cum85ANuml6H+0nXBSerNmXGoIUCSfAvBt
	 dNyjdCTC/h58F1/izOioqXuol3s21tAqp9vy7cpWMJI7m+ByFqIB1u8yMLV7jBQL+AA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791900354;
	bh=t1isco/kWFONwIfLhtYu6vkFEqIYgl1r05crSGGJaRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P2yt67QFocqXav/oSChqNFt+W9SquKqB0ZpXT+gEbORuUeNSrrcwYt/D6I28H1pYX
	 SqZyoJ1qzmFD7jOke/4l/+ZGn7VcHulRyecR1VIYZKQad+/nNfodjrszDLHHgs7haB
	 wBfMNdgWUmvn2PopFUpfzX1pOhW0F9M3CM3I3ZXv3BjfTFD7mqbD/38pJusqN34pxf
	 M4lm9Cpfug9DoQo/cLcONG+WXKluOOQVFXxqiXh/tV4HVyKSmX6wPQkK39ndLqrlqG
	 fMBMtdS1CFiVjhMW1DCDXyaLx9koyW1CoEVfsLcMouda93fFSZYxVGhyR20i2K9GzJ
	 CtoE5ryDVIsnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ABAE605FD;
	Tue, 13 Oct 2026 14:05:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A7D5235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C35C80ABD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0rzbrS2Ju2eR for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 14:05:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2186580A87
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791900352;
 b=FQWIB04NoqbWAGJenh9nzekpy/ezWIEKy+OJ4LGyiJygmTBQfl1MDKMvrC6v0Mm4JY14
 tr2N/97kM9A91YkV1BCQfqFxQPnZ2/CeO0ULE0Omo0QXCHqEcQmlFy0PK1oQt/kVx0w1l
 YKBSsbdoBj2YANgYJUQl6DQNVBhDpWi9p94bqVuN3NFQTye0WLD6fSvgk6JXlR562itwN
 NhJRs43ukiSEkD8E3sJYQMGQ1LUitixylFafcDMPi4ln948+DLUPXVTu7/CeTNRA7t0pZ
 pk/5Edlr+sIMk70wfcm8DMNak0OA2wMkbYiepTwuqrcvc+lkwmjWVQbZd4n5z+X5q/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791900352;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=t1isco/kWFONwIfLhtYu6vkFEqIYgl1r05crSGGJaRM=;
 b=BYUDS4ZFNv1abn+g8nMD3Q1Omb3RiFVs5QujzHXapml4rHPB0o45PujUZ8ZbO/NjejA2
 WksCDlcL6MSnSUQzhWTzQ+kqeEtV+SvVoQz9ojzTKWtpazQz6pe6gxXR95hiLpV5AuuiX
 pg1TC0495saS+VPfJQaX6YH2fbRnJNWWii/irNoEiq9kRwbFole8Q9FA9Zp9pqFcxQlMf
 buEISWfNtfbJWUzdhq36dWoiNU66uf4KuegLYSqsiCGXniGu6YeAtiLYlYBv6faJqz2tO
 PN7RmqAwiTGtD8Qv8HRhhyJhrS13p3AEaD/9YoLaSjQ3kvtaI3QznWGGIQpD5qPOLoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=a60dLjHD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=a60dLjHD
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2186580A87
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:05:49 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso26134365e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791900348; x=1792505148;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t1isco/kWFONwIfLhtYu6vkFEqIYgl1r05crSGGJaRM=;
 b=a60dLjHDNaev0rt/4C1ZxLStLyfxJknMzLqcSjme2/K5PD9mBHDlWGIq/yy8+IUSEt
 BlsCP9WZJNK3iE2lPnON+ry31jTjYWBz1GUq7SH0MUfGZGnttKea24b+j8/bAqXEIVR9
 B+egleWn4lIj9jP0OmJ4XkTFRNt59hrkKoB8u6WCscDqEQD4HhfIFGZtFU4Mf6iTa2mO
 zyAggWYVQv/39z5026R0D2aa+qXlhIPIcSrFstIYK6A5vEbHM2GP7QOxR6xm1cvQk0Nv
 PseQIXgiNL0bJWEfeVxIa2BI9DeZqhpMu3KlGIIIAl0B1hSw3stShXQBRPWcs6h+1qHY
 bpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791900348; x=1792505148;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t1isco/kWFONwIfLhtYu6vkFEqIYgl1r05crSGGJaRM=;
 b=tSb/oYNl15z2265bivqQyZ9zuCxfoVhPKwpbO5gqK5KhGpi+w4t84KnKJNw6R4yLod
 e5SCIEdHVrueKBEDmhXlozax0n5+D4/DiF3WOCzKKoQFAHvxXpaKCFzanobwTWEdS6TZ
 adDuoCXFLe57EkQ0jV8Wb28Z3/P/R0O19vxzBtKbdh5hSd1inXqAbdCFa4EBSyJZKn+x
 takGU8IodpyKRr2beX8gaeU1deJ1bjwGRAHq0FyG3JJDwaVVp37rpc0242ZjerxqWjdg
 3I4Zlyyw+nbnGzDr1+vCNnnPTQHNEKc3YHZ4MX137qNNQ7/6sv2n9rvyGOa0hKsiikb2
 n7pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJAI7MrSUMcUrmbSzmeLpmOk2s3cdnU/JV3aCTECChczDCbfFggkghx5esa+oLRxmhFtxycr8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLs4Imiq9vAQQ8j1vDfmG/zlrQh9l64/E5zCD9aLMdDpEAF9yE7
 5oJR+fw9X8RUEvG8vsBBBMRiBftGFefuI6hjM57bs6DoOcnxtqMOXThLkXToYhVIZZ4=
X-Gm-Gg: AYBFou2nTE7FTNvaR32ilVtWCn6nuG+L6KpJmsopkADD6oe3frLLXmv2hWhh279WGYb
 ywBZzMngD3dId7ssD+ocsR386ilZKehmnoUFesAFCWs0PXYpAYLqZUzgJ7g9lHEowyxqskqRmOD
 kA8OicbFMjR8p8KgqfYF7eSGsEK32TuPHW/+QEU51jmNbE6DVnE4MmagQnRNYqCTLHZm6hbcBLX
 cOOHP3n8uvjuaDFt680TsMhg49eL7ITWPnuvJ+QMUueF2O5H9dSHXo6K8MfJiAw67IT1z7O5TWv
 fNqgDM1MtwCLINXn3XNHCwSEzh2DQ+uG+nd7I0Gusv61fw+ttoUEYt25c0dh663ey8HRu68MT5A
 XLTqL8mj8kB6Lv2H18J2xnkcMvWGsMDEFZ0ozz4idA+2i0x4//AgrYkor1fohpuWK4adLRScUp6
 r3F33AVypZ30jp6xC0F5JxlPbPHDhQ6I7my3vqGZP3uhF6a12j9hxis2KyG+copVozN745prs0S
 zig4Vz8kFTWmtZARopUwQOZJFGoIRt5qMfcrZ01mfzxvj0t8Jyf
X-Received: by 2002:a05:600d:1:b0:4a1:9438:71a8 with SMTP id
 5b1f17b1804b1-4a1943873cfmr158446925e9.26.1791900347685; 
 Tue, 13 Oct 2026 07:05:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e50:3860::642d:5bda?
 ([2a01:e0a:e50:3860::642d:5bda]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab4e8csm5029735f8f.23.2026.10.13.07.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 07:05:47 -0700 (PDT)
Message-ID: <1d59861b-0243-4669-90fd-adf84eb2e6de@baylibre.com>
Date: Tue, 13 Oct 2026 16:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] avb: Support verified boot from non-mmc storage
To: Jan Kehren <jan.kehren@emteria.com>, u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, igor.opaniuk@gmail.com, sjg@chromium.org,
 trini@konsulko.com
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261006092732.3577974-1-jan.kehren@emteria.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

i test this serie on Spacemit K3 board which use UFS to boot, no issue so :

Tested-by: Guillaume La Roque<glaroque@baylibre.com>


Regards
Guillaume

Le 06/10/2026 à 11:27, Jan Kehren a écrit :
> Thanks for the review, and no worries at all about the delay.
>
> AVB in U-Boot assumes its partitions are on mmc. bootmeth_android accepts
> any bootdev but passes only the device number to avb_ops_alloc(), dropping
> the uclass, so an Android bootflow found on nvme 0 or usb 0 is verified
> against mmc 0.
>
> Patch 1 is the rename, split out as you asked, with no functional change.
> Patch 2 adds the uclass and the optional "avb init <interface> <dev>" form.
>
> On your bootmeth_android point: it has other mmc-specific logic such as
> bootflow_iter_check_mmc(), so booting Android from another medium through
> bootstd needs more than this series. The avb_ops_alloc() hunk here stops
> the verification being aimed at the wrong device; the rest is left for a
> follow-up.
>
> Tested on Raspberry Pi 4 and Raspberry Pi 5, verifying and booting Android
> from SD on both and from USB mass storage on the Pi 4. Those boards boot
> through a downstream command rather than bootstd, so the bootmeth_android
> hunk is build tested only. On the Pi 4 "avb init usb 0" then "avb verify
> _a" passes, "avb init 0" still resolves to mmc, and an unknown interface or
> an out-of-range index on either bus is rejected without disturbing ops that
> were already initialised.
>
> Build tested with khadas-vim3_android_defconfig and
> khadas-vim3l_android_ab_defconfig; each patch also builds on its own.
>
> Jan Kehren (2):
>    avb: Drop the mmc naming from the block IO helpers
>    avb: Take a storage interface in the AVB operations
>
>   boot/bootmeth_android.c                |   2 +-
>   cmd/avb.c                              |  24 +++-
>   common/Kconfig                         |   7 +-
>   common/avb_verify.c                    | 167 ++++++++++++++-----------
>   doc/android/avb2.rst                   |   7 +-
>   include/avb_verify.h                   |  38 ++++--
>   test/py/tests/test_android/test_avb.py |  28 +++++
>   7 files changed, 181 insertions(+), 92 deletions(-)
>
>
> base-commit: 25a459fd4d2eeef909dd4ea8a577ba82b1fc5e43


