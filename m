Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91711C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 09:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822D2882F0;
	Fri,  5 Jul 2024 11:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z4OK8mR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DCDF88543; Fri,  5 Jul 2024 11:57:32 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6BF68644E
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 11:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7163489149eso1010161a12.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720173448; x=1720778248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5pcpzbhaxgRsWxV3VLuhePxU5gQyLVq3c0+8QI1ALko=;
 b=z4OK8mR359nGKf/lu0Cf7m47aGPifyz5ov8qB24/a8kwC5hLRrr6a6d/pvUo+bbRid
 cyLeYq5YtBbaRpXa0Bj7PR6bwi1EgYM29YILIUwwRiB5sAfHhWLsfPDvlAIi/c5QR4pZ
 q+mMwUQPNGTD25FQ3PvXCJ+XuyNwAGssU00w0xp50PWjt7EKcPylXHK6b4vngll9Cnb+
 u3GjSaYnYNgHRkrb/dOl1ggekO5Or4gwTphebvFvfLzKCdSOt2h2aaiwdDxgBLUkc7eZ
 m+pH5MKuiDxxGION8OhM1+fZ8tbZAoybwpYbtFQiDX3QaijQDUunF9baPAZyTYOJ4DdN
 DdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720173448; x=1720778248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5pcpzbhaxgRsWxV3VLuhePxU5gQyLVq3c0+8QI1ALko=;
 b=JEbUIxUHVrGMwogJhVTYg+5HsHgqxTyeHKy3AQnrLbScYmPjgnBlgBCsG5vujhqqGg
 chR3fn01TJwuwobReqmdYpueaWCktM/o/Flf+AXe/R92yR35UUXrhlB4kyFOpehZ2Vvc
 JIZtjXI+w0r+lpoLDUU/jt3RIAiMq9Mx/C//VJ0ab78K4RetohaXrXxBCxjTOV+VxuyE
 zVsgKn7AGCujq3SKeeTJAQm7A01+caDvIM7Gft7uiIFf6brwZEgBDYC1+SEN8vPYP1b9
 6zAEocsFOYSyhcVLIVcu3/bV1Yf+JKkvpNaWVQ33RTJboM8Ct5yRc2i4PAig5CXXN60e
 3KeA==
X-Gm-Message-State: AOJu0Yy51HVbkyoxyVLA2Y5+nHZFjeIBKPn3wpgh4BoJPefqz21u0ye2
 VitqUIcOw4+cVQqVI3PL6T2Aaumsu6hghhQuH5vxJmHJ+s6O/V2RB7wIGjdl30O3BG40S+jFg/s
 u6logQMOs7kfT/fC3vas51GAuBeg+Bwb8d0IZPQ==
X-Google-Smtp-Source: AGHT+IFqdMWxKeIEp9VdoTpSBsYsMBgLrD5mWBNbIlT0r+ImzW4zOd+XODoJoxl8pwOAP/O3O6ccQGERt93vPHBhtsE=
X-Received: by 2002:a05:6a20:918a:b0:1c0:be3f:5846 with SMTP id
 adf61e73a8af0-1c0cc892907mr4339257637.36.1720173448122; Fri, 05 Jul 2024
 02:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240629070046.24432-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240629070046.24432-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 5 Jul 2024 12:56:52 +0300
Message-ID: <CAC_iWjKaLa0S-mevOLJGsr41HK_5NFrR1VSi8zmBN0T5RkFSgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: print device-tree in dtbdump.efi
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Sat, 29 Jun 2024 at 10:01, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The dtbdump.efi binary can be used for testing the EFI_DT_FIXUP_PROTOCOL.
> It provides a command to load a file and have it fixed up and a
> command to save the resulting file.
>
> Add a command 'dump' for displaying the device-tree.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         print leading '/dts-v1/;'
>         print memory reservation block
>         allow space in string property value to match dtc logic
>         correct formatting of byte strings
> ---
>  lib/efi_loader/dtbdump.c | 261 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 261 insertions(+)
>
> diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
> index 5f39cf22da7..116593d9e25 100644
> --- a/lib/efi_loader/dtbdump.c
> +++ b/lib/efi_loader/dtbdump.c
> @@ -40,6 +40,53 @@ static void print(u16 *string)
>         cout->output_string(cout, string);
>  }
>
> +/**
> + * print_char() - print character
> + *
> + * 0x00 is replaced by '", "'.
> + *
> + * @c: - character
> + */
> +static void print_char(unsigned char c)
> +{
> +       u16 out[2] = u"?";
> +
> +       if (!c) {
> +               print(u"\", \"");
> +               return;
> +       }
> +
> +       if (c > 0x1f && c < 0x80)
> +               out[0] = c;
> +
> +       print(out);
> +}
> +
> +/**
> + * print_hex_digit() - print hexadecimal digit
> + *
> + * @digit:     digit to print
> + */
> +static void print_hex_digit(unsigned char digit)
> +{
> +       if (digit < 10)
> +               digit += '0';
> +       else
> +               digit += 'a' - 10;
> +       print_char(digit);
> +}
> +
> +/**
> + * printx() - print hexadecimal byte
> + *
> + * @val:       value to print
> + */
> +static void printx(unsigned char val)
> +{
> +       print_hex_digit(val >> 4);
> +       print_hex_digit(val & 0xf);
> +}
> +
>  /**
>   * error() - print error string
>   *
> @@ -227,6 +274,7 @@ bool starts_with(u16 *string, u16 *keyword)
>   */
>  void do_help(void)
>  {
> +       error(u"dump       - print device-tree\r\n");
>         error(u"load <dtb> - load device-tree from file\r\n");
>         error(u"save <dtb> - save device-tree to file\r\n");
>         error(u"exit       - exit the shell\r\n");
> @@ -489,6 +537,217 @@ efi_status_t do_save(u16 *filename)
>         return ret;
>  }
>
> +/**
> + * indent() - print a number of tabstops
> + *
> + * @level:     indentation level
> + */
> +static void indent(u32 level)
> +{
> +       for (; level; --level)
> +               print(u"\t");
> +}
> +
> +/**
> + * is_string_value() - determine if property is a string
> + *
> + * If a property is a string, an x-string, or a u32 cannot be deducted
> + * from the device-tree. Therefore a heuristic is used.
> + *
> + * @str:       pointer to device-tree property
> + * @len:       length of the device-tree property
> + * Return:     1 for string, 0 otherwise
> + */
> +static int is_string_value(const unsigned char *str, u32 len)
> +{
> +       int nonzero_flag = 0;
> +
> +       /* Zero length or not ending with 0x00 */
> +       if (!len || str[len - 1])
> +               return 0;
> +
> +       for (u32 i = 0; i < len; ++i) {
> +               if (!str[i]) {
> +                       /* Zero length string or two consecutive 0x00 */
> +                       if (!nonzero_flag)
> +                               return 0;
> +
> +                       nonzero_flag = 0;
> +
> +                       continue;
> +               }
> +               /* Non-printable */
> +               if (str[i] < 0x20 || str[i] >= 0x80)
> +                       return 0;
> +
> +               nonzero_flag = 1;
> +       }
> +
> +       return 1;
> +}
> +
> +/**
> + * print_property() - print device-tree property
> + *
> + * If a property is a string, an x-string, or a u32 cannot be deducted
> + * from the device-tree. Therefore a heuristic is used.
> + *
> + * @str:       property value
> + * @len:       length of property value
> + */
> +static void print_property(const unsigned char *val, u32 len)
> +{
> +       if (is_string_value(val, len)) {
> +               /* string */
> +               print(u"\"");
> +               for (int i = 0; i < len - 1; ++i)
> +                       print_char(val[i]);
> +               print(u"\"");
> +       } else if (len & 0x3) {
> +               /* byte string */
> +               print(u"[");
> +               for (int i = 0; i < len; ++i) {
> +                       if (i)
> +                               print(u" ");
> +                       printx(val[i]);
> +               }
> +               print(u"]\"");
> +       } else {
> +               /* cell list */
> +               print(u"<");
> +               for (u32 i = 0; i < len; ++i) {
> +                       if ((i & 0x3) == 0) {
> +                               if (i > 0)
> +                                       print(u" ");
> +                               print(u"0x");
> +                       }
> +                       printx(val[i]);
> +               }
> +               print(u">");
> +       }
> +}
> +
> +/**
> + * print_mem_res_block() - print memory reservation block
> + *
> + * @rsvblk:    memory reservation block
> + */
> +static void print_mem_res_block(const struct fdt_reserve_entry *rsvblk)
> +{
> +       for (; rsvblk->address || rsvblk->size; ++rsvblk) {
> +               const unsigned char *val;
> +
> +               print(u"/memreserve/ 0x");
> +               val = (const unsigned char *)&rsvblk->address;
> +               for (u32 i = 0; i < sizeof(u64); ++i)
> +                       printx(val[i]);
> +               print(u" 0x");
> +               val = (const unsigned char *)&rsvblk->size;
> +               for (u32 i = 0; i < sizeof(u64); ++i)
> +                       printx(val[i]);
> +               print(u";\r\n");
> +       }
> +}
> +
> +/**
> + * do_dump() - print device-tree
> + */
> +static efi_status_t do_dump(void)
> +{
> +       const unsigned char *fdt;
> +       struct fdt_header *header;
> +       const u32 *end;
> +       const u32 *pos;
> +       const char *strings;
> +       u32 level = 0;
> +
> +       fdt = get_dtb(systable);
> +       if (!fdt) {
> +               error(u"DTB not found\r\n");
> +               return EFI_NOT_FOUND;
> +       }
> +
> +       header = (struct fdt_header *)fdt;
> +       if (f2h(header->magic) != FDT_MAGIC) {
> +               error(u"Wrong device tree magic\r\n");
> +               error(u"Not a device-tree\r\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +
> +       pos = (u32 *)(fdt + f2h(header->off_dt_struct));
> +       end = &pos[f2h(header->totalsize) >> 2];
> +       strings = fdt + f2h(header->off_dt_strings);
> +
> +       print(u"/dts-v1/;\r\n");
> +
> +       print_mem_res_block((const struct fdt_reserve_entry *)
> +                           (fdt + f2h(header->off_mem_rsvmap)));
> +
> +       print(u"/");
> +       for (; pos < end;) {
> +               switch (f2h(pos[0])) {
> +               case FDT_BEGIN_NODE: {
> +                       const char *c = (char *)&pos[1];
> +                       size_t i;
> +
> +                       indent(level);
> +                       for (i = 0; c[i]; ++i)
> +                               print_char(c[i]);
> +                       print(u" {\n\r");
> +
> +                       ++level;
> +                       pos = &pos[2 + (i >> 2)];
> +                       break;
> +               }
> +               case FDT_PROP: {
> +                       struct fdt_property *prop = (struct fdt_property *)pos;
> +                       const unsigned char *label = &strings[f2h(prop->nameoff)];
> +                       u32 len = f2h(prop->len);
> +                       const unsigned char *str = (unsigned char *)&pos[3];
> +
> +                       indent(level);
> +                       for (int i = 0; label[i]; ++i)
> +                               print_char(label[i]);
> +
> +                       if (len) {
> +                               print(u" = ");
> +                               print_property(str, len);
> +                       }
> +                       print(u";\r\n");
> +
> +                       pos = &pos[3 + ((f2h(prop->len) + 3) >> 2)];
> +                       break;
> +               }
> +               case FDT_NOP:
> +                       ++pos;
> +                       break;
> +               case FDT_END_NODE:
> +                       if (!level) {
> +                               error(u"Extraneous end node\r\n");
> +                               return EFI_LOAD_ERROR;
> +                       }
> +
> +                       --level;
> +                       indent(level);
> +                       print(u"};\n\r");
> +                       ++pos;
> +                       break;
> +               case FDT_END:
> +                       if (level) {
> +                               error(u"Missing end node\r\n");
> +                               return EFI_LOAD_ERROR;
> +                       }
> +                       return EFI_SUCCESS;
> +               default:
> +                       error(u"Invalid device tree token\r\n");
> +                       return EFI_LOAD_ERROR;
> +               }
> +       }
> +       error(u"Overrun\r\n");
> +
> +       return EFI_LOAD_ERROR;
> +}
> +
>  /**
>   * efi_main() - entry point of the EFI application.
>   *
> @@ -524,6 +783,8 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
>                 pos = skip_whitespace(command);
>                 if (starts_with(pos, u"exit"))
>                         break;
> +               else if (starts_with(pos, u"dump"))
> +                       do_dump();
>                 else if (starts_with(pos, u"load "))
>                         do_load(pos + 5);
>                 else if (starts_with(pos, u"save "))
> --
> 2.45.2
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
