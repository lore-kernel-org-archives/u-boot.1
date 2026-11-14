Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66CB606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AP3eKxxd;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gN9cCl8a
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEA6060715;
	Sat, 14 Nov 2026 06:53:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rtFq3Vf11Cdy; Sat, 14 Nov 2026 06:53:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 45A8A606CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794639200;
	b=YV4h6pru29akxtGpLI5vBaHW6fdYQyaxq2cxjts/+gsRB8FfbLckauDbA8DbooFOpWCG
	 G8+YxOxcDgt2oXCSzniHvaPhmyVzFWeMkuVyUQV/uyuPhgbIcmJNI0K6DUgE6hiI+PLQY
	 QLglCug/5isxHWkGjxqCaxg7ydg3En4xyz+0UE+MqgrVdEDlodLgap7OYdqH0o0xH8tGE
	 hBAl/C2YGUntP5lhnvjwrgrlafDWiDz6JRwxK13nYNyh1YvheCM6zzrtOfMbe+DlkWWRW
	 D+ooPDit97nbQDwDmj9lAm5mfj31RkwwdwE/AxRceGLCjmBShPgT/EYGVo33j3nnetA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794639200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OSzQwfL0s4GJroq1CpEHgctsdQ9b9gmykJIxVzNP3bI=;
	b=KfU9Gc/nZhhkUtWC6bMNWo8dOkj2sj5lIw/gR5tlc18IZfPvH9iTahTluP4zs72mOpuv
	 +i+piNWIu7QYwMglChwZdMDFCdGZO6wUuAuqtu0xcy/YO4n7L1UN2gUFdW4crMKrSY0gG
	 zKu+IagCA1cq2AxcIHFoWDV53b5YLVOKyoB7oIQrEpdsD2/vkj4GSudIay7XJSjGl1qBq
	 /EhlBH8CBKiuhOLbSfFytf6olzY0NM5HNbTl9UEjr2jbFVg9icjnzKq2Tg4ozXCaEO3z4
	 E+gKKzbY6WlpHYqRaCmC5hmWpDy7ko5QIF5to0gNaR0XYbG6lQ8Bf0/ySHz/ImuRshA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794639200;
	bh=OSzQwfL0s4GJroq1CpEHgctsdQ9b9gmykJIxVzNP3bI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AP3eKxxdBYUPRju7ZMU28ks5NZ5pXZB3QbBvHjlL7ViaarN0YA4TUxmdmKKF7wX+/
	 EMDu0pFBg/Sm2GtsW2b8JeEkHjWYmN1AzLQffMfWqxZlDmqvgovd9fUPnaPCQ/sRxS
	 bJA+jArcsKjFnGZTqAGJrOeQUuMzupQvl1LSz1QGajNh73sZkDNtooUqcocUmvDzIQ
	 DUnSD6G4D4pWFI4JAEkBRpB6Jw4WPUj4TYCMPn5utpTum1q+8Y39AfX9vmDvzQ+ihV
	 JcEKYOUjnwHHaLbDlMw+p15imD/WeFenjIGQdzTw6zNtB/DtJ3SffuMm954aQNIxbq
	 NhHTUQSkxaSYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45A8A606CE;
	Sat, 14 Nov 2026 06:53:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5785F1A6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 06:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3620A400B1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 06:53:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mYgpdn7R17xB for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 06:53:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5C55740050
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=ehristev@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gN9cCl8a
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C55740050
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 06:53:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A4646600CB;
 Sat, 14 Nov 2026 06:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AB31F000C4;
 Sat, 14 Nov 2026 06:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794639195;
 bh=OSzQwfL0s4GJroq1CpEHgctsdQ9b9gmykJIxVzNP3bI=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=gN9cCl8ah9AUBQT6+mfHB8TOH1RXhiNDB1dBTkY72yvGCrCAXC7boZ9ctUf1tQ+2E
 Wt6vDQhgeNpJA2wKlxBNGpST9cHERF/HLNN9Ai53M1EzOgzPzMZjEz4wGJOIy5Xm2b
 ys3wZRhHaaqwotyeYq2u+Duk44rePW88ka2PzDmtpfGbfa793dysB55SRjXms+vUTD
 Ng+X6bw0aaChWLaOvMSVofM6H7bMp22zluga9yZaXsUmpWpo5Ice8qyIMQNwLdZteM
 emW1IEJdXqI3zwTy5XShBvWiSu0B3C9Th9fkaffqUwhoa37nCHt/EnKwt6Fj+AM3iC
 2iigWybitPh1Q==
Message-ID: <9a0761f0-f16a-4dd7-b197-5502dbec8d7e@kernel.org>
Date: Sat, 14 Nov 2026 08:53:08 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Remove gurnard board
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 cristian.birsan@microchip.com, patrice.vilchez@microchip.com,
 u-boot@lists.u-boot-project.org
References: <20261113154504.1213229-1-trini@konsulko.com>
 <c866b80f-81ca-4192-a128-19b3f9de76ee@linaro.org>
From: Eugen Hristev <ehristev@kernel.org>
Content-Language: en-US
In-Reply-To: <c866b80f-81ca-4192-a128-19b3f9de76ee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 19:31, Neil Armstrong wrote:
> On 11/13/26 16:45, Tom Rini wrote:
>> This board no longer has an active maintainer. Furthermore, it seems to
>> been untouched, aside from global changes, since introduction 10 years
>> ago.
>>
>> Signed-off-by: Tom Rini <trini@konsulko.com>
>> ---
>> I'm not sure how popular this board was, so if someone just wants to
>> pick up maintainership instead that's great.
>>
>> Cc: Eugen Hristev <ehristev@kernel.org>
>> ---
>>   arch/arm/mach-at91/Kconfig            |    1 -
>>   board/bluewater/gurnard/Kconfig       |   15 -
>>   board/bluewater/gurnard/MAINTAINERS   |    6 -
>>   board/bluewater/gurnard/Makefile      |    9 -
>>   board/bluewater/gurnard/gurnard.c     |  426 ----
>>   board/bluewater/gurnard/splash_logo.h | 2619 -------------------------
>>   configs/gurnard_defconfig             |   63 -
>>   include/configs/snapper9g45.h         |   65 -
>>   8 files changed, 3204 deletions(-)
>>   delete mode 100644 board/bluewater/gurnard/Kconfig
>>   delete mode 100644 board/bluewater/gurnard/MAINTAINERS
>>   delete mode 100644 board/bluewater/gurnard/Makefile
>>   delete mode 100644 board/bluewater/gurnard/gurnard.c
>>   delete mode 100644 board/bluewater/gurnard/splash_logo.h
>>   delete mode 100644 configs/gurnard_defconfig
>>   delete mode 100644 include/configs/snapper9g45.h
>>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Thanks,
> Neil

Adding to CC some people who might know if this board is still being
used or not.

Eugen
