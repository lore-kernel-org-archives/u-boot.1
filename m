Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C707CCA490
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 22:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18111815D3;
	Fri, 16 Oct 2026 22:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5dVbfgSl2XZ; Fri, 16 Oct 2026 22:25:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B55898162E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792189500;
	b=EOmeSXYE6WzDlza5GozjeIRPFZ8KhVg9MMl9r9bgy5LQsVeHWbjsA6le68qPgAjKZ5WJ
	 xduki8US1t9VmZwWc6tzIG1sD2BYqZ9dGm3xPX0S9heTjF4TRTNJ7T++tpl/oCjHOK8QE
	 A2U2X3T8f6H8gAXHhuOcwj1vWkVPVGkWFiLGkwfwNE9msHUEZn3QrX9D33FSyDFOuTxzq
	 +92jWMFLypMiD+RNd5zSkqlENDw5x0EJzqGrqduDedaxAMrOC9g36HWrQt2SLjNWVVA77
	 4bewrfi+a8vQwI8LtD+l0rZ/+Neu10X2qiTKY0PXgFTuho9M1GyR5/wP5O+Vhp6kt9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792189500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1NinarKIiS2qhuLRezSZQkPi0sSWHA7cr0mu+oTWe4o=;
	b=Cfrl5PnDWkEZ+MqLIW3r8iWvs2HWO34uMv7+pwIpr6/JBJw1NIbRe+CRdQXt+5ksvYhM
	 OpPhQNMoqnS4a5PgEGCjVFnExQcivrOtmkVEgEnUHfcmVA54gu4HnzOh/ObwkFZvUYiK6
	 Bdix7EsCKMLxECrJlv4t3GrNnlvzZzxFD9Vt6Nz4P18DglTcSlqugSovSqNrYIwkwThPn
	 pw1wPBmXWzeFfT4uDrqcuIkKHH60hn6Lxzc0MrE9OZGY23w9oSn5RTqPaIeoZ7kiJdRJ8
	 I6x+F/Q+zEW3LlgYjpoSgxhzpvxTa5WMDscC4CT5Ifwm4r4qyYRGta/kG0pP/YU2PWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792189500;
	bh=1NinarKIiS2qhuLRezSZQkPi0sSWHA7cr0mu+oTWe4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HxyyaUGO7WByN8fb1zavotfKz+VxbZn0iMpuYDsH1hdL+a+7vWHWkSY3VQHS1MRr/
	 WLaYaQidh/M47JfD5rjj6xUQm+23ANcSd4tb11io2yD5z43Hqzp7aFUMDiMRriIq6x
	 AGzB6jrvPxaK1Pd/sda4guHaD45AOPjf8NANc3ofqWFJ1j3hMe4FzU4qPlsGe2S+nK
	 xxsJyEvqWXMNwG9flhPRwREV35wLcSz925QtYpuLvrXZ8y0jAQijK4WN/uvTGWBFpY
	 TdGfMbFf+ZDbt4sneTyJdhBC1wqekdQaH8N7sqMFXRZnvYtufCUog5yR1TVvN16VLA
	 44irBR5TBBLXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B55898162E;
	Fri, 16 Oct 2026 22:25:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 75E03362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BF4D409C8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:24:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IR8L77Gj1OOf for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 22:24:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A1645408BD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a02:830a:f787:8f00::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792189496;
 b=GGZF27rN8ETx7A9cZtaPczRPxKLyJOSsdBzHMjMlYNnNd0f52V3/0ssSksT4yrx/sNX8
 zlvO2RJbCO9D2CIqohAQxkkFDgLVMmTY3drRN4vjoZSJw6w+7imIVhBSgirxLrRFwG5DC
 f4gJETzqb7ILu3AYedflcXR+oc9HX6vjt5u7UrYOhAJI3FGP2YG7yqCtaQkWOc+TNCyK/
 uqU0ankg4lGCv2eGNoymihnCHunG7UVv6O+V5olHc2uKOGfzgmCNVGBu3BRvTi0w3igjn
 9DwO3/idW4ByD/7YVp/J65Ic2hxCy+63wv8RlPyGt9dV3yJ9Q8dy9H//ek92YDCnCjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792189496;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=1NinarKIiS2qhuLRezSZQkPi0sSWHA7cr0mu+oTWe4o=;
 b=jBFBb9VxGTzcNEqEuNCF07AIw1t+cKpznJiYl3eRed/w1ym/cQcRZ1KS7P5nzaxFIOEX
 KDj4LhszbGfBmAH0t36kTDpq7+uCUuzQ20bCc4LHKXZg8J+86/dX6Dbo4n4+talgP4VMy
 VWe0jQGfWn3qQaYpjUw5eImsa8i1LQVQ6OBTtpo3Xe6S3P/TcP2MoogVvoeke4wmiesS3
 fmm/J8vR3w261MXvyDcXH6x3mhJwAUMg4iXs/X/1SLCj62+4VQAtV/xcS7J1GqyAkdYpW
 uKCppmMLmHzycdPy0YnhfxSCjjC+m6MpR3bxgLi5fyxs/0guTG91BZ5zLUT4POyQwWA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=ixit.cz;
 dkim=pass header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256 header.s=dkim
 header.b=pmfOh07i; 
 arc=none smtp.remote-ip="2a02:830a:f787:8f00::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:830a:f787:8f00::2; helo=ixit.cz; envelope-from=david@ixit.cz;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256
 header.s=dkim header.b=pmfOh07i
Received: from ixit.cz (ixit.cz [IPv6:2a02:830a:f787:8f00::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1645408BD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:24:54 +0000 (UTC)
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown
 [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id E2D0B53401DE;
 Sat, 17 Oct 2026 00:24:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1792189490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1NinarKIiS2qhuLRezSZQkPi0sSWHA7cr0mu+oTWe4o=;
 b=pmfOh07i/0SXmfI0AUj0TVvlfcmX9RHzI90WKaZWw7LNHEDm8po7awXMPw5SP5wNFI8gZ9
 Q+0io9/sCMjTQRpo38+M7kR8bIbpOIvsDnZ4OboJuovEl8GG31w/vi9d9R+Ml3vCNAacLo
 TdRAPdb4u5mWzacfG+GphuOnEYPZc+o=
Message-ID: <8255ef63-dc32-430a-8a82-646d896b6b80@ixit.cz>
Date: Sat, 17 Oct 2026 00:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: simplefb: add an a8r8g8b8 format with an opaque
 alpha
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini
 <trini@konsulko.com>, Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Aelin Reidel <aelin@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Petr Pavlata <petr@acrux.cz>
References: <20261017-b4-simplefb-a8r8g8b8-v1-1-ce7e80682a5c@protonmail.com>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20261017-b4-simplefb-a8r8g8b8-v1-1-ce7e80682a5c@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 17/10/2026 00:07, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Map "a8r8g8b8" to a new VIDEO_A8R8G8B8 format that writes 0xff in the
> alpha byte for the console colours and for the BMP/logo paths.
> 
> Adds support for the framebuffer on Xiaomi Redmi Note 8 Pro (begonia).
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
> Doing bringup on the Xiaomi Xiaomi Redmi Note 8 Pro (begonia) and
> encountered the following frambuffer format.
> 
> For a simple-framebuffer node with format "a8r8g8b8" U-Boot currently writes
> the pixels as x8r8g8b8 leaving the alpha byte zero. Therefore the console
> background and logo are fully transparent and the screen stays black.
> ---
>   drivers/video/simplefb.c     | 6 ++++--
>   drivers/video/video-uclass.c | 5 +++++
>   drivers/video/video_bmp.c    | 9 ++++++---
>   include/video.h              | 1 +
>   4 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index 8d0772d4e51..3dc073bce9e 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -71,8 +71,10 @@ static int simple_video_probe(struct udevice *dev)
>   		   strcmp(format, "x8b8g8r8") == 0) {
>   		uc_priv->bpix = VIDEO_BPP32;
>   		uc_priv->format = VIDEO_X8B8G8R8;
> -	} else if (strcmp(format, "a8r8g8b8") == 0 ||
> -		   strcmp(format, "x8r8g8b8") == 0) {
> +	} else if (strcmp(format, "a8r8g8b8") == 0) {
> +		uc_priv->bpix = VIDEO_BPP32;
> +		uc_priv->format = VIDEO_A8R8G8B8;
> +	} else if (strcmp(format, "x8r8g8b8") == 0) {
>   		uc_priv->bpix = VIDEO_BPP32;
>   		uc_priv->format = VIDEO_X8R8G8B8;
>   	} else if (strcmp(format, "a2r10g10b10") == 0 ||
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index 53641fc28b6..68fd9ef38c0 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -354,6 +354,11 @@ u32 video_index_to_colour(struct video_priv *priv, enum colour_idx idx)
>   				return (colours[idx].r << 24) |
>   				       (colours[idx].g << 16) |
>   				       (colours[idx].b << 8) | 0xff;
> +			case VIDEO_A8R8G8B8:
> +				return 0xff000000 |

Hi Petr, few nits.

keep the style :) (0xff << 24)

> +				       (colours[idx].r << 16) |
> +				       (colours[idx].g <<  8) |
> +				       (colours[idx].b <<  0);
>   			default:
>   				return (colours[idx].r << 16) |
>   				       (colours[idx].g <<  8) |
> diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
> index 1f267d45812..98ed59e275e 100644
> --- a/drivers/video/video_bmp.c
> +++ b/drivers/video/video_bmp.c
> @@ -88,7 +88,7 @@ static void write_pix8(u8 *fb, uint bpix, enum video_format eformat,
>   			*fb++ = cte->blue;
>   			*fb++ = cte->green;
>   			*fb++ = cte->red;
> -			*fb++ = 0;
> +			*fb++ = eformat == VIDEO_A8R8G8B8 ? 0xff : 0;

since X8 variants ignore the bits, I would say it's safe 0xff everywhere.

>   		}
>   	}
>   }
> @@ -409,7 +409,8 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
>   						*fb++ = *bmap++;
>   						*fb++ = *bmap++;
>   						*fb++ = *bmap++;
> -						*fb++ = 0;
> +						*fb++ = eformat == VIDEO_A8R8G8B8 ?
> +							0xff : 0;

ditto

>   					}
>   				}
>   				fb -= priv->line_length + width * (bpix / 8);
> @@ -447,7 +448,9 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
>   						*fb++ = *bmap++;
>   						*fb++ = *bmap++;
>   						*fb++ = *bmap++;
> -						*fb++ = *bmap++;
> +						/* blend on alpha */
> +						*fb++ = eformat == VIDEO_A8R8G8B8 ?
> +							(bmap++, 0xff) : *bmap++;

ditto

>   					}
>   				}
>   				fb -= priv->line_length + width * (bpix / 8);
> diff --git a/include/video.h b/include/video.h
> index 9ea6b676463..71e9558dba1 100644
> --- a/include/video.h
> +++ b/include/video.h
> @@ -67,6 +67,7 @@ enum video_format {
>   	VIDEO_X8B8G8R8,
>   	VIDEO_X8R8G8B8,
>   	VIDEO_X2R10G10B10,
> +	VIDEO_A8R8G8B8,

you can drop this one for already existing VIDEO_ARGB8888

David

>   };
>   
>   /**
> 
> ---
> base-commit: 1bcb2fe324180d0a8cfbdb0511737eba1d5b8550
> change-id: 20261016-b4-simplefb-a8r8g8b8-2dc70be64fcb
> 
> Best regards,
> --
> Petr Hodina <petr.hodina@protonmail.com>
> 
> 

