Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B1BC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E58888360;
	Tue, 13 Aug 2024 06:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522085;
	bh=qrY3H+EsiwyIPB5h2EYL514t91Rco93oc1inHCUspOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Ia0eE/XL9FakrI/3lLDnOb7HxjSoyPOJmjjNB2sPfekKyOYIxBA0/cBiQ9ZVHehel
	 MongPuqqCBiMSiFqaAKvhIxrMwDaeFls941Vz6Thvw1VJjU5WRDK0cwjYYps8azuxg
	 9pf/13sV9ttjjuGSx+AXc9HpOp4JW73gpc37lEg8+gRTIzAqB0iJtMjyMZIOr5T5LJ
	 N3Bd5PNq7y/7RC+48zQzAmtMbE1kLxkh/evkUuoInOr91TzWgAlgTrV9JHOnrel67g
	 XxtlExFJDJfcLAKc/OBqcgr1ucHKDTKjEpUr0Vae4HRWJ8f2jIiwU9aWWGCkp5hwWZ
	 h2BS8oKXMabqg==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9BB1D87E30;
 Tue, 13 Aug 2024 06:08:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522084;
 bh=qrY3H+EsiwyIPB5h2EYL514t91Rco93oc1inHCUspOY=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=iYn5QQswnk5uuKSx57GcE1ybyVtsGGq5Ycf7H6wm6b00C7VTEDfohfXXOrb1P0Wkv
 nM9gKIEvHAaxG8XqEbOLYAyoQpEGre245kCpSzKZzbZ3KtV7RAjuXECu4tezxUndom
 vZY/KsKBk9h20F5YPRihB4mkD2jLj7JdHwzLGm2DMVCe0m0fGoJZ0bmjX2U6bTeX2d
 bzW0PCTn50CZ+3bGfxhonIFSl8zI93R8PWsU2xJYX8+OraLRF/hTN37Tt84CglFyha
 P2Rq0d6/N0ePb4HRvUDUIqK/Nvgx1ntsDAAYA6HMOjSDtRauAnW98oqIwy9wuzteAI
 sgJOYU7Fc4ESg==
Message-ID: <d0970c04-5a97-9bb8-c77d-fa029b7c5ca6@denx.de>
Date: Tue, 13 Aug 2024 06:07:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 04/18] mips: malta: Drop CMD_DATE
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-5-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-5-sjg@chromium.org>
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
> These boards use pre-driver model code and it is several years since the
> migration deadline. Disable the 'date' command so that this old code can
> be removed.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   configs/malta64_defconfig   | 1 -
>   configs/malta64el_defconfig | 1 -
>   configs/malta_defconfig     | 1 -
>   configs/maltael_defconfig   | 1 -
>   4 files changed, 4 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
