Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BD606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gbCxl3ME;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Pz1rTOqL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21C2540641;
	Wed, 28 Oct 2026 08:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QHzI-GX9wCiJ; Wed, 28 Oct 2026 08:56:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 267CD406C9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177802;
	b=BwoNxHmRAW/UyntoS2VRa+s2NKb//EYzBY4fZp+Ngji1G75PbQdJ6lBJP/QZOBkq2ZRC
	 LEI8pUonq2/paRiZukFm6rV2lUuwAcH/XjujWFxBIHaDE6C+exRQiyEjIlWveqsZe2Z7u
	 RWSeLsmoAH363k59ouaqczf3QAeSfpEhAjnNVMmNGX3Dj3xrD55Ixzjamxem0ZM8Eoh4z
	 iglKx1cYIzTNwnWCVMYCyWjeGUUD26UuehS6GfSdoQxMftvIVDXDXC0xrWjUyrVV+9cL+
	 DsIx0WVCLT2n8Ipf8pv5LwNBfbTw2qaKA17Wz5ST9nO5Iw1S8W05VjmXYnSWNT/o2gg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=iNbBNSX63wSoo7KujoTVI3ajmXs4YgV2mh/JpAvVp3w=;
	b=cGQjWDF5Lst7J4gG4V0sO6FxYHgE6MioWsJZGbuwSabAFzs5KhKfvyPIl2WXw2l5nScb
	 T2HhDRvWjObFr9CLT20Qo9Xypk0SCSBuurwKqnJp5aNGeC1Ym2J3gTqIM3fx0g8poG4Qf
	 mJPxCVjcCOc1t5ThtpnLu8EKwCTDC7rwnMVssxmMlngD114ylcKsZI5kI+BdQtyCJPxRd
	 4hoejGKxYOcJ7aatN3tegPIAhYsfrXfKhocxWbs5i8NnJYWUgRoIDiSMGGaAvSZFstOv+
	 nzL/9AoUmPKdWZsjrnzkzbu6N+yw84NWbr0BXNrB/qrtcBXI2u5jDbxOPicLYMVdnmg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793177802;
	bh=iNbBNSX63wSoo7KujoTVI3ajmXs4YgV2mh/JpAvVp3w=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gbCxl3MEicm+WtMqyk8khoz2Ajdu/b9hHXqAwRemm6MlBSYoSaSp63wesEd3szYbL
	 /Dygyo0MHOyr1ce+zzrR3II5B3qnGC+C5yIfSq+s7+ZCSWkQfsj5rvWFL8s6ukRp9V
	 ZG8OWK6r2Y07j4/ljV+V8r4M8AtEkTPICZ05w8dh3wM0NPk2nal3LbOhe54x1bsqq5
	 h0rURWnw+7FT6dW1fJOlDBeFY+qniFZKVCtJvAkzNs0yjFed4gzi7ZaUSvUrGAA0iP
	 oRQ+zRZG/DoEcgCz6lW+wXaBj5aIyTlGhm1NIZ6i1VNgQKExmtBO0oRAR12qpT8Pum
	 B18raRT6ZMx9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 267CD406C9;
	Wed, 28 Oct 2026 08:56:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ABF884D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E3C580CB9
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkGQdoR2LPuN for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:56:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5D1E80C88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177795;
 b=nD3jqDgh5dZOjmSwgBqEcaNovrQVPINz8F3qkcumd1AVOsDTQeAcySwh43buXZp7+MQ5
 ygRR2fGQwNxqDQMOFqVrJOUCZN06mUZ8x4I1mCLpCa9t48f3cRoUHTvbGonIInSOGD38d
 zvkTIEB++UZuiJqJC2+OcMeOu1zxqkMCdpYQyfzGe+naNeIz7LNrN0XqMum2NugSdDUwN
 npEefKhoQPJR8TK2O2hc3u4gL0lIR0R7AGS80SuFrcLnqqahws4cRRZuj9EomNUUJ2c3c
 zEBvNh1pTqGQAI9Kgxj+jImgvR+pV0+kUAIEWcjI4V7KPtfHufg8DHD6vp9PZQUjlLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177795;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=iNbBNSX63wSoo7KujoTVI3ajmXs4YgV2mh/JpAvVp3w=;
 b=tM1mQTLDWlNxShNNYI4+BNvU9PhebaRus6PpX8SEHsVZ4gvU/lLsgX1bV13GpISN94Eh
 EkoxFMYFaOyyJo1Isbj7778GVMP7zDW+Yl3E7GxY4+yKX9UKBLCPGydkaFmagQtQHOe9a
 eZAWikcWTYcdTpCtcHvWNnG3fISE8NRH9iDucTt+eip8YFi9cnqu5qlwdlrCtLKorG8P+
 +PahpXr9UlgQcESZc5yWOIhqg5nxo5jCIBxVO5btCfIbh/NumET3NloO2Lc6X7eUvlESh
 tzry2jfDglhLPReYCRbgvx3jqsn1JAeoIHa7VpgHlCwukmB8PqZchbX3rz2Wjczaxtw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Pz1rTOqL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Pz1rTOqL
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5D1E80C88
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:33 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c315869241fso103675666b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177792; cv=none;
 d=google.com; s=arc-20260327;
 b=n9SWZ4hFKmRmNMQEu2XF5K1dtF4AhrkE6OqRurUv7PdxMUBm3L0hZq1jY+g++sPJzV
 jbBFmdQXbk0KTy54r34ny4b5o4roYy5qGMLLjvg5ugcto62BipqK3gTrISgfFUvQsa8Z
 ZHzxQyv1POLkJFo1pOlDo3CqnQ9dbpscgvFafbSkx6awGccpFR35w+LQlLCHrUhOCTZa
 T7JwTO7/ty75RqUgIzMJElFkOZuxDBe16doalhumTfMM623Ducm9ydRhzkD5ipaYYWNe
 IDYwBAt93FzCe7GwE3n6D71NvCpPqYx6G35OJLLSzba+Mt6/n2SHfrqIJP7ORmYmzk3X
 Ilcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=iNbBNSX63wSoo7KujoTVI3ajmXs4YgV2mh/JpAvVp3w=;
 fh=MDrUQB0MSkrYZRpfCYqPxmxpYwAn3mJ+4I/XMiiFQIg=;
 b=NufGBzs9AtzN4Ql/gLXMPFcrhisHBIO8dM/jd7m5ZIS+T1B5E82CMjeOWuPMDzJbxS
 1gD9vzgY+R/jJKJZMqcR9IVh3F63YEY85/7gxfGJqIt/uZGYV/Tj/iwpyewl73BPrgfB
 uTr88bFMHhtFs/YvwKCPwrXEYSDh0YxMlh6R1FFwyLgIi7oLMV64uxDjwhhqYjfO9HtO
 37fgDLG/9OWegrNf5zaBzOnK5piJjLtPQlC1AheFEQlmxf3sBa8pzluvEgPHhJctolVp
 tiQL8r8X8Yt2i5Bt/c8phdXG1FQ7xK5wOoviFzyym+grGzhaB2Pz4GVyWPE51/tKO3fF
 R0UQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793177792; x=1793782592;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iNbBNSX63wSoo7KujoTVI3ajmXs4YgV2mh/JpAvVp3w=;
 b=Pz1rTOqLsKiPvEs+XMiHKUxFXHZ+f21KuzPzGGqN2rsXQtUqOoJtRP0KGrnmIhUwu5
 d+2JsdybE7G5f0Y7jZQe4jU5fKq1Emiy3YAhiouQFhqetONNLs4SjPQ7KS1Nmol5iDyE
 leWtxIwXFIRe+KG1ek54Hmb0PfXQS22n/pfI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177792; x=1793782592;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iNbBNSX63wSoo7KujoTVI3ajmXs4YgV2mh/JpAvVp3w=;
 b=P35SL8JsevCUwD4tPBZz2hI3ndhVYyeCBviffXrcfUZRmkf7kUa1UtlCrihAwAHas/
 dc546tYDBGmmRBZwYK+ZtNnKTmfWG2CH/xsMYq2kpJmG5+CFoiOmomFjODkrvn3O9oW0
 tuIw4L7BbXHDzqkVFL/g1sJ1VX7/Vr/5rhvenZi5EyW7NDoOd7f3uGEJ2cPR/tJaSMDz
 IiiRN9q+bXwEoFVZkPxMvYAnaDqacrCTIza1zfB7c/phaJHmnE48IPWrCQom9HLplkC/
 xVjTX+BX4FbCN3K3883rCvFmon7V6Zg6tEGVUIzaNDU8PM5A8EczVBlhi7m9sfIH0QzJ
 X9Yw==
X-Forwarded-Encrypted: i=1;
 AKwUvByDlYTvV9523x0O6hYbNIpctBU3HRwMtM9M+WqaqIkuO4OUScC9AeVCEHdKl9ZRQa5iCkMAVs0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKi4VlfN+ldMFmEB0TP9D1CEgLKKK/q7mLio0EBSkELSgJF6a6h
 safcqUju5GXRMMq/03wCmCF7ClFFF92qkIPyx2uZwhCTrPMND5468Zpz0jjEwTXkHHcWgys4SpS
 srcZDS1MbtvtHHphoz/A6R2g10e4qniRNl9NwJMZy
X-Gm-Gg: AYBFou1MZPbPOnekJOztmydiq2DRiVCzlRH57hocPaelF8JNLZgrdfwQQYRmXSqwIx4
 HWveHk18UFl0Src47N/Itp2kEpqv51jfrpOvX/A0KdV6iC8N1WKoFCljPCds3aJblSbpPqo5QgD
 xU0D/T/VyNMZhPJOn//b0GOY62udVVuyDjVcva+DR5zrzLrXqIHdgv16duH6cG9mGSeZszMfMg2
 YcXEgFfAsiyoYkU1NVE8OWwCXzD2HHQwy5PXyPTEE3uZ8lCS2iiL+KDMzD+bBfbFTbCGxzxHJuD
 +z8E0pdfJ+Hj9eUclWId+xSkjwuXpZuT3yKKM6+2synnmLH9TixyOEaQNdOGQDz1hpIKZW1wY5M
 RSVwih/f26PSg96SBTT8q5FL6ayp+taEXwTg=
X-Received: by 2002:a17:907:e84a:b0:c46:cf73:bdf9 with SMTP id
 a640c23a62f3a-c49bdf3e78cmr137520566b.21.1793177792076; Wed, 28 Oct 2026
 01:56:32 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:56:30 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:29:41 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7f6c3461-f084-4682-8638-212ab29c69b9@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
 <7f6c3461-f084-4682-8638-212ab29c69b9@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 03:56:30 -0500
X-Gm-Features: AclHuK8OpmTEsx8d9yFv6r_M7NULKUvjv85iwYLwZ8wrmDpHpSjCLeD12fZekpQ
Message-ID: <CAFLszTiq63bPEXYByQFr8pL7o8KkF=r2VctZqUckO3ybqm79Ng@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] usb: storage: Refuse a block size the block
 layer cannot use
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
> usb: storage: Refuse a block size the block layer cannot use
>
> usb_stor_get_info() takes the block size from the READ CAPACITY reply of
> the device as it is. Once blk_post_probe() refuses a block size that
> blk_valid_blksz() rejects, at the end of this series, such a device would
> fail to probe there, and usb_stor_probe_device() would stop, skipping the
> other LUNs of the device.
>
> Check the block size where it is read, and treat a LUN reporting one
> that blk_valid_blksz() rejects as unusable, as for a LUN that is not
> ready, saying which LUN is skipped. This also covers the legacy (non-BLK)
> path, which calls part_init() itself.
>
> Add a test where the sandbox flash stick reports an unsupported block
> size.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  arch/sandbox/include/asm/test.h  | 10 ++++++++
>  common/usb_storage.c             |  5 ++++
>  drivers/usb/emul/sandbox_flash.c |  8 +++++++
>  test/dm/usb.c                    | 51 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 74 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
