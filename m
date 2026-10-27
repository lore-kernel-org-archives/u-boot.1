Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309AF606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JQ7eWMnJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EvR0xEnl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1638F4040B;
	Tue, 27 Oct 2026 06:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ikfp9M_p7y1; Tue, 27 Oct 2026 06:49:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 687AC4041A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793083741;
	b=S/EwJXCsnJIUgRUze7LbAMSum7wGZnJLCvd/1XKAglBwHFNsfU1xImBYvWGbBlW13GBG
	 6Yin6iYTjRBh2yZc9tU2/vMyIFbcmnN7DScUEyRn+mnL89mbcv8bhkG+zz+brFoJ3USKR
	 Xr+VBrZX6161ebY/eKD/lG7oYxor/TCsAmAz6ViTNFTHOxbP6O4ZZakJENoLVmeFSinHG
	 CntRcCD8Cw1HjDLytg7lS3ezteyUqQFb89ghmEJByr0hB7II1u8/m8CV2yBIZ1d/KZTEO
	 EmLzqLpZC0GHSyWgcmZQeVqByDHvEGWT8Hg5g6kDwz0TTqPKsSzbR5vh8y+UdxM9u2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793083741;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fTStH/jZnA7Of4Yvl0GW9mGJOPH0LEOIUUE3obguYvs=;
	b=sEp5udJ5PKfxUVblXIcjP4Nl7SYqLcpkgy8c8ien8HQLchNh0LUEnf0O/EHuO+b6ebRN
	 F0ycPA9hhPE2ShCrpzzLaOjo6InylMnJFbhi9f5J+Yiiky6/6rFetJkt0jXnP/+AEnUEB
	 jX4Idws7lFbXf4dCcNPiqarmuM+hW6/W2CqcM2BG46YVM6LLjXWsrsXmqB7Kqy111rytH
	 aG3j5NWyQGR0hBz1odPc1P1CraO8/+dhKSWVUoEDAtvLkPMDj3l8oeyLUCyEVYDuGGHf4
	 IpZWQywokcApUhaEAmt16TKW533f5bmbAabt5WrpQZAgswAY6cAL/E7yMh9Ru0rMsFw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793083741;
	bh=fTStH/jZnA7Of4Yvl0GW9mGJOPH0LEOIUUE3obguYvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JQ7eWMnJEkpWZba56hav7o659+HCcyaMpM7lLr+Ievj/3JQHbeIRO/0sxiRJgt9oO
	 uOpPGU9YUqMMtkfkL5OlNy9PDqbba8jsPiVPTB2fGtoqPlZ0GgjqSYF+C1TmN5r7fm
	 tpiNNiozE6Sba5iG2vOb8oJA4K3ELXa7ryo19Cy6OC9gW89bKkgce32AM4r5L5y8hr
	 PWVkWUKaHygS8ZEaCHUIsKH6vXdslZCl0ydbBCKa9fLg8BOLe5MDUl+13UnhpmwVU8
	 Mb7mNgEWiAaxyt3jqhYwGJICU6v+YvPJjFGdL11t6erGPpZ6gJz9mAQEcPfrFlXeNj
	 +Hh5+2KxNCWwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 687AC4041A;
	Tue, 27 Oct 2026 06:49:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DFD6279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FA2A80A98
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:48:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8xPhQ3knSJz for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 06:48:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E6B8980A95
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793083739;
 b=sdUALMRMX8UCeqImEUMDpTpJl7EvYE4c7eMbF03EhowkXfKyGoESb+B24eK/2i3oA01D
 fVIBHqS4Hg9Z1uY1omFaWd41yzO13/MYFCS6gZsoy/0hE1PR1GcTD1GM4wJABznv0gkFE
 4YX+muf+l1EBz1B+n6KvtUgjGVxkH9mszb/guZ+OYvdMdLb8r3Ac8Osyex9bxLx9P7qbg
 Nqw1hEokiqY+plWuI2DBMGVFukQSlUHNMflomI9VLin/n7hz4oHAEWsVDCuNmmIM/Fp1Y
 u9TaMV5jlOK8rzfzYSo6eUdsUqFOHxDbA+2Ey9EqAJ2bTT8//dG3Aui9eyqUlH6fdSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793083739;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=fTStH/jZnA7Of4Yvl0GW9mGJOPH0LEOIUUE3obguYvs=;
 b=DMV9NeZlCDwcqYdx8nIRrgRdari68V6DWkg0Ps3z6H8ail5IjSVc7HNQOzwzMa33cX8O
 3Q4CVBKesO237/9+ipIc5NsggNCq8D1Af2NhNqZGOGWuF3r63r4WBnbgZurP1U14t2LSD
 qltd8ckj56DllfVu7vHlPeNUhfF0AMRZe59iwKhFg3Z0cC+XLp8RTnv/gYCMqhRS+WDXD
 v4lUn25vflSiQwwMQElORK7F9CAy6nN0rlfK98UkL8zCz83A7DDLQ4U74VuyVlhL0wBnP
 GLd/fT0fTsfd5Lyjh7pzNsRM7QPUqn40vWHV3TXf/W0M1U8xU8PrSS0GT1YCGZn9Y7Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EvR0xEnl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EvR0xEnl
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6B8980A95
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:48:58 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8a058f74a54so1422898b3a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793083738; x=1793688538;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fTStH/jZnA7Of4Yvl0GW9mGJOPH0LEOIUUE3obguYvs=;
 b=EvR0xEnlwazApZXWBSHBpPscUEi+AT2J39DkCP9Q4YSCtJmBZyQqxcdZUjtHYpGXJt
 52iJ/EWIWnzg7o36qfg4Y6jmL8S4t2UM5wrAtPjkqQjfocCVNS11OJpc/quziJjrBJu+
 o9dDn1vBPnJHKEPPw03fJgM+PA9ZAhpid7Tw1TBxaHEVgBun2WagRyNBnXilMz8Olcvq
 6KJAEDfmG1Ur5jGaRspt1T+62xOmuY+aUDTkL6044tqcLM/rHcjS9oEejb99Pi55zNQO
 4X+cAULzD29C6xz4AhjQIBuD3JmodgEqsKITCrjfFZTN539Aw7Qvhz1hN7HstcsdwHhr
 b61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793083738; x=1793688538;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fTStH/jZnA7Of4Yvl0GW9mGJOPH0LEOIUUE3obguYvs=;
 b=Sv8AHezfsAM7syf7Adof/DHZg4pw6OD7Wbak4eWE9oZ/SHG+nu5UBFoze8FeW9thsn
 wLs+R6w75V+CAgnsET+rC57DstH38LupRhREoDeY3Xd95VLzlL+rbbqN1VeI4AEqYG1l
 3NywWkKqtZirL/KFH9EEI/FHib6pLKTX2ldQ+kUiKfliYcCE2hhT8Y8FID/xcm+ynqLw
 AtpKgpXOgI6tyu6BoWYtYWKDcAjBYMg4vdW833/oIv9dhdodi0AuSjuAamf6TT+g2pnu
 6z2I7sG+HxN9LzUj2VYE7kQXvM8GKHnE8H5aQsW3VJwP3MHmiAYlZnpnZGP0mpHzDoFD
 /GXg==
X-Gm-Message-State: AFq9FYILxn2tNhIlBLeMINGzQf9R06odJQH4ARYwtleNeI9jCr6rPRA+
 lX0CGKW/Z8WA6nVqhaWPJkUKm9M9/E31y/iyLvmzDKbcg7GuCuHuiqoG
X-Gm-Gg: AYBFou2dGM8FkUhh/oV7U9yJCSLnSjurXpwmTQRzK8IJ2zbD0FcX6DydsQoKdOBATS0
 ZsJvrKBch7+DDtOaNWGjddejP4v+iM+ZOvISJL7Ib8qg0lSQk51wRqygPdQ+2/LEhXEfG3/Pbns
 YAd9M75vNHQmVJhrA/uLsJAr/bHW6cZOR0Sds5IZrErA4ylOt6iz1FRsNEwTdHayBfJ3eWXocMn
 2MH+UfK+SgAgOMgDiDn4G1D50lqBiTetB3VMtglWFhDH3vHlWNHOX45j5K6hvkn5NMCGVKv27BR
 Fj3uzA6WygwmhDlT7Jyi3YyaSGHz4PXqzQOr4oR42mhN0aN6n2rGgMCbVIHBmloroXIFv8lMk6S
 qwQhpfp7kvGVQB67/MW3hpwamQwvpx51DI9sys38mWrYu4dL10lO+Hdg9UAP2+HJVDAMXw2wrnH
 Lg24aW1kTqSbuhb3Wle19iTyPD7NccLcJeJ4u8uOg0kDC6Bav2FM695WLY4d0lEtAPCZhrLyzVL
 XqjP1NcvwiuS8XegRhNQWrtvdqrYpnIN5cazFwHnyTCGPG/mUbye9WWQjkKcPYDbTzBAj9Ee8r+
 Gg+RoLFY8LSwUQ==
X-Received: by 2002:a05:6a20:94ce:b0:3e2:3222:2559 with SMTP id
 adf61e73a8af0-3e7cd56328cmr6848014637.62.1793083737831; 
 Mon, 26 Oct 2026 23:48:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:1f3b:75d3:73bb:cec])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a368d85e22sm2008064b3a.8.2026.10.26.23.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:48:57 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:48:53 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, Daniel Palmer <daniel@thingy.jp>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/8] virtio: mmio: Fix private data lookup when deleting
 queues
Message-ID: <auBJVWpt4ARpNhPa@google.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-2-bin.meng@processmission.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015111328.1269775-2-bin.meng@processmission.com>
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

On Thu, Oct 15, 2026 at 07:13:16PM +0800, Bin Meng wrote:
> The virtqueue's vdev points to the functional device, while the MMIO
> register base and version are stored in its parent transport device.
> Using the child's private data can make queue deletion write to queue
> memory instead of MMIO registers.
> 
> Get the parent device's private data in virtio_mmio_del_vq().
> 
> Fixes: fdc4aca89ecb ("virtio: Add virtio over mmio transport driver")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
> 
>  drivers/virtio/virtio_mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 975f98cd9e5..4b478639fb7 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -279,7 +279,7 @@ error_available:
>  
>  static void virtio_mmio_del_vq(struct virtqueue *vq)
>  {
> -	struct virtio_mmio_priv *priv = dev_get_priv(vq->vdev);
> +	struct virtio_mmio_priv *priv = dev_get_priv(vq->vdev->parent);
>  	unsigned int index = vq->index;
>  
>  	/* Select and deactivate the queue */
> -- 
> 2.53.0
> 
