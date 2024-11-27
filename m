Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169ABD6ACD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C037288E81;
	Wed, 27 Nov 2024 14:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KUmZ5O/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C3D789775; Wed, 27 Nov 2024 14:43:00 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E273E88C8F
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 80009402F0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732714977;
 bh=LjUz8qqOnCz1ACWXETNagBRMhXeVdK/rDgdZHbQWpa8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=KUmZ5O/X1Xvmf/2puobf4Hu34+kTdenoNbonRvQWCN9SNnUiMjaIt9rfGNWXuX3aK
 g2HLNuv2qZD8nQir6Bheh25hyvkVyLM8FOKVK7IrRIFiUUc2sdsTKon4QkRDywxx3v
 9wP+1DOcfilSRguN741z4SySMMm5a+i6+UOdrBkrQv/d3DLs/w0Z/QYDiykRph8uPz
 ytpA/hFGAj7POwzXUHhtvio3RY1n8IT7CuqeVeWc3AxxMiLKVXc3mOmuWfXWKT7jrA
 sHdU0PoAtNlpbqd6ktE8C0Ad0NWLyhyHWt0zFGh90JIZsfnwyqEjrIoc75rLBPFkA7
 W+SHs7JdANsgA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4349df2d87dso34534915e9.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732714977; x=1733319777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LjUz8qqOnCz1ACWXETNagBRMhXeVdK/rDgdZHbQWpa8=;
 b=jRn9JpHSPOycgrzkdOIeZ2Zxn5hFFis+SWrmuFWar3Pyc5bxDgt8hSTW2B1tQWW5fr
 OFL0xum4zzo1Fxa0j0tMZzQrTiHmK02fvpVfmWrW5n9a8xl/1GYH9y1/4ptbvMHJX7wX
 GjdjgVlIaUseLJsl19NROZI82d/f3Fq1TYlgWA3uM+xsGoUqsrILL9vMwoJ/dhvKUWrv
 znJ/lDZcBy9PRcnEfV/KQKw3jFcgqGZ72sbsSHEkiK1Z1ukRzCDqKrFU/92tQu92trtS
 ruxRHsQI8RJ0pyNMj7sNTQzwlAAHWTIlOiVazCpXKMAWRg7zHiLSm03an3YZGA5rwkkm
 ynww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGkBwxGSZutiR8G7UmeXHNPZdxBxfISeKFCnDwt3no2HKTB/aDdwiveIX5gtaCmrqFC27Tk6o=@lists.denx.de
X-Gm-Message-State: AOJu0YwKPO8FtrTKIEeaPngPm7r53tTLSCO8x2Nu8JiR11LV4lmdSoxq
 lrQKRySw0x0bWZ3EzktLES+U3p3ICfk2cVwGYm25OYEEXI3Tcas3P2DSZUH3YzwllqasuEJAyIE
 +dbDs6swHofiNgJbouWEAelt3/KnNR/UxNHEQ7Wb5ECp0e8/OSJdi5Gp//LrSMW/izYg=
X-Gm-Gg: ASbGnctFA1QoWDoHSSEE38CH/I8Kt8XPdL31+ABBeCZl5U/eJwa3+3h2+c+liso0P8P
 wgiSlKOMTCS8G5ASqxwp5fI40UzG81YPAT7USUznIuXKRhE2yBqmAuWK4v11UKxddsmKqb9LTjw
 nlwUGjRufACqjMu1ACK4hve+9bb3xhVXdSTVh2H9BViF3DFpkueTxAoK5bIki2CRlZQ1EtsCQq1
 Z8v7i2JwNnXiR5NHPzRYfPTL36cZVNsQltD/3VGAli8vCgldieSex1gThRJYmyYfVPJ7Pc5s9SJ
 oA4unwwh4LEk0kLubqD7KaWrNigI0kz/v+ZyU8p+
X-Received: by 2002:a5d:64a7:0:b0:382:4978:2a93 with SMTP id
 ffacd0b85a97d-385c6ccae9emr2966906f8f.12.1732714976839; 
 Wed, 27 Nov 2024 05:42:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo8kh7wjf+r9xpeuLUvPWIRBiwD66lK9MB/kFgkgp48+G50vAa/ICuEniYFOxdcwAzydFb8Q==
X-Received: by 2002:a5d:64a7:0:b0:382:4978:2a93 with SMTP id
 ffacd0b85a97d-385c6ccae9emr2966878f8f.12.1732714976488; 
 Wed, 27 Nov 2024 05:42:56 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:b718:b90b:9391:e0a8:69cc?
 ([2a02:3035:6e0:b718:b90b:9391:e0a8:69cc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc415asm16718265f8f.75.2024.11.27.05.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 05:42:55 -0800 (PST)
Message-ID: <9e572f07-9cd4-472e-a6f0-acf4c38ec982@canonical.com>
Date: Wed, 27 Nov 2024 14:42:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] net: eth_bootdev_hunt() must not try to boot
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-5-heinrich.schuchardt@canonical.com>
 <CAFLszTgNguURurFAnX4W4mw8_Fokj2iCQOw15MCnFtT_zea6hw@mail.gmail.com>
 <f7706753-d4bc-484a-bf5d-f4b85205ac8e@canonical.com>
 <CAFLszTiCv3zdeg+1vNKY__iYmdZgVs4E=GXT6Y2DYCGQOi4RzA@mail.gmail.com>
 <5c80bb06-28fd-47c6-a249-55237a81d4a6@canonical.com>
 <CAFLszThH5i2cmf0WH_X2BYonMUHWbMHkUmCL-mgLO1SvbKjQEg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszThH5i2cmf0WH_X2BYonMUHWbMHkUmCL-mgLO1SvbKjQEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 27.11.24 14:08, Simon Glass wrote:
> Hi Heinrich,
> 
> On Tue, 26 Nov 2024 at 09:16, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 26.11.24 16:38, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Tue, 26 Nov 2024 at 00:42, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> On 11/26/24 01:32, Simon Glass wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>> On Sat, 23 Nov 2024 at 14:46, Heinrich Schuchardt
>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>
>>>>>> eth_bootdev_hunt() should not execute dhcp_run() as this itself would load
>>>>>> a file and boot it if autostart=yes.
>>>>>>
>>>>>> Instead just check that there is a network device.
>>>>>
>>>>> If you look at dhcp_run() you will see an 'autoload' parameter. This
>>>>> is 'false' in this code, so it never loads a file.
>>>>
>>>> This is not the complete truth.
>>>>
>>>> If $autostart=true and CONFIG_NET=y, dhcp_run(false) still tries to load
>>>> a file.
>>>
>>> Here is the code:
>>>
>>> int dhcp_run(ulong addr, const char *fname, bool autoload)
>>> {
>>> char *dhcp_argv[] = {"dhcp", NULL, (char *)fname, NULL};
>>> struct cmd_tbl cmdtp = {}; /* dummy */
>>> char file_addr[17];
>>> int old_autoload;
>>> int ret, result;
>>>
>>> log_debug("addr=%lx, fname=%s, autoload=%d\n", addr, fname, autoload);
>>> old_autoload = env_get_yesno("autoload");
>>> ret = env_set("autoload", autoload ? "y" : "n");
>>> if (ret)
>>> return log_msg_ret("en1", -EINVAL);
>>>
>>> It respects the autoload parameter. If there is a bug in that, we
>>> should fix it, but it seems to work OK to me. Please fix your commit
>>> message.
>>
>> The cited code only sets "autoload". It does not adjust "autostart".
>>
>> As I have shown below this leads to trying to boot via DHCP.
>>
>> This is exactly what the commit message says: "load a file and boot it
>> if autostart=yes".
> 
> Oh, I just thought they were the same and I didn't remember about autostart
> 
>>
>>>
>>>>
>>>> In all cases dhcp_run() wastes boot time.
>>>
>>> Yes, it uses time. With bootstd the hunters are only called as needed.
>>> In your case you are calling all of them at once.
>>>
>>> Is there a way to just call hunters which relate to block devices, perhaps?
>>
>> We need to probe network to provide the simple network protocol
>> (lib/efi_loader/efi_net.c) but we don't need to execute DHCP.
>>
>> We also need the correct device-tree provided by the extension hunter.
> 
> It would be good to get some use of that, as it has no tests really.
> 
> As I ask on the other patch, why do you need to probe?

You asked on the Network protocol.

If your idea is that the concept of extensions is not yet deployed, is 
there a good way to exclude BOOTDEV_HUNTER(extension_bootdev_hunter)?

Best regards

Heinrich

> 
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>>>
>>>> CONFIG_NET=y
>>>> => dhcp_run
>>>> BOOTP broadcast 1
>>>> BOOTP broadcast 2
>>>> BOOTP broadcast 3
>>>> DHCP client bound to address 10.0.2.15 (1004 ms)
>>>>
>>>> => setenv autostart true
>>>> => dhcp run
>>>> BOOTP broadcast 1
>>>> BOOTP broadcast 2
>>>> BOOTP broadcast 3
>>>> DHCP client bound to address 10.0.2.15 (1002 ms)
>>>> Using e1000#0 device
>>>> TFTP from server 10.0.2.2; our IP address is 10.0.2.15
>>>> Filename 'run'.
>>>> Load address: 0x40200000
>>>> Loading: *
>>>> TFTP error: 'File not found' (1)
>>>> Not retrying...
>>>>
>>>> CONFIG_NET_LWIP=y
>>>> => dhcp_run
>>>> DHCP client bound to address 10.0.2.15 (1007 ms)
>>>>
>>>> Where command dhcp_run is provided by:
>>>>
>>>> #include <command.h>
>>>> #include <env.h>
>>>> #include <net-common.h>
>>>> #include <vsprintf.h>
>>>>
>>>> static int do_dhcp_run(struct cmd_tbl *cmdtp, int flag, int argc,
>>>>                      char *const argv[])
>>>> {
>>>>            ulong addr = hextoul(env_get("loadaddr"), NULL);
>>>>
>>>>            dhcp_run(addr, NULL, false);
>>>>
>>>>            return 0;
>>>> }
>>>>
>>>> U_BOOT_CMD(
>>>>            dhcp_run,       CONFIG_SYS_MAXARGS,     1,      do_dhcp_run,
>>>>            "dhcp_run",
>>>>            NULL
>>>> );
>>>
>>> See above
>>>
>>> [..]
>>>
>>> Regards,
>>> Simon
>>
> 
> Regards,
> Simon

