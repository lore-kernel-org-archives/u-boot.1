Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ABBCC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 19:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEE4F407F7;
	Wed, 14 Oct 2026 19:55:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uONv150iyy9I; Wed, 14 Oct 2026 19:55:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40086407FE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792007702;
	b=ZcNBqKk2JoZwhFWpJOrG05xpds+Ofot2z2r6PG0xmXjRFTu+21e6lm63ihX2qR2FvOzj
	 l0GXi4GzJIAVHPCJpwe+AsG76XXA6bXzITDbqe10HXlB0pz9LdxjVmD5yzDt4LGv/mlo+
	 482BFBSgJN07YaGKC99kS9H6XzOMunm/qK3xhCr4rA1Zd5AL3nQ9gKDa8lixc50NzNhAH
	 qyUmBYwS5bqN2pzjZ/eyD/qLKUppKeZXzZwEF/g5z1LgkbZPJ6XO14Noc4Lc9tIKXnMoj
	 /oqPPvKfa88m7rHyZP7eHFtZI74u2yCv+1gHZV66bL2ad9mafUiQFfObVNKazLHsCtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792007702;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RzSuZ9A2AnnDT5IIEXMcCIwBshuvP8iA4wjODtva7Ok=;
	b=k8Ql0kxG9EM8PNFrBw3zWM6QcGbd6hNWIn3yqjHzINbPhLXIcVhfHSYEcOrWB3d/HTua
	 0AoXZ15Ht7kz+WU0HXXrOv7SiL4boFVc8y0vcHyuUpFvHtncvmbYpuhU3l3YrdWlH/mo5
	 VUzLFcbI4NpToUwAA79xhEh4o5ed80SJI8BGROsGTwfSCGbc30hzPJXWdiXXiRu5ary0G
	 8f90L1lEI11aJX5sw4aKZeRp8V4GYtQjt9woJVuuDKaAHhLHAENtpNgE9+GRc3WRAt0RH
	 xeCuPPQVdEJ/8Pn3gLx2Fhc8TJTHGWOWlkWaBHB3kju+6YjddGMcvcx3U/eTtMMS4rg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792007702;
	bh=RzSuZ9A2AnnDT5IIEXMcCIwBshuvP8iA4wjODtva7Ok=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DoNUD9E37zHaj4TzUIgcvlPByqtv5H7MYrFZREV6+gI1h9qfoSM18+2qhOKDNUUBa
	 fDDknQsQX/8DbyQhMPphIrXLokfDHBuNop/sqv9QLj9FtRtYtiG3QH428RuIDvgYAd
	 DZNKneAix0dJ6bvqXt3ur/Y+RS/Kb7fIULFUlSf0Se4WRsLgB3RmNJZ2U6rVA7h2nQ
	 qyPGwZbRjvu2hrRkSyTM7Ph7zYfTa0ZY1Kn/ClnSUgwW9pXS4b5XEo0Yo5XgZZkIFo
	 nFCZGygx57bABqlKa0zdGo+ST77gcKzFzZDfFT6CIPYZMjrROzbD2ulNHZjUUElFA9
	 2pA8Pg02VgjvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40086407FE;
	Wed, 14 Oct 2026 19:55:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B9DB2E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D5BD80F92
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:55:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_SC9KIh4g0n for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 19:55:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3AD6080F91
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792007700;
 b=ZEN8WKd5Glq8rMpCKvGifnHxRULoM5M+aetwHkiiSWZRF/i75vZmWmsaHXjZE9/6E/U4
 zXpRC3b6EJL/J/qOzlHG0ryUjkoaMw3onX2WC6Ddxy5r+yE7fPubfsrmcDg3FLUXEXleb
 z2X24a3I/b2/pAG7ASEZbceMx2hiIj0ymV0qCC9pl6+yzL/HTc4CroQVwZVMh3DpDb0h4
 PZEMWppIzVT+mZlbVfcQA3i/R5PAZBOmXrnlEQiUiZIJ5ZRefZwVmjYDkVNtd0ZNOo5V0
 W0Za++MEeha7VcHIahfhAtAC864Z54sL7kjTe9ZepELNEoWpxqTHDghujtRvSgeky3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792007700;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=RzSuZ9A2AnnDT5IIEXMcCIwBshuvP8iA4wjODtva7Ok=;
 b=Kx/TJSOb2oLDs1t6JCaLntuRsodG9b8yxEXtnfy8bI2X730QXqkWZRT9zDPmz3peLOT+
 YQZRFKO451r0FAYScnA27yufrKd7LJVtqk9gB0jqHKMLN5Y7gT115gQQOl2H97mkSdeoQ
 xVFBV23ZCeWog3JY7gvqt8zaOPMdB7ogCxBquCxGwkyvyee8CdFik9N6PWhZBa69xIVMa
 jKnT68Tt7bm2KeNxRHPgFjeAYraGmm5JjvzmBKsxNSJXdpY0gvKcwJ/ELov4vfm03fKvz
 fkUn633TE+3GmgDUNydzeHUTxED53/0l5Uuk0o8s2OrSwhNuFLzp3+J2OADF8B/M+kw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=r61mCLyG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=r61mCLyG
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AD6080F91
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:54:59 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-82503732024so2326461a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792007698; x=1792612498;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RzSuZ9A2AnnDT5IIEXMcCIwBshuvP8iA4wjODtva7Ok=;
 b=r61mCLyGfpYNAcf/u1j0yJ9pjZIjvKuGAs3H1BLqiBD79xR+QAF86fqa0LqZfknkAi
 ttlks8CIpgQ1EyQ9k7Lj++p5xDVxudlprtxKJ6QukL91pLNAM3kfvEwddiWN4YVAkduF
 u4N+jCazhZ3/bfOuP8w98xhgUldaHaVDZngmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007698; x=1792612498;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RzSuZ9A2AnnDT5IIEXMcCIwBshuvP8iA4wjODtva7Ok=;
 b=vLC9VGrjifsinMoBSAUGpJl31aV3IIudxmSaxD+5qxEHEe/ZCULWL4stHFXd/sDsZE
 N43HPArDOPNHDieZzh5H6435EZ7MYqYQLk00k3e5VSuG48kjxd6LqlGJn9Vexspy6DGS
 ZfGLy8QaBfq21XCTlOFQMED/3wP/wUaJ+sow/8Zo+Us+lV5jTgYUgOFxm7FjrlI2s3O2
 KQdwv0KXb8teDHMTKSD/r86+8RzzaqeHu5gYyblQVTBhmeVcxRmtffzo2pZWrWh0neAk
 RQt/xB14MvIbqWwLlmxR13eAZs23fuc93K+RRQ0ZcCsaszyRThou+YRZ9otcsEf6nFuf
 Qedw==
X-Gm-Message-State: AFq9FYKq69NyGgWRrMj7cFb/PpOFTJLGEWnLEwSFg8acCVTSC5gJXpkH
 77h3qT9q3FLnc+0Ae2H80moqi8Iogu8+l0X0H/uvq1qeFvFJgLdIjfnhMRVU3/qhrfM=
X-Gm-Gg: AYBFou2ARZyiAxAR2RQCb6kYzU0xcOvSP76NQeSKlUCkmDGrQolQGbGslokgTFqOPnA
 vr9I2qEJckoQCFQw2jbVq4T6Bb1EEAEF3sVCL5GrTn2eNn6gzy+Ih71uR9dJEWI1qFK19Xqjomr
 xumS3kkgRJ56hshs+Q98d3XLCy+yOyZluEKXyR8dXfxzCVOtr3RIMxBCk6nSXWgh+0AO04GTOBL
 avQWk8EGL4rqbZncbtHp8JhLVapoet0lCuZuXdXiw0gQ2pj23Q0FETlMdo+U7I4JvkoqL652uJ8
 moAvDr1MER87tKx/cqLG9UGkTGOg4UAuTNCWRhNgi2y6PKg8AJnMcujcbVAfn94sdivylw+e6WY
 lPicQiJKQMR+w3fG6XeysKKbDk64crf8w1DbqqNYA6md9+slPhR6xya+aqujgrlpcsXakkibYIB
 hPUzeGQckxE3BNV7+M923tbjIWK5uvhdyL3g6Bc+4kF+nnSH5kB+R0Xl2RWVux70O/G0Ay6jtJb
 Sr/k1XTiwUfpzYJSHB+/qckyVQH6ChNDSypuqovzZknOfoCa43kKItVFzfQ4ljZw83PE+QhgYpp
 2Et/ww90aP9EwtvHR60=
X-Received: by 2002:a05:6808:14c4:b0:504:d28:279e with SMTP id
 5614622812f47-50c41aa9bbdmr17723747b6e.5.1792007696398; 
 Wed, 14 Oct 2026 12:54:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe916sm18225959b6e.1.2026.10.14.12.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:54:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Raymond Mao <raymondmaoca@gmail.com>
In-Reply-To: <CAMDkj5weBw8mXqz6RNubuPo_tkVwWKObZxpK1LXa4n_44ZzxvA@mail.gmail.com>
References: <CAMDkj5weBw8mXqz6RNubuPo_tkVwWKObZxpK1LXa4n_44ZzxvA@mail.gmail.com>
Subject: Re: [Git Pull] Please pull mbedtls-2027-01-rc1-101426
Message-Id: <179200769467.285119.5120386639294548784.b4-ty@konsulko.com>
Date: Wed, 14 Oct 2026 13:54:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 14 Oct 2026 10:18:25 -0400, Raymond Mao wrote:

> Please pull mbedtls-2027-01-rc1-101426 from u-boot-mbedtls. Thanks!
> 
> The following changes since commit fed92546960a92177d67c0b8d7b22385f50fed29:
> 
>   Gitlab CI: sage: Update for labgrid 26.0 behavior (2026-10-12 11:13:40 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


