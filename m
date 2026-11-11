Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A0606A32D
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sfBgsrLZ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XphXjTAg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 010DB60888;
	Wed, 11 Nov 2026 12:04:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_bExbGzxmIF; Wed, 11 Nov 2026 12:04:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3DC7260796
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794398676;
	b=U1YiAZ/OESh5kOcI5+hv+snt1uBsFgkjflw1dhX0+h3t7+FStzBwQ4mx9MomAPAkyP6H
	 vDSYUztv9EbNIPpHcHgKlRqGnFTk12FEjQXFXbpGWPQV/z1YGIGjTFY3roZ3ucpYi5a2N
	 5sTmqGA4OOfE4JHeFh0UKwSfhLgoegEVHLRJ2MjxAMp54jN8Z8fPYTUeUe9/gDOjsNALp
	 uXnpINtPjNNFIgocQOhpggLJ8iOW6wDmk4NQ3jjxvA2BCF7XOmRqRmHU80sqFj5APeQIP
	 YV58NYJwvfyOzkfaS2be5fzYfUMaty7gB+uJrqNHqKe529trm7Jqxy5nfSLMLtY+SFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794398676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HrTN7o+nQMCofB9wsTRqNWTrQjssSvyGH1A6XOQoE7o=;
	b=tN6MPHkjeeMxbFz2PXkYDs6F3rA3n0eroRoHiNPAW8fm6TO56m9Fdse0kIJ28rApLxNJ
	 EQQHPABMQMpn8Snn/H6rbs5qgYQH6Vf+3p6tQF1FYnPm3GhzCMSvj9ZtwwYl6nyK1IO/J
	 8ghvyx4oF8wzgJRsOEYubkVhe2JtwqBj35uxE7hgcB2drqVVUcxL+ywgGKxofEf/hjiEe
	 JuSqI+r6jHCtUtjfexSSdjf2kPfAC0BGeGMCnoOGDHwyihjXG4pEZ7fewzkgmhV8uqpNd
	 au29mEK+zGyxEqhSuPI1SV8nnTTV/UpmFha7Ynk3j41RhR2CZ7UOhGO/KE1d7zQNrGQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794398676;
	bh=HrTN7o+nQMCofB9wsTRqNWTrQjssSvyGH1A6XOQoE7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sfBgsrLZubS13vHKH6iqIff4V8tlsWkUgH0KRTXxx8ZLKpv6Sq4Ak8m496thtF9vC
	 F82oGK3q7FG5BFDDCiS4EHmRatgbMX0O4p/M5bHtwZdStcdrLKbccgvWZNRUFL9wXc
	 SXk7gIfKO3wjLu0y9lmVQzNGbxLO2wcf0V1hQu0VbqaOy1cl/pxZS24hMstoLOMuuO
	 P756StA6nx8P8Xtuuy637TuNb939LsFoNNXQIYAd0cWHrsZXckt2QhpCdgOy9oy2Su
	 gwpcc5fZ3S/o+OKHuLOlyhO18IU1DKIe/bZpRgTVveluhAeO/wSrax7n486JNAOMw3
	 rTVYUt/LiiGIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DC7260796;
	Wed, 11 Nov 2026 12:04:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64E2E335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DBBB40A30
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:04:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0TKYYgGXmjut for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 12:04:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61C68409BE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XphXjTAg
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61C68409BE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:04:33 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso1855450f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 04:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794398671; x=1795003471;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HrTN7o+nQMCofB9wsTRqNWTrQjssSvyGH1A6XOQoE7o=;
 b=XphXjTAgglXm8631Xy7t4njEaHIDDubBRFhnpsMOOpzjr+L6DtK5d8n441C/k8cf8p
 tqHOl2V3g3pAI64OpmJFftIqXiQXw4cDq7yuwi/YmxLGHIL9ZjNHwePHwCt7GHLXdaGa
 HNIcFtmqWvigXCDhPlgibxmI7MfgexM/3ELF+DVASjLaIyK+zow2qgmDWJooqW0s907j
 ZqDdmCqVQlnHloiEh1Mu+i1saEv9FERytntaenZm9FGpCi5DN1xqBhoeQrzthdhPC8El
 qds0eZi2dWluTxTi1r8oUMC8bdEgfRcjoE2KnaN6WdGz6vwTB7YxHlyMW64FJS/AELko
 xACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794398671; x=1795003471;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HrTN7o+nQMCofB9wsTRqNWTrQjssSvyGH1A6XOQoE7o=;
 b=rEjSSqJ0XaXPdV2trrAUdmKDOc03vvyGh8qI+gjII2wk+Cs/16WQvWHF4huNnWGEe7
 wLloIIT8EwVWQKjHzvJ4rUoJIffuwCS/2n5BCLLiT0dkwhfVcvw41S2UH/6oCA9+O8a2
 Fc8ABg0YkyO98RIrlhnHYgmg/y2Yu7VI7mgB7MyCeBOpSjrXlpODNTvvC2isOxoWbrcL
 cKfQ5tlYInzIpWFN8y8Yw/n9vkmkGQo+dTINTado8O0E+hcTvXDsT5QLELazn0JmOER9
 en6niFAROjicPVuJ6Banp9ntqGesn5P+60qP37JcVPLs70/22CCmaPpp3jwUkxVw6bOr
 eYjw==
X-Gm-Message-State: APuU4Z/FOXpFTdySeyqhe034E/Y77KV79wN7KyvOwnXLxwb2yTusxvLS
 xm8ALA4egFjnDGzz3aBh0VuH1M2PWNnyRBMY/qtCGTkeVMhv31jGYs5iJnwEVGzRrMk=
X-Gm-Gg: AYBFou1gy4qa0v2e7zIqoZH70I1JEziBisc0g+BlO232tq7BJhhd736d4sP/vnX3vFp
 qRG6pc5bg0/OGiau8vACw3NYPylVoBVlmIC+wg3GVoaqn14+6Iakw3ULARJuxKT1Y+1bMVW11M8
 u0EGEe2N2wKgYnbesySqgF/9NnMWyH/uDyUYJfcL90zVKqZQnWGC9KWtaWy3CiC8rwB1gJGH8oG
 wlylftRqOlXs+ESpfRU3edq0VFF0+k1Cio7uH4JrCzIXiersRShw37zmNHEgvsd09FWSWUOzqjL
 jwQ1Z+xzbV+Yf6Vpd2S/EeG2wy2+u01cH2JsD7ZlZ1DIrJMBMf4Jk2q/dby/V5LWDwgx0bNRf56
 hdVF2us6/q5A8JPvb8prGiiHB2594LV0uR3E+50HkYJASlE8gEPazED/MR5/mzDlBM41edChC38
 K7VPDp7xwBbYblYXq9TiJK9hGni6khE7ubX+DhgFKxtXaQDlGEjqosxwBI0xW65LobpurKVRcU6
 lvJbRVj3D0e3W2fQhuXQr17kqUE2zjQT1taJuDgeHhkfIQvK1IbqYq9PJsuPvd/fifXNhKbPfRk
 zxCc8V2e9yF29B3NhHA/fHnfvf3XqbUrPqmHaHoTmUgDW1+Oveh20Uv7ioNG+PRviN2VhS18f7c
 mMWL8i0I7N/l2kaHLMXjlCitHXEsg5Yft5g==
X-Received: by 2002:a05:600c:3544:b0:4a4:de70:2ad4 with SMTP id
 5b1f17b1804b1-4ba0938e165mr39434415e9.22.1794398671455; 
 Wed, 11 Nov 2026 04:04:31 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (mob-83-225-17-246.net.vodafone.it. [83.225.17.246])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe2c5asm207923425e9.5.2026.11.11.04.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 04:04:30 -0800 (PST)
Date: Wed, 11 Nov 2026 13:04:24 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 7/7] doc: uefi: mention UFS RPMB for OP-TEE variable
 storage
Message-ID: <avRZHwuIPVrJ6pw8@macbook.homenet.telecomitalia.it>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
 <20261111-genio720-ufs-rpmb-minimal-v1-7-701a62dfa034@baylibre.com>
 <CAC_iWjKA6T2g651b5SCE2M+AX5gJkdswnUdq3YhYNsUToQt68g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjKA6T2g651b5SCE2M+AX5gJkdswnUdq3YhYNsUToQt68g@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 13:41:38 +0100, Ilias Apalodimas wrote:
> Carlo,

Hi Ilias,
 
> When we designed and implemented this with Jens it was in theory the
> abstraction we aimed for, but has anyone actually tested it?

It was tested on a G720 platform. We created, updated and deleted a
non-volatile EFI variable from U-Boot, backed by the RPMB on UFS.

The stack was this series + the two OP-TEE PRs linked in the cover
letter, using EDK II StandaloneMm.

--
Carlo Caione
