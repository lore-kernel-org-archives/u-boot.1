Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF491EE49A4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 03:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7029886CD0;
	Mon, 11 Sep 2023 05:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="sF3m0p4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F2C386B0E; Mon, 11 Sep 2023 02:58:13 +0200 (CEST)
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com
 [162.62.57.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08AC586C0B
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 02:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rtoax@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1694393882;
 bh=8ZkZTE5jCUve79V9LdHGq6w0kkbhlZN3VcG/36IWZz8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=sF3m0p4Z4s7VeZkWGroislPtpDRO1uX+xwPTywfyIN2goJ7F2jNxtBo7hcS76QIN7
 W6Akl2rrAw9pxYQUCV5NwaBZJJMDX2mGNpO568dxc5dLmpvjZkAw+D+/u6ues2hxs5
 KfeJQYCDEz+WybpT3O0pNTNS7711L+B68CLxRJ+E=
Received: from [10.56.52.5] ([39.156.73.12])
 by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
 id CF20FAF7; Mon, 11 Sep 2023 08:51:50 +0800
X-QQ-mid: xmsmtpt1694393510tn0zgwfmr
Message-ID: <tencent_94924065F3356E3401F1C54043882B8BFA05@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQk1giPPfNlljxnw9LNoTUn/U73j14nzd6hRiaoqJpdgi0P7WDUr
 MmdIk3oH/dqKkeGfrdAmUUX8BT5QiE+5fytYtlqpiU3Y7dPHUXOlapJHfvMlRXzLkGZ/eAD0wdvo
 mAZyDjgtMQvceOSBX41Sxcm+iTT24Qu61MdoZeVOVM0Ko69nxvAfjrf0brY4/tgF/rCrZ7nihDNl
 a5qGwVEdjt//eZb26SsieLpYQvvjzuQfvXMsVZbkF8dorn1zi3h257lUPwDUjIjkSYfQ2kueoaNg
 x5BOQ3MZYyOEhu6ambpQV2LUBCmwABw1Qmrqx1y/Oy0RFdhryTJLnoWzLgTAZmMAa3zvTSdbl/FS
 rQgBLy/hCxqgZpKv5jjOUFNqwxGBrnGE/fS2Nfg4IgDZbvDfS27iUk5FcktRqf4b77yux4rucZhi
 saFZfeHRA6poPNmM5wLdQ62mKXcLTp+U5sqw2uqAUgoSqqovg5tsjVjHhrUKscqwQaY0HOib/Ufj
 2jjncc7wAZnetYd5OGKbWqCN2ijqvFxfH6H9dqs0bL+VeYLxLY4Ac5nlHGUgu0+Krdb15hNu+uvF
 1EDUoRMzunZsBQyMI3ivH1DNO+9HH89dHun/KoUMnhbiYxLczBcQkbNXq8A+uII/pOM6f1xDf2d9
 KYxHHavylzVnU+APzyvbyLrPriZv6hDiE/d1H7LKgQU5qmcmQOiZfR/8h9m4jEzhCuY7SLnOfAvx
 GN773O5knsPjluJLt1lfKGjnfKtUFw6i9d3mYt0WsRpZrbsvlCQxSYaZAqSgEX9EGHMhKFZa/csO
 wUQc4MbgXfe0NPbJyeVuCiv5RfbpjrIJNH7uu3FxNQUUt4wDpPCLIwhvmCXH0UKCGt4fE+I+Ax+a
 fw0aFo4mtHVEZfxgvoKNh4xU0Yz7ClpQzMgUXJgUaBCEPYlw5giz917+Bn0oKHJoZSOrL/TUmMGV
 eG072cFJsk8fkTXPJmywGgjGymxSNG7UWUwNW2sMY=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <5c36846b-26c6-42ec-8cc0-94a04eed9816@foxmail.com>
Date: Mon, 11 Sep 2023 08:51:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] binman: Fix SyntaxWarning: invalid escape sequence '\('
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 open list <u-boot@lists.denx.de>, Rong Tao <rongtao@cestc.cn>
References: <tencent_A957A85155C40E033B2189AC8CCB3995F607@qq.com>
 <CAPnjgZ1fWjL_qy+W4ygOvA2dDjK2v15zTJFkeNdqSSCDq8FuWQ@mail.gmail.com>
 <tencent_BA46C710370DF285E4B2EA2E35553A5FF909@qq.com>
 <CAPnjgZ12yLwPpo=8BBFmNOnz=RWykTtCzFOQyi11MgvS74QTcw@mail.gmail.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <CAPnjgZ12yLwPpo=8BBFmNOnz=RWykTtCzFOQyi11MgvS74QTcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Sep 2023 05:40:38 +0200
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

On 9/11/23 6:36 AM, Simon Glass wrote:
> Hi,
>
> On Tue, 5 Sept 2023 at 19:34, 荣涛 <rtoax@foxmail.com> wrote:
>> Thanks, Simon
>>
>> The following lines is my systeme ENV and make log
>>
>> $ cat /etc/os-release
>> NAME="Fedora Linux"
>> VERSION="40 (Workstation Edition Prerelease)"
>> ID=fedora
>> VERSION_ID=40
>> VERSION_CODENAME=""
>> PLATFORM_ID="platform:f40"
>> PRETTY_NAME="Fedora Linux 40 (Workstation Edition Prerelease)"
>> ANSI_COLOR="0;38;2;60;110;180"
>> LOGO=fedora-logo-icon
>> CPE_NAME="cpe:/o:fedoraproject:fedora:40"
>> DEFAULT_HOSTNAME="fedora"
>> HOME_URL="https://fedoraproject.org/"
>> DOCUMENTATION_URL="https://docs.fedoraproject.org/en-US/fedora/rawhide/system-administrators-guide/"
>> SUPPORT_URL="https://ask.fedoraproject.org/"
>> BUG_REPORT_URL="https://bugzilla.redhat.com/"
>> REDHAT_BUGZILLA_PRODUCT="Fedora"
>> REDHAT_BUGZILLA_PRODUCT_VERSION=rawhide
>> REDHAT_SUPPORT_PRODUCT="Fedora"
>> REDHAT_SUPPORT_PRODUCT_VERSION=rawhide
>> SUPPORT_END=2024-05-14
>> VARIANT="Workstation Edition"
>> VARIANT_ID=workstation
>>
>> $ uname -r
>> 6.6.0-0.rc0.20230901git99d99825fc07.3.fc40.x86_64
>>
>> $ gcc --version
>> gcc (GCC) 13.2.1 20230728 (Red Hat 13.2.1-1)
>> Copyright (C) 2023 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>
>> $ make qemu-x86_64_defconfig
>>    HOSTCC  scripts/basic/fixdep
>>    HOSTCC  scripts/kconfig/conf.o
>>    YACC    scripts/kconfig/zconf.tab.c
>>    LEX     scripts/kconfig/zconf.lex.c
>>    HOSTCC  scripts/kconfig/zconf.tab.o
>>    HOSTLD  scripts/kconfig/conf
>> #
>> # configuration written to .config
>> #
>>
>> $ make -j8
>> ... [too much logs]
>>    SYM     spl/u-boot-spl.sym
>>    OBJCOPY spl/u-boot-x86-start16-spl.bin
>>    OBJCOPY spl/u-boot-x86-reset16-spl.bin
>>    CAT     spl/u-boot-spl-dtb.bin
>>    COPY    spl/u-boot-spl.bin
>>    BINMAN  .binman_stamp
>> /home/sda/git-repos/u-boot/tools/binman/etype/section.py:25: SyntaxWarning: invalid escape sequence '\('
>>    """Entry that contains other entries
>>    OFCHK   .config
>>
> Thanks for that. What is your Python version?

Thanks Simon

$ python --version
Python 3.12.0rc1

>
> Regards,
> Simon

