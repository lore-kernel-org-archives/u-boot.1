Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D61C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 301FF812BC;
	Tue, 25 Mar 2025 15:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="ZjFoRELy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3AA58186D; Tue, 25 Mar 2025 15:49:26 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8169880EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 15:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso43345165e9.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742914163; x=1743518963; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=y7dPC3r01B/xftcPB0VPCVA75b8U0z8V8vdyE4E9xP4=;
 b=ZjFoRELy+8TWzMcqFiyU5eCGySoubYWUsAMlPxBm9vW8uw9Mv+TS/Ffitd7O2fgniL
 tD8deCzlPzm5cGC8OmlKYYNYgzdWUxXITooZQlRjKPONnaBTip7hAjNQJOAtLRynwvbD
 j7c9oE8mJ35q3ghDNs6GDJzoLVeFeYLwk/eOtNa9FXgzuQXlvCMCrdFlSzrmxQ3IIGxH
 EQKTymdIyItPbJegfjKbhgF2zA5FDx7YYLMnvyprllxwNAiJFOpqOpyolFOFeC5KmxAv
 9olCXOC7DajggOCvr75vT1zVInmiPI0cWnSHxGs2pmvzAW0ZnynXIJuXLsdKE9Xz4fVC
 q/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742914163; x=1743518963;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7dPC3r01B/xftcPB0VPCVA75b8U0z8V8vdyE4E9xP4=;
 b=BVWXPwb+qfxC5IgNuKBtJZKcHOSLPSgmeypzzacR+IGsk7udU0sFTRj2egcRdBFGx+
 gbGnfcvp4lRQ51J0xK+qaOfjQw99Z5ZIDAmppl8F2mjybRxZ9XVXUIoql46m/+O8Absa
 13MTd6rSv8Hs5BgG448OyLBdc+6V0LxfZO9RvH7u462LGjB/fZsa1tTUPsIFIX6p07zT
 GrlumcGcKMV+hozsBkbp9E1xS+lQUzkauZt2lLpdYXTayQZDCkEP60Jgjrrb9IjisAi1
 TthuothCjM7gLNH8W7a/uaieL9R/cfz9kPGYB62GvT8NvShl7KcQfu2ykrlBsaZxOaH7
 nbhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWslzf7Y5Og4uXXOFwfL2NLfeVUiNl+LZAUBS+DStTjfc9BSHxDyAVZ+QnviF8gJYo/F9iJHiM=@lists.denx.de
X-Gm-Message-State: AOJu0YzuBazWp1dO0vusK1FjZ4oGNa+xFA8/NLMGdvPe3sazURkYJD/L
 4T4IxhhNiesQB0EfO4wkZ69Z3KKA8dYMS+s88pwtTviOV4AwbGS3JnmktaD3VuQ=
X-Gm-Gg: ASbGncvlZ0VjpBG1pvOMqb9sP/5t9b+gq8NU4J+XqWudqZyR/+YiduNjMnUkWdellNn
 MzL6CctPujVXBA5FYxXLy0lAyPDB4py81FeO+u9ld/RxIHOOjPa4pUntCgaOjetKvdME8orxxdM
 OkSPtl22R4grPCloOCoyMF7LNpLa9fW/qBiw+md4vCXv8SYsW7XFCWpdi1uO+jHnUDS75EIPIWn
 42W6klRc18fSnmjCy7YIY5erWrdcAiP5jzWJ7/ko1Nksr/xhFkAjffXdY1GF9dpIATYq1JtJuLk
 FY2ag7Lj2xtLbCN6p6iBVCOSsgbAke1qpK4V+C4OkLk4lG4RcWhm
X-Google-Smtp-Source: AGHT+IH6WjN4uBPGKuxBX8nv6GlUb6FR5WV4+Zu/ihthOU6RYnj+YuRAw5iYcCq5Px+g3cNjv+7qoQ==
X-Received: by 2002:a05:600c:3b07:b0:43c:f00b:d581 with SMTP id
 5b1f17b1804b1-43d50a4b494mr157338375e9.29.1742914162829; 
 Tue, 25 Mar 2025 07:49:22 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6667sm14127877f8f.72.2025.03.25.07.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 07:49:22 -0700 (PDT)
Message-ID: <9b35c8c5-d6ea-485b-9ab3-dc027163a515@suse.com>
Date: Tue, 25 Mar 2025 15:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] acpi: new function acpi_update_checksum()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Fiona Klute <fiona.klute@gmx.de>, Martin Stolpe <martinstolpe@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
References: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
 <20250321232121.251800-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250321232121.251800-2-heinrich.schuchardt@canonical.com>
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



On 22/03/2025 00:21, Heinrich Schuchardt wrote:
> Introduce a new function to update ACPI table headers.
> This allows to simplify the existing code.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   include/acpi/acpi_table.h | 7 +++++++
>   lib/acpi/acpi.c           | 7 +++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> index b8b1f1338c6..f8e5f552ab1 100644
> --- a/include/acpi/acpi_table.h
> +++ b/include/acpi/acpi_table.h
> @@ -1274,6 +1274,13 @@ ulong write_acpi_tables(ulong start);
>    */
>   struct acpi_table_header *acpi_find_table(const char *sig);
>   
> +/**
> + * acpi_update_checksum() - update ACPI table checksum
> + *
> + * @header - header of an ACPI table
> + */
> +void acpi_update_checksum(struct acpi_table_header *header);
> +
>   #endif /* !__ACPI__*/
>   
>   #include <asm/acpi_table.h>
> diff --git a/lib/acpi/acpi.c b/lib/acpi/acpi.c
> index f4d5c1e25d0..596301a43fe 100644
> --- a/lib/acpi/acpi.c
> +++ b/lib/acpi/acpi.c
> @@ -6,11 +6,18 @@
>    */
>   
>   #include <mapmem.h>
> +#include <tables_csum.h>
>   #include <acpi/acpi_table.h>
>   #include <asm/global_data.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +void acpi_update_checksum(struct acpi_table_header *header)
> +{
> +	header->checksum = 0;
> +	header->checksum = table_compute_checksum(header, header->length);
> +}
> +
>   struct acpi_table_header *acpi_find_table(const char *sig)
>   {
>   	struct acpi_rsdp *rsdp;

