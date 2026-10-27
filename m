Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE2606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K9aAI9sO;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RBiewmR2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7E9180C53;
	Tue, 27 Oct 2026 07:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNTeFK81_uN4; Tue, 27 Oct 2026 07:02:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 10FF380C12
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793084550;
	b=KpDNFZeoyRfoICobDZFFO9BVznkNhOrlXawcNUTBu9v+9/G8miEN2MwjdgFKnWvajcGL
	 LKp1EPGEjrb/qhOowHuHWNpa6ZCxV0fwSO5MXsU7kIikvydfO/EU6WFtq/LxGMFoBmVZF
	 4uGHggBrQQtlM0ufirb0o4elEmj7PPhPNg5ZyUQb2e8HrgIjFJOjVmtWxFGpCtMNWCqlS
	 QlAv6DRUWATlwBZdpRSZnfWR7Mh34AWihDiNtCE+gM/lgh5j367DasgR7ltp942z4Sz1O
	 RExfiSd1gDm3C1sPgpYRZXR498QR6S7lwMvjMByrfzcvro0MsH0jmFkA8XdCuAlG8FA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793084550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YLDfkEzZbNLvpPZlfLPOJVQlvNKiIWni62GN3UNhew4=;
	b=aVmcdROSKBSs1G9Ct2T/Jv40OrWA6abbFqtKw94r3y8k/GKIYYnmy0+JABxszWAlhO8L
	 hsKeVn7jM4NPw65Xr75vJ6IHOS58uwzbp3HFOM0YUfQN5Nr5/BE3tiS+gaZ0MouTKE/mZ
	 GIucL98IaNtOkQIHMW49WVO+75lKn8SxhgVukrK92CQhTGhxr51xb4BR/CQe3iWCTnqwf
	 Nww7fLRujOyWBm/kJegyYN8yR2i6c6zBELGymc4nrD47Poyn2sDabzHGES9Jz9dcpAk5F
	 nPNokI7jrM49Hj8RBSm445t6gdPbhzh8apGOJeihoclJZd50ydxADOiexWs8JE9Xpgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RBiewmR2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793084550;
	bh=YLDfkEzZbNLvpPZlfLPOJVQlvNKiIWni62GN3UNhew4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K9aAI9sOXkf81F1M57w7EdPiiIn+7YA+l8AZde30hStJpNmdGxMeENz9AsGiz0p3f
	 Gyma5IL67DTpFivQpqgxhVLbBSQWvSKWTKj4qliVqTzpf0aF2dM6/CRxj5ptpsofUx
	 QgiQPlLoQDbON53GgR868CYng91ZyMf7PeoRePev7UBmlYCdeK6dYCk1a1qL4u39ef
	 HdjEhfeFmOFdBho6AiBQ+lEYEf68bS90CZYXQOulIXTyVdKuzjlc9OdIYic16DJVC0
	 v5+1eE5k4U5j2C6ezIC0TixMEnOHSv/kgEkP6cSdFUKoOPsis+znP9TjxvqwOu50RS
	 RMsLt8eqen1jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10FF380C12;
	Tue, 27 Oct 2026 07:02:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E5DE7120
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7F1580C79
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fkltYt8zvRur for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 07:02:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2549180C4E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793084548;
 b=Rp0VQSECAnh4TBKiO1xvB2K9g0ZPmDE7PL2O8ue240o0SgnOVh9j+Zff9daSyzc8/eYT
 e+3sIcaoGzoUuQxmRlXowHb7G8wsk99RKtQZyYfv8Nrw35I0eIrrHDkKqRlgY+h5Y/tSz
 tLH1HeQa4flW6oXDU8bqYTjyUn+8/a20PfXd2VzZvEQOSX1hz/NKDKynsYJhdeRiM46lu
 8V93NJIqTeIXuX6C8kdotIGQ5vZP6FVMDvugYiu0PaiVB5IhJqJ186o1CRfJokxeQZwn8
 JlYkT23vAtaCw8wnW1dJlE7OFssEIURMbCGeR81LMd0zmvJ2vgfeDE2fVLoCoQiF+ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793084548;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=YLDfkEzZbNLvpPZlfLPOJVQlvNKiIWni62GN3UNhew4=;
 b=HFHSLSHXC9H++RWQadENN5223cspjJzRwy5KysyekADGUu5ayzUJU0DfzkOrInM9et29
 Jf9VF9h42l76sfgR1qmt9Z0HtXB50qRs35BBZeohZZpptANGBjetgt17LYPWoPponhYwT
 luB/uHgjiDiwijWElGroqXgHA1yc1QD2i8c83NwwYsyXPUfkdnm4hy38ip0DpJqZk4+DV
 vXzRa4j2clY7HdQylA3bxRHCuMVVB7tEQGNAK5Q6lHYQLMyVDMsMmjE3u0WGZBYBYWeA0
 c/1OVtup92lOcLtCj+zAfca8WKQvhT7VpnVZkoE3o5z1aZxEkTgVcOPACYEdf4gW0mw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RBiewmR2; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RBiewmR2
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2549180C4E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:02:27 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cd6acc50b8dso1378829a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793084547; x=1793689347;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YLDfkEzZbNLvpPZlfLPOJVQlvNKiIWni62GN3UNhew4=;
 b=RBiewmR23WSH/4TpQiXHsHQ9sH7fiYfEwe8eRkC9+l4r19TjQ6rZXgXw40VbANsOnm
 8+MPOZvGaDGvgFntWl3KcysP7tF9o/EoUnw5vlBl0QjTpCXbw2iEEv7Km2LJrlgqxkmZ
 2JsKesYQkZ4H0CIgFr7cZUDBOJKuQzpDOQRRp7ZfgcArUNh8upak5ci6ZjEOcAvP1EIY
 Q0DKiOGiDL9Omzp/yB6aYCqbJlhmO88/rH7XZygjlaZXWBTVO5fzc24m/YHYlvxTKgqP
 aYP/JHEAITaV00yPO7Pab/DK0eXf4DwWysw6OdGIj8xIUuyr9PM0xARahXW5JRaG5ewG
 hzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793084547; x=1793689347;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YLDfkEzZbNLvpPZlfLPOJVQlvNKiIWni62GN3UNhew4=;
 b=HasTiHkk8own1FjaN0o0JBDvyXxisws7MQga9GaacIYpQgSA717wEm7W+qRIkMfeKg
 +V35WCbNK/QFuBkm+AnW7C+EjdOQvFDw34PKCTCDix9U5yF8iaiXBvCdf2wtHxYUyxyh
 d/9ZiIhtMjkqwgp012+sMlAtw1/t8Od64wj+ApKJsCsh2pRPnXO0Oh6erh1PIGqWVeyp
 DCILeW92jnx5TQDaAeNcD0lxhx7vELoLVhzFU3SVz8KILfMrTlARE8GAdiXmsBqhME/v
 gIdUtImJREGpc3odioKUQCH6q6jJx0bK/bdqTcZcqlJFTEjHYVeY4gZLnR9kO6eCoLdd
 TyeQ==
X-Gm-Message-State: AFq9FYLBL3K8W3uHLtjW7qWlfJznObsbsZUBN7T8v40SmgdYYASR46E0
 1QH94SpT9UhSvDbMpalixgr6ablEUtzRZpfwF9As4NUXUu9GqjYQyhJ8
X-Gm-Gg: AYBFou1YrkFsx+fiWzg5dLzlfF7n0NH3OicgvmfOWTm0sfIRtEPcC1c/99p4JEm4a6J
 1VtZf9nRc8JGI2qMtj3LpZxD1/Z8b13vaToURuXUPBx0hwocPClx4SGJ8G4gU97/jX4jwa2l9Bm
 ryUH1lUIAvwp0AYeRvhB/egbvYjDA+nb9RSQdvtRDH6BkPJV45vBYJKhZtRdP2emFu3FA+KmBKC
 DwsSmXT3J5v8xeMkN68JjP7LpsREc+vQls5F74ifvP0TbWiJg0/FIJVrw4wY8Mf2HggfWx/hPKZ
 /7rtUB7KAhmBlGb3E4pR+g/BUgXg8+NeJlYBPcQPvcbtLYf+sP/5gJqhv1MN2BsNcNZ+4b1oh/c
 OFvpt1hVfWeoEi0Sp0+XHc+CqeJynGUeN9okjydRW/+2suekzAuD3fK2bk+2faBJhwFfmeIrVgY
 QrdKRpwcPnNLDMluUQ/9E0lN0miuSHTfSsaEpS0ic1KCkrCEMG/rKrFcmRE/x8B0MfxYeigTfVd
 OnicwSPff510p572zv54kner2tQ46ETokDm/LMRuT2QPO1xUYWAOexfrE4v5t6NJ9NDsm3ciXN8
 g+M2Q/DRbvQDrA==
X-Received: by 2002:a05:6300:808b:b0:3de:b120:bb8f with SMTP id
 adf61e73a8af0-3e7bfbe4811mr5013433637.50.1793084546992; 
 Tue, 27 Oct 2026 00:02:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:1f3b:75d3:73bb:cec])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ccc45a19sm2364243a12.12.2026.10.27.00.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 00:02:26 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:02:23 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 3/8] virtio: pci: Fix modern private data lookup when
 deleting queues
Message-ID: <auBMf_GCgef_a_vF@google.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-4-bin.meng@processmission.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015111328.1269775-4-bin.meng@processmission.com>
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

On Thu, Oct 15, 2026 at 07:13:18PM +0800, Bin Meng wrote:
> The virtqueue's vdev points to the functional device, while the PCI I/O
> register mapping belongs to its parent transport. The current lookup
> therefore treats the functional driver's private data as transport data
> and uses a queue pointer as the register base.
> 
> Queue deletion can overwrite the queue's list links and crash when
> unlinking it. Fetch the parent transport's private data instead.
> 
> Fixes: 550435edf810 ("virtio: pci: Support non-legacy PCI transport device")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
> 
>  drivers/virtio/virtio_pci_modern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 5850e0c18c6..d309f9a9dc1 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -305,7 +305,7 @@ error_available:
>  
>  static void virtio_pci_del_vq(struct virtqueue *vq)
>  {
> -	struct virtio_pci_priv *priv = dev_get_priv(vq->vdev);
> +	struct virtio_pci_priv *priv = dev_get_priv(vq->vdev->parent);
>  	unsigned int index = vq->index;
>  
>  	iowrite16(index, &priv->common->queue_select);
> -- 
> 2.53.0
> 
> 
