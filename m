Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CCAC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E05488360;
	Tue, 13 Aug 2024 06:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522013;
	bh=T7FzitIiIndxI/dog3FFWBaSOaqOAygDateGNYt1jho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=hz0z8C8/LEghqDLUiV1UJTMZzFz21hScjMrm0eG0Rz3eK6qhCHo0L+toeBudNM9zn
	 L7gsGBbp3wY37aadbBNrvdrFUyDpcUUG2PDT2dbbygiArgBeJucTyhgc1d70Q7twBG
	 xeXi5Ck6E2BNUtuiBnghNbvd3fgdhmb1IuKJX/SHTlUfRp6roE8FM/JWBdNvY9hizY
	 scdv5gZZupSFIuIEOjHXK9v2bXZulsKf2PLQmX1T6YKnFPGB/3cfl21v9BT8Bzq/X6
	 LvmEuMYUpFfB3CSQWy6HkpLFITW0OciZCh4+WvXcur3UnnIfAomd9k6fXeTGBdbC5e
	 baJwb3IzUJ1iA==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 470F287E30;
 Tue, 13 Aug 2024 06:06:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522011;
 bh=T7FzitIiIndxI/dog3FFWBaSOaqOAygDateGNYt1jho=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=jWJftFjQoYkqqiIBNyQwya3lpkH3xYSCQhv+IMbJB2RXBi3ihn+VmnWQnjR3ax/mw
 6ihMWYZ7OMW/yOY/Vvw66/7+NOXqE+ysYymqfuSk3ElAjTnjDYQ939Jzix2M2LnAfV
 wV1DuysrQdv53Avwc6+RTIJzsEgfU0+L2g9Fhf4RzkjoCYMFxWaHbXFrdttLb2+axP
 U/8Zumlcg1H18ZlMCIW+1ytzltHW0anbwkCNg7YBu9MvI9mC7OCPsl5eU8Ldfxbn9h
 vIhkBeZr/aTnTGFpEk5nluZMu+JJ+HX5WjUevYJqLT4aDt6WeU9k9lW12CeTXAewK9
 aIBNFXd09umjQ==
Message-ID: <2dc4f7a7-d2d2-b8f8-1f3e-edcd2aafb762@denx.de>
Date: Tue, 13 Aug 2024 06:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 03/18] i2c: Remove CFG_I2C_MULTI_BUS
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-4-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-4-sjg@chromium.org>
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
> This is used by a few boards but we are years past the migration date,
> so let's drop it now.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Drop omap3_beagle.h change as that board was removed
> 
>   README                   |  7 -------
>   include/configs/sniper.h | 14 --------------
>   include/configs/tqma6.h  |  3 ---
>   include/i2c.h            |  2 +-
>   4 files changed, 1 insertion(+), 25 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
