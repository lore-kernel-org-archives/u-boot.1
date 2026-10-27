Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1239606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SyVzlHw/;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CCzVRo5N
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF6ED40422;
	Tue, 27 Oct 2026 06:50:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KAWHqtvrSoYq; Tue, 27 Oct 2026 06:50:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04857404EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793083810;
	b=NZvLt2NL3pd57RqsIxbCNQLOyX4UjLbCYFeNArLvMko1Z9yOW7BxomYfWQfO2TZVk9BR
	 d/X7Bwz+EMLRp8Q12yzXq1IiXHMD5IMhh7VcQXKUAnLMyrJvj/rYwLvkwNj+maGXZm3B+
	 +sVA5Q7Ba45o4C+koByth5PRAeZQ+piaJw6jsjDLeJZOV2y8+dcVrzhTzs+NcpD9jmk9t
	 0NJTS2OuIijuea4/DVNuei5Sgb6FRF3y4oXNNifl2JAf5Rqjb58TU47riNsojRL1nyWM3
	 YpnswFwkkslp+PuR8nEFeJUyfugkvqTsXVmCYvrgQZcuTL27+DtcCW9at9DVB/8ytvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793083810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RQbsFZib9ViJsdmgpUeWmSmjViiPX+6t17wufyFxaBw=;
	b=nPg9vWjWnwN6p+be1PG1DC/7za8JgtwveWdbvN4/AJbkNkhAi3wgte+rRIQFmXZ2AfYb
	 PKNLWN9EmGqzk3EmU/kn5Al5ehVOANuM6237dCOTXwlqAFJLb1M6lda5q0R8TKH7olQ++
	 Pbk4l7p6gaGkeMubP0uWoImIFXgSQCuEUD8YROy8W0s4d1/MjlH86zb4owYi/dwQSpqSV
	 +lpNUkPnSKc/3ufdgrIg+wEyU4N77Dnt1OoQ1ZJKXftzz12RbJvzDwNGXS9yXTm0ztDuo
	 r0fr0JI6fQmP86ktkkXF6UgRGRUh6fVodBW11yI2xFOH31KYfhdwb4dC2RR7CPrDzBw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793083810;
	bh=RQbsFZib9ViJsdmgpUeWmSmjViiPX+6t17wufyFxaBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SyVzlHw/jKR8fCbvFSc9RA6F1G0maNkwkt+MU2zEQw3q2i3Gj9HR815Dlv8pO+fpz
	 iIaN30ZguTyVHmzh48q1AWu5tekpCIfH2ZNiNGQ52bbmoTiVz/PQ5RM4mq1dVXGd7t
	 0atUY0fCcfHvfYL6raHE5xyvC1Jj1Qrqsvg98Lr1xnyN26N4kSzRXKrOV+5G8lV1FH
	 HHCTdcXL4yUbe22FaNgP+QGuZqB0vXsYwhJGD7RfXJXnixGzNFplw4GsGtlsKZ0uIJ
	 Yg+R38aEUDQTHlo8QGzxZ20OvN2GQcJ3IcH2V0/iebQ0H8jA5Futp1N3HMjzcdDzl2
	 njgEJ17GY0bBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04857404EE;
	Tue, 27 Oct 2026 06:50:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7EA24BC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99E5D400A8
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nvuj6prCbXk0 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 06:50:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0DB2B40062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793083807;
 b=NT7//DfYSiEaOLc+1IP/uxsPHa/Gs731lpdXq7X+L2fTB4P73Ma4gm/BRQMyLILVzLFg
 5D6fUoCTo/UlXBdGT3t+kL96+gwhMG6TPxGyJdYKvqK3dfJuvvgi8ngymFyNn6tPKgbar
 K1YKUnLV7bzKCRGkf5EhpdeK3zIAFVvPwPz1QagT7OikxXXSy+8pvqKIu3H/xwq/2w+Pv
 867tIvG3GNmAn/XxyD3ISiP3grw2uzmTvY5vf0ctBOTp6enDqaAb3p32IYHm1Mk2vJ7gF
 1n4JukwQiplwrsFm0EvZMyog2TlEAYMieIXghNABGHSXE+tXn87w4JQGQdoe79NscUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793083807;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=RQbsFZib9ViJsdmgpUeWmSmjViiPX+6t17wufyFxaBw=;
 b=VnDsRggMeXutCLgCmu7EW2y6T5Lm0CVvYUg5COtufAJmpcQ5M0u85N6iud//rHYvRnyh
 fK9w/BN2DnKcVNkt9DVmbXjfbLRcGDanpPxES1IciaCazLlEA5rO4ab2AHrQNf6wLDTJE
 Lrv3U3T8bLlxDhgODYYyjxHg7RPM8pmeKFSZojcQZD+YZy8AgXmkR2v/I0qm0WO5vRKWA
 77nPJ4aYN3ioO2r2xWRduplMtxgwhok8pLgZewWKo+UbZzp/I9v1taHs9QRCzDoZnRV4f
 eJqo58TYWHcHkFp94mGcGNN0bMyjiJQlVEgPz6CqCqKQG8MlVpm4mbNQ36p0qxAOscw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CCzVRo5N; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CCzVRo5N
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DB2B40062
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:50:06 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so298245a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793083806; x=1793688606;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RQbsFZib9ViJsdmgpUeWmSmjViiPX+6t17wufyFxaBw=;
 b=CCzVRo5NAdMcZgrtQX1u0GR/3Wl/47HDNR841pCu6YQjzFkuSDo32MpWjiX/n+q7p9
 1m1RQTp7OwFa9h16mQF+Vd11e2sTaxaCqw2ZTQs9VD6NGgFqFVcG5xbzUVdU0qDxn651
 0D3OYpOUEmHJoFvKdaa1FhyyWrqicZeYmSddz5ALqL4MdJJtAcFIbY+hNYT+iWpeQBz+
 xKN39XoyU/Cd4ZC90PJ/Ty40TSK376eIEKinxGb1x9ZwJ5F4qMGHCOSeHVB4bZvVYmKE
 z0c9AHiYjh7n0vDq0FbQ9csxY2Ce4RPTtUCXkVrwtsqqX7E2TlPw2MwwJv8Rsfp8fuOU
 jSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793083806; x=1793688606;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RQbsFZib9ViJsdmgpUeWmSmjViiPX+6t17wufyFxaBw=;
 b=WDCWIWrTXGXhwhTbyf3dAWttKvVJWp+v7nw0GuDfPnGdbxO2dzu88Y8Md311G16Iqc
 V4OXA6qD1rhCf/wmfdPI8fnVl+4n5mVGNjBL5a9zwH3hWhdlxtpJQLcsKKjpBqytUcKA
 a+ThtuBu+VNfgHVSQ+KFgUGK9UKEcaONjXX2NOxCJZHxiBJMFYwHILwsifXrOrefh3Zu
 sbZ6HREPvB6tVLNfF43cj1fmLVZxXICYFUk13ExTGUM/EbvmMSmMCEBVmy/9yuIuIXx8
 bDRJ133SjOGoKcjCOkxNtk6rhYF/+QolOTJyhwUAkQWTIqMos75W8DCoKHBJVuLAI1pt
 1qZQ==
X-Gm-Message-State: AFq9FYJAVguT+d7SIKfOiUrPTzrxTTiDEQGbMncTJMt5l569kKjtCxgX
 63MfU8BRaOeztmZZk+IKSR/P9EaBcStABOfNnrVE8xCPIvZW2GVD6Hve
X-Gm-Gg: AYBFou3qJOeuH4zS897xiSqbvI/NV2jx0NxBnAPax2gP2MT9IaCeQoAuUWh2IMlOME2
 gzPsRDKFHYw1DhVFujps5E9+Upu+V+U8SegOY7Fc7YFx/pUEoejAS6ubVRfgjb/0qTVcaHWhG7f
 wfLF/QiJ1kLT1ImGutxNMLlDOO49PdkVTg8YB4A1FHQlFQC9gThBdP3Kw15aF26OMSzeaXSpYkt
 5wrrR8HRYdAiHe3BZQ1G6ywbNStvCul37QTAq3Zj8ueD8SK2tOo/AsbAKVu94A7x79ohH37aP24
 S0xkIn8FdaqASI4sL85s2RSZV6GY9T+v/u+GEIE66mjbptSEocnFfHizqPvKtQZchSCcx7A2BUY
 wA54zgOmaXebYvkb59HhJl2+87pvSxEmmxTKUIHlTRn+BpdO+OKigh7xbdPlgUgWoUFmiFCqk9e
 phfCLSchGfDRiXn7nHWq8RT19/mkZssiNX1hKYYAGgAgXOTK/0jSXKiq9+xqRYq7iMS2zkiZ9Hl
 tBZNKgkD1srYUW5sZbtbiTD49GK5Qqe1iSti/HbCmBXSM8I4DE5GOZ5Kyu6hW65NPRWvHEzcRnD
 sIJAthDZC9af2A==
X-Received: by 2002:a05:6a21:2c03:b0:3e1:1fb0:fc84 with SMTP id
 adf61e73a8af0-3e8eae7c930mr1135409637.45.1793083805943; 
 Mon, 26 Oct 2026 23:50:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:1f3b:75d3:73bb:cec])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ccc21274sm2254420a12.8.2026.10.26.23.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:50:05 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:50:02 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 5/8] virtio: 9p: Reset the device before releasing its
 queues
Message-ID: <auBJmtCpS64F0-8M@google.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-6-bin.meng@processmission.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015111328.1269775-6-bin.meng@processmission.com>
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

On Thu, Oct 15, 2026 at 07:13:20PM +0800, Bin Meng wrote:
> The 9P remove callback frees virtqueues while the device can still
> access them, then resets the device. Outstanding requests can therefore
> race with freeing the ring memory.
> 
> Use the common reset helper, which waits for the device to stop before
> releasing its queues.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
> 
>  drivers/virtio/virtio_9p.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
> index fb2eb0c7223..d0fb39a1de5 100644
> --- a/drivers/virtio/virtio_9p.c
> +++ b/drivers/virtio/virtio_9p.c
> @@ -102,19 +102,13 @@ static int virtio_9p_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static int virtio_9p_remove(struct udevice *dev)
> -{
> -	virtio_del_vqs(dev);
> -	return virtio_reset(dev);
> -}
> -
>  U_BOOT_DRIVER(virtio_9p) = {
>  	.name       = VIRTIO_9P_DRV_NAME,
>  	.id         = UCLASS_9P,
>  	.ops        = &virtio_9p_ops,
>  	.bind       = virtio_9p_bind,
>  	.probe      = virtio_9p_probe,
> -	.remove     = virtio_9p_remove,
> +	.remove     = virtio_reset,
>  	.priv_auto  = sizeof(struct virtio_9p_priv),
>  	.flags      = DM_FLAG_ACTIVE_DMA,
>  };
> -- 
> 2.53.0
> 
