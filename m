Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A54107BCEA
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 23:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218CE84324;
	Sat, 14 Mar 2026 00:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="OcUS9Hrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E7DC8435B; Sat, 14 Mar 2026 00:00:28 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E86AC84319
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 00:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1773442804;
 bh=AN4NkEY9YwmbVhps9uEmovLlari6l01IzjnBMdNdnqk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OcUS9HrkZ2OnS+MGxUFnqomcHLDX4G507MDiIZ58Ntmxe8cQ8uekNfBpA3l01o4pN
 bGSZyUVu6TVpN2wzIOi3Uk4Hi2YxVhmkzsx4P/GLHJb/f5qXZ+3U93jHGq5lZzdjIi
 17Bj2kDnMsoiUEWiD9AlpXwz3zjwwFO6qZxl4j8FoUmsrCpaIcVbYcHrPAyargnWAR
 xg3L7rpNwGXgSgAGXmT5Rs+DxwjV7ypmqvVy2kwRZOtJNRSn5CDf1vQewgAE2MSYND
 Mh7MPqbxsAYix2DqESjZWA4b19rgpJxxH4TTZ1GMNIg5J750udPWFAuMSUiwbq3hU3
 AFtOZQi3SJMcQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id D5C6AB221449;
 Sat, 14 Mar 2026 00:00:02 +0100 (CET)
Message-ID: <5cbcf317-f36e-4c57-9a97-0b5f27bf17df@freeshell.de>
Date: Fri, 13 Mar 2026 15:59:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT,PULL] u-boot-riscv/next
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Leo Liang <ycliang@andestech.com>
Cc: rick@andestech.com, nick.hu@sifive.com, jimmy.ho@sifive.com,
 schwab@suse.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <abNxIFSAFWMgeEEf@swlinux02>
 <177342068508.1062380.5101081635850084640.b4-ty@konsulko.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <177342068508.1062380.5101081635850084640.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Leo, and Tom,

On 3/13/26 09:52, Tom Rini wrote:
> On Fri, 13 Mar 2026 10:06:24 +0800, Leo Liang wrote:
> 
>> The following changes since commit 8bc2a5196c1c0bb5dbdaca073323da0015a0de37:
>>
>>   arm: k3: Kconfig: Enable fTPM and RPMB support (2026-03-10 12:35:18 -0600)
>>
>> are available in the Git repository at:
>>
>>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
>>
>> [...]
> 
> Merged into u-boot/next, thanks!
> 

Did we get a resolution on applying Hal's series to add support for
VisionFive 2 Lite ?  ref.:
https://lore.kernel.org/u-boot/20260214145634.GQ2747538@bill-the-cat/

-E
