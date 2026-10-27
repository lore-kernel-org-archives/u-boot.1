Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59E606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Bl25C562;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lFm2nCz9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1051F40738;
	Tue, 27 Oct 2026 13:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lqcqQsfs0f4X; Tue, 27 Oct 2026 13:46:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2D02440721
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108795;
	b=WzSurTCT8OnQcapWfe23Bt+41nL3qkXXa+gcQ8/5a7GiyTrCdRgML5U7lyweVStVxpsG
	 Hz/qGxkt461z35Gvmslk6xoFzfeOJbZ7uk8dFnLDTIoAsbllRok2WwwcqPpgJC8HiTBRZ
	 PReI18uuslvOQHpetMWsdSOME6L83Y5N/kWebAurOwMoNAvK5CalAtoC5pTpqrDvqyXYB
	 6pyFicjNbJ7dSzPDKVDus5/uNyiFediQ8+ll8qCvNI/D1e2EDfS5dhya7x5ZGEgqiusfZ
	 PhDF6V8Vf3IFLSPddeEQCpX0IMPUcbrP0uPs2tUcqBm1tt0zZwgdy9XNLG+3b8fPUmw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793108795;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=selb6Hu3x+rQeXPC6xrze7opEVbjfusVNKWMlL8a4Ko=;
	b=b/4qUE6oyVeSMAlzno18qquLFKv0sBEFq2ifSBK0FZx/cFgOG0JOnvNRuKNS5jDAQlBz
	 g68nK5I2Ffz52CNe72zoopKBJFZYL9a2VF3wh26umuUoJtfcRDyfJjdjRXAMweB6/aXam
	 i/USHo5PqHr/zWnW8PmlUBPU+BRvvdX6z8R/0d9ajfvXSpINvZk5T7xBwbrxloyTeaSyH
	 B3Q0jhf3yBppoODDC1IU4p488ijtaJrww6J01RTf4kAR5K9VIdfZoGCDAkoXW52gev+yq
	 qIw9ocDkOpHJD736GAU2TB3A8YW9AcmJsilwaB7rkOJeVmcb4qOduBfYtTq4fV0eY2A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793108795;
	bh=selb6Hu3x+rQeXPC6xrze7opEVbjfusVNKWMlL8a4Ko=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bl25C562MOPQo30NUlgOBwG1vOmrm3+n49xywLaD7af0Q5zlKeqjXWRP37VojvL0T
	 UmlaldYrEdtqspWMf78IrYD5XyRsCVdmrLrdbKNB1RmwcRRyk73bEARfouvF22P2bf
	 na2xEAFLu6Avs9JB7WvWDQulHIJJ1QmfEaq0rPWJXiiFXim924to0RDAbt1dfHOaMo
	 FDT18QEjXfbQly8o4QLKGU2flaH7P16GP00Priv7YvoyUNFduvggK31qbZriW1HhuE
	 dnejaV0gbciw0LK93hOy54u1I9BXEB8ejc6sSAMmthtKYhi/zCWDh4Scvnxx7Y6hr+
	 WyDXc0xzh1ZxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D02440721;
	Tue, 27 Oct 2026 13:46:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 29B512F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D329F60759
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vEhSJcn2JYc2 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:46:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B66416076D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108793;
 b=SnGfVLRn/poqyMGk2jZQQOqP+Cgr6BLJUe5IIq8yxzcaSAJLXpIGiaLsSyUJgk7LgxZi
 FoIpNfBPTteqtunaiIwFCDcHJ/X1pu/7eU20NfV1F0sYppB2nJLEod+vTtnaZ0suUTX9w
 /rUhYfAo9a9tUr1P10nYend05I1cCLb3nMrvqozuSu9s/jkfNedS56rGzK+gPKG4NOGyH
 LG2fUYBx/hG8wb4axBen+Tu5x2UbEHS3oDEVVoshdC8TVNivGCQW74d978depx3c53Uex
 UBzwCjn8ud4uLRdQSx4yC5dmT3DvYNoWE9WRhYOkg8eWt6qdzYIMxNvklQlQrXtkM/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793108793;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=selb6Hu3x+rQeXPC6xrze7opEVbjfusVNKWMlL8a4Ko=;
 b=j/cMsoNY38DwBEfSwE3+7bxm2zm0+qD0LZoDfBkAj3a5eytwvOu/8umpeKd41uf32sc9
 feZVerE2rHE41ScBPVVzsiMWk5DKcBJNCEioTCfe+DU4MC23MKgIF+mnH9ndr9aUEIhQR
 Grt8j6HUTMRv7eKTPqTFuF9X4fTptyjZn9EWmgEJKqP3rKkVw6CHj1AQQuU/wEStH/yXf
 b9w5zL8wBPhooF43iUemKZZ3Hw5KCu1jGHZVDmN7+gDzUmTQ8FeZBO2NHVSg/q0pySvtF
 50qFuYuF+b0szHTuyW/fVYaKOYD/Pswj9cnC9TqPIKnRL8IOWlMFYgU+59Fw2vpfQFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lFm2nCz9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lFm2nCz9
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B66416076D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:46:31 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so4928025a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793108790; cv=none;
 d=google.com; s=arc-20260327;
 b=W22aAZ+pQNeObUd/OzTcLg9tSmBDRzdHrF8t/eHdARNtk8V4bHOkxXfNbB+OhujoE4
 bzSItp1pkAjZoqLiIId02pk4Ju95pjANwhrGJhx/Y2eLzqh5IxHxT38lt3M8YHT1XC4d
 3l/frBQN44kfshJSwiatyHvf+zVbVv/rEwb1gnYVmKgUuCYX88dytW65yn5xqZGrX4b9
 h8zIX51Bn2ArUy4+eA5t4lBSitp8IYuIuBidNVbR5L3j6bUUeZmtJpaOhv7s56U7/klS
 TTpj5VO+UmsALQL553g7Oi+8Sj1Vmo7WNf1O9XuQJ5Y/bOePng6FVh8qkp9l6U4sAjzM
 MEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=selb6Hu3x+rQeXPC6xrze7opEVbjfusVNKWMlL8a4Ko=;
 fh=uOXiX/FK7Op6ux3YVCK3wLiLMkejBefoITtZ4+fQo+M=;
 b=iqgYzAISMaH+rgM8GstMU7kx9fgxZE37+g0DD6hPaM2xjXMRfuROIQzaPCJUxUY+e0
 MEBMqqmoHCk32uFsUFB2mohlKCsNx5wKvektgqNn8jRS1JEAuLjVSSzxCx5sX7V4Qcg6
 83KM2CaqGlL/QmI0wW6eeximHafVHLloOtgdPyiV2U9QDguJ6gmlDXZAyVox4eN34yZs
 6enXv059M0PmzwpklyGrYv1NdOWo9HrFJivzNf1Tqm8dj7S9BHw1frgUmhk53tSgSbkp
 aMiJOBYiQUVqxBqEg22ipsX6upHXPxJTuCwhA4yBEbOPSK7cPE395R5u42oIQO/eZAaH
 WhqQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793108790; x=1793713590;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=selb6Hu3x+rQeXPC6xrze7opEVbjfusVNKWMlL8a4Ko=;
 b=lFm2nCz9oYMbnQJ2Eqo77DZMJiw3ZuORbfgQVV8Y/SJW7ue80i8kGiWLU6g2DjgIwi
 rDouz+7ZlaarbyBGBK+0Try20JF25zYj7CAg7X3KRNzfhpk9yrJqQecPNvU7y6ZrnEhq
 2koVN27wvqyfwIuVjvDME3m/MjC6SuCqfKt2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108790; x=1793713590;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=selb6Hu3x+rQeXPC6xrze7opEVbjfusVNKWMlL8a4Ko=;
 b=S6h50r3yPN80j9yRYtVjSmDIIAip5yXVOTPlFnxExZGVk4UqF7JpomDlTT8d0XBMa5
 O/onLEnnSOzjzIfMLtphJkvH7q07yZKhuFYC2Qe5n6YtEwf4pRPL0fxMOFyCWzKuwHQl
 l8xZzKD5X2dPde3mgtxkKOjNVSnTgI3WgCUMlXOkP+Zq4dG8xSYhukaZy9VvArq1vZiD
 n5twiIcdFlZqGmZ3x+6ZYx5giElRDgmSE14drsC5k2Rmgiv+L67pNvN4gvX+2GO3YJ/7
 Go+Ddbq0pHtBg9gZQ+mM7iQ/8erp4adWRIsrY6PPWLa1hDHmhqzPSj/PAxpG2CvUGHbo
 uo2Q==
X-Gm-Message-State: AFq9FYJC+0hvATv3WxT3cvJiqf6Ar4kE7NCG8vA3ARzWMddBOyZ6QbEs
 S/h6dqavx3lPGW4hSUwakH4Z5gzrE4oaAqMiwbhCfMjgQ7m+FtcFPe2YJBgqUXGScTr4qDLnbBo
 /m0Zgj1QWsDIWN05q0fd25Uzd+VT74JSP8dImAnfMphjRWSCCnzbQ8w==
X-Gm-Gg: AYBFou3yw2DZLopeb+8FeaPN40QYaunvwNtgNuAMYYgxGqs3dByubDY9Ya4IKCsE+cW
 BFExY3CphKPsHtbFYKDcu5z61eak9vnfuHcuUi61kVi51bwKsb+/aS90/u7+UY9eJwSOljlL4fA
 KXZEv3b3Vhq1XYyaM/zcBbAM4laCqlD+mwu5EmJYNzSoiKqb8pbAoEeO0UCHvFgO/ANvOvc9Jtc
 k5tGjUceUGKGQrIoHUgNFmyjSZ4spSwdFeggoTyD/VKIlr/skV1dG2eSauCqOf4QDevlJXIF2wp
 5HOAKQeVR5vcAC1GIqZjc/2pvRK4BLR+jk6mAgfRR+KJLtmC0X1oT2YzegMborcH5iVab6lkW52
 gXJayBmAQtTPoTxe9hYiyxOfkmuhdDp8PAXi0bdMHDEY0JJE0Y2LOwtDTTA==
X-Received: by 2002:aa7:d642:0:b0:6af:80c4:8981 with SMTP id
 4fb4d7f45d1cf-6b443001da4mr7585640a12.26.1793108789715; Tue, 27 Oct 2026
 06:46:29 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:46:26 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:41:42 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261026-fat-fs-fixes-v2-1-41ae696cd353@siemens.com>
References: <20261026-fat-fs-fixes-v2-0-41ae696cd353@siemens.com>
 <20261026-fat-fs-fixes-v2-1-41ae696cd353@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 06:46:26 -0700
X-Gm-Features: AclHuK_LB9nbBKhzxedrxgD3VEcZC_Sz5kEaNItiCKfVO9fCa_o0sI1J1NuLR-Y
Message-ID: <CAFLszTgCVD2z+_H5c7y9Bozydx8DAHxZqb1+A8Moemajinn3jA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] fs: fat: add a write that keeps the end of the
 file
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
> fs: fat: add a write that keeps the end of the file
>
> A write at an offset that ends before the end of the file trims the
> file at that point. This was chosen on purpose in commit cb8af8af5ba0
> ("fs: fat: support write with non-zero offset") to stay compatible with
> the interface of the fatwrite command, which replaces the whole file.
>
> Callers that update a part of a file, like the EFI file protocol, need
> the data after the written range to stay.
>
> Move the body of file_fat_write_at() to a static function that takes a
> keep_tail flag. With the flag set, set_contents() does not free the
> clusters after the written range, and the size in the directory entry
> only grows. Keep file_fat_write_at() as a wrapper with the current
> behaviour and add file_fat_overwrite() for the new one.
>
> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
>
>  fs/fat/fat_write.c | 32 ++++++++++++++++++++++++--------
>  include/fat.h      |  2 ++
>  2 files changed, 26 insertions(+), 8 deletions(-)

> diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> @@ -1535,7 +1537,8 @@ int file_fat_write_at(const char *filename, loff_t pos, void *buffer,
>  		/* Update file size in a directory entry */
> -		retdent->size = cpu_to_le32(pos + size);
> +		if (!keep_tail || pos + size > FAT2CPU32(retdent->size))
> +			retdent->size = cpu_to_le32(pos + size);

One thing I'd like to check is the zero-length case. With pos == 0 and
size == 0, set_contents() takes the '!filesize' path at the top, which
frees the whole cluster chain and sets the start cluster to 0 without
looking at keep_tail. The directory entry keeps its old size, so you
end up with a non-zero size and no clusters. EFI is safe because
efi_file_write_int() returns early when *buffer_size is 0, but
file_fat_overwrite() is now a public entry point. Please can you make
a zero-length write a no-op when keep_tail is set, either here or in
set_contents()?

> diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> @@ -1578,6 +1582,18 @@ exit:
> +int file_fat_overwrite(const char *filename, void *buffer, loff_t offset,
> +		       loff_t maxsize, loff_t *actwrite)
> +{
> +	return fat_write_at(filename, offset, buffer, maxsize, actwrite, true);
> +}

On naming, see my reply to the cover letter. Here,
file_fat_write_inplace() would describe the intent better.

Regards,
Simon
