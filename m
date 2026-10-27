Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F13606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eGoyGt+v;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FOYDpxgF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6DB280B7D;
	Tue, 27 Oct 2026 06:49:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2niyXv8CntSc; Tue, 27 Oct 2026 06:49:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EE5DD80AF1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793083792;
	b=RqjOcgL8+Hqfm3zzNNt4d0W7708qDGQ8GqDpcemscCmrxH8fvz+DZrn//abHl/35Ze+/
	 SAbRCtd2/U435XvpXkYsi/QpaqNYv3nIhTL14un6LRpAEb/KRw2bXeE9BNfv6mduHc2on
	 g5VwqcIFhT0egdxp35+S4pdmlNhowbObqS/bObxDfI9YxTmkk7fQHzXSzxXGA91HBvycp
	 bzxba87iVuDd8BFYuNtV9WH91ebLMbU51lxwxUzBWGi5M1MPoHsIuQn5uZgdJwg3Frwaj
	 1GVyYinVYPzlB1M/L+R7keqq8RP8hDGFNWeBq4f+AhSZ+z/WxEc+JnHBN5e+5x+lwBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793083792;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xrMsMYQdYJICss8592XAgIhyaKNsRHOy9MhR5kNjZcg=;
	b=Sw8Ex8vInFh3UXznWYp06z9D3VfHNyZFfIAoWuQLTq25/k8CfBDesTvE7kHa5gaw0wUg
	 EwDRWGT2D9OvOiTOFs5Ip6/7Q4rw77vZJZi1n8njjYFeBIp5fcLNNha+WVwPuNTjpuOQS
	 8lkb9dP03+4F7EgIXaqOA/fGNTN+yEZo781OOVDx2bOWWFraaTlUu5GFYX6sEzwcn8eFe
	 NubqJAXHvzUUXhQeGo2ms6+a3Rf5dpKY+ctx/RQA4ZJSSYY4hiII16h7Wt1hPNDYh/KuG
	 1dGGAmcjEcUeSPJril9vBB/mQ3T3tlCTQJJwDLeYFwZfqZPa58kdjCJamEGwiWZRoug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793083792;
	bh=xrMsMYQdYJICss8592XAgIhyaKNsRHOy9MhR5kNjZcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eGoyGt+vXVCpcailutcSVZxtFndJZOoyDCMXesUfZIQaj0HVIo70UkRc+176jragh
	 JFqGl0DlO2LzSfvA4eCLLlHrWtWvTdgmIdwUZDqtaeEmFufr83stHNzQXsv/+zh0dx
	 UViAZVgQeD8UcX9ejxpGjVKI0MVtCTmTBxKXnQPeismfxlEgTwlOn7RirV+jeIj1U/
	 4GVUN4cF5hEnL8SxvKLQ8bWwm8yRVw8GhHK3lmIKNapl9jPdM3ViC7GLo2WQYqwoW3
	 R+nQoOVwU2qesxP9BcXrGDe86oYd+KJDu3FJa3UaMJ1BfDC+za1KB7GCwNRIqLTEaF
	 vmUXLPLfrho/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE5DD80AF1;
	Tue, 27 Oct 2026 06:49:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CE14356
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F1E940589
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H0p9gySb8Mz6 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 06:49:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6CF3740587
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793083790;
 b=KHhMP1Wf6RctRFq6NQhereum6nIOjEBDkdkCkv84hC78Sse19rGzJgKkbg7HDQ7Wvb/3
 Qwy1D8NGgwzLgZgdXqb6jcLI8pb06BziUPPZN/4CnfidT6QeYQIUrmugXhDjzJKeilMVZ
 tq8s5b7k1klDxy6OE29KfhNWhTTp9dxjAzDY1nQQAreox7sGbTqduYLkVFV1Uver+v3fk
 b96/py8xoEw3gR4JIfkZIw42kFZ3EhJO2UmcBZF7JEqFHVLck9DkhLrlObsxZFJi6PmBj
 IBTOwaaa7v838eafCkkp2CPz2+DNn/wumqCzlulgbsAt2qjuyDV6d4oMgBmPnR+ckNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793083790;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=xrMsMYQdYJICss8592XAgIhyaKNsRHOy9MhR5kNjZcg=;
 b=KzBQg/1UHbv9GqE+Rfp3BFnpY/uxMelihyKwBOiYkJryMnqYVnAkxlWCVHRoRh/fMpjp
 F7BTislEvrxhyZu3iNeOl2A9AFqaUs/dGLfnQDDcohwMjJu+o3yZmbmLKpmhoPwUJ6IWD
 DHyazsgLNx2jvakl9KapGxCVRFHZ9nntA98zdmvZO3xrn2d2u7IDQzjyL+k/n5HhpdmY7
 klG+e/Bex9oOQearN0Nm7T2Mb4RPsZBovMJ2s5Qs2E3cK/Cm0Tu729a8ILE2ZUIXg687f
 07/MoGUe8k0rr2oK5x7DHKAVgIK7J2MqmkYL1sujUg4GE+ssp8/boQ9CY7As2Nic72g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FOYDpxgF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FOYDpxgF
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6CF3740587
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:49:49 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so1258678a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793083789; x=1793688589;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xrMsMYQdYJICss8592XAgIhyaKNsRHOy9MhR5kNjZcg=;
 b=FOYDpxgFByNY8JQEQhEa4NhhFruYgpSkG5qjTSL8M05+ztCB6B0zvJ/Y0fU2hMT6Zr
 op13uGhuSh7+SbXUT/WkMd8p2D71xa7L/SnaMj9gUx+cUWr5E74PJGDUH42bwXIz6Us3
 57gGGaSDpFJkwIHGNvVuH+xvYhBEDvD0sFrbQYxoZS7/m6hslWBQjXjGCA0/bUo+pYGT
 zp9v6K3sYJC+QOYROtt3MbQMmJWNWgDlkqJZRvsnSBhUDD/Ns3JTIezDdaib3/19CPgq
 t9v9VpKULrUM1uc5ruuiAs9Ze5gMTjUMFW4Vy2X1nbJYAxTzMWnH0e9pTnaYk7exI/Xz
 jLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793083789; x=1793688589;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xrMsMYQdYJICss8592XAgIhyaKNsRHOy9MhR5kNjZcg=;
 b=os9olTxBE83OqdxDIef3hTgirH6CUamfsVAMfFRKUs0NnjCe+vzpUasw7aKnJ3/QBM
 lUEL/8IpIxO4LzHAg+X3jAJnam1LWwAl+QWQt8lGvB2AmzzLB0Obe1sdRGTHTUzli0KR
 yDv0PukEo9rhuvckMovgmNYyJI94Gx/xAJ3b+rUkeH4eAnAyHpqmeRFhJvJpt9v4tozJ
 gLhoa4q5mbXUmj8AMkVu2f6TzSVubbhQkwTLgt99lOi++1ylO5I3eKU3xNr9MOD0sz8f
 OOB6iy5bidfJXEFYFsvdbAYCT0ekJFgcxJJJLGpztVyOvLvQMVyz69eiXj0moQ5wV+O5
 RS7g==
X-Gm-Message-State: AFq9FYI9kG1YXLHN4lNa59O8W8gOkv/EWYehJ7T1/P5muBakUsRGsvBT
 JJTtO+z1PMvEJvdNu5J7mPU6bS6ZDuv2QcrMNH+6ebPwUbUNFRvj5lfa5hFCyQ==
X-Gm-Gg: AYBFou01mATtGjlrj5A0ey8LUk7cjgfpIAoiefNKNkvWCMnhUq91o++PhiPTd5Hsk7e
 gq7qIqQrxy+4YUutnRl1pUG3DTCuXoS8G3aU8x7KYuQVShAuLCXs+YfbBArXYXPAwYGbCX5Dx9S
 V0yLJyWNixtt9zYLBUv0M5QRz8iDie0yHFCiQbKP5IPFYdtjtO+K1m1HTYOhayzHo7N2HpNSviX
 odY/M2+DUdiuCyP2HaK2ftaRpYGf6dRPCXMaLVRv2W9kTdoJJ5z6QjbtXnyzLpelfxGQwdfae8G
 B3+lG9ZwymVKvj6+u2wav8k04auPzkJlv4KMXSofwh1xyWQntsHUEWDAihSWG5Ql7cYBUIE8qvP
 kkyhWsiWpnKxHuR5Nnaeaj7pmrpXlSBAvDynMr+ivlA4QNItKaZFCpi44nIgpw6+Dw657ff0wFj
 V1UCGKw0IlA+GG2G2+bDiiOI+ZXLW4PpF6MlUs0eGulzi9c9PvxyZfU177eqwwvDr4ZnoIvzphc
 7ou9EE1nlEhzPgnyGGUjGhkifF+UbJx8VzKI9cvP0InMlH8Md//v6QnUyj+QQW3FrEtzP3HaOKd
 pxnV83qzi6t0XM5M8TAqIApkecpHZ/b5VHs=
X-Received: by 2002:a17:90b:4fc9:b0:3a4:9dd7:296f with SMTP id
 98e67ed59e1d1-3adeb0fb875mr6843535a91.40.1793083789238; 
 Mon, 26 Oct 2026 23:49:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:1f3b:75d3:73bb:cec])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae406361e2sm2264785a91.8.2026.10.26.23.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:49:48 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:49:45 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 4/8] virtio: Release virtqueues after device reset
Message-ID: <auBJicrbloG1woFp@google.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-5-bin.meng@processmission.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015111328.1269775-5-bin.meng@processmission.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 15, 2026 at 07:13:19PM +0800, Bin Meng wrote:
> NET, BLK and RNG remove their devices through virtio_reset(). Only the
> modern PCI transport currently frees its virtqueues during reset, so
> MMIO and legacy PCI retain queue allocations across remove and reprobe.
> 
> Wait for reset completion and release queues in the common helper.
> Keep transport reset callbacks limited to resetting hardware only.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
> 
>  drivers/virtio/virtio-uclass.c     | 18 +++++++++++++++++-
>  drivers/virtio/virtio_pci_modern.c | 12 +-----------
>  include/virtio.h                   |  7 ++++++-
>  3 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
> index c163b2fd7d5..978ef0d1ce7 100644
> --- a/drivers/virtio/virtio-uclass.c
> +++ b/drivers/virtio/virtio-uclass.c
> @@ -25,6 +25,7 @@
>  #include <virtio.h>
>  #include <dm/lists.h>
>  #include <linux/bug.h>
> +#include <linux/delay.h>
>  
>  static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
>  	[VIRTIO_ID_NET]		= VIRTIO_NET_DRV_NAME,
> @@ -85,10 +86,25 @@ int virtio_set_status(struct udevice *vdev, u8 status)
>  int virtio_reset(struct udevice *vdev)
>  {
>  	struct dm_virtio_ops *ops;
> +	u8 status;
> +	int ret;
>  
>  	ops = virtio_get_ops(vdev->parent);
>  
> -	return ops->reset(vdev->parent);
> +	ret = ops->reset(vdev->parent);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for the device to stop accessing the queues before freeing them */
> +	do {
> +		ret = ops->get_status(vdev->parent, &status);
> +		if (ret)
> +			return ret;
> +		if (status)
> +			udelay(1000);
> +	} while (status);
> +
> +	return ops->del_vqs(vdev->parent);
>  }
>  
>  int virtio_get_features(struct udevice *vdev, u64 *features)
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index d309f9a9dc1..abc0163fa82 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -14,7 +14,6 @@
>  #include <dm/device.h>
>  #include <linux/bug.h>
>  #include <linux/compat.h>
> -#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include "virtio_pci.h"
> @@ -350,16 +349,7 @@ static int virtio_pci_reset(struct udevice *udev)
>  	/* 0 status means a reset */
>  	iowrite8(0, &priv->common->device_status);
>  
> -	/*
> -	 * After writing 0 to device_status, the driver MUST wait for a read
> -	 * of device_status to return 0 before reinitializing the device.
> -	 * This will flush out the status write, and flush in device writes,
> -	 * including MSI-X interrupts, if any.
> -	 */
> -	while (ioread8(&priv->common->device_status))
> -		udelay(1000);
> -
> -	return virtio_pci_del_vqs(udev);
> +	return 0;
>  }
>  
>  static int virtio_pci_notify(struct udevice *udev, struct virtqueue *vq)
> diff --git a/include/virtio.h b/include/virtio.h
> index b981eead5d7..30e5005e9ad 100644
> --- a/include/virtio.h
> +++ b/include/virtio.h
> @@ -160,6 +160,9 @@ struct dm_virtio_ops {
>  	/**
>  	 * reset() - reset the device
>  	 *
> +	 * The uclass waits for the status to become zero and frees the
> +	 * virtqueues after this operation succeeds.
> +	 *
>  	 * @vdev:	the real virtio device
>  	 * @return 0 if OK, -ve on error
>  	 */
> @@ -288,7 +291,9 @@ int virtio_get_status(struct udevice *vdev, u8 *status);
>  int virtio_set_status(struct udevice *vdev, u8 status);
>  
>  /**
> - * virtio_reset() - reset the device
> + * virtio_reset() - reset the device and free its virtqueues
> + *
> + * Wait for the device status to become zero before freeing the virtqueues.
>   *
>   * @vdev:	the real virtio device
>   * Return: 0 if OK, -ve on error
> -- 
> 2.53.0
> 
