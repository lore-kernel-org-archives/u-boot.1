Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93693D3B9B7
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 16:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E3F8972F;
	Tue, 26 Nov 2024 17:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Oo/w/LMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F158972F; Tue, 26 Nov 2024 17:16:52 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F8D895EC
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 17:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5450D3F215
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732637808;
 bh=mRvirHOyJcgvkNCPR+hkfFBK0N7TrIxzrtJQ3zAuETQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Oo/w/LMX9JyQt0wifd5AXAzEueyDLIaCtUSkt+MHKI5ow8OIeWrCn25Wkv30VY7Dr
 fhE1CtwfpdvXY+BM1JYdTC0KSLHV9LZC/33EOC7+/CeA3AlGDbMplBFR5iz6/HiqO8
 7zfiBYQCSNaRHMiEHIVYFE04+XB4prfZ+yU90yndL7e1FWBxlBi2rtS7DK3Ll+R6MI
 4RuMMK5s/2LUwM7XfRmnor2mLgNEFPuQHSPKxjQsKTlInVNKafp0XDJnBhsyoXhl5D
 kE4xWBRJZ2LHlQ8o1Bh142N8t1tpaV4OdWVZc+XUSzNwW/9Q+b3Lpy++huAhAsFzwu
 96MlajP+ZEV5A==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434a0bf9914so15786315e9.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732637808; x=1733242608;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mRvirHOyJcgvkNCPR+hkfFBK0N7TrIxzrtJQ3zAuETQ=;
 b=pXMmaD2vZNbyM7vxHiyTLmGonUH1I0TD7fLQHafdTcJJf4n8A9UYlrtYwvEM5iR6+l
 Q7vAQBz6bu9XsMft3j22b+yNl2wayCqfGTQKFmUUOo5PBXDB+FWYPVlvMfYDrlqm6FZ9
 zeVrYu+Qe1rZRgQdobzwfkUyVVyyUWRyzKzF1IxEfT74HL6QjTImY9tvJDdYowRJUPTY
 gRdEKh/TZV0o6ojBsg4ZUnW0BigJS5N0Q9PStUNjCteLdxkY7K11je5QuQohqUHdoXck
 6qtA1qPzvK8SlVvnhwvK+rsAM0gNpiZeR2UN386HHUUMivOTto1k6nUM8fZpKAl0EqVE
 Y2BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2XNozUOlcX5HVhfZqgRTUQlBqk5cbdrdRy25qWRxnTNGVWb3nQvRv6WjqEKEff8wF0GhUrC4=@lists.denx.de
X-Gm-Message-State: AOJu0YxRxQIlCmOnWTajP80Xr5oEGb8wnaGM2aDZTXelgv/m3jwIyeXj
 33RtNocOJLtAovmopwPcxVdCYbDZ3P2k3SILbIZwiwk6+femALkWvhh4fi6Yvp1HXPnUZ5v9CnG
 bluEL+htojrxiQeSgvQ54XvPRczRsD49HcSGzvvWyh0nKnzYl+ZiQ4gdzI9sM2ISEcXQ=
X-Gm-Gg: ASbGncsXU90kFUw2zK+voZc8j0F/RCif6XyvfvaMgfWz7YRiQPcWjm1XRdehwzaQvs4
 S6BNph7AqZNWKWY0AJiFmisMXnSGTRHYpE6SDS6bmzKbeXh8xT1UhooPI7MTla+b0ERnIM1WI9y
 KuBePiwZz+l3AnT4dvyZeEE0v72G02IRapCukJiHFYLnnC10zA1WkgCzrEWum4IyS+t6SZ6UyhN
 FkXJa7fpUnyQODKGnK2W9asobJL3mM2O56F+ZdGBF59Sqo4u8lSVVWXGz2fINL2yTG0CaPq8tDV
 fTGm1Sesgh7vDSWLYaoCemvvgxTysL7Xh97nGHJ4
X-Received: by 2002:a05:600c:1f85:b0:431:5ce4:bcf0 with SMTP id
 5b1f17b1804b1-433ce428100mr166011025e9.15.1732637807943; 
 Tue, 26 Nov 2024 08:16:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCrT0ymjpMTmlD2pWwbxy8jF/UG3x+nsh4KVcVZ5MVjkUVfiD+o3CMBoEKy0pbxhe70JyB7A==
X-Received: by 2002:a05:600c:1f85:b0:431:5ce4:bcf0 with SMTP id
 5b1f17b1804b1-433ce428100mr166010645e9.15.1732637807601; 
 Tue, 26 Nov 2024 08:16:47 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:b920:5c3d:9b8a:b7bb:8983?
 ([2a02:3035:6e0:b920:5c3d:9b8a:b7bb:8983])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafe207sm13743028f8f.36.2024.11.26.08.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:16:46 -0800 (PST)
Message-ID: <5c80bb06-28fd-47c6-a249-55237a81d4a6@canonical.com>
Date: Tue, 26 Nov 2024 17:16:44 +0100
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiCv3zdeg+1vNKY__iYmdZgVs4E=GXT6Y2DYCGQOi4RzA@mail.gmail.com>
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

On 26.11.24 16:38, Simon Glass wrote:
> Hi Heinrich,
> 
> On Tue, 26 Nov 2024 at 00:42, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 11/26/24 01:32, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Sat, 23 Nov 2024 at 14:46, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> eth_bootdev_hunt() should not execute dhcp_run() as this itself would load
>>>> a file and boot it if autostart=yes.
>>>>
>>>> Instead just check that there is a network device.
>>>
>>> If you look at dhcp_run() you will see an 'autoload' parameter. This
>>> is 'false' in this code, so it never loads a file.
>>
>> This is not the complete truth.
>>
>> If $autostart=true and CONFIG_NET=y, dhcp_run(false) still tries to load
>> a file.
> 
> Here is the code:
> 
> int dhcp_run(ulong addr, const char *fname, bool autoload)
> {
> char *dhcp_argv[] = {"dhcp", NULL, (char *)fname, NULL};
> struct cmd_tbl cmdtp = {}; /* dummy */
> char file_addr[17];
> int old_autoload;
> int ret, result;
> 
> log_debug("addr=%lx, fname=%s, autoload=%d\n", addr, fname, autoload);
> old_autoload = env_get_yesno("autoload");
> ret = env_set("autoload", autoload ? "y" : "n");
> if (ret)
> return log_msg_ret("en1", -EINVAL);
> 
> It respects the autoload parameter. If there is a bug in that, we
> should fix it, but it seems to work OK to me. Please fix your commit
> message.

The cited code only sets "autoload". It does not adjust "autostart".

As I have shown below this leads to trying to boot via DHCP.

This is exactly what the commit message says: "load a file and boot it 
if autostart=yes".

> 
>>
>> In all cases dhcp_run() wastes boot time.
> 
> Yes, it uses time. With bootstd the hunters are only called as needed.
> In your case you are calling all of them at once.
> 
> Is there a way to just call hunters which relate to block devices, perhaps?

We need to probe network to provide the simple network protocol 
(lib/efi_loader/efi_net.c) but we don't need to execute DHCP.

We also need the correct device-tree provided by the extension hunter.

Best regards

Heinrich

> 
>>
>> CONFIG_NET=y
>> => dhcp_run
>> BOOTP broadcast 1
>> BOOTP broadcast 2
>> BOOTP broadcast 3
>> DHCP client bound to address 10.0.2.15 (1004 ms)
>>
>> => setenv autostart true
>> => dhcp run
>> BOOTP broadcast 1
>> BOOTP broadcast 2
>> BOOTP broadcast 3
>> DHCP client bound to address 10.0.2.15 (1002 ms)
>> Using e1000#0 device
>> TFTP from server 10.0.2.2; our IP address is 10.0.2.15
>> Filename 'run'.
>> Load address: 0x40200000
>> Loading: *
>> TFTP error: 'File not found' (1)
>> Not retrying...
>>
>> CONFIG_NET_LWIP=y
>> => dhcp_run
>> DHCP client bound to address 10.0.2.15 (1007 ms)
>>
>> Where command dhcp_run is provided by:
>>
>> #include <command.h>
>> #include <env.h>
>> #include <net-common.h>
>> #include <vsprintf.h>
>>
>> static int do_dhcp_run(struct cmd_tbl *cmdtp, int flag, int argc,
>>                     char *const argv[])
>> {
>>           ulong addr = hextoul(env_get("loadaddr"), NULL);
>>
>>           dhcp_run(addr, NULL, false);
>>
>>           return 0;
>> }
>>
>> U_BOOT_CMD(
>>           dhcp_run,       CONFIG_SYS_MAXARGS,     1,      do_dhcp_run,
>>           "dhcp_run",
>>           NULL
>> );
> 
> See above
> 
> [..]
> 
> Regards,
> Simon

