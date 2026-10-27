Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B7606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ALG+T2oy;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OQadG4+n
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 572D840638;
	Tue, 27 Oct 2026 08:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dgUgHuryVLut; Tue, 27 Oct 2026 08:59:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 909644060C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091557;
	b=esoV51k1GZGpJ0b6QMeupBOd5CWDpfpH0uFfc6TQh0UEc/vVxq123jkS/6DJXULwYawm
	 jvsfZcGBC+qnrse3sQ1OH/BoDqxREa6S1Jx+ecmC09NC+G0gxUjIOrjVbs5D8OAhamnoh
	 cKz+iQccdmG/N6kgdQrKBs232CqvSyuhHYbVs5kjYp1yGj5L5BWgzAkMPnKIxJKd8J/C3
	 cXgCk6tJR4oXMUqYY67pIa//gjpltqumoD5wTD0vCzr7lkvo6ify3yvGB6PkJLWiBzRp6
	 NU8Glnv0GswfIJxFK1QJsnBx8KACVzq5/zdcDA7Qp1/2xl3nKBiWT7VPkAZnyjtbCjA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793091557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tZ0O5FunGMK35MBo5oU5/YmEhxEsCp3JuNzTZyefX0c=;
	b=I7yJV/iMwBKHZ2RAFrX0mOkky/WhY3jNyepTU814Pcv4spFcxtHLAObs4xP06kJdZ0tY
	 qFaE61ni0QxMFVZ5jnsB7QlsArUk61em81eODE/Ln3ThyvdyXgssF/okG/eJGkjQO9kBa
	 ThBUCF0d5j/b8tYaJW90yFg88TZwofiarcspVCPH15aXP1Odp8yFPHy5+ntFSjJgPj8G2
	 C/5ZG0WB+UjD8dN5SBnrQ1mZyNNxlUyaEq5s7BGn5l3SlAN14j1D7i8C1w9J+/eblOx3S
	 HOnK/n8HBHi7czk365uueKtFZuoPiLX64f+Dp4+T1pa20AqveR0kQFfEwdS1ZCgTuVA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793091557;
	bh=tZ0O5FunGMK35MBo5oU5/YmEhxEsCp3JuNzTZyefX0c=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ALG+T2oylSnsJxj9JWR92G7IfLuf7pMMsdqja13sO7HYyVampw4C8Z5sCVy9ge2le
	 xPyaNbQIkfUPY/eMWYMN546a4GL3Lhn9Q0UR21hk6WinY0sm33oA/5bb2qtxspoVb8
	 vucGQTCieN2TFg0xFYhgLq5WKdN90Z3buIf2MgEhscwBUGICjxcanXEXiceDgzDwZG
	 dEpJVjaR+z1QfLiT/n8DkgTTS1tD+u4moxVUBt0OC6XWbUgCkosnlrzN4V50mSTxKA
	 dxntg8Ekc4V3ovdAFFXFUZXHzmKacLy6dsrWoSjANa4Z5kZNEAJdcVY49Xq96LngDS
	 UcRh5aIK6xRFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 909644060C;
	Tue, 27 Oct 2026 08:59:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E411CB91
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E05C5606C9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qk0rNX9_CRte for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:59:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3D98605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091555;
 b=hmNXO5RuMfM57Md1XqvpyOyH74r5m7HjT3BG3FgtyZDqFUYbo+QCzdx6tHVE2BLTKtzH
 hHKcqSlrf43Pebxdm+LqP4Rb9oS6otBqUQiDM4voF0s5+HqyQGJg3i2E45JkLYP6QxnhP
 /aXItrpZzTrmKnWWWpeq8S8CBFEnI2bxR98EBQgAmzv36NoaHThF2iObpjodE7hHSsM2C
 dwHhgie6raqWvJf6LGaj6O+94uAgOvYT/iUDfbza7GP3Wv7ovOW9PAp2kE3O2S447LckN
 3l7Rmq9quo2lpgUY4Fo07/rkv2XTMk300hWkLsi23RNPP0rC0VPMk84JALb7qpPGCGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793091555;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=tZ0O5FunGMK35MBo5oU5/YmEhxEsCp3JuNzTZyefX0c=;
 b=ghzs7//WxndScFphVSdu4vxRGpy3tY/caXcRqFF1qE3ar/pbO65iiqgxsrDxBHUJYHmJ
 MqtfwxotExnfeAq9hbSfFjPg7VKhfPOOXq5fWVpSjKOnZ4EgKv6EogiUNKWzDK7Arz7yS
 1XMQfau3mFwRlIJq3DoUyxXM9W8SKqC+vFqM3x8GrNv49b+jg/mA1B2Nz8BotbnGIpl35
 0xyUj+pcbnqr67qJkM7HbvhntCr6C4sOSO85Y1roLsojf9BZp4mBG4b4PwRqpr2CCCmXB
 CZUpMSM9z//HA0V8mc9t/a8qXpdGCZvrJWFa9nHzOYcKIWfEwvA3yFL6N7OQvJvMdLw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OQadG4+n; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OQadG4+n
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3D98605EF
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:14 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b486e1d02eso265618a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091552; cv=none;
 d=google.com; s=arc-20260327;
 b=Dp/4Ypc03em0ibXsTCWv8AdqhzxSEVPCeP7BIvTz4c2zL3LlEMe6WeEloLhDSxc7MQ
 x+8rs7UcIHfueDMoCNixCuuJo5WIZOexcHMv/fgffq67EmVOzhci3S0LwqF9V3LNcwPB
 RpwKG3Vik8PjivQ0d/Nh08CQmRu4MpXn+zFxhSkRLWmaSUJ6otNKsfQadXZdhX641VBZ
 qrYq8WQ4/QOVCpiBJiMrHVbJGC7sKSzyhJnp52c/FexSARQ/Rreeok4ol1FH64d9tsHV
 i2eXXAo8q3mdWyCKB3DNSPfsaAtE5wG4rqPCL+tKzq6yqG/BzXcuiDcxdSeQdRzSGaR7
 hMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=tZ0O5FunGMK35MBo5oU5/YmEhxEsCp3JuNzTZyefX0c=;
 fh=/rdnnAgt/z8Y/gO/kkwLsOp9dS2eruYSp+dyjwHJTc8=;
 b=FkUb5uKPbo30GH0NBymWIGyL011LZ1FwRIQ1WpWqDFDiWxTEenhKRMHvhCQNcMh7Ae
 EBYId3S05xfsf/YquSa3V5Nmkje6aMlOFe7osG3dOxvXtwsnlw5vG8sk2S+QbvqOvt8I
 /Ox8J9bPx1kWhk85fS/pwmFVG7fP3G0GS8lJCHJvE541RXe0WLazufbZDyxJCvGn2x60
 fokA5BGmh4jTwtHIhzfvim5+C9XGSLXrATfwL5hHYMPS7JZz23fCvJkIByvFBrIIKiik
 7WDG7UxnvD6FMiFmOdIhpsNI7EbcuyagtjsWm9DsAy0q9BuCT0Y/hHN3wvwQ/xAcdneD
 pyKQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793091552; x=1793696352;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tZ0O5FunGMK35MBo5oU5/YmEhxEsCp3JuNzTZyefX0c=;
 b=OQadG4+nnmYCl+vObWSpky/QUbxp9zOcEC5Nd5W6H4dIteOHykFB34Y6aWu864M3wf
 GSa1WPWZzCj8Z4DekHx+CfaLKzGq+Fcok3oGMMtd7S5VC2gRvM40d7lzSKuay9RZbg7Z
 kxOfU9MvyCMg6kwFWLKkg3B0r5mfu3cv+pS0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091552; x=1793696352;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tZ0O5FunGMK35MBo5oU5/YmEhxEsCp3JuNzTZyefX0c=;
 b=mUhR/42xB0hI43Lf+7FSLI/pCkumaKGneSXMrQHKyH2YM8SdsrfTrXyJKLfQ+Kdkhj
 FuEb0P27MbM9GNV3Dh1KxdbaEzhoKaI1cz6Ete2v4QTrDBy3Ca8obsDkM9fEgT93UNBW
 UTG6ri8IOzkBAypdOQw2MzrqTHXX3/DB81GSzvDVqcPm0cpdpF0iAYt23sdCXPmPhlmI
 IIlUGM3GV26WPFhqULPM6hUa7Fk5ZIC+eWP3tp6ybs32+gQcGvnsqWjdCDMHB1czOBa5
 0DfiWvt29+ITJtbUvuoU2JlzGH3X3r7giTpwRdilhflGdymhoxxlS5LnsudoiX2+hCGP
 BffQ==
X-Gm-Message-State: AFq9FYJtd33CbKXrEyKDfo6X5Sc/OqYXYKHKxLLe311nmuy1gAaaHVYQ
 TG1sTOWbHir0kVZlWLV7XDX5EtlETL99H5RP3NanujNUt98E/9b6G+WYHd6mr/i5eMI6mkFZxtt
 ZIClI3j6tYu0lqwZOAKfEzFbK8L/qhgzv7DG9shF3
X-Gm-Gg: AYBFou2XgvK0bUP07jUVEsYnxTbgs4FaxmTsJkPEeqgTpUN1me598ox7Yedvod1HXjp
 UhmlEW3HH2dTZ9jDGJHhL9RksYMpCmJ685w+WkWcaKyVXC6ZtEmUod6aeVEa9wnza3wPYU1hVGI
 bqrf7/M/5RyNdVFqmEs5Az/5rwTJAYphspG/XwiTM3lN8hU1Pfmov2m5uem+eOJpSiId1Z7aVDi
 TI3ufZDynU+Ck5buBhxrFbUoP4/V/qee9nf6QgtFgOH9qSM7bQoB3YQRt8/0iBInCmMMAR10mGf
 P7xIdAXfv/2kIkvQVfbHYNIRCAFQVF5gJ4m61rzOdxLclaA2eyStBiM3hrEfjZkLjRZj4x63QSt
 gzYm/U332lZDoz/dBSLjkUs4ITD/BtXF+3fU=
X-Received: by 2002:a05:6402:5191:b0:6b1:b97b:744 with SMTP id
 4fb4d7f45d1cf-6b442ff3810mr11312492a12.32.1793091552384; Tue, 27 Oct 2026
 01:59:12 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:59:11 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:54:49 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 01:59:11 -0700
X-Gm-Features: AclHuK83rYu0FAGKCMylnq7SQMe6E2v136TFt4rhVE0pWkdHEngTzMr-GPLHQD0
Message-ID: <CAFLszTgygsEhQCaroyLvxJiQhafaR_pgQhRaF7Z+wobkVCcdyg@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/9] block, disk: Check block sizes and partition
 tables of devices
To: anabobillo3@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-10-24T12:16:28, Ana Bobillo <anabobillo3@gmail.com> wrote:

> Patch 1 adds blk_valid_blksz() and has blk_post_probe() refuse a block
> device whose block size it rejects, which covers every block driver.
> Patches 2-5 check the block size where the USB storage, SCSI, IDE
> (ATAPI) and NVMe drivers read it, so that each refuses such a device
> cleanly: the USB LUN is skipped instead of failing the whole stick, no
> SCSI block device is created, the ATAPI drive is treated as one without
> a medium and the NVMe namespace is skipped like an inactive one.

One thing I'd like to check is the order of these patches. With only
patch 1 applied, the uclass refuses these devices but the drivers
don't yet handle that cleanly. A bad LUN then fails the whole USB
stick and nvme_init() fails part-way, which is the behaviour patches 2
and 5 describe as the problem. Also, on a little-endian host the USB
fallback after READ CAPACITY fails gives a 128KiB block size, so a
stick that probes today would fail to probe until patch 2 lands.
Please can you add the helper first, then the driver patches, and put
the blk_post_probe() check last, so each step stays bisectable?

Regards,
Simon
