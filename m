Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E5606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mmZu7vSm;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=b/7LKbeB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 943E2406A3;
	Tue, 27 Oct 2026 08:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eK-mu7-K-R8N; Tue, 27 Oct 2026 08:59:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 92D8940737
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091577;
	b=K2T/8Zf7lNOlhYiKni5pV1XMFdH79GArz56UFK9FZ3NOKDcyej9BCpnTdpWTqtwJwWlb
	 lhd1IycwfzB48fpNASopLl0DHuqjmckG5GpPHBFeuBjnnFLyaWdx4b/gX0WlV/yCZ+jz1
	 ke8JNeUdxzbWN+kOFuHRSk3S53GHod1hNs38eLDHDT8hBANVvYihk4jftWAJ+GJSz+kXx
	 vZDXFnJ337f1OnRophOKF2+ZihtO0p+rAU7KMZw3CJFG1uHqR9WNVetUxhd45z/vtVKAd
	 RMcZ29KB6c0Bpsj45IJ9EmCbpfHCtRe5aiKYL1sL427cjjjgrtymKl9WQDPbvH1xIgg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793091577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vs1ZI+Ijb8KLhKZzfp0m0poaCV5sor8J7nk+x8BHyEs=;
	b=Oci7tQIce92h1BMaqMca0+trLfx4WhOK1yYcowcPXA4K4njh7RWIqAywaZ7XGgpLLj0+
	 dLpfj8/TJEIlXjLe32Dd76/DpzAZ3vo+CFfX7aLsM0X/e9MI2GPSXzpIIJd3SgljcjIvr
	 3agXsBuZfmtVJsYGCasW3m+O5Sk2+CLiXuj+3x5HMMfnLadY4iESYKUc8yZv7YkEix7as
	 tFl10vijYIiKsKN7tuGyykA/KbJvzArV10lTTG6H+bdAOpD57Id1Wq/Ls96bCpQ5SaKeE
	 k8sJXv0TYDh5mHe6+MGTBcTgqRfAgTNwco8qxdqWC5HZg4PioC1J6UjYug68GXAlsFg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793091577;
	bh=vs1ZI+Ijb8KLhKZzfp0m0poaCV5sor8J7nk+x8BHyEs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mmZu7vSm97eZOqlGHyuf8gh8Shi3nN/LVRSNSPpFaT3x9NL9ayWPZcT/cMhGTdmTj
	 XLL9jqEzlmJaKKmKHlWLZIABn3Gp7DlqZxseTFelY10eb/yzlezc7Y2NiHlmln+WZA
	 V/sdl4wCEMVgWYC5CEdrFX0d7CV3NBDgwWk9MQGC9lF61HJIoyAmlDK5TC2Euqgrsi
	 JhEmAuT6QhOYhncNGoMrCeAHLzXbTwPHCs7cWI35VchhX3dZqF3/qBobUSt1m8WeOo
	 4lwCaBf+UAZ4c11nY9ZoBkWp1u4VI/XaJNBCggZZGzajD/S22Ipa5IVwdIP4TEilsm
	 fE4WRCpw1vzww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92D8940737;
	Tue, 27 Oct 2026 08:59:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D6ED4D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F2FF605EF
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msVIM7TFcLPq for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:59:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1FEA6605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091573;
 b=JLIrO/gIx9/VY6V92MmgvRkfR2clhxRl97XahgeiXpR0oBdstyGaP8OsmnCdFltHTr8W
 cm+E/p8xeGqa9OSbPjMIG5QIrSR14IdvrIWe4HfhfoRKTY+CrNeK1iLPa/fCL50M2On2v
 oCEntSEag+Q8tska1jrOznL30suwnGivb1QFlMZzgaLvMsP7PZ58VD2bQrYinkYTEwXvM
 jNFpo3h59WIZvQvHFyRICqa7oKciwpyyiPIjbFJQlz+o3pjuwRFMXZJ0Mv1n2Bft6VBUv
 jgDY7/BpDpm53pGTANfhiFBn/B/YYnQ3MurCUkCF0a5P2cYw3OFXTDrLZncCm6jBTcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793091573;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=vs1ZI+Ijb8KLhKZzfp0m0poaCV5sor8J7nk+x8BHyEs=;
 b=jaYU/zuR7JlLvFoUZp/cD+2HcABv78aDD35iXhniTm3SYZQSsctHcK37eaJqpocTEQiG
 QfktkofvY8tThOicBEjQ2UfftMVdKyuo5HhexRjkLX6nvnCiHkQtZuhLLa71DTIfisBTh
 d7zKlJi8V8z2HXGSUJGzk2/AyE37afkHUJVzchGaksWgmPO0XdrzsQrUnRLJKROAd8s1H
 Lk/nqpapWPwtbZ5Y+w33Fo0KtCHCP/9RV/+4vsW0HVn5WHb9q+5iy3PY+AdWXlVq0IeQx
 twXqCcoKnRFAfpRDNGJxRSXT8Kyb0jRz69KQC65W5THavEzQmJ4HxQb06GrxRLxKWZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="b/7LKbeB"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=b/7LKbeB
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FEA6605EB
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:32 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b45f9ec1ceso2216802a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091571; cv=none;
 d=google.com; s=arc-20260327;
 b=S425Q5TdwmY91cme3UPcqKSrTqAOVh1PSJwoQRwbu9O0O5H0R7VoOGqsDKudkpQm7D
 bWe8EvLnmG1jowa3yvj0qruB18jzC0tmGesvL86huhlnZlmievNOmy6jEjoMowojazag
 KOM7U2oT8X1twfz/A5dJog+dlAKnbblxWw62+TaW8gzBDUKtPw8zPC1wCbK62BrcMpKB
 HiHE3qWxfnH9/TNUVKvUdC0WUrIyAIQYdkCEVFtvKTVO35APrzTd/l/589QBCbmWS45z
 gmv91dl/9wwif89UnID/Oh92bYxpE7RQv5bRjZjJ92dfqWxXVhH0oFftWGmEfkHum0at
 RYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=vs1ZI+Ijb8KLhKZzfp0m0poaCV5sor8J7nk+x8BHyEs=;
 fh=/rdnnAgt/z8Y/gO/kkwLsOp9dS2eruYSp+dyjwHJTc8=;
 b=LEUQL8RLRhyCdajIBlSUFWtVWgnUeqOuq8GYIqFoBv5DwJoeCM4OW/9Hx6D2I06Nxi
 4ZC7NuuXq4jtgodKXKQGTe4lUt/CoHdznHl1fxj+6hVLz67zcIQEKUELodYEBXmIwMAa
 mA30x7ts/abigh+0zh5LzorrK6tKCGmLFA1DgmH1ES/+eLv1YjRm4TVA7XsARzx/BZ7I
 78kGdBGRIz65FmDJJoCT7t69g1yIqlz3CDBLN60vuWd9lq9OuStBfVp9Rm01aCzNX1Wb
 DEHBIae7ydehpZuRUPg6txsH8dTr7o4sJ8bMI91kS/YFbzSFnxgxz9NqMk/zqGmkGt6v
 CoAA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793091571; x=1793696371;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vs1ZI+Ijb8KLhKZzfp0m0poaCV5sor8J7nk+x8BHyEs=;
 b=b/7LKbeBp2ZvFUQS8/Kum6qtBAY+8jsOSLmiuiJggM5j7Jy346OtN3RaIQP4d8lJE8
 fUxaOm6d6jysuBnF0njb1BxaNXNsPi3pSOp9YxAcYbF8z/11v6N2fYX5ietW8AOdWvKP
 js4SB/67oeZvzz4TPKckFLe7VOzptcT+vO4mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091571; x=1793696371;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vs1ZI+Ijb8KLhKZzfp0m0poaCV5sor8J7nk+x8BHyEs=;
 b=hUoLNguYZ0EULCkguGAPI9rcNJ2///3AsRHPQ2KH1/fRyn4tagAkHXJTSrO1ly6oHv
 tWAQdX5uyoDZh0dqLG81OFDGY11Agdya2zoWlE0Anu9bAomhuyIH/X/xOS3iwIhySKtA
 WkAYd5ZyWMWWBupjqD95JQDcFXG1xeXQnKnyGXBJFvXpzQMdRkwylgWx0+XZyqVeL6pg
 afzkK480nuq4of+a6xtEGbM1DSVJJxozlK4yS6boxBkzbAz7zXCxB340nmzWfa3f7yEN
 xQBZHpsQmGWlMgSV1Pki3SNkJ5UTA9nYRBnF5QLLzYYrMtwJHDVfgBiMHD6SXcQjk6rV
 cFJA==
X-Gm-Message-State: AFq9FYIcgSDjXksSr2G6uQ7MXJeb+Svzh1P/fCHBFtG81wMn5yfKwMAR
 ZTMyRZQoY/uOfl2XLJAMsZO/fG9ByesMoNbsG43o+LgesKV+3ThoTPSqDFOC4p+lglhS6gcutPR
 XyLUGJP1vdad7r2JFFawvBev2h1AVX6IEc1R/DlQj
X-Gm-Gg: AYBFou3Xc+8RtVj9QyVj23suJQE89XZTgyI6NqVapZV+Z+iavNgeOvQlnLj90NIjrcC
 ohsullBPdBI/0HX5puHCStI1U72oKAvnm+R2Qovu8gMk3IoG4CT8JZGazRkLcoWt/gN802Qwcc3
 zCAOwJcPp0qB17L25YM8p5wu1E0Ynvx/IaO0We5BCAITTJvcxwCtJo4foB3mQp+R8weKFxNbH2A
 6Dk30k5vK2n5kr8y9rPGqen7x1N4+Hq8oxUrzx9sbEJlTn0fM+1Us3meIwAqzgPJulApRGVsC0i
 ztayWOcva42pA0AUWmrxfLP3ohEin5O8goVNzfrQ0tD1g8gcQ4tO8C9EaccLYwwHpqxzHNbtRXp
 5YnMAgIlkHW5WALcDAFMsvSCfKPtsdRYUUoJWPfmjyIHhtUoWTt5gXOdl
X-Received: by 2002:a05:6402:28c4:b0:6b3:8456:e891 with SMTP id
 4fb4d7f45d1cf-6b442a82a92mr9502331a12.6.1793091570681; Tue, 27 Oct 2026
 01:59:30 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:59:29 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 00:14:37 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <23ae3d1c-1d7d-4c2a-9b09-3216d53e4e3a@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
 <23ae3d1c-1d7d-4c2a-9b09-3216d53e4e3a@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 01:59:28 -0700
X-Gm-Features: AclHuK9ny1kHINR9lTiBwE6IYwSR2Qy1uPLPu4WOE9fOiidHI9gPjOyejwagrzc
Message-ID: <CAFLszTiXp7N1hw7DEY1NaJuu2O_1oBxPcbRfH2sx-5F2aqC+_g@mail.gmail.com>
Subject: Re: [PATCH RESEND 6/9] disk: part_efi: Check the header and entry
 sizes of a GPT
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-10-24T12:16:28, Ana Bobillo <anabobillo3@gmail.com> wrote:
> disk: part_efi: Check the header and entry sizes of a GPT
>
> validate_gpt_header() computes the CRC of a GPT header over header_size
> bytes, as the header gives it, and nothing checks the size of the
> partition entries before they are used:
>
> - the header is read into a buffer of one block, on the stack behind
>   part_get_info(), part_print_efi(), gpt_repair_headers() and the gpt
>   command, so a header_size larger than the block size makes the CRC
>   read past the end of that buffer
> - alloc_read_gpt_entries() allocates and reads
>   num_partition_entries * sizeof_partition_entry bytes, computed in 32
>   bits, but the entries are then used as an array of
>   num_partition_entries gpt_entry structures: with a smaller entry size,
>   or a product that wraps, part_get_gpt_pte() and part_print_efi() read
>   past the end of the allocation. On a 32-bit board, rounding a product
>   close to 4GiB up to whole blocks also wraps, to a tiny allocation that
>   the entries are then read into.
>
> As Linux does in is_gpt_valid(), refuse a header whose header_size is
> [...]
>
>  disk/part_efi.c     |  46 ++++++++++++++--
>  test/lib/part_efi.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 196 insertions(+), 5 deletions(-)

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -30,6 +30,12 @@
> +/*
> + * Largest partition entry array accepted, as in Linux (KMALLOC_MAX_SIZE with
> + * 4KiB pages): 32768 entries, far more than any tool writes
> + */
> +#define GPT_ENTRIES_MAX_SIZE	SZ_4M

SZ_4M only resolves here because patch 1 adds linux/sizes.h to blk.h.
Please can you include <linux/sizes.h> directly in part_efi.c, so that
this patch does not quietly depend on the block-size patches? That
matters if the partition-table patches are picked up separately.

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -925,7 +960,7 @@ int is_valid_gpt_buf(struct blk_desc *desc, void *buf)
>  	gpt_h = buf + (GPT_PRIMARY_PARTITION_TABLE_LBA * desc->blksz);
>  	if (validate_gpt_header(gpt_h, GPT_PRIMARY_PARTITION_TABLE_LBA,
> -				desc->lba))
> +				desc->lba, desc->blksz))
>  		return -1;

BTW the fastboot path still takes partition_entry_lba from the header
without checking it, so the entry CRC can be computed at an offset
past the end of the download buffer. That predates this patch so is
not blocking, but the commit message reads as if fastboot is now fully
covered. It could be a follow-up.

Regards,
Simon
