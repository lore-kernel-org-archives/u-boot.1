Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77890C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 14:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B68E882BE;
	Thu, 18 Jul 2024 16:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BJntEfth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B938882FA; Thu, 18 Jul 2024 16:11:35 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16E458827D
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 16:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a05b4fa525so25535085a.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721311892; x=1721916692; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5mNz5fwjQxA7hRjG/y2bSuDn47T4+Ayl8EytxxJFnmE=;
 b=BJntEfthBOqAmvu3yBbxUrPqDaIdjEzuysosxxQE+/7mPORd8LDfzq2CzfrDz4Px/6
 tqWe0UnVDQHWhXQUxJF013o6IAiuEg9NBvZRAULsApTVNSShbbG0qoSO3sbAMExICcuC
 FbaVVA5UvYVpY+ezHXwv5NxqP+ewWqqJe8WIQq5JgUycDlT3QMzclzuArq12Hbg7WQnQ
 7HQbqpjUjP7RSc6n+Sm8atb/ZB1BveucENcSxvIQ5TxURaLubDO5Mod5iWxm99BdGFaO
 nO2P+IXrDZHaaI4ubrOtF+behB/oGW46LJDf3U6iBnraiPWWI+6aXlMspmjwDZiIGsvT
 fc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721311892; x=1721916692;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5mNz5fwjQxA7hRjG/y2bSuDn47T4+Ayl8EytxxJFnmE=;
 b=BfzJFNi8UANlD0QH2I896Ch5sL2LSb8aWI/l6PpqMYqXgrwE+34GSWozQqNQTB2qOU
 IxYKnt/ucy9kdT42B8dgutngEbFP2QUrMTpzdjD7w8xlYnCCA54E9EXVGvMBYuEU7RKi
 1sgvnH7+GtA2dUskbwue3+oNo/EsfDtDE2eNqpGVBaz3k5qjzwjO2J51gc6hHqhwhoyw
 WKB3XaP/W4XD/MVxSfB+aQ2GYDK5hn5GOzevSR6i2k594zh/Oeb6k0leEkA+rB810M7+
 hjpYWJZ8N6VyhgNnJlbvsDyw/WUJB07kkkyBntipchIvXgxRDlipUz7wuuL5CsZTUGma
 DHGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3uVRXrxgxvLVGJEUHoqB3hvr4+P2qtV+/xCvsqh3jKB7yHC0i3yKdd39KaY64wmggC3CMtnBBejbk9s+8X8/2xA1f3A==
X-Gm-Message-State: AOJu0Yzd2DbI9WMkgWY58tUjPtnGrHb5QGTUVnAWu5E/0Q3iPXh+D2dV
 BtrH/QxW9CfNArr5OLx2jSV0bZ0VxeCu5TcfcIWUSmWYOO5hqvHUKkdXzQ==
X-Google-Smtp-Source: AGHT+IHl2XLD5gXi6RRh7Vy6DTd56p0pczONX94yMNvfblr7Oc1U02S6hDdLmFfmf/D3DC1nHRXKag==
X-Received: by 2002:a05:620a:1a22:b0:795:4d37:82a8 with SMTP id
 af79cd13be357-7a193981b56mr137840185a.22.1721311891549; 
 Thu, 18 Jul 2024 07:11:31 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19396fe9asm27987385a.118.2024.07.18.07.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 07:11:31 -0700 (PDT)
Message-ID: <cd57edbe-bf5a-0545-9cbb-f39babdbe776@gmail.com>
Date: Thu, 18 Jul 2024 10:11:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/21] test: Move some SPL-loading test-code into
 sandbox common
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-4-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240713070055.2172883-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/13/24 03:00, Simon Glass wrote:
> This code is useful for loading an image in sandbox_spl so move it into
> a place where it can be called as needed.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   arch/sandbox/cpu/spl.c         | 67 ++++++++++++++++++++++++++++++++++
>   arch/sandbox/include/asm/spl.h | 14 +++++++
>   test/image/spl_load_os.c       | 53 +--------------------------
>   3 files changed, 82 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
> index 9ad9da686c6..caa8e0b3b01 100644
> --- a/arch/sandbox/cpu/spl.c
> +++ b/arch/sandbox/cpu/spl.c
> @@ -6,6 +6,7 @@
>   #include <dm.h>
>   #include <hang.h>
>   #include <handoff.h>
> +#include <image.h>
>   #include <init.h>
>   #include <log.h>
>   #include <os.h>
> @@ -179,3 +180,69 @@ int handoff_arch_save(struct spl_handoff *ho)
>   
>   	return 0;
>   }
> +
> +/* Context used to hold file descriptor */
> +struct load_ctx {
> +	int fd;
> +};
> +
> +static ulong read_fit_image(struct spl_load_info *load, ulong offset,
> +			    ulong size, void *buf)
> +{
> +	struct load_ctx *load_ctx = load->priv;
> +	off_t ret;
> +	ssize_t res;
> +
> +	ret = os_lseek(load_ctx->fd, offset, OS_SEEK_SET);
> +	if (ret < 0) {
> +		printf("Failed to seek to %zx, got %zx (errno=%d)\n", offset,
> +		       ret, errno);
> +		return log_msg_ret("lse", ret);
> +	}
> +
> +	res = os_read(load_ctx->fd, buf, size);
> +	if (res < 0) {
> +		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
> +		       size, res, errno);
> +		return log_msg_ret("osr", res);
> +	}
> +
> +	return size;
> +}
> +
> +int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image)
> +{
> +	struct legacy_img_hdr *header;
> +	struct load_ctx load_ctx;
> +	struct spl_load_info load;
> +	int ret;
> +	int fd;
> +
> +	memset(&load, '\0', sizeof(load));
> +	spl_set_bl_len(&load, 512);
> +	load.read = read_fit_image;
> +
> +	ret = sandbox_find_next_phase(fname, maxlen, true);
> +	if (ret) {
> +		printf("%s not found, error %d\n", fname, ret);
> +		return log_msg_ret("nph", ret);
> +	}
> +
> +	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
> +
> +	log_debug("reading from %s\n", fname);
> +	fd = os_open(fname, OS_O_RDONLY);
> +	if (fd < 0)
> +		return log_msg_ret("ope", -ENOENT);

should return errno

and I think longer messages won't hurt (this is sandbox after all).

> +	if (os_read(fd, header, 512) != 512)

Actually, this should probably be sizeof(*header) and not 512

> +		return log_msg_ret("rea", -EIO);

ditto errno/message

> +	load_ctx.fd = fd;
> +
> +	load.priv = &load_ctx;
> +
> +	ret = spl_load_simple_fit(image, &load, 0, header);
> +	if (ret)
> +		return log_msg_ret("slf", ret);
> +
> +	return 0;
> +}
> diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
> index 4fab24cd156..d50d9ad6b48 100644
> --- a/arch/sandbox/include/asm/spl.h
> +++ b/arch/sandbox/include/asm/spl.h
> @@ -6,6 +6,8 @@
>   #ifndef __asm_spl_h
>   #define __asm_spl_h
>   
> +struct spl_image_info;
> +
>   enum {
>   	BOOT_DEVICE_MMC1,
>   	BOOT_DEVICE_MMC2,
> @@ -31,4 +33,16 @@ enum {
>    */
>   int sandbox_find_next_phase(char *fname, int maxlen, bool use_img);
>   
> +/**
> + * sandbox_spl_load_fit() - Load the next phase from a FIT
> + *
> + * Loads a FIT containing the next phase and sets it up for booting
> + *
> + * @fname: Returns filename loaded
> + * @maxlen: Maximum length for @fname including \0
> + * @image: Place to put SPL-image information
> + * Return: 0 if OK, -ve on error
> + */
> +int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image);
> +
>   #endif
> diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
> index 7d5fb9b07e0..56105a59236 100644
> --- a/test/image/spl_load_os.c
> +++ b/test/image/spl_load_os.c
> @@ -10,63 +10,12 @@
>   #include <test/spl.h>
>   #include <test/ut.h>
>   
> -/* Context used for this test */
> -struct text_ctx {
> -	int fd;
> -};
> -
> -static ulong read_fit_image(struct spl_load_info *load, ulong offset,
> -			    ulong size, void *buf)
> -{
> -	struct text_ctx *text_ctx = load->priv;
> -	off_t ret;
> -	ssize_t res;
> -
> -	ret = os_lseek(text_ctx->fd, offset, OS_SEEK_SET);
> -	if (ret != offset) {
> -		printf("Failed to seek to %zx, got %zx (errno=%d)\n", offset,
> -		       ret, errno);
> -		return 0;
> -	}
> -
> -	res = os_read(text_ctx->fd, buf, size);
> -	if (res == -1) {
> -		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
> -		       size, res, errno);
> -		return 0;
> -	}
> -
> -	return size;
> -}
> -
>   static int spl_test_load(struct unit_test_state *uts)
>   {
>   	struct spl_image_info image;
> -	struct legacy_img_hdr *header;
> -	struct text_ctx text_ctx;
> -	struct spl_load_info load;
>   	char fname[256];
> -	int ret;
> -	int fd;
> -
> -	memset(&load, '\0', sizeof(load));
> -	spl_set_bl_len(&load, 512);
> -	load.read = read_fit_image;
> -
> -	ret = sandbox_find_next_phase(fname, sizeof(fname), true);
> -	if (ret)
> -		ut_assertf(0, "%s not found, error %d\n", fname, ret);
> -
> -	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
> -
> -	fd = os_open(fname, OS_O_RDONLY);
> -	ut_assert(fd >= 0);
> -	ut_asserteq(512, os_read(fd, header, 512));
> -	text_ctx.fd = fd;
> -
> -	load.priv = &text_ctx;
>   
> -	ut_assertok(spl_load_simple_fit(&image, &load, 0, header));
> +	ut_assertok(sandbox_spl_load_fit(fname, sizeof(fname), &image));
>   
>   	return 0;
>   }

