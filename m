Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746C1606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YX13uYJ7;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=P25vv/N9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C855560854;
	Tue, 20 Oct 2026 10:34:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HrYzvZquX2yr; Tue, 20 Oct 2026 10:34:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 152956083C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792492451;
	b=k+25VsmPTXLZDULJLK8CZiO5ivxQgc2IZqckQ2MO5JuEwJJTfOsx2/gTGA/jfx/wHLgW
	 RKPhAD5M05A5t/J1yXAVdfSyPnLmXYzdUEtfuekfzyt+QkfZ6sE2Gs4KOeJw94XevGgoO
	 AljKxWorbTuxSuaA+jrQ6ivuz63p41ANSyDtGRAaiq45DUuGCe+u3Dho1CSmHSYhYmSfw
	 pbAECCEt5ifC9nr5X5+ufQ5icLpnxgfePWjWXXfz8/pUdlvnL5/llNm/ajUS5+m9ENLPo
	 5j71ZPan6bVKWes98Kkt2NOOf3xLJUraidVU8QNQtdlj5GemDCjFHx5c5nshaDil+VA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792492451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=MV8Jo62jiQuauAmlLFz20vJOlEjNk3XhmLVSjnNn78c=;
	b=NBt78Ke6ubnv57E58SgGOWN0h2Tv/h9y3L3WQ4e52GsLjA0qGLSUtueop+XjytnvUzU2
	 x6arAiXhLhguRXjb9H8YhyKJCNA+O2tgxXmRSGL6E8VM6R3i+UsZx2id5RSPT/SiZ8moO
	 eeW7Uj54kwTyr4uKLkhhUpVvgs0aXW8Dyh+XINQz2Bfy/aN79ztGYE2UfbX5I2gq8EtLQ
	 JPoNVptkX8F1MNUaCp8PJJL4ULYLqlrX6zPinccdrMNnoDu094HWOQ0uvqFrjs6AEx2h1
	 VpTqq3sV5aatuQihgX5mTOJ1nZHWJEj4wWW1NT7Z/USTEqlKqyVKt311jjYucTclFOQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792492451;
	bh=MV8Jo62jiQuauAmlLFz20vJOlEjNk3XhmLVSjnNn78c=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YX13uYJ7l+rbTnAkdZApBTdAQ+m1XUdZ4imBsBKt7t5bLyMR2jkjh1RzQJQ6aCOep
	 dsSYmU5URpkbxqpaerbDBxspXkvUOWtDX3KJl93KoEqYVkYnPo6my3LaLXy5Ua1Ttc
	 9I5EGu9t6+AsphqsoS3m37PFH5TKTBMDKyaf3e5qSNZ5WB2sZDeX0gjtHu1d1wngtG
	 57Pn9S8w3fmxOPamPqaarDnSCuGlDoNuoyRnvow9Xxs17Z9rqHzEP3zAABTSzDh5V6
	 4H6MXaU/nvxWp+zB/Nnp4+4RuIF1ZSE6MM8+gvkkrKGNesmLeWWGhO5aK+4xj8ve+j
	 qx9T1xG//I8+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 152956083C;
	Tue, 20 Oct 2026 10:34:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C309B769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3E6440333
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OieQ8sTc2p_a for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:34:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 84DF8400FC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792492446;
 b=dVEFKHeH4CGzJ5+DskW5vU9QE4Zd05Wumvyv5wH1lJOKuJRN4/uWtaRrhSVV3WfpMClk
 YuPvr+m0XXFhjTRZF9Gni0gMENj62LVuyKvB6XeMCdxvxwDsD+uNu9if7GmckwbNSogcx
 MlRpK5qqrEve5fONU3WWqTSTLq7HPVxRow5zyMgn0R4hR42WY627TUPiEboEfO+SwXs7e
 lTBuSFLnuMlqQElPLCaRl89sq5cOZKaYsdHwdrKWE0EdNr9gMeS9SDZEut5DwPT3RuXXx
 WpvNL9BMJNPuIIo4WLIiPHgCK0MaasHVtpcXYhG/E7Xsh5AIHXV7BmQJ3dP4Ycx26ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792492446;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=MV8Jo62jiQuauAmlLFz20vJOlEjNk3XhmLVSjnNn78c=;
 b=nXbc4vrq+edoYlH2tbzimmF7mZrQoE0uhhthiBplPFrOvO5g1B8VDXmg6n55YOn0uxAp
 6UvstxYZUEwQVlzN9Q/YTTjSZtQNZGITdgI4jJT76RJwrymm/UqamsuZYths08+fuTKCf
 l8I9MXgWjOvVqciUgH/vAnSgUHVgTvd7kMyaiQ4qdxI5xcaSaN+GWvr4tBk4Svij9xiuh
 f8SYHPFUC0uMQ5m/NzbIxnFi/iBuXPLOdm84Ad+WzcJKjs6Amsnm7dj+Slohd7ESae/tS
 GW1AEM7OtTI+GKcISDnCVvoD7BHCN/kQwEMSnbOh8poU/1pehBLsbPABUGtJpxc3JIQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="P25vv/N9"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=P25vv/N9
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84DF8400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:05 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1900032f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792492443; x=1793097243;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MV8Jo62jiQuauAmlLFz20vJOlEjNk3XhmLVSjnNn78c=;
 b=P25vv/N9fas/1BYYZEB3Yz+Cz/P295EA80g+52nrF17qzeieJ4HRY07gO6wpiFlG++
 8oKVIOBxVp7j1Ii63iT9W0wZ6Xhm351XeTRdD29oYfnuwAXkK/3SE5Cl2wfTDf4qyzoz
 JiMgzCy1Bm0FigTkXmcJ+eUUSmpZUzuUg0lpRUinPqf+fdfUUXtrjoN29WbdssGe5O7e
 M7k6nEjbVyAPywM4r92EVFRUNyosWcp69YkOfmSP7coumwz0jhXfoWSc8bC/jrrX3bJM
 tFHY8jFQxNYgsrZ1K9G1+Mo+Duex/11tmG0+Ufnnz6PpCYn8kE31ALsYePia7fOLHKRJ
 /9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792492443; x=1793097243;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MV8Jo62jiQuauAmlLFz20vJOlEjNk3XhmLVSjnNn78c=;
 b=CKUgogCls1TXMvs/oYT+Z+PtdoIhm74q1VN0OmQ+ltfMCn+A9cUHClCWEZ+nkxACOF
 qUR4itMsbDQMg1joUNjcZP5KdyT+96JusIUq/+GnvDQTItIJLeOenA0N4qWG4vG0J3On
 1HbP3yVeiUjCOM20BaXcWXR6MH8uIKvJuDz5o1Mz/0M17saF2k+rZ/Bfvnot1vV0bCjt
 BEU8g4t5UxUj/Jd6YLRergf5RlOxm4pG2MBD9BVIDI6RjMe8jRleRQecpWbr7E6vd5hB
 594FDnXEAlccH727jePAMEY6ol7m7mnF1edyeaT4b6RaiCPupNnQlPLKz9ouY5f3taDY
 9qSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2c5fUDpZ+nvyt0p5B5gdOJN6XI7f2Qp4FczpglvkQtGndUJaGqStc6659sy/lkvA6CRQ0JQE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI2MlV2ajAYlDc6hmOENZ7Iu9JBAPfoLrQ0ORlq/AneQn80sUZ6
 STvWQkXf/jL8GVS+nWzlz24VufrBjC6GChmXPHsZwVJuESOgCr+BpDKuFxzDGKOhGfD0pc5PyzG
 Oi8xM
X-Gm-Gg: AYBFou3b/1MMBnbfUhxru6KefaORXq43nPIF3vUKdRadPMejudI2Ty9hyHJ9b087Y2n
 pbJiSJUy+kUB+M5xwrRwiARaw515R9FCqAuc3UXNLVCwigGcZMElyxYdybwi1IR6Z4bSxrtpLZW
 45fRJi3XdninBaGeuTzLYN/CW8P+JfKUl7yN3RgwfmoYxvFClHU+QwHeqseTOiChXQfZmo40wyL
 9/jDhKXviOc00vy8lVZahx6s/jr4K0jlQ1MVZHJ/HJ2g/3eQG4A67Gs3ClsnlkrDqnVNex8L0KW
 UC9x/Nw83KUrzWCB86VMDIerNlZYyR289HhhMGIRYFGaAzZg6eJbMCLZZYEEHDcL0xU0XYrKH0n
 MxvOxYmtgkm5pSCCMwugMV+YAOgKx6KplP/ix4o4D2MTSPPkMuQncqfjAuwAzAT7/BeIbX0D6cN
 dChAMgFs3ArFzuH2FCQb2Waf4NpVWJnD1oVhcwfjfNarAbzXQ08Dz1Gyi1RPcoz7OBg1oVsXt2o
 k62RcMVAsY9OEwafo04
X-Received: by 2002:a05:600c:46d1:b0:4a1:de8a:603a with SMTP id
 5b1f17b1804b1-4a1de8a63f7mr199565795e9.6.1792492443119; 
 Tue, 20 Oct 2026 03:34:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cdc342sm67880245e9.13.2026.10.20.03.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:34:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/5] avb: verify the boot images in the buffers they
 are booted from
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-3-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
 <20261012-upstream-avb_lock_unlock_b4-v2-3-87460a24e559@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:33:56 +0200
Message-Id: <179249243656.2829155.10792036769671220998.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792492440; l=1454;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=xRICnAvT1yLl1JMGeXg2LX8uW2X9FiIu5FWuTQLXVOw=;
 b=BuIC5BQ8MRA1jr/MOdMaNfhauoqFh0y4sMP7+TCGHXAuzhyGdbBAjX89UC5cEafDtN6ZFcHr4
 FXFCQ8Iah9JBQfMXiShlz5vln2pN9m5ucF/PzKOf8vRTT7BLzOyRPwk
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 22:25:05 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

Hi Igor,

>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 0db08d4f861c..862d0d67a2fe 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -450,6 +460,35 @@ static int run_avb_verification(struct bootflow *bflow)
>  	if (priv->slot)
>  		sprintf(slot_suffix, "_%s", priv->slot);
>  
> +	/*
> +	 * Hand libavb the buffers boot and vendor_boot were loaded into, so the
> +	 * bytes it hashes are the bytes that get booted and the partitions are
> +	 * read only once.
> +	 */
> +	if (priv->boot_addr) {

Not sure it's  needed boot_addr come from boot_android_normal , in fact a check of
loadaddr in boot_android_normal could be better than here or we consider
user should wt properly loadaddr in uboot env

> +		snprintf(partname, sizeof(partname), "boot%s", slot_suffix);
> +		ret = avb_ops_add_preloaded(avb_ops, partname,
> +					    map_sysmem(priv->boot_addr, 0),
> +					    priv->boot_img_size,
> +					    priv->boot_part_size);
> +		if (ret) {
> +			ret = log_msg_ret("avb preload boot", ret);
> +			goto out;
> +		}
> +	}
> +	if (priv->vendor_boot_addr) {

missing check of android image version, if android image v2 this value
was not set and come from malloc struct android_priv , we can have any other value than 0.

-- 
Guillaume La Roque <glaroque@baylibre.com>
