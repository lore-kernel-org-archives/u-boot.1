Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2757606A33A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ANhxrTr3;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=atJ9BIpk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC73040855;
	Wed, 18 Nov 2026 19:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jj4kKDqrDHGy; Wed, 18 Nov 2026 19:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2788F40844
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795028923;
	b=p8JzSZP1IuZN+rH9JX9KP5DachnzIJF9GU+Nt6WQkWhjME3aSsDMj6RcxQliG1RSEK1i
	 r2J6ZTiQk3JAqfPMypZsmYPJzks+uEkATRuJU+P4s11uyfLmKmaMRVFeKWQdOTdtqC7J9
	 PDiY499cYw8Z0UOszdUVvlvtNcwaCrfFbtbKtWkTTEDnudXFeLOTgB9OqwQp219xMa/S7
	 nj0WJs51K2M+VtYVraRr+Tc0UvUFEXkkjizqSfkTOSoKZ5oS4Ghu77tFzs8VE1HZ4ioho
	 WTKjmiAp6FAw3jHhJ6FTENYEV/BCjndCIIMFWEkiqIuRGCPFL8bl1AY0SlotdsF7Eow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795028923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Cr9FuQbjGclxGr8fbJNtSjJAsyCZJ0zyeKwJxf71S34=;
	b=qBVVkQofDZoAY0/6sdkPoXmka2WQFJG6grVbXQljZhDgFhYePPDyGSeHfOu3tblhKEsc
	 Ynd0D/o65lRQuTy3B3mPouWjB51UnnLIH6CdMn71EsAgoLb5T4z/rakotTiZ8rOCWOKrN
	 Asvlwzlq1oHzDzDmTtE5sOEKXAc5BO52Vf+sF1q+duS70tXjEmIT1yVzSJRVv5yhpCEVH
	 sOd0GoU0hWadn6IgBkD8VwPls8Qe3VYMH5zJ7AaTe4XLBGdduvWKdsM3FfO5PLp5+oCj8
	 4iRsGQJ/8Bs6VoW76kp8+ufSdNQOOit07m6UTVBNWMCgwnrLyzxH3owoF4OIYSp49Gw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=atJ9BIpk;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795028923;
	bh=Cr9FuQbjGclxGr8fbJNtSjJAsyCZJ0zyeKwJxf71S34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ANhxrTr32W/ts674kLI+yLCUMwx2dlIw20jRp7bOfAReyUYbSJ48VDcomaHd3S78/
	 SUVUo8UkPho0O71iMomBW4+nDB9bP+itZr+rR6ZOnKIRq8kXMINe4PnO3NNHG0zsbq
	 PgSLtdbd7KVVZUg7DrfzVk7A2q2w+AaCJUMnf5nmnXbaC3nHvNFTcLGUGtye4XWm7M
	 jmrPXn0KNZnR3rvvemF+Ole7leEkxpYHJa1uLvzscBlDg2LwMfaMYQ1DIBfR2TXkaa
	 edo2AWf0FHUf8/Wl8mpQwH70B4YB5+Iq+Q2OidhJL+56dKpdyhYdgLep4kiLy2tEVf
	 6E83sD8luCgUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2788F40844;
	Wed, 18 Nov 2026 19:08:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 98ADA977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A05F40822
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Amez5IAZdX2G for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 19:08:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF6A74081C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=atJ9BIpk
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF6A74081C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:40 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4e4a4d77e5bso124001b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 11:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795028919; x=1795633719;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cr9FuQbjGclxGr8fbJNtSjJAsyCZJ0zyeKwJxf71S34=;
 b=atJ9BIpkaEk7Savv+5L8/W0kDzkF71Tj40Qu1wkNjBYWv878l2n9Y+pIvIM8/bjAL7
 2/lvgyYhauAmeOjxj6kxI3sgaaQ6kKEsIb3i0UDaoUaBJgH8+gdqh41ylV1yy7NDmgCH
 LwaFWls/3or+fv0i0avI6+JwY4el9vnEhxu3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795028919; x=1795633719;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cr9FuQbjGclxGr8fbJNtSjJAsyCZJ0zyeKwJxf71S34=;
 b=DvhuOivLCChO67XKOybV1qpfbhst4K9Kg2sDe80SzxDfCgTeTkBPvAFa5rxQW6bE5j
 Wk4NsV6YlmRbZRWtKtdt6pNUTGBV5sVQr7ItgMChlTYp9vaVMSBKs9WCQ3YUJRXHw4Sw
 2Mcb4sRcaMKL6NXJ9eYMqhXV2cynrVcT1VQgCWVm0uD6gA+SPFQW7AZg18rfXc+Qd5vI
 qsrdclbasSRtaAF4Zzic6M/vxMoWCYqlJrZyLGhdSK2u0W7PxtZtffJ9SBHyMBFMwR5L
 PtvkKccw+3UmZX1HZlCzGCYF03pmOOKfo9JUSSFwE1mjCwwtOVTe099iX9tB8FtPMraS
 A01Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEM45TqW0vNLftc3W1tlRSojtYVXlVTPUM6jpq9XLscDgnQRYOQO/wbZss3OqQnP/sKVDXDbUk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+HUhW/AP+eAV87Ym9X7JOHg6N8qBvQ54ogH+qyYvluqRnx13xl
 EhguDtxHwQk/DnrWXjwlOJhYHQJ5qP59BHDE7l2oJkFsx5MViiUrqQS/bGu++utnHcs=
X-Gm-Gg: AYBFou0x5UeR+97nCG5A5QL6aapoIcPdqgc+Cl7kgojp1QAvulPsYACSXVsI9sh+kBl
 1AL3vBTAL62W28STonxt9/amQPOAl7u0PLPiuR8+zzErmc8/dUg2uwEL5wXc/POdbuqV5xFmJWB
 oSSmHg9L31j0MZvmYmB6JgOLSPvR9U+YKMSrryBDTS4roLjZLzA6Jzk/pG9r7qDA1tySweMIUkw
 1+Ris3TjMGRv0tDm2rEYirmPk50T0BSqUeyQAelZFKcjUNfYewICik1T3piG3fIieHV6tlyMnHP
 rR9ZcB5iAuHHR8SPWq64aj3vYk3hsDnKX+ny1JkhdEb7e/wkEIASbF8mkxj+++XLZ2E8RBJr1At
 Rm4Lfja3/7pJfiIrAh+uTJfYleM1QE7UXhsdVPXOfUnpTVJA9IPqEvps9su726Wi1o8i0hu1VPG
 No3CECNWuAtmxp52eWKBWriCtG+isGqckHy0ZY+N+FW0GuAVmL6cVYG37YlZ265l50eUlV1rJkG
 jbEpLn13NCLnm9X2KZ/CIKDTZuZajPdVWfp9dZQVg18SuVZFIHalSxXTsd+odEWC+J0+Bo7MPmK
 9wxwqLhf0x7q9mrEgzP8LrGRUTOugKm7v1mfBfrQqZnGOFuMpn+hAPBR8aHPTjDJrdWVJPp35zq
 kyWy33BuvAFT1HymV+3AWaOYCocRjLVn6kzzeR2uYC6PovwGs8WK5T1Yg18iRN3GeJKHo0Hr6iK
 EHMVYgTJ/ICyYgFYhApwn/UYxskbApuw==
X-Received: by 2002:a05:6808:1490:b0:564:3e9e:b498 with SMTP id
 5614622812f47-578b962b86emr358949b6e.22.1795028919293; 
 Wed, 18 Nov 2026 11:08:39 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5777b39306asm2052999b6e.15.2026.11.18.11.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 11:08:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
References: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
Subject: Re: [PATCH 0/2] bloblist: fixes for transfer lists from TF-A v2.15
Message-Id: <179502891804.3148473.14798016712366176426.b4-ty@b4>
Date: Wed, 18 Nov 2026 13:08:38 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 15:23:07 -0600, David Lechner wrote:

> U-Boot cannot use a transfer list created by the transfer list library
> that TF-A v2.15 and later use. The first patch fixes a hang when adding a
> record to such a list, the second moves to header version 2.
> 
> I found these with a DDR loader for the MediaTek Genio 720 EVK built on
> TF-A v2.15, which passes a devicetree overlay to U-Boot SPL in a
> transfer list. With both patches, U-Boot proper applies the overlay.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] bloblist: align the used size before adding a record
      commit: 3020578a97adb5c38901202ce558c4692399f159
[2/2] bloblist: move to version 2 of the transfer list header
      commit: afdf96402c68d1d2f38ccd47e28c7714d0f674c9
-- 
Tom


