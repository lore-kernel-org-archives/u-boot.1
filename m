Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD32606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c63kbdPc;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RPI1Q160
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36D0260AFC;
	Sat, 31 Oct 2026 09:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VGpNOkZkCTkm; Sat, 31 Oct 2026 09:35:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A9A660A88
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439312;
	b=KyoCGQDurAZl+cRjIUlbPDICmXdObMlgfVfwAxxn3G7jSSgq7S300zvRP1z1mRComRt2
	 ZSt/SJRN6rqvROeogwgDVryfExM2xo6qABc3St867JJu+/O6Rcr0+T3fOgpf4YjZ4Bjxx
	 uAJufn+AyPDEfpL+nufo6hEdbywcdkA53sS8ajSnN0bgNXevbWPvRQhS8A+Mb/Aqx/e2z
	 Ry8qTY6gihHSlAp+qYwfGL+fnZUNloYRO9MQ+gWVQGnDlHRo5ldWKMqBJ9jdeM+t/WjJo
	 H3T+X/UnB4qqiLwEtnIIaWF9ftlUF0nkOzWP1LKtf6E57SKh5m45psWWopEwpWfXglg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439312;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=S/YWaG6DIevKHgjNoadzeIwz5vHk2oQZopbB8EjWB5w=;
	b=pN+pSDcmQR0wrO8l9d9S0F8ztFrKaIYJ/VNJByzg9FC3zkCbm0nNcG19MjG7+7kzNsxz
	 epLQY3ANz/s1EgAW9XElsGlk2kiNdI7PYtUX37EvRbCt/P6OvXeHgfFUYLl4wU44MMkhy
	 ismHP+NPqzvb8kCcwPl5uxW6OZWnwC8m29pjX1od6x6Vju3rUIRpIiexivKMvqRhInXYX
	 dBvo0S2ETqb0H8jIfX7DpqYmPtqwRX31VZBXmx2OW9L9lGnU0zDBt+XSZKNvrUS8NZfVH
	 k2xS/HL7tmStu5OGGsQX3fF4N7UNwlGNgBOcoEzi636dDFjodKDpeCL+RHsvtVZWinA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439312;
	bh=S/YWaG6DIevKHgjNoadzeIwz5vHk2oQZopbB8EjWB5w=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c63kbdPcC++sNQZw8OTkp4GRAnje0d2l59p31V2rdoCMPIvJ0JNqrL2H5ZvyDZ1Lt
	 +VzMTBTiabZ+Oslm5LfMCzajYFneNTtgJF+39lBvjoVofTwGGwTcrGgIck6JquXhv5
	 m+XstaD2rgrEz4TXnGE7/PrrBNrE2buKZ8mdmJINEBJ2NPjqjWaQcuuwpU0aRL2+5q
	 ZgA/c4eV2lg0lkmIpwAOWTlRu1pgqXbdzH7WdjlpJr5QvIxu+0DJMD/6KEBopaMpKl
	 DcqY3SBYqXU6jVB5SFZHxPFXBrom37/5fH7t35/mU98gkh8LCM5HaJjLLkmQmq9/+g
	 +ltHWl4tyZKRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A9A660A88;
	Sat, 31 Oct 2026 09:35:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C72DC4BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACDE58112F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9s_0OBjAiB_c for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 22C3A80C1A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439305;
 b=cvI6WTlzFw2Ap15D3j3+BJCf/wrjRcIZiE+8iuxSWc2e/7S5hEO7bEPHSBaX7PlpE/+s
 4QBgvCZkpddI2pGbtXr5ugOE0TqxGaYXHczMQUCuWIgKnNjlySagkxeZRJcpkIBEDlPQb
 xUDHzIAr+9rhcx9hWwlhOPo4brMuok+XYqt+Z2KOoNXCUBzm7TrC/7HctSvJdb/HTBWXG
 3BekegIQp28oN/Al761c2tXBo6jeGWldpd4pOUx8WsP4XRXdR4INpHkqTLS5VkvvABmWO
 Aavhwz+b/ZjT+x3LhjkuZve7/Hf8SFh905m0fUSdJPd3LDx38CJBjpdh90hRYoeeHyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439305;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=S/YWaG6DIevKHgjNoadzeIwz5vHk2oQZopbB8EjWB5w=;
 b=nHr5nyN0wQHJQvKax903JRCl9Kb94Wsc24sejwYHg0+n5xrOGUJ0iE8ZP5xEnoIR/zIv
 s9FFBCecZ3u2cEHYoIA5zwMsp6cdRCk3YJr2xY331UUSSuyY53fevKZE8aCjNjNK3dZg+
 +o9Wvy5JyMQag4wcZfEB9kBJr5UJLqqu0Qwg6cCKvzj5xj4/kE0gxW8aGVxCM2JuOUH1W
 Lu0AeRrJft6OloMfekxAV/DNn8BtOm75dWtgLod/48TRH1npsKs3+xz1YnBq7kHzUqfH3
 4lgT08sfaXpPDB5EBQQMKI/59j0ZJmIDvzX6/27auEYNQTCBE/riexSx4r134OLoNLQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RPI1Q160; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=RPI1Q160
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22C3A80C1A
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:35:04 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cdab8873d9dso562310a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439304; cv=none;
 d=google.com; s=arc-20260327;
 b=EV37yW15usJa/QfPwSnFMvxOxNzIn7L4joOQ7by2iMBaMrVhTl3pIcwSaGiclG8sFa
 SOe2fb/6eI+DRh7eMcBcQf/ZPln0C/tzMHLkojLiSGX2MDlw+TAY3cSOsZdSrQ7jxx4+
 A0w/XH0rmR2G287ot/OhWdAFuPfTipZC5c6XSkUEn6Zrlnz6HZ9Dy/gjqzhovVqH2all
 vtAXU7qSBfcHjiTzSUcy+40oxvvZqgxwyDTd3ViCIEtIm+LQOma/wdGTUHglqRE5ayTJ
 f+Dd2aioupanHkTQI8vCNSu4KC2ED6i5rZgDABhu40Urz45UmOrEaVOxErUVWYqIB8pL
 bECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=S/YWaG6DIevKHgjNoadzeIwz5vHk2oQZopbB8EjWB5w=;
 fh=cQQ8VeWUexvaj6HnP87YmFHPSJrG26Btgg6bTe4/Xfc=;
 b=QCpFm018dO9PSPIPqMh5NwEGtJpXk5j4L/gQg2NYQEEYwa7ukltUxlOtAhIS/dtN/F
 yll9MT6nzoILbD+1jiYPfMNZIh8XgN0PKRK5Kkblo1WTjuSHCvVN8rBox20RtJUPAJgs
 cKUXTooy6JOIqxDfXeNEljNfpj3nOgY9eOQgSfsX8sDos4nezXEs4jiHWQQKNpdcWY0o
 j8Mjqdk/em7MFzdQJWeAnT6GcvG+CSSI6ibjhKR3FqcZTokDYkE6IxL/z4TJXRAWpAIB
 gxdYPXtB5i+wqRk+GgQOXYhNpO1nSu7AFRmBMisGGs2YqxWtTIIQ1Ilmn9oOQDurCINS
 3q/w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439304; x=1794044104;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S/YWaG6DIevKHgjNoadzeIwz5vHk2oQZopbB8EjWB5w=;
 b=RPI1Q160rzX+33bMEakhYZtSvvNuXWpTx52MiUBh0wD/fV4cuNvl7G0JDR2SNdcSL2
 43vDZTsA4tdDZJ7Ub9yCx66sTqmATMPguuOxhcAZdEhSo/I2f53HRkQrSB5ZTAoJgtwB
 18yLjZ2krdlfo7/oRS3NF9BUW/5rEfP6wGoGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439304; x=1794044104;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S/YWaG6DIevKHgjNoadzeIwz5vHk2oQZopbB8EjWB5w=;
 b=Npq6MkKTRtmxPQaZ0E8Cwz+8HQC2SJMnb51VQCUuzMUT1wlduAW3W5RA9XGEez4E3Y
 +gYtm4/R7pbSAWS5i+EtYSPw6vOtc3pRgrhgXII383MPfnqm7UKCwlQR9gQDpSODrpLA
 lyuXKEh9DpUUr0R3A0cY2cIN6U8WoEehvw5wDuDJ/T0MlzxhvAsCyJUNdQlMyxi1CnGT
 iTMgQnfYRIzGHFUCovA6iX/gRtQ7tCo7HJyQH/OPs/+wYMuL0fSNf4G4zt87MdGyloI6
 tbIZ8hgevNA7DfmYkTUdCdv7fdEJLC4K52kes6R11udwe9+rOgy02L+GJosqqDZ7a7Pc
 Qecw==
X-Forwarded-Encrypted: i=1;
 AKwUvByfywJkImn7jJNpqFokk5l1HJEZ/Zvjb7sfmP240Ueai+wKiIwZlLcDAQ9e69h6XPhz4B1zN7c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKhm4ars+t/rr3J9F47F3EGAEwmpHD/F6ODvmEFGUsTX6KvsK+N
 J4NfC4g0jf8ikaXw8JhztDIb3HXQ2FbK0iLkGQgoMSXv0cbDIi9eIR1qygKHwzhie00Wa83kSHZ
 J2sXrSvIH5DC6DNXe35L0GKgIEHoyhvLDD+d7Ya5htodzHeXW7E2iTw==
X-Gm-Gg: AYBFou3JCfksREllOjfk2E/4Tot5rPe1cZcs2YP8w93H9HlLkWbK1XdTMpSFgdY+wkN
 Oj7Ylh5f593jPuJeCMGqLhkvJvNA3aHsPiImMH2CZGHAbfBc1zZM5EClPQZHgnWQrkjRiIDJIMa
 Z9IWPzjibaMRRs9moHjFtNfVRYmXk/PzPZcrykS5QToRcXDi7n2PmceykMw3S/TK7p70C9laUKI
 WkjpsLFWuEXK44o/iiYTjsUY+UPzUIBElKG2/fWJsFtYWFCHxk9ZKgj3JXKUB+2x4HKvMG2YD9j
 gjOlKpqo8awdEhNX3FPTeIQOenzcyhLo9qIM8Q2GY+VsAfplJCyslLCzVs7c5HNd5GJYseLnPou
 iMKVnIfIle5PeNvuPoZ8zuSm11X558KaNe51uFKU7JAuX1YVAvHOX97htDHhK8kgxJF4y6ME=
X-Received: by 2002:a17:90b:4a46:b0:3aa:f2c4:12e9 with SMTP id
 98e67ed59e1d1-3ae8953617fmr4250976a91.3.1793439304066; Sat, 31 Oct 2026
 02:35:04 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:34:59 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:15 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-19-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-19-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:34:59 -0700
X-Gm-Features: AclHuK9pqe4-vsps0qFfKzIxhRSoR6a7PatIQmeCKG_MJ74V5s--nqcAnWiQCZA
Message-ID: <CAFLszTiUEPn0bQc=Pw2bqwm33KUgemtvtq+AGbw3SYsiaNN-Nw@mail.gmail.com>
Subject: Re: [PATCH v2 18/37] clk: rockchip: rk3588: Use SPLL_HZ constant
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3588: Use SPLL_HZ constant
>
> The SPLL rate is set to SPLL_HZ (702 MHz) in SPL phase.
>
> Replace '702 * MHz' with use of the SPLL_HZ constant for consistency.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_rk3588.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
