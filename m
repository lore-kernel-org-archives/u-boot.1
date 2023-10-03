Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E69E8FDC1
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 23:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB5FD86E8E;
	Wed,  4 Oct 2023 01:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ANHbTtUe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4CA886E96; Wed,  4 Oct 2023 01:44:16 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id EDBB086D7E
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 01:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from [10.7.98.35] (unknown [167.220.24.35])
 by linux.microsoft.com (Postfix) with ESMTPSA id 730D220B74C0;
 Tue,  3 Oct 2023 16:44:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 730D220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1696376651;
 bh=tVSxexvDsdp9szINAdelzlSQz3clBSah7cQJce1sDUI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ANHbTtUeNIgO13V4GBsJec6/LW5Jc6bqqwrpZxbIEiflwIQ9w1n7c05SPoacdOLgJ
 3xUewWbSHnIRqSdcX9f9Y7EyczhpsrV7wzJ4czvnULqsGVrb00wHaX//KAx4vIpc1N
 ZgR2IwHAnShZ/eVCVP499AKO+/bTZnbk8bx/xtQI=
Message-ID: <6ed884d1-427c-2c1d-275f-25eb817aef7c@linux.microsoft.com>
Date: Tue, 3 Oct 2023 16:44:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 14/15] net/lwip: replace original net commands with lwip
Content-Language: en-GB
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 trini@konsulko.com, goldsimon@gmx.de
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-15-maxim.uvarov@linaro.org>
 <77c30b7d-66ae-a7ff-0e7d-07be3098acbc@linux.microsoft.com>
 <CALeDE9NkvMbmwZP-7E4_mH3WfFAV==ZX_3PMhk7DKYj5OyFqmQ@mail.gmail.com>
From: Sean Edmond <seanedmond@linux.microsoft.com>
In-Reply-To: <CALeDE9NkvMbmwZP-7E4_mH3WfFAV==ZX_3PMhk7DKYj5OyFqmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 2023-10-03 2:58 p.m., Peter Robinson wrote:
> On Tue, Oct 3, 2023 at 6:58 PM Sean Edmond
> <seanedmond@linux.microsoft.com>  wrote:
>>
>> On 2023-09-26 2:41 a.m., Maxim Uvarov wrote:
>>
>> Replace original commands: ping, tftp, dhcp and wget.
>>
>> Signed-off-by: Maxim Uvarov<maxim.uvarov@linaro.org>
>> ---
>>   boot/bootmeth_efi.c | 18 +++++++---
>>   boot/bootmeth_pxe.c | 21 ++++++-----
>>   cmd/net.c           | 86 +++++----------------------------------------
>>   cmd/pxe.c           | 19 +++++-----
>>   include/net.h       |  8 +++--
>>   include/net/ulwip.h | 64 +++++++++++++++++++++++++++++++++
>>   6 files changed, 113 insertions(+), 103 deletions(-)
>>   create mode 100644 include/net/ulwip.h
>>
>> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
>> index ae936c8daa..52399d627c 100644
>> --- a/boot/bootmeth_efi.c
>> +++ b/boot/bootmeth_efi.c
>> @@ -20,6 +20,8 @@
>>   #include <mapmem.h>
>>   #include <mmc.h>
>>   #include <net.h>
>> +#include <net/lwip.h>
>> +#include <net/ulwip.h>
>>   #include <pxe_utils.h>
>>   #include <linux/sizes.h>
>>
>> @@ -319,9 +321,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
>>
>>   static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>>   {
>> - char file_addr[17], fname[256];
>> - char *tftp_argv[] = {"tftp", file_addr, fname, NULL};
>> - struct cmd_tbl cmdtp = {}; /* dummy */
>> + char fname[256];
>>    const char *addr_str, *fdt_addr_str;
>>    int ret, arch, size;
>>    ulong addr, fdt_addr;
>> @@ -368,7 +368,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>>    if (!fdt_addr_str)
>>    return log_msg_ret("fdt", -EINVAL);
>>    fdt_addr = hextoul(fdt_addr_str, NULL);
>> - sprintf(file_addr, "%lx", fdt_addr);
>>
>>    /* We only allow the first prefix with PXE */
>>    ret = distro_efi_get_fdt_name(fname, sizeof(fname), 0);
>> @@ -379,7 +378,16 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>>    if (!bflow->fdt_fname)
>>    return log_msg_ret("fil", -ENOMEM);
>>
>> - if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
>> + ret = ulwip_init();
>> + if (ret)
>> + return log_msg_ret("ulwip_init", ret);
>> +
>> + ret = ulwip_tftp(fdt_addr, fname);
>> + if (ret)
>> + return log_msg_ret("ulwip_tftp", ret);
>> +
>> + ret = ulwip_loop();
>> + if (!ret) {
>>    bflow->fdt_size = env_get_hex("filesize", 0);
>>    bflow->fdt_addr = fdt_addr;
>>    } else {
>> diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
>> index 8d489a11aa..fc6aabaa18 100644
>> --- a/boot/bootmeth_pxe.c
>> +++ b/boot/bootmeth_pxe.c
>> @@ -21,6 +21,8 @@
>>   #include <mapmem.h>
>>   #include <mmc.h>
>>   #include <net.h>
>> +#include <net/ulwip.h>
>> +#include <net/lwip.h>
>>   #include <pxe_utils.h>
>>
>>   static int extlinux_pxe_getfile(struct pxe_context *ctx, const char *file_path,
>> @@ -116,18 +118,21 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
>>     const char *file_path, ulong addr,
>>     ulong *sizep)
>>   {
>> - char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
>> - struct pxe_context *ctx = dev_get_priv(dev);
>> - char file_addr[17];
>>    ulong size;
>>    int ret;
>>
>> - sprintf(file_addr, "%lx", addr);
>> - tftp_argv[1] = file_addr;
>> - tftp_argv[2] = (void *)file_path;
>> + ret = ulwip_init();
>> + if (ret)
>> + return log_msg_ret("ulwip_init", ret);
>> +
>> + ret = ulwip_tftp(addr, file_path);
>> + if (ret)
>> + return log_msg_ret("ulwip_tftp", ret);
>> +
>> + ret = ulwip_loop();
>> + if (ret)
>> + return log_msg_ret("ulwip_loop", ret);
>>
>> - if (do_tftpb(ctx->cmdtp, 0, 3, tftp_argv))
>> - return -ENOENT;
>>    ret = pxe_get_file_size(&size);
>>    if (ret)
>>    return log_msg_ret("tftp", ret);
>> diff --git a/cmd/net.c b/cmd/net.c
>> index d407d8320a..dc5a114309 100644
>> --- a/cmd/net.c
>> +++ b/cmd/net.c
>> @@ -22,6 +22,7 @@
>>   #include <net/udp.h>
>>   #include <net/sntp.h>
>>   #include <net/ncsi.h>
>> +#include <net/lwip.h>
>>
>>   static int netboot_common(enum proto_t, struct cmd_tbl *, int, char * const []);
>>
>> @@ -40,19 +41,9 @@ U_BOOT_CMD(
>>   #endif
>>
>>   #ifdef CONFIG_CMD_TFTPBOOT
>> -int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> -{
>> - int ret;
>> -
>> - bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
>> - ret = netboot_common(TFTPGET, cmdtp, argc, argv);
>> - bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
>> - return ret;
>> -}
>> -
>>   #if IS_ENABLED(CONFIG_IPV6)
>>   U_BOOT_CMD(
>> - tftpboot, 4, 1, do_tftpb,
>> + tftpboot, 4, 1, do_lwip_tftp,
>>
>> It looks like LWIP doesn't support TFTP with IPv6 addressing.  Perhaps we need to fall back onto the existing TFTP implementation until LWIP supports it?
> Is it that LWIP upstream doesn't support IPv6 with TFTP or it just
> hasn't been dealt with in this patch set? If the former  might be
> useful to reference details.

Apologies for the misleading comment, LWIP does support IPv6 addressing, 
it just hasn't been dealt with in this patch.

>
>> Note, that currently, IPv6 TFTP is enabled using the "-ipv6" argument.  The intention is that netboot_common() sees the argument and sets the "use_ip6" variable.  It looks like the new implementation in do_lwip_tftp() doesn't re-use the argument parsing in netboot_common() and that it doesn't handle the addition of the "-ipv6" flag.
> Is there a reason why there's a need of an explicit argument for IPv6?
> I would have thought if there was a local IPv6 address assigned that
> you would automatically try IPv6 and if it fails for back to v4, or
> even better do a DNS lookup and use what ever gets returned. Having to
> know what to use by manually specifying a parameter doesn't sound like
> a great user experience, what's the use case?

This how IPv6 was added to the TFTP commands in the initial patch 
series.  I added the "-ipv6" argument to the PXE commands.  At the time 
it was accepted that explicit selection was required.  In our case, we 
try IPv4 and then fallback to IPv6. For example:

< Try IPv4 >
setenv autoload no;
dhcp;
pxe get;
pxe boot;
< If IPv4 fails try IPv6 >
dhcp6;
pxe get -ipv6;
pxe boot -ipv6;

TFTP could intelligently select based on the environment variables.  So, 
we could try IPv4 first if env variable "serverip" is set, otherwise try 
IPv6 if env variable "serverip6" is set.  This would make things easier 
to use and would simplify the code.  It's not clear why the "-ipv6" 
argument was used for the TFTP commands in the first place... I'm 
guessing it was to provide more control to the user.

>> I support the addition of LWIP, but I'm concerned about how abrupt changes like this one will be for existing users.  The underlying stack will change, with no easy way for the user to revert to the previous stack.  Has there been any discussion about preserving the existing functionality, with an option to enable/disable LWIP stack?  This would give the community time to transition/validate LWIP before deprecating the old u-boot networking stack.
> The problem is how long do we maintain dual stacks, do we default to
> which one, when do we switch the defaults, how long do we wait to
> remove the stack and the maintenance burden on the small amount of
> maintainers?
>
>>    "boot image via network using TFTP protocol\n"
>>    "To use IPv6 add -ipv6 parameter or use IPv6 hostIPaddr framed "
>>    "with [] brackets",
>> @@ -60,7 +51,7 @@ U_BOOT_CMD(
>>   );
>>   #else
>>   U_BOOT_CMD(
>> - tftpboot, 3, 1, do_tftpb,
>> + tftpboot, 3, 1,  do_lwip_tftp,
>>    "load file via network using TFTP protocol",
>>    "[loadAddress] [[hostIPaddr:]bootfilename]"
>>   );
>> @@ -139,7 +130,7 @@ U_BOOT_CMD(dhcp6, 3, 1, do_dhcp6,
>>   static int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,
>>      char *const argv[])
>>   {
>> - return netboot_common(DHCP, cmdtp, argc, argv);
>> + return do_lwip_dhcp();
>>   }
>>
>>   U_BOOT_CMD(
>> @@ -196,13 +187,11 @@ U_BOOT_CMD(
>>   #endif
>>
>>   #if defined(CONFIG_CMD_WGET)
>> -static int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>> -{
>> - return netboot_common(WGET, cmdtp, argc, argv);
>> -}
>> +int do_lwip_wget(struct cmd_tbl *cmdtp, int flag, int argc,
>> + char *const argv[]);
>>
>>   U_BOOT_CMD(
>> - wget,   3,      1,      do_wget,
>> + wget,   3,      1, do_lwip_wget,
>>    "boot image via network using HTTP protocol",
>>    "[loadAddress] [[hostIPaddr:]path and image name]"
>>   );
>> @@ -456,28 +445,8 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
>>   }
>>
>>   #if defined(CONFIG_CMD_PING)
>> -static int do_ping(struct cmd_tbl *cmdtp, int flag, int argc,
>> -   char *const argv[])
>> -{
>> - if (argc < 2)
>> - return CMD_RET_USAGE;
>> -
>> - net_ping_ip = string_to_ip(argv[1]);
>> - if (net_ping_ip.s_addr == 0)
>> - return CMD_RET_USAGE;
>> -
>> - if (net_loop(PING) < 0) {
>> - printf("ping failed; host %s is not alive\n", argv[1]);
>> - return CMD_RET_FAILURE;
>> - }
>> -
>> - printf("host %s is alive\n", argv[1]);
>> -
>> - return CMD_RET_SUCCESS;
>> -}
>> -
>>   U_BOOT_CMD(
>> - ping, 2, 1, do_ping,
>> + ping, 2, 1, do_lwip_ping,
>>    "send ICMP ECHO_REQUEST to network host",
>>    "pingAddress"
>>   );
>> @@ -601,45 +570,8 @@ U_BOOT_CMD(
>>   #endif
>>
>>   #if defined(CONFIG_CMD_DNS)
>> -int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> -{
>> - if (argc == 1)
>> - return CMD_RET_USAGE;
>> -
>> - /*
>> - * We should check for a valid hostname:
>> - * - Each label must be between 1 and 63 characters long
>> - * - the entire hostname has a maximum of 255 characters
>> - * - only the ASCII letters 'a' through 'z' (case-insensitive),
>> - *   the digits '0' through '9', and the hyphen
>> - * - cannot begin or end with a hyphen
>> - * - no other symbols, punctuation characters, or blank spaces are
>> - *   permitted
>> - * but hey - this is a minimalist implmentation, so only check length
>> - * and let the name server deal with things.
>> - */
>> - if (strlen(argv[1]) >= 255) {
>> - printf("dns error: hostname too long\n");
>> - return CMD_RET_FAILURE;
>> - }
>> -
>> - net_dns_resolve = argv[1];
>> -
>> - if (argc == 3)
>> - net_dns_env_var = argv[2];
>> - else
>> - net_dns_env_var = NULL;
>> -
>> - if (net_loop(DNS) < 0) {
>> - printf("dns lookup of %s failed, check setup\n", argv[1]);
>> - return CMD_RET_FAILURE;
>> - }
>> -
>> - return CMD_RET_SUCCESS;
>> -}
>> -
>>   U_BOOT_CMD(
>> - dns, 3, 1, do_dns,
>> + dns, 3, 1, do_lwip_dns,
>>    "lookup the IP of a hostname",
>>    "hostname [envvar]"
>>   );
>> diff --git a/cmd/pxe.c b/cmd/pxe.c
>> index 677142520b..d44df428d2 100644
>> --- a/cmd/pxe.c
>> +++ b/cmd/pxe.c
>> @@ -8,6 +8,7 @@
>>   #include <command.h>
>>   #include <fs.h>
>>   #include <net.h>
>> +#include <net/lwip.h>
>>   #include <net6.h>
>>   #include <malloc.h>
>>
>> @@ -29,21 +30,19 @@ const char *pxe_default_paths[] = {
>>   static int do_get_tftp(struct pxe_context *ctx, const char *file_path,
>>          char *file_addr, ulong *sizep)
>>   {
>> - char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
>> + ulong addr;
>> + char *end;
>>    int ret;
>> - int num_args;
>>
>> - tftp_argv[1] = file_addr;
>> - tftp_argv[2] = (void *)file_path;
>> + addr = hextoul(file_addr, &end);
>> +
>>    if (ctx->use_ipv6) {
>> - tftp_argv[3] = USE_IP6_CMD_PARAM;
>> - num_args = 4;
>> - } else {
>> - num_args = 3;
>> + /* @todo: check and fix me, here */
>>
>> Again, looks like LWIP doesn't support IPv6 addressing, we may want to fall back on existing TFTP implementation here.
>>
>>    }
>>
>> - if (do_tftpb(ctx->cmdtp, 0, num_args, tftp_argv))
>> - return -ENOENT;
>> + ret = ulwip_tftp(addr, file_path);
>> + if (ret)
>> + return log_msg_ret("tftp", ret);
>>
>>    ret = pxe_get_file_size(sizep);
>>    if (ret)
>> diff --git a/include/net.h b/include/net.h
>> index e254df7d7f..de7baeb121 100644
>> --- a/include/net.h
>> +++ b/include/net.h
>> @@ -54,8 +54,10 @@ struct in_addr {
>>    __be32 s_addr;
>>   };
>>
>> +int do_lwip_dhcp(void);
>> +
>>   /**
>> - * do_tftpb - Run the tftpboot command
>> + * do_lwip_tftp - Run the tftpboot command
>>    *
>>    * @cmdtp: Command information for tftpboot
>>    * @flag: Command flags (CMD_FLAG_...)
>> @@ -63,7 +65,7 @@ struct in_addr {
>>    * @argv: List of arguments
>>    * Return: result (see enum command_ret_t)
>>    */
>> -int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>> +int do_lwip_tftp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>>
>>   /**
>>    * dhcp_run() - Run DHCP on the current ethernet device
>> @@ -514,7 +516,7 @@ extern int net_restart_wrap; /* Tried all network devices */
>>   enum proto_t {
>>    BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
>>    NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
>> - WOL, UDP, NCSI, WGET, RS
>> + WOL, UDP, NCSI, WGET, RS, LWIP
>>   };
>>
>>   extern char net_boot_file_name[1024];/* Boot File name */
>> diff --git a/include/net/ulwip.h b/include/net/ulwip.h
>> new file mode 100644
>> index 0000000000..8eac7aa130
>> --- /dev/null
>> +++ b/include/net/ulwip.h
>> @@ -0,0 +1,64 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/**
>> + * ulwip_init() - initialize lwIP network stack
>> + *
>> + * @return 0 if success, !0 if error
>> + */
>> +int ulwip_init(void);
>> +
>> +/**
>> + * ulwip_enabled() - check if lwIP network stack was initialized
>> + *
>> + * @return 1 lwip initialized, 0 if not yet initialized
>> + */
>> +int ulwip_enabled(void);
>> +
>> +/**
>> + * ulwip_in_loop() - lwIP controls packet net loop
>> + *
>> + * @return 1 lwIP owns packet loop, 0 lwip does not own packet loop
>> + */
>> +int ulwip_in_loop(void);
>> +
>> +/**
>> + * ulwip_loop_set() - make loop to be used by lwIP
>> + *
>> + * Function is used to make lwIP control network pool.
>> + *
>> + * @loop: 1. Rx packets go to lwIP 2. Rx packets go to the original stack.
>> + */
>> +void ulwip_loop_set(int loop);
>> +
>> +/**
>> + * ulwip_exit() - exit from lwIP with a return code
>> + *
>> + * Exit from lwIP application back to the U-Boot with specific error code.
>> + *
>> + * @err: Error code to return
>> + */
>> +void ulwip_exit(int err);
>> +
>> +/**
>> + * ulwip_poll() - polling function to feed lwIP with ethernet packet
>> + *
>> + * Function takes network packet and passes it to lwIP network stack
>> + */
>> +void ulwip_poll(void);
>> +
>> +/**
>> + * ulwip_app_get_err() - return error code from lwIP application
>> + *
>> + * @return error code
>> + */
>> +int ulwip_app_get_err(void);
>> +
>> +/**
>> + * ulwip_loop() - enter to packet polling loop
>> + *
>> + * When lwIP application did it's initialization stage, then it needs to enter
>> + * to packet polling loop to grab rx packets.
>> + *
>> + * Returns:  0 if success, !0 if error
>> + */
>> +int ulwip_loop(void);
