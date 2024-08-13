Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B29EC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F0388360;
	Tue, 13 Aug 2024 06:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522469;
	bh=wGcm9NIubDJpWXF9p8uNLA4uAy9nlB5dNfEF7sgaADI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=n61aRPW17K+lrcp+G1qOLggEOi9fMsb83001rT/CzB/IFvSV3IwwsQdc7qhg+X173
	 kj4RGFoCYao8/w9u5KSKMMdQAX9R3Mo5sCK5n8j+KDM01XMbXEW0OEtlophl+vKgrA
	 CeY708VDVmetzAl8hLkBbnRcWuKLwQJLD+QD/Za2cv7vh3zSDjxo6YGoZjolIW18Hd
	 jKna1yME65DcHXsq2xOGk98mfrQveXyG2UgK9Lo9ZWDAcmapmLammVwNUoWPvJYK3g
	 9EkkMU99QLmc49vUraNETuyXXQ+4fcg1CvWiR2w/tVT6mq8tpz6zDRTVy+I0u/e7Ks
	 HhIALPSPACm5A==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D5AB887E30;
 Tue, 13 Aug 2024 06:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522467;
 bh=wGcm9NIubDJpWXF9p8uNLA4uAy9nlB5dNfEF7sgaADI=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=tv1EYCvQ1OijLz+ksxAnATtb6QviRfkHxSrhSc2SzMmJ1EdrTr/zHRsoartESuNfm
 kNm75gJ+wXKmBOfRiYyvnB2rHnRd49nKj955nkH24rm7KUI2y28kSp0dviHU+Il4ib
 TDFQM58SWeS0Uw4gy1x1djI7MATFrE53K2y3N8qTy88BkWUR4oTIcjYFCOpwUur9wc
 VHk8ySXyXGMOtnhPkCvuSxgiPIsIrTocM+zn/ZCKYS9rM02KyrZxUk7XUTnVqlr6Tq
 K5WfEhL4agV5rzIa+GO5OS/Z2xkY9Hu77v0qCkv8JYX2it2WFEc+XdrPH4YjA4urCu
 qL83kmKddRJ3A==
Message-ID: <f1ca0d41-ca65-9687-5960-adf007aff5b1@denx.de>
Date: Tue, 13 Aug 2024 06:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 13/18] i2c: Remove I2C_SET_BUS()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-14-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-14-sjg@chromium.org>
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
> This is very old, predating even the legacy I2C support, so drop it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   drivers/power/power_i2c.c | 5 -----
>   include/i2c.h             | 7 -------
>   2 files changed, 12 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
