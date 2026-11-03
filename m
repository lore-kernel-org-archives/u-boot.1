Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2B60A5BCB
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BXyj9oc+;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UuW321u0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA0BB60705;
	Tue,  3 Nov 2026 14:48:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fIJli-q9Idys; Tue,  3 Nov 2026 14:48:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1CE16607C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793717288;
	b=CKXZ4nyqax/pwdnncDakNF5Nk5WisTdDM2dyx42VGHG8R7dmU2ZZfzQMPGASF83jQHcx
	 W7OLxAMSacNjsNZ1MjqCx7w8aA34d59c5drL7MH+Wx+T/iYShzJSZnrzyDpinc62XBfKN
	 aPCKq1n3SeAeSZnHeSgkj8y6KcIatrPJuQY2Cg9GtB4c3hg06Z59X0fdJ9SxZ/jyjjopg
	 diQUMnOjDVk3isbd9LgRYJecJAQCRfrgxToN5PB98wV20PXhH5xStBqaJF4fNkA+Vvq2O
	 +3UQ9Q9HVzVSjeav3j5aZvd6VFeaoEYApRS/7yh4I1/eobRSzE95N7iO5E3qnpeaWVg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717288;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=otGBJCxnsqpUYFVng7eoe4xQKEE9BfR7uWvM98nXwB4=;
	b=ABv8UergRpmgZvVuJu91y3tx1QUJhH1PX5rvBOxI17EdHVTQi0fNcxbXanDHSc4XXbbo
	 Ct3HKDWCTqgSEw9RukqSna6qp4yKPQRJXFurkkembpzj3hbyqe30AbcG01MyvDcr7jXnd
	 qhXYTkWkrrv2nzLcjcSnfl4ymF1lzB1jKByy6EDHjmDnq1s32bUbDL/Wkzoxs/xmlpd/1
	 61ZkzuzuFszLxK3O3WmFNiU2Zueqor/Zxeq+hiPsjwdziqgBG2gK1SpbYQ7HQWuh/jUi9
	 hO8OtF4ra3811A1jtFa3HFeyMl2N6cUnz+ggYSWxEr4b9TRD7fYYyHJ7mshY/z+8GOA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UuW321u0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793717288;
	bh=otGBJCxnsqpUYFVng7eoe4xQKEE9BfR7uWvM98nXwB4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BXyj9oc+a68a50rgmWNf4WTZLG1TUKOXzKu9rqcB2Rz0MAfs+ZAidRzOT4XSUfQUR
	 8MEesC1EPjQwq3v/GN3AFhOUZ09k1cJqLc2KhIlnJJfrD0fuF421u6zYAt1DuZoUYa
	 02FnQxVQX0k+DMczNc3qz6DvoPSwT7dofbT4UKetdOz76vwaWqp09FVMisFHAL1yNq
	 GFeCT1XgKdlBu/zFh/qZYc4WStCjySAceeNwUYzydnxNcU2Suo333QDn4LXb/4ipQD
	 ijDPGfb6JyR2AYpSxRcu+pRshRFw4xbWj4DtQ1IQk5BSHcgwUh7pCsXcWEISzEYgZU
	 w0Rtj4qmWi4/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CE16607C4;
	Tue,  3 Nov 2026 14:48:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 67900A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 591EB607C4
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PTzD5GqS-6vp for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:48:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6591360705
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793717285;
 b=LIy8Q0ztUeYGWREc3uT5AvoMistnbvwavW+Xei7lMH97sHTT3/SbQEu1EjSUMm3fWj1e
 i9xdX6/F0e1cifUOjcipSHClTWrXGjJLb0ZzvTB3QJBZ788g8Ylm138Xx1LMQ/kUZliK+
 /toey5NHP7srsO3vQ4szcqU72iM7CHbhKPeluxjDwBLlxcG4MsaxZhjUY2/2QrhcY90xl
 l0ZsK+mgGI7GPgyCSlr2Jq2Rfp9X7TjtlonhYGISnPEM7T/UGumbRJke3JHgs/TRDxMRl
 RqhniCBPict9uJijvPr2l81+XuXLbuAlFY6DJ7vTvcjs6BvnRaOYQxRSmgDUGB8K8NQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793717285;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=otGBJCxnsqpUYFVng7eoe4xQKEE9BfR7uWvM98nXwB4=;
 b=PbBzl1i8WGcuAq7zAx13NfygNfT6fn2iimVVbY2j5bEJpUCbpeNeW2hxfS6StcESkczR
 cieYz67+uIs58APrc4oQaUO4imKELa+hdRwEV/dlXgIPeEG9kO5zEJFutQCF60qluJe8K
 NkpGVyPk3/K5t78ojtqiTrmjFWVzJJa9w6izv4C+ktaXGkRxT+H8+bO9hMpbuyNKZ3yBx
 ugFke2jIS/f6zBgp99qQovxqSJZ505ExptFpjMjPKuLeqZYeKduPJrLhv27hDhEeCfny0
 qlLA+ar8fjTdkvqmweX14YcS+iUaD+3hRtgeSM2JQuYuk5F2/Th93wYdzfDD2PD82Qw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UuW321u0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UuW321u0
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6591360705
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:48:04 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b47c1a3c74so5721335a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 06:48:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717283; cv=none;
 d=google.com; s=arc-20260327;
 b=NKUmDogH4nnBqgAP89qVZGAczqgw11AiGOBCRfexE81lU4Oy02DWzFii2QFzL+15I7
 DTcptkPO77b29P9vRBGsRnIG42xjsGJ5veF6TplYwZv51826qoN3UA6oFDV3g4TGNddl
 6xXb2rROAesdnMSMqGWwI9Bw5ZyLzl/z1AIHWt1BR1eWoB7UpDxNwm+7WD/8bSyjaumg
 +eSyu/wB3wqFTtmiC79c5uuEnnIClqKxZZXOiqybBdVx63MrtUuryTNnGkP9xbtIW+nh
 kcU4L5mmeV5MbxjqPOo/QvGczMRwD12+cCt36Cd0m9+ivHo5qx+LYd0DMCvR39yXqfAm
 wxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=otGBJCxnsqpUYFVng7eoe4xQKEE9BfR7uWvM98nXwB4=;
 fh=mhLlMaHwepi2aoq9NaZRYVDIbwZ82Zfeuy1FKZQUO+M=;
 b=bWFwpXX0xQuW80kfc1kCtIxSSpS+ZNbcJvFG34inHZ9Ur7M2sgdYw5W5NhjwAnsFYi
 kz61PBGgNTPVvdwHJr8mYIbAtiTFWZ5pB+R/WlbzNlXNWUTNbWQZsPCo5YYl1vb29wUp
 DGoWlzuoKpxVm3A38kPNlCatI9O19gykcQyjVbNotoOHb2tT+wGucNO5TToWY4qU1ajV
 RwV1ST5r/vN1+zh3VTCcaIFhtoWByGXDgjtCsekOdov57Q0Phl5b33pHoVjqYlSXAWoB
 6vJgLCO3zzGQUqFXiKHiiy+t/EQLlDGQmLafBelZlArIrDSu0aBBLKaIL6akbVF5RoW9
 6Q+g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793717283; x=1794322083;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=otGBJCxnsqpUYFVng7eoe4xQKEE9BfR7uWvM98nXwB4=;
 b=UuW321u0I211mV4rNUYpWRQwlecLCKDYWt4ychTBcgnYunZquuwTS4tXev79V8H5fZ
 3AwmwVtJBRUImWhNIIcymUb/e++jG7HJ8ex7cWHsOs0jR+X0llWqckAtf4J+nCDR1JxR
 Nb1I5//uAne/ECvoLY+c1DGn+rx8cyfyWEhXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793717283; x=1794322083;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=otGBJCxnsqpUYFVng7eoe4xQKEE9BfR7uWvM98nXwB4=;
 b=262llrB3/0BqLRP/Nk080IkQ/qcAoBCvFU9ZZuSvhF+1L/GjtadfASFs2X2lsacbVb
 PnA4RdbbsASTooGHjliMv5aQouOpmFQ1+9w5DTTqWKRljXNADpyFt/NE9U+gsRepl2ch
 WewR042bVviXY+GUzv7d1tbJhbwr1FJCu1fv8Jfxfh9gQ1GG5n9bYWFHAWx/Z2p3gcup
 zYun6osS0igHnFAd3O7mRPrf2Te2zfQkA92N6mv28ZvZzR9Fvro2proze3j4nrgDaqlL
 doXoqBxex+yFVC+7j4uLe/hMdp4lWV4Pnn6lxYLVIlmnafVyfkuFvaccm966CiX6P2Wr
 m9IA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCvUlooGTvyUqy7pfKp6jg+6v0xta6iKddVmngcfyQpn4O5F1dFuKJWN6K674jcSBBO38FuZY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/1WR9x3KuXOyRTVrYuypFvMhfrdPKf2F3J27avdq4XvKKgk5/3
 SUV2S5dUgegYeFksDHzsQ2VNe3p+6ljtm1mEwPPKze9tma29O9WeZxMINtpwdEdNgr+TZA06myT
 JgtESnneSr1JZDPvk8ZuXEeMvROx88E0Q2xMJispoLGtSNEQKehMcXg==
X-Gm-Gg: AYBFou2R+JY2BB2GGKcf9gH2+nZLr/e4gnojeNmEhxXG+WaeAuMCcwAT6DOcR4VkkQp
 1Zicm4o/Xuhuoa0yhDO0Cboay3/SgUlXzKW4ywgyew++zakYlLgzrhTryXxjQyQ4QK3YkXRmxH+
 TIkJWUTukr9kheyk6scnL+2Fc+foBl9jBQN7XbZTngYlM5WZgrCtzJhiVq+lS/WWEALnRcY29O5
 eN//5ApMhn9/LxDshnDWB6pscy5dZCh24NSs3jI5x7YsCiF6eZGZr+UMtT8fULL0Yw9Z2rABECw
 pDnwDN8OPdpyaasdLOH2VAMBH1ac6DWHYJBgwd1fkNc8cHm8B51UNVbCNicSSR5aaQKz/zrGn7r
 0IJugkn3IBZHEJp0UeI1VIuroR6wmb/t3mGHvrC+P1diExvRVdm+ad4hGGZDayaiEXKOwm8U=
X-Received: by 2002:a05:6402:a6d1:10b0:6b4:91bb:88ec with SMTP id
 4fb4d7f45d1cf-6b4d4d6f5e9mr6599029a12.35.1793717282736; Tue, 03 Nov 2026
 06:48:02 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 14:48:00 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 08:40:39 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261102-blk-part-unbind-v2-1-d0319d20fbfe@kontron.de>
References: <20261102-blk-part-unbind-v2-0-d0319d20fbfe@kontron.de>
 <20261102-blk-part-unbind-v2-1-d0319d20fbfe@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Nov 2026 14:48:00 +0000
X-Gm-Features: AclHuK9-rAtYtX-g0fWwSv_jVpoNISCyLWq3U4Id1Pt6F32SW9n0BwdFc0yDPho
Message-ID: <CAFLszTgA3h=ks1-t83w1jnLYxp+Ciu1m0sGvru-L7hDw_WS7MA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] blk: Unbind partition devices when removing a
 block device
To: frieder@fris.de
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-02T09:03:47+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> blk: Unbind partition devices when removing a block device
>
> blk_post_probe() binds a UCLASS_PARTITION child for each partition
> found on the device. Removing the block device removes these children,
> but does not unbind them. When the block device is probed again, a
> second set of partition devices is bound next to the first one.
>
> This happens for example when the probe of a block device fails in the
> EVT_DM_POST_PROBE event and is retried later. The EFI disk code then
> iterates over all children and tries to install a second EFI handle
> with the same device path for the stale partition device, which fails
> with EFI_ALREADY_STARTED:
>
>   Adding partition for mmc@42860000.blk:1 failed
>   switch to partitions #0, ERROR
>
> As every further probe adds another set of partition devices, the
> block device can't be used anymore until the next reset. This was seen
> on an i.MX93 board where a single failed read during the first probe
> of the SD card made it unusable for the rest of the boot.
>
> Unbind the partition devices in the pre_remove hook of the block
> uclass, so that they are bound and unbound together with the probe and
> remove of the block device.
>
> Fixes: bf76031d19fa ("dm: blk: add a device-probe hook for scanning disk partitions")
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  drivers/block/blk-uclass.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
