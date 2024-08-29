Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527FAC6FD35
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742B688AFB;
	Thu, 29 Aug 2024 10:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724920120;
	bh=1E2G3+o/DlUoGldje2/K4IX4TkOJbb4up8JeIu63bC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Sd0WRs/1LUFTvXvbrho4NXjI3QEtWz2B0aKUeop7EnnQbYyZH/wcCEfZV3YBgR/Ws
	 XjqXt/pFa+D3afjKq4dMryEXOYtkgqjK4pt3AK32stG479JYFfSjJTA1K5guMp5IEE
	 VStrjoVCitEafWnQzYRmG5RaZzMYpzQReiX0W2nLE1KvHVtwxzr/RWAlvtp1OtsnIY
	 Jz5SXJi2nxy1EQEptqAJKVD00GC/6Hkz/4UHI5zHKGrSp7D/+PsNjVhWPDR3+93rkX
	 lfO+t3TV8nYubf8lnK8nVdvwZxuqDLw4Igr9htPh8y3ZFOUwITH2Yn38OGiXkH6a+8
	 A/QldljGUidQQ==
Received: from [192.168.1.107] (89-186-113-255.pool.digikabel.hu
 [89.186.113.255])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5912688950;
 Thu, 29 Aug 2024 10:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724920119;
 bh=1E2G3+o/DlUoGldje2/K4IX4TkOJbb4up8JeIu63bC8=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=C2NARoroLGoCK6PX5iVQlTXn/PdntG4j9Ozh1WTktyeflZWJkZX1g6qwWopZ4UuHo
 0g+QHN3g1VdvGRdb2RmcyKy+Ea0Z+1MWOrHeYDTLlZzhdcQyszKtPfUcisajhJrRRC
 Okj8p1j7ekF608U54wKlXO52CdC+GJHQ6i075t4Am1GkUDCKeHz78IbmMQm5hD4dbL
 uU9DBZyk1IE6Mq8+bf8AmmtqJ8b4d2T5OWmk/m9hu0bMa2FzuNXcM3WzGhk1qKC9zY
 PkP3BqrGSpeP/3lIAMTvSuo5JE7JTDnl8Fff0C7AtoyFLQnBAz+U0LSIo5XCd9ER+R
 7hXLB9uEazZmw==
Message-ID: <2e5bbf2d-7a2b-411d-4b6c-2657de9e2b17@denx.de>
Date: Thu, 29 Aug 2024 10:27:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 03/13] at91: rename mem_init() to at91_mem_init()
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Jakub Klama <jakub@conclusive.pl>, Artur Rojek <artur@conclusive.pl>,
 Stefan Roese <sr@denx.de>, Marcin Jabrzyk <marcin@conclusive.pl>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <7f010d834c665c15888b7738a0ad16334fa03443.1724846454.git.jerome.forissier@linaro.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <7f010d834c665c15888b7738a0ad16334fa03443.1724846454.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Jerome,

On 28.08.24 14:10, Jerome Forissier wrote:
> THe AT91-based platforms have a mem_init() function declared in
> arch/arm/mach-at91/include/mach/at91_common.h and implemented in various
> places. In preparation of the introduction of the lwIP networking library
> which also has a global mem_init() function, rename the AT91 one to
> at91_mem_init().
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   arch/arm/mach-at91/include/mach/at91_common.h       | 2 +-
>   arch/arm/mach-at91/spl_at91.c                       | 2 +-
>   arch/arm/mach-at91/spl_atmel.c                      | 2 +-
>   board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c     | 2 +-
>   board/atmel/at91sam9n12ek/at91sam9n12ek.c           | 2 +-
>   board/atmel/at91sam9x5ek/at91sam9x5ek.c             | 2 +-
>   board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c     | 2 +-
>   board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c | 2 +-
>   board/atmel/sama5d2_icp/sama5d2_icp.c               | 2 +-
>   board/atmel/sama5d2_xplained/sama5d2_xplained.c     | 2 +-
>   board/atmel/sama5d3_xplained/sama5d3_xplained.c     | 2 +-
>   board/atmel/sama5d3xek/sama5d3xek.c                 | 2 +-
>   board/atmel/sama5d4_xplained/sama5d4_xplained.c     | 2 +-
>   board/atmel/sama5d4ek/sama5d4ek.c                   | 2 +-
>   board/conclusive/kstr-sama5d27/kstr-sama5d27.c      | 2 +-
>   board/gardena/smart-gateway-at91sam/spl.c           | 2 +-
>   board/siemens/corvus/board.c                        | 2 +-
>   board/siemens/smartweb/smartweb.c                   | 2 +-
>   board/siemens/taurus/taurus.c                       | 2 +-
>   19 files changed, 19 insertions(+), 19 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
