Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33E8EE3F0C
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 19:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D4A86E87;
	Tue, 12 Sep 2023 21:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LiPmJXVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7BC986D3E; Tue, 12 Sep 2023 21:27:06 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF1086D59
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 21:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so345542a12.1
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694546823; x=1695151623; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gHHTgULNX26zp/i0NrtV4FQj7i38TzwSX3WISqKiX7g=;
 b=LiPmJXVstcIxN+B6X7k47QyA3paGsf0tlYMSEYmrEAxi9OZpS/FbgA9nngJyc6pOGq
 gRaVY40uzIyHG2BHV8rAd88Dg25+e3autEdjl8dRyDgGVuMkqdmZgi7kbtUfPrLhv7cE
 hUufYyBBftbRNvwy1/zwtWtor9PCbQqg5T2gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694546823; x=1695151623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHHTgULNX26zp/i0NrtV4FQj7i38TzwSX3WISqKiX7g=;
 b=RQuX4QKhPlPPdhZj/M093/b70q2RnvlHUOuF1+3GZxhlOZpeVlfhNsonAyFy/Hdz1l
 YZOTOq1uJv7KAXMZ4grOJ4tzYohFarPX8IuDPKZKzpwhN9qj2pn/SHcbf8Qqu9w+TivE
 xW00m+fyPhJZTho5DmhyZPUFe2gshvvoKIcN668xuJ3hqYMnM7upusKyS3Axpvq43R7R
 EEl7IMMwPrPbWGiFG5aC4xVs5d3L/R5kQ/xXk1RUcET+kEonjOCZGJ28kA85dpSeWMvh
 ezp4eDC34Jg1+2H5gUf0m2BDxDvhY6HxNlIvBTuGl7u5EmF/+n/jc1kYAIFKvWK/NP1k
 TQCA==
X-Gm-Message-State: AOJu0YyIMBKt2Q07jyArvUpzrSlZGg2ez8/ODboar/rKmiGExMB2J1wb
 THCmiJ1y3dWjXWXRYnSw8sD4+uMkb50Bg8GSHvvMXg==
X-Google-Smtp-Source: AGHT+IGWxhnu8uFs0EMeswoCGUPIdRH1/ul/0wyx9HBe1MH8+ymoM9kqQwV2mtcUAIKl1axjbmG4BgCU5ymReunYIp0=
X-Received: by 2002:aa7:c748:0:b0:523:c36e:ec8b with SMTP id
 c8-20020aa7c748000000b00523c36eec8bmr873861eds.9.1694546823503; Tue, 12 Sep
 2023 12:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694435541.git.michal.simek@amd.com>
 <ffe462a5a535018833443821880becf3bb366564.1694435541.git.michal.simek@amd.com>
In-Reply-To: <ffe462a5a535018833443821880becf3bb366564.1694435541.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 12 Sep 2023 13:26:49 -0600
Message-ID: <CAPnjgZ2dPj2RJh5vXQQ_6AkauPDzG65TdqYMz16RPXqVmYEuOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] trace: Fix alignment logic in flyrecord header
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Tom Rini <trini@konsulko.com>
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

Hi Michal,

On Mon, 11 Sept 2023 at 06:32, Michal Simek <michal.simek@amd.com> wrote:
>
> Current alignment which is using 16 bytes is not correct in connection to
> trace_clocks description and it's length.
> That's why use start_addr variable and record proper size based on used
> entries.
>
> Fixes: be16fc81b2ed ("trace: Update proftool to use new binary format").
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  tools/proftool.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

See my comment below

> diff --git a/tools/proftool.c b/tools/proftool.c
> index 7c95a94482fc..f79128169e68 100644
> --- a/tools/proftool.c
> +++ b/tools/proftool.c
> @@ -1493,19 +1493,43 @@ static int write_pages(struct twriter *tw, enum out_format_t out_format,
>  static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
>                            int *missing_countp, int *skip_countp)
>  {
> -       unsigned long long start, len;
> +       unsigned long long start, start_addr, len;
>         int ret;
>         FILE *fout = tw->fout;
>         char str[200];
>
> +       /* Record start pointer */
> +       start_addr = tw->ptr;

I'd prefer start_ofs since it is not an address, is it?

> +       debug("Start of flyrecord header at: 0x%llx\n", start_addr);
> +
>         tw->ptr += fprintf(fout, "flyrecord%c", 0);
>
> +       /* flyrecord\0 - allocated 10 bytes */
> +       start_addr += 10;
> +
> +       /*
> +        * 8 bytes that are a 64-bit word containing the offset into the file
> +        * that holds the data for the CPU.
> +        *
> +        * 8 bytes that are a 64-bit word containing the size of the CPU
> +        * data at that offset.
> +        */
> +       start_addr += 16;
> +
>         snprintf(str, sizeof(str),
>                  "[local] global counter uptime perf mono mono_raw boot x86-tsc\n");
>         len = strlen(str);
>
> +       /* trace clock length - 8 bytes */
> +       start_addr += 8;
> +       /* trace clock data */
> +       start_addr += len;
> +
> +       debug("Calculated flyrecord header end at: 0x%llx, trace clock len: 0x%llx\n",
> +             start_addr, len);
> +
>         /* trace data */
> -       start = ALIGN(tw->ptr + 16, TRACE_PAGE_SIZE);
> +       start = ALIGN(start_addr, TRACE_PAGE_SIZE);

Would it be possible to store the old tw->ptr value at the top of this
function (e.g. in tw_base) and calculate start using (tw->ptr -
tw_base)? It seems that there are two parallel trackers here.

>         tw->ptr += tputq(fout, start);
>
>         /* use a placeholder for the size */
> @@ -1517,6 +1541,9 @@ static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
>         tw->ptr += tputq(fout, len);
>         tw->ptr += tputs(fout, str);
>
> +       debug("End of flyrecord header at: 0x%x, offset: 0x%llx\n",
> +             tw->ptr, start);
> +
>         debug("trace text base %lx, map file %lx\n", text_base, text_offset);
>
>         ret = write_pages(tw, out_format, missing_countp, skip_countp);
> --
> 2.36.1
>

Regards,
Simon
