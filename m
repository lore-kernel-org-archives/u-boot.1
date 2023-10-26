Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17FFC0032E
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 03:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D22087AD1;
	Thu, 26 Oct 2023 05:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698291586;
	bh=l/n99f60wMkT+DVlc5t6jPzMujX/5fOF7plqRYRWqVU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=fVwBS008ezWNyfBV31ENjc3trJMsg+zaFCpxMo0nPkGd5AhR4SeSBVwudQ8QbsNOY
	 +/zuKOPXpuwTf257urSKIur5l53GpO1f1IT/CqHJAS31FocIiFDTEy3nwKHqDRmd8s
	 7BiuGRkB3m1gYF3jzflxpl2/j+smQ4wOZvlEyZ+hAXLlQdOuGWKSjp/HzrgUjNn+Py
	 NPfj+13CoxVNtBpyf6atnT7vMEuKqPhfDZbyQVF+At24XTv0ZH99tnc5j7ejh7v+dk
	 4eemh7rx8ZvSk7fnHtjjPdVIlgNpO03iMYlNqIHvU88VnJm4IjtHicQ8rt6a9Ri9LF
	 XXqPyd/uvUh5Q==
Received: from [192.168.1.107] (fibhost-66-250-177.fibernet.hu [85.66.250.177])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E71F88751E;
 Thu, 26 Oct 2023 05:39:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698291585;
 bh=l/n99f60wMkT+DVlc5t6jPzMujX/5fOF7plqRYRWqVU=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=XjG+lpv/jJmEZe1YqxvRaeQgBTmOvcG3z+/bB/bohBfut7EK5K+XUcFRt7mV/UjxA
 YEzEOUbpQZyvsVnioLO6rpLIfX024FzrbUZPgRtatG/YN2ijxI1eagYW8/nRHNEG7F
 W5tWXROFffc3qAmeOSWXs03V6daI0KwPXxHvt5HXjlpRtASt4Q6XTi4qYMLkBj7iEZ
 Uwg0pAxIuidvmrHVYfCHFkInWk2dPuwicWcKQJHPha6ByeoXlxHH63GJyMaXW18RyY
 cJF3G2TaTWG4ARx4mAphKA3yLQmEpoA6EWPB0bOB6EzcAgI9xbr6rdO9kmnsXrlQJk
 q6fyiFCbyKzdw==
Subject: Re: [PATCH v2] i2c: nuvoton: remove standard mode only
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, YSCHU@nuvoton.com,
 KWLIU@nuvoton.com
Cc: u-boot@lists.denx.de
References: <20231004013558.2828546-1-JJLIU0@nuvoton.com>
From: Heiko Schocher <hs@denx.de>
Message-ID: <8192f1e8-169a-e2be-8eb4-54cfb037b9f3@denx.de>
Date: Thu, 26 Oct 2023 05:39:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231004013558.2828546-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

Hello Jim,

On 04.10.23 03:35, Jim Liu wrote:
> first version is only support standard mode.
> remove this judgment to support standard/fast/fast plus  mode.
> 
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> 
> Changes for v2:
>    - add commit message
> ---
>  drivers/i2c/npcm_i2c.c | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
