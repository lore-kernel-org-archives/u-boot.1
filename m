Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA544606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z4SnZZgc;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TFj5j2Sz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9544E80F50;
	Wed, 28 Oct 2026 08:57:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FudtWzN-mO0a; Wed, 28 Oct 2026 08:57:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D0E4E80DF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177827;
	b=FVVtfpXFFTyoEX70ryuHdLyf+rFrR8UQ6jwAJgElYMkyQL7IUO+XGkv3FEoSuPhkJP4P
	 XA7X1L2EKTBUNsK15xQp8+tyjhJ2i65ZKRPTjGmkpMDgqsJm+o+quJRjaNmWFhgykVu0k
	 9TYD7v4bZPjye7r9oC5ocw773pvwgfcRARjwN2Fk3WTfkCxiXbU4b1W/3Qhj5Bbuxr/Je
	 SJQfaSsnV9p28urpd6XBfuQrN2rWf8mB0laZeMLo2VgIqZLG4rlgrz85IXs20Rw30Pama
	 E0KoIXysy14FZBJQDtFQqWHA/L6XhBxDzbeukAF1bg8cZhHPn1gTYskZxPOOSpzpwGQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177827;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Z+aNrsOouK9Ow/WCcJ/Wkw8GgWL4v0FZx+MJcNgCG70=;
	b=AAQXaUmwn8Zc9TCvJI60dIQwfJwYPYkHnzvHBvnK51vVayFzvKglPIfW+iN5TF1rseUu
	 FDuUu717beQzGJXz1Dkwm6WrZnHnF+q6z1BqY34wcS5K+arqNsIApYhyogWpJ1HtoUbw3
	 cKfWTA0HqUqbl/wNiAYLFfY019N07tmSJlwfxCAZd4BnwsM5QQWwD7sQ11wQmcGCYwMd0
	 ozYRQLSfjhf1HW+PJxfsv2Mk2nlZjqhnXBJ4OCPqvAePOK8jMMHFKb7f3+DCH79ik2GrM
	 NRz39iVTc0jqdOZk6aPc7VBzB+BeAdTzhyii3vcqHboQPJ178rcM9PwQa+1tn/NyhEg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793177826;
	bh=Z+aNrsOouK9Ow/WCcJ/Wkw8GgWL4v0FZx+MJcNgCG70=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z4SnZZgcficH5mQbqjJxfPcbc9IxJmmVezPdRcIOGflDDNM4OcDz+zV8+LrPu2aFW
	 JNgPnWVsmTr2mCNaM8MLbbZzdc57XiHpg5A4dE/JFzcKKOvq/QiRw9olqa7/74dxR6
	 OUmEIXDhEQwYWfgcAIJmRdXgBf5qSp06SgZZj8TfOZjxVH4/pKJJedNw+fTMP/Ooun
	 yIv9fgN0jJfmDV/Dmvui+ZCBsPkfUXHteBGU0e3UP3CvmndgoOjkx8bblYLKox5Z4n
	 fGkNSzPs2OT1cieWEPJ2E+Cydk+5OW1pGCQezqjPAirwFoyo+l2OjV4zKP1xrTHdDc
	 EJGXouz54Fnbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0E4E80DF5;
	Wed, 28 Oct 2026 08:57:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 781914BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E64060658
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:57:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cxf0oPIlJX4P for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:57:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AB4C0605EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177824;
 b=OFznE2Te9DS6Y74pV5SbzK6gGhdNDSeI+bIMnWrigpWqCASCIDtTDeTVBsokcgIfO0B7
 y0WXKhP+ObK3c3fqjGazTggvd2zXkT0zZEaXAK7rrl6M8i9BTrZTp2eztZ9jTcQrEp1m/
 7CtINkJJQBF7okDrMSj2jrAw0lRGdQUy5tVQeTkWkPS1sN3CYc47flpdaKN2OaE1qDkf5
 ySBl77ljgOeAlFJZh7cmj6vPIQqZiLrNau35TELufs91vgVvP6UvsShfp9yMR9r68eVL5
 NEbk7FSf3hcmCTh88l98vHvfE7/3RZMuv+XAHPxKh/oEtvoWpHgsNmVGkQlo91REf7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177824;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Z+aNrsOouK9Ow/WCcJ/Wkw8GgWL4v0FZx+MJcNgCG70=;
 b=EK4dip6JOu+yfSExddM+hhUyXfm2rzw5NDhycDo7R8KmFZx10kJVyivC5hc2D/YWtl5G
 IuNAo/gGe8tPZ9lTuQZQ+aCDNG2m6spat5okxYuXL72ShO/4eq9ujDGFGIA9f7oRLNhUD
 aqex5SZ2frzfQn3QM2rsKfa1e799nfoK/IoYoVwQM/tqj+5ReiUYcrsrMQGMdhwbZZK5E
 K8uCZYR5OlbfCyO328bR+f0mAgBECtIyaHxtZaCQkSHbxgxE2nUutXI6BhQnziBxJQEiF
 eb33geCRPhCO5QAAsaaUTGJyfoWC20nbuVh1FZOq5RSosjW51MDGPqtbprRyzIX/Odw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TFj5j2Sz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1036"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TFj5j2Sz
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB4C0605EC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:57:04 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3ab98332238so435015a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177824; cv=none;
 d=google.com; s=arc-20260327;
 b=KKf6GsAoFtz2I/9g8ztDZMxrzmVRQUdjO/h9ki9P4cO3HYZQn1LNGZQgYZ2PSdWdQJ
 36OnCvqYVQBUEt3qzEJFJIQTpa5q/muDxt64Ca61FsORCQQ1RRdnDF/io7sLvpEBh7pI
 LbOc36ULvMA5pXNzGcpeGHcU0RNOfBqjufi+jIA6jZ4B/tYvch4gnltJmpu7tElWUc3w
 3icSPP5p6nJ0WwvswbneNTwJGJ+I0aJWf2xjTKx6G6so1sY2kBQDBmy+I3qvh+WRE0EL
 6JJS+XMluLSdRHfPyK4ajnjquv1rlTLMLDOHxj2WM9G+fBl5dI1SBdLD6pfsoyFvFrHh
 A2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Z+aNrsOouK9Ow/WCcJ/Wkw8GgWL4v0FZx+MJcNgCG70=;
 fh=eF9vZylbEvld9eguCebLPY0zNJfAQB8wx/EKkSrZPvc=;
 b=QiP7bxxg2pF+IKYB7ScqBgNkBnWAutcU6llDf1lgXytwLJdDvjTbA8Z5SlH/iOx7nG
 0ATojtiGGWLoBnuqrllFl/2O0Zbc8gSl7QAdc7bt+i/nFi+FWHD/Xp8rc0T3m1Ttgrxg
 iHaQHOywCUPORvlR2AwsYifGw1qZKr+S3iuMnT4W/6YY0pK5y/xeRpIb4tyHWJCdgZ+6
 4vJugAJVrnjXqJYAqb+C9vLVbBA9Xy+UkYHkukfHsza1oRWMZfMWB3sdyqh+6cTJeVnS
 9WdGI2jFuwQWRfhI3XSSajNXVoGP42RIjr80VGmCG4TYbuR9N4I05Ypdq1/yxgah2ztM
 Fofw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793177824; x=1793782624;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z+aNrsOouK9Ow/WCcJ/Wkw8GgWL4v0FZx+MJcNgCG70=;
 b=TFj5j2SzC1j+YiXlUOM3GwCtCvcFm1kOZcHfUH3ihmXpK84buTsHZ2hOxC84UCaqu7
 adfKyeYwdNiMkUBpnaXji9NnSOF3u4y3dnd6nlKZHZfY3dwYTZykT7oeo28vt6g47Cpe
 YqFhwnsKwfbh08Rx9Ab+WDCJJrqthSqZNrNac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177824; x=1793782624;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z+aNrsOouK9Ow/WCcJ/Wkw8GgWL4v0FZx+MJcNgCG70=;
 b=aA5ZU+6Ncozwnybw4MM2vyVJUT3nzd/m3Gf09RNRDya5QEozPIfZiqRDSG1UOaTlaY
 RDE3I9T/HHvu4Z8nWNU9WvScRbh6z0aeYd6C+G9TiwHR7LhIka35HZeSq7AWGWXExUHJ
 /2BTRR44rvO3wOH3XhH9Xc8VWVgMW3FGqBSwYPKl+dVnSORx5zca64nWe7QMMqey7opN
 08q2fa7SgyAEwqeYicjETWyNFATUFu4oZ2mgAac3eC1LPOxlUV4kfhb3nb/trabGsI2U
 AOmSJNZKpLwoWSC+u3ldHBTji9Ooy6fbJGA5na14OWH+yg3j+o+reW2tjZcHsXz5O+pV
 5eIg==
X-Forwarded-Encrypted: i=1;
 AKwUvByBiqnLhQ2ncqYE6lc06HGKSsSUBuejCtp8ro434X+RD2SPSE+rwEzDuccaQzGNP6dg58qSZVg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJOFNfcptznqpjungG67Q0ThxGX2FNWyIdpAGlodPEBtPlqxNT+
 kS9z4LruNmvewPRJrWI6SnTMIyZsvNTEtgv0OZqmiUCyFElES9QuG9pVKKvIrjFFvsyshyOJnlj
 qUEejSaFCDkeELiD9HY6PkEpUE+RrB33lUNZI10dF
X-Gm-Gg: AYBFou3m/s8ugefLQAOv6JVXOUDJ2SNfSY2jKztckTnCLiAXzDspSNjI0Negp8mryKX
 puIXvWQaQrBy6+tDO+FgQSBbL/9nthYEN36Yi1IGH1CeC8rvfS5oASE/G/eZvMC9lIFrF/4vS/V
 Jwtq+Kz1xapELwSAX0QdeXkPHJDkO9LZJMwfkSC3QeaVlZdMG8cc+XLCtJ/HuKJbNfiaIUj8Voh
 6iYUJW1r45pLamJ7sYvfdU1Ff9l4q3Mgi7Eh/0CyUwBGQpbK6Na0hvqixEsucoxJ+8v9XZFarQj
 vJsNfqNbOqBeKrxJyYFIisV2sdbrHvnLjc1DYGYoAPr0EXAbX4uSQYiAU4FMF+c2UavrfP4idyO
 bVmM7YkoUFbkhF534ytx7cC3lz26QjjtFCx8=
X-Received: by 2002:a17:90b:1c8b:b0:3ad:6738:db14 with SMTP id
 98e67ed59e1d1-3ae5814509amr1273038a91.55.1793177823847; Wed, 28 Oct 2026
 01:57:03 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:56:58 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:29:46 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a8d9f8b4-c900-4706-8d4a-8c07da7d8cec@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
 <a8d9f8b4-c900-4706-8d4a-8c07da7d8cec@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 03:56:58 -0500
X-Gm-Features: AclHuK8SPoUFfeL2VQeqp-QFIfJeY8a8GOMllylL1F0kPKc1nnGwdihSsEAVgIE
Message-ID: <CAFLszThV_2swcM7rzdix+_PJo0x9YMOfimq6pos5fKmPOgYZPQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] disk: part_dos: Walk the extended partition
 tables in a bounded loop
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T05:50:48, Ana Bobillo <anabobillo3@gmail.com> wrote:
> disk: part_dos: Walk the extended partition tables in a bounded loop
>
> part_get_info_extended() and print_partition_extended() follow the
> links from one extended partition table to the next by recursing, and
> stop at MAX_EXT_PARTS partitions, the limit added for CVE-2019-13103.
> But a link adds no partition: an extended partition table holding only
> a link back to itself does not advance part_num, so the recursion goes
> on until the stack runs out, whenever a logical partition of the device
> is looked up. Even within the limit, every level keeps a buffer of one
> block on the stack, so a long chain of tables on a device with large
> blocks needs megabytes of stack.
>
> Follow the links in a loop instead, reusing the one buffer, with the
> code that finds the next link in a helper, dos_next_table(), which both
> functions use. As Linux does in parse_extended(), stop after
> MAX_EXT_EMPTY (16) tables in a row that hold no partition: tables
> linking back to each other are then given up after a few reads. Also
> stop after MAX_EXT_TABLES tables in all, as many as MAX_EXT_PARTS
> partitions need when each table holds one, so that no walk reads more
> than that. A chain that also holds tables without a partition then
> reads fewer than MAX_EXT_PARTS partitions; partitioning tools write one
> logical partition per table.
>
> print_partition_extended() follows every link of a table, where
> part_get_info_extended() follows only the first, so it can list
> partitions that cannot be looked up, under numbers that clash, and its
> walk is not a chain but a tree. Follow only the first link there too.
>
> Add tests with a table holding only a link between two logical
> partitions and then a table that links only to itself, and with 15 and
> 16 such tables in a row before a logical partition.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  disk/part_dos.c | 289 ++++++++++++++++++++++++++++++++------------------------
>  test/dm/part.c  | 175 ++++++++++++++++++++++++++++++++++
>  2 files changed, 340 insertions(+), 124 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
