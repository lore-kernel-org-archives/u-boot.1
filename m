Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828BEC98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 20:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30F0F81DF1;
	Wed, 23 Sep 2026 20:53:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4RqKeVw9LenO; Wed, 23 Sep 2026 20:53:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6280481E3F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790196820;
	b=p1pZ6RucYDxp6sDXYFREBWXLgULKD3udATm4LpyznD+i7OrFJtUZ15A2BJI8SmqoyhOQ
	 lEq1ngEWRpteVI4+LA6co4mYRWlG05ZcHTLQ1LDBtMUykBPe9z1pYPqTPcoSqwtPcWMG4
	 /m6vCWuJdhEXkZlCrdoOV+pc841XPLod32pWlqxOuEoLuzr7RW4GMyd46Or/9bf45HDKP
	 YZ7GDI+JcaRjrZ4vaPUTnM1ID35vRkPetk7Qh5k8uD2c6LhWWnnWYaofahfezBsy1QDJC
	 rFixm3xnMACMtMOQ6OkCqigLRDvdCC64OQJtlWYWDeWTeMk6NLORxKSpGyQ70syMaBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790196820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v6cCdjDk90AUGvrq52TRLncZSnmQEfxQHoBymCMRKBs=;
	b=gxbISa/UNJkF3zV7/AOQxDgxZXXP+wgJxlBazbrJ2YpY2I7QnZVK7BL/Ho9zXEIwj0GJ
	 Gl7tqMZtp8fFvcY5zMXR3kTtO7dN9UiU0D3+P0RMUujDmIYT6Bp/zw+MsVh2BA4pZZTle
	 73ve6X2D2iD5bMFhu62ehFir4bZ+l5c45PyZk0hZeCEbIQjuhp21xBJFKhK9SDGigL/ft
	 lcsyEoNs4q403vYsS69nrYALxh2qKt79jD8YIACrk7Q2ZdExjOoLlVo6aqddnhvaXDXr9
	 LuGxNwsYXXMZF11eI0K4sUAv2rgxDgAfsZDoJ3A9gez63a3qiQHuMJUmfVEleKCIhbQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790196820;
	bh=v6cCdjDk90AUGvrq52TRLncZSnmQEfxQHoBymCMRKBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FrezbVGQ2t9wm1J8qp6yRPhdP3lpnetCRTQ7rKJdKqlwfBT3q13v3BYGgMcMZ3G0+
	 beC7QISaPxhVsF1IXqJ+qg9uL13BgTap6HFuUiyw4yIXysQT5NEBAKfpfISG/H5GQq
	 6VpOdNrTLIOWheVQwCFjh3erbitqmp60oQCAauEtuteFJRBQhGsomcOfJP1j7q6YMg
	 3i0/JwMIsYhvWDR6WxxlRS+5Ok2wwYBskY9EuMCeWSZeIcJoR8fGxrUaPkUshnZO4O
	 WsPVMqyr2mbLt+VGEaJHJYDFN5JMAjfTCLljjZfALmkK874EtGYXczE/l24n+CFNXI
	 JYTufmN5IAhMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6280481E3F;
	Wed, 23 Sep 2026 20:53:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D3953A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 335A0410BA
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tCXBxc3ZCAe3 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 20:53:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7C87D40FC9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790196818;
 b=RjUwTRgBsd+LD9n3jl4i2XHw0yHic/hms+mDBmJ/6MHmyEaBTEvxQ3LLNDzzB3jzsUYl
 ix7+bfHItCvPTfUvOUGmbG9L8s7F5RU6PW4XLUS+3DwTuLgitCPEZ90KyNwmWXiLYMLkw
 lk7jg0VcIVskmsZJAjwW9zznltRG9FCRCxc/wDVlgdZFz2WUICGyW0y2OlRjAZnBzldex
 uDxgKAm96x/nvAhOo9a7RwFo+OUBV5q2sBz+k4rJWi5VCYl9xu8X5Bspj6mPb7ETVx9ea
 C0de5iz8wdOtp9lj6vHKm/7cSu7BAgLRb8C5BtJKA0XBTBwD70DqxG68VXi3rE7SGBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790196818;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=v6cCdjDk90AUGvrq52TRLncZSnmQEfxQHoBymCMRKBs=;
 b=Q1gjen1rHLlh8FLRRNEi+4vaV/rohiB1Nw7xZ//k+VCyegcI1k8tIjkJ75OKntXIi1mw
 rucKWqcyBTJD2/7Ta3maxV9ScWVUMs/qInOzk3vXPsAnrx4a2o/uZDv/FzuoG0QIpK3fk
 /DK4hxVzUlBogPOSKSNm53/gqYoxIlIc9Z0EFzKf7f2VBhtOy9TpXRWSVhu7EygzrsXo5
 Px9cPAwDoVoy6ol/9hAfmM39MZQucYkZNDpTFUQT2PfuqrqlEo6zLXvITvz1mPhtNUq7W
 S/nAikGaVP0zrybukC3UPuBd5ru+RqNoPblg3G/MF67OFhpPmQYiLhgJEkkffJuHEmg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=V7VZ9ePM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::e;
 helo=mail-pz2-x0e.google.com; envelope-from=visitorckw@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=V7VZ9ePM
Received: from mail-pz2-x0e.google.com (mail-pz2-x0e.google.com
 [IPv6:2607:f8b0:4864:3b::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C87D40FC9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 20:53:38 +0000 (UTC)
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc0so492634a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790196817; x=1790801617;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v6cCdjDk90AUGvrq52TRLncZSnmQEfxQHoBymCMRKBs=;
 b=V7VZ9ePMPtZ+ftuo0nkCnFU+Ev/2upguWovsW5DwemhShEdWST6737exQ7DPA1RgBu
 60601vy99FUVb/QPhEfopK47cNdqydDbULicLks5egrqWggBY6WPHF8AwbZXX6MpJAUV
 m+eLy5M8T9ONRugD1e9iZapGtm/CiUEdlxG/sPlLRgxPhzTBhuFhDU85TefKxzgXD7jW
 wSDVvrcxWzplB/NxtDetKFNd/ty2mU6jooVcuu80TjnxYhSz1BcSOqlKWLdvw6aqR1B6
 Z+Qs4tgpz46J+yt8IAmnZKG0dSc78RdyfC/D/5rABvOiMgrNhKVb79ukP8h1h2h0qONH
 94kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196817; x=1790801617;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v6cCdjDk90AUGvrq52TRLncZSnmQEfxQHoBymCMRKBs=;
 b=afkGMldK8Nqrm0VlzKUJkpimInLTChQS2ATptM2q6111OMfrNobI5rrRt/B5SLel4h
 k7gfN1oNiHDtjrtooXswJkodZIoo3qhrMtRHpNs/c6yp4w/fduhLy6bfeJpxNkPJSNtj
 nhNssdeD/o6UK+GpcsTTE5oiMoQGbWs9tTF/84EI2d43VHZUQ9QYOwWJJQHYFj9Pp5SF
 trqnZgrPwopHXFoBs8yBMVz0+etGh4NOKLXkqlwXiQsP86O0yGPSqKAz84WAlNRHPfZe
 ebY+wszXMXd8GKz6kzw8fTMw0lhOmS1qhkDBT53tba81zwRnLXKQQmKTADxHNMt1Cj/a
 kAjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVqwkx4xdlQRbRLtcb+sLVZK9eRhZD0Bq2ZRm344NF61i2JDq88xklB70us4YhKezy/8sNvQA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lJ4Ky+wR+wm9HGEVyo/kYfSanH3vWOJ0Y7McHNq6edeYl6pMZt
 cVp5BRc2Fw8S13ZsU18Ej/0C9R+uvxFlrIsSp7QYOwpuD2MigEFs49yg
X-Gm-Gg: AYBFou23d5LBk2/rsdmj2vtC6YRpFdK+489i2QKTnJQ3U94xPnNutczydR5QAbJfan2
 HVUcJgSB21VHSmKcJ95t4RSCTe/ufI7JLuUUvczwJ6JCK6Bt3RJ3Hd5oeipsnIFsy68Znn4WkoP
 a32KV50XZHjmq1pLV5mzBbYpNKfnTSNHhZPCDlkmbRxjLAvSwfOblEzDAjW5624OI/mBXsudTb4
 g6rjKzVcMaHj+9y+SUuG0FosnT/PYRmrWsDy7JXZfylriKfajGOelMj4IP78+utoddypWSLhdsw
 kbhnwUIFvpr7LM5eaprVCrfGTlK8AvecPCZqND1Mui12q/FcZqWiKdu+OzB6fcoXsqgJf99jEVy
 z5n3WQM/odo9MSN9CqjwHmta9WucEnWIWuc33PFfx7JMQ20tHEoVB1M3O4F6eksn+iKIp/3JaHw
 iDNQePpkNzpgmzjcV/pRFwsWQ9VaFKs3f221j5nroZL1zoWr8KY+DeWH8YJcAZLo14d8VFshjM
X-Received: by 2002:a17:90b:39af:b0:39e:6a7e:ee1d with SMTP id
 98e67ed59e1d1-3a098da1075mr260506a91.41.1790196817386; 
 Wed, 23 Sep 2026 13:53:37 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f3ba829sm1629814a12.11.2026.09.23.13.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:53:36 -0700 (PDT)
Date: Thu, 24 Sep 2026 04:53:33 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 3/6] virtio: 9p: Add 9P transport driver
Message-ID: <arQ8TZcziIi7vjpe@google.com>
References: <20260829192119.2658328-1-visitorckw@gmail.com>
 <20260829192119.2658328-4-visitorckw@gmail.com>
 <CAFLszTh6STRL=4sE1eYAuTKQEymKK1xXmJwxA0u7p1BPGU9pmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTh6STRL=4sE1eYAuTKQEymKK1xXmJwxA0u7p1BPGU9pmg@mail.gmail.com>
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

Hi Simon,

On Fri, Sep 11, 2026 at 05:43:39AM -0600, Simon Glass wrote:
> Hi Kuan-Wei,
> 
> On 2026-08-29T19:21:13, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > virtio: 9p: Add 9P transport driver
> >
> > Add virtio transport driver for the 9P filesystem.
> >
> > This driver binds to the virtio-9p device exposed by the hypervisor and
> > registers as a DM UCLASS_9P device. It implements the transmit and
> > receive routines.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> >
> > drivers/virtio/Kconfig         |   7 +++
> >  drivers/virtio/Makefile        |   1 +
> >  drivers/virtio/virtio-uclass.c |   1 +
> >  drivers/virtio/virtio_9p.c     | 119 +++++++++++++++++++++++++++++++++++++++++
> >  include/virtio.h               |  12 ++++-
> >  5 files changed, 139 insertions(+), 1 deletion(-)
> 
> > diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
> > @@ -0,0 +1,119 @@
> > +static int virtio_9p_remove(struct udevice *dev)
> > +{
> > +     return virtio_reset(dev);
> > +}
> > +
> > +U_BOOT_DRIVER(virtio_9p) = {
> > +     .name       = VIRTIO_9P_DRV_NAME,
> > +     .id         = UCLASS_9P,
> > +     .ops        = &virtio_9p_ops,
> > +     .bind       = virtio_9p_bind,
> > +     .probe      = virtio_9p_probe,
> > +     .remove     = virtio_9p_remove,
> 
> Sorry, I gave you the wrong function name last time. Other virtio
> drivers set .remove = virtio_remove, which calls virtio_del_vqs()
> before virtio_reset(). Going straight to virtio_reset() here leaks the
> vq allocated in probe(). Please drop the wrapper and use virtio_remove
> directly.

I checked the tree and it seems virtio_remove() does not exist in
U-Boot. Existing drivers like virtio_blk, virtio_net, and virtio_rng
all set .remove = virtio_reset directly. To avoid leaking the vq on
removal, I will keep virtio_9p_remove() and call virtio_del_vqs(dev)
before virtio_reset(dev) in v3.

> 
> > diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
> > @@ -0,0 +1,119 @@
> > +     start = get_timer(0);
> > +     while (!virtqueue_get_buf(priv->vq, &len)) {
> > +             if (get_timer(start) > VIRTIO_9P_TIMEOUT_MS)
> > +                     return -ETIMEDOUT;
> > +     }
> > +
> > +     if (len < (int)sizeof(struct p9_header))
> > +             return -EIO;
> > +
> > +     return 0;
> > +}
> 
> Looks good, It might be worth returning len to the caller so the
> client can cross-check it against the size field in the reply header,
> but up to you.
> 
Ack. Will do in v3.

Regards,
Kuan-Wei
