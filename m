Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1938C55174
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 058B580EC4;
	Sat,  8 Aug 2026 17:23:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jE3yDMtk9cBK; Sat,  8 Aug 2026 17:23:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E60A80E91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786209807;
	bh=n5zybGVTJMFyVi7IwPnCVfvZnb+pYKQeVIyhc3Br/hM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Funb917ncERNIqhbtGBRoCFWx7j747kgRcxjKmwf1ArGxmmKD9Bau7yoGDAXEDbdq
	 Vx97F9AdLM1spflwedBO3sqhmJ9tHAxaGQCULhWdAger+fKESNwTqHVRd9j42kXiSF
	 h0ljuj4upgDBRELlcxoGlkEi5JA89nwNgFgh7fIlHM8+gWGMzAvFFKEgb9+ru25N4o
	 ugiafHn7mlnOz9wsMBvSRvu64tfrvMD8Iu8whhdzd88lxj6klnXnxBGUNzsBU9uwzy
	 rmNKCGRZB4AanUD1/0YldY+o7wbzPT9hP7sG+Mldtf7PYgvODQqQ//oFZlJbIqPmHP
	 2NxsA7Y/VvJCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E60A80E91;
	Sat,  8 Aug 2026 17:23:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A6BEB296
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CFF8400D3
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9v0GF0Skm_W for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:23:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8D7564007A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D7564007A
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D7564007A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:24 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a17cb94b26so785767a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786209802; cv=none;
 d=google.com; s=arc-20260327;
 b=Zay8wX0ZapaeIj6KjEb9gDRhLT5ywzDJ8iaytHrHJaRf+DOH0tp5Vo+S1jLgzPNEW+
 eaA1W57QRFWoxCuIrKI06UTrEk8+yRBHIUdvSM/TKjc21VrrdNT/2eUL+7+0y8GlWheP
 sUkiuooE0nfjyidMqRGExZb/P9pIb0FxLQjYcOXeUV1t7uPAYo5T8q3+sWqXJ0cW9bu0
 cQWqRtoMIGF5c/ePCp2GSsot8PIEo9aoo4H+EVbO5KiRZt5IRjz2mzN6oX7okDd/wDDe
 dTz6Iy7UxB+vQCF4GueHdwhAj/Caa4A8XZbMN8fchm/eqFTwCIwdCVWtBLcncrV20M4v
 JrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n5zybGVTJMFyVi7IwPnCVfvZnb+pYKQeVIyhc3Br/hM=;
 fh=Yvqp1IYQMFjLj9zCkC4w4ectsS5JIuQOsnvOWh99j8w=;
 b=ZgI89se4GwgUo8UYLif4nA9loGd12QZjINXc7NCSLZd9uWVwMC0bVb5YonsOfh4RPK
 GiJOq4mr8Lv86ukvGY6bJwPs3foXJV7X+3gd+YtOSkjjZ0t+iZ8vMa0hE75419fTlA0s
 UAlJjLDeS/xuOlOngDqZWRfruUOTSnJerS+pFxoRvt2ny7OsrZ/Y0fodUYbR8f9vjo3G
 bR7hQ9mBV5qFrq3/+ZhsYeLt4f5qRaWzeiGBhd9sLXIOGIHInODA8U8ZtA2UtPn7cY+F
 4JE6R+xC09l/wzg8377TSWey9HYmLDneJbHtHXuFlZA59QEtrhovEBJ/plOHE8lrE6NM
 +jTw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786209802; x=1786814602;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n5zybGVTJMFyVi7IwPnCVfvZnb+pYKQeVIyhc3Br/hM=;
 b=jBSEvR0rBcTBULaycHypQYzLSxXfqVJiq9tiBcC3cHt0ugOjvEQMx192NsdJmlJWJ/
 DJyX1bCTJlEeqoYO1ru6aUtSURTowUbF7jcqCmkSdgoo4t4KM2doqWOXw06B9+0WxVmj
 tPMR1+WJqbGgToooft3D5VflcxuHMs5+ZeSOjHFJJYvpWuWdBuqYTjohKDU9T4DqXUS+
 vUocswRnVlLK0W0xW7WH0VShkZ20kAC/cywe2CqP+3yzlVLv6Bo/+9oPiko1rhyrk2tG
 glT82emLVB1FVIoQ6cfWqRABghtO3osH2who5F9Djd2kq+oKSx5tcn+drlaXgYFkg6iI
 SiRw==
X-Gm-Message-State: AOJu0Yx14l+zG0GM7Wv0ekSbQL4iJEQKn3DPj3vwA+lJaQ8S3NQRZPdi
 dVIFUhxB2vIqse6IhyZLczxy73DVqAs+YRvv3g9+hQfXRtUdLncRqAyLQm3D8IVSf1BbPYQfEli
 tDJtO69WREvkGPDDhsxFHSusLmqkCWjV9iYyTFbrO
X-Gm-Gg: AR+sD12f0vvxvU2o3Gz0OcwvRwgSQibc4RMxEMZyfzMd32LCMbedm8TMZwrdsMLJ8I8
 BuTbz4h8cvTbxO0PK+JQ0XjrU8lfzQR7TPHPlcO9BqSi+tIx29kt7tdGS/QEv+eRIhJ1QrdlvhX
 U9TwKFMJ0dThn5auMK9WqBPdM9rT7YauUTm91GUEf+SSL6basqUXmAcWK55bVzUuyFZVH3iqVsB
 KkeMO+gNP8WIE3U/zOjvUkv8R6uRrG0r9uuB2cCtf9V8tBjIbdHjj2tdzUn/eqFKzpqDcWWQtac
 1uvyedQvdqE7Sptjec2o61Kqwbz+4nqltW+v+4PBuA8=
X-Received: by 2002:a05:6402:5023:b0:698:9e5e:5df8 with SMTP id
 4fb4d7f45d1cf-6a1e5ac7ab9mr5797052a12.7.1786209802467; Sat, 08 Aug 2026
 10:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-tpm-trunc-resp-v4-0-5dd1a634ea4d@byteray.co.uk>
 <20260729-tpm-trunc-resp-v4-1-5dd1a634ea4d@byteray.co.uk>
In-Reply-To: <20260729-tpm-trunc-resp-v4-1-5dd1a634ea4d@byteray.co.uk>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:23:11 -0600
X-Gm-Features: AUfX_myqiESvHOk29_sDpEYoxOucYOOrKodIOEz1jfWRNlK55Fff0UO8f3I878w
Message-ID: <CAFLszTjawt7CW0r6E49xhbQyf+v-nkNGJZBn_oEchJ9-xCW07Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tpm: bounds-check the device-reported response
 length
To: shahriyar@byteray.co.uk
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Reinhard Pfau <pfau@gdsys.de>,
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786209802; x=1786814602;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n5zybGVTJMFyVi7IwPnCVfvZnb+pYKQeVIyhc3Br/hM=;
 b=BMaPPzZOkhwle6RDgPvLtOSrZQS7/b1EBVfbIY6rPyPz+pIxnvvrLA8TnECG6qvZxh
 +36FY9ovU++FsVEqWbvHkY5XsdVRg+PdG2BIgclBlYz9UgQVFdA6Tgg1ktez2Si2Ad0E
 klREWNskwbO1blHDwz7zdJA8H0NZrsnPoaLc0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=BMaPPzZO
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Shahriyar,

On 2026-07-29T18:25:21, shj <shahriyar@byteray.co.uk> wrote:
> tpm: bounds-check the device-reported response length
>
> The length of a TPM reply is set by the device: tpm_sendrecv_command()
> stores the number of bytes received, caps it only at the command buffer
> size, and reports success whenever the reply's return code is 0. Callers
> then use that length unchecked. The clearest damage is in the parsers that
> compute response_length - <header> and index the result (the TPM1 OIAP
> helpers and tpm2_get_capability): a reply shorter than the header
> underflows the subtraction into a huge memcpy.
>
> Rather than guard each caller, check the length once at the choke point.
> tpm_sendrecv_command() gains a min_response_len argument and rejects a
> reply shorter than the caller says it needs, before the caller parses it;
> every command that reads a response now declares its minimum.
>
> tpm2_get_capability() additionally copies response_len - 15 bytes into the
> caller's buffer, but was never told how big that buffer is, so a reply
> longer than it overruns it. Give the function a buf_size argument and
> reject a reply that would not fit, so the copy is bounded for every
> capability rather than for the properties query alone.
> [...]
>
> cmd/tpm-v2.c              |  4 +++-
>  include/tpm-v2.h          |  5 ++--
>  lib/efi_loader/efi_tcg2.c |  9 ++++---
>  lib/tpm-common.c          | 16 ++++++++++---
>  lib/tpm-utils.h           |  8 ++++++-
>  lib/tpm-v1.c              | 59 +++++++++++++++++++++++++++-------------
>  lib/tpm-v2.c              | 60 ++++++++++++++++++++++++++++-------------
>  lib/tpm_api.c             |  4 +++-
>  8 files changed, 106 insertions(+), 59 deletions(-)

> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> @@ -550,12 +550,13 @@ u32 tpm2_pcr_read(struct udevice *dev, u32 idx, unsigned int idx_min_sz,
>   * @capability       Partition of capabilities
>   * @property Further definition of capability, limited to be 4 bytes wide
>   * @buf              Output buffer for capability information
> - * @prop_count       Size of output buffer
> + * @buf_size Size of @buf in bytes
> + * @prop_count       Number of properties to request
>   *
>   * Return: code of the operation
>   */
>  u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
> -                     void *buf, size_t prop_count);
> +                     void *buf, size_t buf_size, size_t prop_count);

The copy is now bounded for every capability, and the kerneldoc
distinguishes the two counts.

Reviewed-by: Simon Glass <sjg@chromium.org>
