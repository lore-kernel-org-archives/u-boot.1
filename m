Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C03606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lLBN9gug;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=A+Rzd5uW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC32E4060E;
	Thu, 22 Oct 2026 08:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 53BoWRnP2HXL; Thu, 22 Oct 2026 08:44:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 15CC5405A7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792658681;
	b=tY9fMbhVynGUN6GJRXmyL0H5gQoAiFHiXCEsqG5jKizb+qUI+3J31N1ihVP1+1Dic7Dk
	 ypFqddhYV7x0iAFVAtawCQn95sBzGegbU7m3H3PF8HyHJm1GsUtNER6CFFsJ5ju/UlrW7
	 IE9/g/PNu3hvj2fVFib5GG1G9SQMkbvD7EMxhUWJjlLoiwj3J1AJaGaPj75thY86/Puav
	 YDgj5BfrijJ41sqzctciWFtjSGlY8e/72xLYj+Vrf67guD2G26wDN/ojKZ6NL2I4ldnN0
	 aGDdk+BvZIQq4Lh3m71zpowhkEMF4945becQhphpb2AGeVbOi2JwPx51yLiHgWrp+wA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792658681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qzkHx/0BuOqOtwaPJaC75vzQxVazP26f2YXETSDGToo=;
	b=C5F96xvUc/+z/ELbc2CmYowOl78PBBximOXE/SKRoY9f/i1Fm1kM4cpMk/CU3zYqW6+K
	 nJDzVrEaGP8xqv1yc8ZnfPOR60K1MmotuQEIoz7M1h2WDO3Qck+FlJENj4TJmAcLICzZ0
	 RsUlrcal1fKbLJdF90EjluOK/MHZ5m1apXhvDfZfpDRDGh3zoMoI6QVMllmJXYi55x1tI
	 S5gN45ei0E2WCyOyBkJEKm93tsil0Fsc7EMbusX8hjwopc+lg5gzLO64jvsWCcgCPci3L
	 l0rgunfIxzOANPvo9yJUoMDRlT6velK8cY2gO6rJZhtv5TWBcb8t3b988V/oPkcD62w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=A+Rzd5uW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792658681;
	bh=qzkHx/0BuOqOtwaPJaC75vzQxVazP26f2YXETSDGToo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lLBN9gugEn+yw/Ai8xWWaNdllzO2gfA2f0nhRR3Wom6ZNKhSpHNoZlyZqRPWYlbq6
	 s6VHrYdmUnQeAZK31alGS84hyCrX/6PO8nrc4eMTfapnI+FzmFW/yYNqwC7A7OOzTZ
	 Dqs6xBUTILfe9fdku3Sh+zMlLeb34U01i4AedD7uHx4TkWlopY6g1/v2kVONRpq6sC
	 qs0qm2ZXyDY9Cr2rI5119wC5OsX/u61I4a2r2NkyXtI3kWgEQ5KZFr9WnJcArk55/e
	 5JySlLhOzv5xlmIqFE3PIi9Sly2vkUuLepuLO2fswDJGzkPJke+l+5gANMbYRHCX1M
	 i62bIramzr+jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15CC5405A7;
	Thu, 22 Oct 2026 08:44:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C4BC371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DE97405A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:44:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sq7B6RfpZBhV for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:44:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3726F40583
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792658678;
 b=WD12UaLcioUdaYO+b2OPwbflgNU7cb/X4Z0FUYTXAKKVeFGXeHuSxOzoV3vFuaUg2rzT
 uzk/YGrsRta02iy+PD95zcA3eWYnS+05luPEzJTIXqjuFkfxLhspK1+2TShmwFaxMxyBo
 KLpQfGw3CGdFB+aT4nS+MPe4ZH3vCZQIB5Q7ojA1lP/k08ag9bJl/YRChuLDmfqLr5fi9
 afsqT0iB9BXZUZNvcheKN3aBKQHL4K2YW5tofRqkI7XSYCNhPxDEI73F8TDmVvJMadbLa
 athXmyYjkUBcsH1jrLLJoXkEmvwNJc/YqPNqhTBjttGEI+RQ4sZC0xPh8MWmIDa6KyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792658678;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=qzkHx/0BuOqOtwaPJaC75vzQxVazP26f2YXETSDGToo=;
 b=cw9T2skLGP/xUj/jrLHw16b85luDq9ne28srzfvrBLxXaFwly/LpFAf7B0oQLS7zCXFy
 LAvKo5krZuYANenR1o0aI9eSypqWshCXY8e5zn+7F2ntM7IewCb52Onu/nBMQp7xxS7VP
 uBQ+tfhI0ngwpLvmKT1kC1PRb24mU1CRpfVIZ3c0DfAVg4c2XZHjXbF80s0/pk4+cR3kl
 C36SxmwkGHUZ8910Me5RsSUiFrwW+uvddCg5HOpnPhOSazZD9TS31Sm/rU9rMErQp9N6a
 8V+mb9Nan9mwrSTYFtDpNJ13FM9xVNcMYW6Xzg2DgBWlbYFAoY+DjBZYF+0/DyBO9vQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=A+Rzd5uW; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=bastien.curutchet@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=A+Rzd5uW
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3726F40583
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:44:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0BC3D1A12B9
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:44:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CBAAE60360;
 Thu, 22 Oct 2026 08:44:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BF7BC10328D8B; 
 Thu, 22 Oct 2026 10:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792658674; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=qzkHx/0BuOqOtwaPJaC75vzQxVazP26f2YXETSDGToo=;
 b=A+Rzd5uWeNeXrlSk0A18V72EF8SqCaAE/xauMM+R8OhsSOnhKvTe52UQUcBl6ojP+BwC0/
 Q8MRx1iTbdT2zWMZ25iFRsqirCJA0OI1Izo/sp/FB2/rQ+CH7xhCu+s6mf/KFIEFr7OJdz
 TZRzNnuvxm+phFmTNIXsydRui2JfSK+aFd9rzQQu92lxv47Jmkx+J5wU/XLWJhUipQEXcT
 wsYlqYIpUbLE3CmRfcUrHsi4cBl4TuzJNN+VSb8xJ8AZoeEudSoLkE61UrLp9xjnKZg4F4
 vwPwDjNJzANfV2pfhfOhKUNyyZ5rdsYr6maI00R4G3UOTzcMPaKpfWLtXtOZQg==
Message-ID: <45b86d7a-15d3-4e5f-98b1-399d87c5470f@bootlin.com>
Date: Thu, 22 Oct 2026 10:44:30 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
To: takahiro.kuwano@infineon.com, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>,
 Fabio Estevam <festevam@nabladev.com>, Eugen Hristev <ehristev@kernel.org>
References: <20261016-split-sfdp-id-v3-v3-0-4a47b8fc945a@infineon.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20261016-split-sfdp-id-v3-v3-0-4a47b8fc945a@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/16/26 3:43 AM, Takahiro Kuwano via B4 Relay wrote:
> The spi-nor-core.c contains optional logics like SFDP and manufcaturer
> specific fixups. The spi-nor-ids.c has single large ID database. There
> are many #ifdef directives in those files and that negatively affects
> readability and maintainability.
> 
> This series, as the first step of cleanup, move SFDP logic, IDs, and
> fixups to newly source files. Reworking, renaming, and reformating
> existing code is not a scope of this series and further cleanup will be
> taken place in follow-up patches.
> 
> Here is the code size impact when applying this series.
> Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
> manufcaturers are enabled.
> 
> SPI-NOR:
>              text    data     bss     dec     hex filename
> BEFORE    720685   14084       0  734769   b3631 u-boot
> AFTER     721827   14156       0  735983   b3aef u-boot
> DELTA      +1142     +72
> 
> TINY:
>              text    data     bss     dec     hex filename
> BEFORE     77399    3128     248   80775   13b87 spl/u-boot-spl
> AFTER      77589    3200     248   81037   13c8d spl/u-boot-spl
> DELTA       +190     +72
>
I tested it on a PicoZed board with a Macronix flash (mx25uw51245g), it 
works like a charm.

FYI, below the size differences with only Macronix enabled:

SPI-NOR:
	text    data     bss     dec     hex   filename
BEFORE 	931951   44980       0  976931   ee823 u-boot
AFTER	932523   44988       0  977511   eea67 u-boot
DELTA	  +572      +8

TINY:
	text    data     bss     dec     hex   filename
BEFORE 	91612    3252     248   95112   17388 spl/u-boot-spl
AFTER	91680    3264     248   95192   173d8 spl/u-boot-spl
DELTA	  +68     +12

Tested-by: Bastien Curutchet <bastien.curutchet@bootlin.com> # mx25uw51245g


Best regards,
Bastien
