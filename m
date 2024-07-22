Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF47C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 04:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA5A88001;
	Mon, 22 Jul 2024 06:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721621201;
	bh=wVmUD/EinliWscPTScWXq/r9aIL5K7g88aFPJPt2qkQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=z5mWYk3X2jhh5qm79shDck4HZDva2KaH/sF50MEd153fMBVqAbNdNX2SKDKZLIVIw
	 ktaN4xgm0HF3T7ZU96yi7hV+u1ppRR6htlOnx/BdU/wjx8St/AjgdJCfx4pcTIr3XP
	 rR/4GFgTMxfUfh9ynBF/kcGYJSZ362p3lOmRa1LBhgy//YxGDejywOWOveyKDebyxk
	 K6CH7tP3ZXsTYQx+7oIXaTZMvPeg5uWUL10pOokZeI5k9GihlPCUXOT+EW0XrpK4uR
	 Yf7gSkB8O8mQ34ebVarvLyKqzsnYbP6QKonzZClQrMlDe8UKAfPP9OYE7OppOy2gd2
	 PSQZ6fx50+EbQ==
Received: from [192.168.1.107] (87-97-112-163.pool.digikabel.hu
 [87.97.112.163])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A09A287F82;
 Mon, 22 Jul 2024 06:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721621200;
 bh=wVmUD/EinliWscPTScWXq/r9aIL5K7g88aFPJPt2qkQ=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=i1lxRU2DhQcZwQmUz4C4/rmCmmgfQwP0PEsgVDBsjJp8+7Ey34wIFddd0T7m8I/C2
 lG4ueBxnqxzD3Crae8Dlxxvk+t6c2wO3c5nd9w29UbzaeFa5iYzt0lh4Wz/YcKHibA
 kPujWZ6lHdktdiLrV9BynvwqIOII9qYE6RBFc3LLdWFe2XctZR5j6GuKhSeATjqHDT
 W4jRBkE50VcPotck7PLuYOEshdhjtzv8pWM3kkHPrpGY2dmVxnbpSec8HcXc5ydd1Q
 rZxPk52C+bV/xJ+9k1NmIDrGXDZK8/+eOwionUIoVTAjX3i6K4XdMqz9ZEGQnAOkQR
 b2vKTViSsSNUQ==
Message-ID: <2f5064d4-de93-5f4b-7c1f-2895bb801ae7@denx.de>
Date: Mon, 22 Jul 2024 06:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 14/40] drivers: i2c: Remove duplicate newlines
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
 <20240720124239.7553-14-marek.vasut+renesas@mailbox.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240720124239.7553-14-marek.vasut+renesas@mailbox.org>
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

Hello Marek,

On 20.07.24 14:40, Marek Vasut wrote:
> Drop all duplicate newlines. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
>   drivers/i2c/exynos_hs_i2c.c      | 1 -
>   drivers/i2c/i2c-uniphier.c       | 1 -
>   drivers/i2c/imx_lpi2c.c          | 1 -
>   drivers/i2c/muxes/i2c-mux-gpio.c | 1 -
>   drivers/i2c/mxc_i2c.c            | 1 -
>   drivers/i2c/rcar_i2c.c           | 1 -
>   drivers/i2c/soft_i2c.c           | 1 -
>   7 files changed, 7 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
