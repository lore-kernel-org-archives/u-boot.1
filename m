Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A32DC48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 14:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE8D87CEC;
	Tue, 13 Feb 2024 15:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EzBFaWfx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F4487D58; Tue, 13 Feb 2024 15:23:50 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 378E2875FA
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 15:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51181d8f52fso1235510e87.3
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707834225; x=1708439025; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RGaN2CbLovCN4fYU/hyCNaph/OgJolU8Dx+aB4vMT9A=;
 b=EzBFaWfxtZxYcfIh2IkY5G18kmflvl+5jOdz6fyPC0SGlWESQ6TSNgegNdbQEuiwDT
 zHAmqs+PO9b5y50BerSvWaYSVvA3d68Ej+eKghUamG6E01EWb1gUHyLOKbQqEE3N0oBV
 Kuq4cvPbTiz/+h8SE1nkcysZ946ZoluV+wRqMTtrB3XUSU8oiyVAfZnBdbnVb1V2iybE
 XL6jDhEjZdnAxxxQj544KTLMSdXIAW6XSKdoaQbVEDUuTYZpu+XfQ5d7iCd/U/cDMtfD
 VnwYava0YCGr0SnDI9X30ZsU5ER8AqcgRWTOZI5EgASVn56h6+aHk6LHq0cvYxOdTs6d
 lFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707834225; x=1708439025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RGaN2CbLovCN4fYU/hyCNaph/OgJolU8Dx+aB4vMT9A=;
 b=Lwnf+oXL3JHlmPTRaohLewgeqgxU1Qio+1f+UwIgP0chmfyTt+Z2VaSAgZZuzZ/ZF5
 lpjtqhWRYjyYHxzVEZ9azQ2gjnhbwSSSbOKYDJ+KM3zlrjjIDUat7noMSBbCcgliFYv7
 TUgggyjCH7DnvM/djAxkOG4nbUi0vZ1ONLzNPWCG+T3BbKdGac/M6n3vGRJCcce0xFkZ
 vtKvY8CKyujAqteYN1ZjhVSjywU6V9vd8wC/Iy3q7Cpm3SgWFsmz38rf7F47mI9DLlkB
 2XIX8Bl00V80NjU4GJNgvlGNu3ZiMxcoppscTSmQCYgWlfuN3P7Rnx3QRB19fMDFwAhX
 DS9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsstbWgiCk/QsG4g82eHrXZ2EbcmYFu4ECm7vfOClrXbHY9m4zlWl0+GyaBMc8KcCv8LmQNSQy+T7dnLOVpFDYzw/4hA==
X-Gm-Message-State: AOJu0YzIjYsreSEXIa8p5dm09fjzKe/QT5tdn6bp1FtbQEyGpI4T+0CI
 BkwW3AZolIhxh+zKNN4vGrcDOIsnt+sM7NK+OXZ8XaonblCcxbUaKI0MC7Cw7TV+ehHo9GlkO+W
 geGc1omA2EGltbmhyXXZbY5CMmctXnsNy8R30Ug==
X-Google-Smtp-Source: AGHT+IFk51CPy85vHBcx/po84HJx57m+dLo7Y5HNJN6v0IUnxTsl1Rp2MMW1QKVMNLbnLsi1Ng0aH2sMsz0WTwlUGhw=
X-Received: by 2002:ac2:4108:0:b0:511:8d37:4b61 with SMTP id
 b8-20020ac24108000000b005118d374b61mr3977591lfi.3.1707834225354; Tue, 13 Feb
 2024 06:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20240201002022.11258-1-heinrich.schuchardt@canonical.com>
 <20240201002022.11258-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240201002022.11258-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 13 Feb 2024 16:23:08 +0200
Message-ID: <CAC_iWjJpfn5Dxfk_atKm+A=Ah7EOCtroQPdXn_g_BHCADJy=7A@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmd: smbios: show correct table size for SMBIOS2.1
 entry point
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Eddie James <eajames@linux.ibm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 u-boot@lists.denx.de
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

On Thu, 1 Feb 2024 at 02:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The SMBIOS table size for SMBIOS2.1 entry points is in field 'Structure
> Table Length' (offset 0x16) and not in field 'Maximum Structure Size'
> (offset 0x08).
>
> Rename the receiving variable max_struct_size to table_maximum_size
> to avoid future confusion.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/smbios.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/cmd/smbios.c b/cmd/smbios.c
> index 95bdff6026..e2d82be163 100644
> --- a/cmd/smbios.c
> +++ b/cmd/smbios.c
> @@ -126,7 +126,7 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
>         static const char smbios_sig[] = "_SM_";
>         static const char smbios3_sig[] = "_SM3_";
>         size_t count = 0;
> -       u32 max_struct_size;
> +       u32 table_maximum_size;
>
>         addr = gd_smbios_start();
>         if (!addr) {
> @@ -142,7 +142,7 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
>                          entry3->major_ver, entry3->minor_ver, entry3->doc_rev);
>                 table = (void *)(uintptr_t)entry3->struct_table_address;
>                 size = entry3->length;
> -               max_struct_size = entry3->max_struct_size;
> +               table_maximum_size = entry3->max_struct_size;
>         } else if (!memcmp(entry, smbios_sig, sizeof(smbios_sig) - 1)) {
>                 struct smbios_entry *entry2 = entry;
>
> @@ -150,7 +150,7 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
>                          entry2->major_ver, entry2->minor_ver);
>                 table = (void *)(uintptr_t)entry2->struct_table_address;
>                 size = entry2->length;
> -               max_struct_size = entry2->max_struct_size;
> +               table_maximum_size = entry2->struct_table_length;
>         } else {
>                 log_err("Unknown SMBIOS anchor format\n");
>                 return CMD_RET_FAILURE;
> @@ -163,7 +163,7 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
>
>         for (struct smbios_header *pos = table; pos; pos = next_table(pos))
>                 ++count;
> -       printf("%zd structures occupying %d bytes\n", count, max_struct_size);
> +       printf("%zd structures occupying %d bytes\n", count, table_maximum_size);
>         printf("Table at 0x%llx\n", (unsigned long long)map_to_sysmem(table));
>
>         for (struct smbios_header *pos = table; pos; pos = next_table(pos)) {
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
