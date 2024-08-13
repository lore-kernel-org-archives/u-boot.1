Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D03BC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3828C88360;
	Tue, 13 Aug 2024 06:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522417;
	bh=uReW2wOwyWf+VAmR7TgcUEIzBL0tNs8xpqs2LYGGCNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xICxcliDsYGiT24zb0rFQ8YdrIF7QAk3XtmiE3wQm3WcuGZLQwu98/rhRBMt2sS18
	 3GOwMmuI0w6NobAYvl+o7m+7iCW7Jq7CftWszyq5o8tmF9Bf/YBPPJ1QjMPzrbcMeh
	 U4/ckTqWv3OxtEijV/InY/1EArdolxt5hXi7pASLnJaSa04AizSFR0G1w87tutjhEH
	 EGKoDDDd+I8O0BFk47rpzG/KWzHyEVowim0ebSGRzrzdDAvUSl17lRA7b4tu+1onjJ
	 O8O/PkXrIf55K8CdVvB2G/Y5fcXU223rdej7TPMIvnuFmx8CkBBoN/kngBj9MUpjiH
	 XMD+8s6tPBL5Q==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 41BB287E30;
 Tue, 13 Aug 2024 06:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522415;
 bh=uReW2wOwyWf+VAmR7TgcUEIzBL0tNs8xpqs2LYGGCNk=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=EogDtcMMq3jJfKo0N6ccHrerDNjP0DM4Sjq6Hxbz1calXBpo1S/BqeNFQV2YGSPGz
 ZrVnQmoFW1SkcW2TGg84/6t61/aaraXiAXqQZ+zRjlimqRX2Rt78mOSbHYg/jGY8Jq
 kZAI28JnkEWtTngmgP/MlQOIJ8dmJmuk8foJz7yC8x8FoJ089x6uyntTW+xoCNuPS/
 B00v8XJTWf6j3MWiiZoowm3KLps+yMwdfTNkKr9WFLn+p7NjyES/NiPuMJ1W77+1/z
 tAesqG3CZm4Sa90EaN4K74/psrl1XMuWVbgjJzCIscEu+euTs8gd5xklbKTkuZV3I4
 e4gFnB7KmI3xQ==
Message-ID: <7ba67d77-1ed8-7477-1d73-0ef594fd4503@denx.de>
Date: Tue, 13 Aug 2024 06:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 11/18] i2c: Drop reference to SYS_I2C_INIT_BOARD
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-12-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-12-sjg@chromium.org>
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

Hello Simon,

On 11.08.24 16:50, Simon Glass wrote:
> This is not now used by any boards, so drop it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   doc/I2C_Edge_Conditions | 10 ++++------
>   drivers/i2c/soft_i2c.c  | 11 -----------
>   2 files changed, 4 insertions(+), 17 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
