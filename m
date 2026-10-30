Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2700606A32A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KPz7Vk1F;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=N3Y7UNfQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B14AA816D6;
	Fri, 30 Oct 2026 17:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oY344GoFmAs4; Fri, 30 Oct 2026 17:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C742881685
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793381199;
	b=samjCd/vzRslsg4n0eqeTnFtDAgn2ffrm7J2YF0kf7j9YlxfuwmE2CtOqiSTGEk0otEI
	 MwrpdLpb2A6ASXKCsUjgAoq05TFRMc5BNAfPeig5gH/YaXhiGWMQIDrMEsS7qPMnL48wH
	 Sp2PCp1siRl6hfmRTKclRFxlj0p09HjafcLGMyPtzZc06p0J/qrC7WDxsXDfEFA77mhDa
	 D5JiL6IPyv1ETGlTFhpd1QM8uNgNsmW92tq6jn1vNgVLVto29UixwglDBA8TJuD63PL0D
	 igyRqZ6zxxMmMhrw9py7+SyqESZ9cXy+cb/3BB9xSPCkVhIPjuDeQ2EZUMzKZChhBfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793381199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pQT+cROjVZJs/EuzoZhQR4u8Y0J8WqCsnYzwYHF/YEI=;
	b=VPt9buFemT3kJIPCKjRRnQ5VjcnA+ulCrbSLHniLIQekP1u1AWh0P9Kvj+k73jhlFmyH
	 hlWQ45bfAwm/6uznO9lQMNEHwno+i1J0yfu06UsWiwnBAorIkpT/KJ64pdVzfbOYLBJNq
	 MKGeqMemqaRg84+0NiFHWCX8m3arRvJW2UgDq6RbCvyZfSSvuS3+Vv7XYauObkdBqkxJE
	 57i3noMMJDTXdLmrtXwXxVaVW4qA/DCVXKksvNnnaOQ9PyWAiGq2W0bTI0dy2/kBWXsM5
	 +PGt7k+QvkfEp1+qJJfEYYyYZyE7mWeESOIKT9Wotxq1neWXtbtME5+6BXnJAbeuuqA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793381198;
	bh=pQT+cROjVZJs/EuzoZhQR4u8Y0J8WqCsnYzwYHF/YEI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KPz7Vk1FDoKEk8fRQQ6lgpAQM+C59CU889MnfqPEwHzSuhLbU0KYEv3YCihsG0DyO
	 wwyM1jkebdfhNy2lU8sff1Sxwp9AvaESZz3Kw7DJ1HWvlGAaeUbFPrgoLuwfIexKxw
	 n4bdz3p0FQgAp3bxU4TjeKnlXSOD21yzPj8UzgVIbAEqdP89/CUQ2NM2nG51fqw2DR
	 5rBW3/NnDZtYweucilff9aNDsy39fnfPZ8LTNH6uUbP2FIJ/kCIxhZpyrSc3q2rsUW
	 2KxBJEeaP2teZHibSNVeOJ5/KKTNdFw4M7RoU/X5Ez+gwjiYTWzPnFQD39FEu4fDJF
	 C1M1tvL2mxN2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C742881685;
	Fri, 30 Oct 2026 17:26:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9ACF3411
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80B2B60AA4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXXu0INoh8AC for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:26:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9765D607B4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=45.157.188.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793381194;
 b=iaUVnCVZxNks+a5MzWEdLaDaeDKp4n1x7Ev9aigN9OTjX411RaTxNVtmi07RFWRJ9bJr
 zyNccEqfUioSpIHtm+VXujTalP0NRXMidqsHNOHAfogQp/4p7qmALVklGIci5XB/hG/Yx
 gGuonyzrBU0uuRm9ZhKlPShhmEv13pA6tmtzwh2ZeKEEMVGVhvxMFr1Jc6/4t/krdPels
 cbmW9Uiux8DJpck4q7mt7l2WXBADS8uHVa4zFIuRkc5SietxkQ0/0t5heWW2Pp+19Czqa
 QXEwYPlEjIxVTUsDCGftRoHxc2ZcrCbap2iu2hSMRQYJJ41ZKPUnh2Ajvu8oG1fdoYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793381194;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=pQT+cROjVZJs/EuzoZhQR4u8Y0J8WqCsnYzwYHF/YEI=;
 b=tR2GriL9pPQ9WHVXTG7NjoYFD72ymnj3X1+h3dbyFuhnJ7uxRKKKirsfv2hl8AF6xRC+
 8jispqOyv8x+RAMRqhrbjMQ+k9xtomv3I9r9Ehi7KXwaV+C+er1LaHmhrXCFJQshKS4rz
 BPdVwwi69gnrO0+JTfccHPbNr8XJ7uoICA1O8+uvMj3jkJ9VeioWBcQDD4AWyT2d9daTr
 c2UUo/GwIHtEO5OHJ6lMdUR8zwDPvGlX+r2L0YtGkJ5MpbfsuOPO2uEpOrB8IjDiYquyT
 P8KSYZy0U0puSLDbM/runIaBq+3rzb01PsizgAfSoARxD46fXfYqLMBVxT4ipRF4naQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=N3Y7UNfQ; 
 arc=none smtp.remote-ip=45.157.188.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.8;
 helo=smtp-bc08.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=N3Y7UNfQ
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9765D607B4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:26:33 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jGSgq5fyYz9K2;
 Fri, 30 Oct 2026 18:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793381191;
 bh=pQT+cROjVZJs/EuzoZhQR4u8Y0J8WqCsnYzwYHF/YEI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=N3Y7UNfQMFlnUiKUIpRmxFgOtM4xwIiD5Rc5xf1PZkoi/L10xtvWJC694XZO6O5zx
 xgRHUCLIZdbFW14teZUGEqeYLR1TZdUS3hLSsb/puiAdf1oNnOgZ5t8wnP5xUIoyQW
 87z4JKtZHEZDhXQScZBUIElkvoivgn5tRNIolfjuGG09FzrrdY2EafgyG01oXXkgEi
 P5LGnCPLctJB8EgTpXu+JCkcb3KGfg2WlLhtdnOgXUOnI6Hl79GUCVOTbasrpIxxef
 khudvcC2DX2m47ToV9TgpkboHv6vq21Mi7/1J1+Ge13msjnROon8qi4G/TwB6fyl97
 4tTnFm6n1JKKw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jGSgq1KMtzqj6; Fri, 30 Oct 2026 18:26:31 +0100 (CET)
Message-ID: <3c325063-58d0-44b6-ab7f-4b92cd8c382b@0leil.net>
Date: Fri, 30 Oct 2026 18:26:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 0/2] rockchip: mkimage: Update init code size
 limit for PX30/RK3326/RK3328
To: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261004195853.59863-1-jonas@kwiboo.se>
 <179338067925.786412.13298758717481896565.b4-ty@b4>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <179338067925.786412.13298758717481896565.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/26 6:17 PM, Quentin Schulz wrote:
> On Sun, 04 Oct 2026 19:58:50 +0000, Jonas Karlman wrote:
>> mkimage is enforcing a smaller init code size limit than what BootROM
>> can handle on PX30/RK3326 and RK3328.
>>
>> - PX30/RK3326 is limited to 10 KiB when 12 KiB is supported.
>> - RK3328 is limited to 30 KiB when 32 KiB is supported.
>>
>> This series updates mkimage to allow using max possible init code size
>> supported on the affected SoCs.
>>
>> [...]
> 
> Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!
> 
> [2/2] rockchip: mkimage: Update init code size limit for RK3328
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/7fcc2b3948860d1146bc84bb523ba185d892b09c
> 

And b4 ty missed that I also merged patch 1/2:

https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/f09629da79aba1706d0b338dd925f2081d8b5e37

Cheers,
Quentin
