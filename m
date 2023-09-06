Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E10EEE14C1
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 17:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E6498679F;
	Wed,  6 Sep 2023 19:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48966868BC; Wed,  6 Sep 2023 19:56:05 +0200 (CEST)
Received: from mx1.tinet.cat (smtp.altanet.org [195.76.233.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AF3866EC
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 19:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xdrudis@tinet.cat
X-ASG-Debug-ID: 1694022960-12aaf213d667c590001-4l7tJC
Received: from smtp01.tinet.cat (smtp.tinet.org [195.77.216.131]) by
 mx1.tinet.cat with ESMTP id Fs2R4YAMHc1RZwTT;
 Wed, 06 Sep 2023 19:56:00 +0200 (CEST)
X-Barracuda-Envelope-From: xdrudis@tinet.cat
X-Barracuda-Effective-Source-IP: smtp.tinet.org[195.77.216.131]
X-Barracuda-Apparent-Source-IP: 195.77.216.131
Received: from xdrudis.tinet.cat (42.red-79-152-186.dynamicip.rima-tde.net
 [79.152.186.42])
 by smtp01.tinet.cat (Postfix) with ESMTPSA id 0EC22605DE45;
 Wed,  6 Sep 2023 19:56:00 +0200 (CEST)
Date: Wed, 6 Sep 2023 19:55:58 +0200
From: Xavier Drudis Ferran <xdrudis@tinet.cat>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Sean Anderson <sean.anderson@seco.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] spl: undefined return value in spl_blk_load_image
Message-ID: <ZPi9LmISZUAZ77ss@xdrudis.tinet.cat>
X-ASG-Orig-Subj: Re: [PATCH 1/1] spl: undefined return value in
 spl_blk_load_image
References: <20230906122511.96787-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230906122511.96787-1-heinrich.schuchardt@canonical.com>
X-Barracuda-Connect: smtp.tinet.org[195.77.216.131]
X-Barracuda-Start-Time: 1694022960
X-Barracuda-URL: https://webmail.tinet.cat:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1061
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4619 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=6.0 KILL_LEVEL=8.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.113748
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

El Wed, Sep 06, 2023 at 02:25:11PM +0200, Heinrich Schuchardt deia:
> spl_blk_load_image() should not return an uninitialized value if
> blk_get_devnum_by_uclass_id() fails.
> 
> Fixes: 8ce6a2e17577 ("spl: blk: Support loading images from fs")
> Reported-by: Xavier Drudis Ferran <xdrudis@tinet.cat>

FWIW:

Reviewed-by:  Xavier Drudis Ferran <xdrudis@tinet.cat>


> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/spl/spl_blk_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
> index eb6f526689..ea5d1a51d9 100644
> --- a/common/spl/spl_blk_fs.c
> +++ b/common/spl/spl_blk_fs.c
> @@ -53,7 +53,7 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
>  	blk_desc = blk_get_devnum_by_uclass_id(uclass_id, devnum);
>  	if (!blk_desc) {
>  		printf("blk desc for %d %d not found\n", uclass_id, devnum);
> -		goto out;
> +		return -ENODEV;
>  	}
>  
>  	blk_show_device(uclass_id, devnum);
> -- 
> 2.40.1
> 
