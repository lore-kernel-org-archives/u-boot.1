Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1F8C54FCD
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C87FA80F59;
	Wed, 29 Jul 2026 21:52:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9gZ0Nce2cYc; Wed, 29 Jul 2026 21:52:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C140980F48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361936;
	bh=4iTpJncp8igwedFPD8nyaTrf2H/PS/j5lo85MZ6wEcc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AklW5lfbWCFLia2TNVAn/Cn8FpR+7PCIiIbld62+WheRD8XQ4v3bw/XSRGiLQmUFR
	 YLcJc91lHx4UhcUUDEfjHgn9LKzKYNQ9L0xC5m5KyOV3vEeuQAl69Y03LUh+TTqFeJ
	 ptzWd6AAYcK7ftkTyBFJaOZ98st5iJw4+zcvKyzqglUma99ZQy4XI5VQhfVT2K0nKT
	 fgKlvRhSjYWvEbZozAkvpmZXfrko3QkhI2Db3EJJRIOQV3Fr84gxEf3NJHRbWBJDSa
	 GUQbxY9kGfa3K+fIhNGVqwIzJ7xanwwy7oIG4INT4WNy/J+EFgcBSF+tH5B9iXbZ0E
	 FKuDFO7GyDLqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C140980F48;
	Wed, 29 Jul 2026 21:52:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2DE22E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8F5A80C06
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SbG0kwXpAttC for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 16:47:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B7F138064C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7F138064C
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7F138064C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:58 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-495437bb891so581785e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785343676; x=1785948476;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4iTpJncp8igwedFPD8nyaTrf2H/PS/j5lo85MZ6wEcc=;
 b=D8ui9URV+zR2z6Ff6TSv3M1TZf+GQf6V8d2apMrzAnZhpv3oVsCPWl+G6dEaSerWW1
 CzhKGMQQMSPjCuxNzunZt50Gou6L46RvM3g8Qq1dZk6xm/73V9f5H3UV1miXGCeJzCdm
 TjOyjLHVAX1AI1Ra5+e0gPHDIihvMjeTDYVkfa565qfWugJ+/CSl/EotQOq6lA8B1VYD
 miAcDzbMG4v9+F6F8rBBVPOnjUTw5Ukt1z9z6jv6BZxYwn17WhuDO8ygX4OdovrKW1mT
 GnFJVZbC8QeO5ga9BGoT5T25+Cw7cJh97ETRpY/DIqBRWb8sPNtgBb7VMqP9eZ1ZG/ob
 niRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDIJ2G2yJ7AJ1uPMPsmvsdmb0EDVfU7+6Asfq1tk9XZJ9GwBXu8ANgQqPRKiStRpid7VXx420=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzRIyba+SjZ4We6zTRgvFnd3B0KUi+lRTd2QzciY6/znyYxHsT0
 mI+trqfVyb3K4+nmbp3kJKdW7DW5OCjlu9/b8L/BMitQmKDdQSv62QmeEv3H0r3L0GE=
X-Gm-Gg: AR+sD13wPyBbr9SZBHGI4mYGw0dkkeI4TJeFLnfg6IeTFOPBljODy06staU3/lVRa7Q
 pF3ZevnLtr/NWGCGpXPfpI2X08BIg0PaMRHWB0OXz2jTJigQ55Q7KHvB8/UUYGfrNvyjAo7zU64
 iVzZzUUPTyfJaJChR7vLGxZPxKg+7pi24jtJeSM2yhhSpZrBV+M9tKQQSHn15FNt5crHt4/uJJk
 ORcxE9zBH3OIJE1LO//DChKAGDlGh6zlmwE9ezoVZZYhH0HsO1BbX74mirieAHafbhozLbYbbpv
 x+IDwq6249nnULS19URAf8Y3IhBVLihqVbmbeCRaJaQpw43yFlXJkJC1zfDiEJTiKnUQJY+Sibe
 iMdIBB+dvVNo5nwCZ2F4+qSOzCQf1ZnEK2mfTXhe5x8Owf0SRS/bmhC9IJnacmwvAHq+pIx2t+C
 Py7x2RSWPQGzR6mUpfGSWzLupa/suEU+M3Krrfe+sXe+mxwV8HyZgL72rPGcHbh9ZYWF/Z/DkiA
 GEy3lu/MZa3gY+mJrPNJVRQZjubACw0v5E/Nf9kBxZBdaCbGbUEgTw94rDsf6zxuhlguILNprri
 icJQ4U6O2gSWiMRDWfWGa2CA7n4zFTTlCs+3NYJfNd9E9wKh+yecRxRi
X-Received: by 2002:a05:600c:6d15:b0:495:636b:e50b with SMTP id
 5b1f17b1804b1-497fd2de69fmr28081785e9.6.1785343676592; 
 Wed, 29 Jul 2026 09:47:56 -0700 (PDT)
Received: from ?IPV6:2003:ff:f03:8f00:4cb1:53a4:7b38:3d18?
 (p200300ff0f038f004cb153a47b383d18.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:4cb1:53a4:7b38:3d18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb647a8d4sm9550505f8f.0.2026.07.29.09.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 09:47:55 -0700 (PDT)
Message-ID: <8f45a6ec-db43-407b-89ad-0dbbdcefdb4f@byteray.co.uk>
Date: Wed, 29 Jul 2026 18:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] video: bmp: bound RLE8 decode writes to the
 framebuffer
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>,
 Argus <argus@byteray.co.uk>, u-boot@lists.u-boot-project.org
References: <20260722-video-oob-fix-v1-0-d6943f687c50@byteray.co.uk>
 <20260722-video-oob-fix-v1-1-d6943f687c50@byteray.co.uk>
 <CAFLszTjsdYu-JoN1jvOfcWDR-nyEN2CkmCVwx2m6WjMN2mVzXA@mail.gmail.com>
Content-Language: en-US
From: shj <shahriyar@byteray.co.uk>
In-Reply-To: <CAFLszTjsdYu-JoN1jvOfcWDR-nyEN2CkmCVwx2m6WjMN2mVzXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Jul 2026 21:52:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785343676; x=1785948476;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4iTpJncp8igwedFPD8nyaTrf2H/PS/j5lo85MZ6wEcc=;
 b=JmIK4ea7u36oNujcQ3kSbvTysHLyEsDKoKobTCoNTdtTyCyPLXw7rEglNIqeE9UYe9
 EjzgwzQS7s1T0/uSixPrPCBSlGOMNW6Ra6q60vuWP3pUspIsZsqlUqdwLtH8x9h6ZYzN
 CUtWbTPJ4vlacT/4st9PHaE0YcoD92UPioC2H8n8F6qkfjFzS3lW9pA+6mPW3DvODcf7
 d4bmF5S+YEKh/ClWxKSsMIH61GS2+q7wbQK+yOlKW5sAFnYgWRDow5/O2uFs6fu6r6iB
 M12LCFu/JRAkq31PWvH9njoGvFmNL0pt8zndMyJ/jipliGnHkYmyLSzomCgcnxtxdlF2
 9TkA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=JmIK4ea7
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

Hi Simon,

Thanks! Fixed in v3.

And good catch on the unbounded RLE reads. I'll send that as a separate 
follow-up.


Thanks,
Shah

On 28.07.26 13:54, Simon Glass wrote:
> Hi shj,
>
> On 2026-07-22T07:10:10, shj <shahriyar@byteray.co.uk> wrote:
>> video: bmp: bound RLE8 decode writes to the framebuffer
>>
>> video_display_rle8_bitmap() moves the framebuffer cursor fb up by a
>> full row plus a scanline on each End-Of-Line escape, with no
>> lower-bound check.  Repeated EOL escapes desynchronise fb from the
>> scanline index y: after height - 1 escapes y is back in range while fb
>> has drifted about one framebuffer below priv->fb, and the decoder
>> writes pixel data before the start of the framebuffer.  The DELTA
>> escape recomputes fb from an unchecked y as well.  A crafted RLE8
>> image displayed from the splash-screen or PXE-menu path can therefore
>> write out of bounds.
>>
>> Check the cursor against [priv->fb, priv->fb + fb_size) before each
>> run and reject the image with -EINVAL if a write would fall outside
>> it.
>>
>> Signed-off-by: shj <shahriyar@byteray.co.uk>
>>
>> drivers/video/video_bmp.c | 26 +++++++++++++++++++-------
>>   1 file changed, 19 insertions(+), 7 deletions(-)
>> diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
>> @@ -337,8 +347,10 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
>> -                             video_display_rle8_bitmap(dev, bmp, bpix, palette, fb,
>> -                                                       x, y, width, height);
>> +                             if (video_display_rle8_bitmap(dev, bmp, bpix,
>> +                                                           palette, fb, x, y,
>> +                                                           width, height))
>> +                                     return -EINVAL;
> This now returns a proper error code, so please propagate it rather
> than flattening every non-zero value to -EINVAL:
>
>      int ret;
>      ...
>      ret = video_display_rle8_bitmap(dev, bmp, bpix, palette, fb,
>                                      x, y, width, height);
>      if (ret)
>          return ret;
>
> With this:
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
>> diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
>> @@ -176,6 +178,9 @@ static void video_display_rle8_bitmap(struct udevice *dev,
>> +                                             if (fb < fb_start ||
>> +                                                 fb + cnt * bytes_per_pixel > fb_end)
>> +                                                     return -EINVAL;
> BTW this bounds the writes correctly, but the reads from the RLE
> stream (bmap) are still unbounded: the decoder advances bmap and the
> encoded-run aggregation reads bmap[2]/bmap[3] with no check against
> the end of the loaded image, so a crafted image from the same
> splash/PXE path can still drive an out-of-bounds read. That is beyond
> the scope of this patch, so a follow-up is fine.
>
> Regards,
> Simon
