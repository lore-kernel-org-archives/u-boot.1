Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3B0D12D72
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 06:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7323889171;
	Mon, 11 Nov 2024 07:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731305023;
	bh=+I4/1YPQY48FMx2BvNztZYwcbbM1VH1Dx+vKgQLXU6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=sBDG38eYhfP6nYD8mNk+GM+HzPXMozgMLhUDcdDr/aiZ0Yw6RbRL/Eyvn70XM9dr7
	 J2XsEfxSwcoCm6rrRu16iWP0bxD2tEZAA6vht0WN6wJkU1qfimPsNoTyQAYw8uGgPs
	 8soYdFwQfCr6PRl4gS9f985xW+XYne+hNtEddwdYkTbfUcOhsKgho7HIrrfPakJJPH
	 0gsehjQZWBnMEUb47P/AFVq95Pvjrt85cYhlYbR8sBjg/HIloarL85d7ur0Gys89Kw
	 alOkKbo+Fvg4j+rUKTmsoD2Ms+dujlq4O+BMzN9TNLvvqseGLisuhVSDorMzp6m/Al
	 CA2zfjclpCQGA==
Received: from [192.168.1.107] (87-97-106-70.pool.digikabel.hu [87.97.106.70])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A2EC9890F8;
 Mon, 11 Nov 2024 07:03:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731305022;
 bh=+I4/1YPQY48FMx2BvNztZYwcbbM1VH1Dx+vKgQLXU6M=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=kG610w7WR3Vqho66qaLYWN+U/WiU5zOR71NWuzBoJus4ndwZJPgNeHnzV8EF7RpT5
 1nbmUecwy3tw8w2V/RQLDbZTagXSfwA4NDXn6V1OICznzyQ8L77nomUF1zQoZoSL+W
 unks5PD2vVuuqpGXV+jxhjMiICYwhe8VplbGaFV56C5o0dfo3aYbHKx00DzNWsHczn
 mGz6FN3Y/QDnWMlR0u3IPVKSgiGqEqz7ysuF7aUDZFi4Ic1069ldzM27s44/UNH/Vu
 FZTjFyKxzqSIgdnMjRZyBOrPNMXSWm6rqKLDYdpr93BLjYIpHcqrmh3B0vmjjlRwMc
 TXtY3AziRBgaQ==
Message-ID: <d0653a79-0299-6549-624d-43e48ee35ff5@denx.de>
Date: Mon, 11 Nov 2024 07:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 16/22] siemens: capricorn: board.c fixes
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, =?UTF-8?Q?Marek_Beh=c3=ban?=
 <kabel@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-17-hs@denx.de>
 <CAOMZO5AY4pD124FV_GSRD9eLNzNdZztLj+jVudHtG2+UgPVq+g@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5AY4pD124FV_GSRD9eLNzNdZztLj+jVudHtG2+UgPVq+g@mail.gmail.com>
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

Hello Fabio,

On 09.11.24 17:38, Fabio Estevam wrote:
> Hi Heiko,
> 
> Please use a more descriptive Subject line.
> 
> "board.c fixes" is not meaningful.
> 

Heh, indeed!

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
