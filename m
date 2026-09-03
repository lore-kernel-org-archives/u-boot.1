Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DA5C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 311B360B8F;
	Thu,  3 Sep 2026 14:45:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qGgus7kF_U1h; Thu,  3 Sep 2026 14:45:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 56B6760B66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446726;
	b=qZQ8iLstUXO56ziV35rl7G2dVCatNoNjisxw/WDf0gQXpobqYeo6NFogHPBr2wGL8clm
	 9KDRfTiGl2B38QbArDiKI7OfFibsV/7U65AT5HOQ1n/w2bbdZNV4I7zKTtRMvETE2ClCx
	 gzjUWEN/exoAWA3eAEiIfaDs/N01G1kfXW6GWZzsETV8sN80MWzjerMXsgCN5HcBadjlw
	 w01NS256rotkAoflvVOkjNti6I0KVstqLUHRiCq/eCE3BDb5Qfji36XJqUj2gNs9ymdHe
	 ky8poNgsZ6tp1jTPy1AQZbz4gEu+eKIA79O0Hcf8ZrU8zifGxdUySJBWjMOZGIXn/pA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788446726;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Mime-Version:Content-Type:Date:Message-Id:From:To:
	 Cc:Subject:X-Mailer:References:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ixLM/sxuAUqHIHQHgAMyGuqRBqom711AbuUo01HcU/I=;
	b=jua4YKeIOxII3OJtlg4Rso6I6SNFD8g3KWt2PfaG3QG3i+rRQcuUX5tjUGOdVshwfAtj
	 PCLYtd+8P+liZVbXDdHY3QIZfSdmn1ABB8kyXBb3EAL9Ei4kWFjCKDoBSMLnHpBJvGqvy
	 /uzagl5xpuJm9v1bUjCzg+kvB+RFrQsVEM7BxvjWxuN9OoPIIaxBh9H+0KC9fzFZpq3LU
	 TdqwN/7TKE3it9moV3oTANkkSQ/A09SksUXh2E4/ixTPaQ5Hax/z1aIJrTPK2YdmxqNR5
	 XfkjcAcYAvAcuy8MSdwoOczTbCK0woVZux4FOFOLuvN/s4mtD9wVz9o8jFqsxQJpNoA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788446726;
	bh=ixLM/sxuAUqHIHQHgAMyGuqRBqom711AbuUo01HcU/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YPoIcqVu31DXXSr9YPEvyaAquWPUv4qPVR53O1EmFAxq4WD3jpi8xTBM6INsnwiRy
	 wBVj9erpK4VtyUz91bBIGK9UukYgiFtFy/dY15NaISbBRVyG1Om8n0f+McBSSqmZCE
	 s450F11Y1Y5OgKW53Mi/Yrzc4TTvSQt6edHMztydcqxvW+1NUuvqfKi0vv+Pi5OLuo
	 FCRi0KGFf+Kk55wWadkF0arsfDC185npWPJr4yM5/m1MS32GC5xVlJCd2yBfjmdnCZ
	 MWd7sMLEKJqGtgxXxwuSBbc4BgGGptaczuXi5j6CQgyGFE389EJhP+PHhJP87zydP+
	 +PgFv27LeVtUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56B6760B66;
	Thu,  3 Sep 2026 14:45:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C197534E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3B1B4046C
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bRiDZP-9idZ8 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8F7EC40469
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788446724;
 b=aE6+xoAhwY9/kin6Z86EvymbrKJah09e0mF1Z+gCfSmhjK8tZRiQx+tEfCALjf6iNcbI
 bM9VVw3sxPXL2GaKfRM3iHOInEJy4GcEyutowzT1Du3EHW0todIMGrPfY+WILtQUowjoS
 fNdde5m1tQK3gQKoamrFpEioFQbsFNdjKRu4BVF1VJv4HLE7nTenB4cBoO2q3Lo15IB3M
 yov/8a33kzNac6e1+8/Na4Pswee3TLAQ7sOi3l96Gs14h7u4jHgQLzC3wrRW87MRE04ku
 y2XKqu3h6xDvowIFiY/Y/jCBWpa0au3tbuvOoXbIoyR0/KAa4oVhJnVB6b8VCdJxtEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446724;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
 Content-Type:Date:Message-Id:From:To:Cc:Subject:X-Mailer:References:
 In-Reply-To;
 bh=ixLM/sxuAUqHIHQHgAMyGuqRBqom711AbuUo01HcU/I=;
 b=sXA7V0p2Ocez+2j3GzX7G0Xc9RvaTXHNKdnOJBtjyY75EtwgvQaSbiPRSa0jOQ6fZUg5
 75xLGdysxP+VqFfOwrXzZg9zEDL8ytzK3zGSNimXl/DS8JEfGS0R1p5u1b1o9NLVbuB6u
 Nd1cnh33rXH4dxsib550YK56WL1oC9NT/aEj7pNn5HHE6Ot5m6Wow/hfmg9hEeFO4Kc2C
 60XUgfsbfyRLS1fpzLLQboQ1AqdD9soOjw4Pv5/MdYRJAFg62lG7O1yZdYWlLxOfo7/zc
 ik11tZdpaYY+Ar75qYlp1fear5s2NlqQBpPOAETNdtfEUveVLlLT8pjCjwGTeTG3rUg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="eam/kbOB"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eam/kbOB
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F7EC40469
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:45:21 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-495590dde14so28368855e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788446719; x=1789051519;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ixLM/sxuAUqHIHQHgAMyGuqRBqom711AbuUo01HcU/I=;
 b=eam/kbOB8DFFNKk6p1yXXKdHeMp/kiCLLEcJLcvGgPkWwsTlD/VmmhYjuAnFmpNq9P
 uXgS/kB3eAPNzOm2g9LqcLqNixuAMD4hNbDdHLZ56+fixohVHlwDajIr/0mAqSQIp8/6
 cVM2vMqRwXk0z306GyraS4lZTMg7+VSYZvdniUyxxV4lcJotPb+vt/G03hlzDA/uWLPu
 gHk2WHjOc1z+k4uTJC8Jkc9JDkBwCSDssFBoOa5qw6lk23qZajeBjdNVp3PRgJt4dZvy
 uGlLRVKCOVT7v49WZzd6U/wnEKFxe06DC+k09xHhq6/jTMMZkAoCghHgg3S0265qtbiV
 nvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446719; x=1789051519;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ixLM/sxuAUqHIHQHgAMyGuqRBqom711AbuUo01HcU/I=;
 b=pQyhV5wvztjYywPkVbWTi1LTgMkZEBKKy1EBHRK6Rlb9erLVNE1rcEDWncVR0v45MX
 LAVtqXfHRPq9gRo8ArhV38df58OBGFJF0/y1bs7Z4kMvbagByDJcvs5BPhfghQzsm4Au
 rEegkKhTFzJHENCJD9XZgff73CYXQ89xAfmQ9gqrtxcSiTHbuoU6vUU56cYGM3G6+plQ
 RQt9uQXLz8yDRWbFqafpVeodX6Fv3VjnwtILfGqnCOCX8t0BBVp9FnKTkO88zytetZxn
 WKg/etwTQiiph4CSTG8eRaiVMA8Q0P6fJ9SRe10YZHYWAr2Mr6PX1z5cEGcqaL5pCCHh
 WHyA==
X-Gm-Message-State: AFuF++n/VEH3koUs+uxrNIJ2fy5LGlzTpJNW5M24wmwkDgmYN3BDgHDk
 e8GJecoOXnBCbFno1Y/B6inuHNmArTTIQcIP8Qb8FNkaLqmKBh4FPItMJUfSAW+HPRs=
X-Gm-Gg: AYBFou3p1RgPeiX9kTTf1qRmbt4ARFZ7eVWpOUFgfho/drIH1YSPapTcVV1Wt02Zv+8
 xTcxEonLvXcFXUux3kBR6wvAvpIOjgirXY0sAqAal2IrVEoDxUv5x8H7MJyGvrUbo0bjdULfpOT
 +gmUk3yzo6cbTqni0Epyhm93CNEEVFNEPStwTZyKHg2AWNid6FgJoQAaJ3FmIw1t7x3l3WFzQuX
 TqEvj4uHfYhP9c5xvkYPhQ/bxRoO9ZEM6c4cNTdnnaU/dphJVsPgRDK5Uwpx2yWev+PhWvsFxjl
 yAgdE3/sfBmPAOBJ4Z091KRsFWlsmttOz/weSqh+gOdDnlhR5WH2d0xulZGccMS5GuZxJOyV3UC
 KpiidbR31QShAfwP4Uzw45poFaTyQhRkC9ogTWjbDD+OeRkGWPTTBQ7aNvoM73DrJiNpsAnPUtt
 e4Uu8dfmLgGL0JOPH0Gq/GtHEJKiJFlMBWusYTE07DLADHSTO2SF9kSF6M
X-Received: by 2002:a05:600c:8714:b0:499:b65d:1250 with SMTP id
 5b1f17b1804b1-49ce580d869mr237953495e9.2.1788446719510; 
 Thu, 03 Sep 2026 07:45:19 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:489b:7642:1b32:84d6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d476esm84353255e9.1.2026.09.03.07.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:45:18 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=79abb5382963b14b652576412a099939c3b1b2be9a354692fe1aef418913;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 03 Sep 2026 16:45:11 +0200
Message-Id: <DL5RG53XS1VY.3PWDBU43LSE4B@baylibre.com>
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>, "Markus Schneider-Pargmann (TI)"
 <msp@baylibre.com>
Cc: <u-boot@lists.u-boot-project.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Marek Vasut" <marek.vasut+usb@mailbox.org>,
 "Andrew F. Davis" <afd@ti.com>, "Nikita Kiryanov" <nikita@compulab.co.il>,
 "Peng Fan" <peng.fan@nxp.com>, "David Lechner" <dlechner@baylibre.com>,
 "Johan Jonker" <jbx6244@gmail.com>
Subject: Re: [PATCH 1/4] arm: dts: am43xx: Add missing board u-boot.dtsi files
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
 <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-1-47e1c63d188c@baylibre.com>
 <20260903144032.GI1764417@bill-the-cat>
In-Reply-To: <20260903144032.GI1764417@bill-the-cat>
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

--79abb5382963b14b652576412a099939c3b1b2be9a354692fe1aef418913
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Tom,

On Thu Sep 3, 2026 at 4:40 PM CEST, Tom Rini wrote:
> On Thu, Sep 03, 2026 at 03:43:12PM +0200, Markus Schneider-Pargmann (TI) =
wrote:
>
>> am437x-cm-t43 and am43x-epos-evm are currently missing a u-boot.dtsi
>> overlay file. Add these in preparation for OF_UPSTREAM to include
>> am4372-u-boot.dtsi.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>> ---
>>  arch/arm/dts/am437x-cm-t43-u-boot.dtsi  | 21 +++++++++++++++++++++
>>  arch/arm/dts/am43x-epos-evm-u-boot.dtsi | 21 +++++++++++++++++++++
>>  2 files changed, 42 insertions(+)
>>=20
>> diff --git a/arch/arm/dts/am437x-cm-t43-u-boot.dtsi b/arch/arm/dts/am437=
x-cm-t43-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..bb40317cb28c
>> --- /dev/null
>> +++ b/arch/arm/dts/am437x-cm-t43-u-boot.dtsi
>> @@ -0,0 +1,21 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +#include "am4372-u-boot.dtsi"
>> +
>> +/ {
>> +	ocp {
>> +		bootph-pre-ram;
>> +	};
>> +};
>> +
>> +&uart0 {
>> +	bootph-pre-ram;
>> +};
>> +
>> +&i2c0 {
>> +	bootph-pre-ram;
>> +};
>> +
>> +&mmc1 {
>> +	bootph-pre-ram;
>> +};
>
> Not a blocker but a question, are you working to upstream these
> additions?

Not yet, but you are right, this should be upstream. I added it to my
todo, but I am not sure when I will be able to work on this.

Best
Markus

--79abb5382963b14b652576412a099939c3b1b2be9a354692fe1aef418913
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCapmH+BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNp
kwEAkuC0LXsSrmQtBGKKzvNUBGGEljx99T3iWWxThPbuLVUBAJtTWAn2mUx9aXKd
6S/DM1cDaTA/gG1IEbWSEEBnUjEH
=1Xq6
-----END PGP SIGNATURE-----

--79abb5382963b14b652576412a099939c3b1b2be9a354692fe1aef418913--
