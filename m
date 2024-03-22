Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3D8C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 08:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 762C18818B;
	Fri, 22 Mar 2024 09:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="i9roeaG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E21988197; Fri, 22 Mar 2024 09:14:44 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B108819D
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 09:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B6BE4120016;
 Fri, 22 Mar 2024 11:14:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B6BE4120016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1711095279;
 bh=yIqYRbFevKeLq77EZd4K1+Ys3Af2T8a1FGrVkbt1yu4=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=i9roeaG99vXwmcAm6uAB1KBU2dFrEeCG5I/Q4KvZ66HSp8aC6rYQ46KmLhB0OvEKZ
 vXHqfyYDo9RgmdYBENIa0qe/6r4L/dFBKroqIjDqXXjysao937diq0TAzXcM82zhQL
 YH1u/7LX122DGU/V2yDJpFAE2FcdGOfHSmfdppRjY+yMwjFHGk0CoJgmGQsGX5pq7M
 Zdyl03XrinAG6aoQoE5gLofztXkn1J5+Da7dhNVEnDMMgrsYWPii20d8lp6KjEshk4
 UqqVbkgomhVT/SYvqHLKK8r951wZ5tjj6/JATxPvabqi+EaKquG1hn4TS8AZ4u0cdj
 /AvlkYWaQIPOw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 22 Mar 2024 11:14:39 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Mar 2024 11:14:39 +0300
Message-ID: <c9bad5ad-e4c9-f895-6f8b-7653859cb2af@salutedevices.com>
Date: Fri, 22 Mar 2024 11:04:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] cmd: mtd: OTP access support
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Simon Glass <sjg@chromium.org>, Alexey Romanov <avromanov@sberdevices.ru>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil M Jain <n-jain1@ti.com>, 
 Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Sean Edmond <seanedmond@microsoft.com>, Tobias
 Waldekranz <tobias@waldekranz.com>, Stephen Carlson
 <stcarlso@linux.microsoft.com>, Michael Walle <michael@walle.cc>, Peter
 Robinson <pbrobinson@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20240320190443.1483274-1-avkrasnov@salutedevices.com>
 <CAOf5uwnF8VZoY5pQM6yaGOvT-e4NiBmS965+Re5xZ=X_pQmktw@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CAOf5uwnF8VZoY5pQM6yaGOvT-e4NiBmS965+Re5xZ=X_pQmktw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184341 [Mar 22 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 11 0.3.11
 5ecf9895443a5066245fcb91e8430edf92b1b594, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, source.denx.de:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/22 06:20:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/22 06:20:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/03/22 05:30:00 #24352985
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hi,

On 22.03.2024 11:12, Michael Nazzareno Trimarchi wrote:
> Hi Arseniy
> 
> On Wed, Mar 20, 2024 at 8:14 PM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>> Add access to OTP region. It supports info, dump, write and lock
>> operations. Usage example:
>>
>> 'mtd otpread nand0 u 0 1024' - dump 1024 bytes of user area starting
>>  from offset 0 of device 'nand0'.
>>
>> 'mtd otpwrite nand0 10 11223344' - write binary data 0x11, 0x22, 0x33,
>>  0x44 to offset 10 to user area of device 'nand0'.
>>
>> 'mtd otplock nand0 0 1024' - lock 1024 bytes of user area starting
>>  from offset 0 of device 'nand0'.
>>
>> 'mtd otpinfo nand0 f' - show info about factory area of device 'nand0'.
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
>> ---
>>  Changelog:
>>  v1 -> v2:
>>   * Remove warning that OTP can't be erased after write.
>>  v2 -> v3:
>>   * Commit message updated by adding usage.
>>   * R-b added.
>>  v3 -> v4:
>>   * Fix build failure due to invalid format strings for 'printf()'.
>>   * Rebase over latest version of cmd/mtd.c.
>>
>>  cmd/Kconfig |   1 +
>>  cmd/mtd.c   | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 225 insertions(+)
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 7292a150f5..f218dc6cf2 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -1363,6 +1363,7 @@ config CMD_MTD
>>         bool "mtd"
>>         depends on MTD
>>         select MTD_PARTITIONS
>> +       select HEXDUMP
> 
> Make those change forced in increase the size of uboot and break this build
> 
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/jobs/802378
> 
> I think that those command could be optional and not forced to be
> included by default
> 

Ah, Ok:) I'll add it as config option which depends on CMD_MTD in the next version

Thanks

> Michael
> 
> 
>>         help
>>           MTD commands support.
>>
>> diff --git a/cmd/mtd.c b/cmd/mtd.c
>> index e63c011e79..2b03a85ef0 100644
>> --- a/cmd/mtd.c
>> +++ b/cmd/mtd.c
>> @@ -11,6 +11,7 @@
>>  #include <command.h>
>>  #include <common.h>
>>  #include <console.h>
>> +#include <hexdump.h>
>>  #include <malloc.h>
>>  #include <mapmem.h>
>>  #include <mtd.h>
>> @@ -202,6 +203,219 @@ static bool mtd_oob_write_is_empty(struct mtd_oob_ops *op)
>>         return true;
>>  }
>>
>> +static int do_mtd_otp_read(struct cmd_tbl *cmdtp, int flag, int argc,
>> +                          char *const argv[])
>> +{
>> +       struct mtd_info *mtd;
>> +       size_t retlen;
>> +       off_t from;
>> +       size_t len;
>> +       bool user;
>> +       int ret;
>> +       u8 *buf;
>> +
>> +       if (argc != 5)
>> +               return CMD_RET_USAGE;
>> +
>> +       if (!strcmp(argv[2], "u"))
>> +               user = true;
>> +       else if (!strcmp(argv[2], "f"))
>> +               user = false;
>> +       else
>> +               return CMD_RET_USAGE;
>> +
>> +       mtd = get_mtd_by_name(argv[1]);
>> +       if (IS_ERR_OR_NULL(mtd))
>> +               return CMD_RET_FAILURE;
>> +
>> +       from = simple_strtoul(argv[3], NULL, 0);
>> +       len = simple_strtoul(argv[4], NULL, 0);
>> +
>> +       ret = CMD_RET_FAILURE;
>> +
>> +       buf = malloc(len);
>> +       if (!buf)
>> +               goto put_mtd;
>> +
>> +       printf("Reading %s OTP from 0x%lx, %zu bytes\n",
>> +              user ? "user" : "factory", from, len);
>> +
>> +       if (user)
>> +               ret = mtd_read_user_prot_reg(mtd, from, len, &retlen, buf);
>> +       else
>> +               ret = mtd_read_fact_prot_reg(mtd, from, len, &retlen, buf);
>> +       if (ret) {
>> +               free(buf);
>> +               pr_err("OTP read failed: %d\n", ret);
>> +               ret = CMD_RET_FAILURE;
>> +               goto put_mtd;
>> +       }
>> +
>> +       if (retlen != len)
>> +               pr_err("OTP read returns %zu, but %zu expected\n",
>> +                      retlen, len);
>> +
>> +       print_hex_dump("", 0, 16, 1, buf, retlen, true);
>> +
>> +       free(buf);
>> +
>> +       ret = CMD_RET_SUCCESS;
>> +
>> +put_mtd:
>> +       put_mtd_device(mtd);
>> +
>> +       return ret;
>> +}
>> +
>> +static int do_mtd_otp_lock(struct cmd_tbl *cmdtp, int flag, int argc,
>> +                          char *const argv[])
>> +{
>> +       struct mtd_info *mtd;
>> +       off_t from;
>> +       size_t len;
>> +       int ret;
>> +
>> +       if (argc != 4)
>> +               return CMD_RET_USAGE;
>> +
>> +       mtd = get_mtd_by_name(argv[1]);
>> +       if (IS_ERR_OR_NULL(mtd))
>> +               return CMD_RET_FAILURE;
>> +
>> +       from = simple_strtoul(argv[2], NULL, 0);
>> +       len = simple_strtoul(argv[3], NULL, 0);
>> +
>> +       ret = mtd_lock_user_prot_reg(mtd, from, len);
>> +       if (ret) {
>> +               pr_err("OTP lock failed: %d\n", ret);
>> +               ret = CMD_RET_FAILURE;
>> +               goto put_mtd;
>> +       }
>> +
>> +       ret = CMD_RET_SUCCESS;
>> +
>> +put_mtd:
>> +       put_mtd_device(mtd);
>> +
>> +       return ret;
>> +}
>> +
>> +static int do_mtd_otp_write(struct cmd_tbl *cmdtp, int flag, int argc,
>> +                           char *const argv[])
>> +{
>> +       struct mtd_info *mtd;
>> +       size_t retlen;
>> +       size_t binlen;
>> +       u8 *binbuf;
>> +       off_t from;
>> +       int ret;
>> +
>> +       if (argc != 4)
>> +               return CMD_RET_USAGE;
>> +
>> +       mtd = get_mtd_by_name(argv[1]);
>> +       if (IS_ERR_OR_NULL(mtd))
>> +               return CMD_RET_FAILURE;
>> +
>> +       from = simple_strtoul(argv[2], NULL, 0);
>> +       binlen = strlen(argv[3]) / 2;
>> +
>> +       ret = CMD_RET_FAILURE;
>> +       binbuf = malloc(binlen);
>> +       if (!binbuf)
>> +               goto put_mtd;
>> +
>> +       hex2bin(binbuf, argv[3], binlen);
>> +
>> +       printf("Will write:\n");
>> +
>> +       print_hex_dump("", 0, 16, 1, binbuf, binlen, true);
>> +
>> +       printf("to 0x%lx\n", from);
>> +
>> +       printf("Continue (y/n)?\n");
>> +
>> +       if (confirm_yesno() != 1) {
>> +               pr_err("OTP write canceled\n");
>> +               ret = CMD_RET_SUCCESS;
>> +               goto put_mtd;
>> +       }
>> +
>> +       ret = mtd_write_user_prot_reg(mtd, from, binlen, &retlen, binbuf);
>> +       if (ret) {
>> +               pr_err("OTP write failed: %d\n", ret);
>> +               ret = CMD_RET_FAILURE;
>> +               goto put_mtd;
>> +       }
>> +
>> +       if (retlen != binlen)
>> +               pr_err("OTP write returns %zu, but %zu expected\n",
>> +                      retlen, binlen);
>> +
>> +       ret = CMD_RET_SUCCESS;
>> +
>> +put_mtd:
>> +       free(binbuf);
>> +       put_mtd_device(mtd);
>> +
>> +       return ret;
>> +}
>> +
>> +static int do_mtd_otp_info(struct cmd_tbl *cmdtp, int flag, int argc,
>> +                          char *const argv[])
>> +{
>> +       struct otp_info otp_info;
>> +       struct mtd_info *mtd;
>> +       size_t retlen;
>> +       bool user;
>> +       int ret;
>> +
>> +       if (argc != 3)
>> +               return CMD_RET_USAGE;
>> +
>> +       if (!strcmp(argv[2], "u"))
>> +               user = true;
>> +       else if (!strcmp(argv[2], "f"))
>> +               user = false;
>> +       else
>> +               return CMD_RET_USAGE;
>> +
>> +       mtd = get_mtd_by_name(argv[1]);
>> +       if (IS_ERR_OR_NULL(mtd))
>> +               return CMD_RET_FAILURE;
>> +
>> +       if (user)
>> +               ret = mtd_get_user_prot_info(mtd, sizeof(otp_info), &retlen,
>> +                                            &otp_info);
>> +       else
>> +               ret = mtd_get_fact_prot_info(mtd, sizeof(otp_info), &retlen,
>> +                                            &otp_info);
>> +       if (ret) {
>> +               pr_err("OTP info failed: %d\n", ret);
>> +               ret = CMD_RET_FAILURE;
>> +               goto put_mtd;
>> +       }
>> +
>> +       if (retlen != sizeof(otp_info)) {
>> +               pr_err("OTP info returns %zu, but %zu expected\n",
>> +                      retlen, sizeof(otp_info));
>> +               ret = CMD_RET_FAILURE;
>> +               goto put_mtd;
>> +       }
>> +
>> +       printf("%s OTP region info:\n", user ? "User" : "Factory");
>> +       printf("\tstart: %u\n", otp_info.start);
>> +       printf("\tlength: %u\n", otp_info.length);
>> +       printf("\tlocked: %u\n", otp_info.locked);
>> +
>> +       ret = CMD_RET_SUCCESS;
>> +
>> +put_mtd:
>> +       put_mtd_device(mtd);
>> +
>> +       return ret;
>> +}
>> +
>>  static int do_mtd_list(struct cmd_tbl *cmdtp, int flag, int argc,
>>                        char *const argv[])
>>  {
>> @@ -551,6 +765,10 @@ U_BOOT_LONGHELP(mtd,
>>         "\n"
>>         "Specific functions:\n"
>>         "mtd bad                               <name>\n"
>> +       "mtd otpread                           <name> [u|f] <off> <size>\n"
>> +       "mtd otpwrite                          <name> <off> <hex string>\n"
>> +       "mtd otplock                           <name> <off> <size>\n"
>> +       "mtd otpinfo                           <name> [u|f]\n"
>>         "\n"
>>         "With:\n"
>>         "\t<name>: NAND partition/chip name (or corresponding DM device name or OF path)\n"
>> @@ -561,10 +779,16 @@ U_BOOT_LONGHELP(mtd,
>>         "\t<size>: length of the operation in bytes (default: the entire device)\n"
>>         "\t\t* must be a multiple of a block for erase\n"
>>         "\t\t* must be a multiple of a page otherwise (special case: default is a page with dump)\n"
>> +       "\t<hex string>: hex string without '0x' and spaces. Example: ABCD1234\n"
>> +       "\t[u|f]: user or factory OTP region\n"
>>         "\n"
>>         "The .dontskipff option forces writing empty pages, don't use it if unsure.\n");
>>
>>  U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
>> +               U_BOOT_SUBCMD_MKENT(otpread, 5, 1, do_mtd_otp_read),
>> +               U_BOOT_SUBCMD_MKENT(otpwrite, 4, 1, do_mtd_otp_write),
>> +               U_BOOT_SUBCMD_MKENT(otplock, 4, 1, do_mtd_otp_lock),
>> +               U_BOOT_SUBCMD_MKENT(otpinfo, 3, 1, do_mtd_otp_info),
>>                 U_BOOT_SUBCMD_MKENT(list, 1, 1, do_mtd_list),
>>                 U_BOOT_SUBCMD_MKENT_COMPLETE(read, 5, 0, do_mtd_io,
>>                                              mtd_name_complete),
>> --
>> 2.35.0
>>
> 
> 
