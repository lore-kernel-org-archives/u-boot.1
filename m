Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B66606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zN2sOYfS;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BWLAuBsN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BF7E81698;
	Sat, 24 Oct 2026 06:41:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D7NAu-wODJtQ; Sat, 24 Oct 2026 06:41:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 198A38166C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792824106;
	b=LgaisG+b88zfU2ihKxPodMa3VQrBbQ4zHnl6yG9i//0qx5FFd+w2vhu96ZM8/E2N3FB5
	 TMafXEwuypvlhfYozJiGWCvd2r5Wf/FyfYJ/Sk85Hy9Ai7FbJ8ExCvP38Ffhxv+0ZIQKg
	 AUil5euC+u9gHAhcbxDumm5h5CSu7T0HZbYwvQMbAvor2DlVv+2JpFFFqH/T6qXe4rji9
	 nsA29FuZEB/3Z+Xa4LQCxpwkNxjk4uVmE6JIuImw9sRJmmNBEDcwzpjMocadcxpCps2sN
	 v4o7wzFqRRdQt8F0bA3q+lJaVaFJLLQpghFFd/uFwQmXzcKqGKDSD30fBWBw1yqYmzQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792824106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EtAS1kqz3qVpgJaTFOIFb6xtilmUSmL75953L5a1LDc=;
	b=iE4DoSN7W5ao0jyaut5dGW0Iz/SVnTmInbm2530IUqWw3ANKvd5ljj6nbA/BxschVhbm
	 axkUw5x3CP310tUFGrzA27A9bUTx9s/pJEfAoJVcrTysyXnDADMzfEgemQzZCK1YAoq2P
	 3LHqC3ukbzE+36ec7YOrOWISFIjGNmRrzTgYUGuv7KNBYpKWbcuIN85tfuKim0Z5QczMK
	 IO+IYymWohU1pkEm1CgZH9ajg+Tfi8wP6xSCi5WvLJ2l5Lc6r3rfAf/0Bkl89jyfItbMT
	 pMaa6yHo2TksvrQP68FyZsR0EeqxHeKjWAbVbek+Zm/TPxlvVo48o84+r7zsepFgg2w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792824106;
	bh=EtAS1kqz3qVpgJaTFOIFb6xtilmUSmL75953L5a1LDc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zN2sOYfSAkFiFQGbYHgdLzedqWB6vonkit+zdXe94J0OscVtfUL8PA86nXLEHpqe9
	 Xk7x/PDPKoqStn4dySgEELOr+kpvtaMiRqNd+6LuLauqG45ozbADuzQlFVHLgBK2WK
	 B4WPaxdHOSOCvVsAcJ51Yn+4EaJ00SbgtD06Y8Ro9u9NlafCB7HBxeSwCZx1s5hqY7
	 BG/zzNcaG1Mb8iOnvLoeKeJQguvJlzGo/E5dgFPT/6XLd5ytFYfg52HqFh9kSRsowF
	 m1qRV9l+bLja/ognu0R80r3ZnMIoIaapE81PUeJVwSbzFXEV3OD+U0pSv+LK4hVvPw
	 7YZ06208O9VlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 198A38166C;
	Sat, 24 Oct 2026 06:41:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D1494D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1271A60A6E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aVQFmltI5HN1 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:41:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0759B60A66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792824103;
 b=MYuAp9pT2px02nA2VVwcaysOPZhfjWB61tD3dhPY39BN+/5+5aDIZ0viG6Sxt7cN5bcW
 Sz/YuhhDOSKnidDqqK8oxBRUuXJA9DGO5T9lu+rkOgOvvanFJJOyFgdFzntdxhG/Ab+sY
 +ErS35u0UMzDAo3ET5ohyXT07idTLWuO6DWdOf0lLLLksC4cUiirH1Ts5tJsCIjBipOpC
 SJv+lcPF9GavS6DvBvbzI0FWN4rVheLZP98efVwhF+8xht/pp1hpy4MEEfLh5gqINscXA
 n7rHS/J+3j1fmPX+qyaNawex0pVKnVO6QPokzztZZ3yagtmiNbgd3hI3mS0zl59F7Aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792824103;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=EtAS1kqz3qVpgJaTFOIFb6xtilmUSmL75953L5a1LDc=;
 b=QqVCCTJlEaLiXHhei3vWWbRdCLtZIFU8XHewYVlvmsDo8k16FVAzvqcI56VoNfBMWezr
 UK4WelaQkJJr/HDtvA07vkhvOce5cAQEoJoU/ffTc1/o8wCoTts+pIplxvXYCdntjWEk5
 8ev5hBpxWJFK2OuszbkejIOyTUJ41blWrA1WT26WCLWeOLZ8BpaU1Nb6xAPFdUCQsAPp9
 KfXRvl6Pw6je2IDdi48skCM2ZM9WcpwG6aOqRWJ9Z+T9TkZFB6jZ1s8XIMI07bV1CcQyr
 fZ9hrVJQtfvLiAYc6GZnbKZxrZlOJUt5g90SH3laxosMibfqGPO1B85bct4203eepZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BWLAuBsN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=BWLAuBsN
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0759B60A66
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:42 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so915272a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792824102; cv=none;
 d=google.com; s=arc-20260327;
 b=NVAQNUjz8eTWqCzdYy+C6WPbC0jqHUvyagEa9cB92WaMM3s9tMr2xYLr33CMTmxpgp
 VhGBjffvEwx5KraVUAYOGAtxQDTHWik7Fa8Wd70D7RznX9+mmQiApWdi/G7sOtpEmTU1
 nXxOI+g80qcUVgj94oTpXLOywBDYneor4BT+Ji+zHZxkF1LO6NP+ZMSZdgcoaZs7y4/s
 /gjdiBqxnDIKQe4ppFG36Jo2UHhX7+wFspHY4VoSa8bfSUv48ICXkh75fK88rB3ey1jD
 DBIeUWqofOPXCTWPTg5kgvl/ohk7kDyfTgQF4mMh1wZFFMgruwUGQNVMrbMrR92qOA81
 qzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=EtAS1kqz3qVpgJaTFOIFb6xtilmUSmL75953L5a1LDc=;
 fh=L/uw9+u71ZiDOqmjlybLnHPNPB0oTVqkdjWVKnRfXQE=;
 b=rvVI+Wa/execW8TtZ/7lnpijDGdVrhFOCW1tjos2zzYN6NeOnndflT/tqv79hasZ1I
 1n/4LH4w0+5twjHtproXFDeRdOI210uLbY6WVzIjOc4C9IKZwh8XyfOHf2qP0E3K5V8/
 aNZwcwvX1FyW92gacdsl8v+FbElIU4LOvthP0XLcwi/G86unXHulT6IXpcrO0OfgUvbg
 HBuUu9FdXYE6q/MYjySLMfFZZf8jdFhm3k+ORWNGZrjH+Yk/oReRQ6YHb12HXdgJr4PK
 RPtGghPvWCQWgfhVTm7oh4CD300lyWLBLdhd6C/OP2pl3iL+uBrSbAEl/a3nMLGsON/h
 aH7g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792824102; x=1793428902;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EtAS1kqz3qVpgJaTFOIFb6xtilmUSmL75953L5a1LDc=;
 b=BWLAuBsNEkoDLGJz1Qw8Fi4mTQFa66koP16OHI+foqKIgxHw0Afo09P19b1fsya9AX
 qdzaRwrYSFg8cS24bDs8WOj6pT+R4YZvyenfvI0GXz0W0JnfvDoWEwb3UfJyDzRSaxPq
 Eroko9Wdvkfu0OLwVMXaTThsxcqDWD9AyMrkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792824102; x=1793428902;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EtAS1kqz3qVpgJaTFOIFb6xtilmUSmL75953L5a1LDc=;
 b=yboiNbOv03SdYzmep/rz2lbObtlO/jLvusMGU8FMPY/Of1JEHCcp+aYjzKx04Cqtk0
 888SCgGM9xXLwZNjrnIzfjyRausPOs4MW+HVj+UQq6KOwrB/U8fvgMgju32DWiJjX5hR
 a/A8KgD6a/IL17XF8ffE7og61JE7QITUY1SDCOJtLMDYc14Bhsc9+Fw3Txmllb7natYm
 +dOm8HdHcRAFkPBSj4xX2s/JN7pGkmGnAMu72n1iyxoNPx2Z3C6BKwQj1/KjlZpr4txA
 jlBEwAMXm1bKyBj99VD8uF+2A/SelzdtqIZ7GGHUBHLxWRZ8EGKII351D3ckdXahw8Zd
 VSdQ==
X-Gm-Message-State: AFq9FYK00vq9oyacdDSbOZdZHoiaBY+W+I6e3dG80JDuL98FmpZ6ovB7
 zP8Os5DaItaoRJ40Lq3Z+mhdnxeh+Mz1v+k5d9vVh/hEYE5Ry5MtnW+9Uj/L9sQ/tRVlKng6aSQ
 g/Z2VMU99NBsMS8syCy+4MTGv8BmAEbU5nJ9+jA0DnOGcq2xnayv0Lw==
X-Gm-Gg: AYBFou3yhRHjLQAaLBX1ec561BZ8/fwyR+tCzyQUcDaFTSZ0hJMqnAZ9Xm/UoM3WQfP
 X2/rN08wPdtT+J+FTYNlWnbhmlHRmnZoPrruP8DfuLaOaqTnV2TRFfrLnRmYZOcI0g7LK1pkYqI
 bBOn2FBH8dT8rFesQAUlUPLAls+n37zdOZwD8LkA27zxPRdpExMp17jY2lZg0iuB8S9Q2Q5uWw4
 1GLzUiP2aaBEGHeuYrK5JP6kI8PuQuZkoe+J4/1b4l+K5TQof5mTNwcMZwOHsoO3Ss/JPcHiz2A
 yjnCtifzwhNKVGTfh4evuXbq1jRoV/Z6zOeccZdmNtMwdiNDbi9VX1N9cDgi2MNIxjaz5OyLkJE
 hemCSnZN4LDVkHCZxdrPosQvjXg1CO/WPxO4=
X-Received: by 2002:a17:90b:2542:b0:3ac:adce:60a8 with SMTP id
 98e67ed59e1d1-3ade9b2cf27mr1234582a91.5.1792824102003; Fri, 23 Oct 2026
 23:41:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:41:39 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 11:57:55 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022135740.3869144-3-padmarao.begari@amd.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
 <20261022135740.3869144-3-padmarao.begari@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:41:39 -0700
X-Gm-Features: AclHuK9DIFVatHG8TJ9ElgUqaPD3T6aF6V7Zhzx34HyLGWqp_JncUpGwCiBZgtI
Message-ID: <CAFLszTjH=dFNR418iH4Je-QB2rb_zap5+eEA7Ljka3mKzkOxaA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mtd: Add virtual concat support via device tree
To: padmarao.begari@amd.com
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Padmarao,

On 2026-10-22T13:57:03, Padmarao Begari <padmarao.begari@amd.com> wrote:
> mtd: Add virtual concat support via device tree
>
> Introduce CONFIG_MTD_VIRT_CONCAT to separate the legacy flow from
> the new approach, where only the concatenated partition is registered
> as an MTD device, while the individual partitions that form it are
> not registered independently, as they are typically not required by
> the user. CONFIG_MTD_VIRT_CONCAT is a boolean configuration option
> that depends on CONFIG_MTD_CONCAT. When enabled, partitions declared
> with the "part-concat-next" device tree property are transparently
> joined into a single concatenated MTD device and not registered
> individually.
>
> The solution focuses on fixed-partitions description only as it
> depends on device boundaries. It supports multiple sets of
> concatenated devices, each comprising two or more partitions.
> The "part-concat-next" property is set on the first partition of a
> group and lists the phandles of the other partitions of the group, as
> described in dts/upstream/Bindings/mtd/partitions/partition.yaml.
> The partitions are joined into a single concatenated MTD device named
> by joining their labels with '-' and appending '-concat' (e.g.
> [...]
>
>  MAINTAINERS                   |   7 +
>  drivers/mtd/Kconfig           |  14 ++
>  drivers/mtd/Makefile          |   1 +
>  drivers/mtd/mtd_uboot.c       |  13 ++
>  drivers/mtd/mtd_virt_concat.c | 502 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/mtd/mtdcore.c         |   8 +
>  drivers/mtd/mtdpart.c         |  12 +
>  include/linux/mtd/concat.h    |  57 ++++-
>  8 files changed, 613 insertions(+), 1 deletion(-)

> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> @@ -32,6 +32,20 @@ config MTD_CONCAT
> +config MTD_VIRT_CONCAT
> +	bool "Virtual MTD concatenation via Device Tree"
> +	depends on MTD_CONCAT && DM && OF_CONTROL

The hooks are in add_mtd_partitions_of() and the MTD_PARTITIONS
version of mtd_probe_devices(), so without MTD_PARTITIONS this code is
built but never called. Please can you add MTD_PARTITIONS to the
dependencies? Since the option depends on DM, the
IS_ENABLED(CONFIG_DM) check in mtd_get_node() is also not needed.

> diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
> @@ -0,0 +1,502 @@
> +	mtd_node = mtd_get_node(mtd);
> +	if (!ofnode_valid(mtd_node))
> +		return 0;
> +
> +	list_for_each_entry_safe(item, tmp, &concat_node_list, head) {
> +		is_mtd_found = false;
> +
> +		/* Find the concat item that holds the mtd device */
> +		for (idx = 0; idx < item->count; idx++) {
> +			if (ofnode_equal(item->nodes[idx], mtd_node)) {

One thing I'd like to check here. This is called from
mtd_device_unregister(master), so mtd_node is the flash node (e.g.
flash@0, via mtd_get_ofnode()), but item->nodes[] holds the partition
nodes under flash@0/partitions. I don't see how this can ever match.
If it can't, unregistering the master (e.g. from spinand_remove())
leaves the concat registered, with subdevs whose parent has been
freed. If it did match, the children are re-registered with
add_mtd_device() but never put back on the master's partitions list,
so del_mtd_partitions() would not clean them up. Has this path been
tested?

> diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
> @@ -0,0 +1,502 @@
> +		/* Destroy the concat */
> +		del_mtd_device(item->mtd);
> +		kfree(item->mtd->name);
> +		mtd_virt_concat_put_mtd_devices(concat);
> +		mtd_concat_destroy(item->mtd);

This teardown sequence appears in mtd_virt_concat_destroy(),
mtd_virt_concat_destroy_items() and twice in
mtd_virt_concat_create_join(), so should be in a helper. The
err_rollback loop in mtd_virt_concat_create_join() also duplicates
mtd_virt_concat_destroy_items() and could just call it.

The sequence also leaks memory. put_mtd_device() only drops the use
count and mtd_concat_destroy() frees only the concat struct. The
slaves came from allocate_partition() but are not on any partitions
list, so nothing frees them or their names. Every mtdparts/mtdids
change re-runs mtd_virt_concat_node_create(), which leaks these and
allocates a fresh set. The return value of del_mtd_device() is also
ignored, so if the concat is still in use (e.g. UBI attached), the
struct is freed while still registered.

> diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
> @@ -0,0 +1,502 @@
> +	/* Check if any target node is already part of another concat */
> +	for (i = 0; i < count - 1; i++) {
> +		node = ofnode_parse_phandle(parts, CONCAT_PROP, i);
> +		if (!ofnode_valid(node) || mtd_is_part_concat(node))
> +			return 0;
> +	}

This silently ignores a bad DT (invalid phandle or overlapping
groups). Please add a log_warn() so the user can tell why the concat
device is missing. Also, since this loop already rejects invalid
phandles, the -EINVAL path in the second loop below can't be reached.

> diff --git a/drivers/mtd/mtd_uboot.c b/drivers/mtd/mtd_uboot.c
> @@ -366,6 +374,11 @@ int mtd_probe_devices(void)
> +	if (IS_ENABLED(CONFIG_MTD_VIRT_CONCAT) && !ret) {
> +		if (mtd_virt_concat_create_join() < 0)
> +			log_err("Failed creating concat MTD devices\n");
> +	}

Groups that are still incomplete here (count != num_subdev) are left
alone, so their intercepted partitions are neither registered nor
freed. Unlike Linux, U-Boot has probed everything by this point, so
nothing will complete them later. For example, if flash@1 is disabled
or fails to probe, if a target partition has status = 'disabled', or
if mtdparts is set for one of the flashes, 'rootfs_a' just disappears.
I suspect it would be better to register those partitions individually
here and print a warning. What do you think?

> diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
> @@ -0,0 +1,502 @@
> +/**
> + * ofnode_find_node_with_property - Find a node with a given property
> + * @from: starting ofnode (use ofnode_null() to start from root)
> + * @prop_name: property name to search for

ofnode_dfs_next() and ofnode_find_node_with_property() are generic
helpers, so please can you move them to drivers/core/ofnode.c, with
declarations in include/dm/ofnode.h and a test in test/dm/ofnode.c? An
ofnode_ prefix on static functions in an MTD driver is confusing.

> diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
> @@ -0,0 +1,502 @@
> +/* Forward declaration - destroy path calls this before its definition */
> +static void mtd_virt_concat_release_subdevs(struct mtd_virt_concat_node *item);

Please can you move the function up instead of adding a forward declaration?

> diff --git a/include/linux/mtd/concat.h b/include/linux/mtd/concat.h
> @@ -33,4 +33,59 @@ struct mtd_info *mtd_concat_create(
> +#else
> +
> +static inline int mtd_virt_concat_node_create(void) { return 0; }
> +static inline bool mtd_virt_concat_add(struct mtd_info *mtd) { return false; }

All the callers already use IS_ENABLED(CONFIG_MTD_VIRT_CONCAT), so you
can drop either these stubs or the IS_ENABLED() checks.

Regards,
Simon
