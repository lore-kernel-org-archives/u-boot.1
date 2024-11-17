Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CCBD10F26
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 18:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07CD8891E4;
	Sun, 17 Nov 2024 19:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=systemli.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=systemli.org header.i=@systemli.org header.b="4MiqlrZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 365D889215; Sun, 17 Nov 2024 19:00:10 +0100 (CET)
Received: from mail1.systemli.org (mail1.systemli.org [IPv6:2a11:7980:3::36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DB15891CF
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 19:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=systemli.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent@systemli.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
 s=default; t=1731866406;
 bh=vL/NIsbe4VwiWfgQ3Cpsh6dW7aARa2KnBQPOyMOHxJY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=4MiqlrZp4K07bSDBsbCdrMlRlEkSMaXUcKGFBy6epMdrjzdV87SkYk6mjaFhAEyKM
 icc9XfZyOnF2W5jQi+8KcWy7lQxA68f9Q0whfsXzKnFq9nXyy4g2USZ5F4bEv06HzL
 mcASbimK3xAUakpJy5Db4074x7gmE0dtuHZAWd1ozQvAj0bJ1QL8q8Uhi/RBPCHwCB
 Mjn5HEihxMwKEd5EAPFwB9E5FcaaCpiUwKuzdzJi9ZWqIBPpojCk/bw+5MNNFilzxc
 vgCcxXLa93vu2HHFk6tEDDia92GPJ+sKYLb4amv2sryzjSV0lHYUwVLP6rZ2opAoMi
 OdQA1qbelOxOw==
Message-ID: <2d1a6839-65e9-4e9c-b64a-ae009fb2fb9e@systemli.org>
Date: Sun, 17 Nov 2024 19:00:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mkimage: ecdsa: resolve duplicate symbol error on macOS
To: u-boot@lists.denx.de
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Matthias Pritschet <matthias.pritschet@itk-engineering.de>,
 Simon Glass <sjg@chromium.org>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Joakim Tjernlund <joakim.tjernlund@infinera.com>,
 Tom Rini <trini@konsulko.com>
References: <20241117165709.24819-1-vincent@systemli.org>
Content-Language: en-US
From: nick <vincent@systemli.org>
In-Reply-To: <20241117165709.24819-1-vincent@systemli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Sorry, there is an error in the commit message of the patch I submitted. 
The current message inaccurately states the issue as "building mkimage 
with LibreSSL version 3.7.3 or higher fails." However, the correct 
description is:

"Building with LibreSSL versions higher than 3.7.3 fails, so the OpenWrt 
project has stuck to version 3.7.3 to avoid these issues."

On 11/17/24 5:57 PM, Nick Hainke wrote:
> When building `mkimage` with LibreSSL version 3.7.3 or higher on macOS,
> CI tests in OpenWrt encounter linker errors caused by duplicate symbols.
> Specifically, the `_ecdsa_verify` and `_ecdsa_sign` symbols appear in both
> `ecdsa-libcrypto.o` and `libcrypto.a`, leading to errors such as:
>
> ```
> duplicate symbol '_ecdsa_verify' in:
>      openwrt/build_dir/host/u-boot-2024.01/tools/generated/lib/ecdsa/ecdsa-libcrypto.o
>      openwrt/staging_dir/host/lib/libcrypto.a[249](libcrypto_la-ecdsa.o)
> duplicate symbol '_ecdsa_sign' in:
>      openwrt/build_dir/host/u-boot-2024.01/tools/generated/lib/ecdsa/ecdsa-libcrypto.o
>      openwrt/staging_dir/host/lib/libcrypto.a[249](libcrypto_la-ecdsa.o)
> ld: 2 duplicate symbols
> ```
>
> The changes in this commit that address this issue were originally written
> by another developer, Linhui Liu, who decided not to send them upstream,
> instead submitting a downstream patch as a PR for OpenWrt.
>
> Given the sensitive nature of cryptographic code, I sought feedback from
> the project maintainers to ensure correctness and encourage the author to
> submit the fix upstream.
>
> Because no action was taken and the original author has been absent for
> several months, the OpenWrt project worked around the issue by holding
> back LibreSSL at a version below 3.7.3. However, we now aim to bump
> LibreSSL to a newer version, making it necessary to apply and upstream
> this fix.
>
> Link:https://github.com/openwrt/openwrt/pull/12799
> Link:https://github.com/openwrt/openwrt/pull/16901
>
> Signed-off-by: Nick Hainke<vincent@systemli.org>
> Cc: Alexandru Gagniuc<mr.nuke.me@gmail.com>
> Cc: Matthias Pritschet<matthias.pritschet@itk-engineering.de>
> Cc: Simon Glass<sjg@chromium.org>
> ---
>
>   include/u-boot/ecdsa.h      | 6 ++++++
>   lib/ecdsa/ecdsa-libcrypto.c | 6 ++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
> index f0ac0f327e..f576c79c8f 100644
> --- a/include/u-boot/ecdsa.h
> +++ b/include/u-boot/ecdsa.h
> @@ -9,6 +9,8 @@
>   #include <errno.h>
>   #include <image.h>
>   
> +#ifndef __ECDSA_SIGN__
> +#define __ECDSA_SIGN__
>   /**
>    * crypto_algo API impementation for ECDSA;
>    * @see "struct crypto_algo"
> @@ -33,6 +35,7 @@
>    */
>   int ecdsa_sign(struct image_sign_info *info, const struct image_region region[],
>   	       int region_count, uint8_t **sigp, uint *sig_len);
> +#endif
>   
>   /**
>    * add_verify_data() - Add verification information to FDT
> @@ -49,6 +52,8 @@ int ecdsa_sign(struct image_sign_info *info, const struct image_region region[],
>    */
>   int ecdsa_add_verify_data(struct image_sign_info *info, void *keydest);
>   
> +#ifndef __ECDSA_VERIFY__
> +#define __ECDSA_VERIFY__
>   /**
>    * verify() - Verify a signature against some data
>    *
> @@ -63,6 +68,7 @@ int ecdsa_verify(struct image_sign_info *info,
>   		 const struct image_region region[], int region_count,
>   		 uint8_t *sig, uint sig_len);
>   /** @} */
> +#endif
>   
>   #define ECDSA256_BYTES	(256 / 8)
>   #define ECDSA384_BYTES	(384 / 8)
> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index 1c5dde6069..9a5b7745fc 100644
> --- a/lib/ecdsa/ecdsa-libcrypto.c
> +++ b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -238,6 +238,8 @@ static int do_verify(struct signer *ctx, struct image_sign_info *info,
>   	return ecdsa_check_signature(ctx, info);
>   }
>   
> +#ifndef __ECDSA_SIGN__
> +#define __ECDSA_SIGN__
>   int ecdsa_sign(struct image_sign_info *info, const struct image_region region[],
>   	       int region_count, uint8_t **sigp, uint *sig_len)
>   {
> @@ -256,7 +258,10 @@ int ecdsa_sign(struct image_sign_info *info, const struct image_region region[],
>   	free_ctx(&ctx);
>   	return ret;
>   }
> +#endif
>   
> +#ifndef __ECDSA_VERIFY__
> +#define __ECDSA_VERIFY__
>   int ecdsa_verify(struct image_sign_info *info,
>   		 const struct image_region region[], int region_count,
>   		 uint8_t *sig, uint sig_len)
> @@ -271,6 +276,7 @@ int ecdsa_verify(struct image_sign_info *info,
>   	free_ctx(&ctx);
>   	return ret;
>   }
> +#endif
>   
>   static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
>   		  struct image_sign_info *info)
