Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDED1C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 15:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DBFE885AF;
	Wed,  8 May 2024 17:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andreas-buschka.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=andreas-buschka.de header.i=@andreas-buschka.de header.b="jwVgy3h3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E558838D; Wed,  8 May 2024 17:29:54 +0200 (CEST)
Received: from smtp052.goneo.de (smtp5.goneo.de [IPv6:2001:1640:5::8:30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C33B88667
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 17:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=andreas-buschka.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kontakt@andreas-buschka.de
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id 180A2240DA6;
 Wed,  8 May 2024 17:29:52 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPS id 7B18F24030E;
 Wed,  8 May 2024 17:29:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andreas-buschka.de;
 s=DKIM001; t=1715182190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JzOaMYBb62vEue6WKrCZNFhdHIPlEVmNz4ncA1naMLY=;
 b=jwVgy3h3pQ8UZwtyfSvUjj4Nzi40ma5vzDcuqcqZ4rOpfH74qCWPCgTebdxsyX3m++qJeW
 QM1y6hsPFmZ3zI2m8VenXcVfNiZphKRS0F5bPW4dXbeUPx5BEn8lFEHx1J825ho+FZWgx1
 ss/IiK59PWBVZUZ3Lc28FTbLfWEvvE9Qcss08J2G3JhnlBRiTy9b0/AtzQfE2VTAbBAgp7
 g8ne3bpvpyRNAvnDqTIvln1jO1Se7Mi17U/HQnTX91pMsU083nPaJY1Eca/T5BmxCuDtzC
 RBeWzT2nEUcikaPi4QFNWa4G5xnRfgiY5q95YNLVfEgaMUEpDmiu4Stvs4jwzQ==
Received: from [IPV6:2003:e8:170d:e600:c161:808e:e5fe:918b]
 (p200300e8170de600c161808ee5fe918b.dip0.t-ipconnect.de
 [IPv6:2003:e8:170d:e600:c161:808e:e5fe:918b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPSA id 3996B240287;
 Wed,  8 May 2024 17:29:50 +0200 (CEST)
Message-ID: <ff647650-44bf-41f3-8ede-085f9ff9a1bd@andreas-buschka.de>
Date: Wed, 8 May 2024 17:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Does u-boot support USB CCID communication?
To: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>, u-boot@lists.denx.de
References: <CAHseuWCExW0TpJE+wcASX5Q5gcYzisD+JfCazTjzx5n4m-jCEQ@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Andreas Buschka <kontakt@andreas-buschka.de>
Autocrypt: addr=kontakt@andreas-buschka.de; keydata=
 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
 afVgxDc=
In-Reply-To: <CAHseuWCExW0TpJE+wcASX5Q5gcYzisD+JfCazTjzx5n4m-jCEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: bfcf5c
X-Rspamd-UID: 47d954
X-Mailman-Approved-At: Wed, 08 May 2024 17:35:22 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Sourabh,

In U-Boot, the only methods of separating storage of secrets from 
general storage are (as far as I know):

* TPM v1/v2
* OP-TEE in combination with an MMC supporting RPMB

-- 
Kind regards
Andreas Buschka

