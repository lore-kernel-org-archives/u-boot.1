Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E5606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bRB+nmSU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sp1HLQRP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F37604050C;
	Tue, 27 Oct 2026 07:02:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fc_1erqqCvQY; Tue, 27 Oct 2026 07:02:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4E8464056E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793084529;
	b=amM+kmrJmPFj7SKXy4qV1649BJ6ipOvsFUQjpFb32LM6fsFiOhZLP5X4aZCEJdEbisiE
	 mv6K8ufjnsQUMV2ssFpB0Qb1FHmkhZSh+T/tg/Ril0yseSPohRUXjNKQGm+q/nJ9+Gh0V
	 HSGHJzIqTEZT82FTRCOvBR1N1qQ8ez9k8PR4CreB2nVMsZKpZvBR8eCLbDRhbFKGtqdNP
	 63x21lvbylDn4p3iecRSiqBfQxHw+Xe9/798ZUhqgEljOgMl/1y/y6YCafolFvLMWNMpo
	 9ITzH2vMZmCuTDKoh0cN97h0a9B9YE81FDJ638aquMLaQzELHzmNQwdQPJd+LiIsjQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793084529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L8MHZGN9sip7Fk3g3URoTfRJ/8syygZ67qMBmwLyyNI=;
	b=s8/Za9MG9bBamaium8dxDm+jHawL1GwKzUHUQb3y83WgD2VpbmqblFa1hpRO9Hi4Xz1j
	 S2ZFx6Y+IrKQzg56z+RnKuCAc5/oobX/e8CCgWWzr0AwVGtl1VdQvRRPppMNp3Jmx5plY
	 V6Y0a5jFTSrkjBEEjoH7icsjEodQ7mf4XqitJ9pHbEPZJ2VZxsUf/IrMY45ejjmggpDjX
	 JxLyarwIN4avLVDbD2vp3h1ezlw5837n15nguR2O/FV2Dr93Eb4AdrJPR6k1QVla6HiLb
	 aIBTpVP8N+2IjWwhp3mx8rboB+YxcmBQzvVC5t4XAOSNhZuMrseYI7/xlOvc+CtKP0Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793084529;
	bh=L8MHZGN9sip7Fk3g3URoTfRJ/8syygZ67qMBmwLyyNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bRB+nmSU8+qqS7lzfxBgqclCPBuhBBbEqSVr4VT0smUyDD9AL1GQqvlrk3BWqlaVh
	 Y9mXBqpZrchrcJvYPoIuNvttHz7wc/vQ7u4yaccInoHmgSavpgzPFuI/F63ILSMuj2
	 4Pkra/GMc9IYjyO+Ga5pha1SNUQ1ff5HRrmG5sJTw/gmF1uHL3z0BOlLRALGMQW3WW
	 DGX+e63uAMgxRT4m2NV8m/GND1XzqBMcgTYdY5tDvr6vM68qZiHNEg+D+fA+LTowc5
	 Qi023YfZH9+QZcURnBcG/EHZpTOAzxpYSYI4HaoDO+Dm7iuOl1Lv5HgyHcolvbRGk4
	 fooNH2mUD46+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E8464056E;
	Tue, 27 Oct 2026 07:02:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CBD4356
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E10280C12
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xYqyzw6kD0O9 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 07:02:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D5FDF80BDD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793084527;
 b=juUOLdJgulM7ZX+3YWbPWd+G5a+VJSYwevgvF7tYmhVsfSgdwh5vc7SxrJpEkrjk6UfS
 c3NgpXo2WI+E8JfY/39YfAm9OeuAKb/SFua3zqAOLoDVqNtCO0srbyx83Jgw1Xydk/lVr
 nutV+6GYpDmzPyD1QyWseamKQmJyxhtMqBx9xlbyjj9FzplYhxvXZMoYY9wo70zFZomHQ
 xiPPh7L5CUaHt6P2F5aCHxQ5iUhF3H861bYseX0nkYiFy8PN1CaikQdF2JGPirrc4LQON
 fRcr5EFmzPLyqMOouz9bXlYQRKP7EpnGu5N18SazymVwSbKof/Sgshe3P11668YCIYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793084527;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=L8MHZGN9sip7Fk3g3URoTfRJ/8syygZ67qMBmwLyyNI=;
 b=Me2CQG+SPKEba25Ie1oBlzloqKRw8iEAakPHSYRst8ZgeYNTJ1fM8dzZEUJzeQ5rSCUO
 qOoBWJ3cVGN+Gq7jxpZ0rMMH4wm+f0kQ588GPgqT47+/3f6s8belFQ84moULif3o5+MY2
 9lNNSltzZkjfgvKZZ5pYE16hGMvU6nPlv8iw62nb0WzfcK2yiqr900jHcWn5yYIOgsDK9
 7WBGKu4RU//lGgLsr8uhxorIHi9vqSECXRjXWr+Vot8YWSDmdyGgpIYGHuhKrPrxxVtT9
 QwvB/EJXJ2Qm/uwW+AbDzZCvs/C20k6u2zFqJoZBmMJrrZRdIcZz0Zk4AXc9yFlhTmg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sp1HLQRP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=sp1HLQRP
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D5FDF80BDD
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:02:06 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2e9d7791b00so24271885ad.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793084526; x=1793689326;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L8MHZGN9sip7Fk3g3URoTfRJ/8syygZ67qMBmwLyyNI=;
 b=sp1HLQRPrVMdySr96oF8GU9GGmIEn1pvwyUg1Zv3RXuasRflKC4M1ddhURsKtZch2n
 jVxtNXYZUYNj8IQcGflE5eN/+mzJwj8cq0ntUpLCbG6gzJjfUQT8wF1c7JWvogdzLGkT
 H1wa113ThWk/5EvoYLE6I1mbraxJewpVzeSDUmH3FrM9EVs6uyUcq5SCKTUklne8fC2c
 XUcACvVBfjQGwYjnFbih+2EYpvOUKLOyyDnEWSMTHLDXiLw28PQM2mJJ3o2HbpOG8/CD
 08SoDLB2hyALlA2jweWELKvOJCoTcXAK2w42aBzffmrvbY6WJe+BRRXJZ+V94wkwt4WN
 OwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793084526; x=1793689326;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L8MHZGN9sip7Fk3g3URoTfRJ/8syygZ67qMBmwLyyNI=;
 b=PWGp8rHOAAid46aZQ4Vds6loNLJrcqZNFlJhbqBKYDlK+3+jxZDgYTboe4i5akOu9x
 WJE4+9lZ5eVIpHMekfDIn1gTMI/PqX3EbBaHTdabgGkh92V4sUvDgpgu6P04yHyxiBB/
 4Q8CSpTSTrQ44ZANm1eB/jezeQJuBm/HU0GQ/iujY3aXWMI9u6coIra7GGr2bD4Rc+XZ
 ariAFVNTWlIL1PcwqXHtQ6oo+jZB5m1TY734pzz7T99gWlkwD8LpSC+g3v5vN/CPPZS0
 TiT83P71o83c0x7VoD+KWHTXaGQ7cuZExW0pYb7y9Auwc21tBCilETji3WhMD9wMonyC
 5IhA==
X-Gm-Message-State: AFq9FYL9tak7U8ZIAY8xIS060c3yOFp4EnXkC5rQMNIuZ9Mt0OilgPP/
 bU2uwnKJMPgcnT5P42YWDEyNR0WyUXMM8uBGrOihfeccGF6XP4QN6CEj
X-Gm-Gg: AYBFou1jAL9O3dK1XFE3ZyPlAip6nCM98wSpvg3OkhW2uta6W57wI3/OZb49LJl+H2p
 OzkR2tWpM3x3UqC4bLRTDLXg7vNHfqcXSvXDS3R3nwYK4fQSfy++VqaRxUiPrjq8nXYaxe5jceV
 ObeS+ENy+5JmkOZuyaXXw0j9ds5XP4O0d9gyoCc/nYoawxb9T9OjuL0PYaqZfyOv6d9O0DOqz+n
 r100qe53KQcLT3sMf6uk8+3m16QNpZ/cS9gBs1Dg+NGimWbOycadroDolS2mZyf4g4u9Ay/Wa84
 Ao8qEIv6UG24X8F/GccuTEdIYirpw/0WYQrphBUUyszZwcovcRLNOlgxZch5FyHiv5e0cRIwBmU
 F3LH1s7HjZfloYYexJQW/LyZC4p22AJmTnLYLmpU2asJlRmFa9TDZwc+roiV53plRYdV+kaQCYC
 xb32BCSYGm1LHNU1MzauFG8bAFHZeODzwfAeHbw7KdtHnSL7CuQfzQYdeGQEBa//swCW90P/2BX
 dmqp2uHZLVhq5+hJmQZYUgUQ3H8pYzubpdjpq9ifOr0BRpWR8oWczRTnHhsP3+Ka9ko4+HU7y5a
 ZI/k/Ni7NAVvBNY=
X-Received: by 2002:a17:902:dac9:b0:2e9:401f:f0f4 with SMTP id
 d9443c01a7336-2ea9c5e240amr75808955ad.16.1793084525623; 
 Tue, 27 Oct 2026 00:02:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:1f3b:75d3:73bb:cec])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c407aasm4513145ad.54.2026.10.27.00.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 00:02:04 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:02:01 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/8] virtio: pci: Fix legacy private data lookup when
 deleting queues
Message-ID: <auBMaWkFU9gtA0SU@google.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-3-bin.meng@processmission.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015111328.1269775-3-bin.meng@processmission.com>
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

On Thu, Oct 15, 2026 at 07:13:17PM +0800, Bin Meng wrote:
> The virtqueue's vdev points to the functional device, while the PCI I/O
> register mapping belongs to its parent transport. The current lookup
> therefore treats the functional driver's private data as transport data
> and uses a queue pointer as the register base.
> 
> Queue deletion can overwrite the queue's list links and crash when
> unlinking it. Fetch the parent transport's private data instead.
> 
> Fixes: 4135e10732a0 ("virtio: Add virtio over pci transport driver")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
> 
>  drivers/virtio/virtio_pci_legacy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 15f8c6e7d25..369c15bd88c 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -226,7 +226,7 @@ error_available:
>  
>  static void virtio_pci_del_vq(struct virtqueue *vq)
>  {
> -	struct virtio_pci_priv *priv = dev_get_priv(vq->vdev);
> +	struct virtio_pci_priv *priv = dev_get_priv(vq->vdev->parent);
>  	unsigned int index = vq->index;
>  
>  	iowrite16(index, priv->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> -- 
> 2.53.0
> 
> 
