Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD208D3E2A3
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B598911E;
	Mon, 28 Oct 2024 20:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Vm8J0IqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F358911B; Mon, 28 Oct 2024 20:04:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F5E18908F
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730142251; x=1730747051; i=xypron.glpk@gmx.de;
 bh=74VBAQLg+iKMmbIRRfh0x9d7PKwICqbhj7CgJmmAQjY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Vm8J0IqF970p7iM2GFiIMzUui43Bgezwr4jfG1JWpPBYTL63Un5lM02vPWjwGg/+
 rZbjsTJx81exZy0FRfmZmXAvI5FefH/Nn0PcGqpRAr72q0Zvv2e8WCvgs2UKvZaDN
 ZGXXRxb9tmF1RBUVXProWZ3XW4YFIqHxzaq0whVsUBl5cKJoePFAhjMaxrBHfclWa
 Rp6r96mi3xReVwIyy46lw9qihJmN3kAvxrkg8LDRGASp3Sx+LRayRPWt6WxTRRoNe
 lDaIBqrijr+zuYNgOUaNnWgWjM0aQAMbJXUGw1k1pN0Bu3qr8GLcwP67+UR9hdWc5
 1NLtemQVrvjjFs5rpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1tOfo03iSQ-00SCyy; Mon, 28
 Oct 2024 20:04:11 +0100
Message-ID: <ea85b8fc-fe7b-4a76-a3e1-bb92b45b027a@gmx.de>
Date: Mon, 28 Oct 2024 20:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] sandbox: Report host default-filename in native
 mode
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-6-sjg@chromium.org>
 <CAC_iWjKUjsMdqXa2YZGiu1FSsjx_aH6cDQsi+2Ng5i-+9obQhQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKUjsMdqXa2YZGiu1FSsjx_aH6cDQsi+2Ng5i-+9obQhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1hXttaol3uyIcJ/9ox1oBR/Dol12ahLYJa2uADfrp+RKEV6z1oq
 OydUigCNKN3ZDrmkQkrGc4pAq4F+Q6Jg7O8AG/FGd32YFX5OCWP8WBCK6hFL3FiiWi+9VN8
 E14coz2apJbwGAu7y09GJ/x3qd04gPU3gGQsT1Je5vQUXYpPS7nH0ByWnhLajW+Q46svgWe
 PTSqHfGsoPjYyLdvPQX3A==
UI-OutboundReport: notjunk:1;M01:P0:Iet+EBiDkKE=;Ys09jwgPJV7fqZ0U6Mwt6bm4+Hw
 qkkJ3MBZbfRwpmOgcAx4aGHkL4Gfo/EOchON1dtzHhkvy+kgxb9mfINC3Jo4VAmZWtGzu0u9E
 W7t3U+MC3gVK5b1LKFdS/9Cxi1u9nE6TbvDyDDZUabtRVy2JtRT4sewiTgW/Vvj4dJwCZpCHw
 PFIRp2WxhQZrgRJez/vEzpxbxrp+ZRZ062AEqOsAJez7bg5Sde17P4ifCi+EZGPlzZMtNn/z9
 sDzVSxAi4RPycVEDBkWORR1tRbHZdoj/vptsL6//czxyDl52s4LJUorEovRXD4wK7j29FC8JL
 Ci1Nfc9ddb5fFk3S6IlyPCZObJmg2IPWsJWo5/hhVjuYYZOVXnoV0ykOjyBAEVyAzPn9bnxq8
 x/MsUKrhbbPMDjiZrUb8bD7UaftBkPkXgbBSXdmRkUZrz0VaAxpv2UQtDczjLZ0ZBwrag7dlS
 RkihqUAZToXZUXeHdEONfY8iVrB5SRWiN7fS2wRtNpkwOCls8gkeSvbCnpTLMc2IvgtyaDWrU
 svn635cJuenQpH03xVm56lwqG/lIN0Hw6ZupIiPbBH5F0c6xvMuyzpTbb6Au1cqDK8lRNMSCT
 vduuF6NYTTbci90G0XToa7BRuTaB621zAIzNx+OqtD6AUPp73c0gjPfuoVKgNFwXhRpa9w0VK
 uUoxgm0XHwzSizq+XcyHxqkpAfKMiFfA61TZgdOaJnLc1Y5bpQIFr9HtZZGzSZ19qbh4R23b4
 FQ1GnmCRChL9v+65KIy8QcIt95enVFUdqeeFKCgmBvqU0LtVHLUrn/J7lzslFj9yHWk3IuKnN
 fs9ESJBq/snzEB+mA5zwLmug==
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

On 10/25/24 11:56, Ilias Apalodimas wrote:
> Hi Simon,
>
>
> On Tue, 22 Oct 2024 at 15:00, Simon Glass <sjg@chromium.org> wrote:
>>
>> When the --native flag is given, pretend to be running the host
>> architecture rather than sandbox.
>>
>> Add an 'efidebug filename' command to report it.
>
> Heinrich does this allow you to continue your testing in native archs?
>
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> Changes in v8:
>> - Add new patch to report host default-filename in native mode
>>
>>   boot/bootmeth_efi.c | 25 ++------------------
>>   boot/efi_fname.c    | 57 +++++++++++++++++++++++++++++++++-----------=
-
>>   cmd/efidebug.c      | 25 ++++++++++++++++++++
>>   include/efi.h       | 25 ++++++++++++++++++++
>>   4 files changed, 94 insertions(+), 38 deletions(-)
>>
>> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
>> index 371b36d550b..f836aa655f5 100644
>> --- a/boot/bootmeth_efi.c
>> +++ b/boot/bootmeth_efi.c
>> @@ -25,32 +25,11 @@
>>
>>   #define EFI_DIRNAME    "/EFI/BOOT/"
>>
>> -static int get_efi_pxe_arch(void)
>> -{
>> -       /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-par=
ameters.xml */
>> -       if (IS_ENABLED(CONFIG_ARM64))
>> -               return 0xb;
>> -       else if (IS_ENABLED(CONFIG_ARM))
>> -               return 0xa;
>> -       else if (IS_ENABLED(CONFIG_X86_64))
>> -               return 0x6;
>> -       else if (IS_ENABLED(CONFIG_X86))
>> -               return 0x7;
>> -       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
>> -               return 0x19;
>> -       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
>> -               return 0x1b;
>> -       else if (IS_ENABLED(CONFIG_SANDBOX))
>> -               return 0;       /* not used */
>> -
>> -       return -EINVAL;
>> -}
>> -
>>   static int get_efi_pxe_vci(char *str, int max_len)
>>   {
>>          int ret;
>>
>> -       ret =3D get_efi_pxe_arch();
>> +       ret =3D efi_get_pxe_arch();
>>          if (ret < 0)
>>                  return ret;
>>
>> @@ -239,7 +218,7 @@ static int distro_efi_read_bootflow_net(struct boot=
flow *bflow)
>>          ret =3D get_efi_pxe_vci(str, sizeof(str));
>>          if (ret)
>>                  return log_msg_ret("vci", ret);
>> -       ret =3D get_efi_pxe_arch();
>> +       ret =3D efi_get_pxe_arch();
>>          if (ret < 0)
>>                  return log_msg_ret("arc", ret);
>>          arch =3D ret;
>> diff --git a/boot/efi_fname.c b/boot/efi_fname.c
>> index a6b11383bba..790f9e2fa36 100644
>> --- a/boot/efi_fname.c
>> +++ b/boot/efi_fname.c
>> @@ -9,29 +9,34 @@
>>    */
>>
>>   #include <efi.h>
>> +#include <errno.h>
>>   #include <host_arch.h>
>>
>> -#ifdef CONFIG_SANDBOX
>> -
>>   #if HOST_ARCH =3D=3D HOST_ARCH_X86_64
>> -#define BOOTEFI_NAME "BOOTX64.EFI"
>> +#define HOST_BOOTEFI_NAME "BOOTX64.EFI"
>> +#define HOST_PXE_ARCH 0x6
>>   #elif HOST_ARCH =3D=3D HOST_ARCH_X86
>> -#define BOOTEFI_NAME "BOOTIA32.EFI"
>> +#define HOST_BOOTEFI_NAME "BOOTIA32.EFI"
>> +#define HOST_PXE_ARCH 0x7
>>   #elif HOST_ARCH =3D=3D HOST_ARCH_AARCH64
>> -#define BOOTEFI_NAME "BOOTAA64.EFI"
>> +#define HOST_BOOTEFI_NAME "BOOTAA64.EFI"
>> +#define HOST_PXE_ARCH 0xb
>>   #elif HOST_ARCH =3D=3D HOST_ARCH_ARM
>> -#define BOOTEFI_NAME "BOOTARM.EFI"
>> +#define HOST_BOOTEFI_NAME "BOOTARM.EFI"
>> +#define HOST_PXE_ARCH 0xa
>>   #elif HOST_ARCH =3D=3D HOST_ARCH_RISCV32
>> -#define BOOTEFI_NAME "BOOTRISCV32.EFI"
>> +#define HOST_BOOTEFI_NAME "BOOTRISCV32.EFI"
>> +#define HOST_PXE_ARCH 0x19
>>   #elif HOST_ARCH =3D=3D HOST_ARCH_RISCV64
>> -#define BOOTEFI_NAME "BOOTRISCV64.EFI"
>> +#define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
>> +#define HOST_PXE_ARCH 0x1b
>>   #else
>> -#error Unsupported UEFI architecture
>> +#error Unsupported Host architecture
>>   #endif
>>
>> -#else
>> -
>> -#if defined(CONFIG_ARM64)
>> +#if defined(CONFIG_SANDBOX)
>> +#define BOOTEFI_NAME "BOOTSBOX.EFI"
>> +#elif defined(CONFIG_ARM64)
>>   #define BOOTEFI_NAME "BOOTAA64.EFI"
>>   #elif defined(CONFIG_ARM)
>>   #define BOOTEFI_NAME "BOOTARM.EFI"
>> @@ -47,9 +52,31 @@
>>   #error Unsupported UEFI architecture
 >>   #endif>>
>> -#endif
>> -
>>   const char *efi_get_basename(void)
>>   {
>> -       return BOOTEFI_NAME;
>> +       return efi_use_host_arch() ? HOST_BOOTEFI_NAME : BOOTEFI_NAME;
>> +}
>> +
>> +int efi_get_pxe_arch(void)
>> +{
>> +       if (efi_use_host_arch())
>> +               return HOST_PXE_ARCH;
>> +
>> +       /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-par=
ameters.xml */
>> +       if (IS_ENABLED(CONFIG_ARM64))
>> +               return 0xb;
>> +       else if (IS_ENABLED(CONFIG_ARM))
>> +               return 0xa;
>> +       else if (IS_ENABLED(CONFIG_X86_64))
>> +               return 0x6;
>> +       else if (IS_ENABLED(CONFIG_X86))
>> +               return 0x7;
>> +       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
>> +               return 0x19;
>> +       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
>> +               return 0x1b;
>> +       else if (IS_ENABLED(CONFIG_SANDBOX))

Please, add a warning here:

      log_warn("You are using the sandbox in non-compliant mode\n");

The riscv64 sandbox can only run riscv64 binaries
The arm64 sandbox can only run arm64 binary.

We cannot expect a DHCP server to do the expected with the value 0.

So why should we introduce this?

>> +               return 0;       /* not used */

The following comment would fit better:

     /* This breaks PXE booting on the sandbox.*/

Best regards

Heinrich

>> +
>> +       return -EINVAL;
>>   }
>> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
>> index e040fe75fa1..02f1e080e88 100644
>> --- a/cmd/efidebug.c
>> +++ b/cmd/efidebug.c
>> @@ -511,6 +511,27 @@ static int do_efi_show_images(struct cmd_tbl *cmdt=
p, int flag,
>>          return CMD_RET_SUCCESS;
>>   }
>>
>> +/**
>> + * do_efi_show_defaults() - show UEFI default filename and PXE archite=
cture
>> + *
>> + * @cmdtp:     Command table
>> + * @flag:      Command flag
>> + * @argc:      Number of arguments
>> + * @argv:      Argument array
>> + * Return:     CMD_RET_SUCCESS on success, CMD_RET_RET_FAILURE on fail=
ure
>> + *
>> + * Implement efidebug "defaults" sub-command.
>> + * Shows the default EFI filename and PXE architecture
>> + */
>> +static int do_efi_show_defaults(struct cmd_tbl *cmdtp, int flag,
>> +                               int argc, char *const argv[])
>> +{
>> +       printf("Default boot path: EFI\\BOOT\\%s\n", efi_get_basename()=
);
>> +       printf("PXE arch: 0x%02x\n", efi_get_pxe_arch());
>> +
>> +       return CMD_RET_SUCCESS;
>> +}
>> +
>>   static const char * const efi_mem_type_string[] =3D {
>>          [EFI_RESERVED_MEMORY_TYPE] =3D "RESERVED",
>>          [EFI_LOADER_CODE] =3D "LOADER CODE",
>> @@ -1561,6 +1582,8 @@ static struct cmd_tbl cmd_efidebug_sub[] =3D {
>>                           "", ""),
>>          U_BOOT_CMD_MKENT(dh, CONFIG_SYS_MAXARGS, 1, do_efi_show_handle=
s,
>>                           "", ""),
>> +       U_BOOT_CMD_MKENT(defaults, CONFIG_SYS_MAXARGS, 1, do_efi_show_d=
efaults,
>> +                        "", ""),
>>          U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_im=
ages,
>>                           "", ""),
>>          U_BOOT_CMD_MKENT(memmap, CONFIG_SYS_MAXARGS, 1, do_efi_show_me=
mmap,
>> @@ -1653,6 +1676,8 @@ U_BOOT_LONGHELP(efidebug,
>>          "  - show UEFI drivers\n"
>>          "efidebug dh\n"
>>          "  - show UEFI handles\n"
>> +       "efidebug defaults\n"
>> +       "  - show default EFI filename and PXE architecture\n"
>>          "efidebug images\n"
>>          "  - show loaded images\n"
>>          "efidebug memmap\n"
>> diff --git a/include/efi.h b/include/efi.h
>> index 1b8093bd4d3..70bb47e742f 100644
>> --- a/include/efi.h
>> +++ b/include/efi.h
>> @@ -678,4 +678,29 @@ void efi_show_tables(struct efi_system_table *syst=
ab);
>>    */
>>   const char *efi_get_basename(void);
>>
>> +#ifdef CONFIG_SANDBOX
>> +#include <asm/state.h>
>> +#endif
>> +
>> +static inline bool efi_use_host_arch(void)
>> +{
>> +#ifdef CONFIG_SANDBOX
>
> #if IS_ENABLED(CONFIG_SANDBOX) is preferred no ?
>
>> +       struct sandbox_state *state =3D state_get_current();
>> +
>> +       return state->native;
>> +#else
>> +       return false;
>> +#endif
>> +}
>> +
>> +/**
>> + * efi_get_pxe_arch() - Get the architecture value for PXE
>> + *
>> + * See:
>> + * http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters=
.xml
>> + *
>> + * Return: Architecture value
>> + */
>> +int efi_get_pxe_arch(void);
>> +
>>   #endif /* _LINUX_EFI_H */
>> --
>> 2.43.0
>>
>
> Thanks
> /Ilias

