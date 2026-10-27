Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4765D606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vcf0rah1;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=X9RqvuMv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C772A80AFE;
	Tue, 27 Oct 2026 13:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JfGTgWh2kz5h; Tue, 27 Oct 2026 13:46:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB0CD80AED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108797;
	b=nj/Lr/KN1bAghf3Inms6r3+J0/zjHcu5oIptqk9rwoyEmHhjHtME94jWaOSoBx8j0B/A
	 fjzXJBxBvL8L2jPlkUCBmWYqDMsRL74WoUWEToRSzyHdaPN20CZgsGT6fZH72HlmPlByN
	 fAZf/Mix0WBzbGS2l2aPxBGook70KRAYkIPz696NHsU57nGbxTqf13B/QWJxboKbKiZvs
	 fkQNvLIpYb17mcqQL5G1cf7lwdqdjiGp5jxE8ExJuQDmtBFcjkjJuGnYEHp/kkBuYKKq1
	 KumfinTJH12RcwsN1aPWQnv07yLD2LRweGix7m51T9By0M89QOBmbDKYEPjR0mrMXMg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793108797;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rieKu4279Fhbg/KmhGDqnsfatszzYy5iHHWmcOfsq7U=;
	b=J8mTJ2+dbpi7/ZmIcIYtsmu9+mErCSvhutHC0bt/Sm8v9bEOPJU2MDdoxeA/STVU0MU0
	 br+/gIhjYH+brhk1tocIkL32z2G65PfKY6bKwW116PVf7z0AeGVjmABEhOvsdZJ007n3o
	 MYBvmhe7YuB32ZXTuVluqOb8glb4xwe0NPdlbJIqioN/Zu/WC7de9T/Z0rfO6Ufe2GIv2
	 toFnIP7fSmSidIrOqeTaRC3BAqg40tsMzMO+2G7/htJaRb+L/tjdCHnpQCF06rB3a3D7Z
	 icx3ZkGnnPF1rBfCxGMrsI/hT9NQm766FlS65EiD0PpOfMksCyq12Lbq4jOFwNFFk6Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=X9RqvuMv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793108797;
	bh=rieKu4279Fhbg/KmhGDqnsfatszzYy5iHHWmcOfsq7U=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vcf0rah10JEYhz7sM7gpxCTq1QXhmDFsC49Mvx5FxRmZ0eYh8NRlMtDUBkEPxrBx3
	 9lufeHwp77jXImq8QuifDii64T7ktZFHWcAXsSr8TzsKgF42PWqHzaPPD7J+n8NNlH
	 YgGpVpH4xJGusE+B8hc7Rp4ykTojgQd65aFUJT3+JHxtnWp+QpvM/G/0i8eCXDt937
	 xGVFptLmOdz34b93+9OudBTeA1FEmNHiB0b6z9HJLbKLuiKyzU29pGpsThvBSsXhO+
	 nfXug9NdrSxBKrlbhPMTSUibvBdpQH8VvsMiu4nf9AHsNV11PPegkJYJ1/VjMkACKc
	 U2sVrU+FXdMSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB0CD80AED;
	Tue, 27 Oct 2026 13:46:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A66FB91
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CE8580AED
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fo2whiBOl-1L for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:46:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 20D0D80ADE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108793;
 b=PMeMltdhDQqfpz6OM1SuYjNEvLrG51OSxyvjHmIEP8C2JiQSzfE9HI9theV1pSffVssY
 B/dxssguz0/oVEeZd1uJnNWKeXfuQ7FpBmXPVHZUBK7lt8Im13TTRG7zwZkW+0M5sW7uk
 XKyKdm3qN/LP0f2D0oxGrBEfU8bsOKqCop4OejiPA96DOh3UNgr8hiet/MW5HVNcNEwiw
 vC7A2pJHsb4Cm+olwhYzYQVKP/0nhmBFjNM9UQ9VDDYygTD/eWiTTFZI1U1Wm/NAsY8kw
 6PFooG1keYoMOhd9kLUwP8bg3WlhH+oKd54v48RJFYSQPOKoWkhnAOcihZ/IAJLQRsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793108793;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=rieKu4279Fhbg/KmhGDqnsfatszzYy5iHHWmcOfsq7U=;
 b=pi+pE8lVjPdGew4+14HC9eBAUZpgDssBOpgE1/UtoGaXpPz49Fh9IxneDySeSMMx2lwJ
 2LDvzHscQrWXUkN34DyLYEtn5U2gzXYivj4YqFbalygQ72HEPPFYb5c6zh6IoSmG9/z5H
 L3Y2EHLtyO7giJUQwP6iYRFdvKhkdVW8QB36yYFdnn4bbh8YmgQy+uZDY+nj/SsOh+ROs
 U4PpV5hWyif9hyBb+XYCEYm6laUHwvVRiF02Mg6IR4zbJJ8qu6IZXPjrNDOUZtZu+AGP5
 dXh4Ucz2Wkk3JD80xHLFd3bUs0//hZMV7SWdSARdCjpWhp/ta8uUxhjHcFthiCVulgw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=X9RqvuMv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=X9RqvuMv
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20D0D80ADE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:32 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so5457234a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793108791; cv=none;
 d=google.com; s=arc-20260327;
 b=pS0+sQyq+K9LTTy/v/rHMBtZ3aaU5BiNyLbG/y1lhsoCZeSWZWgGL+lfN5QVIfL0UR
 WftrD03uRO0Uzu0L5gIbrcjKSUZN/t9VZrhql/1CZBV9GIFQkz7ouZZrPp3EpZ0ZQXgA
 ib9yajDS4awKE58gYgLKMLWNPA5upMHfK7ijq1hO2rUk9VTApNw4SGEcmOO8grYd7RfM
 UtBMGDjao8VSavudQi/JErswTMAFtliJb6UQumBllx4RVbAY2ju3PuH+d4ic57L+qsTh
 rbmHiWWF2Xd9fjYMywIvGAXq23tYFm3AlPeRnk1gYN5rjnjPP6YJcVKIsbuSYIeyAhjh
 LMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=rieKu4279Fhbg/KmhGDqnsfatszzYy5iHHWmcOfsq7U=;
 fh=uOXiX/FK7Op6ux3YVCK3wLiLMkejBefoITtZ4+fQo+M=;
 b=QctcVokuFDHKdm0pkXtbq3tZgD+u9qncBodcWvI4HzJYcVF4VnjTsNJqckeVyoFH42
 xWLIRGlhZZMmB8qTXyne7A6phh7vcgCPCqFG1HE2IhEO1bzkWAQw/qenAYqXN6aXlRtC
 wH5CIREJa1QbMB5cBanVMlFmdwnyqkfCABC8CevLalvsgW9COPjYy5JUlK9AUBB0GjW+
 IjmimPLmwkFxYNCaA3gwJCAESJti1BBIwI+zRlnLabQ8NgHLnbMkkiZ8mHuOXRIWKw4R
 PBepMvixZGwca/ziOskXf2rbScH+wqC+uXzKA1rEUGRdMY6uYkqsa6fXRi9Qvp/2RdkS
 QuCQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793108791; x=1793713591;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rieKu4279Fhbg/KmhGDqnsfatszzYy5iHHWmcOfsq7U=;
 b=X9RqvuMvsxT7+8gwO7lBOlZXQ20hNhwuwrRwj9lfNZgcO/WvNuu3dGF9kUCznEXmBS
 /89WLLITZ3s9GTUxemAbE1xEIYZr0Mc+p1zs16yj3ZWG2eeuALXrWDglE9uR6VnOtABq
 AUDTlzCzKaWHTFBH1awAVfd6mlynxK536elu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108791; x=1793713591;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rieKu4279Fhbg/KmhGDqnsfatszzYy5iHHWmcOfsq7U=;
 b=kNS4/cXiZTSG7Ujy9dKCFMK91stBTnkhqB27DW8tuL/xm90flYCE67NHewdZU+iuEg
 w4TaB7rUU6mPUVIKDyUqWaHZ7rUc9YQiklsxA/TlnvzB4RsTz25lzey6mjfQAqwa8gIt
 9qJXifIDiYrIkjer0dm24ry7XEcdNaOMSP26alxdfEvtaQFTnTf4isx6n+iDvgjtzOAV
 a6Kv0UeP03FTaMhSbipadZQ7ET67wV0ykzxdxvn9LpwtEgqWrm5h7YFbU9Hs/TITXpiL
 qc5dxqT7PmMoETR9oYV9iY7f2KVNgYhQmebLe/eUCXPQvSqSQklbblX2sYt+vXfPQi3H
 w6aw==
X-Gm-Message-State: AFq9FYJ3EIxlOaDLZsF6gTL9QoscYPmnxcm2Fz3OJdonNVvxP/noCfHM
 mc3HhedUCaef7zAd4x2PQJ0TjUhzUNJ/nqdlBBwzubdQF6WLETVvLqvHU+WXrhPX2kJYtJhFv/D
 6ICEosI+4bwCOX3cradv7kNlIB2hMc4FnJLNTI5mj
X-Gm-Gg: AYBFou2VBUARdZdFGshnyXMGC+iW7I6VGffSKB1a8rwTZ316yCkz9Ou71LJ2t2PgryG
 LKs0hXuMjfzNoeWhNafh+oBhPcn0sZLxrFqmvDDBqbPPx4V5m0qxBCkFD3A5G007ozwKJiIYnaj
 LiA/lKfbVp0Y8HiU30gV8HyuPBCWV86Gxxjvpmdn+39093m666aw8Ef72V3KAk+xrws9JTYG5Dk
 jXIzyIdoNmNdmijXeCxK012DsW9sMTDUKP53pq2TS/+sNis+1vRxKjqKyq738PL2wP2f1GoeTfz
 dgJc4nZDe8rFnGSu1JwntwX+yeJudpAWKv4j/KBtRvZV9xpf+3d6X9rActH4RINe/FO4tZKkvam
 yQ6QRlqrMfLYlaeg69Ety3wJ/h6o9xiZschI8/ssIN9CDBtCmTcIP0699
X-Received: by 2002:a05:6402:4597:b0:6b3:d0a0:1358 with SMTP id
 4fb4d7f45d1cf-6b4431130e0mr9886961a12.41.1793108790725; Tue, 27 Oct 2026
 06:46:30 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 08:46:27 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:41:43 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261026-fat-fs-fixes-v2-2-41ae696cd353@siemens.com>
References: <20261026-fat-fs-fixes-v2-0-41ae696cd353@siemens.com>
 <20261026-fat-fs-fixes-v2-2-41ae696cd353@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 08:46:27 -0500
X-Gm-Features: AclHuK9vfkHFMNgRnuQoyf3vD1yESs0qJPQVy0YqX7sKrLWrmYdVdOxMWR7VA3Y
Message-ID: <CAFLszTi=QN1XTryqGZ0aqU+S=4jcGYPq4+6nPKUTYG+iiHXakg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] fs: add fs_overwrite() to write without
 trimming the file
To: cedric.hombourger@siemens.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Qu Wenruo <wqu@suse.com>, 
 Alexey Charkov <alchark@flipper.net>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
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

Hi Cedric,

On 2026-10-26T16:37:26, Cedric Hombourger <cedric.hombourger@siemens.com> wrote:
> fs: add fs_overwrite() to write without trimming the file
>
> fs_write() with an offset trims the file at the end of the written
> range. Add fs_overwrite() for callers that need to update a part of a
> file and keep the rest.
>
> Add an optional overwrite() operation to struct fstype_info and set it
> for FAT. A filesystem without it falls back to write(), so nothing
> changes for them. fs_write() and fs_overwrite() share the same code.
>
> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
>
>  fs/fs.c      | 25 ++++++++++++++++++++++---
>  include/fs.h | 16 ++++++++++++++++
>  2 files changed, 38 insertions(+), 3 deletions(-)

> diff --git a/fs/fs.c b/fs/fs.c
> @@ -709,15 +713,18 @@ int fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
> -int fs_write(const char *filename, ulong addr, loff_t offset, loff_t len,
> -	     loff_t *actwrite)
> +static int fs_write_with(bool keep_tail, const char *filename, ulong addr,
> +			 loff_t offset, loff_t len, loff_t *actwrite)

fs_read() just above uses _fs_read() with the extra argument at the
end. Please can you do the same here, i.e. _fs_write() with keep_tail
as the last argument?

> diff --git a/include/fs.h b/include/fs.h
> @@ -167,6 +167,22 @@ int fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
> +/**
> + * fs_overwrite() - write into a file without cutting off its tail
> + *
> + * Like fs_write(), but data after the written range stays and the file
> + * size only grows. Filesystem drivers without support fall back to fs_write().

If you keep the fallback (see my reply to the cover letter), the
caller cannot rely on the promise in the first sentence. exFAT still
trims and ext4 only works at offset 0, so the guarantee really only
holds for FAT. Please can you say in this comment which filesystems
may still truncate.

Please can you also add a C test that writes into the middle of a file
on a FAT image and checks the size and the data after the written
range. test/dm/host.c already calls fs_write(), so it would make a
good starting point.

Regards,
Simon
