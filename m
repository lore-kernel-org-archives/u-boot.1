Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76B606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yJ/QsD3G;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=O/bMAmoR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A1DC406E7;
	Tue, 27 Oct 2026 08:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msMbIAQCBdto; Tue, 27 Oct 2026 08:59:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B1012406E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091564;
	b=oACiJBsDyVGAi1sEU5FhZnJJ6TECH28cuObvYyxku3UWcUTN5dgvXEOcLJAMsxZ9mC/C
	 RRt9o71+K7G1A9Y5P0YXuII1HIhczGh0kunWCcHr8Am3d8LG8YQMnEWQkoDM7Pcsg2AWH
	 wdugHEbE6oUJGkbc2td/xTP/8PMLRrR8OhBA0XoiuN0R5Dy1nTrq3pDVCYVy3AhTdaNIK
	 PzCbypLX6B1zqmejS9TVR2OZs0k4gXGYZAEvu6O4rqNYRpEUgj/6Cr2sZdVn0BNUgA+wG
	 IxlhLl07pi0d3lq5MrdxTigAzNGr65HDohfgMX6z2Yx5px90Y9bZ2Fpgf0KsMPrkfAg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793091564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CFzX7hK+M6TBgt/FOpoIhG6N74IUfyCLbnrkulHITuQ=;
	b=ivf9E0N+AMGcpqDOWAfNmgJirRtgvLh7LEdNEc0ZJ9BAz1UHMTqPzp8jiupZTeWzO3R8
	 OPhCwnNa2bHe1lO/CNpbl7bVxTVrsahlzOCW06xWptTqrjyb9gMSnjA1iIbU9Be6qHhuw
	 Q3rQm09trPwVYlPkrs6b8aW41F0MCRJZpbxRstT7JUGGKCB7K2SBzCkaBLDsSvJ7yags8
	 6Auss6e32OJNf/W+YiFpozCC3QvzzwFrEBcUI6Tw1ZFtL6CCnleV5T2G+SPly5gZIyuOx
	 wEmtfODtkr6gLt1PUDGB7R1S2Rb/e7+xZ4MkFPYEUbPe517wCqDYqVhWW6tanRYdpqA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="O/bMAmoR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793091564;
	bh=CFzX7hK+M6TBgt/FOpoIhG6N74IUfyCLbnrkulHITuQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yJ/QsD3GZd7xZBPv8tRdgF2yLUipQtqknzMVYAXmJZA5kQa5FxwbexC2C7LEQCC7G
	 BpDVPuZz8uLNTJ+NvmkxFgiQuRqyEuz4vgZJWyBwS+f7AMbumEiuezQHtGM53vnZyK
	 YSL+rG8wziJo0DnNnMa1hfEED6GqCViv2ChlEjQFxp3o5Mbyq632R0eTxBgnpov9t3
	 0S73psVmibF328SU2WySaGmGSwPVb5okAXkvZ0MJNEwz/EWqRH36kKWRdsRhSlfzzu
	 zNPvVnkfNRHsZONSqMPEPllB5sgRnNXtzkTUziPAcjaj/EGNt/wCyREMgWEcoABIu9
	 vkKUCWEkYCOPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1012406E2;
	Tue, 27 Oct 2026 08:59:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC60CB91
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CAF034062B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TftCBk_TgbXS for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:59:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BFD7040689
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091560;
 b=LBnr9hcz81J/LmLyf6W6e2jUmGk0At2qdaqsW6iFXX+yNKSmVtoHvJbXNrJNlhZMNUiv
 RnkCXKhErguAB3ECc6KZ33ygk3uERD0kv5onQZB749U/fsuB9kmxwHKW0+gGQSyE/tPdR
 oWH3HPnHkhvahjnF+qiLIiZChKyTdK11HUUH0tOm+xEhWTn1XJ/y4A6uVtrIaFPcGFS0X
 D/K3gaS7d9BIYrlCqR/tfMMVRG/l9RI3qDXdyxbjbaF0vaVr1pm91CN+EVGFD7OiOafqn
 F8NWtz8yPYP99UmwUoqJxZOmW8spqbU/M/lhYRadRdDbsAcdFWY6lcHFhf3zAzcd8+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793091560;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=CFzX7hK+M6TBgt/FOpoIhG6N74IUfyCLbnrkulHITuQ=;
 b=DAFNigpHEMXWq9fRS4kZWG2nz+UqruV7KAevp+fiaz+64ga28YjHLsrP1WrBGKJdE5F6
 5TaXIqUPzJ7ln+xXSStTZUHDFdCCT5LrHgFXPQQYx+pHqToa2OzapZIPZ5pRjMgHpA10J
 znvdgRDlXjA9c+O5b11DKxQKzeCSEbR+s8dfmWMwxF3p9mAWwN+1yzTljRtO70JkB645e
 jGkHR7b+4qU5fC95I5py3fXfvilQIm8OeoEvWSBRTbYzKANLJyZqZSknNfkNJeD4DuAlB
 1RSIYCoahZwUEDUvxDeNGDvT4r1j5rxtSz/jeB9qfPJ0KuxbnZbx42bgGdvHLEzCIhA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="O/bMAmoR"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=O/bMAmoR
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFD7040689
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:19 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b40fc523faso4234976a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091557; cv=none;
 d=google.com; s=arc-20260327;
 b=XGJOXs4rRALLliHDglqb8eprbFPh/1pk9Q2Sr2uuL3j+a5+DDryDPYievn0hD37hHC
 dond6xSO7eJGoCPq1vMlJjXdpp71OByJp6TPjiH4Pbo8JHlPNUe30qasWFVq+7Iql1ek
 U9mFutZXVwaswqZlgxEnflSxb+wb8tVJSBxSBaxdNnDcr/TRj1NgHCq0EF+JaefW1hVr
 wNiTt0RIIiNOMdpvbeiiQvtBvHoHSP8t8jyfrT2Cvuq2g9O9QTcxb/WuB0tiv4oxNqog
 q+e7LDjvMjigcOsMvoTUCa3nhfqSHa96oHvdzS8o2ReqSPjDlkj7ph1ERhLKjRkDp3Gq
 wILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=CFzX7hK+M6TBgt/FOpoIhG6N74IUfyCLbnrkulHITuQ=;
 fh=/rdnnAgt/z8Y/gO/kkwLsOp9dS2eruYSp+dyjwHJTc8=;
 b=iyx+IxVvQWtrwSP9LlkshuaefdGPwSY58f3aLbc+AzdfRWL4yy+YQk2NlQNbhmIU2H
 IhdZ4LNqzOWOSYqlQS70v5EV0ktwB2ontCreEg9YwyUWVmjCjolUIOwP8NYV5Ihq0PnG
 KS9zXX/yVzUgiRORlQ3+3QwWCE7960R8WQCYoJ7NQULDZjDItofqpt0uzBPGb6d3/1xB
 SfEQwxsl2sODjUYkcAs2ArObQe3INk/PIQ6jo7TpXx5LVdagJVOst0QNT3SXnPQEhlP5
 vbhIRE360avUQUTFjO51sdkAyrSl62uDXvsrmqPwLAAn/TMNML1hHQRMPwLDo//2j44j
 3zsA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793091557; x=1793696357;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CFzX7hK+M6TBgt/FOpoIhG6N74IUfyCLbnrkulHITuQ=;
 b=O/bMAmoRkxA3Zc64nzFWqNUm5FGQ6WpirIb5vYoKU8JjE36/AtPR8GE1mgkMHtuhYV
 ubiR4O9nZvnUkNq1UavtGjlsEOLx6GidhXWAu2mu96YpxEkfD+MsxJODaFb+3Ya5HNEf
 m/PDyb7sF2zgD0qE9cs1Xh6LOsVWAVFQLDRiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091557; x=1793696357;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CFzX7hK+M6TBgt/FOpoIhG6N74IUfyCLbnrkulHITuQ=;
 b=XgVhHyqGhWIfnevB4baAMQd4z+nJEfMiFoFvbn1QO69cpnLH6NiiHr83WfurfdJ7+V
 f2XQ8wsOCCEzphnCGrXZnccco8NQU+Tat9PrvZtQiLh+qVNr6w8WojTtuhDkUQTXdLpa
 CNq+b779JOUzT+Vm/6Ku7tzkuLlMRVzuSSwBU4QhsEKyYTNKCmJcH0UAYQLzZLmgbbLG
 3gFLE8vIiOLROsuRdQXjycgLEwsBXgKD2mo9Agfq8gndvJZupwqRPO3hfOHdkAGvb0PG
 XeiTqPfinTSeFTCskkdjZbup52Xzi+VnivXz/PwLxPnX+pP3FhraQy4v4td8APMAz2k7
 182g==
X-Gm-Message-State: AFq9FYIZ97NG1f2OZh6DYuMqDoJ+7ohC5MVEZTOBx1LcYsyfvEGvmD+V
 0ReGIVpBX1bABIA2jAYl9BDyLprVfM520TVCMy8A4t2TR/vvpui8HtRt+eA0yY8Or/P3mi9ohmg
 PdCljEErfscvUkZs7t+ufIYt4ZiDK1uejxJhEF3I1
X-Gm-Gg: AYBFou3a/tVo0wk4mKmzD7nFvgS6VSROSjK1vM3cHzV24xJO7uS1rOgQAykT2KiWi9N
 z87fULzEzRlFevtcaPEZrvBvG5f0DZt4dT9KB2Ooz60a968u7mKyXvv/ta5LMb6ie/g0LPbSwIr
 +m2F2DJkySVCzVmypV1lZ3w0mNlv2G4bNPIHNAVJMEEz8XvoD4jJpm5WfNGCw+dXvFL/EgWMMUK
 70Oy0Oupv/ORAaLpocWjz8di84vN9oLstVCe5Jfb79WucbruMNL0B2INAxAolNXjan0VZ6qH5bw
 mFFNjtCb+nrWcbpZYsCL5RMqJZzNEHhW+7NxEDwv1DLkGtgIsbamifWuGT/MVxV/pq5gcS+6n5o
 m2uKJYZibPecQBt+u2VXnUUfdoLBIF90+qK8=
X-Received: by 2002:aa7:d642:0:b0:6af:80c4:8981 with SMTP id
 4fb4d7f45d1cf-6b443001da4mr7107992a12.26.1793091557351; Tue, 27 Oct 2026
 01:59:17 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:59:12 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 00:14:30 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <26508a97-8a4b-4802-97e6-1df74a56ce3f@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
 <26508a97-8a4b-4802-97e6-1df74a56ce3f@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 01:59:12 -0700
X-Gm-Features: AclHuK8uCe6c8f4lAVSRgAJPCTtvzNaeBVmhtyTu24KRWEsMz87MECP-h01WIJs
Message-ID: <CAFLszThUToWSoVEM2i_Cbup3=WywzaZxJtXhB-GGQJSDftLaeQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/9] block: Refuse a device with an unsupported
 block size
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-10-24T12:16:28, Ana Bobillo <anabobillo3@gmail.com> wrote:
> block: Refuse a device with an unsupported block size
>
> A block driver sets blksz and log2blksz from what the device reports: the
> READ CAPACITY reply of a USB stick or a SCSI disk, the LBA format of an
> NVMe namespace, the sector size of a Xen backend. Apart from the virtio
> block driver and the host command, nothing checks the value before
> blk_post_probe() scans the device for partitions, yet the partition and
> filesystem code relies on it:
>
> - part_get_info_extended() and print_partition_extended() read one block
>   into a buffer of blksz bytes and parse the partition table at offset
>   0x1be, past the end of a block smaller than 512 bytes
> - fs_devread() converts bytes to blocks with shifts by log2blksz, masks
>   by blksz - 1 and divisions by blksz, which only agree when blksz is a
>   power of two; with any other value it reads more bytes into the
>   caller's buffer than the caller asked for
> - buffers of blksz bytes go on the stack, so a block size in the
>   gigabytes overruns it
>
> Add blk_valid_blksz(), which accepts a power of two from 512 bytes up to
> [...]
>
>  cmd/host.c                  |  6 +++---
>  drivers/block/blk-uclass.c  | 15 +++++++++++++--
>  drivers/virtio/virtio_blk.c |  3 +--
>  include/blk.h               | 20 ++++++++++++++++++++
>  test/dm/blk.c               | 41 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 78 insertions(+), 7 deletions(-)

> diff --git a/include/blk.h b/include/blk.h
> @@ -22,9 +23,28 @@ typedef ulong lbaint_t;
> +static inline bool blk_valid_blksz(unsigned long blksz)
> +{
> +	return blksz >= DEFAULT_BLKSZ && blksz <= BLK_MAX_BLKSZ &&
> +	       !(blksz & (blksz - 1));
> +}

Please can you use is_power_of_2() from linux/log2.h here? The two
callers you convert already use it, so this keeps the same check
rather than adding a second copy, and you can leave the linux/log2.h
includes in cmd/host.c and virtio_blk.c alone.

> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> @@ -828,9 +828,20 @@ static int part_create_block_devices(struct udevice *blk_dev)
> +	if (!blk_valid_blksz(desc->blksz) ||
> +	    desc->log2blksz != LOG2(desc->blksz)) {
> +		log_err("%s: unsupported block size %lu (log2 %d)\n",
> +			dev->name, desc->blksz, desc->log2blksz);
> +		return -EINVAL;
> +	}

Just to check, have you looked at the code-size impact? The check now
sits outside the PARTITIONS condition, so every SPL with BLK picks it
up, along with the message, even when SPL_PARTITIONS is off. I think
that is right, since the SPL FAT/ext4 code relies on blksz too, but it
would be worth saying so in the commit message so that nobody moves it
back inside the condition.

Regards,
Simon
