Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF960C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 07:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874998811C;
	Sat, 20 Apr 2024 09:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KXrrCKkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EA0688124; Sat, 20 Apr 2024 09:17:51 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4B6B88113
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 09:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713597452; x=1714202252; i=xypron.glpk@gmx.de;
 bh=GVGeyRrURbAhEjQ2+pfdfqt2a3HOU9UQZw0/3bzutyo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KXrrCKkA/iHJo4Eh15JWeIILgAwAL8QMUUKMJV/xPt95oHPl7/P756+iwMAFF0+B
 uM/4HGrsIxFlqwJrJqSuxZ6k82Z2+m7aT/Hprs21iktTtfYYb6tT6YqoP7TKu2WnK
 P5jJH7Y/WsOYfEkTRo5VjX9rq+sqn8W5WhOBq9xo8++eAqr8/54p6LJGJ31hVTCr7
 t5ofbfqdbLUy7WcVxUdKI0QAzSNqu+no7U/jtVomrqiQf/M7bfKl1CmENs5HIRltu
 RjkOd4R+2olArOkehptB/ukOqkOr5aYn9axQTsZXEHXRak48OUgKXUcxjMyTSLaF8
 IlHDiDEijfJJ/CtX5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1rzzqn04GP-002YLp; Sat, 20
 Apr 2024 09:17:32 +0200
Message-ID: <3240a9af-9973-42bf-b09c-dd227dfcec54@gmx.de>
Date: Sat, 20 Apr 2024 09:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] efi_selftest: add tests for setvariableRT
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de,
 kettenis@openbsd.org, AKASHI Takahiro <akashi.tkhro@gmail.com>
References: <20240418125456.50944-1-ilias.apalodimas@linaro.org>
 <20240418125456.50944-5-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240418125456.50944-5-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/6JtU9GVxwxIheRtQMURx3Q2bb/sXLMQlgTmz2OPMYs3/caD25B
 LqvnqpH853Czg1T1adY/oKxBHBqkUbG3DkGflPlhRsWPikVmpZ9xv6PM4OULyFX7W6lrUz1
 WVC5I0jPB5hCTNN0jY3rAvrVVBuPTwZz08DDPVRAP6Kw9YNqWLAECd3Z1MgqOS1kRqW9uFR
 JERkvI/fBPLpbrL29de4A==
UI-OutboundReport: notjunk:1;M01:P0:j96xrkBuMRs=;BN7q66Uaqp29leXCr1B5eZEWlKG
 ScWisA3gjYSOYZURShduv11480PMkN3SD0qx5L1D4tPydZ+FoIAT6dFjosn1wSGDVeXApPjyF
 UX+ZT1v8Nui4ujXZbPRhAeq8nDaYnRO48pyMo7cL2jCyi7oXT/vGJuE5mkF9xzH6Sv03+9tOv
 hfsxVHloXruzXb7YKVvLsEVzN98HNN12fH7dodI9uICY9/K7X9St2nb2q63D66IRsTEhNYQRG
 K7iBRLS4pHCFLc3p87B/t/P8b6ewLa6g73LGOR/HNFd2jL+yZ0SaHjojy6eigpboYilDhMXX5
 bC2KAM3vHhSr4TK6d2XjZr0Eyiza8BBL+xOxqU2edkO1WkEwmptJozP1uiprSFhT6d+dcM3Dn
 1Ya41dICrsKG9/8g6AXiFUcS5Pj8278os2TZXKrgwPxeHkHbFOXxXzbjKL0WsTH5e3LfIPNWJ
 vEr2eHfu72rjJlGlehiqF0BmMTiA7khsF4gWPz6HdXc1cv/xHotvxRmdWJdi8L/9R7Lav3MCE
 8uUiKP3Norxpywl21cZm8rbik+P9PDHixtyJQju5oTrtG518qk9E48omYGRqY1wfnIRqNijyc
 MFcytC0XIg4D3WxkKsOfgJh+9PZ+AD8S10HGUSr7dw67Q2ZooZLFD0Rk53NiMmZ5nARwwlC1b
 dhZ9C/IBZqoL4tnEYxVxesJ/17YTh65VsL81c0aMrMpZ66rvEUXuO9bh3H73v/SeJhmFSv72Y
 aX1foO5nS+HkEywMdkP58huB2i/C2gmbHZ5OQ6AJo5EJe4Xl6DMWjzFFjAs+IKnHUfVW0efJ4
 5qnj91sE1E3Yg4ULkNrzzSUsuj3PDWdAmPig0syLDN6wg=
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

On 4/18/24 14:54, Ilias Apalodimas wrote:
> Since we support SetVariableRT now add the relevant tests
>
> - Search for the RTStorageVolatile and VarToFile variables after EBS
> - Try to update with invalid variales (BS, RT only)
> - Try to write a variable bigger than our backend storage
> - Write a variable that fits and check VarToFile has been updated
>    correclty
> - Append to the variable and check VarToFile changes
> - Try to delete VarToFile which is write protected
> - Try to add/delete runtime variables
> - Verify VarToFile contains a valid file format
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   .../efi_selftest_variables_runtime.c          | 197 +++++++++++++++++-
>   1 file changed, 196 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi=
_selftest/efi_selftest_variables_runtime.c
> index 986924b881dd..28b4e9e7afa5 100644
> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> @@ -10,6 +10,8 @@
>    */
>
>   #include <efi_selftest.h>
> +#include <efi_variable.h>
> +#include <u-boot/crc.h>
>
>   #define EFI_ST_MAX_DATA_SIZE 16
>   #define EFI_ST_MAX_VARNAME_SIZE 40
> @@ -17,6 +19,8 @@
>   static struct efi_boot_services *boottime;
>   static struct efi_runtime_services *runtime;
>   static const efi_guid_t guid_vendor0 =3D EFI_GLOBAL_VARIABLE_GUID;
> +static const efi_guid_t __efi_runtime_data efi_rt_var_guid =3D
> +						U_BOOT_EFI_RT_VAR_FILE_GUID;
>
>   /*
>    * Setup unit test.
> @@ -41,15 +45,18 @@ static int setup(const efi_handle_t img_handle,
>   static int execute(void)
>   {
>   	efi_status_t ret;
> -	efi_uintn_t len;
> +	efi_uintn_t len, avail, append_len =3D 17;
>   	u32 attr;
>   	u8 v[16] =3D {0x5d, 0xd1, 0x5e, 0x51, 0x5a, 0x05, 0xc7, 0x0c,
>   		    0x35, 0x4a, 0xae, 0x87, 0xa5, 0xdf, 0x0f, 0x65,};
> +	u8 v2[CONFIG_EFI_VAR_BUF_SIZE];
>   	u8 data[EFI_ST_MAX_DATA_SIZE];
> +	u8 data2[CONFIG_EFI_VAR_BUF_SIZE];
>   	u16 varname[EFI_ST_MAX_VARNAME_SIZE];
>   	efi_guid_t guid;
>   	u64 max_storage, rem_storage, max_size;
>
> +	memset(v2, 0x1, sizeof(v2));
>   	ret =3D runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
>   					   &max_storage, &rem_storage,
>   					   &max_size);
> @@ -63,11 +70,199 @@ static int execute(void)
>   				    EFI_VARIABLE_RUNTIME_ACCESS,
>   				    3, v + 4);
>   	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> +		efi_uintn_t prev_len, delta;
> +		struct efi_var_entry *var;
> +		struct efi_var_file *hdr;
> +
>   		/* At runtime only non-volatile variables may be set. */
>   		if (ret !=3D EFI_INVALID_PARAMETER) {
>   			efi_st_error("SetVariable failed\n");
>   			return EFI_ST_FAILURE;
>   		}
> +
> +		/* runtime atttribute must be set */
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    3, v + 4);
> +		if (ret !=3D EFI_INVALID_PARAMETER) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		len =3D sizeof(data);
> +		ret =3D runtime->get_variable(u"RTStorageVolatile",
> +					    &efi_rt_var_guid,
> +					    &attr, &len, data);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("GetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}

We should check data against EFI_VAR_FILE_NAME.

+               if (len !=3D sizeof(EFI_VAR_FILE_NAME) ||
+                   memcmp(data, EFI_VAR_FILE_NAME,
+                          sizeof(EFI_VAR_FILE_NAME))) {
+                       data[len - 1] =3D 0;
+                       efi_st_error("RTStorageVolatile =3D %s\n", data);
+                       return EFI_ST_FAILURE;
+               }
+

(memcmp() because we want to be able to carve out efi_selftest as a
standalone binary in future).

> +
> +		len =3D sizeof(data2);
> +		ret =3D runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +					    &attr, &len, data2);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("GetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +		/*
> +		 * VarToFile size must change once a variable is inserted
> +		 * Store it now, we'll use it later
> +		 */
> +		prev_len =3D len;
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    sizeof(v2),
> +					    v2);
> +		/*
> +		 * This will try to update VarToFile as well and must fail,
> +		 * without changing or deleting VarToFile
> +		 */
> +		if (ret !=3D EFI_OUT_OF_RESOURCES) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +		len =3D sizeof(data2);
> +		ret =3D runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +					    &attr, &len, data2);
> +		if (ret !=3D EFI_SUCCESS || prev_len !=3D len) {
> +			efi_st_error("Get/SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		/* Add an 8byte aligned variable */
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    sizeof(v), v);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		/* Delete it by setting the attrs to 0 */
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    0, sizeof(v), v);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		/* Add it back */
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    sizeof(v), v);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		/* Delete it again by setting the size to 0 */
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    0, NULL);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		/* Delete it again and make sure it's not there */
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    0, NULL);
> +		if (ret !=3D EFI_NOT_FOUND) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		/*
> +		 * Add a non-aligned variable
> +		 * VarToFile updates must include efi_st_var0
> +		 */
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    9, v + 4);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +		var =3D efi_var_mem_find(&guid_vendor0, u"efi_st_var0", NULL);
> +		if (!var) {
> +			efi_st_error("GetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +		delta =3D efi_var_entry_len(var);
> +		len =3D sizeof(data2);
> +		ret =3D runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +					    &attr, &len, data2);
> +		if (ret !=3D EFI_SUCCESS || prev_len + delta !=3D len) {

Please, provide separate messages for length and GetVariable.

                 ret =3D runtime->get_variable(u"VarToFile", &efi_rt_var_g=
uid,
                                             &attr, &len, data2);
                 if (ret !=3D EFI_SUCCESS) {
                         efi_st_error("GetVariable failed\n");
                         return EFI_ST_FAILURE;
                 }
                 if (prev_len + delta !=3D len) {
                         efi_st_error("Unexpected VarToFile size"),
                         return EFI_ST_FAILURE;
                 }

Best regards

Heinrich

> +			efi_st_error("Get/SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		/*
> +		 * Append on an existing variable must update VarToFile
> +		 * Our variable entries are 8-byte aligned.
> +		 * Adding a single byte will fit on the existing space
> +		 */
> +		prev_len =3D len;
> +		avail =3D efi_var_entry_len(var) -
> +			(sizeof(u16) * (u16_strlen(var->name) + 1) + sizeof(*var)) -
> +			var->length;
> +		if (avail >=3D append_len)
> +			delta =3D 0;
> +		else
> +			delta =3D ALIGN(append_len - avail, 8);
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_APPEND_WRITE |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    append_len, v2);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +		len =3D sizeof(data2);
> +		ret =3D runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +					    &attr, &len, data2);
> +		if (ret !=3D EFI_SUCCESS || prev_len + delta !=3D len) {
> +			efi_st_error("Get/SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		/* Make sure that variable contains a valid file */
> +		hdr =3D (struct efi_var_file *)data2;
> +		if (hdr->magic !=3D EFI_VAR_FILE_MAGIC ||
> +		    len !=3D hdr->length ||
> +		    hdr->crc32 !=3D crc32(0, (u8 *)((uintptr_t)data2 + sizeof(struct =
efi_var_file)),
> +					len - sizeof(struct efi_var_file))) {
> +			efi_st_error("VarToFile invalid header\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		/* Variables that are BS, RT and volatile are RO after EBS */
> +		ret =3D runtime->set_variable(u"VarToFile", &efi_rt_var_guid,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    sizeof(v), v);
> +		if (ret !=3D EFI_WRITE_PROTECTED) {
> +			efi_st_error("Get/SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
>   	} else {
>   		if (ret !=3D EFI_UNSUPPORTED) {
>   			efi_st_error("SetVariable failed\n");

