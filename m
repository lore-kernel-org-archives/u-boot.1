Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C567BCA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B99AC60B74;
	Thu,  1 Oct 2026 16:00:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y_47BhXMdwft; Thu,  1 Oct 2026 16:00:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C069160BF3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870403;
	b=oh/w8bp5UliEhHsZyR5nK9NJmfUd9KSzeIjkI2XiIkuncga413d8HAHbmdzeFJQehv/9
	 My7g5o0dC6pTlHQ2U9DZH3kIyAxXMEE8oGC3N6IYMKQhGRu6CZh4f5ce5IsE5UKQv0qhF
	 qMHvJuCaQINiTgwW34y6JBp2Mx+XtBiITxPIz6yIEJImGnhtm5oft0QoxgGooOrmAsIDP
	 h5nNjTECvmddw+jQP6q36es+pbCqYm94y8bj9MJIRA3a+VzdK+rF3PfF2qVaNs3sTU0W7
	 l2V4LThxNtJDNCAZT1QCQ5Qllfut65+MRg9mfp95R4R7/lIZX+0UYP6ZBufXOzJqg8g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SoT5vgn/jCr5S3u0VY+zqQ/fSSr/Lr98qnokLisGFtU=;
	b=aes7YOj+apMqCuj48rhPE+8Yed2NeU52IMiv231WIfy61xhe7AsY/BxSnW26+KhFA97f
	 5ab2J7UI9wZebbszEQKbUqyMIaw4pAjjKXdtfSnZUpIjzykzXY37Wppom6mmsI+kYhH7U
	 R4Rao1fr7js4HF3rXG2ERobaiyTyhiirNJrpGuV/TE9ZNmX1S9QJNQlLd5/ITIgQaBcYb
	 QK234MpSOK5ifciKLDKhM1sf/LKJ1cqkUXyk9MmYTsWLU8iARbhzQfPjV/e8mh/O+yByu
	 RUrDEkfkgPNPviUXKxqvr2oZNyU5reokQiOSoa/30NBN6nsngEOnwqa2O0UTe4u/0vg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TjsrLeuj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870403;
	bh=SoT5vgn/jCr5S3u0VY+zqQ/fSSr/Lr98qnokLisGFtU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E4w4O3qeEev097FEN7a1wEL4r6QA2xHLO0eZNNRv9bgrAsQPEe1u2fXqiVe7Yad0A
	 6X33IJFwBSBO5Lz2gD9yu8y2WBuHDsw2CHcKsMdKz2+NxwJRcbsphTmDSNqGM3oKTR
	 wKNHHsBt+SUlWMFgDJiECYxUErA6A/olEdDQ2poPnRF8M61LF4GQj10crwNrJlIsap
	 0zO36SlCQ5YS5hX0AzUjfxcsmKYXrlpA2U/Ql10eyHccOFjOA8mw2hR6mrgtKKDcd3
	 r5cRuLrcHShPeuODIQMBVucxK6VZOZ8DN2xP6BAqqg+G0dtLul7WPYIseJ7ArWTXT2
	 C1FYX+SBTaqGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C069160BF3;
	Thu,  1 Oct 2026 16:00:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C65FC1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC53D60873
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uL6DQuSyRUjn for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:00:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8D74E607E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870400;
 b=p56HacBGEkdrS3XkaFhZ4v+LOA9wBD9fHOkxlUNc8EeLKa3R0Ygs1u0P2wZ0z9hWtvHS
 WpNKIW3g0yGai11MRLKCNZ+XWHlVBTN5NuQpx1Eva/6//qjuqOKH5owmNPM3x3X/WTSwL
 arAeEaH8lUjPrJ8hynPUij4wPZSTbAqHtWdOBZAyndQyWWopk6s89n/s/78+W5XbNHLtv
 ClVxxDLbUhhM2iE7nEY4atgnISosAGsUC8BcmO19ir+qXRjpeNJjp8IxK+QLf3/JZsq8x
 8/CcRDrZ53jK/95OMVQd5f6/0FEKNGYKs946HReWWb9r4YpVqPh1LR/wrujOTwu++5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870400;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=SoT5vgn/jCr5S3u0VY+zqQ/fSSr/Lr98qnokLisGFtU=;
 b=lK1Jgd3CbGSvcklp0A5lqRIP0ORYvKCNpoHuKx9pdr/d00fSMyNbulvezmDMv6RE1QvX
 T+HjVAcB1NgMUVEXXzM6NUpqR1J5C+m01hp05du0gEm9oMQYJ+N8szk75iYIlSVG3GlrH
 4kpQMCBRDumXnjy4dTOcPVEr59rSgZdEKAAuBrQ9X6P/7U0r8Pb7X9y6P34tRtmwAZgpI
 QKN5v9Port1BUxrBQaxbFWH/5Mp4o5BOEDeAtq+Nm/r1Mf5rYarIHyA24GGULrJ8YLpIy
 Uezmd17ddR7PX0BMYPUoZQvcE+dcUxjDO72G1/pDbK1w/LRRkQV4EcY54b5wV3LcZzg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TjsrLeuj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TjsrLeuj
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D74E607E7
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:59:58 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a8038a9f10so9260395a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 08:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870397; cv=none;
 d=google.com; s=arc-20260327;
 b=VYayWnkAVGqrf8nwVvHa/zAaUcmcWwr24bjVES4WWOCRfZ/GBGyQhF3QxAc4SYonlq
 +vx5VGXUlSRxzdnus7GTWYvkIz/hR6938HZB7TN4Q1IASoBxyk93H9ulyBpbfXdOO1BQ
 wOSF7JB7pe2WgOvYjdyZbe3QF6LQk9mtXPu6cvHFWmrKjAZuPOLB5dS+HqwOzowvEq1C
 mbhIu6S65JHjuvLhClB0zaRzYqGNcuvxbcBGa1Z40mRmBBOc8oSwMk+cEind9VEOeTdM
 7x2LW6BplT/0si7s4Hm1tfjclARWe9SuuNgEoOwbMad8SdL2Dj5lkZBUjXW+A7ukR6LD
 fxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SoT5vgn/jCr5S3u0VY+zqQ/fSSr/Lr98qnokLisGFtU=;
 fh=6kpbejhtxF1XAAIHwS7aDhGLiqS/pDAcMepAoOk4GYI=;
 b=NwjaJIwaULAjSEn26P878LnZzd5ZB7ovA/IoB/+c4UJcf8kZLPadEoJBXkuDWA79v7
 I4ENGRBSYNL4ct2a/kjcQDk2WLZN2D9/CD5k7rtx6vpYcEwM2w0BzdYZ/W7RAuv7tXr0
 Ka6lDjkWDeJzJTGgVa52fMae7Lpha0XgxM8oWVBZkFRgspGSS2bFQCwiKaQQejwil2zq
 KyAbIbt23GUtpZr9sQtaIdpLzpyhIzqMdM3NpFsGjSjGkZGoAiY2QlTh7uEnEEpltfLt
 qL5+CwAY7JbdEcHDV5OhevP5BdHbQijXQYIV01OjcNxZjGc7mhOG7kP1tkbgYNwCiay4
 fK3g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870397; x=1791475197;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SoT5vgn/jCr5S3u0VY+zqQ/fSSr/Lr98qnokLisGFtU=;
 b=TjsrLeujo4HXrfDC5aQ/nfnNMZeW8hH2G6FyoOi7u60bsI39fiPniPMmsZvGmGcqPI
 JTxzqPChs3HtGjrgOO8aGA8MgUWRmW0UQT+ANPuh7eer2u4j7f0ne+1AvzJoU0jhgGsH
 FJytL/NxiY091lKWHTTjv+JLQyMwwiwxtOdtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870397; x=1791475197;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SoT5vgn/jCr5S3u0VY+zqQ/fSSr/Lr98qnokLisGFtU=;
 b=ScX0tOZMQJ/TcRm0jbrNCtvXxRncn/pDXJkR6KN8uWCbvFDkE14E17XFIcvBUeQM2D
 8e4C6f+vI2WvEitchcgvRFm36m8nRCJwobihfR/kuWcA7RqEAUnfdAg0RtYL535/VGOc
 V/cP/6JBzsI4ajStxmuX+Ao25msNPN/Bh7DNe0aQbvMmUK7O1n3UV+5Hmoth5+ikk0s5
 0E/zaDHHSx+UosrKDns4LQSXH9IuGkSkhKt8N19Jy4RoqtNbncNsy04Q2MvBCCOrT08y
 GLQU7oSK5eQ7fs4G56Eg4WKRP3Hyl4/zEJ66pFCyhpKCRkOGb/MFwBywOw/KgkSPSiXL
 zC4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2h7rjMkNts0BIlsE+IBYSEU1dbxOZTOHAxxCKccVQPgUH6MJW8uuWoGfdnyDAM0vK2kQp9Xo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIZxAJyYRjvPbppech870+CIePS8VY1cVl9kL7OVOa8B9DK3XL0
 izrQSXBEewgjYk4p48U9oFNsL9uHZVMEiXAHvfME12qkD0laV4En/6FHOpgWlg1gfXZqqLu+7Nv
 w4LldO+lNCAtQufDHLxibWoP6wRo/9qda6b7kQJLN
X-Gm-Gg: AYBFou3Fl2YoQMTowKe43U2PbTpzqo+lCLWeUXI37AVveDRaH/C3LAJcHL431BN0NUh
 KLDWutLOntrphFu+mBSdJ5ufSQNrAXg9sJE4WJLB0Cd83KMOJRbS3idJcuBC/qSi3SjoHvAWKi8
 IndO4ZW35fuaEW0Lx908JR5Kky927chZn2teWbK2bmpC4q3T91XKEZ5aZtVI31jj/NJ4hNOavwN
 WpQOQFNt8vnqDRXgDk6cT830kGFBIgWMv/YwtDqy5vVy+fQjOjeLC2LgSnvFhm+MRvWW8WOAbhD
 ubmBzOo3/oQSSV1lrudWI2xRFyK9vd7lIZF1HL7Ta7oNhKPTpxm6MdLI+rFVrPFVMQg=
X-Received: by 2002:a05:6402:a0c5:b0:6ac:77c2:c418 with SMTP id
 4fb4d7f45d1cf-6ae1985d094mr3397421a12.1.1790870396948; Thu, 01 Oct 2026
 08:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
 <1db5bc9548848bfee60b4548a5247935231e8ae3.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <1db5bc9548848bfee60b4548a5247935231e8ae3.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 16:59:45 +0100
X-Gm-Features: AclHuK80_t47NCGZWN5b_Zvcq9ZT-IGLBPzmuqTgi3iJP0yPBdBzvl2YtwqHcNM
Message-ID: <CAFLszThXY26ec9B28ekosVfkCeUgoa0Z=3JFfN2Swk_DJsviNw@mail.gmail.com>
Subject: Re: [PATCH 02/11] cmd: ubi: report a failed UBI block device bind
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.u-boot-project.org, 
 openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Daniel,

On 2026-09-29T00:04:16, Daniel Golle <daniel@makrotopia.org> wrote:
> cmd: ubi: report a failed UBI block device bind
>
> ubi_blk_bind_once() drops the ubi_bind() return value, so when the bind
> fails the attach still reports success and the caller finds no ubi_blk
> device with nothing to explain it.

Not quite. The only failure path in ubi_bind() is
blk_create_devicef(), which already calls pr_err("Cannot create block
device") at the default LOGLEVEL, so the user does get a message
today. What it lacks is the errno and any mention of UBI. Please can
you reword this to match?

>
> Report the errno. The attach itself is not failed: UBI is available
> either way and the block device is an optional view of it, so a UBIFS
> user must not lose the partition because the block layer could not be
> set up.
>
> Fixes: dec405d1653a ("cmd: ubi: create a ubi_blk device when attaching UBI")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> cmd/ubi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -690,7 +692,11 @@ static void ubi_blk_bind_once(void)
> +     ret = ubi_bind(parent);
> +     if (ret)
> +             printf("Cannot create UBI block device: %d\n", ret);

A failure now prints two messages, and since the pr_err() in
ubi_bind() has no trailing newline they run together:

    Cannot create block deviceCannot create UBI block device: -12

I suggest dropping the pr_err() from ubi_bind() so the caller does the
reporting, as your patch 1 does in mtd_blk_bind_master(). Patch 3
already changes ubi_bind(), so it could go there or here.
Alternatively, keep the message in ubi_bind(), add the errno and a
newline, and leave this caller silent. What do you think?

I agree with not failing the attach.

Regards,
Simon
