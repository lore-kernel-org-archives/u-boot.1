Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA2FC3DA47
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 08:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B4D188641;
	Thu, 11 Jul 2024 10:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="laJ+Vu4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E62688709; Thu, 11 Jul 2024 10:33:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C1E88617
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 10:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e9d3=OL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1720686825;
 bh=Dvwx+lZeymEdwYDeVzCWZv0d+2n0lZmHt8V9tfZ2rEQ=;
 b=laJ+Vu4lyQcf08tSVWJsHt+8t83CygKvwaGjQPMhJEoxeTtr2/6tq9tFBsSvIIRhGYzyrGsXi
 3Cf5gPLFLGpy50mSezp70Z41f4bnSGMSK2h7QXjt4BbRrnTQldYulL6UgJ65elgG8CaoMVxGPA9
 m/o5R1qIgow0LTCLglRG4KtLRhPb7xhoSiX/Bzk/Wlof83OFM6dtsUBUILEKWSww5lFaDBEVtWH
 /51Cl9KMU7O4KOkudxqHqMUsK+li0pj1K6v4VlnEpEREO2o+kOrQsauxUWglNWrsxOKGHpmJcp7
 uT5XB2KL2ozCcuGGz7gW9j4ZgQi3hUAEixBplTdeiEBg==
Message-ID: <7e901715-35bb-43b9-9471-d8f4573cbf61@kwiboo.se>
Date: Thu, 11 Jul 2024 10:33:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: radxa cm3 2024.01 mmc write error
To: Belisko Marek <marek.belisko@gmail.com>
References: <CAAfyv37co294aQKffpt0ce=ajYutBrcnU23P=pi=s6YN5gT3Fg@mail.gmail.com>
Content-Language: en-US
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAAfyv37co294aQKffpt0ce=ajYutBrcnU23P=pi=s6YN5gT3Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 668f98e5dbd5dc0c2f1f3013
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

Hi Marek,

On 2024-07-10 21:26, Belisko Marek wrote:
> Hi,
> 
> I'm playing with radxa cme and mainline u-boot 2024.01 (present in
> scarthgap yocto).
> I realized that mmc write fails all the time like:
> => md.l $loadaddr
> 00c00800: ff7ff7eb fffdffff fffffff5 ffff9fff  ................
> => mmc write $loadaddr 1fc0 10
> 
> MMC write: dev # 0, block # 8128, count 16 ... mmc write failed
> 0 blocks written: ERROR
> 
> 1fc0 = 8128 is according to rockchip gpt table u-boot env partition.
> 
> Is there something I'm doing wrong or its regression?

Please try with latest U-Boot v2024.07, following fix has been part of
U-Boot since v2024.04-rc2.

rockchip: rk35xx: Remove use of eMMC DDR52 mode
https://source.denx.de/u-boot/u-boot/-/commit/ebe293bae79d8c64d9cd4284044e25ddadd074b5

Regards,
Jonas

> 
> Thanks and regards,
> 
> marek

