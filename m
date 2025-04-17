Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD435C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 06:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E1482FD4;
	Thu, 17 Apr 2025 08:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rqNBalt+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 950F782FD6; Thu, 17 Apr 2025 08:31:43 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E98C82FB9
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 08:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso360725276.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 23:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744871500; x=1745476300; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ym2L5Cf40X69J8KkSnA7/WmL7CkPEENbl3lQ/tsEEqo=;
 b=rqNBalt+zRlxSmdiUSVl2HuTrVhotROP9vh1SSgVMQagZ3lcjdX6LjzaohyZLK1LaP
 l7cRrOJsogJhQlQo4Zuk+tHK79E3nwdCuJwQt2sWIMxuKmCjK+gf3u4OBneBGokVzwv7
 L988m7ExHdE3MRjYwt3+6X5Z34NhbW8g4sDqH9UvRvyn5+dr/lwoXoQbiV2R8z0Evvxw
 TDKVX5ju19vCuzr/fTpNdxPpJs7+pGnPyMcru0snHZw0siZ4Hmf9CSlnZxzevGWDfZVX
 mWfza9KgCW886dwFaPhzc1u9hNev75GAXp+1a3ypuELy3CyLMwqWlJgnHXu8eN0mNYH6
 gAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744871500; x=1745476300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ym2L5Cf40X69J8KkSnA7/WmL7CkPEENbl3lQ/tsEEqo=;
 b=WBayJdYktfUqpwg3X60PihbiD6Ww/lfsANuvRkFXwQV4+JxXFDbm5M58v1tOkRhG61
 1g/68eVHeaHbYq5xIMNDx1rRSsiiqvWO6O+unOtdCTtspkjLqo2Bh/eGBSwdc5XIYBS3
 bYZt/MrZbqH61hDhsyoBpLiplrax1kSdnvXgTe8XwCS7sWU9gG/tbf9Uj9X08T1lmut9
 utvxcuNNr2joA9KBDknAD8+hCwtvc0+2Onr1IKH7FHWrLGi/voR8/ri0Hlh5lCNXwjq8
 2VFMIWsVlp77LRn7yejePI/A/efQOxtaeS9uY8V88hf1WCIGOetbySC8+jcE9sRZ/A+C
 1eOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIVQhP9go9BOcORoK5FkvRhJ54ykCFnRnOq1RLFzuo22zV+XXMIAECx7v1y8YlmfiipAQFl38=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1PqRtf9KvtVjDM7f868BfYYuyokoizsn4F85PSMnH5TU+rcII
 ygMa/X457mBcUz/he0eZfbZ4GcVBQ6zevE5USMJMPjdE17VDeriIpXASAj+q55NuM+J8YJVwZ/F
 428UCvwzWQjmHQsnkVCnfORFxv9VfrL7oo0P8My5lh6/8RsfT
X-Gm-Gg: ASbGncspnKALMxF40T0BDM4b906Vja4BYaQA2j2BmtwFRovh0xzaovMTAW7tNhfUky1
 IFnQBxoRsj648uW5Zk1gRNaOCU5mNM60BCA1MGUCEucFceJZj1q2dDeuZCJZmrapoNcP7mUDy3h
 yJt2l+2RITzipZ3ECXjrk8+sU=
X-Google-Smtp-Source: AGHT+IH/snnDhxYdIkDnfFZtoWQedBfiwv3e8I57bEzG+RiK/vAM2WbmY0GcoyyAcC5IB2na3AqFLB+Xq/05AwRhOL8=
X-Received: by 2002:a05:6902:1583:b0:e6d:ecbb:e527 with SMTP id
 3f1490d57ef6-e72759b42abmr6498898276.25.1744871500109; Wed, 16 Apr 2025
 23:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
 <20250408-topic-gpt-cache-v2-2-de76e47debb7@linaro.org>
In-Reply-To: <20250408-topic-gpt-cache-v2-2-de76e47debb7@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Apr 2025 09:31:04 +0300
X-Gm-Features: ATxdqUH5k-Go2C-sIO3aYqB-G6WzbV5Iizsdqq24i0MySoI5DB2d5jmlm9h9eWk
Message-ID: <CAC_iWjKa+WaOQ5diQLx5BxP9wdDS5v5kvvqBdFDpa0bN_kV+JA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] part: efi: add GPT PTE cache used with
 part_get_info_cached() API
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Neil,


On Tue, 8 Apr 2025 at 12:13, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Implement a simple cache for part_efi to be used by the newly
> introduced part_get_info_cached() API.
>
> The cache simply stores a successfully scanned GPT PTE if called
> from the part_get_info_cached() ops, and will return the cached
> data if the blk_desc and lba offset matches, invalidating the
> cache if not.
>
> The cache will only operate if called from the part_get_info_cached()
> API, all the over calls will operate uncached, making sure we
> can still update & re-scan the GPT partitions like before.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  disk/part_efi.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 96 insertions(+), 18 deletions(-)
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index 932d058c184ce6946b7142e7c2d9637b28e4661e..949968fcd30fc18766a023e73f43ca1381dcef89 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -55,12 +55,58 @@ static inline u32 efi_crc32(const void *buf, u32 len)
>  static int pmbr_part_valid(struct partition *part);
>  static int is_pmbr_valid(legacy_mbr * mbr);
>  static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
> -                       gpt_entry **pgpt_pte);
> +                       gpt_entry **pgpt_pte, bool cache);
>  static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
>                                          gpt_header *pgpt_head);
>  static int is_pte_valid(gpt_entry * pte);
>  static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
> -                         gpt_entry **pgpt_pte);
> +                         gpt_entry **pgpt_pte, bool cache);
> +
> +static struct gpt_pte_cache_data {
> +       struct blk_desc *desc;
> +       u64 lba;
> +       gpt_entry *gpt_pte;
> +       gpt_header gpt_head;
> +} gpt_pte_cache;

My only concern is that this is global, and I don't know how it will
affect the caching with the threading framework that's under
discussion.
I don't know the block framework well enough, but it would make some
sense to store this per block device eventually.

> +
> +static void clear_gpt_pte_cache(void)
> +{
> +       if (gpt_pte_cache.desc) {
> +               if (gpt_pte_cache.gpt_pte)
> +                       free(gpt_pte_cache.gpt_pte);
> +
[...]

Other than that this looks sane to me

Thanks
/Ilias
