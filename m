Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FDE606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=minT5Ky/;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=frs7kjCG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4E4640780;
	Sat, 31 Oct 2026 14:04:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-fV1J8lQuEb; Sat, 31 Oct 2026 14:04:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 16067407A2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455474;
	b=h/9XfQmNtM0WpVO9OAHFcpTgrVt3GHQdSZIoWuy5d70id3nlhcslP4Uw5P18VA8g6VKA
	 MCjiIjir8DD+xMx0SZuVotIO+GJTl98B5cWAr3FzBeajeacU1hVJ85kQATv8qYHr04amE
	 Ups9L1KfuScavHwN4BjamBcr/b9B/ek2nWSztzEDZobOLlxWe+ZBXhphmFm5DmZYSinJR
	 jzAChqCO9apxxElULVzF0iQR9/F+JJ7PR70bJ6Zo1t/m74ioHEmV5GxeRIYHP1WFrdMnD
	 KNfD03YonzMiR4gW8OTwz805KLf2RnIGItSD6v/EiqkjXCpUxVz5IdNcjLVxrsZ1k2w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=t+xxcSzsM7h4HEbnAlMG6buuZ1fxZqHezFUsHGcWqLM=;
	b=ZCayHqroGJsX5ITqUh1sVDQslu1+ge/bZlhkcYi0Yhv85E+cu90tf/YuJAEMVDermb/M
	 i0i+ih2imXV1bqN7KHkpaMcpTa/8hIvFzIWdNy8dlQ61o902lAXRoXTcWdbdxar8ug8PC
	 BMoAWW+fFDwNNbS99pm5o4m7Z5z8A8+C452FamwpQl3avNcvTijl8YP1l7hOlFDuwqspN
	 qIxy96dpPz5mNrAb7uK8iSEQz57gQQXRbFLOfFX5H4YF7wh44wBC77/+DVLAN1YcfSLjE
	 ZM6k9wYSSAjTuRbMtVe4oes+t/s+wbF2V1gEXVz6v5KlexEFycrX+BYbk/5kZl5D/Aw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455474;
	bh=t+xxcSzsM7h4HEbnAlMG6buuZ1fxZqHezFUsHGcWqLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=minT5Ky/grChtoOsNOovkYSDC5xZkzm09QI0NM/P4/4MxjFmEAZvFkW/CaDe1pkn+
	 wS7A9Afahyr+vAyim1Jus50P7BB6dgiU8OAL/EjcVB81jg+JgS8VIwSh81QyLfesRw
	 ipytJikXo7Ke60wJfDso5PWzBQUYkWaFF9oN8/d0VfjLcqzPja4CNP8R/YZSDaMckE
	 ZH0bqEmrVnrwzNpOffaXKi2auN1HcWmmneucpCxjg66a1YUsIrsFGM5EKbo6nTVkTG
	 PrM1T6uTfwMgPcWfjFgHglfy4gV5C3ChyWl5W0AHc/GiqRn4gbeZRGkM1mSzWGfjRX
	 EhxmZZEUILFpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16067407A2;
	Sat, 31 Oct 2026 14:04:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 596891DE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A7EB6061B
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:04:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4cN2Iq7LfGRO for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC20660614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f2d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455471;
 b=cVfp4SfHo5HigJBpUCl94JvFpEngDo82DgmHMhXFG73uaqopncKtnTcKCtvtCwCMh0h1
 wol69dSlVX/DhPfQA7R7UBcLXj0ZZ8SjlNU4BkMWZp021aoeHr4ALntqRdGWkM5J8YUgW
 AYPJwX7AUOWKif6GIp3IxDz+eF6mWiwfurw3VeCrRgmXRCI8Ydtov1joEj6C8aRwCkRfr
 8pGsE6mopLMvmSy5AL7yRMi7gsKPMbaYPZ8hSTWh1tIOy8+qLaFOrperbEbu9q0XH978w
 h9i3vSDiGgQx6o5dngnwxFj3f4FucMitQA+MboPurYzNDNTNIA3ghpKCSITo5LJD34w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455471;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=t+xxcSzsM7h4HEbnAlMG6buuZ1fxZqHezFUsHGcWqLM=;
 b=U9r9sx0KrsmQgr8YxZVZKh5BAmmUapLkICMUr0tukpWgf3DcFlVc/wl61Fx57uwQ3FjE
 9M9w0ucdJt80n3JJBFDkoD5H4iR5+TOUZnW+Hg6LQwHCdVGmJnU6h4UHcMfaz+otwAooS
 r9RN4BYJWbwkizHRO5n3mOgDwD95pL5ypyma4r8dJ4nqTcVcm1oLhy1pmgC9fSuOaj4wQ
 UsJYmbr26GSz6qQl4+qzbgNHRBdtLg7VDfadwZt6DE/O0CSeB4h/Uvm1Dhlzplb/N27nR
 RQZ6nz5QjJ36v5ZLmZDIjDfnHvDhBimgKg4e3+xaAAMUVDDkTVJ5q5YgowEDXs9iAyA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=frs7kjCG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::f2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2d; helo=mail-qv1-xf2d.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=frs7kjCG
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC20660614
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:04:30 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-91c67992ce5so12300016d6.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455469; cv=none;
 d=google.com; s=arc-20260327;
 b=cOuADsskE1G8rPIcXBxrw1DMiIwfm8iyYUAZ+F1fuBdUa0CY0IGLAkUFghpblD6e6H
 V88aELKvxfL/rAsvGSE0l9JHOeHa7gv29a1Mo5nYWN4GgLe/QeorpGI04RopRCDfKh8I
 AaGIIlk54X5J12eZwT2k+Cl5oUVzGStI4rNYvDGgG/9kQ4w+DQduwA7dzryp5n6y836l
 UDJXLKcPcwATuoENJd5fbUlS5YKyJrm05WdtG6lC9FuvOEwxFz/AlZjuSjDgUv8NSE09
 4c1x7y/UXppzBm8KQyf47cdEgwkrQ0pZIwswUwbVr9b0zGkmxeFO0LBRx29kNde4M7HG
 vzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t+xxcSzsM7h4HEbnAlMG6buuZ1fxZqHezFUsHGcWqLM=;
 fh=pgKmFyQKxE3kWjF9BMNo+uQpSesf/4sb2tCQvxjVnfM=;
 b=eI/QPP6Tj9wyurjc5r478rkhUnziOIzfdbWjjpvvzIM6ulufW0GokPqN1ZUXHH6qgc
 vieS6aL3jkvDnyD/QjRvQ9VWIfgrt4ao+CSpjALfJIohvS5A/QEWZGGogcGGZYs0NmGp
 NMplBAgtQcu+vyvgUQ0yxdIVmDdOdwVC6pkfhWkGegCQY0eNjz2C2pX1T/ZKHWeop2Rv
 PcRv8KkkvYu/EuBpb7E2JEpC+NldCSUdS2OIfhEMcyImacIU5UGTkBqUZ92Hqd5WT9hO
 tv9vEZkq9qA6cl65pNmNYL1lqoixAsSwEPNrN8pqXZP4KSuXg8vYVI9WvYLkeHj/syky
 yVcw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793455469; x=1794060269;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t+xxcSzsM7h4HEbnAlMG6buuZ1fxZqHezFUsHGcWqLM=;
 b=frs7kjCGFcXkCkuScJrBiLuz5VY2wMcKLoVJ1Dt4yDwq2x7oWdHKjgVcGR6GAGZwxz
 KrMOVZPS/YazlfGu6OoFbtv4BriRtGMnh572jQ+TjDi4UwKYG9zIKtNJN3tsuLkVzXxn
 lVVQFRhvqUnoLyZiBmrqVUMdhE8a+qkhCk7WnNgeoCRSMoz9GQ8TZVESVw+W8zgACef0
 dK27Y3bGCHfISRgNLOVXuj0NohClkqz7jD4MJsdf/kIp+jS9OqFN9Dsq7y+zEAnAhyEl
 gVNgx3lpoWQkuiGZfWtsPOdxg4J/BmlM3fx1CM8Ue5Zlq0MoX7ck6DLNefbfF/4Yb51Z
 bkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455469; x=1794060269;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t+xxcSzsM7h4HEbnAlMG6buuZ1fxZqHezFUsHGcWqLM=;
 b=vcGJ2fvJqCSg5RrMFM8rFoFu/uc8SBcmEj6jI4mTRwczlbay9OqJWJmn/T9sZYfPxN
 IkxNr5Z0mCTWE2xuHe83ueuBQaMoOYY0RRWzwC/CSFxrYARKcF48XnXaLB/Aee+GRbEp
 VmF1tSMKmeDP37t6x7NcD+HkhAV0H8vqoQLhRa/Y+K11MjOUTVoVv2EaMZRnw/WihAiN
 X9IyXOAwRPmQ/yY5iVHgMXtWHNUrKR6DgHi0KXYxM22NzhPR+OoYiwC0fIymG7gQKl1P
 l4Rs6zN9t7Pjw6MewzHVhVewak4ScdoFR1GIvRD1KfQLAg9evlIMU7/rcGK8c1yt9FgU
 GKcw==
X-Gm-Message-State: AFq9FYI33Hf3Ul46fKrhT12LF3h1eyPgdtpO2SYacM/vW3mC1HepthaI
 dcsRulzYshDo3q1Xeb2wT63PnhPVD8Ipamn/rLFAzmhjN4UXoJ7d3VuRk+cp2Pvpf6Pn0GobDO5
 xNKXUPSjkaprIJLUQkR1F8StSotebMmCjaw==
X-Gm-Gg: AYBFou3Z8kYvDdfmRZVnuIt9unFkzgzK96pWWVw6sFLKGne2C2eW+i5pC4IA1FMGWBz
 enuhxoq1rOJAW5sjRWpPuJtMXGArqTCol3N/lbcEwPjbRjHF7piZiCgciN7YN+8vfU5OeAMEKpe
 5Pk9yvcvlXa4+GTqL9wB8GDZl/kAoSluZA/o7dUvxCswmoenl9/dwe6KhAMhrwfFSVAO8ozjFCP
 awo+z3Smmz9cpejnHHRpJ5edXVGBQOD7h3J36F6AjpBorO7/rxQOYnne66by/9H/AIe3xf8PXEp
 dCMmWjOp3mv55JO/7JdQu1tS/dHM4buaOSdyGuswf7XTmkLaTs4kMCRi9HRDL+pwOe7EaOiaRwv
 JYvWlnLGDH9oNDF7X21Uiug16iCYfBQD/rTc2lpA79z73itWt6gKLC7tGkWt/OwhbuB0sipFQC5
 IsilodXkVVStYE/7WrckR5FMGgTgZqKSAfbavIdaddzlHnYhNY/b3FFHR1SnsHI4Fff+4gdj9Rg
 nt3ilpPohDjySS+bS7wWQQ0ulVOLk0gLLM=
X-Received: by 2002:a05:6214:4606:b0:91c:61e8:f9cb with SMTP id
 6a1803df08f44-91ca4b7893fmr85428696d6.35.1793455468799; Sat, 31 Oct 2026
 07:04:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
 <20261031065006.343477-1-nguyenanhgiau1008@gmail.com>
 <CALeDE9O_BH_GWrkhOdKTPpE-4RFxSZC19G1VA3364t9=iK_GBQ@mail.gmail.com>
 <CAKXvu5h0-cZDbtps1cJgYjHfOmA9=Unv9vWBeWw-iC5hE00Q0Q@mail.gmail.com>
In-Reply-To: <CAKXvu5h0-cZDbtps1cJgYjHfOmA9=Unv9vWBeWw-iC5hE00Q0Q@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 31 Oct 2026 14:04:15 +0000
X-Gm-Features: AclHuK8VzoM5eh7RMQJqZeZlsIb9iyTZE3WZfG7_TXWWN_IAjPd0z9XhyHkm9qU
Message-ID: <CALeDE9NaGFGmxRKkyPKnceUq0N1oxzW7UYLvRa7TmbVSModP=A@mail.gmail.com>
Subject: Re: [PATCH v3] i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller
 driver
To: =?UTF-8?B?R2nDoHUgTmd1eeG7hW4gQW5o?= <nguyenanhgiau1008@gmail.com>
Cc: u-boot@lists.u-boot-project.org, hs@nabladev.com, mbrugger@suse.com, 
 trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 31 Oct 2026 at 11:30, Gi=C3=A0u Nguy=E1=BB=85n Anh
<nguyenanhgiau1008@gmail.com> wrote:
>
> Hi Peter,
>
> Thanks for taking a look and for the heads-up on the defconfig!
>
> To answer your question: I am testing this exclusively on a Raspberry Pi =
4 Model B (BCM2711), as it is the only hardware generation I currently have=
 on hand.
> The specific I2C device I am using for testing is a UPS HAT equipped with=
 an INA219 power monitor/current sensor. I use it to query battery voltage =
and current.
> The new I2C driver handles the read/write transactions with the INA219 se=
nsor flawlessly.
>
> Here is a quick log of the testing procedure from the U-Boot shell:
> =3D> i2c dev 1
> =3D> i2c probe 0x42
> # Prepare calibration and config data in RAM
> =3D> mw.b 0x01000000 0x39 1; mw.b 0x01000001 0x9f 1
> =3D> mw.b 0x01000002 0x10 1; mw.b 0x01000003 0x00 1
> # Write configurations to INA219
> =3D> i2c write 0x01000000 0x42 0.1 2 -s
> =3D> i2c write 0x01000002 0x42 5.1 2 -s
> # Read current register (0x04)
> =3D> i2c read 0x42 4.1 2 0x01000000
>
> Regarding `rpi_arm64_defconfig`: Understood. Would you like me to send a =
v4 to enable CONFIG_SYS_I2C_BCM2835 in `rpi_arm64_defconfig` (and potential=
ly others), or should I wait for you to finish your testing across other Pi=
 generations so I can incorporate all feedback into v4 at once?

Please add it in for the next version, but also split the change to
the configs out to a second patch.

The typical rule of thumb is wait a few days to allow for further
feedback before sending the next revision so we don't end up with lots
of revs.

> Looking forward to your test results.
>
> Best regards,
> Giau Nguyen
> --------------------------------------------------------
> Phone: (+84) 387 915 996
>
>
> On Sat, Oct 31, 2026 at 4:32=E2=80=AFPM Peter Robinson <pbrobinson@gmail.=
com> wrote:
>>
>> Hi Giau,
>>
>> > Mainline U-Boot currently lacks an I2C controller driver for the
>> > Broadcom BCM2711 SoC (Raspberry Pi 4).
>>
>> May I ask what i2c devices you're using to test this on U-Boot and on
>> which generation of device?
>>
>> > This commit adds a new DM-compliant I2C driver for Broadcom
>> > BCM2835/BCM2711 SoCs based on the Linux kernel's i2c-bcm2835.c.
>> > (based on Linux commit 32a0a94aa09e ("i2c: Switch back to struct platf=
orm_driver::remove()")).
>> >
>> > The driver dynamically queries the actual VPU core clock rate from
>> > the VideoCore firmware via mailbox property messages to calculate
>> > the CDIV clock divider, ensuring accurate I2C timing and baud rates
>> > on BCM2711.
>> >
>> > Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
>>
>> Typically the main config used is rpi_arm64_defconfig which covers all
>> 64bit capable generations (3/4/5/Zero2).
>>
>> I'll test/review in the next few days for a RP
>>
>> > Reviewed-by: Heiko Schocher <hs@nabladev.com>
>> > Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
>> > ---
>> > v3:
>> >  - Added the Linux commit ID to the commit message.
>> >  - Fixed alphabetical sorting of CONFIG_SYS_I2C_BCM2835 in drivers/i2c=
/Makefile.
>> >  - Added Reviewed-by tag from Heiko.
>> >
>> > v2:
>> >  - Clarified commit message: U-Boot mainline currently lacks BCM2711 I=
2C driver.
>> >  - Fixed line endings and code formatting per checkpatch.pl.
>> >  - Converted register offsets to 'struct bcm2835_i2c_regs' abstraction=
.
>> >  - Removed 'bcm2835_i2c_readl/writel' wrappers in favor of standard re=
adl/writel.
>> >  - Moved mailbox clock querying to bcm2835_get_clock_rate() in mach-bc=
m283x.
>> >  - Enabled CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
>> >  - Sorted drivers/i2c/Kconfig and Makefile alphabetically.
>> >  - Removed 'Assisted by AI' tag.
>> >
>> >  MAINTAINERS                              |   1 +
>> >  arch/arm/mach-bcm283x/include/mach/msg.h |   9 +
>> >  arch/arm/mach-bcm283x/msg.c              |  22 ++
>> >  configs/rpi_4_defconfig                  |   4 +
>> >  drivers/i2c/Kconfig                      |  10 +
>> >  drivers/i2c/Makefile                     |   1 +
>> >  drivers/i2c/i2c-bcm2835.c                | 370 ++++++++++++++++++++++=
+
>> >  7 files changed, 417 insertions(+)
>> >  create mode 100644 drivers/i2c/i2c-bcm2835.c
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 8c6c0c2a4bc..3260024a736 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -215,6 +215,7 @@ F:  arch/arm/dts/bcm283*
>> >  F:     arch/arm/mach-bcm283x/
>> >  F:     board/raspberrypi/
>> >  F:     drivers/gpio/bcm2835_gpio.c
>> > +F:     drivers/i2c/i2c-bcm2835.c
>> >  F:     drivers/mmc/bcm2835_sdhci.c
>> >  F:     drivers/mmc/bcm2835_sdhost.c
>> >  F:     drivers/serial/serial_bcm283x_mu.c
>> > diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h b/arch/arm/mach-=
bcm283x/include/mach/msg.h
>> > index e54da86e353..d6adec07ae2 100644
>> > --- a/arch/arm/mach-bcm283x/include/mach/msg.h
>> > +++ b/arch/arm/mach-bcm283x/include/mach/msg.h
>> > @@ -22,6 +22,15 @@ int bcm2835_power_on_module(u32 module);
>> >   */
>> >  int bcm2835_get_mmc_clock(u32 clock_id);
>> >
>> > +/**
>> > + * bcm2835_get_clock_rate() - get the current rate of a clock
>> > + *
>> > + * @clock_id: ID of clock to get frequency for (BCM2835_MBOX_CLOCK_ID=
_...)
>> > + * @rate: Returns the clock rate in Hz
>> > + * Return: 0 if OK, -EIO or -EINVAL on error
>> > + */
>> > +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);
>> > +
>> >  /**
>> >   * bcm2835_set_sdhost_clock() - determine if firmware controls sdhost=
 cdiv
>> >   *
>> > diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
>> > index 4993c0bdb81..74f847c5e54 100644
>> > --- a/arch/arm/mach-bcm283x/msg.c
>> > +++ b/arch/arm/mach-bcm283x/msg.c
>> > @@ -115,6 +115,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)
>> >         return clock_rate;
>> >  }
>> >
>> > +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)
>> > +{
>> > +       ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1=
);
>> > +       int ret;
>> > +
>> > +       BCM2835_MBOX_INIT_HDR(msg_clk);
>> > +       BCM2835_MBOX_INIT_TAG(&msg_clk->get_clock_rate, GET_CLOCK_RATE=
);
>> > +       msg_clk->get_clock_rate.body.req.clock_id =3D clock_id;
>> > +
>> > +       ret =3D bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN, &msg_cl=
k->hdr);
>> > +       if (ret) {
>> > +               printf("bcm2835: Could not query clock rate for %u\n",=
 clock_id);
>> > +               return -EIO;
>> > +       }
>> > +
>> > +       *rate =3D msg_clk->get_clock_rate.body.resp.rate_hz;
>> > +       if (!*rate)
>> > +               return -EINVAL;
>> > +
>> > +       return 0;
>> > +}
>> > +
>> >  int bcm2835_set_sdhost_clock(u32 rate_hz, u32 *rate_1, u32 *rate_2)
>> >  {
>> >         ALLOC_CACHE_ALIGN_BUFFER(struct msg_set_sdhost_clock, msg_sdho=
st_clk, 1);
>> > diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
>> > index f5fb322aa8f..2ddaf003558 100644
>> > --- a/configs/rpi_4_defconfig
>> > +++ b/configs/rpi_4_defconfig
>> > @@ -22,6 +22,7 @@ CONFIG_MISC_INIT_R=3Dy
>> >  CONFIG_SYS_PROMPT=3D"U-Boot> "
>> >  CONFIG_CMD_DFU=3Dy
>> >  CONFIG_CMD_GPIO=3Dy
>> > +CONFIG_CMD_I2C=3Dy
>> >  CONFIG_CMD_MMC=3Dy
>> >  CONFIG_CMD_PCI=3Dy
>> >  CONFIG_CMD_USB=3Dy
>> > @@ -34,6 +35,9 @@ CONFIG_DM_DMA=3Dy
>> >  CONFIG_DFU_MMC=3Dy
>> >  CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x100000
>> >  CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x200000
>> > +CONFIG_I2C=3Dy
>> > +CONFIG_DM_I2C=3Dy
>> > +CONFIG_SYS_I2C_BCM2835=3Dy
>> >  CONFIG_BCM2835_GPIO=3Dy
>> >  CONFIG_MMC_SDHCI=3Dy
>> >  CONFIG_MMC_SDHCI_SDMA=3Dy
>> > diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
>> > index 52067fa7c1f..1b26906e403 100644
>> > --- a/drivers/i2c/Kconfig
>> > +++ b/drivers/i2c/Kconfig
>> > @@ -164,6 +164,16 @@ config SYS_I2C_AT91
>> >           i2c-gpio driver unless your system can cope with this limita=
tion.
>> >           Binding info: doc/device-tree-bindings/i2c/i2c-at91.txt
>> >
>> > +config SYS_I2C_BCM2835
>> > +       bool "BCM2835 I2C controller"
>> > +       depends on DM_I2C
>> > +       help
>> > +         Enable support for the Broadcom BCM2835/BCM2711 I2C controll=
er.
>> > +         This driver provides standard I2C support for Raspberry Pi
>> > +         devices, including the newer Raspberry Pi 4. It dynamically
>> > +         calculates the clock divider based on the VPU core clock
>> > +         queried via the firmware mailbox.
>> > +
>> >  config SYS_I2C_IPROC
>> >         bool "Broadcom I2C driver"
>> >         depends on DM_I2C
>> > diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
>> > index bebd728e7da..aac6ce4b6e0 100644
>> > --- a/drivers/i2c/Makefile
>> > +++ b/drivers/i2c/Makefile
>> > @@ -14,6 +14,7 @@ obj-$(CONFIG_$(XPL_)SYS_I2C_LEGACY) +=3D i2c_core.o
>> >  obj-$(CONFIG_SYS_I2C_ASPEED) +=3D ast_i2c.o
>> >  obj-$(CONFIG_SYS_I2C_AST2600) +=3D ast2600_i2c.o
>> >  obj-$(CONFIG_SYS_I2C_AT91) +=3D at91_i2c.o
>> > +obj-$(CONFIG_SYS_I2C_BCM2835) +=3D i2c-bcm2835.o
>> >  obj-$(CONFIG_SYS_I2C_CADENCE) +=3D i2c-cdns.o
>> >  obj-$(CONFIG_SYS_I2C_CA) +=3D i2c-cortina.o
>> >  obj-$(CONFIG_SYS_I2C_DAVINCI) +=3D davinci_i2c.o
>> > diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
>> > new file mode 100644
>> > index 00000000000..e6abb076bdb
>> > --- /dev/null
>> > +++ b/drivers/i2c/i2c-bcm2835.c
>> > @@ -0,0 +1,370 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/*
>> > + * BCM2835 I2C controller driver
>> > + * (C) Copyright 2026
>> > + *
>> > + * Author: Giau Nguyen <nguyenanhgiau1008@gmail.com>
>> > + * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c
>> > + */
>> > +
>> > +#include <log.h>
>> > +#include <asm/io.h>
>> > +#include <asm/arch/mbox.h>
>> > +#include <asm/arch/msg.h>
>> > +#include <dm.h>
>> > +#include <dm/device_compat.h>
>> > +#include <i2c.h>
>> > +#include <time.h>
>> > +#include <linux/bitops.h>
>> > +#include <linux/delay.h>
>> > +#include <linux/err.h>
>> > +#include <linux/kernel.h>
>> > +#include <linux/types.h>
>> > +
>> > +#define BCM2835_I2C_C_READ     BIT(0)
>> > +#define BCM2835_I2C_C_CLEAR    BIT(4) /* bits 4 and 5 both clear */
>> > +#define BCM2835_I2C_C_ST       BIT(7)
>> > +#define BCM2835_I2C_C_INTD     BIT(8)
>> > +#define BCM2835_I2C_C_INTT     BIT(9)
>> > +#define BCM2835_I2C_C_INTR     BIT(10)
>> > +#define BCM2835_I2C_C_I2CEN    BIT(15)
>> > +
>> > +#define BCM2835_I2C_S_TA       BIT(0)
>> > +#define BCM2835_I2C_S_DONE     BIT(1)
>> > +#define BCM2835_I2C_S_TXW      BIT(2)
>> > +#define BCM2835_I2C_S_RXR      BIT(3)
>> > +#define BCM2835_I2C_S_TXD      BIT(4)
>> > +#define BCM2835_I2C_S_RXD      BIT(5)
>> > +#define BCM2835_I2C_S_TXE      BIT(6)
>> > +#define BCM2835_I2C_S_RXF      BIT(7)
>> > +#define BCM2835_I2C_S_ERR      BIT(8)
>> > +#define BCM2835_I2C_S_CLKT     BIT(9)
>> > +#define BCM2835_I2C_S_LEN      BIT(10) /* Fake bit for SW error repor=
ting */
>> > +
>> > +#define BCM2835_I2C_FEDL_SHIFT 16
>> > +#define BCM2835_I2C_REDL_SHIFT 0
>> > +
>> > +#define BCM2835_I2C_CDIV_MIN   0x0002
>> > +#define BCM2835_I2C_CDIV_MAX   0xFFFE
>> > +
>> > +#define BCM2835_I2C_CLKT_TOUT_MS 35
>> > +#define BCM2835_I2C_XFER_TIMEOUT_MS 1000
>> > +
>> > +struct bcm2835_i2c_regs {
>> > +       u32 c;
>> > +       u32 s;
>> > +       u32 dlen;
>> > +       u32 a;
>> > +       u32 fifo;
>> > +       u32 div;
>> > +       u32 del;
>> > +       u32 clkt;
>> > +};
>> > +
>> > +struct bcm2835_i2c_priv {
>> > +       struct bcm2835_i2c_regs __iomem *regs;
>> > +       ulong input_rate;
>> > +       size_t msg_buf_remaining;
>> > +       u8 *msg_buf;
>> > +       struct i2c_msg *curr_msg;
>> > +       int msg_err;
>> > +       int num_msgs;
>> > +};
>> > +
>> > +static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)
>> > +{
>> > +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
>> > +
>> > +       while (i2c_dev->msg_buf_remaining) {
>> > +               if (!(readl(&regs->s) & BCM2835_I2C_S_TXD))
>> > +                       break;
>> > +
>> > +               writel(*i2c_dev->msg_buf, &regs->fifo);
>> > +               i2c_dev->msg_buf++;
>> > +               i2c_dev->msg_buf_remaining--;
>> > +       }
>> > +}
>> > +
>> > +static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)
>> > +{
>> > +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
>> > +
>> > +       while (i2c_dev->msg_buf_remaining) {
>> > +               if (!(readl(&regs->s) & BCM2835_I2C_S_RXD))
>> > +                       break;
>> > +
>> > +               *i2c_dev->msg_buf =3D readl(&regs->fifo);
>> > +               i2c_dev->msg_buf++;
>> > +               i2c_dev->msg_buf_remaining--;
>> > +       }
>> > +}
>> > +
>> > +static int bcm2835_i2c_calc_divider(unsigned long rate,
>> > +                                   unsigned long parent_rate)
>> > +{
>> > +       int divider =3D DIV_ROUND_UP(parent_rate, rate);
>> > +
>> > +       /*
>> > +        * Per the datasheet, the register is always interpreted as an=
 even
>> > +        * number, by rounding down. In other words, the LSB is ignore=
d. So,
>> > +        * if the LSB is set, increment the divider to avoid any issue=
.
>> > +        */
>> > +       if (divider & 1)
>> > +               divider++;
>> > +
>> > +       if (divider < BCM2835_I2C_CDIV_MIN ||
>> > +           divider > BCM2835_I2C_CDIV_MAX)
>> > +               return -EINVAL;
>> > +
>> > +       return divider;
>> > +}
>> > +
>> > +static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rat=
e)
>> > +{
>> > +       struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv(bus);
>> > +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
>> > +       ulong parent_rate =3D i2c_dev->input_rate;
>> > +       u32 redl, fedl;
>> > +       u32 clk_tout;
>> > +       int divider;
>> > +
>> > +       if (!rate || !parent_rate)
>> > +               return -EINVAL;
>> > +
>> > +       divider =3D bcm2835_i2c_calc_divider(rate, parent_rate);
>> > +       if (divider < 0)
>> > +               return divider;
>> > +
>> > +       writel(divider, &regs->div);
>> > +
>> > +       /*
>> > +        * Number of core clocks to wait after falling edge before
>> > +        * outputting the next data bit. Note that both FEDL and REDL
>> > +        * can't be greater than CDIV/2.
>> > +        */
>> > +       fedl =3D max_t(u32, divider / 16, 1);
>> > +
>> > +       /*
>> > +        * Number of core clocks to wait after rising edge before
>> > +        * sampling the next incoming data bit.
>> > +        */
>> > +       redl =3D max_t(u32, divider / 4, 1);
>> > +
>> > +       writel((fedl << BCM2835_I2C_FEDL_SHIFT) |
>> > +              (redl << BCM2835_I2C_REDL_SHIFT), &regs->del);
>> > +
>> > +       /*
>> > +        * Set the clock stretch timeout.
>> > +        */
>> > +       if (rate > 0xffff * 1000 / BCM2835_I2C_CLKT_TOUT_MS)
>> > +               clk_tout =3D 0xffff;
>> > +       else
>> > +               clk_tout =3D BCM2835_I2C_CLKT_TOUT_MS * rate / 1000;
>> > +
>> > +       writel(clk_tout, &regs->clkt);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_d=
ev)
>> > +{
>> > +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
>> > +       u32 c =3D BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
>> > +       struct i2c_msg *msg =3D i2c_dev->curr_msg;
>> > +       bool last_msg =3D (i2c_dev->num_msgs =3D=3D 1);
>> > +
>> > +       if (!i2c_dev->num_msgs)
>> > +               return;
>> > +
>> > +       i2c_dev->num_msgs--;
>> > +       i2c_dev->msg_buf =3D msg->buf;
>> > +       i2c_dev->msg_buf_remaining =3D msg->len;
>> > +
>> > +       if (msg->flags & I2C_M_RD)
>> > +               c |=3D BCM2835_I2C_C_READ;
>> > +       else
>> > +               c |=3D BCM2835_I2C_C_INTT;
>> > +
>> > +       if (last_msg)
>> > +               c |=3D BCM2835_I2C_C_INTD;
>> > +
>> > +       writel(msg->addr, &regs->a);
>> > +       writel(msg->len, &regs->dlen);
>> > +       writel(c, &regs->c);
>> > +}
>> > +
>> > +static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv *i2c_=
dev)
>> > +{
>> > +       i2c_dev->curr_msg =3D NULL;
>> > +       i2c_dev->num_msgs =3D 0;
>> > +       i2c_dev->msg_buf =3D NULL;
>> > +       i2c_dev->msg_buf_remaining =3D 0;
>> > +}
>> > +
>> > +static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs=
, int count)
>> > +{
>> > +       struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv(dev);
>> > +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
>> > +       bool ignore_nak =3D false;
>> > +       bool done =3D false;
>> > +       ulong start;
>> > +       int i;
>> > +       u32 val, err;
>> > +       int ret =3D 0;
>> > +
>> > +       if (!msgs || count <=3D 0)
>> > +               return -EINVAL;
>> > +
>> > +       for (i =3D 0; i < count; i++) {
>> > +               if (msgs[i].flags & I2C_M_TEN)
>> > +                       return -EOPNOTSUPP;
>> > +               if (msgs[i].flags & I2C_M_RD) {
>> > +                       if (i < count - 1) {
>> > +                               dev_err(dev, "read message must be las=
t\n");
>> > +                               return -EOPNOTSUPP;
>> > +                       }
>> > +               }
>> > +               if (msgs[i].len > 0xffff)
>> > +                       return -EINVAL;
>> > +               if (msgs[i].flags & I2C_M_IGNORE_NAK)
>> > +                       ignore_nak =3D true;
>> > +       }
>> > +
>> > +       /* Clear stale status and FIFO state before starting a new tra=
nsaction. */
>> > +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
>> > +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_=
DONE,
>> > +              &regs->s);
>> > +
>> > +       i2c_dev->curr_msg =3D msgs;
>> > +       i2c_dev->num_msgs =3D count;
>> > +       i2c_dev->msg_err =3D 0;
>> > +
>> > +       bcm2835_i2c_start_transfer(i2c_dev);
>> > +       start =3D get_timer(0);
>> > +       while (get_timer(start) < BCM2835_I2C_XFER_TIMEOUT_MS) {
>> > +               val =3D readl(&regs->s);
>> > +
>> > +               err =3D val & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR)=
;
>> > +               if (err && !(val & BCM2835_I2C_S_TA))
>> > +                       i2c_dev->msg_err =3D err;
>> > +
>> > +               if (val & BCM2835_I2C_S_DONE) {
>> > +                       if (!i2c_dev->curr_msg) {
>> > +                               dev_err(dev, "unexpected completion st=
atus\n");
>> > +                       } else if (i2c_dev->curr_msg->flags & I2C_M_RD=
) {
>> > +                               bcm2835_drain_rxfifo(i2c_dev);
>> > +                               val =3D readl(&regs->s);
>> > +                       }
>> > +
>> > +                       if ((val & BCM2835_I2C_S_RXD) ||
>> > +                           i2c_dev->msg_buf_remaining)
>> > +                               i2c_dev->msg_err =3D BCM2835_I2C_S_LEN=
;
>> > +                       done =3D true;
>> > +                       break;
>> > +               }
>> > +
>> > +               if (val & BCM2835_I2C_S_TXW) {
>> > +                       if (!i2c_dev->msg_buf_remaining) {
>> > +                               i2c_dev->msg_err =3D val | BCM2835_I2C=
_S_LEN;
>> > +                               break;
>> > +                       }
>> > +
>> > +                       bcm2835_fill_txfifo(i2c_dev);
>> > +
>> > +                       if (i2c_dev->num_msgs > 0 && !i2c_dev->msg_buf=
_remaining) {
>> > +                               i2c_dev->curr_msg++;
>> > +                               bcm2835_i2c_start_transfer(i2c_dev);
>> > +                       }
>> > +               }
>> > +
>> > +               if (val & BCM2835_I2C_S_RXR) {
>> > +                       if (!i2c_dev->msg_buf_remaining) {
>> > +                               i2c_dev->msg_err =3D val | BCM2835_I2C=
_S_LEN;
>> > +                               break;
>> > +                       }
>> > +
>> > +                       bcm2835_drain_rxfifo(i2c_dev);
>> > +               }
>> > +               udelay(1);
>> > +       }
>> > +
>> > +       if (!done) {
>> > +               val =3D readl(&regs->s);
>> > +               dev_err(dev, "transfer timeout: status=3D%08x remainin=
g=3D%zu\n",
>> > +                       val, i2c_dev->msg_buf_remaining);
>> > +               ret =3D -ETIMEDOUT;
>> > +       }
>> > +
>> > +       /* Always abort/reset the controller and clear W1C status bits=
. */
>> > +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
>> > +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_=
DONE,
>> > +              &regs->s);
>> > +
>> > +       bcm2835_i2c_finish_transfer(i2c_dev);
>> > +       if (ret)
>> > +               return ret;
>> > +
>> > +       if (ignore_nak)
>> > +               i2c_dev->msg_err &=3D ~BCM2835_I2C_S_ERR;
>> > +
>> > +       if (!i2c_dev->msg_err)
>> > +               return 0;
>> > +
>> > +       if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
>> > +               return -EREMOTEIO;
>> > +
>> > +       return -EIO;
>> > +}
>> > +
>> > +static const struct dm_i2c_ops bcm2835_i2c_ops =3D {
>> > +       .xfer          =3D bcm2835_i2c_xfer,
>> > +       .set_bus_speed =3D bcm2835_i2c_set_rate,
>> > +};
>> > +
>> > +static const struct udevice_id bcm2835_i2c_ids[] =3D {
>> > +       {.compatible =3D "brcm,bcm2711-i2c"},
>> > +       {.compatible =3D "brcm,bcm2835-i2c"},
>> > +       {}
>> > +};
>> > +
>> > +static int bcm2835_i2c_probe(struct udevice *bus)
>> > +{
>> > +       struct bcm2835_i2c_priv *priv =3D dev_get_priv(bus);
>> > +       struct bcm2835_i2c_regs __iomem *regs;
>> > +       unsigned int bus_clk_rate;
>> > +       int ret;
>> > +
>> > +       priv->regs =3D dev_read_addr_ptr(bus);
>> > +       if (!priv->regs) {
>> > +               printf("bcm2835_i2c: cannot get base address\n");
>> > +               return -EINVAL;
>> > +       }
>> > +
>> > +       regs =3D priv->regs;
>> > +
>> > +       ret =3D bcm2835_get_clock_rate(BCM2835_MBOX_CLOCK_ID_CORE, &pr=
iv->input_rate);
>> > +       if (ret)
>> > +               return ret;
>> > +
>> > +       bus_clk_rate =3D dev_read_u32_default(bus, "clock-frequency",
>> > +                                           I2C_SPEED_STANDARD_RATE);
>> > +       ret =3D bcm2835_i2c_set_rate(bus, bus_clk_rate);
>> > +       if (ret)
>> > +               return ret;
>> > +
>> > +       /* clear FIFO + status */
>> > +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
>> > +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_=
DONE,
>> > +              &regs->s);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +U_BOOT_DRIVER(bcm2835_i2c) =3D {
>> > +       .name       =3D "bcm2835_i2c",
>> > +       .id         =3D UCLASS_I2C,
>> > +       .of_match   =3D bcm2835_i2c_ids,
>> > +       .probe      =3D bcm2835_i2c_probe,
>> > +       .priv_auto  =3D sizeof(struct bcm2835_i2c_priv),
>> > +       .ops        =3D &bcm2835_i2c_ops,
>> > +};
>> > --
>> > 2.34.1
>> >
