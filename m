Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB80DEA71B5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A814842B7;
	Mon, 20 Apr 2026 04:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aDNQu5NE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D348842B7; Mon, 20 Apr 2026 04:12:43 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706828419E
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so464988266b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651161; cv=none;
 d=google.com; s=arc-20240605;
 b=OxxGufEPBwRYMBp7UfScVVuF9MMfnqZDvhIHRQq+999uu9/DYZaW2DAO46+ulR45+Y
 nrpfo3/bgyOi2xwH48qQD0Sjd7v68s1VFrRVq1QaT2v7DaPgV23RqWnp1T6RCmKqHcHZ
 XZCP5qjSZyB1UVPVHLq9jMO/ntG1F2nHw1sqJjwQZe4r/0eAOnNgEuOFSFKNNJwzXRRb
 xEmjUbDD0JK8+CmTNLPb0CJO4ILu2yC2wmogX47vRTR+hDtkOxFq9Qh9UAcYBXprdcr2
 AEMfnU3z+f6G0cg0fAkraDeQA7HtVt/tjj8SqRZW5JldAse+kAb/UmRc7/yEBdjFKNBT
 uyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ikM3qHBtlD9FKmAMj9EVqrcua7yu+Hjuo5LlwrepzdQ=;
 fh=axaieEKI1EPnKwzDhCT1NTUzAiELcbdCJIApDIYu7as=;
 b=InD8lHp07UerGSRiNb6EXjlGU868bJ77v0sTPsuo8b2yYSScE3zjoYVQwe8j+kkTYy
 y1VL3g6Ihta0qhk8XMIji/H7ZoTgCJdAPnJnTTIoTi0kCDQziXEsk+dqIJRZBeT6vW0u
 8O+rmAwQtb0v66kXsPPr7gQB9t3jKAZ5K8JVwsvl4KhfKJI5IEjSaTGh089qTzvfWBIo
 xtrcL/QxAE+vjBF5J3ZfTwLJnip5X+1Dw8O7nAxxS96jLgBdRms6JXGVHzSW1uUdz07a
 dDGbBTqmOJokjKDWBGYzulxrTEQ27vAhsht11D3oohs3lU2alZTGutdS22r276v1qRth
 5uZA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651161; x=1777255961; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ikM3qHBtlD9FKmAMj9EVqrcua7yu+Hjuo5LlwrepzdQ=;
 b=aDNQu5NEMhT2Gaai8Ow+5iSuTLxbtZFl6sAU4JzDTyxUhFAVAIcW5iYQ5vgTf5OWJ8
 E12fwEmewOBmcPtBF1Z1gTQQuwg4BT6VVXIfZ8rI2Ykf2yjq9qgvDXwAwzH2ARSa+Npo
 Bk3srrlclur1lC+uEKX5rQCV4p+ANS73qbfK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651161; x=1777255961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikM3qHBtlD9FKmAMj9EVqrcua7yu+Hjuo5LlwrepzdQ=;
 b=TR4FPzrzuJeBzQht8PbknYthfGOyRwtiwLDUVzLflKl7cxHVgkWfN+J/1vZxcjU0s7
 tFD1cCcoPrd/rS/aMfvM5n5GGBcnVlbRkWqtclzfuoDgOeFqKB2Nmrz9gZG9bYIFu8C+
 l3fwGnsaEVKtx3jRJTjeSSbQMhgsRD5OfZeFqpFZ5Wm0GzZJtEyuM9NQajVnS0+aqemV
 kXIslyLS+yO86AJftzJv/6wKgOL1dF/zdleinlkcEB4V4lyKx5WxFTkxdFAk3jWy5kud
 TncQc5qYMRFn9QYDHtXnkF4Q+J2n2I5mUBmogGT59DAyXV+MWMBCP7YikyTeysp/EDYp
 3m6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ndE0e1jS6X+4smJfFRf5zymExcQPHqo5GovA9Xe8WaaAL7X03xGTn6Sc5h086JiOMs8QZ8xw=@lists.denx.de
X-Gm-Message-State: AOJu0YySY6GpD99C9O8gJVyL52M0N1SkMRohoq3xrt+ttPW0veBaScIp
 qG5rAvSnOyPIpimySkbLZPybVTEt7ay0Fov4Vxu+Q9WVLpNpE7naT5FawIeXLYoAM2IEJO2Bo2n
 r79T9//ooR+z8iNPmY/LUnBastMxq7P7+XG6TtlPp
X-Gm-Gg: AeBDievXQDam9asBHReW4KmT1DEqRazjkgn1wOax93DSMU9Hi6coS7xzhmFckm0hAgy
 +cWCPZaBii0l1A3Wctwexx4KmyhKtty+Du34F21yFWy0KrOzxYKe0uatHHY8WHkgQXc4KBDRUyQ
 asH1e8wcC04Pmog3t9N3dfxBGE4RU72bfo2Bs5LndEJvCGJ3lOWk+i1rGiiGcn6VfXhJNsA6KUg
 g7Zj2sZeJHSi/WADlOxUBzJD9uUcSEfbXMjwAO357D/CZMLYaJQFyT/detqEJwNV/lAJrQcRNCL
 ZZWg/etPF2VqPlbZB887UmW0YEJzQ6c=
X-Received: by 2002:a17:907:d641:b0:b9b:e619:a73a with SMTP id
 a640c23a62f3a-ba41b3e2885mr539692666b.46.1776651160957; Sun, 19 Apr 2026
 19:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-10-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-10-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:12:17 +1200
X-Gm-Features: AQROBzBBb1skThPaL0id8UbuaA8_IR38oy4Ea7ZRMBfKbmDs-E39y6oJV5XaZfM
Message-ID: <CAFLszTiG50vp=YSYzY5uPGD0QXgTzmwnvWi=fCzA-csXqRO8VQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/14] tools: mkimage: pre-load: add support of ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> tools: mkimage: pre-load: add support of ecdsa
>
> Right now, mkimage can only create pre-load header
> using rsa. We add the support of ecdsa.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> lib/ecdsa/ecdsa-libcrypto.c | 29 +++++++++++++----
>  tools/image-host.c          | 79 ++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 90 insertions(+), 18 deletions(-)

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -538,6 +533,26 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
> +     if (info->required_keynode > 0) {
> +             key_node = info->required_keynode;
> +     } else {

Strictly speaking the check should be >= 0

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1244,13 +1245,61 @@ err_cert:
> +static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
> +                                    int pre_load_noffset, const void *key_name,
> +                                    const void *algo_name)
> +{
> +     struct image_sign_info info;
> +     int node, ret = 0;
> +
> +     memset(&info, 0, sizeof(info));
> +     info.keydir = keydir;
> +     info.keyname = strdup(key_name);
> +     info.name = strdup(algo_name);
> +     info.checksum = image_get_checksum_algo(algo_name);
> +     info.crypto = image_get_crypto_algo(algo_name);
> +     info.required_keynode = pre_load_noffset;
> +
> +     node = ecdsa_add_verify_data(&info, keydest);

Please can you check for NULL returns from image_get_checksum_algo()
and image_get_crypto_algo()? Otherwise ecdsa_add_verify_data() ->
prepare_ctx() -> alloc_ctx() will dereference NULL

See fit_image_setup_sig_info() for an example.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
