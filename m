Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961C4606A324
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VX7oRaUM;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=a8GRvf8x
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72CD940770;
	Mon, 26 Oct 2026 16:51:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 28o6T_XAqA7x; Mon, 26 Oct 2026 16:51:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A7A3E40775
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033511;
	b=DN2RiKPlfxgoZtjyciTi0OV3yT9hzSMEi9aWYiJSXWLCilrXHCz43fGfAi1TCEBW4y/P
	 NyDQLGxDkHr3mFt871D/ElyC7zwbSkLL+7K5lTn3+q3EDgHsusdVJY8LheN0pj74Ql8dH
	 zRYHbhB26tPP64d1OiWSP2TZZj8M8CIKtgcdXTGnU5je0zaRDlMl/4JMOKvH07jM/2+FL
	 sKiVc42wQNFSTes/MpvevuTk3gUjxsal8ABXRE2a+RJOkUYs8YSk4JeciL/WTYEEcGAss
	 18X1KwO5mEbooTgnJUEBFQxbx8ovMpuNaOdmu9Ev7KcQ8x43ZRcqRiAPIMz+zMR1Odg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793033511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BGdFa62S9q61X19vcUmEA9UY3MNVCjx8Wrx71ZgIBNk=;
	b=MaVhcxjC1Lm+etnjYAPkZx4+ZEWfpY4NFJQ0dozSgpzjjve4iVFTb91Y1ITdUs0iYt3p
	 ipqZAnClNueTn0uD0ENuyLyoQWlLEFdDBjh4xowqVLv154TwSM4qnlVmL+NuHcEl1nZbb
	 Yti9jPnsfPO8wMseovpVsjWqLxlilk+YBdWPFTj+UXz7el6XT2UVpXT3+QUY0WsxU3Ugt
	 aESovRwhoPCKoe3QfgDiJNAxml7qkZlNKwfOPkobEITKNyUvEvN46lvvGka+g8CSwyTkL
	 L27BRdxHZvpCQor0qGCsVPCUify3vQc44iWrBfKOKWBlkYZpqF95N0UvOzB/SS32Z8Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793033511;
	bh=BGdFa62S9q61X19vcUmEA9UY3MNVCjx8Wrx71ZgIBNk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VX7oRaUMtz+jbCfFqSqJn6sO5mWmYqXJG0lq7VNu1A+IFeh5I/AXbybv6NCTF0FCK
	 Rm+7trojk70b3+s3fqR4eQHwoAEn4saojN1wSy3gYnMZfaGfIdS+/K8HLZQA/KLsV0
	 wrepyLTlblMIgYJKJVRLKFG2B83Q5hUwKRSysq/NmxF8+F0eVQR5sOWlqBTd2P+gNV
	 aww2bHhcYqaKfxjU7+BmdL50uVu0Uddnd5e6fFimT+SXZyw0MvF/FyM6Wkfa2D13tw
	 OQmDvJ0VjsLEiYkk94KXNiejrC+s7kM+W/BnFOcPduYKX2dha5cnJwNY4d670bi/jZ
	 0t0UyL706BqUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7A3E40775;
	Mon, 26 Oct 2026 16:51:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7351C356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64E1A4016B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TT9k0tv4XKoT for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:51:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5FC4E40062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033509;
 b=mJ9Qw+lgbejk/MOcQkbX4PBuRcaCwyQXux4hZPw2IRNYM7PyyI/iMxkqdM59ujluhkcG
 CUrBxeVtMpg2MPxfiHmLzhXttu6kY9ZKYL3wzeCr5vnjLDjVkyEsKRDVywzje+cDEk3qq
 UEQ9VervfCQG1r+28HwXqQWcU08gnGCDUqSjInepgJksd8CAJzXoXekKIgRXpru5cWgZz
 CQWjSj5yL4fQkDWNnVmqZvlr1r0N6OHHtKPOwUulX0x19KpOaHd/xIBmjTfZ4botDglVl
 wJiE9bHKHqgElkEK8HpR4LHgt/QiqXJ6Uu0xHAb2Tm0tQU08almwy+je1ZAB2II15Kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793033509;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=BGdFa62S9q61X19vcUmEA9UY3MNVCjx8Wrx71ZgIBNk=;
 b=NE+Ws+yzm6pl7xB7L9qimz4hPJxX7/u/N8maEe4siGR9fjVbI3VpSavb9j98XmT2teWX
 qbwpXSAqLsDsEhYHAJ/449JeEZLNf65C8INnLW9uj1cbIvC6O+avuTqIyXyaMfOZ6dxQl
 SSlDTFETzXn9V8xeG9jSYpqlzRpwRQ4R92JYwwJIUiq0NuQr3bB/KfMyswiflbK60uZQO
 49B5H6sbNYusFDDybHLQecCUDbsgfprd8iGSdbkeaIRdOao8/N9S7of/t+rY4y4fk0Dnx
 MI5acuNK8szXJhPUwUN1RhawNBPEzpxgMaog5ofoPmUVnjrUcBDFy3G/mysXezLvLew==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=a8GRvf8x; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=a8GRvf8x
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FC4E40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:48 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b3dc272dcfso4247826a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793033507; cv=none;
 d=google.com; s=arc-20260327;
 b=dcXzPCv2NhK12g+/MbslIJSnF0HmMNow4kTIFlKHOuDZJRuEGMZcxXwhcjkfFxpj/y
 Y7bSoziqt5uNYY9x2COoD6O9aHR+2U/uKovhpAoHbU6OrTLF057nM4UyrajcXCqmqXX7
 OzeVabgZskL5XiIMZFbCYelDblrP2xMTG0iONlY7jOTGlfZv9jcczDq8jBbL+DgJ6xpP
 gFSPi2AKYehVzCsXCNbg/u1amef331BRhb6aUnpZsUvGoFeY8BPKOv/BRCY9afxSAE3w
 FEV9eM9cwA9PaR/9zVmxXvpUf7iMYV+jd8gv9N8+1aN2xvV+h6vEjRwbixsZ4y35yc1l
 zAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=BGdFa62S9q61X19vcUmEA9UY3MNVCjx8Wrx71ZgIBNk=;
 fh=FRv9yVjqYmrIB8j+ihwM651CQlJ8zwS+KolfRYTbpio=;
 b=JP578DTVlUC3MXZLZtaYVy1VO1+mJO9dpLYGWMl+zzLwDdl/k85tvJtx5bRPPwvKCX
 wL5l0/puuQMJAqXUhPon846wOBnvxUiakqA35b6D+/KKYzXSv9A07Waesow46hyX2eX8
 UhsnOIUe6d0tZ2u1cCKFJcYeV46lbSwdMM52pvAp3t52IIbXTxqqWQSuIRcPFDDjk4y0
 AZse/+2n1GNieYmkfjqCb1XLeFozH/UezTOSarkkwI/xaBzt2T8oV8qCugzwoU8JMp3z
 WNo9dl1C9S2UUQm3blnh17+4h5lOj2a3ob1T8MgvDqyXLkRcHCX3Nfa4I9MFhiXWTAoq
 hohQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793033507; x=1793638307;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BGdFa62S9q61X19vcUmEA9UY3MNVCjx8Wrx71ZgIBNk=;
 b=a8GRvf8xt81Gjc5r2xnaVnDi352fo+k2NrQUXyWV84lza2l664df4MEBcSF63+v/vi
 5/wBH9GwJE/2cEW9EuxtoXkxqFDoMEtzQIebGiFTMawov6G5WIO1vNlSTz91LEfBG0+d
 9M5FP105ea/knzXxziAXGgARfy9I/41utfutE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793033507; x=1793638307;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BGdFa62S9q61X19vcUmEA9UY3MNVCjx8Wrx71ZgIBNk=;
 b=x7LRvi5C07t63QV4iSV7LS3nIQg2PxbuQB4KO8nk1px2Niz4k7QfyclBUIJoz6G5LO
 8kv6YQXq4ZVRMJVW1m31bhNktuT1pQxhQ8QZGgBO7+KOqGhNj+cYmCzYhzb/RapsUX9p
 Z4Fm18diJBDkAWQgyE4vBKkbx0ZOWFwj4YQlxunxtMuCQZf9HIRSaZ792Q4PNumHmHtg
 NamvYK2ipXokiiAknVklr8gUZqds8OKkXzaWd4i96N9Q5lQpT+z1hDv7N+de6uwIKh40
 u0w22XhMEA8vRjctvERkzocoUf/60P2tPfTtyQnnrktQLsBC1kdn2X0A9yMQ1V33T7YD
 xI/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQZ3r/jwq6QDbDmu9wb+xSPmcq8OMFiXdFPl/1TryX0r7v4Qrgd4wlC+TumEqOtHc2ZbbrsQg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLinbK1ZUyMn4hGKqewTATEFukKIk8wXpV9NBkhB1d3d22c5CJs
 dk5Sj0TKVI/7HtexJFTgutTLo07ienN2ZOdW5Odbjt0bsoTmjP343L9SEeWIQePmbHhdWHFCOhV
 WLnRjlrBeccaSuIBU2SAsVZ0TYdL5aNpm9vOhu274
X-Gm-Gg: AYBFou15cpjibTX1oBZfST8s5vEVYBhfhRRhhO0xlMXoZGkaD4oppVd1+mnv5G+NLuK
 qMESBNsm+XhIH/nA4QqBhbhyPRjDBzhXfxtivSSMJ0KlMNXlzxffYrPLa+eNe/zVCRVsWYpxSaT
 noCqUh+fO6GQVU8TDfSISBzMsUDGRBPcCS/6gMvf36xkp4xBPjKqLig78TqeSmXlKCdxID0Fyic
 xqUqUAx7kCVoRl8iF6bFAsArHXmJ4ekqGrj8jrViVB65LSlCvvx8jukJZcLKcpLBtr+6e2Yo3oC
 jbVWh3syR5vFTJxdR4D+cu5wUqCXCv/6JaV+UyPxge9W45f8MA3bk1jUOlVBZOrZEqFBe82wsO1
 Sw24UZIX08gLdKgtNbBkwNbomRaSrQjRA7OE=
X-Received: by 2002:aa7:d78d:0:b0:6b2:e2:d965 with SMTP id
 4fb4d7f45d1cf-6b44300edbcmr6276262a12.32.1793033506767; 
 Mon, 26 Oct 2026 09:51:46 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:51:43 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:55:41 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a048c826-bda3-46d8-8abe-2b24e32d5b0f@gmail.com>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
 <a048c826-bda3-46d8-8abe-2b24e32d5b0f@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:51:43 -0700
X-Gm-Features: AclHuK_ansVGW3uoclkFUCNxavIuOtECpkPAG6WW9Llz6uyOElm_lbpq_G7Hopc
Message-ID: <CAFLszTjsh+i8nzRP_u81Lvd02wiPVqrO_QBcqYKSKV4y6ifZJg@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/6] fs: ext4: fix the triple indirect cache check
 in read_allocated_block()
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-25T13:04:03, Ana Bobillo <anabobillo3@gmail.com> wrote:
> fs: ext4: fix the triple indirect cache check in read_allocated_block()
>
> In the triple indirect branch, read_allocated_block() reads the third
> level block from ext4fs_indir2_block[(rblock / perblock_child) %
> (blksz / 4)] and records it in ext4fs_indir3_blkno, but it decides
> whether that cached block can be reused by comparing against
> ext4fs_indir2_block[rblock / perblock_child], without the modulo.
>
> For a file block reached through the second or a later entry of the
> triple indirect block (rblock >= (blksz / 4) * (blksz / 4)),
> rblock / perblock_child is at least blksz / 4, so the compare reads
> past the end of the blksz-byte ext4fs_indir2_block buffer and can
> make the lookup reuse the wrong cached block.
>
> Use the same index for the compare as for the read.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  fs/ext4/ext4_common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
