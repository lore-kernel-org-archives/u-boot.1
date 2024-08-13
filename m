Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0423C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5712A88360;
	Tue, 13 Aug 2024 06:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522183;
	bh=xYG3s4Bun8z1GybmuoOyRlyrf3EU+wfkmgqY9V32N3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=onnIJgHwHaH+GyJabLI4SZSjHpSg6UAG2hFTPuCNhvVHggkVY5CYm6yL27DjwQJzw
	 u1DxwmNJu5OyMQV3eku2fuZbFmli2ppBKiTVc17aVC4mFEbnQobAs287xrNwJsjRlA
	 RlHHclc6lQ2yunz+0IQSaUbTz7zkQMKLAeA/vF4k5uaUFxrPjg/SWyCmnxpxB+3Zmt
	 0jhg7IVVHt+X+0Mr2BNTVlfzB9m/UHsRjky+f0oYJASzPzBpwNvRaMluRtb4uqyW/7
	 +XTYFQWKa8p3jn9ytg/we4/YwmBSFRsJ7vGv1WBSTZSHNlWcyjnLybRFtyflcu2WAM
	 U+tCa19tp2N4w==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4001587E30;
 Tue, 13 Aug 2024 06:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522181;
 bh=xYG3s4Bun8z1GybmuoOyRlyrf3EU+wfkmgqY9V32N3E=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=HHP4eKeYoq46ycXOA78uTkpRHSioZuE1ZWd1xWBWKq1kgqVDQegCD4Mj4WnTBVwMM
 QZh9aGZ4ESyvMukCktIyj3mj2uywDIyapyx2NbZswzMvH2t7jcYK3AcSXZDmpMUEB6
 /kQDpbs4A24zSXnMmatH02RGPdZ0PpF0lcsY9Dw9xYSE2pk+JDIMg9bcdgGQBr8qmT
 YQSoVgEbvKpCgDQv1Ofq8JFGUNF00qjJ9Y0dYFxBYD+GNWiDdUBRkaWNk2cEzPzxcm
 znMT0nXqGsPwQlaGZktj+qeVu8X21NZMRBUvINwUQyobRjB4/LsicMyfIConslzr1n
 dnj8LOJGHAPug==
Message-ID: <c1bbbad9-94e9-da8f-040e-aed02a6459d4@denx.de>
Date: Tue, 13 Aug 2024 06:08:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 06/18] mx28 / mx51: Drop CMD_DATE
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-7-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-7-sjg@chromium.org>
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
> These use pre-driver model code and it is several years since the
> migration deadline. Disable the 'date' command so that this old code can
> be removed.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   configs/mx28evk_defconfig | 1 -
>   configs/mx51evk_defconfig | 1 -
>   2 files changed, 2 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
