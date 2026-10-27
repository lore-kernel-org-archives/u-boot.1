Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C7606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ciwyXvY1;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IAqBiSKd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B143460719;
	Tue, 27 Oct 2026 13:46:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CcHC1ClopeuH; Tue, 27 Oct 2026 13:46:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EDC9F6075E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108800;
	b=rvYLfi5KsxzPYOyQhgXkVAXyPPXsbqSskNqHdm1weDWmM/dzPsjTvQlxg/IZP7aLD1Al
	 i4p/21XPaeG7rvInuFLJvXs4AYGU6FfLDnDa6eF3WZJmFHL4PMZsIVLF78HSyvNKfZIrE
	 RKhMnku2VGaAdC2gTwG3/oM/EHldo1wxX/4tXaGNbzaTOcL9lFPAhSIPVO5vLGjXhsmwe
	 4Uz2qZ8MCCnZPIwgvGWogYIwC90E6GMTxjfFHeDwga6XdTndX8w5XIsU/FjEgq81EoL6O
	 lfj1ozFeNDyjrS+1OjtKpws5nt5kYnRqu3CTTZlCnCa4Us5ypvO5Apy16MAbYVYfwaA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793108800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=z8Rn4Hbt1KRfPZCj9Bcp7BxmbPbaozASbd4EbnPhFjs=;
	b=aRH0x2AuZDWUvrO+7hSWjxQcZSK6xxp2lKzKK3U70L2e+3WDWQT6jv9n6F4btLWC4bTA
	 ikN8hAkA4XLSgmwoE2JAJlejO3nifQwHdBwUPVXhPpYmqeWK7KhThgmDfPJ5bSwt6WudH
	 nOTLohPuUcDSVCw9/Oy2FiBTqTq3qUZexgPFgzZg+UqPrVOnPvIYJnGVINjUjThgIo36T
	 LUJ4ReqlEQeKY+hmE7cAnC4WSFbTrsvXy21XsL53bOfFnUnJ4Buiv3UW2MQ7qHI7Sggo9
	 lYVYeCrCHkyes/Htvi24xTUsMokBBzJzGXoixYVexioNLdv9UFbf+9Yrz9vH2n9Io8Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793108800;
	bh=z8Rn4Hbt1KRfPZCj9Bcp7BxmbPbaozASbd4EbnPhFjs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ciwyXvY1UO7pe7JqRFar9uETS4bUbSMbfWe6U1cWp89/4heVUgfkYlCcVTpQ5mJro
	 PUs3XUsG90uOd8teP9Fqr5/q1+bPRGpLME1CHElWzxsB2CJYw3ZL84xxZmP/XgJBP+
	 5n3/fpHygp/c0k93asA1gSY/qBMiM9sun0KOuCLjYcGw6MkIJl+VDalhsFBFeJ/Rt2
	 uMufKxYFSgpRPqrcH0AcWr3vFYWMHKIH7RGwSvtcmcW3YNo8iyaynsSOIOO58Xsazh
	 XfpPOkHywS58kgjEjvVlm0fKat35pmZZ43a9U0X8xqz+fE6LiqUAaYI8UZA4onCkcQ
	 ilUf2TcZxdEuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDC9F6075E;
	Tue, 27 Oct 2026 13:46:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 22E26279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08DCF40261
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UfWj9OXaxCVS for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:46:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 891894007E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108798;
 b=QRx6VLPFf+hI5tSfxev3a0gYKAGRNJh24mW8rMU0KRIyE2dGXt0Y+sX24JA5v1lvfZhs
 YmB09HHqpRnrfUl10u7k955YUcJzdvnD9dPGXlBeJLe/UJM9rVftJsUwOr7NxuuymRZJ+
 cREK4Lcjf/wZpkfslqVgJKUgl2V6f6+XGMIQqnlv7OGZW0uoIeuumc21qymF5JAdYuYto
 a1h97EMZmELOJqn1vR6LqApAY6mfWzCXjXKqM5i867ho1viXP5MYugEU+8P45ar1vz+4E
 ZIpGlVXR6HzpfyaWHf/kzqou4EY0jkAahaZTbLfOHqzleFGAV0Fc8u8QnobFCi+kxFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793108798;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=z8Rn4Hbt1KRfPZCj9Bcp7BxmbPbaozASbd4EbnPhFjs=;
 b=AR3/9lEFoqwt4z6KVV6DYC8kZlu4HXDrqx/IhSDYs7XmGJ3WYj8SjZ5NRk/9SYuNii56
 TMEMD0UrWeECjHT3Aq+7zEJdgWLeTIUTv0Wxjy68adNh1v+f6e+IcSQa7DZh7KO/SNopK
 /im4jptAC1SdQP3MKpBQhnqKp9kNKW9k8kyLtr7eUpSssBLWLWrESf6YGP0tom1x/txrq
 YzmN8lc+3lxVOS3oQAeEazQ83+MvlhX2QmZN0xWAxBEg/RvlCdEg8Q2Jexfo0w8l2R9co
 GjP8cpE51CjpzKGeaL9qeTIu8gRRWHckaSrFKdEY7uPm9jBGA8nAW32PKel7Hsl6GFQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IAqBiSKd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IAqBiSKd
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 891894007E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:36 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b1b13e09ffso5773593a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793108795; cv=none;
 d=google.com; s=arc-20260327;
 b=jFKrco9qCPDhtpc3yJcuGM88lVxo+jJLPtd/DO36SeNvPaTHoWBoMbFrsjXHH5gXvQ
 UvLVv1WkgZUiU7arCaiAK+yRn4gAhcePGacHPOuljRlucQQyIvQsbwlP2y+vrOVFTXz3
 kx4EGdIyNm3XU/9s8v9qxbep5wgUmDVL1cth4AaLykl7COrZc71Js5BNS1MLHuXdsx+Q
 lJTM3CRuwWiHdmufre4EPDTO/C4CNPvBqt0TMMXHrOD0za9ROry7DKzwhhBls6LxDxip
 KvpizPJpejPCadpnSxfq1cD8gpCUYBi8yWpBYZs4RLwdhHW51kPsTmk7om5FUNeZj44T
 VH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=z8Rn4Hbt1KRfPZCj9Bcp7BxmbPbaozASbd4EbnPhFjs=;
 fh=uOXiX/FK7Op6ux3YVCK3wLiLMkejBefoITtZ4+fQo+M=;
 b=mhI8E5Ps+gxOmZj9ypQMnC+JyB72UJApJfNwwkIMSyDNG+Pmbq8SHAVI9c6Jmtbchy
 QBMQv2SmxHVMzI9U4njy/rhzX0fhHJ0Gj2S9nzXa/0lrxdKbsHguCnTF9O9eUHA8m6jU
 cvq8YZSRWw65zInFZVcpaPciSXX7BrTQy33hVUTxDCHl2QMOrobxm0YRnjWSgU6LotJq
 1EO7M+Oc7v6bcDgpKLjBMrwxbdvYkwrDosO591ZWFr2hLz6sresNqIzSjP7vyWS9UNeM
 wONtOiWp/YEuJiYYAWx21sxK/dk0dNUzRBf4vhXZoXa5+QAKKtNJMLq1nUfVRWz5CRzU
 7BTQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793108795; x=1793713595;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z8Rn4Hbt1KRfPZCj9Bcp7BxmbPbaozASbd4EbnPhFjs=;
 b=IAqBiSKdysVFEac4uKYuYJ1tAg+iPAe6Qd8Gd8VpVkbePzBOhIGMZjxwm51n1fFavR
 2KYv8dzjhmzdlFdF0ObCWSl5WMPe7Mq+YfEX1KDIrVa+bAGoNGZIl2CXRbvEjWZ9N7vX
 8OjUUYzaRaz3Ge33ATl5d+jTtWnMGy5QZEMK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108795; x=1793713595;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z8Rn4Hbt1KRfPZCj9Bcp7BxmbPbaozASbd4EbnPhFjs=;
 b=m6Cpkzlg+0l0JKlVlDKz4OvWMhmtwi0jCeXDxILvreskkJYoi405Q1ldhlGGGQY4JT
 z+3SJ+Xeg3Pf6N2YBsreGlFl+84if6Zibn1XyRnkbRaa+U3BMiljPsBmICNIWyRgbxbT
 QcpieEpC2VTDI2QBQpqZNtY7xMq8ekEuxZOwbYdW4DCrXXEGVQYnhDHatRdXc/6Hdvl3
 3vglZM2a/tiBZhRNEwSkl3IunqVT71f8Ia7hDROC1Ms3yb5i83VnYdkHXDwc8CcEK+iX
 khy2m4bgWBAsc5ihumrcm9rLLCDkux3jtoCDyY8xOR3N8jD80v9zQwlk96hwzWk5b5FR
 qkCA==
X-Gm-Message-State: AFq9FYLTx7tHGqP7dyFbBBSRk7rJJizo9qpaOdBRGs+L6d3XFmHOmT1S
 KENZYv7QMClMQ0cUKLnsupgoCNoo5jJNWNbejDeVwSh+TBNPvIdJ+6nnPT/h3QdNSswquHL3ek4
 fRg9XTdmTz4LL9fdE468HszkAp+PmrQBkBFHFZB7Y
X-Gm-Gg: AYBFou3KPAtrSiXKhZGvHf0KBysLTiwJiUiR3iu692iC7Rx2gn/jLOnpYKFkxN/muxj
 P4QTbmAlsfS/ZYMpuAN/gdP1kSMilvg32hQK/j0Tdf8XKliuEMeZvtX4/hDEAMLlWAMZdY4jfVa
 St5DiGeoMmYtIa1ehPPsNaGpAv1YtgFG5tM9xpEP00oJAzTX1uk0kETt02Jp31TWs+/dP9Tjd5E
 sz5TUqFrSL92RcntLeGXiiv528koedW6w5M4IFnmXA6s3BFwb1vVw0meUeDPY1teIrFqH40MtDi
 Ytz6Yo6JvpSUpySn2mPUoB3ugW8m3wfkdH9cM7Mh0+4gQ147iaBN/fCguVRcWMdWWERsBvFHrRd
 j1BnfBf/+EWJbqhn1I4HpKfU8LegSn8lu16g=
X-Received: by 2002:a05:6402:14c8:b0:6b4:21c1:21a9 with SMTP id
 4fb4d7f45d1cf-6b442ff31demr6848412a12.31.1793108794678; Tue, 27 Oct 2026
 06:46:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:46:30 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:46:14 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261026-fat-fs-fixes-v2-3-41ae696cd353@siemens.com>
References: <20261026-fat-fs-fixes-v2-0-41ae696cd353@siemens.com>
 <20261026-fat-fs-fixes-v2-3-41ae696cd353@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 06:46:30 -0700
X-Gm-Features: AclHuK-dVpyEzwetsk1y1CBuB46FffVWnfe16WEs3T5pMZhypOMGKW7h4UXNeuA
Message-ID: <CAFLszThw+YYdthEsH71-Nr_cTJjQ77O=UOBug7oF32g_d7BW3g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] efi_loader: do not trim files in Write()
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cedric,

On 2026-10-26T16:37:26, Cedric Hombourger <cedric.hombourger@siemens.com> wrote:
> efi_loader: do not trim files in Write()
>
> UEFI describes Write() as writing the given bytes at the current file
> position, growing the file if required, with partial writes only on a
> data error (EFI_FILE_PROTOCOL.Write(), UEFI 2.10, section 13.5.6).
> Nothing in it allows a successful Write() to drop data after the
> written range.
>
> The UEFI SCT checks this: its Write() basic test writes 50 bytes at
> position 0 of a 200 byte file and expects the file size to stay 200
> (SimpleFileSystemBBTestFunction.c, BBTestWriteBasicTestCheckpoint1 in
> edk2-test). EDK2 behaves this way too: its FAT driver only grows the
> file when a write goes past the end.
>
> efi_file_write_int() calls fs_write(), which trims the file at the end
> of the written range. A write in the middle of a file loses all the data
> after it. For example, a 256 MiB file written in small pieces ends up
> with the size of the last write.

Not quite. The file ends up cut at the end of the last write, i.e.
offset + len (602112 bytes in your cover letter), not at the size of
the last write.

> Call fs_overwrite() instead.

Please can you say in the commit message that this only fixes FAT.
With the fallback in fs_overwrite(), Write() on an exFAT ESP still
trims the file.

> [...]
>
>  lib/efi_loader/efi_file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> @@ -686,8 +686,8 @@ static efi_status_t efi_file_write_int(struct efi_file_handle *this,
> -	if (fs_write(fh->path, map_to_sysmem(buffer), fh->offset, *buffer_size,
> -		     &actwrite)) {
> +	if (fs_overwrite(fh->path, map_to_sysmem(buffer), fh->offset,
> +			 *buffer_size, &actwrite)) {

Please can you add a test for this. efi_selftest_block_device.c
already writes 'U-Boot' to 'u-boot.txt' under CONFIG_FAT_WRITE. It
could reopen the file, write a couple of bytes at position 0, then
check that GetInfo() still reports 7 bytes and that the rest of the
content is unchanged. That is the same case as the SCT checkpoint you
mention.

BTW once this is applied, an EFI app can only shrink a file by calling
Delete() and recreating it, since efi_file_setinfo() refuses a size
change ('Truncation not supported'). That is correct for Write(), but
supporting truncation in SetInfo() would be a good follow-up. The SCT
set-up likely needs it anyway?

Regards,
Simon
