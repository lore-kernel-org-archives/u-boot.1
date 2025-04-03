Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A1DC3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 16:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643AE82054;
	Thu,  3 Apr 2025 18:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="llc+ipii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E88F82075; Thu,  3 Apr 2025 18:13:54 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED6582149
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 18:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39727fe912cso569143f8f.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743696830; x=1744301630; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=8F/8209hiBo1CKf9dYcmUuTEWUxQZAw5pnLlSSL0zbM=;
 b=llc+ipiiIkEGr6N7itZq1VXlnMQeQJtf/Z7ebXew8Qf3ZJZOEP1D0pISdVWEnCAG64
 dg51Py3sAnGyroTAwnad71hClTB06jfOwKCjPZjUV3cBeN152V7dJlTBI3mog5KMpR44
 DyLNPERd1lD5P912mRUejeRSaloA8W8TmozjePaoIIQ9NpcmIz9fPAFLSsDSaIydMef9
 QXPDxZyUBI8tLIDhxxruECdznoP4NEjzQ7TD5RKjzQLSh0PrcWhzSgXdLNkX5w9KzAbl
 zIbp8HqAO+t8wqFrnRxdyyHAYfSgwbKy7kOASz6YjL3OXr3A4j5l3tFexPMZGkD4VJVq
 XHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743696830; x=1744301630;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8F/8209hiBo1CKf9dYcmUuTEWUxQZAw5pnLlSSL0zbM=;
 b=Tc0mOvTkZO1hTp+ogX89gcEO3bO9HtvDDgxIolIMu2MS2en+rxW0r4XbSafAQJTCoA
 Hu+zLbY528vV+yVndOQ/pEPE0Xy1ZrSGZ8FOmK/O/lbav/003kHFVUSsu1CcN6e2oVSR
 KDN8pAVWVmz7WzkFxCsRH0QxJaYWm2nkNEeyoaWOLe2kRK9oxrN/mHYnThqY8ulZx3VE
 pFkQWqy9Cdh0Mr34IcHO6hDGQtVLjGw0ymo1NIy9F7Re13mY1HIHhUmOpUHTDzownqIX
 ODKgnE7RS9kiadsA/WVZ0VsiCuXnIIHmEj66Qe3ND6fXdUvRKBYSlj6C8j9vC4Y+QBzt
 jBOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY97vOVzhzHQOW73Sh6okwQlrg4pGAcIU/91hOLFHo6xyGwrjt0BQXDZn3Y1llFPqla/6Ar2M=@lists.denx.de
X-Gm-Message-State: AOJu0Yxq0Lza1Qox9rX1rURLGrXF3AUJyRdvJCfGCFoei7MZjSl0enwH
 zBJzMiGR/n9zo36K5PTUlnVBTZMugzauU1Y3MXlaIEIHviqdLrbvgOr1CICQtws=
X-Gm-Gg: ASbGncvnBfHUhyLREJP/2g9KhpGryqEu3WEyXmzaqTvBQhtuK6z2ODzWDTG1eGkGWSo
 xEcjxH4QZze/1GT6hJS/pbu+7KF9PSpG30pS1jkGohXhRMaUGNcMSGjWwXlgGPNORTMNpXWOVUj
 ZkAnlbGsj/i/X5e7eRyIRbrsdvI7qX9K8i1gOfACfuUDU+m+iXVWhiHle4f/79OAbyORD7DvFK6
 Euyzq8e81WMEJ9rrmgdwUxv8O6lq76nT1EHd9mFD8YiwC1q01RokjyvpxxHLQreFwKHlzd2PYvi
 7eNS1F7OymMKX1U2Q8a6rh51LUEkchohPaWrWilUrx3PFtCjqwP8ymZxVsPpMQpHCabRDqLvgB4
 IJyf6b3hTyicsDY70uK+olQ==
X-Google-Smtp-Source: AGHT+IGsWAJGT/mqhJ152RIjioJfC9T+a8Aj9AKQsGTQn50Lrewxh1KEElGSSml99bszg5Li/6kSEQ==
X-Received: by 2002:a05:6000:240b:b0:39a:ca0c:fc90 with SMTP id
 ffacd0b85a97d-39c29752b00mr6144898f8f.14.1743696830073; 
 Thu, 03 Apr 2025 09:13:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:e780:6520:c31a:d05c?
 ([2a01:e0a:3d9:2080:e780:6520:c31a:d05c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec36699e0sm22421965e9.35.2025.04.03.09.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 09:13:49 -0700 (PDT)
Message-ID: <4f50c862-250c-4bc8-afc3-866cbafd4b62@linaro.org>
Date: Thu, 3 Apr 2025 18:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_loader: Move public cert for capsules to .rodata
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
References: <20250401112729.2181793-1-ilias.apalodimas@linaro.org>
 <6d683b43-0f0b-4203-b3c7-0c311d16686c@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <6d683b43-0f0b-4203-b3c7-0c311d16686c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 03/04/2025 16:53, neil.armstrong@linaro.org wrote:
> On 01/04/2025 13:27, Ilias Apalodimas wrote:
>> commit ddf67daac39d ("efi_capsule: Move signature from DTB to .rodata")
>> was reverted in
>> commit 47a25e81d35c ("Revert "efi_capsule: Move signature from DTB to .rodata"")
>> because that's what U-Boot was usually doing -- using the DT to store
>> configuration and data. Some of the discussions can be found here [0].
>>
>> (Ab)using the device tree to store random data isn't ideal though.
>> On top of that with new features introduced over the years, keeping
>> the certificates in the DT has proven to be problematic.
>> One of the reasons is that platforms might send U-Boot a DTB
>> from the previous stage loader using a transfer list which won't contain
>> the signatures since other loaders are not  aware of internal
>> U-Boot ABIs. On top of that QEMU creates the DTB on the fly, so adding
>> the capsule certificate there does not work and requires users to dump
>> it and re-create it injecting the public keys.
>>
>> Now that we have proper memory permissions for arm64, move the certificate
>> to .rodata and read it from there.
>>
>> [0] https://lore.kernel.org/u-boot/CAPnjgZ2uM=n8Qo-a=DUkx5VW5Bzp5Xy8=Wgmrw8ESqUBK00YJQ@mail.gmail.com/
>>
>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>   Makefile                           |  2 +-
>>   include/asm-generic/sections.h     |  2 ++
>>   lib/efi_loader/Makefile            | 18 +++++++++++++++
>>   lib/efi_loader/capsule_esl.dtsi.in | 11 ---------
>>   lib/efi_loader/efi_capsule.c       | 37 ++++++++----------------------
>>   lib/efi_loader/efi_capsule_key.S   | 17 ++++++++++++++
>>   scripts/Makefile.lib               | 27 ----------------------
>>   7 files changed, 47 insertions(+), 67 deletions(-)
>>   delete mode 100644 lib/efi_loader/capsule_esl.dtsi.in
>>   create mode 100644 lib/efi_loader/efi_capsule_key.S
>>
>> diff --git a/Makefile b/Makefile
>> index 620996862e6d..7a77948006a1 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2229,7 +2229,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
>>              itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
>>              mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
>>              idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
>> -           Test* capsule*.*.efi-capsule capsule*.map
>> +           Test* capsule*.*.efi-capsule capsule*.map capsule_esl_file
>>   # Directories & files removed with 'make mrproper'
>>   MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
>> index 024b1adde270..d59787948fd1 100644
>> --- a/include/asm-generic/sections.h
>> +++ b/include/asm-generic/sections.h
>> @@ -28,6 +28,8 @@ extern char __efi_helloworld_begin[];
>>   extern char __efi_helloworld_end[];
>>   extern char __efi_var_file_begin[];
>>   extern char __efi_var_file_end[];
>> +extern char __efi_capsule_sig_begin[];
>> +extern char __efi_capsule_sig_end[];
>>   /* Private data used by of-platdata devices/uclasses */
>>   extern char __priv_data_start[], __priv_data_end[];
>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>> index 2a0b4172bd7f..dc2912148951 100644
>> --- a/lib/efi_loader/Makefile
>> +++ b/lib/efi_loader/Makefile
>> @@ -29,6 +29,7 @@ obj-y += efi_boottime.o
>>   obj-y += efi_helper.o
>>   obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o
>>   obj-$(CONFIG_EFI_CAPSULE_FIRMWARE) += efi_firmware.o
>> +obj-$(CONFIG_EFI_CAPSULE_AUTHENTICATE) += efi_capsule_key.o
>>   obj-y += efi_console.o
>>   obj-y += efi_device_path.o
>>   obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
>> @@ -73,6 +74,23 @@ obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
>>   EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>>   $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
>> +ifeq ($(CONFIG_EFI_CAPSULE_AUTHENTICATE),y)
>> +capsule_crt_path=($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)))
>> +capsule_crt_full=$(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE))
>> +quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
>> +cmd_capsule_esl_gen = cert-to-efi-sig-list $(capsule_crt_full) $@
>> +$(srctree)/capsule_esl_file: FORCE
>> +    @if [ ! -e "$(capsule_crt_full)" ]; then \
>> +        echo "ERROR: path $(capsule_crt_full) is invalid." >&2; \
>> +        echo "EFI CONFIG_EFI_CAPSULE_CRT_FILE must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled." >&2; \
>> +        exit 1; \
>> +    fi
>> +    $(call cmd,capsule_esl_gen)
>> +
>> +$(obj)/efi_capsule.o: $(srctree)/capsule_esl_file FORCE
>> +asflags-y += -DCAPSULE_ESL_PATH=\"$(srctree)/capsule_esl_file\"
>> +endif
>> +
>>   # Set the C flags to add and remove for each app
>>   $(foreach f,$(apps-y),\
>>       $(eval CFLAGS_$(f).o := $(CFLAGS_EFI) -Os -ffreestanding)\
>> diff --git a/lib/efi_loader/capsule_esl.dtsi.in b/lib/efi_loader/capsule_esl.dtsi.in
>> deleted file mode 100644
>> index bc7db836faa8..000000000000
>> --- a/lib/efi_loader/capsule_esl.dtsi.in
>> +++ /dev/null
>> @@ -1,11 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> -/*
>> - * Devicetree file with the public key EFI Signature List(ESL)
>> - * node. This file is used to generate the dtsi file to be
>> - * included into the DTB.
>> - */
>> -/ {
>> -    signature {
>> -        capsule-key = /incbin/("ESL_BIN_FILE");
>> -    };
>> -};
>> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
>> index f8a4a7c6ef46..1aa52ac7bb69 100644
>> --- a/lib/efi_loader/efi_capsule.c
>> +++ b/lib/efi_loader/efi_capsule.c
>> @@ -22,6 +22,7 @@
>>   #include <asm/global_data.h>
>>   #include <u-boot/uuid.h>
>> +#include <asm/sections.h>
>>   #include <crypto/pkcs7.h>
>>   #include <crypto/pkcs7_parser.h>
>>   #include <linux/err.h>
>> @@ -284,33 +285,12 @@ out:
>>   }
>>   #if defined(CONFIG_EFI_CAPSULE_AUTHENTICATE)
>> -int efi_get_public_key_data(void **pkey, efi_uintn_t *pkey_len)
>> +static int efi_get_public_key_data(const void **pkey, efi_uintn_t *pkey_len)
>>   {
>> -    const void *fdt_blob = gd->fdt_blob;
>> -    const void *blob;
>> -    const char *cnode_name = "capsule-key";
>> -    const char *snode_name = "signature";
>> -    int sig_node;
>> -    int len;
>> -
>> -    sig_node = fdt_subnode_offset(fdt_blob, 0, snode_name);
>> -    if (sig_node < 0) {
>> -        log_err("Unable to get signature node offset\n");
>> -
>> -        return -FDT_ERR_NOTFOUND;
>> -    }
>> -
>> -    blob = fdt_getprop(fdt_blob, sig_node, cnode_name, &len);
>> -
>> -    if (!blob || len < 0) {
>> -        log_err("Unable to get capsule-key value\n");
>> -        *pkey = NULL;
>> -        *pkey_len = 0;
>> -
>> -        return -FDT_ERR_NOTFOUND;
>> -    }
>> +    const void *blob = __efi_capsule_sig_begin;
>> +    const int len = __efi_capsule_sig_end - __efi_capsule_sig_begin;
>> -    *pkey = (void *)blob;
>> +    *pkey = blob;
>>       *pkey_len = len;
>>       return 0;
>> @@ -321,7 +301,8 @@ efi_status_t efi_capsule_authenticate(const void *capsule, efi_uintn_t capsule_s
>>   {
>>       u8 *buf;
>>       int ret;
>> -    void *fdt_pkey, *pkey;
>> +    void *pkey;
>> +    const void *stored_pkey;
>>       efi_uintn_t pkey_len;
>>       uint64_t monotonic_count;
>>       struct efi_signature_store *truststore;
>> @@ -373,7 +354,7 @@ efi_status_t efi_capsule_authenticate(const void *capsule, efi_uintn_t capsule_s
>>           goto out;
>>       }
>> -    ret = efi_get_public_key_data(&fdt_pkey, &pkey_len);
>> +    ret = efi_get_public_key_data(&stored_pkey, &pkey_len);
>>       if (ret < 0)
>>           goto out;
>> @@ -381,7 +362,7 @@ efi_status_t efi_capsule_authenticate(const void *capsule, efi_uintn_t capsule_s
>>       if (!pkey)
>>           goto out;
>> -    memcpy(pkey, fdt_pkey, pkey_len);
>> +    memcpy(pkey, stored_pkey, pkey_len);
>>       truststore = efi_build_signature_store(pkey, pkey_len);
>>       if (!truststore)
>>           goto out;
>> diff --git a/lib/efi_loader/efi_capsule_key.S b/lib/efi_loader/efi_capsule_key.S
>> new file mode 100644
>> index 000000000000..80cefbe16ae0
>> --- /dev/null
>> +++ b/lib/efi_loader/efi_capsule_key.S
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * .esl cert for capsule authentication
>> + *
>> + * Copyright (c) 2021, Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> + */
>> +
>> +#include <config.h>
>> +
>> +.section .rodata.capsule_key.init,"a"
>> +.balign 16
>> +.global __efi_capsule_sig_begin
>> +__efi_capsule_sig_begin:
>> +.incbin CAPSULE_ESL_PATH
>> +__efi_capsule_sig_end:
>> +.global __efi_capsule_sig_end
>> +.balign 16
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index 275c308154b1..83fd5ff6c31c 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -377,35 +377,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>>           ; \
>>       sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
>> -capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
>> -capsule_crt_file=$(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE))
>> -capsule_esl_dtsi=.capsule_esl.dtsi
>> -
>> -quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
>> -cmd_capsule_esl_gen = cert-to-efi-sig-list $< $@
>> -
>> -$(obj)/capsule_esl_file: $(capsule_crt_file) FORCE
>> -ifeq ($(CONFIG_EFI_CAPSULE_CRT_FILE),"")
>> -    $(error "CONFIG_EFI_CAPSULE_CRT_FILE is empty, EFI capsule authentication \
>> -    public key must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled")
>> -else
>> -    $(call cmd,capsule_esl_gen)
>> -endif
>> -
>> -quiet_cmd_capsule_dtsi_gen = CAPSULE_DTSI_GEN $@
>> -cmd_capsule_dtsi_gen = \
>> -    $(shell sed "s:ESL_BIN_FILE:$(abspath $<):" $(capsule_esl_input_file) > $@)
>> -
>> -$(obj)/$(capsule_esl_dtsi): $(obj)/capsule_esl_file FORCE
>> -    $(call cmd,capsule_dtsi_gen)
>> -
>>   dtsi_include_list_deps := $(addprefix $(u_boot_dtsi_loc),$(subst $(quote),,$(dtsi_include_list)))
>> -ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
>> -dtsi_include_list += $(capsule_esl_dtsi)
>> -dtsi_include_list_deps += $(obj)/$(capsule_esl_dtsi)
>> -endif
>> -
>>   ifneq ($(CHECK_DTBS),)
>>   DT_CHECKER ?= dt-validate
>>   DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-A311D-CC
> 
> Thanks,
> Neil


And with:
https://lore.kernel.org/all/20250403-u-boot-fix-set-dfu-alt-info-interface-v1-1-1fdd12463186@linaro.org/

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S805X-CC
