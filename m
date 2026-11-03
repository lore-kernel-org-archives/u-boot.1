Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100C606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n1QUGKpy;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uCC8rK57
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0957404E7;
	Tue,  3 Nov 2026 09:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ljRTloz9AZTB; Tue,  3 Nov 2026 09:15:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BC4E5404EF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793697316;
	b=tZckxP11QvsRdT+ls2S3bpAfSQP2NejhmKbJ5mwZqaHE1BKR+ej5onBkdWIlfzEEObV+
	 zoiIC0u5XCODLHXSzbEksW/s9TCfz5gnInL8Porg+CP7al/eF38gUfoIXcvsMDffkOoWG
	 9LCy7mz9/GysrSzm94zHou2prVWKe5p0XG3NfwIMy1hog83wBrNHSlDXjj1L+WZ1C5zZw
	 VHZW/MiR8iP8oVBacoKOrNmqShgw30PBH0AhTkqd41lyag42wR7pHjo2GXTRxzA97I6IG
	 rg7EwLx64mfbnsT6uA1ZqveGQ2AQlqeJvNezjlxC/DLu2w60NQGqgRphUsWOvqTM2IQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793697316;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nRC1t6ZTiMRrGml+tp12qabln20Gcs+SEVM/AqE95sY=;
	b=fe4lM/mQikHfwzvKNZliBhv5at6STul0RUajZn3PXPPZrsmyuMjijdf1ysCuXghvV2W+
	 QVaFQjTlQiCVDgwtSII+hxwEKSHtOpjNAMr4CJOxmlNIi0juDkM/usMKlnrgsspVbV/Ys
	 mdbNCYTY+K/pHBSiExmbLik0jOeSP5kRn78R3/8fgC8WRGnSnevcy1t3W3Jo6WbG4JdCw
	 g6FQxDKXATe9wVT1jPY8rKIEy8dV+yMZPzKLKJSDRxKWen9SjvXCX/J+JH0jj5AJjL+X3
	 0uRLeiX7NBsSw4+rNDu3OzoizdaKSu18mqlJnqAt0iNNYMNqJR2iInZEU1DHQ3ZB0CA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uCC8rK57;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793697316;
	bh=nRC1t6ZTiMRrGml+tp12qabln20Gcs+SEVM/AqE95sY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n1QUGKpyu9Ej5FODcD7XFfqTjFhqkYaJH+M6H+7AjK4en+bwUISMkwmdkwBuAAvye
	 UIciVHzFvrxHd0ZWZiaAupJ5IK6gdRMCd6fUDtK6anE/CuS16nia7UuNpzaZXF+glM
	 cb8//nLAxRejrf4IE0DASxdY2EGSClfaT9daG8ROAOYsligipA5lc7ghe6n3N6nWel
	 muwo0y1yUP2jT/IkfNCtELyz2qisBBseKplbR+VjuWp4Y0jP9x4ITudHj8bmWdFURi
	 zhYQwu8j8q+bGcAK/b4UmueNM9Wx9cN2LHzac3yy5jlEhmxMadfOa1QnDaaFwGJTiF
	 rCedWnmVc30MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC4E5404EF;
	Tue,  3 Nov 2026 09:15:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A158356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BBD0404EF
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYyUaCxFECmB for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:15:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E161F404E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::833"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793697315;
 b=TB0VK4T+HoXxZqltaLTGxWiL1jEZrl5LR8AKMDQczA6mkjV2ckA54qPHqPxprwRs4JjN
 atqpnh3PsNY89DAW/boBrCVvLLWoYCUtkV7yVEXBZzbuPVlc6CIFi8GKQrY78KRj57kFT
 OLzKI3Fe7m6INJWXZ80zkbMfQLKAy7FlcotezZUH4fNfD8cDspg5xR/cBuMO4pVMsnSW2
 wTJTgHVf+nHZEnQSP0lJfxMC8L0EoLlAmrM7az19djYqyHA4eBd3KidWOFxPyl0BbU6ZO
 7If2KFFRMHHPKjZL0bmsCbC/b7Pw1BUxA0GKV6Y8rcUqEGIYZj7yv/7ibvIVzsk+/IA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793697315;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=nRC1t6ZTiMRrGml+tp12qabln20Gcs+SEVM/AqE95sY=;
 b=p1FKQgVEPg4KgRVwEM/+V8MBOt9V6Cgv9DcL5PGzZ2i12fs48YZ8sH+Op9A+FN7WDsp3
 CyHjNd9c82rj0z/KV3Qu6Q8nbpxfypdooOGOWMHV9RdOqoShSENzN/zb+WlPv1JjgWlPi
 AzGRqhIJNF7ESNacd3Nk07Yhaij5J6DQUMaJLTvIbFqUAfxURV34L6VecyWQW9eZC2tmm
 wsJWqok54jCn8vcccfBYDJVHKtEwXGj6EDkgToiKtbkBJXVICONJvvAzNJdOkcMtMJdpg
 RHBE0oRkipW7iWn64z9fUAD0SX8iyUdRetQaU+T4WQmF4ECa/gSjCFlWa7R2EPEdhtg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=uCC8rK57; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::833"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=uCC8rK57
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E161F404E7
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:15:14 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-53644ab1f7bso35063901cf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:15:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793697313; cv=none;
 d=google.com; s=arc-20260327;
 b=cuha63U3SO6viomAykaZypMkwI73Vbtxznf3V4TMcTeILbGQ3qjPlSbpnWwrxjN6Ow
 m4UJq8ZhLQXktENPTDn/bHWSLY1oGyEYHFNAJ/ni7otp2VYeqhPBtUZqX/dAFp5tV19z
 opM4If+Z9/MWhCWcah3hfQNFDicajTDCQO55ekUIWbkD+9tZOIK7w9XTlfnvadDpXlYo
 OcXzxJpt/6k7GQ9CPGNDIBHgmI2j4v7PHrFYj1fZPj4M1FmfOBJABQH8CSOaW1W8TiYg
 DJIxLEDCHZnJlYwjG8BCzjKPKSY+Lcc8N1WPYdOyOePMtWHBWssf0xSAWJVtbZPC0Ynj
 4rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nRC1t6ZTiMRrGml+tp12qabln20Gcs+SEVM/AqE95sY=;
 fh=dSKMca6CaaLLb4AlH0tQEjahByHASnDY+tEa9AhOPZ8=;
 b=r0RLc2+Kfssb3BWKAxdNYgun0LDgq/bbYLa9u26kgBZ8GPiR+5Z1oxStJWfmDD99bZ
 62B9oA3ySbEpviaG71h+e1SakN04B0sOd991riuSa0DvNbYrkZZPz5tctjFkutE/chNS
 QJF8/55D49Ztl8QixuKlUx5YmfdRpG5VfCLWDF0a1/72r5+NQk4V6QiBL+4lDa5RcIVq
 y5eI7RsicFSvGTuQxE4eVl64bzp4vdqwvqijIUGPtdT4wca9osG8qnmvr8b3rBM6WwZH
 ggbrOTnpm5P1A2Xq4Q6wOS6e/brUExB+Z8l2MIlXWPQ3ty53oAqgyvNbAVTHMDBXG6/0
 Lkkg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793697313; x=1794302113;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nRC1t6ZTiMRrGml+tp12qabln20Gcs+SEVM/AqE95sY=;
 b=uCC8rK57T9kAqGsMGzB4i6aZlp8OfpxARyeGxnXd6JUpGEzhisxZJmDwBypLP+HMGZ
 lTQzK20koGTgSB2sbz0v0K0KMet35nfUk0fOwJFsz7cJ4/49PyHrqEpPXGUbV0VOE1Vy
 3qZwucHwpOyvNpvRdiTyjCdh8uEI9gHHQpo0Z3ab4shUIE0LpzKVNb8sKapVcoMvbrb0
 /hFCX2whwmSbajaCK5KCzIcScFjsd5fW0ElaWhOoVePpvs4jAioJoKp46ktnjwd7a2aE
 fd8wQc1dWqdIDXKVu7SmY+vqlkiZbQKzNS+fxWW5eGLkH77gMG91OgS46vIsZs0dbZLk
 enwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793697313; x=1794302113;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nRC1t6ZTiMRrGml+tp12qabln20Gcs+SEVM/AqE95sY=;
 b=F4VdxXyjjGxIm38GInhk24aAqvMaci94PXq8ucWstyYUGR2sgHQGMO77OcXxqyI6SN
 XiC8PTjp/2rEOfeRjjyrFP5HILwkMlU+5UgfPbrMdP0XE3p6WnoEv4bpwBvwPif+FOB/
 7qG6cFGreJkH98oLfDZWkOkRFUyTnpyXrL3KczmoNbw5+nkTgnl4qY+yKDRG8d7o9ew8
 HKBBL3JhTuMLWp1HxPYiazAVWmrJVPpqdWXXgfxn85dB+KhWKnxvk1DN8dKhmfSovyu7
 JidShBFHtVncZJJxM9TRlM9WgQ+byCOkur0OEL8KnSktcf40CDEMMDdKkVHCbKDrMA5C
 ngvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrUTCZ4nq8j/SttTEKI/ez+rQlT91FLgIl9NXFS/e23yl4Gi3gbJEer0tp6LXZ8+vOQKlFV4M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ZYvDtU+jJkh9KTxOax92jeqCNpA/alx+5pRPb2K1D9d8BBxe5
 M/bZ1J0qHaLtbbXWlYt15A3RXJu9YO68AwfnXxJkgzZCF1U5WWt0SuE3XI00+TNm2pCPlStKYK2
 KYovWoR5zX+idqIO535Z1xhqK89myV4RUxyVW+Uo=
X-Gm-Gg: AYBFou1Lxhq7AlBhP2hUNXgC4aTlJtEA7u2nSWMUuhsg9QmhUJzlycaX1IwKNs7yE6v
 ZbvuP0u2u8GoopEE4tBsY+RQD+xkzPYdAUrj7NSpUDorAtV75Rrb04HvNa/oAlA10rdUoMLSYzK
 4sEt4Ep/skH2L5xWNd7wkHLdIjBuP0ZIICjc0Y2qrWtMpu6FIhm5tnmMrh1F6JTl2JY7q/8yUqH
 g+hgTtM3IaHYNlt9LufssnXfJO1QryRSeRdmon2aKuUnmfvoBcta33gt2moFP+b8VX5yA4ULE5A
 Rh2ZUxllQQ+6sNYlUByCXdcx92FqajWXnoqRv0pTunwwNtJq6DnUaGWvV0kMhRgbuk97vtOGIpi
 eamvnF6my2kfiLn9V9LO8fAoApYkqXFfYGGWouIghbNb/xsfl5Betv/sit/xUgLUrJEpv0JdCvR
 /Y+cClkDoVjMwZKZCal/B4DxemuQLSRYf4zNX7a/ZOrW0SDLMroYYykUqZ3MBN4c0XT0pdbAVpJ
 RKt9tF198urpPNx5JN9Vse+Bit0IVSrBcs=
X-Received: by 2002:a05:622a:48f:b0:535:162c:2e85 with SMTP id
 d75a77b69052e-542b3c732eamr198242911cf.10.1793697313123; Tue, 03 Nov 2026
 01:15:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103-b4-rock-pi-4-spl-iodomain-v1-1-8dfc34a5e2e2@iav.lv>
In-Reply-To: <20261103-b4-rock-pi-4-spl-iodomain-v1-1-8dfc34a5e2e2@iav.lv>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 3 Nov 2026 09:14:58 +0000
X-Gm-Features: AclHuK8lX4v7u6UZzUNfx922YOWI23t9tEjHJhxK6MDOQftr0NhwurbtDm2xvkc
Message-ID: <CALeDE9N5MB5NhLeyRiJX8TsaabLXpNCyFKu0sjoYufPaGiM5tQ@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3399-rock-pi-4: Enable IO-domain driver in SPL
To: iav@iav.lv
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

> With the SD card in a UHS-I mode, vcc_sdio (RK808 LDO4) stays at 1.8 V
> across a warm reset such as a watchdog reset or a panic: the PMIC is
> not reset, and the card supply on ROCK Pi 4 is not switchable. The SD
> I/O domain resets to 3.3 V, and SPL fails to load U-Boot from the card:
>
>   mmc_load_image_raw_sector: mmc block read error
>
> Enable the RK8XX regulator and Rockchip IO-domain drivers in SPL, and
> drop regulator-always-on and regulator-boot-on from vcc_sdio, as these
> commits do for the NanoPi 4 boards:

Shouldn't the dropping of regulator-always-on and regulator-boot-on go
upstream into the DT proper? That change seems auxiliary to the fix
for the voltage reset.

>   commit 2abd7fff9ebf ("rockchip: rk3399-nanopi-4: Allow MMC driver to control SD regulators")
>   commit 210ab4f60df8 ("rockchip: rk3399-nanopi-4: Enable IO-domain driver in SPL")
>
> Without the boot-on flag U-Boot leaves vcc_sdio at its current voltage,
> and the I/O-domain driver sets the I/O domain to match it.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Tested on ROCK Pi 4A booting U-Boot from SD, with Linux running the
> card in SDR104: sysrq-b 4/4, panic 2/2 and watchdog reset 2/2 boot,
> where SPL without this change stops at "mmc block read error". With
> the card left at 3.0 V (non-UHS DT) cold boot, reboot, sysrq-b and
> watchdog reset still boot in high-speed mode. Not tested on ROCK Pi 4C
> and ROCK 4SE, whose defconfigs and dtsi are changed the same way.
> ---
>  arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi | 14 ++++++++++++++
>  configs/rock-4se-rk3399_defconfig         |  7 +++++++
>  configs/rock-pi-4-rk3399_defconfig        |  7 +++++++
>  configs/rock-pi-4c-rk3399_defconfig       |  7 +++++++
>  4 files changed, 35 insertions(+)
>
> diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> index 4861574636e..7a15f613c99 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> @@ -14,12 +14,26 @@
>         };
>  };
>
> +&i2c0_xfer {
> +       bootph-pre-ram;
> +};
> +
> +&io_domains {
> +       bootph-pre-ram;
> +};
> +
>  &sdhci {
>         cap-mmc-highspeed;
>         mmc-ddr-1_8v;
>         mmc-hs200-1_8v;
>  };
>
> +&vcc_sdio {
> +       bootph-pre-ram;
> +       /delete-property/ regulator-always-on;
> +       /delete-property/ regulator-boot-on;
> +};
> +
>  &vdd_log {
>         regulator-init-microvolt = <950000>;
>  };
> diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
> index 7f22aede912..dfec68ac4c0 100644
> --- a/configs/rock-4se-rk3399_defconfig
> +++ b/configs/rock-4se-rk3399_defconfig
> @@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-4se"
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
>  CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_DRIVERS_MISC=y
>  CONFIG_TARGET_ROCKPI4_RK3399=y
>  CONFIG_SYS_LOAD_ADDR=0x800800
>  CONFIG_SF_DEFAULT_BUS=1
> @@ -25,6 +26,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4se.dtb"
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_SPL_MAX_SIZE=0x40000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
>  CONFIG_SPL_SPI_LOAD=y
>  CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>  CONFIG_TPL=y
> @@ -52,6 +55,7 @@ CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
>  CONFIG_LED=y
>  CONFIG_LED_GPIO=y
> +CONFIG_SPL_ROCKCHIP_IODOMAIN=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
> @@ -70,8 +74,11 @@ CONFIG_NVME_PCI=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_TYPEC=y
>  CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
>  CONFIG_SCSI=y
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
> index e5c9072c27f..fe120db9b8c 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-pi-4a"
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
>  CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_DRIVERS_MISC=y
>  CONFIG_TARGET_ROCKPI4_RK3399=y
>  CONFIG_SYS_LOAD_ADDR=0x800800
>  CONFIG_SF_DEFAULT_BUS=1
> @@ -25,6 +26,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_SPL_MAX_SIZE=0x40000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
>  CONFIG_SPL_SPI_LOAD=y
>  CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> @@ -53,6 +56,7 @@ CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
>  CONFIG_LED=y
>  CONFIG_LED_GPIO=y
> +CONFIG_SPL_ROCKCHIP_IODOMAIN=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
> @@ -71,8 +75,11 @@ CONFIG_NVME_PCI=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_TYPEC=y
>  CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
>  CONFIG_SCSI=y
> diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
> index 4be7b0f8130..1a37190d077 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-pi-4c"
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
>  CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_DRIVERS_MISC=y
>  CONFIG_TARGET_ROCKPI4_RK3399=y
>  CONFIG_SYS_LOAD_ADDR=0x800800
>  CONFIG_SF_DEFAULT_BUS=1
> @@ -25,6 +26,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4c.dtb"
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_SPL_MAX_SIZE=0x40000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
>  CONFIG_SPL_SPI_LOAD=y
>  CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> @@ -53,6 +56,7 @@ CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
>  CONFIG_LED=y
>  CONFIG_LED_GPIO=y
> +CONFIG_SPL_ROCKCHIP_IODOMAIN=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
> @@ -71,8 +75,11 @@ CONFIG_NVME_PCI=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_TYPEC=y
>  CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
>  CONFIG_SCSI=y
>
> ---
> base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
> change-id: 20261103-b4-rock-pi-4-spl-iodomain-f6230f4d5eac
>
> Best regards,
> --
> Igor Velkov <iav@iav.lv>
>
>
