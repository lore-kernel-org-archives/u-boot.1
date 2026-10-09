Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959F9CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA1A781371;
	Fri,  9 Oct 2026 07:03:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t8nDsbd2LK_8; Fri,  9 Oct 2026 07:03:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 81939810D2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529391;
	b=dpFQWnpN2tf9N0ojgPAsudHlftjIocvFTvcs5CgiUEtYfIGHdHb2lADJqDMu258/MN/L
	 DycEx2Jp2rsawzDRKMLalOhZhOaLtAHGsF5wbmF0TBGOK4KM+IrzAie8FPgYO6C/ySdHB
	 se40KCbeGsMcNznVHR1PQPxvjVV9MZwNHZ9I5HLJXXZjsQVcY2vVPxPGPYvPUN2kmcZyy
	 6NNvn+JnmxWihTe/AkX9sSR7hKV+Sp64nGSYFHi1SZGNXScqppp5uWK9gIz2jyYGT5F1x
	 eb+gTE9iM0v/sKjvv2eGlHCRE1G637IAeqaiPZjb3+AEu1BqwbUXnMUhobsyuHjcqkw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791529391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VJ4Be7AlVUowmNdcUrYxZ+qIyTIMPTbyFPRN+uTQIbQ=;
	b=hJeCnIbe/zH4/e0FHGqodrQM5ytdiO4/Tqbj0RW6MYxYK/s/gJSaL0zoJV3M6iAtTw8Y
	 HDvlE2ZHVNBuE8UfL64hvjczqEu4CU5e67xzqYSAp34qzCVD4q5qKJVZvtLCPkqwL46PV
	 9sMvfU8ISrLj/xYnOdJUR2QgQ5/T6mhuCzKSiXWgFFKCMSAABG3EBPYkcbS+yuKCQGFDF
	 vxTK4hMIdMOrO9S2hbs6qPplcqlgSTuqou3W+GvhtVB1yJxs6wM2D0VVlhak/J5GcsRU1
	 NUovI8tl4lE3Qo4HZ+oKEKrnH/QrBNyHaAmLwktPMCRj2CczkBMKomo+XgCviGOsRtA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FYfcE8ip;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791529391;
	bh=VJ4Be7AlVUowmNdcUrYxZ+qIyTIMPTbyFPRN+uTQIbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IGvQKtNd33pkUm7cPj4GUGt9zktdquuoTr1TYJg/zrPP2EokwfjSmuoCEm7xmbd2k
	 jlPKZXa4NvHGsy0lFfJlyZDokR+qz4oLbr+S1jftOm8ol1JJx5Y8Obnlrs0LhQYHgz
	 jXX3fW6oEFY2gDo6OYLl3SF/WptGFF+dq8C1XZydnJezGe0mr4k79QvEbNPNdYbAhn
	 IREonUslXK7TW5DL1irek5gqr0y5O6c743US3+Uu6W8pSvg0IBJukMCtltBFoAbuke
	 wztW788B3Da8A5j/XcseFqCXRxSY/YP34/F5P/yds5KHpuXwWgQPxkwmMXcmLWg57c
	 QU8dElGpvdYkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81939810D2;
	Fri,  9 Oct 2026 07:03:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 381F92E0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E32F810D2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:03:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IrK71NEQWaJX for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:03:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 20AC880D21
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529389;
 b=taUQ6E8EcnSXM75ihYZL+65arPJfqdsjiNquonoIq/kj6dW94oQt6Dg8/C9s8rEfKbwi
 9bQFATnDLS3BP22eHBeQgeH2WL2V50z2U9mjzNp2JlK4YIXHRzUEU4nRkTJPJu/Q3C167
 kq1PVfNSv/1pTSRELEp4Jk6PgEya+/TkWL7U3bpefsJcd4ueO4KMBHe93Xee69j6+U5ep
 cIPZ12IlwpvnS5CVhqwqTipZEAPD72b6PfuLOVlTojOqYaFMOIVXLgUf5A25rKf8n8jMt
 xgaH9I/on5HXT4cj6agaYDeRbocSg8a+6jM04M/TL/6kBf+spo72G1KKaLI+EBupBdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791529389;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=VJ4Be7AlVUowmNdcUrYxZ+qIyTIMPTbyFPRN+uTQIbQ=;
 b=ETA4JsRIZcjhQPrZe4LocNUe0hWITBswYVqjjVas7BjEfPVGMo3NJXDB27DQqav2zrxP
 dDYpPLZ/R6Ul2TLyNwOOFcWzmaLXDdlpGTWBFUpgpeHfw6+YDvHFF8GNGSKaePyYbYuH5
 GOXNqgzFqhpd+pf8lnVIZinZSPQNaNmB2EC2JsWhtR5rGKlTObon8E5FjxH3tZq+Dw0Te
 bFZhIlseGchwdsbfyXjLE9X56DEpmy48BwAu+nUj7yx4txS+0Jv+1hJX9tZcoA2fkpOOj
 OdRBww1xzR+JELXvLBcdQX/U6EQz4R3sKRLzgq7sw97OPcuXKrf9g3IVfIUTyl1HYYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FYfcE8ip; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FYfcE8ip
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20AC880D21
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:03:08 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6afa651700eso5889709a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 00:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791529387; cv=none;
 d=google.com; s=arc-20260327;
 b=eqYIOvmrmLXYTiz1QDSdlck2eoUcEQA1CV81asI12BlRW9kk8L4FExzN8KWlC6k9pD
 VC6GbXF8yOFp4msX83PE1pL+jHsey6NkQH4WBB2YE4R3P3/mxGMUINfccfPG63n6R2PF
 hRFEiQbxejLSDuggOMd7MpZn+uQ6WGX2o8bI4VsFAg6q9M14eBhfbC/dF4KJVr5B0R/l
 r/j8FQZoAHAFZv0DPyLcQR//9X1BwmkTXHa3YAYileeBkYkvVAum9Du2L4YWDfzMsvC+
 vLkaVksM4hJpK/rt5ElZyNXtGRr77NFRomcZJZemG1PLljuZOnUJJpV5rQR6wea+g6vz
 Ko4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VJ4Be7AlVUowmNdcUrYxZ+qIyTIMPTbyFPRN+uTQIbQ=;
 fh=KO+N9rDVG8oED9imVwAtmElOU+C+d9ci/tu6TAhBpYs=;
 b=Z+nenq+vYmfRrXd13JFgW8rK6jEJLQVVLtT2R+dB3tD6vlvuFw6PJ4jfcV/GEtEMTY
 OGkgktT+YysD3/EBd6phSCOBEokPQVJlUP2WgagyMz934WW5RoSp3fw70qz5tk9kvnm8
 Fyz6AiXvFJLxCNfmLv0ZTNnLJ/WO0kFJNag1PlrGnpLWOouxnBXAsDtX6yl0TO5BXcjg
 JqldqeJHeYS3ZfGSNVszc2i61T3HirsCEz1h+ZJDTXxVHt2gGvF8LQCcU9qNyQCdhHjg
 iHBWedswaOOGI0NO4YA1ZkfRnuuU5tkQcVO1U0MZa8bJWLNwncr6IHmzVL85sxWffPzV
 xxeQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791529387; x=1792134187;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VJ4Be7AlVUowmNdcUrYxZ+qIyTIMPTbyFPRN+uTQIbQ=;
 b=FYfcE8ipE7rjk2c/Oveg//cxkUw4tq1X083oRAovILIu/wwO+jlBozjLbVmTVW7QBz
 xWS77Hr7x5zB1AHVtT6tZdvJZ4MzGoWWr88zl9tyYAFMw5hP4z16kvIWlgMWknc+UYXa
 xsIF9Rq/scMlA6JrW3IzG7zSQcvYB6VH17PrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791529387; x=1792134187;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VJ4Be7AlVUowmNdcUrYxZ+qIyTIMPTbyFPRN+uTQIbQ=;
 b=X2wLH1cXpeCTE+4vULT78rTpJve1tqLfZN7j0xcU3NsrJhOCWn+n6VXUZ571OmESMt
 JdcD7SoDIbGWO+xXdaWZ60eCHIoLdvEcu/nIGrXo2wTqR07jQ9U0B3a2BiXnYij4kOBJ
 uHDEzNAno85G98LS2V4TybCkSbZRlSCj0D8e0o/DOwYe9oHf9RjUObZjYDuSU7/l0vsK
 +3vEA4gYxJtHjplLaOftIfm8zr1b2+XhHMcop3O4/GAdlozbDy4Xw2pMkVJaYEJwqK1F
 4eF8BNiaYiJqqKIw5sf7B8s5JTimbg0IcvsDSnIosP9/o17p5CN7+4RTAB0hBjhg4h/I
 t7Lg==
X-Gm-Message-State: AFq9FYIx8KIOaxbR+SYSvvuYfBAyAjOXI/pQKsbDSH5iZXWt+XUI+B+V
 n+/SjzcZslMSmFAYQ3QKP6BM6F35Kt7pqC5PqaqT9DuXOanIkFxYhZLwcy0jcy+9O/EDFwmJPp+
 ixud7JZBSUaAEN4smYkJzlaxRNWElfs2WH5zFnLbF2lT3Sz3rDp5M93db/vs=
X-Gm-Gg: AYBFou0xRaQsEFpn2b8Hthtp+ilLn8fstylMuqxNC6awb7KFhaMNn6CM64MWHdKCdQA
 ZsusIuG+clvqb1gOYqdVBMND1YMWTNkr60pmV6ZmRMPItWbICFVo0E719vXBHAl1xzt418Sn/3N
 pQngUnXgXzsbR7ZS2kNhOMFtwznNRxXVxRhkRBx7KdwYyUuwCwviMSIxCwFrmpmlS5pjx2FQUJo
 OxEigQuc+yE4MjtUS3XGWK7sNo/L2jyFj9TcKcVDw3mkOe5j72X0f+hOwO0X7IT2XrxLpGaL5uh
 ctYRp7Ui31GBC6bjXS06wha1xubSY3R/Of6FJENAdLAZh880TGKnGPElRRySk84zZQU=
X-Received: by 2002:a05:6402:27cc:b0:6ac:6a3f:c626 with SMTP id
 4fb4d7f45d1cf-6b17c2389bemr585133a12.8.1791529386630; Fri, 09 Oct 2026
 00:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-3-hs@nabladev.com>
In-Reply-To: <20261004040657.3156402-3-hs@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 08:02:54 +0100
X-Gm-Features: AclHuK-eWErGe5dEXhY0UdtGvr-gHZZaPcfYrHp7MYqSKsRecMiVm8796TN8MFE
Message-ID: <CAFLszTgUh-EdnBYGeRvGh2pkRLc7jyauGHXB1XoZSNSF2f-aWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mtd: align a partition on the write size if the
 device cannot erase
To: hs@nabladev.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Heiko,

On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
> mtd: align a partition on the write size if the device cannot erase
>
> allocate_partition() aligns a partition on the erase size of its master
> and checks the offset and the size against it with mtd_mod_by_eb(). A
> device which cannot erase has no erase size, so that check divides by
> zero, "mtd list" shows
>
>         ### ERROR ### Please RESET the board ###
>
> Linux aligns the partition of such a device on the write size instead,
> see wr_alignment in allocate_partition() in drivers/mtd/mtdpart.c. Do
> the same here, and take the alignment for the MTDPART_OFS_NXTBLK
> rounding from the same place, which divided by the erase size as well.

>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>
> drivers/mtd/mtdpart.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)

> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> @@ -563,8 +563,12 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
> +     u32 wr_alignment = (master->flags & MTD_NO_ERASE) ? master->writesize :
> +                                                         master->erasesize;

Patch 1 decides that a device cannot erase with !mtd->erasesize ||
!mtd->_erase, but this patch checks MTD_NO_ERASE, and the two don't
always agree. A driver that leaves erasesize at 0 without setting
MTD_NO_ERASE still divides by zero here, as does an MTD_NO_ERASE
driver that leaves writesize at 0. Since the point is to stop 'mtd
list' crashing, I suggest skipping the alignment checks, or adding a
WARN_ON(), when wr_alignment is 0, rather than relying on every driver
setting the flags correctly. What do you think?

> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> @@ -731,19 +737,30 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
> +     tmp = slave->offset;
> +     remainder = do_div(tmp, wr_alignment);
> +     if ((slave->flags & MTD_WRITEABLE) && remainder) {
>               /* Doesn't start on a boundary of major erase size */

This comment is now out of date.

In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
