Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB8606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ojtRqFcT;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CL6UzgJL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EC3E60834;
	Thu, 22 Oct 2026 07:40:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5fAuCGULRMWc; Thu, 22 Oct 2026 07:40:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 98B7D60818
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792654827;
	b=qgEZCzOtIYwxdoa8r61k1jVU7NMw9s1otA5FQluKRrl846F6A8BjQPEpVtMM9C+HU2im
	 sMnrQCZfZJj7nxf0fw1t0nP0R/Y88USo5ks64h4PN4++UErUINz6nIndoBvzJfFGVOfyu
	 qpvLQp6gQMPzecEMRNuWB+3BIjiqqelONPmDRwk3pyKLGC34KP9cIqppxzcFpah3pQ/T2
	 UxWdxi7Tw/RHminlP1LLIm/fxvNV+E8y2vUOYZNGvusd5MZjuhoOqCM5NhvWDJOaOSaWt
	 9vgLt5q0MrPT8Xtx6So05o1Bih27ZpH/RMhAKm37S52KVG8d1LyLxz2707bAPkMU8Sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792654827;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:X-Mailer:References:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FdzgjJuiUbjPCJpBSeATNfOpGexfvjyU7mtvQVWLQuw=;
	b=sidZIsBPe8jevUGmnw2UJK7MRNjD2D2FzPg1f4C0BfvZkVt9V1IRcyVigT2373zX/C6G
	 vimOAgVWy2ZKDBJwELbo989/jMdGrWerDdF9ppnE3B1wb3Q9hEMf67uR1OytKMYvqlgcZ
	 46Bn4/ojxZ5Sz8ATcD4HCWvuBBD4O1vmTVcldrba4IjVVmWAvK05VrNWNzljBKycdH7k0
	 cp6DU98gHQT4kx7AyXnWEnFZQzLCD8sWD9bKuongWBpCoDDB0FkzEeiZBHxThIwNLRNIm
	 yFKwATSP/Xt7sCEZLyARbuQ87KA/AvNFM85LkmYt064MaQvedzy7eSpjuCh4OY0q7Pw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792654827;
	bh=FdzgjJuiUbjPCJpBSeATNfOpGexfvjyU7mtvQVWLQuw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ojtRqFcTLwGbvU/kFsututNgwM/iQhq65D+zXhMiPu+s5x7schWQAc7FTP/L+bY+q
	 6C4LJ7HxlBFq3y5op3/XNdF5cjw+vl0cojsIiFVlXj6KYbYPtUZwwuQN430ECP0DYg
	 8Gi4+CRMxbglzia9tM6OWzcNsoVHFgF4gRzzQP2QqG3j4Ztf3S/E0tH2GHNmpvacuW
	 0BQ2NxaD3yD30vxAKi/lkV7xkEg1SObMmXGgiykHeZuqWtkFnXnoLyaCZBfH4gP75w
	 QBIca1FcIoJQd3MlGuhchB1/M/gOod4z5s6YQQ88Gu0ZHkNQ14aiKdDUCdfUEmeh0S
	 R/KapBpWGwmQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98B7D60818;
	Thu, 22 Oct 2026 07:40:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8106B3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7225D40050
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:40:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PhcRh4Z2TfFW for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:40:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B227B40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792654825;
 b=H8y0PdggJWFy9sa3IhdQpmjMt3STq+3xmqgVllBvLIe2p1EiMiAi/20EkAg7lXfWlmGF
 nQwKrZb0DPBv+gX02z0f+mQ3KYfuWtU/anB64QSprOqY+uZRhUIYq+nJlseC07z+Yaj44
 40byQ6LiexGQjgfuJXCgQe2VMtMll/g0WE5r0BoBEMmokEx6/ifNwaTaqTv1WKsOY5HIo
 UXSXuwJgmL5a/Qbh+FpoDjZkH2eT22YMJ5z4J+v4DTJW9zoHqW81DfdTzIgxd0wXFe+p+
 gIugygUB/36kztRIq3rbkj0GKV2xaHR5uWXKRNUmkIVrp82KRwgEDHHlk3igeS9OKSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792654825;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:X-Mailer:
 References:In-Reply-To;
 bh=FdzgjJuiUbjPCJpBSeATNfOpGexfvjyU7mtvQVWLQuw=;
 b=Ocnp2sGKhGgaDg+OFCLe9TUEA99qHDugmBQJl35yh+LUf8RJBD48z5cQFzB7MZvJCCXh
 yAj9+mtNCj/DEWy8SLYYA7/UUskkl1r+89TPxB3RpK7vyMNtPvlopxIR3Bo9topv//qdX
 Jc8kCCwjczamsXy0DlT8WJCfuOAlJoBBr6WdQr7rQGB83iasZ7U2n7RvEd4xF3iamWjNp
 cZzBzWNPKSea5FxoGEszF0rF3/K+mqPKjqIrveWXSpQs7yVa9N66O/Pd44HXX9bmM8KjG
 ZyzDvRSqfvYFKxv5LyyXXJmsquWIuEQC5y9lftx/vpivN4lwQD+FIWI72ojp0gw66AQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CL6UzgJL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CL6UzgJL
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B227B40042
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:40:23 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so12194445e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792654822; x=1793259622;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FdzgjJuiUbjPCJpBSeATNfOpGexfvjyU7mtvQVWLQuw=;
 b=CL6UzgJLLeVvR0FMA2Z094OQvdy/IGp+QUbF0ZbJAsf/MxK2gE216k1KGSwjv1D4Tu
 hRqKpuQYMXEsjw+JiRSoIxr2qGax2q89/EYtDHmqur9v+9z2kBd/7Hwm0fSNsCfYoHuq
 V5+P+r0CtrGQ1mUptPdrZUiMtEsLajgiQ4B2Zoolw48ye2Or/5LAU8BE2S36v7T29QoW
 qjZvPdWWYT0s/TpKMAwhWPh0OcO71UH9J1Jvu6m7lBAri9f/vwH7+iDAEQuMReilZZk7
 MgmdD1nZYc3SbCoq1/FifhgoPVcnV6gzPSaMRfumE6t/0kxeqkKXnWfpgeo6Zn9L7cQh
 x3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792654822; x=1793259622;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FdzgjJuiUbjPCJpBSeATNfOpGexfvjyU7mtvQVWLQuw=;
 b=X25qayZqyYZaU0cUaY9r0Tf7amddVjPWVoqp78jBsIOl5YEOWtnuESFj/4Ajrc3qS/
 Z/L7S/fV2JUTzRnZhP6uIzqLrTQVvr/8NjOq6eknEn3+hlGv0Pt38jEGjaxHHaQkWiDK
 g3pLJ023gnDBJvOzl7aSqtuzmtfOClFCGxQYKUgKYcdmLIRBQJN9MGPNFtn5YhObAsPF
 SN9RFoMeywraieSeC6pPvMTxtFQ/XPkK7dupogGP0SEumx4FwX36UuBjCEEXw/Xwfimh
 AJtAkGhg9Cw32xSmddG7B7CX/OVRE+Lzz5RpANTqLcsYU+Tlke5wuanDMlV7t5vJd3Bd
 rB7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtZXh4SEjov1rJkNitgXCowearezNZKjGaikeMVp8xQXS0ZpxtfzQ0Bg69tUDbHiYUFbUDx0Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLdwxfSVkbNuzoVGGY0qPsR8HPOl8D3WXtno/daX/F1D6raMhlV
 CHa4VmvQvd5z7F8HJIIfU1ean/gOzkp6picPo4GbdGXLp9AwjXwyJrbIZIce6FOtY9c=
X-Gm-Gg: AYBFou0w/VrnGTwjGLP3DUySa4jg1I/N1lflNJfOaEGrvn2RDT6lvLSSwcpveJYxdx4
 xr2PAkQa2TZSweCxBI42mmEg0Geb1SehOUe2eCeGlVPjbIPB11YCTOyZuDNf4LVSr7djzrSiJWx
 sReR6TFeI8lVsCoLwE6fmMIQhsPSrZmGTT/xjSIqAKNmXctHQe+M3ahJWo9RrYvV1pMT0vxcYKi
 xpeljGJjivCUWp8DGbGXJJelnoXuTiNqjbvSg3Ls4M+2Id0oX2JxIhpcc5eukPjIY9l219Hf1m2
 XmykeZ9G3GaUgdJ9XpxK53wqhcYQ4rLmI9pLCN+UE7IhFGwPs1VZl68tXh6wF4yJ595QJJXlwv7
 E+QUFSJYL/JrG+K8Jm7Y3XkRp6WRVu0eT6R7CUwZZTe8SryVmlAeHx8TfdhiZA5qekEnwmf4KNP
 PBd+3Jebrqfw5iqTUPLa1wirV2Rz/wYwNJQeHbcr8lkUCC/4mgu1AS9bin2Ho3f7mojS1XHm2jY
 W6T5ikI0Uc+dPgfzxmATqjUlCLFUnXlRfOfkFbg2YBL6e7Sj4A=
X-Received: by 2002:a05:600c:46c3:b0:4a1:fc98:1cb1 with SMTP id
 5b1f17b1804b1-4a1fd8cd9f5mr89881265e9.2.1792654821555; 
 Thu, 22 Oct 2026 00:40:21 -0700 (PDT)
Received: from localhost ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a207b29276sm50142485e9.6.2026.10.22.00.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:40:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=344f904e2de061aeb224e0f89337e035799719500b0d5e876ef0845a1995;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 22 Oct 2026 09:40:15 +0200
Message-Id: <DMB73H5A4SQ9.16BL7DVVMZEDI@baylibre.com>
To: "Judith Mendez" <jm@ti.com>, "Markus Schneider-Pargmann (TI)"
 <msp@baylibre.com>, <u-boot@lists.u-boot-project.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Marek Vasut" <marek.vasut+usb@mailbox.org>,
 "Andrew F. Davis" <afd@ti.com>, "Nikita Kiryanov" <nikita@compulab.co.il>,
 "Peng Fan" <peng.fan@nxp.com>, "David Lechner" <dlechner@baylibre.com>,
 "Johan Jonker" <jbx6244@gmail.com>
Subject: Re: [PATCH 0/4] arm: dts: am43xx: Switch to OF_UPSTREAM
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
 <4c846989-d5e2-4091-bbde-4d2de7a8c3d9@ti.com>
In-Reply-To: <4c846989-d5e2-4091-bbde-4d2de7a8c3d9@ti.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--344f904e2de061aeb224e0f89337e035799719500b0d5e876ef0845a1995
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Judith,

On Fri Oct 16, 2026 at 10:51 PM CEST, Judith Mendez wrote:
> Hi Markus,
>
> On 9/3/26 8:43 AM, Markus Schneider-Pargmann (TI) wrote:
>> Hi,
>>=20
>> this series does the final changes to switch on OF_UPSTREAM on am43xx.
>> Mainly it adds some -u-boot.dtsi files to define tick-timer and other
>> necessary pieces. It changes the defconfigs and removes the old
>> devicetrees.
>>=20
>> This series depends on these other series:
>>=20
>> - clk: clk-uclass: Ignore -ENOSYS in clk_set_default_rates():
>>    https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream=
-clk-default-rates-enosys-v1-1-ce3b87667c09@baylibre.com
>> - net: ti: cpsw: Skip disabled ports in switch binding:
>>    https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream=
-cpsw-fix-ports-v1-1-764e97251ef9@baylibre.com
>> - mmc: omap_hsmmc: Add "ti,am437-sdhci" compatible:
>>    https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream=
-mmc-compatibles-v1-1-24299cefb42a@baylibre.com
>> - simple-pm-bus: Fix clk -ENOSYS check:
>>    https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream=
-simple-pm-bus-v1-1-1b16c8f95051@baylibre.com
>> - bus: ti-sysc: Prepare for use with am43 and OF_UPSTREAM:
>>    https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream=
-ti-sysc-v1-0-e2c43cecc71e@baylibre.com
>>=20
>> It was tested on am437x industrial EVM with mmc. Help testing is
>> appreciated.
>
>
> I was trying to test this series, but ran into this build error:
>
>    DTC     dts/upstream/src/arm/ti/omap/am437x-gp-evm.dtb
>    DTC     dts/upstream/src/arm/ti/omap/am437x-sk-evm.dtb
>    DTC     dts/upstream/src/arm/ti/omap/am43x-epos-evm.dtb
> make[3]: *** No rule to make target=20
> 'dts/upstream/src/arm/ti/omap/am4372-generic.dtb', needed by 'dtbs'.  Sto=
p.
> make[3]: *** Waiting for unfinished jobs....
>    DTC     dts/upstream/src/arm/ti/omap/am437x-idk-evm.dtb
> make[2]: *** [/home/jmende27/src/uboot/upstream-next/dts/Makefile:64:=20
> arch-dtbs] Error 2
> make[1]: *** [/home/jmende27/src/uboot/upstream-next/Makefile:1442:=20
> dts/dt.dtb] Error 2
> make[1]: Leaving directory=20
> '/home/jmende27/src/uboot/upstream-next/out/am437/'
> make: *** [Makefile:189: __sub-make] Error 2
>
>
> Did we introduce a new am4372-generic.dts? If so, cannot find patch=20
> series in lore.kernel.org.

Sorry, my fault, while working on am5 I also found some issues that are
not fixed for am43. I will send a new version soon.

Best
Markus

--344f904e2de061aeb224e0f89337e035799719500b0d5e876ef0845a1995
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCatm93xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNf
+wEA7eX7XSY8mulTTDCQ56GXqV/UW7Z2lInz3KHtWwYMxYMA/1rifu1x4pWACNX7
k57oOpctxXoSZqftcxJsUSgWKt0P
=JmjP
-----END PGP SIGNATURE-----

--344f904e2de061aeb224e0f89337e035799719500b0d5e876ef0845a1995--
