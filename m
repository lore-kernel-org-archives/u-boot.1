Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63114CA5509
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 08:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4EE869D8;
	Wed, 13 Sep 2023 10:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=goldsimon@gmx.de header.b="D1LM7QU8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526AD86AEB; Wed, 13 Sep 2023 10:32:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81BA86995
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 10:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=goldsimon@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694593940; x=1695198740; i=goldsimon@gmx.de;
 bh=kvq6pt5oqFnQLIKWy1D5nxBGe+CD7jk/ZdEMe43YXak=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=D1LM7QU8olTBYxoo166EWbOl3c5Gm9dEJMiEhoKx6qQMWmosk0A8RoYzWttrcRc9uC1NWj6CxwO
 LXDYNfze/yhMCM9AHnu/LrW5eHiVbMQIf4ZoVyg21GaROBIsuZUbxpi8FEw9QqlMGRLcyV/0NM7GV
 Si1dcEEnuxxPbpZGGwkOiqYTooaT73UXR0uFE9S157VybmnVauqSXTHsvu5JFyb9fQF1snEs2nbqd
 LutRAEyjgh3Gc3kXO7ZPO/WAGnMPsndYhDnVsQ3oM1RYZG05qFbS8Up1hX7QxzKatRSOlKDtef2lQ
 qX/oAIbfT2dwjTEtRDgO2qh/fb854iqESrHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.88] ([176.199.209.230]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1rPXwu2rBs-00jK97; Wed, 13
 Sep 2023 10:32:20 +0200
Message-ID: <d3513631-2831-b761-9b18-63bb7d077b15@gmx.de>
Date: Wed, 13 Sep 2023 10:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCHv8 03/15] net/lwip: implement dns cmd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-4-maxim.uvarov@linaro.org> <ZQFPEF85eOXtw8Qn@hera>
Content-Language: en-US
From: Simon Goldschmidt <goldsimon@gmx.de>
In-Reply-To: <ZQFPEF85eOXtw8Qn@hera>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zh8fBgLpRLlpnkViPP/BGO9Kac77Gn04a/hRY+6IKUlrwBAgbhN
 JOOAZgyNoyfJV9rj8GSNKoUsHgUIQTRKNc3vTPyRqlHkRsphbMul48drnn+u31hdY9R2OmR
 6WDj9ljNXV6cPDddjEJsILxcQrvQGC+TIi4f/ugp/IgnQnKhFhsMkAGqw8tk0P2eE0nsw2E
 dyhKEhe718DhpbL3cvT+g==
UI-OutboundReport: notjunk:1;M01:P0:Xr8ZKbUw44A=;F9h4sMc1MQjU09gi8gVBWC0Zk+3
 Ql0X1oG5pmblGWK3aDl6BO0aGuHFretbPuwUv2kssj1dMY98x+Q6VCo9eYxn7LUJzhR8n4A3r
 dD2QJLWQQlZsn0H+VzFqB+VZlRG50+amz4Gj2CfOD3GoI1tOlbAjq1F0mKY1w+Sb2ht2oQ1WL
 jzQvW2trWK2f0gNgF1D+HYBtjDvnsV1QpuTEJBMqSgadlyXrFySghZVuPwC8iNvscFPuR7k2G
 D8mXcxHvWPB260RI5Ilc1/3TIPaNSK4ORAUUYu0adf0eiPDwdjqFMFylVCKXuamg7kHOkXOIw
 k3MZNckmRWlNbqH1RSV5CADkFNFTMd0A+bNmN5J7zvGQVhcqR/UBaS07vPXJI0ug42FKUR3Dg
 bDjS+qL/wn25x7ec0nSKOCNyjF+2owCsY1R6NGSp6iT0ommKEKmew+PzdahfJl2xrR8UU5iqr
 P3bYV97l0E48uY83U8vZeSZo1vQsXro+PJTmo74trqc71/teBWeI/d49ldiy0rsrbbiBykWY2
 xF8zkkmbOnuHQkjcnmHokHPVX455703MAVDGAD8vhixs7jl/btTIVpDb1q1Ae/9PqnelAxzwK
 7+uINCUziXaf7eXbH9wZqBU9uP2IGvj5P3iOL7EVQ7dZVKU5fyjJhg9CgFxQuvrSAI8XU6Clx
 9VKKIbG6F68FPOG6PEMZPD+hfS+FHvay/6I/uL3ZLvw+f6jkI5qC9efzYMDPkd+pK43rrCix7
 jrceS3Vsuz/T4NYUJDejRV+5qJlkDYYO3olOToVcq+BbktREILlaEHYUm8J/cZ1ldjCFALnnZ
 AYOyQfbDRFx3I4aaLS/pPF0THs6hE3o2VwlCk/9TmI9oU1rCaEZ2huKc36SCI6ZtxxaX4r8lv
 n44imxwnixf3Km+By+46Pk+zptI10C5a5VmAfZQ1XuZcrR1z+OS7DnkLkSvVE2xUyKWd14U0c
 KjC1g/GKSwYbeVGN1b5i1qPc8Cs=
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



On 13.09.2023 07:56, Ilias Apalodimas wrote:
> On Fri, Sep 08, 2023 at 07:53:08PM +0600, Maxim Uvarov wrote:
>> U-Boot recently got support for an alternative network stack using LWIP=
.
>> Replace dns command with the LWIP variant while keeping the output and
>> error messages identical.
>>
>> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>> ---
>>   include/net/lwip.h           | 19 +++++++++++
>>   net/lwip/Makefile            |  2 ++
>>   net/lwip/apps/dns/lwip-dns.c | 63 +++++++++++++++++++++++++++++++++++=
+
>>   3 files changed, 84 insertions(+)
>>   create mode 100644 include/net/lwip.h
>>   create mode 100644 net/lwip/apps/dns/lwip-dns.c
>>
>> diff --git a/include/net/lwip.h b/include/net/lwip.h
>> new file mode 100644
>> index 0000000000..ab3db1a214
>> --- /dev/null
>> +++ b/include/net/lwip.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
>> +		char *const argv[]);
>> +
>> +/**
>> + * ulwip_dns() - creates the DNS request to resolve a domain host name
>> + *
>> + * This function creates the DNS request to resolve a domain host name=
. Function
>> + * can return immediately if previous request was cached or it might r=
equire
>> + * entering the polling loop for a request to a remote server.
>> + *
>> + * @name:    dns name to resolve
>> + * @varname: (optional) U-Boot variable name to store the result
>> + * Returns: ERR_OK(0) for fetching entry from the cache
>> + *          -EINPROGRESS success, can go to the polling loop
>> + *          Other value < 0, if error
>> + */
>> +int ulwip_dns(char *name, char *varname);
>> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
>> index 3fd5d34564..5d8d5527c6 100644
>> --- a/net/lwip/Makefile
>> +++ b/net/lwip/Makefile
>> @@ -62,3 +62,5 @@ obj-$(CONFIG_NET) +=3D lwip-external/src/netif/ethern=
et.o
>>
>>   obj-$(CONFIG_NET) +=3D port/if.o
>>   obj-$(CONFIG_NET) +=3D port/sys-arch.o
>> +
>> +obj-y +=3D apps/dns/lwip-dns.o
>> diff --git a/net/lwip/apps/dns/lwip-dns.c b/net/lwip/apps/dns/lwip-dns.=
c
>> new file mode 100644
>> index 0000000000..b340302f2c
>> --- /dev/null
>> +++ b/net/lwip/apps/dns/lwip-dns.c
>> @@ -0,0 +1,63 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
>> + */
>> +
>> +#include <common.h>
>> +#include <command.h>
>> +#include <console.h>
>> +
>> +#include <lwip/dns.h>
>> +#include <lwip/ip_addr.h>
>> +
>> +#include <net/ulwip.h>
>> +
>> +static void dns_found_cb(const char *name, const ip_addr_t *ipaddr, vo=
id *callback_arg)
>> +{
>> +	char *varname =3D (char *)callback_arg;
>> +	char *ipstr =3D ip4addr_ntoa(ipaddr);
>> +
>> +	if (varname)
>> +		env_set(varname, ipstr);
>> +	log_info("resolved %s to %s\n",  name, ipstr);
>> +	ulwip_exit(0);
>> +}
>> +
>> +int ulwip_dns(char *name, char *varname)
>> +{
>> +	int err;
>> +	ip_addr_t ipaddr; /* not used */
>> +	ip_addr_t dns1;
>> +	ip_addr_t dns2;
>> +	char *dnsenv =3D env_get("dnsip");
>> +	char *dns2env =3D env_get("dnsip2");
>> +
>> +	if (!dnsenv && !dns2env) {
>> +		log_err("nameserver is not set with dnsip and dnsip2 vars\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	if (!dnsenv)
>> +		log_warning("dnsip var is not set\n");
>> +	if (!dns2env)
>> +		log_warning("dnsip2 var is not set\n");
>> +
>> +	dns_init();
>> +
>> +	if (ipaddr_aton(dnsenv, &dns1))
>> +		dns_setserver(0, &dns1);
>> +
>> +	if (ipaddr_aton(dns2env, &dns2))
>> +		dns_setserver(1, &dns2);
>
> env_get will return NULL if any of these is not set.  Looking at
> ipaddr_aton() of lwip that might lead to a NULL deref in ip_2_ip6()

Looking at the NULL checks in ipaddr_aton(), you found a bug in lwIP.
I'd vote to leave the above code as is and rely on the bug being fixed
in lwIP before U-Boot enables IPv6 (this is only a bug in dual-stack
mode where IPv4 and IPv6 is enabled).

Regards,
Simon

>
>> +
>> +	err =3D dns_gethostbyname(name, &ipaddr, dns_found_cb, varname);
>> +	if (err =3D=3D ERR_OK)
>> +		dns_found_cb(name, &ipaddr, varname);
>> +
>> +	/* convert lwIP ERR_INPROGRESS to U-Boot -EINPROGRESS */
>> +	if (err =3D=3D ERR_INPROGRESS)
>> +		err =3D -EINPROGRESS;
>> +
>> +	return err;
>> +}
>> --
>> 2.30.2
>>
