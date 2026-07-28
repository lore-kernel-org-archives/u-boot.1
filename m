Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E89DC531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E1F240A0E;
	Tue, 28 Jul 2026 11:54:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4hGdY5msFmZB; Tue, 28 Jul 2026 11:54:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BEA7409C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785239662;
	bh=dcHuLsdPKmGLrPf8I4kY/fQjiXA4xS4DHEvanubjJA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yemzlgeP2L+dyHWGH0HGk+7jQlvCcS8qRR0x8lmE0eUPJFQMjAL++hV+bGBaBBKgp
	 COqJTkLnJA474L4fuCSIlsoun4GdlkSLOa0Kp3FZOPcRN33AeDtjcFig0cPmnFEFY6
	 LhTbUO1qjJjzb+Kqm9ygzWbMSw/SSmj1ImJrQ0qfZAUf96Waiv+Wpdn8W0DNjDWbTG
	 Gmo6HQnc1gofhBWn8/6PJEZOFlBFDjRH81IFGbDKpw9UsMDvYjCD6GcEQnpuEBSDPo
	 lNosaCG23DEa+yh/u8Gqr66xO8F5B5tPTvr//gGC1TFMJ+QYsDvOM4VBLtA7ORytYG
	 vQiwsutUOKrhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BEA7409C0;
	Tue, 28 Jul 2026 11:54:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FD5526C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 659BD607D5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id spIE07Knhhee for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:54:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8364B60710
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8364B60710
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8364B60710
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:54:19 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso5239469a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785239657; cv=none;
 d=google.com; s=arc-20260327;
 b=Qc1fGcVSp/Hrv6ltCtDxVoT/rQuNK/7nvnobdHA86k/5OewT0K6QnB3GKd+JBdnTpk
 ZD5artQVxrP4PWV8FnB3mf6CkGi2k3ozWvcczBd/IG6sw2YJbvNJS5Oi+NEo5xgjNrDz
 JMVl/rq6Kq0wQCtUSaFMPN9bSHg5YyCbjDIstb5KQb3yxBpKzPmWIi/PfQdUti+KmtAy
 S2P25ygvbHNHV5Sq8IwnXKrj1ZXEuctxZiMsaQUCjxIwdZV2DG4+A5MWbQa7KsKtc6E2
 6EJN+X2oW+JN6Zb88pGj2NwjNRxE6lyJNLlBb3pemMhsFEA6/EL+fH/XU+RA+oz27UR9
 cvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dcHuLsdPKmGLrPf8I4kY/fQjiXA4xS4DHEvanubjJA8=;
 fh=BrX8lee3XPsBGEMuyZ6cRf206vmz8UBHAN71mOhQsKo=;
 b=qUqnIODHPIBfGnPUZ2tgBFwYcbvLPpIHn5tWSgDpn+KX/2N86OeeiHIUKw7be9UPlD
 bRVdbp4WwJs51XqmfiiHBqvI5MPaj6ciC33dEkJct8K8BMNpO+y6YXcuskapfFC5fW1D
 0yRz/kJIu0YA07zvZBLyJhxu9gjKym6jYnxkmfJkZm2Dc4zx9sTaLfRmZTr6Ht/lDNg6
 Hons9ObdDnJxRXfh9HftAPdQ7ouloHRW7AtTV2nahFZTnCKvYJ9kx3YDNY9usefwuMB4
 vwD/KJMjHGrkw9A5IJCgVKG8BSsnCo6pfVUDU+kV3iu1dMHFAwcIOG43zzgESIRaFJPA
 5Acw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785239657; x=1785844457;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dcHuLsdPKmGLrPf8I4kY/fQjiXA4xS4DHEvanubjJA8=;
 b=ZWa00Q7Mvk2Z9bpgptEm/n7Y82UVE6HM+8+Dwyj9RAEoHa150ph3vBtkknAnAvKt6X
 A8oz+QVBk4iCD88E+ksKwLsUEcW8r/qZkJRAnbpDe3veZazHPkWNJdGGzyPyn1o2VR3y
 TGqW7sBAH4VR8dTpNBUc8zNI87hZFJx8TOuHN1akXtWM6LqKkTRlohQuC+2dW6887xfX
 cx8NkTvUN8hx/9xpvj2g5108jPYwDVP0qZDDMBmFTqQF5A7JDblbKk5Xf1a4eChzYlaM
 P+srkQGkBRIp9wRtjSgYqqtF/vVDs9fnocymS7P2aOR+/cg3xVoKhglE1jlDN0FV6FUr
 JUVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyH1n2fxCx5ZXncgHmFhzZ6X6UH6lj2Z0t0irI2XfMgCm59w0QJ8vXHUhDEhD2bRNsxqkXin8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxIf9/zc4k9ql+jOKPpT46pLvmI0A+jp2J50RbpVk3strOUrDIG
 Hb+m4emlh7wL1DW9DI5dNzGERvWp8bcXpcrM7DFIuWbPEnvOHNhpwCVYi+XWH5xKfjlvoB1476o
 /voTr+GjUzXS1fHSG2toXfx2VS9VVAM+08UJGUV5p
X-Gm-Gg: AR+sD13njK4ntlxudV0zLpwVoAQpCd6ztJWEtNP6iHUGxL8jI8XE59/6TU5O+iYbaB7
 3rcLHfZUCngkfyqBO8t3reXrzVheDkUDFQcNwrCLdDcpeJnP5aWnJQUprk+m/sw9Iqwn8Ai/jd+
 QlT9W4BNEhsTp4KEawU2J7ASE7Gbau2917hggIgbPoSD1kYiVjdWiNsy3H0/aN3cdJAggvIv5PU
 4zuAB368s6IDkA0ph4s1hLyVHnvUcJP3HVc0BmVtm0CQCl5NEqm/L/kRTss
X-Received: by 2002:a17:907:c318:b0:c19:80d2:1b09 with SMTP id
 a640c23a62f3a-c1f7251aea4mr111981466b.41.1785239657342; Tue, 28 Jul 2026
 04:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260722-video-oob-fix-v1-0-d6943f687c50@byteray.co.uk>
 <20260722-video-oob-fix-v1-1-d6943f687c50@byteray.co.uk>
In-Reply-To: <20260722-video-oob-fix-v1-1-d6943f687c50@byteray.co.uk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:54:02 -0600
X-Gm-Features: AUfX_mwea55pPhf7wVbBS4xoQAH2IiLGItvFydDSQd0hViYIpk0Hs07hQdvpg64
Message-ID: <CAFLszTjsdYu-JoN1jvOfcWDR-nyEN2CkmCVwx2m6WjMN2mVzXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: bmp: bound RLE8 decode writes to the
 framebuffer
To: shj <shahriyar@byteray.co.uk>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Argus <argus@byteray.co.uk>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785239657; x=1785844457;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dcHuLsdPKmGLrPf8I4kY/fQjiXA4xS4DHEvanubjJA8=;
 b=kwM+9JO3yvAow3ORJ0qXkJ+9JViSa173wg+Qk9D/dZtPDqnbWK+n2m2MJOsMRYR0ug
 H+RMn2bUADEZdJ/d1bF1501jquzF8uA+MOD+leB/tx9C6KhpKzjYt4HPXQhTztRxezzZ
 jFCXRA7nMyb45QylpZ3FZf5tLzzKot+1ySMQY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=kwM+9JO3
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi shj,

On 2026-07-22T07:10:10, shj <shahriyar@byteray.co.uk> wrote:
> video: bmp: bound RLE8 decode writes to the framebuffer
>
> video_display_rle8_bitmap() moves the framebuffer cursor fb up by a
> full row plus a scanline on each End-Of-Line escape, with no
> lower-bound check.  Repeated EOL escapes desynchronise fb from the
> scanline index y: after height - 1 escapes y is back in range while fb
> has drifted about one framebuffer below priv->fb, and the decoder
> writes pixel data before the start of the framebuffer.  The DELTA
> escape recomputes fb from an unchecked y as well.  A crafted RLE8
> image displayed from the splash-screen or PXE-menu path can therefore
> write out of bounds.
>
> Check the cursor against [priv->fb, priv->fb + fb_size) before each
> run and reject the image with -EINVAL if a write would fall outside
> it.
>
> Signed-off-by: shj <shahriyar@byteray.co.uk>
>
> drivers/video/video_bmp.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

> diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
> @@ -337,8 +347,10 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
> -                             video_display_rle8_bitmap(dev, bmp, bpix, palette, fb,
> -                                                       x, y, width, height);
> +                             if (video_display_rle8_bitmap(dev, bmp, bpix,
> +                                                           palette, fb, x, y,
> +                                                           width, height))
> +                                     return -EINVAL;

This now returns a proper error code, so please propagate it rather
than flattening every non-zero value to -EINVAL:

    int ret;
    ...
    ret = video_display_rle8_bitmap(dev, bmp, bpix, palette, fb,
                                    x, y, width, height);
    if (ret)
        return ret;

With this:

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
> @@ -176,6 +178,9 @@ static void video_display_rle8_bitmap(struct udevice *dev,
> +                                             if (fb < fb_start ||
> +                                                 fb + cnt * bytes_per_pixel > fb_end)
> +                                                     return -EINVAL;

BTW this bounds the writes correctly, but the reads from the RLE
stream (bmap) are still unbounded: the decoder advances bmap and the
encoded-run aggregation reads bmap[2]/bmap[3] with no check against
the end of the loaded image, so a crafted image from the same
splash/PXE path can still drive an out-of-bounds read. That is beyond
the scope of this patch, so a follow-up is fine.

Regards,
Simon
