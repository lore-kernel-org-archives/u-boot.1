Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E7B606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nqG9TLrq;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ENaHVxKr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1120840748;
	Tue, 27 Oct 2026 08:59:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XYty9Yvv9PmE; Tue, 27 Oct 2026 08:59:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 38F2B40664
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091588;
	b=XbzFmcv3QnH5ohuE1q3ZrwHtM1je1H3K7LLBjifnZg8A9FRfvtP/NLgvhfZaTJZXMlNV
	 FjWv0DA9Ly6SnmloY97KGwawltgRm7Xti+0N9KOmwQFnl8Hz2S6P8egbrG5EumIy3TrCo
	 It4KUP7qpfCxrl6jweak7oJkAbwE7kX9A/8j7KLsr1ecJDc6rDx66a8rrOjKMPpsTmZ6L
	 4IUCNNLfsWYSy+dOe89i7X3SF5qGRijew18ELxfiI8Y5fgIajrA2oc7Aqp533nII3J/M/
	 ZKzoZDX6Lu3Bupxrvu981BbKySed9QksNA9x8iWS/57lkZ1Xy/AaW68m/BAEpKQdy4g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793091588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rr5lFc3FcWemagY5kyZLCUAwdWVy9UBprRVl2iClq1I=;
	b=RCvFbaAm0jpMrtZFFLy86ZM8yS1z7JMQBRdms80r1dnu61iAmok7MpQy1QwMWO226HZK
	 KNW6PGtObxRCJrubIXGvVY5skvsU4DFXYQfg3nMmiGLxc6PlTWriqvATtt3kKFl29AbH+
	 uD6sVZnfSDowWs5vWb0X696PvZrEAficRHQpR0TopXb9vnFSy1Pq73WbD/FtSmk7GaMIO
	 sG2Ollc1tfgbkqRTFmj9by2wlhCP8+UwdOeUyur97OuKoLC/RUZ7qutwMNEE0xh/I6Avc
	 5Ydbh2tH/Ant6ynzAooCHUCRzF5uYDY8ltwxeACZ6bFpoIG2qTtaWN2BQsx9DLUESeA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793091588;
	bh=rr5lFc3FcWemagY5kyZLCUAwdWVy9UBprRVl2iClq1I=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nqG9TLrqBJOVQKf/Qf2EA2c9cukYFnZ2kihkkWG5U/uLF0/rHF9A3UXqDjxWJzAej
	 SToKa+HStz5BYDI72ok9gvz0uf0MujApLy+xMCIu64MbCyr/fHoWXecg7d7DsYcpRi
	 qJ9XzCGmByGdxYlAKw4XmzdV0DGn5D9JckN8lwKK3IKmDyD5n9Wv6S7Av0lKq91ttN
	 lyidEX/lN9sfsdm7cU+R/Yuyd4kmfh3HatvmgRoJymjZvWeITribKHIR2vE/jKlzB/
	 VPB6q6b0/ShnT5NUXS+ZyKIw4GYo+mSf6nXQuBNa1O4Vpvlf+Wq3v8I4DBWTN7DM5x
	 URhHxsU+jmoZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38F2B40664;
	Tue, 27 Oct 2026 08:59:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA8D6B91
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C09DF808C8
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BY3bI4RLzkx0 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:59:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B495780BA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091585;
 b=WdOnDmvvVsJnqQggQwnF7lmFjVWk/xxfCpAu7uj8VAFdXz/yF2ZucJ96j9XBmmVebOSG
 wCZcg72SsCYYCBKFcGDaJKIDNI1tyZAJRjTOkJK9vZv4FYRlOh6R35TDsm8N9U5NiS2wt
 LNbqKkFnxU5AIYgwHF/ZNDE2/5iQ78pL8Im6AwUDEWtj6ADkLDtcpGaCw9xcpRppq3HbS
 XfFys1cX5/xrQzh6Kj4/xpT3/q2h5JxWotB3SI8z1qXjUnkv+VUQXE7noxb9ZiG405B4V
 kgF6CywrdFl9YX9WJVYkwo7UyiV7ui7Cr+GlmjeZqek8gSXT+7FWLND6JtA+i7fWvCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793091585;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=rr5lFc3FcWemagY5kyZLCUAwdWVy9UBprRVl2iClq1I=;
 b=OuL0oy8ER4oV7KjvSiRUIbif/CTzu7FKB5tDcU6NIKas3fBjOvR9Rjkf5jIgfKOXkGIq
 fAisZbWv2g90XkvdjLi6pE308jwjB/en+Tf279MdDdh6kuxMHbuopVIjdaI+KzBxXGr0c
 fld+NvIrhkYe5sTSPPmKuusEn1jQD200vBy7B3SvDU2co6vTn/8tkqsuSE397P9qSIis0
 t8XrZKtCwedKSv/bdf5Cc+NB2E0xA9g1ZHPsD8f3nfX9LWSGF6Yjyx5vnZmj8xHTA6pB8
 j1SpdkJc1yIEW3mRy7Lfhi6TC8EyGQvwzP01kgaIju/3s4QFTyImles9xhApTsm8FvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ENaHVxKr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ENaHVxKr
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B495780BA6
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:44 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so5254030a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091582; cv=none;
 d=google.com; s=arc-20260327;
 b=nwMxKT5VwJ34j02PqLd5rm9SFIA9ulM/s4TK3ZC4lpaC0hL3lByQ0BSUZbESh5P9N4
 y71P/Zk+cYeiyG0c1JGQGRMHyh0JCC0fVos0QqMcWWQqIeP8tE3TUbnLOD2VudGiTsGC
 8Pn4WDrjEY/ikQkQKAR63WJ4AjCiDf6C6hNJePqsUwdyr3TxrbVtwUq1p2MO/rNCMNjS
 u8xQfIFPfkf3MxRfZ7XASfzNfzJ7BBmNwD5c4ELEodyb3quaqNippPHhDM5TeV9xoz69
 0aggzuW/54hDvrVH38NksEjx71m7QQEhAdGrnvqbX0n5rnOZHbYAYScKVuHUxxxIAcxz
 VILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=rr5lFc3FcWemagY5kyZLCUAwdWVy9UBprRVl2iClq1I=;
 fh=/rdnnAgt/z8Y/gO/kkwLsOp9dS2eruYSp+dyjwHJTc8=;
 b=EwsuOB47FlKJAc9CieEn2F8A6OpW/Jm2GKXUQyEDMY51INxT3L5C7sO0cu7YQP3EoH
 aHYAml+D1T7F7RtdqujjtKqOv0ZfdM0Y+JBPzN9NQnozzTeuLIpnm63ufljzYur8xp4F
 52qt3kkx6cz3krtfeMN0sNIyMJBl0y+k0CQAjC06MRlTJbc0W8sHV/7ievZtxMLbJl08
 0E0GxoNIIe/3EnDUjWhvc0M79ojNgW2BrIkNBwBVai+TEg6Q2alijxmvyTlhoc/Nl+IV
 ix2s3/N09dGO8vG/t3egSGjSl2hVBOMICtm1/fnWQgJ2tJhpgmPTsyCGb3zyOKAcBL3B
 JH7w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793091582; x=1793696382;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rr5lFc3FcWemagY5kyZLCUAwdWVy9UBprRVl2iClq1I=;
 b=ENaHVxKr6cuIzo5rQkuprr/iAxhfRmxbVnf/SETYyFfCEcAtajtFs2ITyMvFUtaBzj
 +9h8QDdrQOCAGScfaXJyJUpFntsBsuIhWf/X0AlkiwX6CNEcC5sCzbSPwYBgzi780g3+
 FbJCUWPMqb8HuVtcKRvAL30LYcr9QipIGRJb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091582; x=1793696382;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rr5lFc3FcWemagY5kyZLCUAwdWVy9UBprRVl2iClq1I=;
 b=A0YAMNxVeLGq4+DqmlnXPArv/UIPfX31+nyw5wR0lPDDEnJ520s4+9RV/qS2e3PhAP
 p1SKQDHp1Ayf7WY0TJFK/aBr9T7W7hTq7+wyao4KKhtBnr7DkVRAYibyipmMGL0Sj3h+
 vbvZFn5vKDW/V7opmKNDBgmSPpO+xd+INq14B09qP2XTP3W+AyDic3rjSuefP+Vlq/7d
 YbRpRk659RpBV6xW7J7DzoDB+GIYaFSCdLMqpzZVzKvwgJseDQKhITcjcmws7vgYehaY
 ukiClkO/5FWtYdI5guQN3/hx5JDMHmPQZiyxE3YNn+Srv4qvwBr3qWD+du8lZlFB7dkd
 ezow==
X-Gm-Message-State: AFq9FYLeoV1I+CaSrdFRQKgwyjIqysOAILxlLG5Qx0OZMXG39W3ihxLg
 Jn+q7gnCTING2mFEJgQ7srUBzYKzVijD4QlkGUspt+fYb4QiRYJpGrZqEHkmeG3sEus4WuguvB8
 oC9SbthqcqRNzHoqODiHzsjieiy96pxqC+1rq5I4Q
X-Gm-Gg: AYBFou2pm4yyiGsWxlIwr4SIP2YJt38rF2+zx7Q7avUx9hbr9W1IQwlb4N2CUIo9uq8
 t1T50v8UsmYYcjwDc7dWQa8tm+jcDi6H0Bc+y924wXknqvmFFTuZr9m8TVBf9aekxwbcBAd0vjg
 72G2iqIEvMiN4jFgYI7cSnsmcaHBuWHPePC9GPv5VB4zu4q9Ke5Tkm+Ahj2fGGjOK4XxL2HIs2w
 5rLHvTS6MuYyxJ5kmtmlHqwSw4q2bVbjSHuSU20WlouUAxwXvpT6XFxWqDOOUNQR7/CSLk6QF3r
 Bd2L2wUZAVdKnbOywmK+HjGgWvUy9Gec4MWe8RS2MevbrCiXdgctxYE+GWgVdJsVwzR3E72VG/M
 kebS+VE/A6LzyQIDZtuy8tOZiG/xhsN+mFUk=
X-Received: by 2002:a05:6402:1f4a:b0:6b1:d62b:a8c2 with SMTP id
 4fb4d7f45d1cf-6b442a82ca5mr9983006a12.5.1793091582162; Tue, 27 Oct 2026
 01:59:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:59:39 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 00:14:42 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e7aa5f28-e3b6-4b52-9019-1136d4ef7a82@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
 <e7aa5f28-e3b6-4b52-9019-1136d4ef7a82@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 01:59:39 -0700
X-Gm-Features: AclHuK_s5l2PRZYNtKp_Wpaar1vej7fgVKv_Vzy93ey54iQMMSzIBB19PUyzhbc
Message-ID: <CAFLszTgOS-8Ha7VRLQO2QHbUr9YTyOHuhqokCbZK84F1r8zR1A@mail.gmail.com>
Subject: Re: [PATCH RESEND 9/9] efi_loader: Check the GPT header before
 measuring it
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
> efi_loader: Check the GPT header before measuring it
>
> tcg2_measure_gpt_data() reads the primary GPT header of the disk an EFI
> application is started from, and uses num_partition_entries and
> sizeof_partition_entry as the header gives them: the entries are read
> into a buffer whose size is their product, worked out in 32 bits, and
> then walked num_partition_entries times with sizeof_partition_entry as
> the stride. Nothing checks the header first, not even its signature or
> CRC, so a product that wraps, or an entry size smaller than the GUID
> read from each entry, makes the walks read past the end of the buffer.
>
> The partition driver does check the header, in validate_gpt_header(),
> but when the primary header is not valid it uses the backup one. The
> partitions of a disk whose primary header it refuses can then still be
> found, and an application started from one of them gets that refused
> header used here.
>
> Export validate_gpt_header() and check the header with it before using
> its sizes. When the header is not valid, measure no GPT event but return
> success, as an error would make efi_tcg2_measure_efi_app_invocation()
> [...]
>
>  disk/part_efi.c                |   4 +-
>  include/part.h                 |  23 ++++++
>  lib/efi_loader/efi_tcg2.c      |  16 ++++
>  test/lib/part_efi.c            |   6 ++
>  test/py/tests/test_efi_tcg2.py | 170 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 217 insertions(+), 2 deletions(-)

> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> @@ -1220,6 +1221,21 @@ tcg2_measure_gpt_data(struct udevice *dev,
> +	if (validate_gpt_header(gpt_h, GPT_PRIMARY_PARTITION_TABLE_LBA,
> +				block_io->media->last_block + 1,
> +				block_io->media->block_size)) {
> +		log_warning("Primary GPT header is not valid, not measured\n");
> +		ret = EFI_SUCCESS;
> +		goto out2;
> +	}

This fixes the overrun, since the entry size is now fixed at
sizeof(gpt_entry) and the array is limited to 4MiB. One thing I'd like
to check, though. Your argument also applies to the entries.
is_gpt_valid() runs validate_gpt_entries() too, so if the primary
header is fine but its entry-array CRC is wrong, the partition driver
uses the backup. This code still measures the primary header and the
entries that the driver refused. EDK2 checks the entry-array CRC
before measuring (PartitionCheckGptEntryArrayCRC() in
PartitionValidGptTable()). It would be worth checking the CRC of the
entries here too, once they are read, perhaps by exporting
validate_gpt_entries() (or a helper that does both checks) instead of
only the header check. What do you think?

Regards,
Simon
