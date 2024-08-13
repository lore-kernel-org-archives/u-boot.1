Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B911C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DE9E8896C;
	Tue, 13 Aug 2024 06:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522555;
	bh=MIqPL9PFECZwj+ZXxA1I5h9OjVI/557fZOk2EICLEfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=jDsHB0kql+CAaom/q7Qf0mnEq84w9qxoVun4OLRxjlPpHZZ//2Zv4DgfRQWyqDS+/
	 mTWQh3xPWXWSFW8QDn6hGycgc15hXYopVBWafgV8uVNZXJz5cpFmbiTVbDTUebyi1I
	 er5q4z1lUcXt7mFwFiDNe8+gLbX5OXyUj3mVqebwpV7wCaqFg36dY3bftlVU6EXE2a
	 3zkWhbYsmjiEVoRmDCUHqtAe0E2S6ubvM6LctY87LsxTF885y8Q+QFK+nZfw9RvnHD
	 jNNQTSYSCEKXs0skjaQIJWScdYURVGLxj2ty9gzVcBaWuXWi7ZGMNz1Xm+egGDLOR/
	 aSwNoP8Nllz9A==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 22B6E88360;
 Tue, 13 Aug 2024 06:15:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522553;
 bh=MIqPL9PFECZwj+ZXxA1I5h9OjVI/557fZOk2EICLEfo=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=xAliDGLn7yYJfEGbRRpDTxs5ceZnd4EZ7NO0uP0MeY5fmK4gDQ7j3f6IdcCLwxN5K
 RGK7O57QOUMUI/PSAzxJodYswn8lRhdx3E3ssD7oE4GLH8muhlfVrud0rPJZabRLf7
 IGsUz99Z2vm7cvvK7v8yDTxY3N5KRaxvQhEMmZz0dyZ0R6yjkkD148QyXtvqETBvok
 eYavBB3l4UFu1pNO/63qQEIBbqT7ZT3MePQYhTI9HhFkG/YN5tgeU8wXYTabAV7I1C
 ZUPH5vM8VFkuskJjVQxv3UnFLQUaYzErQg0MwFGpLCzTrFgD3i+6MRujTrmDfHg4Bv
 cr4d4lJVj5S3g==
Message-ID: <ac09bbf7-7183-f643-8a21-ee06e52ef584@denx.de>
Date: Tue, 13 Aug 2024 06:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 15/18] i2c: Drop CFG_SYS_MAX_I2C_BUS
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-16-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-16-sjg@chromium.org>
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
> Only one board uses this option and it is very old. Let's drop it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   include/configs/ethernut5.h |  3 ---
>   include/i2c.h               | 14 --------------
>   2 files changed, 17 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
