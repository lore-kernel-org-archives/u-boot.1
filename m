Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE97C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 11:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9442880F9;
	Sat, 20 Apr 2024 13:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xW7UoQYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AB9988113; Sat, 20 Apr 2024 13:57:02 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00FD688074
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 13:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a523524e5baso296842766b.3
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713614219; x=1714219019; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EnAsbyTSKIj19EON28UbccKkvL5s9IQE4ctdyVilka0=;
 b=xW7UoQYNQctLS1blOPx5hIvVjV0Fp9pW6FZkbVP6DJ4THpIK6do2qor7fsRTCU7YDP
 YmYhnvsx3kAF/dPxT1KVHQ1OCcN9mWE4YdKq0hCHKRSgAhizzb+V1HUJkobefOiYbVTe
 xN+asVv9ISJgC1Atwg2ujHBWyvjISckrzqtHBjebGTehO0AN3AHlPt3zkjS0kzKaHwi3
 7mNeV+ZTsmd4ElSwmELfBIa3/aD1So3LqufospPII1zDEKesV3VEeVav2WTBXwSN/ELw
 2YoMxZ62wkEQTh4Kdp6A1L/p1d8wApMyCWKZ1xzx7xEdyTgha8GuieKlnb0qvNc1eLze
 RAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713614219; x=1714219019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EnAsbyTSKIj19EON28UbccKkvL5s9IQE4ctdyVilka0=;
 b=QWEPng1LEpnqfK2k7vU0lcSsylKtejZJvnMRIpKOKMZgNJ9IROOJUeVOXed1t/eQo3
 wq/qVqhhxrOKpuiLCB7NIJXpQ51Zqx3a4/uSfgxqm/W6i5L64u9dDp/SmC8P8jgt2Whm
 gnT0IB5lKni9xqUobuDZCmQhpCaYrcELHlPI/r6XalVBy80UUVBzg3rUurM/raOzehEh
 lSdsAvWYg+YY67jXP/8WqtVvHSNbQxWx6CGxXshn1P0/7ioJANS6wJ3nU4bZ7fhf7aep
 S3B0ugx9KLuNTTm8Z+YrL2CUyVRd+PcXlT5KE8lTo7wMIJnKLVOG0sXj7MYTC8Z2Xpsi
 Of4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs6vE6KMV1KRfd+0WuDQx69NY23U7gB1sYdWBY0Yd2U639bq/cxUlbOUsaMAaqAqkT9IWmrTxqMSxzrm10CuEYVN4gcw==
X-Gm-Message-State: AOJu0Yw6jZtZizo2fUojO4Anb6JLqQTWJY15mCqjFZOZ/sfCKdltIQSL
 5wEG57q4FU3gCeIIo3mE+cQTB0BQ6mr+IpynogxIS9SQlBhFH1+I52Ab4fb+wejlp6HbSAMjj7V
 uuBIRMZ8CLh2l3ZKYgu23GNiwuiIVgsKPdYqxDQ==
X-Google-Smtp-Source: AGHT+IH6jWL2ycu4rc3yJGDwQ3NpFlYj3O7BsnCp8rVQWxygwVEJjpIP+kA4NXwnfKlQvOHZ/K4DbqT7Gz9yS1vunJI=
X-Received: by 2002:a17:907:6d18:b0:a55:a17b:1d42 with SMTP id
 sa24-20020a1709076d1800b00a55a17b1d42mr552637ejc.0.1713614219294; Sat, 20 Apr
 2024 04:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240418125456.50944-1-ilias.apalodimas@linaro.org>
 <20240418125456.50944-5-ilias.apalodimas@linaro.org>
 <3240a9af-9973-42bf-b09c-dd227dfcec54@gmx.de>
In-Reply-To: <3240a9af-9973-42bf-b09c-dd227dfcec54@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 20 Apr 2024 14:56:22 +0300
Message-ID: <CAC_iWjJEf-Zs1ahZPn-8f8-km=XtBeH8+spQwfg5-CGOd8rvwg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] efi_selftest: add tests for setvariableRT
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com, 
 pjones@redhat.com, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sam Edwards <CFSworks@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, 
 u-boot@lists.denx.de, kettenis@openbsd.org, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>
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

Hi Heinrich,

I was about to fix and send a v4, but I see you fixed them up on the PR.
Thanks!

On Sat, 20 Apr 2024 at 10:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 4/18/24 14:54, Ilias Apalodimas wrote:
> > Since we support SetVariableRT now add the relevant tests
> >
> > - Search for the RTStorageVolatile and VarToFile variables after EBS
> > - Try to update with invalid variales (BS, RT only)
> > - Try to write a variable bigger than our backend storage
> > - Write a variable that fits and check VarToFile has been updated
> >    correclty
> > - Append to the variable and check VarToFile changes
> > - Try to delete VarToFile which is write protected
> > - Try to add/delete runtime variables
> > - Verify VarToFile contains a valid file format
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   .../efi_selftest_variables_runtime.c          | 197 +++++++++++++++++-
> >   1 file changed, 196 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > index 986924b881dd..28b4e9e7afa5 100644
> > --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> > +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > @@ -10,6 +10,8 @@
> >    */
> >
> >   #include <efi_selftest.h>
> > +#include <efi_variable.h>
> > +#include <u-boot/crc.h>
> >
> >   #define EFI_ST_MAX_DATA_SIZE 16
> >   #define EFI_ST_MAX_VARNAME_SIZE 40
> > @@ -17,6 +19,8 @@
> >   static struct efi_boot_services *boottime;
> >   static struct efi_runtime_services *runtime;
> >   static const efi_guid_t guid_vendor0 = EFI_GLOBAL_VARIABLE_GUID;
> > +static const efi_guid_t __efi_runtime_data efi_rt_var_guid =
> > +                                             U_BOOT_EFI_RT_VAR_FILE_GUID;
> >
> >   /*
> >    * Setup unit test.
> > @@ -41,15 +45,18 @@ static int setup(const efi_handle_t img_handle,
> >   static int execute(void)
> >   {
> >       efi_status_t ret;
> > -     efi_uintn_t len;
> > +     efi_uintn_t len, avail, append_len = 17;
> >       u32 attr;
> >       u8 v[16] = {0x5d, 0xd1, 0x5e, 0x51, 0x5a, 0x05, 0xc7, 0x0c,
> >                   0x35, 0x4a, 0xae, 0x87, 0xa5, 0xdf, 0x0f, 0x65,};
> > +     u8 v2[CONFIG_EFI_VAR_BUF_SIZE];
> >       u8 data[EFI_ST_MAX_DATA_SIZE];
> > +     u8 data2[CONFIG_EFI_VAR_BUF_SIZE];
> >       u16 varname[EFI_ST_MAX_VARNAME_SIZE];
> >       efi_guid_t guid;
> >       u64 max_storage, rem_storage, max_size;
> >
> > +     memset(v2, 0x1, sizeof(v2));
> >       ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> >                                          &max_storage, &rem_storage,
> >                                          &max_size);
> > @@ -63,11 +70,199 @@ static int execute(void)
> >                                   EFI_VARIABLE_RUNTIME_ACCESS,
> >                                   3, v + 4);
> >       if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> > +             efi_uintn_t prev_len, delta;
> > +             struct efi_var_entry *var;
> > +             struct efi_var_file *hdr;
> > +
> >               /* At runtime only non-volatile variables may be set. */
> >               if (ret != EFI_INVALID_PARAMETER) {
> >                       efi_st_error("SetVariable failed\n");
> >                       return EFI_ST_FAILURE;
> >               }
> > +
> > +             /* runtime atttribute must be set */
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         3, v + 4);
> > +             if (ret != EFI_INVALID_PARAMETER) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             len = sizeof(data);
> > +             ret = runtime->get_variable(u"RTStorageVolatile",
> > +                                         &efi_rt_var_guid,
> > +                                         &attr, &len, data);
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("GetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
>
> We should check data against EFI_VAR_FILE_NAME.
>
> +               if (len != sizeof(EFI_VAR_FILE_NAME) ||
> +                   memcmp(data, EFI_VAR_FILE_NAME,
> +                          sizeof(EFI_VAR_FILE_NAME))) {
> +                       data[len - 1] = 0;
> +                       efi_st_error("RTStorageVolatile = %s\n", data);
> +                       return EFI_ST_FAILURE;
> +               }
> +
>
> (memcmp() because we want to be able to carve out efi_selftest as a
> standalone binary in future).
>
> > +
> > +             len = sizeof(data2);
> > +             ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> > +                                         &attr, &len, data2);
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("GetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +             /*
> > +              * VarToFile size must change once a variable is inserted
> > +              * Store it now, we'll use it later
> > +              */
> > +             prev_len = len;
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         sizeof(v2),
> > +                                         v2);
> > +             /*
> > +              * This will try to update VarToFile as well and must fail,
> > +              * without changing or deleting VarToFile
> > +              */
> > +             if (ret != EFI_OUT_OF_RESOURCES) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +             len = sizeof(data2);
> > +             ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> > +                                         &attr, &len, data2);
> > +             if (ret != EFI_SUCCESS || prev_len != len) {
> > +                     efi_st_error("Get/SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             /* Add an 8byte aligned variable */
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         sizeof(v), v);
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             /* Delete it by setting the attrs to 0 */
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         0, sizeof(v), v);
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             /* Add it back */
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         sizeof(v), v);
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             /* Delete it again by setting the size to 0 */
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         0, NULL);
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             /* Delete it again and make sure it's not there */
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         0, NULL);
> > +             if (ret != EFI_NOT_FOUND) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             /*
> > +              * Add a non-aligned variable
> > +              * VarToFile updates must include efi_st_var0
> > +              */
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         9, v + 4);
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +             var = efi_var_mem_find(&guid_vendor0, u"efi_st_var0", NULL);
> > +             if (!var) {
> > +                     efi_st_error("GetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +             delta = efi_var_entry_len(var);
> > +             len = sizeof(data2);
> > +             ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> > +                                         &attr, &len, data2);
> > +             if (ret != EFI_SUCCESS || prev_len + delta != len) {
>
> Please, provide separate messages for length and GetVariable.
>
>                  ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
>                                              &attr, &len, data2);
>                  if (ret != EFI_SUCCESS) {
>                          efi_st_error("GetVariable failed\n");
>                          return EFI_ST_FAILURE;
>                  }
>                  if (prev_len + delta != len) {
>                          efi_st_error("Unexpected VarToFile size"),
>                          return EFI_ST_FAILURE;
>                  }
>
> Best regards
>
> Heinrich
>
> > +                     efi_st_error("Get/SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             /*
> > +              * Append on an existing variable must update VarToFile
> > +              * Our variable entries are 8-byte aligned.
> > +              * Adding a single byte will fit on the existing space
> > +              */
> > +             prev_len = len;
> > +             avail = efi_var_entry_len(var) -
> > +                     (sizeof(u16) * (u16_strlen(var->name) + 1) + sizeof(*var)) -
> > +                     var->length;
> > +             if (avail >= append_len)
> > +                     delta = 0;
> > +             else
> > +                     delta = ALIGN(append_len - avail, 8);
> > +             ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                         EFI_VARIABLE_APPEND_WRITE |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         append_len, v2);
> > +             if (ret != EFI_SUCCESS) {
> > +                     efi_st_error("SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +             len = sizeof(data2);
> > +             ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> > +                                         &attr, &len, data2);
> > +             if (ret != EFI_SUCCESS || prev_len + delta != len) {
> > +                     efi_st_error("Get/SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             /* Make sure that variable contains a valid file */
> > +             hdr = (struct efi_var_file *)data2;
> > +             if (hdr->magic != EFI_VAR_FILE_MAGIC ||
> > +                 len != hdr->length ||
> > +                 hdr->crc32 != crc32(0, (u8 *)((uintptr_t)data2 + sizeof(struct efi_var_file)),
> > +                                     len - sizeof(struct efi_var_file))) {
> > +                     efi_st_error("VarToFile invalid header\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> > +
> > +             /* Variables that are BS, RT and volatile are RO after EBS */
> > +             ret = runtime->set_variable(u"VarToFile", &efi_rt_var_guid,
> > +                                         EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                         EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                         EFI_VARIABLE_NON_VOLATILE,
> > +                                         sizeof(v), v);
> > +             if (ret != EFI_WRITE_PROTECTED) {
> > +                     efi_st_error("Get/SetVariable failed\n");
> > +                     return EFI_ST_FAILURE;
> > +             }
> >       } else {
> >               if (ret != EFI_UNSUPPORTED) {
> >                       efi_st_error("SetVariable failed\n");
>
