Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F74606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=geqcSC3L;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EVmJM10m
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22C4060AFC;
	Sat, 31 Oct 2026 09:36:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fMEGR6gNI5De; Sat, 31 Oct 2026 09:36:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E2F260B45
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439417;
	b=qtwEyxMLT1yRWZOZ4vfQAfkZEiiNzvg6a0fY7FVTWrzoby0w6fAcSb0Ho7nKAy3twVjR
	 QzMiOQa/Jr9MTEnvkzYHqWnzRnlQqMjvSFHbv8LS+Sueygy+8YtIolIG9QwRgw/Wxnpl3
	 eG6D+jb9WAzSNwT+4WO+GTr9o5O1CZfpwaLR59+WTccU0PNGr7om0hE+NhdpFPUpuliyo
	 wCS/gsQyhQ5SPkMvjthRurPS/XN0+K+YrKLSwfmGZLFKsVXAWVk8lgarX+DXO02Tyb9GN
	 aLALCe0vLTAE4RxPJE9VnHktH+6+x9pEnWlDa9f0KYfl58dj3UyNeB+dE4+fHLyrY0Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439417;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qtC4eNep8mdb4dTPqLvmdixpG58EtRuyJ6d73r7ZW8o=;
	b=TMy4OGjtRHdeMAFHYqg/QQ5jOf6TV5kEwL8bvK1YVm3D9xyYtc8noEvF5WhoC9F/Ajq5
	 mm6VkILHlwxaXQCTrYlzJ7baDIBJwQ0XhLRtyLTQSmrMSGWNfld+c6BtwIPjfespUtHNq
	 FCx8+JpdZQvqWG6rcygk2KoXC6bSBUjtaVltufBiP+FlX0PBPudX15DkAn5y/C6CEmVLU
	 XQ24y/JPGhd0lqcDnOBqWT/u1vhNZWrKoEd+1cPyPq9Vvflga5qaPg7BDp+sqxv9vIKBi
	 TGLhSJJrZyC1NbNfpQW52hZGJKCqkEaWcsgD7a+oUle84wHiWh6xSMEirphzWAQ5m1w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EVmJM10m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439417;
	bh=qtC4eNep8mdb4dTPqLvmdixpG58EtRuyJ6d73r7ZW8o=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=geqcSC3LVYN/IZxuByYCvbYwNQYJaFJNp2iz2ucdVPhZAhXM5r1UYY3oTffrURTu5
	 2PZD/NfL2jW+YlAFUBPBY7f4vh4z8yTqIkaHcRhl/fHm4Y6eqN53VWnW+d0Ujod5fq
	 VYBwdHS42ehUcYWzrDJws+/bU/bw56xJ2DVKuifpSX+Vn17zgbLNv2rCdNGTTHSuR+
	 dT2oHd3MfPvUZJ5FYPNngMzTmQ6hnmQL98FhNrmaHwlLI9kGUqyuWJFKn8aXIVtaV/
	 O7MAgJx7fecCkAUnCqwAJOeHjbPvEo6wLbaJkKOOseVxmS1rzliuz/TKkWZdDJD1vJ
	 ZdzlG4kO4BHbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E2F260B45;
	Sat, 31 Oct 2026 09:36:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D726C4BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C721F60A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z3cD_StXO7s0 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DE523607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439398;
 b=Ybfsgtw7NY3tkiBMW10bI6gf2BVqaNQWeZkBq9bgMxgYEFbrzV4e+axhN1TXIBxaiF72
 A8yXGO7rNGz4Z95MYbGbtZ+kUrd592kRjyU/MWo2kqDwyXyVgXR63ICfePpnSJFzBp4Hg
 sUYZuP/aybczWiyK+udlrjEX+1KO5ydmP4syQZJeF3G2QGjAMamItpoRaCbNsJb/juUy1
 gPckx+7GmHLPd9BFA+2gWgo4F+UoXcSD35gO0bex9hgWlRxjN8wLRM1gmN4AI649uYjmY
 Xi4LHfZNxOtBvmvdpc4FeMeNxjuzF8WPnDKEsoxLQbvttzvK4qTcXL5NJQFj5gf+xHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439398;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=qtC4eNep8mdb4dTPqLvmdixpG58EtRuyJ6d73r7ZW8o=;
 b=C/UQsemPxZk5ciHQJz+XkFMhscxOhROWchLBRxG/WG6dvbTwdBS8nPT8VymRTT1OFd9h
 8r/dOrlmK5gbpEUmi4pfQmOqitWc6sFwd89YIRrcBAIyT7MLa7cCdz9dTOGm/KBwDjnkV
 VagyDmM9nJnYe8THnhOF4YGmvY2Blp+o9TWXBLFwq7R+8nwPz0KNrJ5kf//LRPFfxfEyS
 yo5grlS9oa25cCJ3RznA+l7vThOEQS+m5AV00emuJAwNtqAUtR4DqOFq3WLTk5zWdSS10
 9PBsnN4AmPZWXoA2fKN4M5nllWWAT6vtaVN0T8XhFIUP6GkA2v4Z8xeKUeKhpwVvGtQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=EVmJM10m; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=EVmJM10m
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE523607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:37 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso258438066b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439395; cv=none;
 d=google.com; s=arc-20260327;
 b=FMvD3jrIt7QYT7D9G/6RT3Oy1Bu2Eh1o3uNIMzxNG3bkED/xmSbR5E/TjMKIjbL6GM
 0WmMQqaffje3wibF06N0uujuPHoObcQoOZ0IOvUfuE53b0e5bEmbgRuppMUjIXVRN2b+
 ihpvUdwrtowA/Iq5ZT2mYOPD8+RLxlriE+FQzYR5GqMi+uR71shYQG0VWODY/Biy1LmR
 I1W2857xT4SyBzBMlFs9a6L9Tl+hTi8NTtq5zcgsiHeJHq7FeAMWRk/EphIi4Hw8mSCX
 INbI46DHJG1Gz/CfIeshub/ea/it8Z8AykOYx0bLBUSctBn+pzsngrHWWYgMTomZzohk
 juXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=qtC4eNep8mdb4dTPqLvmdixpG58EtRuyJ6d73r7ZW8o=;
 fh=vLFGkJjzZEMjpnLf1wJbX66hvMIw6JmV95nGjccyifA=;
 b=JxmhdBY6X6EdkC3SxvX+CwrZSDpEV+d3cdd78t/xlSVbnSLj6p043a+Uf+rzBNVZWP
 dD5bgfDfaWM5vkgt6yRGVpdGljMPw1VjkcU42mserBAhGgzZzLySILKxfxTPLvNZdGIe
 Q8z+x0wGra6bNoBjcTLXmgatpQz0qcplSgSk7D4VZe0683AqrSwIueWM3+KFl8+sn6n8
 oU4/q8FuiQamUkE2wkfKt6duO+uIA3FW7Djc6XiqGK1G+1w6A7vRKiGEeelVORQYHFpC
 cyrOMMx0RvdBt21iviyjReJngeT0BZ7ITJWNNn9Ec8XpHL/emQpCm0Gq+FnJueFpubXO
 VCXQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439395; x=1794044195;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qtC4eNep8mdb4dTPqLvmdixpG58EtRuyJ6d73r7ZW8o=;
 b=EVmJM10mlcQctTPaFBAUExrkuoXj8b4Sa3+VnKcs0UdBzItjujrliwzWUMfj8OcbEI
 1WwCykIV3rFVnhhk1omqxKx50spdtXT6gIo1RiOR8oXxfiQhYkPKGyt2C2Nsq+7ovJL1
 NC/k0tMiGb3SfrZ9ecXJgm1j488ezM5u5wXy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439395; x=1794044195;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qtC4eNep8mdb4dTPqLvmdixpG58EtRuyJ6d73r7ZW8o=;
 b=ZNLce4hr5KM5cXCi3WJMSh6w7Yc4TIb3186WKgCBs8f5cSfi6t3oOxPvYKJP4p21dc
 5hYxFc3jIsQuKrR2yVGikgBJC3fpN7nR7xXn5jbmsGIpLPi9Rva99cMpAcee0KDcQHCa
 cIxV0gVM6cHjJFhdXDXYpwbX5EpwALOlKKYA3mM11+2lD1OLNiWK7QR3IOL5L9iYahTx
 sggJThd+yc6u0ruPfig8Z8PddbLDZkXjOXh2ZFUV3ljnlYD/7f4WhhAkf2iQzepaCEAn
 A4VA/Oqbz0lrlBwLDKVTMSG1scgGkWPTEf3R+es9W5H0efVbkxL59XikCE8/ASo09RDu
 JjHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgr2At4eP2KlRvQgZ545hpsrESrjuWYjn4+t/C/Ae5VXhLUHEobGq/auEMFSmqewUJHrga71k=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ2uSBhT+DUoB9KnaQcJ88u/RfWJ6aeMhgKEPTj4R1NzLEECG90
 Z2V59NG7qI6MkYMspgWsqMAOefYPPHMDdhL4BRZBOlY+WwHeWBsDLVC2qGta5vFLGQQyJWKCseF
 CPtat21hEsapYZX3Gu+X/hEeNSxjKNJmaA5MG8v16
X-Gm-Gg: AYBFou1401PRQwXCAJBDPt/AduL3rI67zlsXXDEWMlB3YOLwqpJc7V9c2cJbO6gMr5z
 t8pGFAHnSMAbeqGwMgSirftPqDCOrvXD5ZLnw9RcrJJ1Ff8Cv8Rgov+ktuj7dDabq1h2kJ7dqhD
 6KXqu9hjoqz6b5plMgFYt2spPKJsAx0YGJPGQ+uZi1lpIhgJ4NaJ6NLFwHiwjgmGpfHHr/iest4
 aiq+2wJfUn6yXVF6auGLw3hB/Tl3C7hcU7/tD90YTZNyxvLO/2NhQEGV8GMsZeJ+g5emZrZHVHQ
 EdLpCa6/2AMPYMRTxTOK7b9SjDjHY+MPA2k34EyQmFY1odg1inYW/oQSxkjb/sNF9Gv1aHSsvIS
 dzf7iaaxoZ7ReErUAlxi6XQbXqGjCHGHawKJyY8q+fS1YZFQz2mRNR699T3unWVv2yET62oKf0t
 EsutOP4t0X05RmUT8I
X-Received: by 2002:a17:906:9fc5:b0:c42:102f:15d7 with SMTP id
 a640c23a62f3a-c4ca7a07424mr352311366b.10.1793439388197; Sat, 31 Oct 2026
 02:36:28 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 05:36:25 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:34 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-37-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-37-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 05:36:25 -0400
X-Gm-Features: AclHuK83yBF4JVAC0twTUW7WqYVxXI-cMdt88_dzO-OWzVZO2douf8nL0mmpW9U
Message-ID: <CAFLszTgXcYAGmWwCzO0aTg4J3HQ9egzCrm2_Ro5xfBbxGY2jzg@mail.gmail.com>
Subject: Re: [PATCH v2 36/37] clk: rockchip: rk3588: Drop unused GRF syscon
 lookup
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
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
> clk: rockchip: rk3588: Drop unused GRF syscon lookup
>
> The RK3588 clock driver lookup and stores a reference to the GRF regs.
> However, the grf field is never dereferenced and struct rk3588_grf is
> not defined in any header, let's drop it.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 1 -
>  drivers/clk/rockchip/clk_rk3588.c               | 4 ----
>  2 files changed, 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
