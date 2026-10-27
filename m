Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C8606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JcivZNoo;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=b1ARV/r1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D401F40704;
	Tue, 27 Oct 2026 08:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H3GlLZmZVlTM; Tue, 27 Oct 2026 08:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86D2D40707
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091571;
	b=LZVGx9z4TfSN4mZpSiC4T0oTHsQsLYjDrLrfw0LhHkbPmsGfukxuhLTvqXazAG4rnZZ2
	 8BEpyH0J2aACrskPDCxhtKmT4Dr2roXMA2dOjAF9rw8POrEvaX7J4/QBuf2gWtmcrZevm
	 LXnXZMmx6WyYnDvKcMlazdxylzv1ef2vd5VlXsoeoeydIvDQPZKnOKxa74sbsUkD95buy
	 eK//cv+ydZnriDJf86UNEk1LiwgS8nL29wNMW7hPmjt42PaMh9VweHg7m+CqDNv1fM0aR
	 U35xJPf2BZjNh4FrQRmnjzChdCC1YjQoMBqDNpdFCR29b3n5/7Mc1TYzmmNy5CkNCew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793091571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=moTpC1lpnv2MzUG7Rxt+4MPTj9kInVJqi6Lgf7tLrHM=;
	b=Tr56sjsGbuzU/AlUsAfIqG/thCigpJp+VlosSC+jmBSPO0fIEMNJU3yPH7U0zGPdt04C
	 DFAcDB5gGTzmhcwfLdsnt+ckrJu8CgJrVKEYpiky0iNpZFMxFaczRku7xDnm6dPAMnxu4
	 9pFrXfdMapRP51Jf4lKt4pRX77fcGmkU+jLIwsrwgFn2h2OoLJJKTNASc773odGthfgRw
	 Cj4p9XqDK6mkS1a5Ef4nQDgd0sbVZnbUd5Mgj4e+/PT8q+StmhWO3LAt47JmmH8UsYvJp
	 lRCIzvrl9rcxPgQ4C/p60zE+6XZGnxztcc43ZExY/4UIW3u83fqI2ZAzc9LBhPoFYjA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793091571;
	bh=moTpC1lpnv2MzUG7Rxt+4MPTj9kInVJqi6Lgf7tLrHM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JcivZNooU2Fyq+2PbImGNfqu3BLNRUn44XcbGn+IFtX/288+N0zkiiFWBvmLtZESr
	 DCX6uoqWloQBN+2ZXpVhxp5hToGZOWqphEfR2q+XE+2yYk/1q7v8xE33Rv7LvMPimH
	 XkamW/4jdW+kUFMq2pf7cav1xhyGJ6pqxxBrWEcbJPihcbGUr6CCnXBEZUUvrRWFYF
	 tbk6xhjSG3QTtLOstRwBrhCqn0UC9KXaaDuoErwk7Qekki5zdfmmGuaHNPq7kv9TYb
	 upZi7IlhpQg9Gjf6lBz+9Hv5g0Ho7CValSAdaH+5W+UxRHaRRd3ACI6+GwcCGymyfP
	 6fNDLZXUkL1Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86D2D40707;
	Tue, 27 Oct 2026 08:59:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E7408B91
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4DA74025F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WFLCaBouij9K for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:59:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DC1004017B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091567;
 b=DayU848pnROqPrIEzy5fpn9XETxq9YJo4ssJbpGnsb6+RDISgG6VGIi+pkb9NW3jfHM7
 fvEGGEGOCrTHzNZCcYlYJ9GVxCMmtpoHj0eUVfkqs0DOPqGIZhHoAHE4dbFMpQu2MPCJz
 UVc6cugPMehW/WI2iGhsN4Mad91xoOMrGfCLDleyaOdHAXwCZbPqeDrWb51Am1F2ri77z
 /yhUGC7cYpNKqh8xhneINLW68CxmYFqQvw9WP8Kjcz+oq1wHacE+dJyQCCnc22Cvgf2eW
 BV4wuLhTfBCWekfmceUNseh9uGUGBivSso/acFo/7WUCXYjikg4v0f55nsGjL6oDZ/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793091567;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=moTpC1lpnv2MzUG7Rxt+4MPTj9kInVJqi6Lgf7tLrHM=;
 b=WewJJLzabYwY8itVXerjXII4iVKrYA7ZQEkDQKj9j/7x425yxBDHE9zXKpJZi21PY960
 2oFLIwG0PYHrq9Z6pdcz8eLGbMS0we75ti5VqxMIXh5g3I1r/RHg4TTmvWmq5nfbDR9mQ
 LuVP+umLpYhyQjjoqI3CYXDti6lSb8fjkJmdb5tg9XrJRloHDFFaBIovlcwVZPKDM7flI
 SoJSbAtweRUsmtKy/ro1BApeGRpChVlDZDmslyPNgDZ/IDd8ZipZDPDgHqSjBJuFVqMa6
 ggjd6du6wg/ls42ariCgfnfaDxhC4y6dJXA7h+cpquhQnFAOXefomf8qYf/VPrDB+QQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="b1ARV/r1"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=b1ARV/r1
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC1004017B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:26 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c434376dbebso127629266b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091564; cv=none;
 d=google.com; s=arc-20260327;
 b=oonPdXg3u8ClfTaWn+GyqddkExTbR/DfYThOPSbZCMD97pi9bk0IE8edJkh3kwu27c
 HCCaRGxdAWJXg9IKifw7R3zcGEBfzInwBWJy3G7RhLCsBcY3XDQNsfAcd9enAtwIKKG1
 02BzSM7PZH9HDteg/e05jwhIM4h6rZE0IkxRMkGrwuCUK1DOhGrBkA6wLCjXr6ZmkbIN
 GhXGwTjm0WzO1n87ewGSNM+AF83z7Y8TKZBcW9zruvhMuaXgeYzazODjEOG4OwPh1gso
 AUMJVMjbR7ZFs5hQusKci+A7KHKxIB/rK8r/RVQrc8zVfT2PTaowiyKWsJVZEuCYKvrQ
 4A1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=moTpC1lpnv2MzUG7Rxt+4MPTj9kInVJqi6Lgf7tLrHM=;
 fh=/rdnnAgt/z8Y/gO/kkwLsOp9dS2eruYSp+dyjwHJTc8=;
 b=ZM7atuye786eAJupdn/kj/ozBiZICTSZGJODldJkcLHF13hXI4/o5HSAYWc5F0iQYU
 DbnB/vWHSZ+fAyE9qdNSHHS+yBGvsBV/QUVHprn95iojvNeIi9v64VB9FBqkSQ499DKf
 cTMdQsvUHnawjLuDAxzcdrwbrhV5/1E60FYI1t1ihtQk56vPN5pg+yhoTcHvVqPlveBZ
 EbINZi/skkjqJ+8xfkTQQoAZFsC+X3r86YS5mDtbiCBlK4Vmv8KTFeA2s/4wZBiJQ2Ed
 /2CWc/EQ5R3L+nalmvBoaDVR2ZgTLtz20+Q7F0gvT9RUwmc/zkX/czv0F0czIEw2whHO
 AhZw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793091564; x=1793696364;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=moTpC1lpnv2MzUG7Rxt+4MPTj9kInVJqi6Lgf7tLrHM=;
 b=b1ARV/r1JbdYHYvq1yYKVTgKiPv9ChzGLz2LBSnW1KC2Ps6Q69EvhwGR5BoPsvnwkw
 vvcbn8ORu/4MJrLH6KdBPsW7n1S+q6K22snRc/+XqboZX8E3ZX0C/WC0NiE3S4wr/3Zm
 EA7eUrhzttVpo10tpgEap2oa34RUPBtxomesk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091564; x=1793696364;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=moTpC1lpnv2MzUG7Rxt+4MPTj9kInVJqi6Lgf7tLrHM=;
 b=KhD7ElXHpWpl4EgxST2scsZ632NDN75yi/ksBAOJ4dlhzSx66+ta873qNooOiFCI1E
 zUv7FFME1qtfDRl1fYNLzHXgjBp08cogfBewPrv10pCqCtt5ZkdpE2jdkJMdQHUOb+1b
 e1S7GiXust5RhHGG1vp0vGd77YB3qqfRO+VnZKpN+ZsRXK98ST/Rgfxpk6OB6fOySn8p
 aAgvtZKpSJshAXcanC6q8RMmnxMGVme8h5bdSTFJ5lo4iN7NyqSGkwlcLsltasXpm/jD
 0TzKwCB+gyHf8Ww2OtfiTuk7GG6KEnLdy+VDPhUboiAsYgmW76Cy4QE0wnMEaRaiIrqP
 8NFA==
X-Gm-Message-State: AFq9FYJhN9RnULiWX/TmE+DXzuh/zbzvVqrAE5TbUcegiuHm5KbMPO9m
 PkHnqf3G9AfFdujB5Hjc45S1bWqmT0ipmbTr37q/27YrUwyD8jsBdbWAW+auu42YCqKnV4AuPi9
 NkT4QYGo2CIj0MbGfkrAIntKtRLJzlmkVV6zRLvbz
X-Gm-Gg: AYBFou2JarQccVleWVSFlUdLwDCn1n4sQ4Di8QS+rLSYFTwSw421lQ2IT1WB5JRRiet
 qN0ST3t5CjTxKYH1uExfBZ8SVG9sA2iTflDThRJUpgiogg4NwjX/wY+iV4Xmpgg4CKxziS3NGd6
 VJldKNq5gSanYZD9VlyDn6uH2RdzzqDRIOuq2xGowxPgwfhrBLSsdu0IkTGtEcvxFGizGH2TjtV
 yw+0MBNONQxEP7U2eEScpETrgPdXeLgsJL9geXVgHidiOPWgP777/azMsaRHP2RJXXNNrg0E+fr
 OmtmyBWeG8+74QOGQ+juYRW/BQTqqaGmrseqECeyRATrL6IxJWsIDJ/efJ+9iRYVfRVOiiwf4cU
 dWbWN3PurRU1vXqvBbb2p1dklFM/G0I5Rw1g=
X-Received: by 2002:a17:907:d489:b0:c41:4512:a3b4 with SMTP id
 a640c23a62f3a-c49a741fe0emr163878666b.20.1793091564578; Tue, 27 Oct 2026
 01:59:24 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:59:22 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:57:14 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fc361b34-765b-44a5-a594-a6f095b03ad1@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
 <fc361b34-765b-44a5-a594-a6f095b03ad1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 01:59:22 -0700
X-Gm-Features: AclHuK-z5MTij2cLrbX8S4IKZYwnQU6VGtCMsAqP1kjVtnhGGmBh1TT_C0_9JNk
Message-ID: <CAFLszTiyARm-rzVxgCdnBSH_nmCzRxy4g9CWfPKdG2O4tTXWVw@mail.gmail.com>
Subject: Re: [PATCH RESEND 4/9] ide: Refuse an ATAPI block size atapi_read()
 cannot read
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-10-24T12:16:28, Ana Bobillo <anabobillo3@gmail.com> wrote:
> ide: Refuse an ATAPI block size atapi_read() cannot read
>
> atapi_inquiry() takes the block size from the READ CAPACITY reply of an
> ATAPI device as it is, while atapi_read() asks the device for, and moves
> the buffer on by, ATAPI_READ_BLOCK_SIZE (2048) bytes for every block.
> With any other block size the callers' buffers, which are sized by
> blksz, do not match what atapi_read() writes into them: a 512-byte block
> size makes a read of several blocks write past the end of the buffer.
>
> Only accept ATAPI_READ_BLOCK_SIZE. A device reporting anything else is
> left with a zero block size, which ide_probe() already skips, as for a
> drive without a medium. This refuses drives with 512-byte blocks, such
> as ZIP drives, whose reads of more than one block already overran the
> buffer; supporting them needs atapi_read() to use the block size of the
> device.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  drivers/block/ide.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

> diff --git a/drivers/block/ide.c b/drivers/block/ide.c
> @@ -514,10 +515,16 @@ static void atapi_inquiry(struct blk_desc *desc)
> +	/* atapi_read() transfers ATAPI_READ_BLOCK_SIZE bytes per block */
> +	if (blksz != ATAPI_READ_BLOCK_SIZE) {
> +		printf("Unsupported block size %lu\n", blksz);
> +		return;
> +	}

Some CD drives report a block size other than 2048 in READ CAPACITY
even though READ(12) sends them 2048-byte blocks: HP CD recorders
report 2340, Philips writers 2352 and some drives 0. Linux maps all of
these to 2048 in get_sectorsize() in drivers/scsi/sr.c, but with this
patch (and patch 1) these drives are refused. They didn't really work
before either, since part_iso refuses anything other than 2048 or 512.
I'm not sure how much we should care about these drives, but it might
be worth mapping these values to ATAPI_READ_BLOCK_SIZE here, as Linux
does, and only refusing what is left. What do you think?

BTW this message comes out on the same line as the '  Device %d: '
prefix from ide_ident(), and dev_print() then prints the model on the
next line. It might read better if it said what is being skipped, e.g.
'ATAPI block size %lu not supported, skipping'.

Regards,
Simon
