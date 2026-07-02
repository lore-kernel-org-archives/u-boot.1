Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAB8C43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FCC884CC5;
	Thu,  2 Jul 2026 10:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H3niIXx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6132684CD1; Thu,  2 Jul 2026 10:35:18 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E568184C7B
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-8f1a8e914a9so11250226d6.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782981315; cv=none;
 d=google.com; s=arc-20260327;
 b=GPoD7pLw93Afzr5WnxIQLrmZuIt6qWa4LEDSinS1peQHv4aNCoymxPceBnFN1CP7BI
 6o7vWUmgYKH9UP03BZTaEhgG/DJFNMDkppkQkvxdyGkz0TxuKJLJV7Hu1f89Skc//Ns2
 0xdhhLXYfk1J+Td0fDllK7A4gCjQnVI9l+sIOkK4hzE+xUnQwuUlN5xv2IGx2hfy/zxU
 9QLDocScqLMQQkH/wpnq2CRzTiNuc24No+wsD3bRR7bXj5JN0Wkz/TelWUBmi9C2JiHB
 uQu5LtTO/QhzvkaflPUgSkYTM5pv6hWQAQs4SblUiqCtYGTLq5td6xCeqNO+5T1SBiSn
 5HSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T+Jq658uLwtPc8iTbje6Jtj7voSpppzpLRYEqVeFy9Q=;
 fh=1B735Jozkc12MDFwYrn2apZKQj/KcMZFfxUX3U1xlNc=;
 b=YVOJfoRiR+3xX9uIGVd/qYtJGOEqwRWk2wlYHq7bMTbuVeHLTxH4EzJXGjf/cASs8+
 NkKvJ/MRxT1WyInwIlgP0Kan/UEO48KVTSv9zAMHLx3HaWvCKpzxembHsQoieVlIhVCa
 DsVmP41RMNYhPpGDJrjFDvN69Eh0ws/flnrkL/bdNQH9kAxLIVCGVPgH4q+F35P8McDd
 OhGZVedsWOm08srTLZ/xAr6S4h6xDUE7mjR17BkNkxIYlwtuQmPTwawa6/3yFXsQ6F/P
 5MDoy2FXmMgAGE+5xkbV8+UQYefP9P83eAZvwafyOdZQnK4CdX1Ryz3D1A/XGpYZR0nP
 ZJYA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782981315; x=1783586115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T+Jq658uLwtPc8iTbje6Jtj7voSpppzpLRYEqVeFy9Q=;
 b=H3niIXx8rftJztkqOIANPpX0fn5L6eLM6rex61Lyl/RODJlDxRGYZGYEOVZhomI41x
 eH6Epw8n9OfpnPYu+wAyqzs64majlj99RAAnu1mdMCItieuzWV5eIwcBcMFxd4kMP2su
 R1lIXkwTPArvmgGaE7FsZBKRvVP3ZmsHk0mGYMeF0Z7b4jWx4E1FxmgGaD+v5kYLm0L1
 p911a6wh0yrG501amIiH/PgePWLtZZ+5Jo+PJ0YEkyqWyI6R43K7mkEcDqGomfY06H1B
 0Vqo6UrcjK27qm7/HKkDoFtWapVUfsLqxNh3nW/cg4IDnNb3qwPBvZhXthhEmzavzjmD
 QvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981315; x=1783586115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+Jq658uLwtPc8iTbje6Jtj7voSpppzpLRYEqVeFy9Q=;
 b=RilvFc4cT/M+tvRujG+ab5m9vUZBbTn+gnhGwcTkK7D9AMdMcxG+E8WEUgKg0ZoKF2
 QWnrh1OqXFiSEF4vizlcSLCn7zg6oza6H0JVgSgswPPtfDG9UJczN0FXAoPgbJXUwKqx
 DrjPH9kEOha6hgeJX72svuhHwn8efBgmGnlRh+hPSd1CbyREbxrPKWxR1GY+R9CZz1sD
 f8pb96YECyHLvgEVV2sD1ks1E2SvPUUsDx+KYNWttyfgWM7jmb3u78Q68WCCfs6VzKIL
 i+UWNN31wloSF5wOnrYeu2+NXRHbxJIWKBae6eY4Q3ynLKJ9YNr/z4rnRzYHcV3ctW/r
 LjmQ==
X-Gm-Message-State: AOJu0YzbH6IB6SOw3MuKcrz3ZWZO1BiuQUVWiBBvLiJcMBsZoUP1xDrB
 m64HRqTZIXKrhGZU5/uCfdUedKZ8MRKRDejdrl3byQCuKGEvQQiQmqygzHqHxGKBw3Um/mhsbY8
 1Ar3oTAxKpFyi3F4vIOSmf+IN3mczyyE=
X-Gm-Gg: AfdE7cllXXdQTkN4HQzY5jjAGQ/IZ8EFRtE2fkGWwBDzVQVHG4YFSJ9Lq5UiQtgKjjT
 NBWPwF23DHfmsoDQf8uAxhB+cx5PK5kxVCBW69bufw048yl/FXZuWqM9LpQM0ukgKOcWI4hx0iW
 R8HKa2W8wHZMk1E5+zW2nw6tAzOzwj3xMzYSk97PpISrLd3fpbJrIY86dJ6mpTRk5XX5imhfZ3O
 t2m316m3EYU32ZqsHkw9znql0+jepfMsqLxpJlGXMaU4f6yCtnstlmU9OAd6NkWX4HDbAdOt0W4
 YMUPC2WjwwzEcSef54XIdCigB7Xyd9UgiAodPSFxCeiIHrlaIW/mP64h6pYwgj7BCx1D7z8NStw
 QO0qbGdhfhePa2nMKo5YAqpo4Fwx0uyKRq84PYfjL+1AdiM2kkehOUedXvDzrxEKBRBJKyu4V1f
 zhiA==
X-Received: by 2002:a05:6214:4991:b0:8e3:fa57:ecb4 with SMTP id
 6a1803df08f44-8f4225906famr60000706d6.16.1782981314676; Thu, 02 Jul 2026
 01:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
In-Reply-To: <20260702014724.1534351-1-james.hilliard1@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 2 Jul 2026 09:35:02 +0100
X-Gm-Features: AVVi8CeVSMnMrrLQEVrHwPSACvC4dzmuLlsd9xcUuF33vsx99wQd8AfO0eFwPjI
Message-ID: <CALeDE9Mk4EBW+PnAnV22Pp9qwzNj6ngY93mkbsc+KsKv0Jt1CQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] cmd: aes: fix DM operation handling
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>
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

Hi James,

As per the CONTRIBUTE.rst [1] please add a cover letter outlining what
the over all intention of the patch series is, likely useful for
reviewers how to test it, what devices it supports, and I've not
looked at all the patches but new drivers should also have entries in
the MAINTAINERS file too.

Peter

[1] https://source.denx.de/u-boot/u-boot/-/blob/master/doc/CONTRIBUTE.rst?ref_type=heads

On Thu, 2 Jul 2026 at 02:54, James Hilliard <james.hilliard1@gmail.com> wrote:
>
> The DM AES command path takes operation-specific arguments after the
> common arguments. Parse the requested operation before reading those
> arguments so encrypt and decrypt use the correct positions.
>
> Also handle in-place operations by reusing the source mapping when the
> source and destination addresses match. Mapping and unmapping the same
> range twice can break UCLASS_AES providers that perform DMA-backed
> operations.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  cmd/aes.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/cmd/aes.c b/cmd/aes.c
> index 3fd83013ffe..a74a68ee641 100644
> --- a/cmd/aes.c
> +++ b/cmd/aes.c
> @@ -175,9 +175,9 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
>         if (ret)
>                 return ret;
>
> -       if (!strncmp(argv[1], "enc", 3))
> +       if (!strncmp(argv[2], "enc", 3))
>                 enc = 1;
> -       else if (!strncmp(argv[1], "dec", 3))
> +       else if (!strncmp(argv[2], "dec", 3))
>                 enc = 0;
>         else
>                 return CMD_RET_USAGE;
> @@ -187,7 +187,10 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
>         len = hextoul(argv[5], NULL);
>
>         src_ptr = (uint8_t *)map_sysmem(src_addr, len);
> -       dst_ptr = (uint8_t *)map_sysmem(dst_addr, len);
> +       if (src_addr == dst_addr)
> +               dst_ptr = src_ptr;
> +       else
> +               dst_ptr = (uint8_t *)map_sysmem(dst_addr, len);
>
>         /* Calculate the number of AES blocks to encrypt. */
>         aes_blocks = DIV_ROUND_UP(len, AES_BLOCK_LENGTH);
> @@ -198,7 +201,8 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
>                 ret = dm_aes_ecb_decrypt(dev, src_ptr, dst_ptr, aes_blocks);
>
>         unmap_sysmem(src_ptr);
> -       unmap_sysmem(dst_ptr);
> +       if (dst_ptr != src_ptr)
> +               unmap_sysmem(dst_ptr);
>
>         if (ret) {
>                 printf("Unable to do ecb operation: %d\n", ret);
> @@ -223,9 +227,9 @@ int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
>         if (ret)
>                 return ret;
>
> -       if (!strncmp(argv[1], "enc", 3))
> +       if (!strncmp(argv[2], "enc", 3))
>                 enc = 1;
> -       else if (!strncmp(argv[1], "dec", 3))
> +       else if (!strncmp(argv[2], "dec", 3))
>                 enc = 0;
>         else
>                 return CMD_RET_USAGE;
> @@ -237,7 +241,10 @@ int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
>
>         iv_ptr = (uint8_t *)map_sysmem(iv_addr, AES_BLOCK_LENGTH);
>         src_ptr = (uint8_t *)map_sysmem(src_addr, len);
> -       dst_ptr = (uint8_t *)map_sysmem(dst_addr, len);
> +       if (src_addr == dst_addr)
> +               dst_ptr = src_ptr;
> +       else
> +               dst_ptr = (uint8_t *)map_sysmem(dst_addr, len);
>
>         /* Calculate the number of AES blocks to encrypt. */
>         aes_blocks = DIV_ROUND_UP(len, AES_BLOCK_LENGTH);
> @@ -249,7 +256,8 @@ int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
>
>         unmap_sysmem(iv_ptr);
>         unmap_sysmem(src_ptr);
> -       unmap_sysmem(dst_ptr);
> +       if (dst_ptr != src_ptr)
> +               unmap_sysmem(dst_ptr);
>
>         if (ret) {
>                 printf("Unable to do cbc operation: %d\n", ret);
> --
> 2.53.0
>
