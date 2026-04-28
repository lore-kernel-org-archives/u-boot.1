Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D99FFF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 13:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D9F84150;
	Tue, 28 Apr 2026 15:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eX1WZKwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B01584255; Tue, 28 Apr 2026 15:59:43 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD0E584119
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-671ae79e617so14700502a12.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777384779; cv=none;
 d=google.com; s=arc-20240605;
 b=RDRPwy1dySd8sBlk+rmhNvF/zY5i4e0PC0DHfuzk8LkIPcakFLpXG419ON5+0R2vR/
 IQRbw7NYdoIqjp+gfSC1Q3jbh+Y4YLXNBjE7AFOU/Dzm8Nl7MHbtD4lLsTC3KRmFR7iD
 Uq+HNvQbW5eSACUGQ2sVIFJScPYrSpJFbauD95fSG4Ou9NajO0tvYehBP7SLcl4/keLl
 kAqSakwws0KMWL9U3YltjX+aLEzqd4mK2vpAAFDLOtD7EsIs/wIdXvAUM2nbEP5WKHiD
 uoU6+Bi3RjLMNAUwtAba3gzhaAGLxLksM3m4ZZft0pn/5uzHq7Pb/1BqnhKNBeh8A4uE
 M0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IeClgwuc2ejmQVQeGTDuKLXRISVd1EVBBjfdIl2bhi0=;
 fh=WJrT4so2P2TQNu7RsbFk17g04p7+9AUNy/luZnGNCxM=;
 b=QW3rigQ2l4sbN+vFZ3QZb7XDgX7AKwEcealqG3vN1KzvvhLkvS7oBhwF0yNHaqMguk
 KV06uo0Qq7sPDq4WAZB0zHt6nfXGNVvGOGv8+cCMdGOB3Rf8U+pGN7VFkiXtT1RkXl7/
 e9g+QcgpMJpuUa2KQc0ys1VBzgF1znZ4m3iwbMn81mknJykSSsK874LIiHowL5unmud4
 53wEj/E+6669SHH2E/bViI1aRlxz1cNXRRHVMrYHq83ZwrXtZKvKfUvYbKRBqIRhu3Au
 TCC8lv2j50qlB/IkWGovrJ4mdtS2HXfQMUV07jfSlXTvskTMyGkZxA1oF3+K1/XQdrrN
 KE+g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777384779; x=1777989579; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IeClgwuc2ejmQVQeGTDuKLXRISVd1EVBBjfdIl2bhi0=;
 b=eX1WZKwH4yHdcix66/kUEoCa3fIESviYZhE2PczVsMf8SL3JW93R+viTp6uAhzkdN6
 crVb/aawNjCkpKB545u54aMYpwBLseY+Cwz7Yj+YdTRK6qpzoJc8x0YAdsMjRfcQDBX+
 U4h15wmRSoqIkILKvwciLU2ZtTXwi0096DIjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777384779; x=1777989579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeClgwuc2ejmQVQeGTDuKLXRISVd1EVBBjfdIl2bhi0=;
 b=V1MS1BCtH6/y6Tg5nAQQ3b8Ve8NdsYh+UbF/E20PPg7b3T6K4rPM4EWoWi4MsdxC+8
 ZNcordZpKKMgZAQH4rhe8vG4CKZbvINHoobMYVsQM5LqkhfQyZSiLdwrpaPpOfsIrP5b
 bxSfc7ZwMp7BqeKaKzZYp4fDhiQrDKdZ0/hbZ3VgTEbximQwUShy0NJjul64mIhdvZ7W
 NHHy33iHfdEnh/PCaeqQalN0hgzG9nay5o9WAEUMHvlj06hV+qadq7IE4SL/R9f4xsZl
 EuUO/51E4qiIrZa3yImxAdNZl6d97Y4Dd5IyzuHDqq2x1qtYUvdHHkLELD0oPBE6qvTe
 O1sg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0147R6lydhXCQkAv9iMMzTJ/y1W/C06y3Bw4Ex/LRulR0OqbJkAtvGxI2uPPy98pLGpvBbbA=@lists.denx.de
X-Gm-Message-State: AOJu0YxsV0vaBEV5akNaRK1vSNfS3SDim9AL2tDsmVgwlIRfOevXiko+
 cEM0mjJB2c6L2fr1aajPM36jSmeC0e41lmbeIzgfAV4guMIhw6IBci+z3oPbZM3DgZTsj+wVb4w
 J5+oai/VBAMI68qcK/75n5mMJA1z1a5yMknmW8Oci
X-Gm-Gg: AeBDiet0ux5o3fbFueyAIEAyC8GP5Ltd1hhJvQaLOWcEMLsSSYXxfkYKg/SCfDkEtFF
 1FYNEyB0uHABTldY6YWTqdaErnQEZVempWw3OY4FowFvww6zCfSFAiSQ9jQxt9Wp/APoDNja5Ua
 qhxJIiul0LoNybMs+FwJ2uerp8iwCI5A9C4+vIqD2n0IKjQA8Ik5PkCNKp00dB2bGxNjbC8Kt+t
 lhemvULzwnpV7NFR005NcGb4biId6LAnrIbLbBzmxt8kKaGXG2laptHQpy4DrKN1NLoSsV1ixm5
 Af9vi77zJpqPhrmO
X-Received: by 2002:a17:907:7256:b0:bab:e742:aba with SMTP id
 a640c23a62f3a-bb804e229ebmr201776566b.42.1777384779001; Tue, 28 Apr 2026
 06:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <DI3DOZXB8ES4.12PBN3MVHW911@archcloudlabs.com>
In-Reply-To: <DI3DOZXB8ES4.12PBN3MVHW911@archcloudlabs.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 07:59:25 -0600
X-Gm-Features: AVHnY4JR_lOQcpqXzH9LJDmCsZ9qeYH1LbUsBdpkIa9mq0UG0ZOad-GqIchDg2c
Message-ID: <CAFLszTg4YXgn3-=Lr55h9GLiicAZ_63EOCzoQ_t6p6+YTDEA8w@mail.gmail.com>
Subject: Re: [PATCH] fs/squashfs fix overflow in sqfs_find_inode()
To: dllcoolj@archcloudlabs.com
Cc: trini@konsulko.com, joaomarcos.costa@bootlin.com, 
 richard.genoud@bootlin.com, thomas.petazzoni@bootlin.com, 
 miquel.raynal@bootlin.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Jared,

On 2026-04-26T20:45:15, Jared Stroud <dllcoolj@archcloudlabs.com> wrote:
> adding overflow check for offset calculation
>
> Signed-off-by: Jared Stroud <dllcoolj@archcloudlabs.com>
>
> fs/squashfs/sqfs_inode.c | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
> @@ -135,6 +135,9 @@ void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
>               if (sz < 0)
>                       return NULL;
>
> +             if (__builtin_add_overflow(offset, sz, &offset))
> +                     return NULL;
> +
>               offset += sz;
>       }

This double-adds sz. __builtin_add_overflow() already stores offset +
sz into offset on success, then the existing offset += sz adds it
again, so every successful iteration walks twice as far through the
inode table. Either drop the trailing offset += sz, or use a temporary
destination and assign on success.

The three new lines also have a leading space before the tab please
run patman or checkpatch to check the patch.

Please use a subsystem prefix and imperative mood on the subject, e.g.
'fs: squashfs: Add overflow check in sqfs_find_inode()', and add a
short body explaining what input triggers the overflow and the
consequence without the check. A Fixes: tag pointing at the original
commit would help too.

Just to check, is there a reproducer (e.g. a crafted squashfs image)
you can mention?

Regards,
Simon
