Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05116606A31F
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wx1fZCwk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X5athiYN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D804B4050C;
	Tue, 27 Oct 2026 07:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UqqbqHPnUxD1; Tue, 27 Oct 2026 07:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35D5140577
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793084571;
	b=JrqZFDR+wty10ioHRjZyshfKA1/XFxXUva/m7vPgXZ9bSJ/ZiDuHX2GnV6rRfhK9VUYp
	 2J1/3/8se6rBonbD9XSyJ5FOwoA29P7UXm9ouGKG62ZRBhDAxy70pTPr2ya634CT0NLty
	 mtCVQLZFF1w3MHslqxaRZo2waHAdbobQoyoCahkaMJroPY0/ypGCCvYVQNEPyrNUUUGBs
	 1jL5iUFnFF9EGGszPdHNCevJAsQ2rIl04/eyTcQS4zSI9D34JaXJECMBqmqmFWS6MwG4j
	 sT9kozAHvipRzBFxHjYgwdHJxO1y3l6ylY9/XOwmhfRf26RY8DfD4zMft+cs4ItqG1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793084571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aV/+wORGaMvWq9vsfeSZOO0af++tXcCZ+I8+rNR17IM=;
	b=cC6q/xKfNWdkwZYTuMKdjBBq0RuJ67homksnBWBEUsdDXjjS6//Pa2TsOEqjO6FjsMh6
	 U4cGEkrYON/theV478nuqiKeWgtw5V9LUZgY8sopK7nmdXD4WAmYXj/mbyeGnRQ69Emwd
	 cR+PUnDrHP3onT1NMZHpuGwSEdjbCSURoh62wYt6+uYbmgnjBOTb0ZllrEmoyczOiMYrE
	 SwLK69gFa4mcwIT15CqybWjPUyEV5JE3GivviJmb0eFXC04AlWoWoWhmp4JA+dfPka8Tm
	 RQVkG0wJq7Pd1OyYoOOg5Vq2Yemyb39jP9cdBvi3ofPEZ47rRQ9tW8Xp6TF95+TeaZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X5athiYN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793084571;
	bh=aV/+wORGaMvWq9vsfeSZOO0af++tXcCZ+I8+rNR17IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wx1fZCwk+byU6Q03SX7aF4MSOmbG4WG9S2No+zuvOuLZ3Dh4E3BcbhnIeiO2f8yqe
	 R1EcMdJDq6hiM62Sf6K5w1fFRQvfMc8OYN7Tt2CNcANoOjqcp+OZ91fP1w5y0mnOuH
	 3kGDUCWuORItGSgXagjLVZTFe+ueYCf/g3w1xKix8A7vEhIFbxE7M1LMEWXYjmgIGY
	 ercvHDPVa80jomS48POpRl0B9CNIwkvTfHIaVJGFf832TSyzoVNS07peBPJEE9dldY
	 BJI1B3vmzR/Em2Ai2+x8IY6CSx8y4aSZKtz5flcdKnscN7O093mMnC/Q0AAI2bSPEm
	 fJglBHRh924+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35D5140577;
	Tue, 27 Oct 2026 07:02:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E3FA9120
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9CBF40577
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:02:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EaSNv8khN_tj for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 07:02:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B09B4050C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793084569;
 b=JcW9ZPZqOHfdmrHoE2fJPaCu9G3REOQQgSE7D0BGwicONfXBigR/Q+w15MS7i8P8rHZ/
 rpWY3LxFY3xaPu2v2R4NQBze+7O1RWl6gXAHDepFmoPoATkABWCBgCx4rqXn2XuFqAi/K
 KcIsQYCmVK7upc7JVlrR3emGS4dSz6T89YBmyNqvNF639wEV3DEFZ1VFctn156oV/Ov9G
 ChX/L7mdaDBIURdkuyPdWKmHaEiTnsjLKgQuFH3I/Vzy9QRGLdL7N7YUV4wWktbiEFnaz
 wUotvV5GJkTrLhY1dP4vWVVmGGXCiE5yoHAyFH0tww58NDCMl9YQR8011TeuOXMXqlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793084569;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=aV/+wORGaMvWq9vsfeSZOO0af++tXcCZ+I8+rNR17IM=;
 b=c3+xG1ii2D3JFljJD3dITgBy+Bu1Fckjp1rUhHNIF/30mTsv+6B5iT6HwoWT0Pd/04tM
 Fp9nUSt+AQI7QJCCz0oDXOvh0iGjLkzR/A6c96B3H85fiEaM70SSHbgIq04CUOTeFcu9n
 3sUOf5X182+J8r2GtmwYMEhTagJAmAumjAiu01o53LGml9WZLy8/OTgamQS6uN4XUXKMU
 CVa083AKS/dNwIZJGsJY2kPaEVk2UyeL2FfzaeFVejf16ztNwwk3tEkDf1ejIC9OkRloV
 kyvNDEwDerWUxJMn/VGv4xlcXUWwdzeO6hiwv6s/BYhY0IP+A6a5Y4vA2iUAwYaiVug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=X5athiYN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=X5athiYN
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B09B4050C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:02:48 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3a4b3ac8fb7so1990384a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793084566; x=1793689366;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aV/+wORGaMvWq9vsfeSZOO0af++tXcCZ+I8+rNR17IM=;
 b=X5athiYNKJBpd7sl/bsNPJWNQzefixMR6PzYcc3p8RPiMm79XnOxHcgH43+kxkMgTn
 24veuHoYkyENIi8smCCF/3c1JjYzwjyngrj/ohERWwWie26XJtV+w+qgVV66p3gDHN4l
 GY34QLp7QOQNUyxSpaANxzeKhM5CS8BkanXbmxeDja9baBFl9L9CoNGWLZxvdfvxSG7+
 57nc9Vhch1q19KfxR4JY3c4mpWQ7Spe65IEetvPehYBK6G250vOyweUMz1q/IyTDYpHO
 ehZQNkbAHCTsTyIejVvr1P5sk1/J135OxVKjLiiYmW+XztxO3V/qAwssygvsRwHtz2Tu
 Z4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793084566; x=1793689366;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aV/+wORGaMvWq9vsfeSZOO0af++tXcCZ+I8+rNR17IM=;
 b=sSjJ8QHJvbqo/KJ91id8LlO7ApVUkGSMXRv0QD7VvdSJK1SC3sgv/OAD22s5Qye29s
 TfJ3OQwe2Qj8axRfTxKOP5HPnKLGameLR5nq02EnsU9kJZGAd78mqSKp8mrVLuWhlZ7I
 Z212L5mT+wkIkuPW9NRk6WHjW9zaF8SFOv1aGY1eksCPVew5J1hi5uUkdN0XgaGsStIv
 jKf4rStRPbErPV4y4RlV+34nEz6Zgl/v2s2SWxdZ+4ghyi9t/idj6J75VjklRZEPYXon
 0zEeBETt1yQbMAVJWdIGYSlqGUko/f/F8NO7aV0INwCKpooPx24TPmjDJJwMcll3JIY5
 Pi7A==
X-Gm-Message-State: AFq9FYJJTNK0whzttHUAumsk1/jByTusghrFcYh7kcHnBIQZkaZmoNPI
 Zcz0Dedzci1NmE7nlbKoSXjXfQ8+swWSLqJYC/1/8YT86OAfztYcKHW2EPhveg==
X-Gm-Gg: AYBFou3M3s2AljXKyfomYa9zfQ0uX46KeH5OJUnrFrBTvLvYl0c+eJxZC3MGEP0gMNG
 F63zojvBVQ4iT9x91dF6S1AUavq1yWbZqYSEvKbHXP8dMy7f6aIdvOvNGpOA70Ww3rcUFjifRd0
 sO0GlsfVq2f97IjjiA+EvHZihK/nQtJteo9bMeHsBGa2CWKlZ+akw/OeQwzZ9nkxqYDMh1faijd
 vJZb+PxltsDaqm+qZyUXWFnW5q1pjf7EuTzxgBx+MgLq9/308ilArTMf74GpXRLtAlMgCkVw3Gb
 v00rOTXJwCwG3vwHjO+uzd/R0RMRIFBhIdgUxUcOsmNOmJ9HwOaqvSDxPZYZUD336p97GB31jQO
 1hnkZVPNuQY4xLblvci3ZvyYxe6SQE6HZ0Xjato8WrJXWNaWPVFKATkppgJSA2VnSoM6zL+/6nE
 4OBcoJo047d3QIs5ep0tBJMWu49aCdRw+2JQGN/2zdRM1BpxrrnUP4SkMU0DKiMPY5uhMG8NlM5
 6wIC9ZRHS4tb/ojGZTKoysZnmyzto7VfNXyB9LZyj92SiAvERtsAP4cyttn17lyKxqLVYzYvNxb
 i/vGZLrpf+IKfA==
X-Received: by 2002:a17:90b:4d09:b0:3ab:31e6:12fc with SMTP id
 98e67ed59e1d1-3ade9475f03mr6979891a91.0.1793084566235; 
 Tue, 27 Oct 2026 00:02:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:1f3b:75d3:73bb:cec])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adeba44b3asm7763723a91.1.2026.10.27.00.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 00:02:45 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:02:42 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Christian =?iso-8859-1?Q?P=F6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Daniel Palmer <daniel@thingy.jp>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 6/8] virtio: blk: Validate configuration before creating
 the virtqueue
Message-ID: <auBMkr3_OfEdrqTC@google.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-7-bin.meng@processmission.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015111328.1269775-7-bin.meng@processmission.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 15, 2026 at 07:13:21PM +0800, Bin Meng wrote:
> The block driver allocates its virtqueue before checking the advertised
> block size. An invalid size makes probe return -EIO without releasing
> the queue, causing a memory leak.
> 
> Change to read and validate the configuration before allocating the
> virtqueue instead.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
> 
>  drivers/virtio/virtio_blk.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
> index 404d9140cb2..3d5d29f00df 100644
> --- a/drivers/virtio/virtio_blk.c
> +++ b/drivers/virtio/virtio_blk.c
> @@ -251,13 +251,8 @@ static int virtio_blk_probe(struct udevice *dev)
>  	struct virtio_blk_priv *priv = dev_get_priv(dev);
>  	struct blk_desc *desc = dev_get_uclass_plat(dev);
>  	u64 cap;
> -	int ret;
>  	u32 blk_size;
>  
> -	ret = virtio_find_vqs(dev, 1, &priv->vq);
> -	if (ret)
> -		return ret;
> -
>  	virtio_cread(dev, struct virtio_blk_config, capacity, &cap);
>  	desc->lba = cap;
>  	if (virtio_has_feature(dev, VIRTIO_BLK_F_BLK_SIZE)) {
> @@ -281,7 +276,7 @@ static int virtio_blk_probe(struct udevice *dev)
>  	else
>  		priv->seg_max = -1U;
>  
> -	return 0;
> +	return virtio_find_vqs(dev, 1, &priv->vq);
>  }
>  
>  static const struct blk_ops virtio_blk_ops = {
> -- 
> 2.53.0
> 
> 
