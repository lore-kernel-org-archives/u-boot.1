Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80942C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BF37409AA;
	Tue, 28 Jul 2026 11:17:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LvyLk0orUxxZ; Tue, 28 Jul 2026 11:17:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2361440975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785237448;
	bh=tjc8xoCnWkBdvz7WMC6QZOnjBjf+p4hWu3mpq67Z/lU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nlBGGJ95iy7QfUXBFSrdb6rYBxSzxD37XXj0/rtAxsvOge/xKE1H8mDKm8sDJH0Qo
	 oyIJUhBUPXbxZ7/z/7l3Vsh+38+8KGMIXRnxhbWMZxx2hdmk7vJphoJK8Pe4kYg1Ma
	 4aMErwqa0qqhxB39zqkXRWzPeaeHEK74jep6XOVkEV4+z9k3zo4XWNKmj9A79jsRGS
	 bLh3kt+xJz2nNXi/+pBdIGM/kGIy5r6vXF4MFl70g94S2EjDbrXlpN0h8NXXTj6Wus
	 OE0eqcbWksMnJx2lR9k319PwnaUrawESOQ8F4E2Kwc0IlqQOpv3daSH+hMvpdgiW1E
	 fdN1qZPieC9qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2361440975;
	Tue, 28 Jul 2026 11:17:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CA6826C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F8508128A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LPDry3sCOWdr for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:17:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 188B981292
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 188B981292
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 188B981292
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:24 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09DE28494B; Tue, 28 Jul 2026 13:17:23 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060CD848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:17:21 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso5314392a12.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237440; cv=none;
 d=google.com; s=arc-20260327;
 b=kZkkycRpQb6MWe20Td20eka0r9dZPQaMSa0UJ9VriHGtPIryAZj0UZNUy0aA8jANqm
 d4qcGhBU89b0BE2VzIq3TRVAUVNCFVKNLXsDqZoRtz4AEg7Yv8/7TMttzJis3/W7y12V
 PXU85bCTl6fSUzBHPWsLKdil4anqR+SOVzf7+32rcvukPbuKyBaXgzn4md6dPgI9TcIc
 WBrLV3eDw9mfIIQSgWhrWUp5TC2db8D4VFevLL5NujUqfRDkf4fiMEjJuVhh/JyQvPLp
 nBIcrvTZjlmDxXAmgsJQpAtYnV4Xhxaayaq9mbyDJvhNg7Z9bGce9//QSTilCNDmJ0ny
 DmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tjc8xoCnWkBdvz7WMC6QZOnjBjf+p4hWu3mpq67Z/lU=;
 fh=runy5GsEaBbwYs4tLCkIDKGakFI3WhxP+HVdMM9V8MU=;
 b=LWtho4UPPY6no3VaiaVSyIV8/c6f0QQgsO6Mfd2ro6d+x/pPrrqdld+SDY/y2U8sL6
 sQRnT5zPx2jM8mpC7XaujWCfEuSU6j7u5qO/4Ak8ggndu03HuQvXVRxnRbYtxb4zVAB2
 OJPEM2D1letuhbu9Lzz9rMzRE8xKdiIpMuyFeVgXuFCiJLPRIWYSPycjuhURAzcD/s6v
 SmTJUGuOsr9lW0HvAC6Uv1Dh8urgk8po1MlBW1Z6NPFcuM3JozGdAw44RDC/I2lLE77r
 OX2qQwowPcHzyD0QyavLXzJJg2Uh5hIE/xQ97y29Gqu4Cd5YedUUFHS+MEyLgkBY08GG
 5iIA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237440; x=1785842240;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tjc8xoCnWkBdvz7WMC6QZOnjBjf+p4hWu3mpq67Z/lU=;
 b=Yd+PNKeGmJUGOpKxlqU2ARpl/DDaElPGMT4JsVR5EhbKfMU1LSOipWxa0Iw+khe9gD
 C2jEuZCY36//lAc3oFoWLKDJvg+JceuFl/GcWVu2vY2DeyW6JrCXLbxcBZFyspcU6NIE
 tyHIBqvgKZSlAcc4Q9DAL8+XRO6Gs0Wn1kQRYXQkX5t9/5JrlUrNJ1e+EF9t3hbsTTxs
 EsT4DeRQyt86Nk6n2L0niMaqAToag6f0rs+5m3splEuxxx8fnakrA+W6HKCCwRHekhpj
 Jd959r3WQecrrKFUgFhJQaRc/XvdqSOc9aLMz/7WVxpN/jyUuiETxEovh7uFh8TYv+wJ
 eb6w==
X-Gm-Message-State: AOJu0Yzk2fenEW8E38uB9LN/w+IObirxOnha18N6UnTy6P6YpTXRY8CA
 s81qC9R5MZz6iKT4Z78tIK9UyY+n+/cwnTDN9K1bkqgOKHJ08biALyJdTgibfzuMI3OpKKwg5i6
 +lAagGgY7E1PqBdzm5QBvpbhyFbk+QP5Hd1FnIv4g
X-Gm-Gg: AR+sD10B2Qf0LWG2F/NJDyIa7k8F+bwf8RhQ71LkqQOSS6MxoNtN84LGxHpNoca96l8
 C17dZJ8rLWgADDZ08/Eo0pwLLzqd7o8EnwKnQsv8cULdiaJS9qq3tH65vujoJr8tMTCi9lYnh2P
 hbKkRhMGnN8wEc19RlW9EDP8EkFPPH5So2/OUx5RfExqVzFLjDNa3aA9KV+YJVo0y9ZAf2ovTwk
 oayYniHZG+Mmrvb2xTOogL6TOqx7dE9UXHXDaLJkfULSALB3o0lBpI+eovP
X-Received: by 2002:a05:6402:1474:b0:69f:4c65:86c2 with SMTP id
 4fb4d7f45d1cf-6a0349bc969mr1061241a12.2.1785237440305; Tue, 28 Jul 2026
 04:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260716223401.378989-1-dmukhin@ford.com>
 <20260716223401.378989-3-dmukhin@ford.com>
In-Reply-To: <20260716223401.378989-3-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:17:07 -0600
X-Gm-Features: AUfX_mxXe_ItkvTipcbR1G8IlT-DcW9RZQMWhqmpBY9L7DM05L9gv8TgBzRgu0M
Message-ID: <CAFLszTitjYpDnghN+Z8nrxiyKLYHyEp=VYa_NKKQQFcYV0eVhA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] drivers: block: Introduce blk_flush()/blk_dflush()
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, seanga2@gmail.com, 
 sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237440; x=1785842240; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tjc8xoCnWkBdvz7WMC6QZOnjBjf+p4hWu3mpq67Z/lU=;
 b=abe07pkmTINdUUWxuV2Fy/xkub6WpJ7Iwn4Vyw4rEss9nxfrFpavD3caiKm8JddEyy
 f+8agLW1g12dt4ibz8Jyt+T2DQ3iVnGJ/sXro9tFgBwVxETCPR4lmhHXXCU7SqJlBqA+
 YtOahhuEUszmaBnxtSR7ELhfFz1Y86DB8osUg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=abe07pkm
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="abe07pkm";
 dkim-atps=neutral
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

Hi Denis,

On 2026-07-16T22:33:54, None <dmukhin@ford.com> wrote:
> drivers: block: Introduce blk_flush()/blk_dflush()
>
> Add generic flush operations for committing dirty data to the storage
> device.
>
> This provides a common block-layer interface for flushing pending
> writes, allowing callers to ensure that data buffered by the block
> device or its backing implementation is written out to the underlying
> storage.
>
> Note, flushing a partition device via disk_blk_flush() flushes the entire
> underlying device, so callers don't expect partition-scoped semantics.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> disk/disk-uclass.c         |  6 ++++++
>  drivers/block/blk-uclass.c | 15 +++++++++++++++
>  include/blk.h              | 26 ++++++++++++++++++++++++++
>  include/part.h             |  8 ++++++++
>  4 files changed, 55 insertions(+)

> Note, flushing a partition device via disk_blk_flush() flushes the entire
> underlying device, so callers don't expect partition-scoped semantics.

I suspect you mean 'so callers should not expect partition-scoped
semantics' - please can you reword this?

> diff --git a/include/blk.h b/include/blk.h
> @@ -239,6 +240,14 @@ struct blk_ops {
> +     /**
> +      * flush() - commit all dirty data to storage
> +      *
> +      * @dev:        Device to flush
> +      * @return 0 if OK, -ve on error
> +      */
> +     unsigned long (*flush)(struct udevice *dev);

The read/write/erase ops use ulong because they return a block count,
but flush() only ever returns 0 or an error, so please can you make it
(and blk_flush(), blk_dflush() and disk_blk_flush()) return int? That
matches select_hwpart() just below, and avoids errors from drivers
(e.g. nvme_blk_flush() in patch 3) being silently converted to large
positive values at each layer.

> diff --git a/disk/disk-uclass.c b/disk/disk-uclass.c
> @@ -122,6 +122,11 @@ unsigned long disk_blk_erase(struct udevice *dev, lbaint_t start,
> +unsigned long disk_blk_flush(struct udevice *dev)
> +{
> +     return blk_flush(dev_get_parent(dev));
> +}

The other functions in this file (disk_blk_read() etc.) have a
function comment. Please can you add one here, mentioning that this
flushes the whole underlying device, not just the partition? That is
worth stating at the implementation, not just in the commit message.

> diff --git a/include/part.h b/include/part.h
> @@ -454,6 +454,14 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
> + * Return:   0 success, or -ve error number (see the IS_ERR_VALUE()) macro

The closing paren is misplaced - it should be '(see the IS_ERR_VALUE()
macro)'. Also '0 on success'.

Regards,
Simon
