Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE02C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 11:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D68A82076;
	Fri, 25 Apr 2025 13:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745582151;
	bh=aOQWbEiFrLQzKWAdq/R9jmgNs0idXWdfeE2R1QOhzhM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=votZX5QfgYo9eJjJkSiNhFa+xOA+OFLVKw1Q9i8KrdaJEyTNPgyRc5+FT2NQ+oIr5
	 d0PeZ67TrDkuqzt9chNPqls/9p2qJg2eBRc0fjss+wXHV9K1xSWFc6V5apkKGzesgg
	 iVDvQ2Ms4N8ANaOrfPk00JIiBuIcsJIqZJlx7B0Qn0AMzHWkVlDtH/nEmOBbaumYyd
	 M/644kkTpElosKlBCiHs89MfqOoLRI80IqACURdN3vd/otDeIfieqwM3Et5lImxAJU
	 kqoTKEKWT9P2SV9i7ZVQ1dCsF+PTLP1WBZzNadA/XyKYxVwv94lCAuPCm5/KjNyUBF
	 RBJBJEXdwGjEg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C36418209C; Fri, 25 Apr 2025 13:55:49 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFFAD81E14
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 13:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="REb/2b24"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2CD6C102A8CB3; 
 Fri, 25 Apr 2025 13:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745582146;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=aOQWbEiFrLQzKWAdq/R9jmgNs0idXWdfeE2R1QOhzhM=;
 b=REb/2b24u7q6IR+PxTdAplWQJgTxQ4+ZuNVxZDeJJe5lv4SiaAZ3ODq/mtySpKpIKD7Qbt
 qk/NPru/XfOXYWMqabNvFk8a0eBqOpyOd1kKDD8/W5z61dr/SsROr0HQ3b95M5xNsAhWnd
 F/aRYMsSqV1CyQIJUTU3guYyg3P/kOHwQ0BipLOs3QtFkVv0y3A89pGolzAkwPFzDxxcoT
 VbnLTWhwSgPeUCmb+LFwyKv/LpMzsxs3qVj4KC2hblx80R5HZm+9600CBY+qUeNTOtRI4n
 M3PhfpUN7KrOyIjczGzlXwUBNWU7h413hgfmgUORZGbFThNStY2oh3SvR+c0ug==
Message-ID: <67011602-d3de-7c2d-43c7-172f7d08db06@denx.de>
Date: Fri, 25 Apr 2025 13:56:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 1/3] imx8qxp: capricorn defconfig: collect common
 Kconfig options
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tomas Peterka <atheiste@seznam.cz>
References: <20250416090419.54781-1-hs@denx.de>
 <20250416090419.54781-2-hs@denx.de>
 <CAOMZO5BeTfD+o43BAA+TP3Sbv5M1Zww_rtAR8fv9AeZ6NH8X0Q@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5BeTfD+o43BAA+TP3Sbv5M1Zww_rtAR8fv9AeZ6NH8X0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Fabio,

On 25.04.25 13:45, Fabio Estevam wrote:
> Hi Heiko,
> 
> On Wed, Apr 16, 2025 at 6:04 AM Heiko Schocher <hs@denx.de> wrote:
>>
>> siemens have some defconfigs for different hardware versions,
> 
> s/siemens/Siemens

Will fix.

>> all based on mainline cxg3 board. For easier updating the
>> downstream defconfigs, move common settings into new file.
>>
>> configs/imx8qxp_capricorn.config
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
> 
> The other patches had authorship from Walter, but this one doesn't.
> 
> Just checking if this one is correct.

Yep, as I moved this into the new file.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
