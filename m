Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA00ED3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 11:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3628D8051F;
	Tue,  9 Dec 2025 12:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.b="fRoxFJx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE4708051F; Tue,  9 Dec 2025 12:06:43 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF088036B
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 12:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriana@arista.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7cab8b4a6faso129528a34.3
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 03:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=google; t=1765278399; x=1765883199; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjpZ0fKIkEqM8c6FFwj6l7H99iWBwd1AF62kuTftT2E=;
 b=fRoxFJx00n1qRFNcI06WAsnGEgKKEs9SHKJTWGT8QCEvSkmWRpEwmsW9h9TcUJceUS
 TCH7kqAxasgBtgIg/Rz9g7oZfdgO1798L5vdLmQITXp+Aty87afqWwxcH/rb8m06JrMf
 q9pa8/8dlLMngJEA6l9OCCrtYAZhNvij89bQ4MxHVI9s9XWLNMXuM8qA1jzVicXWPMfV
 tAjp0DTpvul4vD3UTFFGhx7fdHKuq19cjfk1Xor6P6xIRmvJKcMw9Md5C2yU7A5MQ4sl
 ZrAt41d/KQ2jX5v60hpbr0tigABYtmtZigc+7vsB589QkYWSOpriev2YeAOlbDOMqKE+
 iMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765278399; x=1765883199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MjpZ0fKIkEqM8c6FFwj6l7H99iWBwd1AF62kuTftT2E=;
 b=smv7k4C/rZOYTlPpWTKRH6DlhoDYXrucAqwlgoo/yiRQz7PJvb+arq1ikafGFWyQCH
 OZZ/fVrkwG09CIOZjVocsxKzDivWrn7YWBJD+SaY9q/H7vuy4Xz2qlfNIHAnBrKt0Z6Z
 pnmqnhzl1moJgj3+ZUvtkVEark4GfWnIFhL6YJLKUtcr+r+kfxz0HPMCvUlbZLPsVZ9R
 e88YNO2KkA63OqBiIGNFU5M00Y7EgUvo8ReMRumx7prg/xZPIzCrGUZ/bKIifPhrO+mt
 B3VP+hAKVNLVA8e5uXwOGioh62rfKaYnDGNx9rMv3yWtV6WOcVB9WZjSnCtufKozgk1R
 jxyA==
X-Gm-Message-State: AOJu0Ywb19ntr7cHb8Poz/EJyxnx4hXMKYEw7Qq/qKpLvNDHSe69KUKg
 JeucKvyljLV2hTnV2YBGt8geG+EEvnZJ/RE7hbj0hY38gBkZQl41cWBb3SP2306SqdD1qq2OilB
 SvHYYGY0ukOwwukkLBQ/QKVuR17OeC7IA5eUarORZeWc08RVWQpwL8ZW8
X-Gm-Gg: ASbGnctskrgBzcDOrVv9kdyAkZCIXZYLkUN/oKMP2zaL07abXpNHRpwXVy6bHQfeS33
 isJoak+IeZ/CaAvaS18nDf9X1MeFjfgQepW5XyNafza8oc5yWWCCdU4L88patpNW0W1EZ6Klp/c
 4nF+9rn3Ioh6DMNq5e1H9Olec3VszbsSp4I/FlNdUsbway+GPb8PIwrriGpId+6kr/Y2OjoOwnk
 DOWQC5mU7j+RMXx3ewst4j/voc4qf/K2t4MobM24YnAstS1PornkzKrROIU0kZqny48eIbxSEkL
 R0y1eVQvq/ELkwKWYhRDkhjsXrs3qA==
X-Google-Smtp-Source: AGHT+IEceLijNsuMXotEL+MuGzES/I7jX4RE/fbz0EIKstPOuCxERXj1UbWZmvX3++k8HBdklpHZA9WYQFoua9CIgUk=
X-Received: by 2002:a05:6808:19a2:b0:455:7fe4:b228 with SMTP id
 5614622812f47-4557fe4bcf5mr41277b6e.0.1765278399229; Tue, 09 Dec 2025
 03:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20251208193857.GS303283@bill-the-cat>
In-Reply-To: <20251208193857.GS303283@bill-the-cat>
From: Adriana Nicolae <adriana@arista.com>
Date: Tue, 9 Dec 2025 13:06:28 +0200
X-Gm-Features: AQt7F2r8tFTcmyzfKxsaFMmlef0yp9WuJs-xVz8s_1Idl0yUryeD_DwqI-WCAPE
Message-ID: <CAERbo5wWCSdxcN3mgf+GxGLNQf6mP5cvbNm_qq7LkY77bupwzQ@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,

A possible fix for fdtdec.c tests would be to validate the fdt size
before using it.
All 3 tests in this file are using the same approach, if the previous tests=
 were
acceptable the newly added one has some identical parts.

If there is a way to test and fix all these 3 errors, I've put some
changes which
might be enough for Coverity to assume that the size of the fdt is safe. Le=
t me
know how I can test it or should I send an email to post it as a
separate change?

diff --git a/test/dm/fdtdec.c b/test/dm/fdtdec.c
index ea5a494612c..a3c90d38115 100644
--- a/test/dm/fdtdec.c
+++ b/test/dm/fdtdec.c
@@ -14,14 +14,21 @@

 DECLARE_GLOBAL_DATA_PTR;

+#define FDTDEC_MAX_SIZE  (2 * 1024 * 1024)
+
 static int dm_test_fdtdec_set_carveout(struct unit_test_state *uts)
 {
  struct fdt_memory resv;
  void *blob;
  const fdt32_t *prop;
- int blob_sz, len, offset;
+ int blob_sz, len, offset, fdt_sz;
+
+ fdt_sz =3D fdt_totalsize(gd->fdt_blob);
+ if (fdt_sz <=3D 0 || fdt_sz > FDTDEC_MAX_SIZE) {
+ return -EINVAL;
+ }

- blob_sz =3D fdt_totalsize(gd->fdt_blob) + 4096;
+ blob_sz =3D fdt_sz + 4096;
  blob =3D malloc(blob_sz);
  ut_assertnonnull(blob);

@@ -67,10 +74,15 @@ static int
dm_test_fdtdec_add_reserved_memory(struct unit_test_state *uts)
  fdt_size_t size;
  void *blob;
  unsigned long flags =3D FDTDEC_RESERVED_MEMORY_NO_MAP;
- int blob_sz, parent, subnode;
+ int blob_sz, parent, subnode, fdt_sz;
  uint32_t phandle, phandle1;

- blob_sz =3D fdt_totalsize(gd->fdt_blob) + 128;
+ fdt_sz =3D fdt_totalsize(gd->fdt_blob);
+ if (fdt_sz <=3D 0 || fdt_sz > FDTDEC_MAX_SIZE) {
+ return -EINVAL;
+ }
+
+ blob_sz =3D fdt_sz + 128;
  blob =3D malloc(blob_sz);
  ut_assertnonnull(blob);

@@ -138,14 +150,19 @@ static int dm_test_fdt_chosen_smbios(struct
unit_test_state *uts)
  void *blob;
  ulong val;
  struct smbios3_entry *entry;
- int chosen, blob_sz;
+ int chosen, blob_sz, fdt_sz;
  const fdt64_t *prop;

  if (!CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
  return -EAGAIN;
  }

- blob_sz =3D fdt_totalsize(gd->fdt_blob) + 4096;
+ fdt_sz =3D fdt_totalsize(gd->fdt_blob);
+ if (fdt_sz <=3D 0 || fdt_sz > FDTDEC_MAX_SIZE) {
+ return -EINVAL;
+ }
+
+ blob_sz =3D fdt_sz + 4096;
  blob =3D memalign(8, blob_sz);
  ut_assertnonnull(blob);



On Mon, Dec 8, 2025 at 9:38=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> Here's the latest Coverity scan report. I think the test/dm/clk_ccf.c
> report is just a "works as intended" but I'm not sure off-hand about the
> fdtdec.c test. Might be the case the previous test in the file also has
> this problem, and since it's just test code, might also be fine enough.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Dec 8, 2025 at 1:23=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>    - *New Defects Found:* 2
>    - 1 defect(s), reported by Coverity Scan earlier, were marked fixed in
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 2 of 2 defect(s)
>
> Defect Details
>
> ** CID 639831:         (TAINTED_SCALAR)
>
>
> _________________________________________________________________________=
____________________
> *** CID 639831:           (TAINTED_SCALAR)
> /test/dm/fdtdec.c: 153             in dm_test_fdt_chosen_smbios()
> 147
> 148             blob_sz =3D fdt_totalsize(gd->fdt_blob) + 4096;
> 149             blob =3D memalign(8, blob_sz);
> 150             ut_assertnonnull(blob);
> 151
> 152             /* Make a writable copy of the fdt blob */
> >>>     CID 639831:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "gd->fdt_blob->totalsize" to "fdt_open=
_into", which uses it as an offset.
> 153             ut_assertok(fdt_open_into(gd->fdt_blob, blob, blob_sz));
> 154
> 155             /* Mock SMBIOS table */
> 156             entry =3D map_sysmem(gd->arch.smbios_start, sizeof(struct
> smbios3_entry));
> 157             memcpy(entry->anchor, "_SM3_", 5);
> 158             entry->length =3D sizeof(struct smbios3_entry);
> /test/dm/fdtdec.c: 153             in dm_test_fdt_chosen_smbios()
> 147
> 148             blob_sz =3D fdt_totalsize(gd->fdt_blob) + 4096;
> 149             blob =3D memalign(8, blob_sz);
> 150             ut_assertnonnull(blob);
> 151
> 152             /* Make a writable copy of the fdt blob */
> >>>     CID 639831:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "gd->fdt_blob->size_dt_strings" to "fd=
t_open_into", which uses it as an offset.
> 153             ut_assertok(fdt_open_into(gd->fdt_blob, blob, blob_sz));
> 154
> 155             /* Mock SMBIOS table */
> 156             entry =3D map_sysmem(gd->arch.smbios_start, sizeof(struct
> smbios3_entry));
> 157             memcpy(entry->anchor, "_SM3_", 5);
> 158             entry->length =3D sizeof(struct smbios3_entry);
> /test/dm/fdtdec.c: 153             in dm_test_fdt_chosen_smbios()
> 147
> 148             blob_sz =3D fdt_totalsize(gd->fdt_blob) + 4096;
> 149             blob =3D memalign(8, blob_sz);
> 150             ut_assertnonnull(blob);
> 151
> 152             /* Make a writable copy of the fdt blob */
> >>>     CID 639831:           (TAINTED_SCALAR)
> >>>     Passing tainted expression "gd->fdt_blob->size_dt_struct" to "fdt=
_open_into", which uses it as an offset.
> 153             ut_assertok(fdt_open_into(gd->fdt_blob, blob, blob_sz));
> 154
> 155             /* Mock SMBIOS table */
> 156             entry =3D map_sysmem(gd->arch.smbios_start, sizeof(struct
> smbios3_entry));
> 157             memcpy(entry->anchor, "_SM3_", 5);
> 158             entry->length =3D sizeof(struct smbios3_entry);
>
> ** CID 639830:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/clk_ccf.c: 68           in dm_test_clk_ccf()
>
>
> _________________________________________________________________________=
____________________
> *** CID 639830:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/clk_ccf.c: 68             in dm_test_clk_ccf()
> 62      ut_asserteq(CLK_SET_RATE_NO_REPARENT, clk->flags);
> 63
> 64      rate =3D clk_get_parent_rate(clk);
> 65      ut_asserteq(rate, 60000000);
> 66
> 67      rate =3D clk_set_rate(clk, 60000000);
> >>>     CID 639830:         Integer handling issues  (INTEGER_OVERFLOW)
> >>>     Expression "_val1", where "rate" is known to be equal to -38, ove=
rflows the type of "_val1", which is type "unsigned int".
> 68      ut_asserteq(rate, -ENOSYS);
> 69
> 70      rate =3D clk_get_rate(clk);
> 71      ut_asserteq(rate, 60000000);
> 72
> 73      ret =3D clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_PLL3_80M), &pclk);
>
>
>
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>
>
> Best regards,
>
> The Coverity Scan Admin Team
>
> ----- End forwarded message -----
>
> --
> Tom
