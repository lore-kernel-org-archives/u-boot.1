Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D13CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 12:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D31986FD5;
	Fri, 20 Oct 2023 14:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697806220;
	bh=2MrokaNCUokWgSiKCj5QOFlrfzTD94GYQOVbC6ptqJE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wTXWfA8AvFj3RUFMRAkhp0NO//AcY5tACXH1acuCLBtDSrHafuAiNGn0fgqd0GrWG
	 bb/qfRy2qbGKIiptT1502iZS+7yMm8+00mJNVZIBqj2q2hQDDZaC03TMTq50bnlTKw
	 jtNfDOPJrYJk6NR/knhGpbRAYB7kniJ6yZXeKoudE0zzVuMx4PbtLC9C4f1dHZHZzy
	 ImUkMbX/YZmcj9sicNDNjQdlniqfikBzkoMhWVhekK6BL3wuwy4hml5dtklCdGn4mu
	 D7+yrcgNeNkDGMsejN08uSGHOxTbyWU7F/vr8U+2jMRmVrqMYPH+2X5NcaNLnjk3+R
	 ENoDT+kdwNJkA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0722B86F5F; Fri, 20 Oct 2023 14:50:20 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F63586FEA
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SBkvX1Rz7z9t4s;
 Fri, 20 Oct 2023 14:50:16 +0200 (CEST)
Message-ID: <40436568-f7d7-4020-a26b-a0bf2a10dff0@denx.de>
Date: Fri, 20 Oct 2023 14:50:15 +0200
MIME-Version: 1.0
Subject: Re: [RESEND PATCH] arm: kirkwood: Pogo v4: Enable LTO
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20231016200142.21631-1-mibodhi@gmail.com>
 <08efdf86-8617-4873-b377-7895132de107@denx.de>
In-Reply-To: <08efdf86-8617-4873-b377-7895132de107@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4SBkvX1Rz7z9t4s
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

On 10/20/23 08:14, Stefan Roese wrote:
> On 10/16/23 22:01, Tony Dinh wrote:
>> Enable building Pogo V4 u-boot image with LTO, which results in about 30K
>> reduction in size.
>>
>> Rebased to latest master and resend.
> 
> Nitpicking:
> 
> In such cases, please generate a v2 and put this description in the
> patch history below the "---" line. No need to do this now, I'll fix
> it up.
> 
>> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> 
> Reviewed-by: Stefan Roese <sr@denx.de>

Applied to u-boot-marvell/master

Thanks,
Stefan


> Thanks,
> Stefan
> 
>> ---
>>
>>   configs/pogo_v4_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
>> index cbbade3c0c..fd62146ed3 100644
>> --- a/configs/pogo_v4_defconfig
>> +++ b/configs/pogo_v4_defconfig
>> @@ -15,6 +15,7 @@ CONFIG_ENV_OFFSET=0xC0000
>>   CONFIG_DEFAULT_DEVICE_TREE="kirkwood-pogoplug-series-4"
>>   CONFIG_IDENT_STRING="\nPogoplug V4"
>>   CONFIG_SYS_LOAD_ADDR=0x800000
>> +CONFIG_LTO=y
>>   CONFIG_PCI=y
>>   CONFIG_DISTRO_DEFAULTS=y
>>   CONFIG_BOOTSTAGE=y
> 
> Viele Grüße,
> Stefan Roese
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
