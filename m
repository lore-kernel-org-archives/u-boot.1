Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25922606A327
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 07:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=efnwwJzS;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=N8ex78X6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80C8C8100A;
	Thu, 26 Nov 2026 07:10:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s2H3UKCyV8XA; Thu, 26 Nov 2026 07:10:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 86FEE80FFA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795677050;
	b=FAQm7MHO35F0wrzIRVpLpHO6quIdDCuFYgBf5cEOIZK7/xDMl+ftPU/lhr9F5FSDzJYq
	 3OXW9xPhRalVpSHUy8cdEuqnYTu9iVQipN012IirevBaxAHXBIOMLa4z/bMvbH0elHD5I
	 t7jODFcdtvtr9Vao0937dTRI1s8AsUfm3StGtGNmm9e0fMV25azGRPYc7h0ibhDjTEBu3
	 YIKUbGwpUslpkSZwEJheE3yT5Rj9Mi2tkLDreXFBFydwyjNYSgosQv3+70jtZ8R1ggS23
	 jsiBmiclxf2E9S8BQVm7L9b7zM6/YJ96QghdiV8V8QGGRvIQVLgjUm2YDV7cE6Y018A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795677050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6cmsD8FZ4s3XYnn+RCYP0LFl7EIGsrvrK5Ktngw6HlU=;
	b=aCu/vctKnGSl7EfHix/e9twHtC1N7zlm8eHWFwbq4+mzOvXBwu0APiK4oxbYeEEKCD+N
	 JjwfJNtlXAb8pnoKt9MM9D0hU/jl3pv2vgc4wU7/tJDkxnHe6A6hHnyJJD5W90u2Ugzkj
	 HXVg+J3u5qW36EWazlTd9r8XyUkqDCHaHqgOtpEIfna7ra0yI1HFBHOBFA8/f1OJLgrrH
	 UaU2aBfp+qtYa+ZpRZLwvUx2KmIRZICgDnFKB1j0/7SgkmdfJPVuZ+s6TJVro/f3wZX7t
	 vRztUg6UX/fgXH/VwW+8FtUkBMxpIoDQA3+5D5i/xdzXyWYSk9bzWFo7NLraV26LFVQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795677050;
	bh=6cmsD8FZ4s3XYnn+RCYP0LFl7EIGsrvrK5Ktngw6HlU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=efnwwJzSq0qCFpt70WYXM7LzlpPw4xIrL36vgwc+N6Us1RGJIJRgPaR7eTXvTDftW
	 34UwvKeh4Lacn0k9nOGGKa9al82dh3CLhHwNLJ8kqQ2jFFsgL5WdgAdk5H5NEL9Or1
	 kIexTdZuUj0H4Etqwsq98glEDa8wqiObF2qAohrg49PNP82HzYG76r+TLVMxRykcVj
	 CXHREcec25DvCQAot5F/lWk2XculRbSnmEd8JhOQ1C37Xs3zeZx6PYeUkSARd8Gs07
	 TJFoNJa/1k2gLJBYpUTMsRaOqeM4+UKi5TPi62y3P0+IuKUxb0iZi2MKNuLcxIyOrg
	 znOWGg93L3UyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86FEE80FFA;
	Thu, 26 Nov 2026 07:10:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8937026D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AE4C608B0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:10:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mb0BzTDjTpmJ for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:10:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F8F160671
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=N8ex78X6
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F8F160671
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:10:46 +0000 (UTC)
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67db8985419so8311662d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795677045; x=1796281845;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6cmsD8FZ4s3XYnn+RCYP0LFl7EIGsrvrK5Ktngw6HlU=;
 b=N8ex78X6R2xSt6yK8d8hwyafzdvWFTqJlRgi6CECHDW1knTXGsQfZp+EjI7JrNID5D
 E3iGwD73RFDPONnCR1BV8X0vE/Q5URU/1lUZF2llCFFFUbXM/5DQ2bWuagxG7F9XB2jg
 9oQpBQws6qc/5xCEm+xN3g6BgYGX4NU5ZshkGVlDv6kJP4NMoaf1K1wRo19KhQ8p1Dos
 qPx05uQMxeL2ZvBx8DnxTM7CjMiUcH5X/bRdFeNQMaK4KEqevd4abXfV1eI8a5xz2HyA
 uPI9Bmr8K/n4v000CHFKcY6PXARMtS8DjGQkilWJFu33dAcWv5jpQ3YltSZBShAy/TVw
 1zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795677045; x=1796281845;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6cmsD8FZ4s3XYnn+RCYP0LFl7EIGsrvrK5Ktngw6HlU=;
 b=YVml8XQsrh/Vrsw/0mDvbNN9dwvHpKweBqN7w3aaHejvBM8euBW9O3G4jSKFIT/eXl
 s691jOaReFp9mWbWI26u4yI/264h/aL+rUFAe3QEGYiBM+rtoiD6EELVnOp2lb+MVivm
 pKH4RN9B8kdU/NuY6i/cJtm8mCpuDYU95I99UAtibBFryKx6ViPaLHOX64zfb75+j7Dm
 Ubonnyi/VemRNuW5JftFl6qHkdvZLy9HQn/WN8AKADiqxUTA76idWUmKS/ArWEl4eqCv
 alvJmoiPILyBEglEu+SqL5hC9m3mJrzZ3A7Ez29vB4B2GRv4WukRrkpXAQvcZAlo0b4u
 xu6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHSuyDeI7eva/9y4A0leGlmmCpqwsjb1HFY1DcC5L1JkOeTdmK41xDS/R0d9V8OVhMeHaVWsIE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+JJmM5Gh5o6Nj6Hg8l6dQp+RadJF8vbXnXKVhcZaovolZrVz5m
 Yc5gHIyYjLQeVa/3tTH8TGt+KwY5Bm9pMtL072LtWP6XGqEUArLbBRSVsjLUTdN7daJRj1bUGcC
 maa6lrNI7z4KYIPPB31RarAKygdoqKNE/2kc77jrLIBbj1JqO48FxrWo+uA==
X-Gm-Gg: AZFdTZe9mXw9fOw593pwbOMkj2wXBTw950fbg/xFB+/vJPjLDeVBbRXAce1z/aVdLGm
 zasP0WHuvlms5lCk6EHRgJ2DbJXWOfkmwVCQHAoNTJdM9zWJizt4D/+8LHTrTfQZ4ozehPaCHlS
 OJVqafSA7smEqTWzIELelQ6kzj26L3NT4a7FbECkyVIxcaGpWLKYwFk02j85oLUdYBHGvznAnUn
 VjM/K1WsDtNCT7a0VHytneqRtUPriCIsyvLx0oTgyGF+gnD1+3Vg86NnZd7f317hJpmojJvfmEa
 ZmIvlvsXB3NCFnqbT55D4N0SeMj0CeqejT+RwFFBbLBxLSGiTSmjQjoqAdTI/B+jgJ/08xZYJub
 o/mOL4RLBdV7rvgnDE/sHrHao133IpPB7EFt7migXs/DIIaSRSzIbGmtPa61ZLm+bdK1ny8b0SI
 an3BDpOudFbcNk9IJQOYmk0jpRJkRHUkmWb186f4idz5LKAbS2ozGOq0prmafvbje8GEGAtnY71
 TbTmt6tLgNV0dcPlM9RZorfU5uTs1fy9i0ZEnx0jCIwwZRqQI4sGgdc607DYvVDKkeKw+RCoEe0
 Ob+I8M9YXnS94ptPkWN5v7S2PeF5DqQ5t0kIcrenN3U4QRqCwBjAFIBLJZFeuacVOtzHwzDiFF+
 SCtmlj/PxGS1mbw2YIVGub92MBUAw0eXgpEJ+osgZJHt+pC+DKbeFpXTfrEQdMg9IiU+il9N/sI
 Q2Qm97zjvKbHQeoqmKi4QK0074pByvoLU/1XvsULlK+FRWnDD32vEr5Hqim8qdESnYXwbZ0/0=
X-Received: by 2002:a05:690e:4594:10b0:67d:a798:40b9 with SMTP id
 956f58d0204a3-67df4410889mr6435292d50.16.1795677045499; Wed, 25 Nov 2026
 23:10:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
 <20261104-bloblist-tl-fixes-v1-2-477121908257@baylibre.com>
In-Reply-To: <20261104-bloblist-tl-fixes-v1-2-477121908257@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Nov 2026 09:10:09 +0200
X-Gm-Features: Aa3M54psQ8XVN8sryc-X8gvu9AYmzHKJwenvgIzIgGJM9Xee6jc6gSAA7JMjKUc
Message-ID: <CAC_iWj+jF+qsOA1vWNP6=pMq=XCRahOVbccJQz-AWPACRHPm+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] bloblist: move to version 2 of the transfer list
 header
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 23:23, David Lechner <dlechner@baylibre.com> wrote:
>
> Create transfer lists with header version 2, and accept lists with
> header version 1 or 2.
>
> Version 1.0 of the Firmware Handoff specification is withdrawn, because
> it specified an XOR checksum while implementations used an additive one.
> Version 2.0 went back to the additive checksum, which U-Boot already
> uses, and changed the header version to 2 without changing the layout
> of the header or the entries. Since TF-A v2.15, its transfer list
> library creates version 2 lists, which U-Boot rejects, so it loses
> everything that the earlier boot stage passed in the list.
>
> Lists with version 1 are still accepted, since existing firmware creates
> them.
>
> Link: https://github.com/FirmwareHandoff/firmware_handoff/commit/dfb62d83c735064291a249d802aabcf48bffb8a0
> Link: https://github.com/TF-Shared/transfer-list-library/commit/81d7f820853aa117a0458ada3b9892c619233db1
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  common/bloblist.c      | 10 +++++++++-
>  include/bloblist.h     |  8 ++++++--
>  test/common/bloblist.c | 21 ++++++++++++++++++++-
>  3 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 4ddb4a56944..90b70b06826 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -467,7 +467,15 @@ int bloblist_check(ulong addr, uint size)
>         hdr = map_sysmem(addr, sizeof(*hdr));
>         if (hdr->magic != BLOBLIST_MAGIC)
>                 return log_msg_ret("Bad magic", -ENOENT);
> -       if (hdr->version != BLOBLIST_VERSION)
> +       /*
> +        * Lists of version 1 and 2 are implemented the same way. Version 1.0
> +        * of the Firmware Handoff specification was withdrawn because it
> +        * specified an XOR checksum while implementations used the additive
> +        * checksum that version 2.0 specifies. Both are accepted for backwards
> +        * compatibility.
> +        */
> +       if (hdr->version != BLOBLIST_VERSION &&
> +           hdr->version != BLOBLIST_VERSION_WITHDRAWN)
>                 return log_msg_ret("Bad version", -EPROTONOSUPPORT);
>         if (!hdr->total_size || (size && hdr->total_size > size))
>                 return log_msg_ret("Bad total size", -EFBIG);
> diff --git a/include/bloblist.h b/include/bloblist.h
> index fcd290eeb16..f368a6acb85 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -76,7 +76,10 @@
>  #include <linux/errno.h>
>
>  enum {
> -       BLOBLIST_VERSION        = 1,
> +       /* Version of the lists supported here */
> +       BLOBLIST_VERSION        = 2,
> +       /* Withdrawn version 1.0 of the specification, still accepted */
> +       BLOBLIST_VERSION_WITHDRAWN = 1,
>         BLOBLIST_MAGIC          = 0x4a0fb10b,
>
>         BLOBLIST_REGCONV_SHIFT_64 = 32,
> @@ -179,7 +182,8 @@ enum bloblist_tag_t {
>   *     blobs can be altered after being created, this checksum is only valid
>   *     when the bloblist is finalized before jumping to the next stage of boot.
>   *     This is the value needed to make all checksummed bytes sum to 0
> - * @version: BLOBLIST_VERSION
> + * @version: BLOBLIST_VERSION, or BLOBLIST_VERSION_WITHDRAWN when created by
> + *     another boot stage
>   * @hdr_size: Size of this header, normally sizeof(struct bloblist_hdr). The
>   *     first bloblist_rec starts at this offset from the start of the header
>   * @align_log2: Power of two of the maximum alignment required by this list
> diff --git a/test/common/bloblist.c b/test/common/bloblist.c
> index ef410ca62fc..3ae5eef3859 100644
> --- a/test/common/bloblist.c
> +++ b/test/common/bloblist.c
> @@ -69,7 +69,10 @@ static int bloblist_test_init(struct unit_test_state *uts)
>         ut_asserteq_ptr(NULL, bloblist_check_magic(TEST_ADDR));
>         ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
>         ut_asserteq_ptr(hdr, bloblist_check_magic(TEST_ADDR));
> -       hdr->version++;
> +       hdr->version = BLOBLIST_VERSION + 1;
> +       ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
> +                                                    TEST_BLOBLIST_SIZE));
> +       hdr->version = 0;
>         ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
>                                                      TEST_BLOBLIST_SIZE));
>
> @@ -92,6 +95,22 @@ static int bloblist_test_init(struct unit_test_state *uts)
>  }
>  BLOBLIST_TEST(bloblist_test_init, UFT_BLOBLIST);
>
> +/* Test that a list of the withdrawn version is still accepted */
> +static int bloblist_test_version(struct unit_test_state *uts)
> +{
> +       struct bloblist_hdr *hdr;
> +
> +       hdr = clear_bloblist();
> +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
> +       hdr->version = BLOBLIST_VERSION_WITHDRAWN;
> +       ut_assertok(bloblist_finish());
> +       ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
> +       ut_assertnonnull(bloblist_add(TEST_TAG, TEST_SIZE, 0));
> +
> +       return 0;
> +}
> +BLOBLIST_TEST(bloblist_test_version, UFT_BLOBLIST);
> +
>  static int bloblist_test_blob(struct unit_test_state *uts)
>  {
>         struct bloblist_hdr *hdr;
>
> --
> 2.53.0
>
