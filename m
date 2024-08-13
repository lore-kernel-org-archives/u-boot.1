Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A01AC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FCD688360;
	Tue, 13 Aug 2024 06:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723521886;
	bh=abBxqt63VWE0GYVIAE213ILyKqgg1Hqktvwrt5fnKhI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=AejLQiaWyf9AEUZi75Q/HK7m/UAF2Ki41ClkKRHiiDEABHUMXHdCdDlE92zk/JBfB
	 fi+n1ilN/AEpOK9qYBm5HibBFs3lm/X3hH5qRVq7PZfjPTyPOx/agDzzj4Q1oZDwnb
	 rCCPZk7wLi4l1bFaDfRA87f4hMFDnjG8U2vyooLa8Optn+Rv52rwfgt2VzXTXTw6H+
	 ZW+YqTtp65whbisnswjf2GFnHqkrHQIqUvHc6AyHl3suw5vNYYE+dha0ZSEtQKkGYM
	 gvHjZ2n/gToQEc+VwKZZdmhJMccb3HaKV/1B8BdcBONqiaoI2M7iYEQ1OAa0hXFrpU
	 0yDsKGhOqmkVg==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 94B2D87E30;
 Tue, 13 Aug 2024 06:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723521884;
 bh=abBxqt63VWE0GYVIAE213ILyKqgg1Hqktvwrt5fnKhI=;
 h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
 b=L9jKoVZ6xCe4GjXzQGnB6uGAprZT6nTJkVpCSYPDj1DGnjOt29lMnqH+c6HUt+Mlx
 HEKlaKaxOxJlPxH131d8GwJTHwafnjOsYerXogzhxfKNfzeILO3pns3nR7LT17BYFp
 ngKAAxymBkIcKkmZ0VFIPlDJhZCOkZOy64wud2YfWeg1UQ+dQb8aZrOJg7dOhlRmmb
 PdKzMi/hDwDamoqhptIgEetL0sHH339ctd41v2RLOCAkDYjFV9eqOjPb24cb1GDRlG
 1eRJYkEQy6Sflb/BlkPbYdtowSl0IEJ5MSR9YsNnZNIT102a5/bIIW7rsU9eg2UPWz
 40LEGZ4OUuLig==
Message-ID: <0e7fd632-a46d-d206-0127-b3a4ae769df3@denx.de>
Date: Tue, 13 Aug 2024 06:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 01/18] i2c: Remove board_i2c_init()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-2-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-2-sjg@chromium.org>
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
> This function is not used, so drop it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   include/i2c.h | 8 --------
>   1 file changed, 8 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
