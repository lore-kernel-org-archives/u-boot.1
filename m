Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85E8FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8817484150;
	Tue, 28 Apr 2026 16:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ez7E7Qsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5692B84605; Tue, 28 Apr 2026 16:12:13 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B20845D0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso827243066b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777385530; cv=none;
 d=google.com; s=arc-20240605;
 b=HHqgtcokkI2cJCBhVCX/fue5hKsEDynWX4GIwauTgwpebBNmWFGJ8KUTYrxJrFdMDj
 7uxznerPpteNJ5q2HEgLZzzt2E3xn1lhOPPunR5FRX7aXDqJsWWvkKGwos4Cs/RHYwPU
 qxHMCv43jAjIKpizBdTrMS0VYljsX2qThY4Nvk0ka3CJX3iIRenMpvnIjfH/6YGKRnLQ
 k3dC7AFC/tHCvZfDWLJfS0ZbgC0C9HiT7annwxI3QBsSdxt9WJboV4jLy8Bf0G3SONdn
 hwZisAkAGBk7fbcQnZ/TD1yVDHGwpXlCLz5/kvPA/g7CP2mLHu15/8aciJe6id2sSJke
 8Zhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EMlIjRiAhL8CJjQbLTaI8EsOC+yfdJT0vUOqB98kwS8=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=VrJ0T8bNp0+KINmiI0gRv+7YL8WS7owGXfL7dcutxFPl7o8ta1+/fTHwyxAQ939YA4
 vu1jxREMRplSiM969Eljknj6c/beXMdfpC40c+bx1sY7CWwHLf8pvqd7ljQnXjasvWYD
 Ao3UPDeArgWqTO4BvlbFL6NOv8iAtap8t3yyQBhqstzMp4VPOuubzQ1RY9gpW8dNhYn9
 RHeAwM/RqfRU1evgmYuVS5PbObexbkPbEr5L+2uypKy5Yqam/O8TxnnWRTBsPjS1uxds
 1jhddmcw2Ytr2eyTtNiFTaJ1LtiOSgioyfeQbY/7r9ru2rHzjktgvM+5q2nHUeWFr39f
 seGA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777385530; x=1777990330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EMlIjRiAhL8CJjQbLTaI8EsOC+yfdJT0vUOqB98kwS8=;
 b=ez7E7QskY9IVPJJc4fVEvDnKsZCMw3hbM3lYLJSNDo3r9nTxjVNDVHFfB86EUcTCkr
 JFn8jAzf2hKptE7WzpZJDT3MJAXAgBcxE6nvGajtCNI7lgYc0m48lTc5FEzJfkaLJchL
 7tPPcyOlP7InRUtc639QspZnY0jEE92ltcwXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385530; x=1777990330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMlIjRiAhL8CJjQbLTaI8EsOC+yfdJT0vUOqB98kwS8=;
 b=S1HL2Wk254+CItp/qtmqkw+U6Ofcay3XviTqZh7ClL0wjYdLzqxgUaV5zb/3XR+vNu
 EwfFvDRSz7Ydq6+RmryjmydK+L6TWERPtCtUrVKgeVp0kCptOLdTrvsJ2QJO/B7SHOWZ
 9NTXSRvvOlF7R1LjWe2BWZYtYso4ITzgTM1sG+n3C3b5EiSZ2Dn8eQymEXAyYLtwx0ld
 Rf/W12PAt1+x+QvBUMIeXLVDF4vvEgyyJS0pQd1H54t7ak1KrChEivEQzWt7sNZpZJOt
 HlOy73lNkCJ830mHJWsT36+zXUc7HdqhKYGnDO/EjF6eEeW7bVEVYZozC7rAaxOJfs17
 UCYQ==
X-Gm-Message-State: AOJu0YwQK+cATiZz1u3wHlQI8U4oXPTnize1IAJ0dzr9Yyx1dT4PKiiD
 H8X7BHIIjRzUYMSrduQjRnvJ6/az166rmpCfB0tzjSip3qO6MwQjnDK08d0BCWpemiZeqKI3FxF
 8F6skQNMRb04M6a7x8P7lA99OnVkhb84eyvyVM53EvtuOAPFp/7c=
X-Gm-Gg: AeBDiesQBXUzfkeDIECK2PcxwLznTg60VuPJNz4K0JiGajcYTNEK3XWnqEZbvvZauZ9
 ITHOM/3ZvUJn3dWCO2f+96BaXeTwkPje/F7aHDHh3YxjofdNQ8ajTXIK79xJ7ktUAOOC6WUIitn
 eHcHbaN6XCZ0qXMhBGXCfUeZlniT4cR3M70IMLka3sX6C102VRelbD/HfWBWw7UkspTz3BDfXRN
 IzMgO2payZS4ttf9B2x4Qt6+3VEXd2GGRHOTaRHbY4mctc/UjTmOvbu+0D+Jamcx+yRNzfAe5oF
 guExx/ja9ZhL3o6K
X-Received: by 2002:a17:907:7210:b0:ba9:bb46:3449 with SMTP id
 a640c23a62f3a-bb8018db5bcmr204915566b.8.1777385530239; Tue, 28 Apr 2026
 07:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777272283.git.weijie.gao@mediatek.com>
 <cb7f6ba95951ed3437b6f0cc85179cf4b78f2a97.1777272283.git.weijie.gao@mediatek.com>
In-Reply-To: <cb7f6ba95951ed3437b6f0cc85179cf4b78f2a97.1777272283.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 08:11:58 -0600
X-Gm-Features: AVHnY4Jyt2gEO5IQsDKf2eUYubwk8DqNyUKmO5pf-3JeWYZvfp5aiLox73Vie0U
Message-ID: <CAFLszTjNBo_jgqv9wmceu=qeYNUrvXczM2Dft6DdMxDdJrhU-A@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] cmd: ubi: export more APIs to public
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

Hi Weijie,

On 2026-04-27T07:09:11, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: export more APIs to public
>
> Export the following functions to public:
>
> - ubi_detach(): this is paired with ubi_part(). One may call this function
>   to completely clean up the ubi subsystem after using ubi_part().
>
> - ubi_{create,find,remove}_vol: this is a set of functions for volume
>   management.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c           | 10 +++++-----
>  include/ubi_uboot.h |  5 +++++
>  2 files changed, 10 insertions(+), 5 deletions(-)

> diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> @@ -47,10 +47,15 @@
>  int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
>  int ubi_init(void);
>  void ubi_exit(void);
> +int ubi_detach(void);
>  int ubi_part(const char *part_name, const char *vid_header_offset);
>  int ubi_volume_write(const char *volume, const void *buf, loff_t offset,
>                    size_t size);
>  int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size);
> +int ubi_create_vol(const char *volume, int64_t size, bool dynamic, int vol_id,
> +                bool skipcheck);
> +struct ubi_volume *ubi_find_volume(const char *volume);
> +int ubi_remove_vol(const char *volume);

Please squash patch 9 (the kernel-doc comments) into this one.
Exporting an API and documenting it belong in the same change -
otherwise reviewers cannot judge the function contract from this patch
alone.

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -270,7 +270,7 @@ static struct ubi_volume *ubi_require_volume(const char *volume)
>       return vol;
>  }
>
> -static int ubi_remove_vol(const char *volume)
> +int ubi_remove_vol(const char *volume)
>  {
>       int err, reserved_pebs, i;
>       struct ubi_volume *vol;

Hmm, now that this is public, the mixed return convention is a bit
awkward: ubi_remove_vol() returns positive ENODEV/EROFS in some paths
and negative values from ubi_change_vtbl_record()/ubi_eba_unmap_leb()
in others. ubi_create_vol() has the same issue. Worth a follow-up so
external callers get a consistent convention - ideally negative errno

Reviewed-by: Simon Glass <sjg@chromium.org>
