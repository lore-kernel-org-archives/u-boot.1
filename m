Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C6FCA5FCE
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 00:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 028CD60B74;
	Fri,  2 Oct 2026 00:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pRYn82eRvJqp; Fri,  2 Oct 2026 00:33:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2D46B6080A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790901190;
	b=XaoCADfM5kAmYhmyrXfxu17FOvpfwkSX7aOcg3C6UQrRk8Th8JmHVQbrRwg4Iwk+SmRl
	 Xw2bs1HtEgqzSoa0n9GrjiBCPF2akEl4PEF2mIyCFnci6a9kDzBz0eB2fJqDNguRJ2kOT
	 BTGQiGjSpFCIF4tQXy/oz6Qy+J30uTJ6EcraO+2Y2Ym/s/UBGkapiQn4KqaNz5KwAx8oM
	 3DVMwchL/bhVcf9U9Yd52x3Mbk5USnzBDJtGAkSxPLV45zB0pzoIee3LskQCCktBPxdYC
	 zqstDAQpNGls5mDhesZ4aGGyAoQ99WHAqX6vbt+Dt+qIKlr9Mm7Pozyb0n7rttRNtug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790901190;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wEio5w5DcZXrr+TnhsIOpTHyIt/nF9AY7YZM2OBdqso=;
	b=Y/NsmRWlqpvY9IPkGZoQ4uS5Kk0A2UzY0rELqYlRUB3e1x5VsFd8baBx5uOlYbOlD5Bu
	 vcrBj336Mzh3d5i26dLR+gadoOxnsuLNXL2efFZ189HSpPMP8afC1aKpxG5oXqY0B4HU4
	 6gQxGxE95/UM1uznaKiU0xHqD9LYGDaOjJv0xPrpJ666KUPxucnglrjx4xMCj/EKh3GNW
	 ZSWAF1TXHe/r9TESGTlrq4cddDfxC66M51g/zQ5ctKBfCdVKJur9AJmaiUBbbLaRZXqlw
	 ojes2pXVx/Bsezy3mjiPzNDOQ92DbO2wqkf/qbYkGYrUsM/PDYrtCjLloa3pJzPgP7g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UCPm0kjX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790901190;
	bh=wEio5w5DcZXrr+TnhsIOpTHyIt/nF9AY7YZM2OBdqso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H/dY3wQ53tg0XWat85Pj2fdZvb4zA7TxuOCgHO9FTTt5HZcFAbqdDgKZGeST8cdTt
	 28l1AB4sXh/M7dec7rcFUiKYLwwnjciPs5spfYgDHtl3zdUnAU8K/v2ydebiEDhWtW
	 cvWVXkMml/Fm3otsS18IehU9BzNQnJRBuATm7yYI7YADOSzh0ff6oxHyJqu+yRFYwz
	 WwJB9Y3yFjI0FhnZA6tI+hlPYEOLKPLy2lELKZMQO6ITKZ23h36lOJz4B6jfhe18Ek
	 v/kqwmykV4K7hD4yoqzehg+i/b4gBn+a1YrfP5d5QxjYOxsO/2kauywk2fzVFFWOoP
	 l6sQQBa/FBcHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D46B6080A;
	Fri,  2 Oct 2026 00:33:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD4DC1A6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A318A6080A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:33:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPpjMa9tSV73 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 00:33:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A5BFF60658
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790901188;
 b=o0NMY2wY7qMgheKoTm+WTTavgQcQumr4/3pkqo22ZxJGC6fjyN5BXt5hmTkLVAHMet4H
 i7QKk8x/rkcP9L4NN8kLfUc+V0dXSJYmdh6pbQas50JFaAtRBl7x1Xs1Gkj7YBdwnEE89
 pQu0Lt9sxZtJ6Dqgnqz/R8/VosSSyMxRk4tbXs+ZOIoGunEjaWwvmRjzn45BgucPn3HFP
 5itNDnPsaXHwJ2/S2plB0Il0TRtlRgspz/fr6Kr+eFqQCzvLDapjnTDM/cZybqjXCPJx1
 Gaee0TAtxd/IH6fbQpGxY+IPQdeNzFMjuGpebF3kS080T/UNaa8ngqFt5nnH8K+nn9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790901188;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=wEio5w5DcZXrr+TnhsIOpTHyIt/nF9AY7YZM2OBdqso=;
 b=ABMftHOaPLD85KgxO/LgDOulwu66LkdIfFGggaaEAVmgW0+C1HjHYSpisJF8G0bXP+u/
 2qPOdoVFDb5gjCvdVdjulUaQuAUfiq63TyP6PiWQbV6ep1WSCZaHO9Cei9elMXWVFujdi
 SfZSyfQVTXY1spYMAm6KZIBOmZoOJPjFTWpjzBdp5pAVp0caWEMjEt1s+4BBAbRhhGpuo
 gtbrhDXX/vTsenaDkkzpUOB6ATSipFemTC14T96Mdb5CAAHsEy+XUw9F/RB8pOFHIasqA
 OBkKx349XPu6AL06qXmjTkrLNVGcXiOaqObVaRNOd1DWiKnD4Ni13Ij5Wf2ddeEZcoQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UCPm0kjX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::f;
 helo=mail-oa2-x0f.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UCPm0kjX
Received: from mail-oa2-x0f.google.com (mail-oa2-x0f.google.com
 [IPv6:2607:f8b0:4864:30::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5BFF60658
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:33:06 +0000 (UTC)
Received: by mail-oa2-x0f.google.com with SMTP id
 586e51a60fabf-4881ca701a4so3748237fac.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 17:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790901186; x=1791505986;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wEio5w5DcZXrr+TnhsIOpTHyIt/nF9AY7YZM2OBdqso=;
 b=UCPm0kjX6hUUeESLsDiBR4vCNPWvt05J2wxOoSr/P8xzCJEQrHq+HtrhhPsUBC7ja8
 DHZvHFfyQVRkvUnqoycGgu1Dznj2lRB2uMRg+1lC1gmKEcWMdIpZYGCiXjlU5yXq3RE1
 yxym1YqLP/N6ccwFLVcqOjbwwTL9P66NO+2UqUW2mCrrlSvvICFowfubHXqtwWoRGxNj
 ynDm8VB2NlflbInALcXeFBB4eYrNwg9sIgjTpA+p3l5n4AoULSvEGQIiAlG7s2Foqp/n
 D4qs5D7vhCx8FaLHN2XyKawmg9zraF4Ox9AW7zRsfFFJEaOpngPzfvEhjkDfEgBDZd9V
 9Z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790901186; x=1791505986;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wEio5w5DcZXrr+TnhsIOpTHyIt/nF9AY7YZM2OBdqso=;
 b=L4HSeV1Cq8HFvwmylxJvscfhkXFupBNioJPWpcwFUCmUlqqv6prFAsuqurNWZEQEiQ
 X8pPSVmhrXyTmDrUvjZJIlI6D8LaDf0S3YE1I++5lxR8Nm+fTXFRkopJYPIj57L5/o/W
 r7r0mr0kqAyja0WwLkPsAkEYJ3DeCtYFFrOS/M/TE9lJx9ulKslSFITj3juFihgEW7Gy
 OjYmkKHaxWaHsvFVxM0+n2GhE4u5vDsSXPxPq4YcJ6iGvYXTE2OKoshzFhcZwdKJlDOk
 zeMC/e8Yd4RHjxD0fnllN4tG3mD5p957dNgbUCgnqrebDVB1kto/R8OGmPvUmibK+zUI
 x9ow==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2+cCT0/hrJbdEH0bfrylHNMZE+GmYI6/Xvyw7Z6nTyIWe8adVizsQQlkdNqa7NbPXblDn6GY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kEmRfZe4VH0aREXghaeaV19UxkZw3137GXx98jdSyZs2FpSTfA
 6+IShIDH0aSJ8QDJLKLXZ/Lz7JSvWP+Cc+tfA5hq5hawcGfFwhrDIj341yu9n7fB5Lo=
X-Gm-Gg: AYBFou1TApABFa7BqCfX+Gfmi4ZI5/uR/QUu2QmWYXLdC+wxYJgHrYGJn/A1gXqfq0+
 Wenwkr6PAnx/DD043iBJV3J23lPrqnhuuwR5XLO04+IfTOaTpa1Othq6g0U3eeatpv0k6rpCovt
 1AuCNfd9BfnjzwLZewEepU5STzvUVU2vgJTp4tHfSQI//ibxNdOI9rPmOExf5k3s6lXxMqFMdIs
 91pLexEx4ftNHNGiUnneeKbm4NCOscsU7oSGb826oiQ3Nz227Vp3G9G13rMJc8SrGOdVceGwWJv
 4rD8ddOKeoTkHm5n7tpwcJlJ5etWNYtiLq8yD971RW71oCSORkf/BfjZTyIMm+X8cWqw3zS6TIY
 u6cBLbPruuwgmnLwTDc/2tt0FoYWWrZTNgL9l3Z09ILtKYBn+U2rwcQya5ofHKi0HIGyg76VmHH
 RJHDhbXxKLAVWfqhMwelzXASm0idmFsQPrvjb6uxDgYhbofXc0o+l+DnQqN1F8yjoAUq7a8vYgU
 D5k4KJvyJauYK1uSOrvSV5gpkCi+GECMctbHw+UrD+s97xH
X-Received: by 2002:a05:6808:1392:b0:4b9:a88b:888c with SMTP id
 5614622812f47-4f5294f9897mr750761b6e.34.1790901185699; 
 Thu, 01 Oct 2026 17:33:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b543:49c5:7c72:a244?
 ([2600:8803:e7e4:500:b543:49c5:7c72:a244])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f5245cf03esm966739b6e.9.2026.10.01.17.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 17:33:04 -0700 (PDT)
Message-ID: <9a0f6b9e-34d9-465e-b3d6-39e527d4af96@baylibre.com>
Date: Thu, 1 Oct 2026 19:33:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] video: mediatek: mtk_disp_mutex: add the DSI
 pipeline
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Heiko Schocher <hs@nabladev.com>, Johan Jonker <jbx6244@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
 <20260928-mt8365-mt8366-add-dsi-support-v1-10-212f51b1742b@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-10-212f51b1742b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/28/26 10:08 AM, Julien Stephan wrote:
> The mutex serialises the components of a pipeline on the same frame: it
> holds the list of the modules started together and the source of the
> start and end of frame signals driving them.
> 
> Extend the driver, so far only used by the MT8188 HDMI pipeline, with the
> DSI pipeline of the MT8365 and the MT8366: the overlay to the DSI,
> through the colour pipeline on the MT8365 and straight out of the rdma on
> the MT8366, which the per-compatible data selects.
> 
> Two compatibles are added, "mediatek,mt8365-disp-mutex" and
> "mediatek,mt8366-disp-mutex". Neither node declares a generic fallback,
> so both SoC specific strings have to be listed; they also differ in
> the module indices, in the DSI0 module bit the MT8366 needs, and in the
> shift of the end-of-frame selector (6 on the MT8365, 7 on the MT8366).
> 
> The MT8365 mutex has no clock of its own, as "no_clk" in the Linux
> driver says, so the shared component probe now tolerates a node without
> a "clocks" property instead of failing on it.
> 
> The driver includes <dm/device.h> and <dm/device_compat.h>, for the
> dev_err() it now uses, instead of <dm.h>.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/mediatek/mtk_disp_comp.c  |   3 +-
>  drivers/video/mediatek/mtk_disp_mutex.c | 120 ++++++++++++++++++++++++++++++--
>  drivers/video/mediatek/mtk_disp_mutex.h |   9 +++
>  3 files changed, 125 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
> index 3846a46f698..5d0e69a75b3 100644
> --- a/drivers/video/mediatek/mtk_disp_comp.c
> +++ b/drivers/video/mediatek/mtk_disp_comp.c
> @@ -114,8 +114,9 @@ int mtk_disp_comp_probe(struct udevice *dev)
>  	if (!priv->base)
>  		return -EINVAL;
>  
> +	/* some components, such as the MT8365 mutex, have no clock of their own */

Should we make a flag in the driver data for that rather than ignoing error?
Otherwise, we might ignore the wrong error and make it harder to troubleshoot.

>  	ret = clk_get_bulk(dev, &priv->clk_bulk);
> -	if (ret) {
> +	if (ret && ret != -ENOENT) {
>  		dev_err(dev, "failed to get clocks: %d\n", ret);
>  		return ret;
>  	}
> diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
> index 0e1d2e3ead2..36a1fca26b1 100644
> --- a/drivers/video/mediatek/mtk_disp_mutex.c
> +++ b/drivers/video/mediatek/mtk_disp_mutex.c

...

>  void mtk_disp_mutex_config_hdmi(struct udevice *dev)
>  {
>  	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_HDMI_ID),
> @@ -65,8 +107,74 @@ void mtk_disp_mutex_config_hdmi(struct udevice *dev)
>  	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_HDMI_ID), MUTEX_EN);
>  }
>  

Similar to the comment in patch 9 and explained more in patch 11 reply,
we really have more than two pipline possibilities. So we could either
make these generic. Or if the bit flags per SoC don't line up, then just
name these functions after the SoC instead

> +static void mtk_disp_mutex_ovl_dsi_enable_color_pipeline(struct udevice *dev)
> +{
> +	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
> +			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_OVL0) |
> +			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_RDMA0) |
> +			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_COLOR0) |
> +			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_CCORR) |
> +			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_AAL) |
> +			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_GAMMA) |
> +			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_DITHER));
> +	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
> +			    MT8365_MUTEX_EOF_DSI0 | MT8365_MUTEX_SOF_DSI0);
> +	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
> +}
> +
> +static void mtk_disp_mutex_ovl_dsi_enable_no_color_pipeline(struct udevice *dev)
> +{
> +	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
> +			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_OVL0) |
> +			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_RDMA0) |
> +			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_DSI0));
> +	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
> +			    MT8366_MUTEX_EOF_DSI0 | MT8366_MUTEX_SOF_DSI0);
> +	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
> +}
> +
> +static const struct mtk_disp_mutex_data mt8365_mutex_data = {
> +	.ovl_dsi_enable = mtk_disp_mutex_ovl_dsi_enable_color_pipeline,
> +};
> +
> +static const struct mtk_disp_mutex_data mt8366_mutex_data = {
> +	.ovl_dsi_enable = mtk_disp_mutex_ovl_dsi_enable_no_color_pipeline,
> +};
> +
> +void mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
> +{
> +	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
> +
> +	if (!mutex->data) {
> +		dev_err(dev, "no DSI pipeline on this mutex\n");

Should we perhaps return an error here?

> +		return;
> +	}
> +
> +	mutex->data->ovl_dsi_enable(dev);
> +}
> +
