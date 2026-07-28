Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE2DC531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BD5F40A59;
	Tue, 28 Jul 2026 11:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LAfxxmHVG_JC; Tue, 28 Jul 2026 11:56:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F32F40A17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785239809;
	bh=q16ktRCT73zwDin/mP8NBubrRXjRYgu/2rT7xHnupIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MIj1ApzuotK2mEgy7xJBrtPlYvkm/qDTnlddle220kbc1TreE5BgThLt9F75AvFOG
	 agJ6qlyQ41CzUSJoAMRacVYSldlir/xZbsSlrJ2xwj0FWGtqVGSojk6afOVW6IhsCm
	 0eAkTug1PvfpuYm2p/0/Yhr4zIA6SZCobvJPGKhxArnB29+yQUI9czY1FPGodhKbu/
	 0OExl0/ZDBIatdc0K5eRb1s+OfTYz/F43gIldIIC7nf1wztmClZ/G7j+wjPLP1bJiO
	 KHurJYuZo9qR5w68GVrSYlliYWxlGPMlGjVt0BJ2IXffokrpLVWnE+qdBNrXIhE7Vw
	 DzkZpATBqrZSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F32F40A17;
	Tue, 28 Jul 2026 11:56:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B36122E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95795400B8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:56:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wkfv8NskXmwW for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:56:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8856C40085
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8856C40085
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8856C40085
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:56:46 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso6003457a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785239804; cv=none;
 d=google.com; s=arc-20260327;
 b=HmJs1X5ZpbSfdTPwTyKvmJ0pKb6aHUw5Uq3a/zOPhlf9w48PrEVJrzg2UEoKLPhd9n
 vDrcoDs06ZK02+HpO8heuThQlmK1XEubwl8enKVsckE4qZC/GdH+okSM001q9K/XzIT4
 Mt8LK82UV7kLeBA6Tky2MGQSSNBs6uX+k+E0CjG2DyoD7e01SitiZvuzZw4n/tXuQjlt
 dtj3/QEJvUIbppY3eHIx8bcM3yNh8yQvxicsip33uWwRkN/QlHMYsEvp9u9IYBAwJK8R
 9QszvUWY2Ujz+2Ls0F6c/M0gBY7jLR7JKTr8tA5SrxjuIV5i54TRo5pvcG+9Q/1/LliM
 zfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q16ktRCT73zwDin/mP8NBubrRXjRYgu/2rT7xHnupIw=;
 fh=R79jWkZYRkbgE+EWHlLWG+bOnLCxKq1aLoR42qSn7cc=;
 b=hVCbpSlm8xFCN8Ks6bRHOhRtfbfr6NaABnZ7Bk8NiTJU9usU9+Dq0mYTp1yar7tQpW
 Q/Gigjzg9d2u2OgVYBvfSm1x+XLSJI/H2tgQXVyKP+9gecUSutj4meZnzuDixsnLRPld
 v0tRLgtul38hUTrh1vjtDje3HbQVcLZ/9WTBWZK4uOPsyKZK1rRdMMs8EtLBFYPgnQFY
 tRhUjeoXfItvpgi6UJiyddSkFeBdkQxm8hMDk5tYfcpO35/To4i9Ltjh5eO/RSKlNzSQ
 NsBirjfMvQXFQK6L2Fd+PHhBdffbL25Jr8i+o6mIFDrH4qhOGOXn0loW5gGyh+EqOhbS
 WXIA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785239804; x=1785844604;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q16ktRCT73zwDin/mP8NBubrRXjRYgu/2rT7xHnupIw=;
 b=pgMfepvZwHsQGuG29kuVD0LuJ4ppyhX6Xo8RLxyi9W0MmkiYO4MWdE5FcwvghzYawi
 f7/7rsaBhOwFgFAH78nOPag6Ar1KFfmPEYeWFQMjDf5zA1ZSBZzi7ouSgzcir7MaMSl/
 Ec+IUXLnDI4qg2yZOwEywYeWiOWMX8+xL6mdcWFpgS5JGziYsuVaY4POxwpysv/CwlWA
 U0M6jS2cuxDR69v6Q+yHKJ0rOaxhRv5l6rDMaFIwlknrTjNn3kJVp2H//MCQByyXTK8M
 Yfy72lLD9FTyZb/gzkG85ktWTaFMxCtvvv0pSePBkhpuZrOEb/kZPOOeVaZGhX3RZY/G
 en7g==
X-Gm-Message-State: AOJu0YzVCh5wneL0RkxDcQz5O7oKPENbfbPqPBri/t20EGHBo8/fKn97
 BOBzM11Inkri+Vgff+m77cdRvxgNubqeLu0j42CvtAyyQZMQa1wEvO0U2sDT7N0YwcMSsXLZkvM
 hz9yVujDjofpUj5algt6QI2iOAs2J07IF2vnVtpS8gyBQojLaOopfTw==
X-Gm-Gg: AR+sD11QNGrx8/nRT4kgCYG7qQofuW6WOfg3w/eMuidPkO0A9PkKDHwO54cepkfTCRh
 Q8tRJWYHT8IeFcDygRJCCGKTk7jyljN/gZmptQ0kRKpkVRIwqwIA6IEYCrX1jyZ17ZwuSzG3iVi
 2KOSiQtx2CE54l9Yjj8k9lAZaYpm5lndkmcHDz2al99n7WBOCj8p0mB/DClsDHQAFnC7g+TDYKc
 pbF0SjTC80DoNsN0rQ0xB5Z1LzX4KUGDiH8nTLIrpzUnSYn7oqqnZ+uN1g8
X-Received: by 2002:a05:6402:1f02:b0:69a:2ee6:4c95 with SMTP id
 4fb4d7f45d1cf-6a034925818mr986270a12.0.1785239803904; Tue, 28 Jul 2026
 04:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260723093830.3132465-1-ravi@prevas.dk>
In-Reply-To: <20260723093830.3132465-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:56:32 -0600
X-Gm-Features: AUfX_mxVixhtZXi8KeDdGVYiY8_etMlH8ImqabJx3rPHAxWifSUW_SuY_iCCdPY
Message-ID: <CAFLszTiC9wFtn=sc+YzYk1g42m51ScVbX1SHaOK_m-TPJKd=dQ@mail.gmail.com>
Subject: Re: [v3,0/7] k3-binman ergonomics
To: ravi@prevas.dk
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785239804; x=1785844604;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q16ktRCT73zwDin/mP8NBubrRXjRYgu/2rT7xHnupIw=;
 b=cIvuZNCTSq0KF26wZwkH0PVKIipaSAO8vB/DaazyMpRNrr9Mez26aro9Q+qT/En1O6
 oqzincg6u+Vh8SwwTHmS3yVPGcBxjweMMgcZuTElbguhYmxVkl8h0P0iZUBcVQJZUs6b
 w6TXQnSjK/jcqc2cHu1f5mn5XKqTDhxFIoYBs=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cIvuZNCT
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

Hi Rasmus,

On 2026-07-23T09:38:22, Rasmus Villemoes <ravi@prevas.dk> wrote:

> - Implement the "allow string list a value" for distinguished-name
>   properties alluded to in v1, as it might as well be done now and
>   doesn't take a lot of code.

>
> - Verify that property values in the distinguished-name node are
>   strings or string lists.

The series adds a fair amount of new logic but only touches
x509_cert.dts, and only to move the CN into the subnode. Several new
paths have no coverage: the list branch in dict_to_config_section()
that emits the '1.OU'/'2.OU' form, the Raise() for an invalid property
value in the distinguished-name node, and the derived-class
default_dist_name defaults in ti_secure and ti_secure_rom.

Binman aims for 100% coverage, so 'binman test -T' will flag these.
Please can you add test cases for the multi-value list encoding and
the invalid-value error path? A small dts snippet with an 'OU' string
list, and one with a non-string value to hit the Raise(), should do
it. That also documents the new subnode format.

tools/binman/btool/openssl.py                              52      3    94%
tools/binman/etype/x509_cert.py                            81      1    99%

Regards,
Simon
