Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94654C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2980160635;
	Fri, 11 Sep 2026 13:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UlXugsVmuC1b; Fri, 11 Sep 2026 13:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1319360644
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789132408;
	b=gz8tFhltMAEiYTAtu8UFWblrvF9c7Ho3ilpb6igA8RdPLtV8jbkhdzQf3R7bribrsM5T
	 /bu0GiUoVrptNIsak/sPqglzLpRD1FZAHUAbMO2VCun8LTlcn3Cr+jXHaO1bOzO2krGdb
	 sG99hjNeiykk6b66aejjMAy5OSvsabdMFOdWpc+pGg93m4M4jpZBtIsk4F2DW6/m4eIFQ
	 s+0ZNaDXTgwJEX4/FtS9BZO6/pNHxJaFfErgrCylU8EGRLQVWsdqWkHR/5petfCpQFt8G
	 MRs8ZPHIMcknMzFgpw6918w+tqpYSG76BC+RYi3oWohcRXr+aGmk7f26uBEfqFxaiqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789132408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8rpzn//uZ75EBbmaptjd2f7pqFdZBCSiMcR/xOmvntA=;
	b=dKMKdJS0LIebs2vLDNu1kf4QPlNrRiiZM1glGCyFpXuhltjop01UUVf7xm8e/lZ+4dHi
	 kt5uwjqg1/lGh+Nhnh7yG1X+QvUE0vYfUNwpVJugvOyihIheKgYFtdqwSxZIouTufq1P6
	 S2xhYpJ0QeSAFumH8SQzA8NCsMXAMswSnbcdVKNwG++GaiEiWkpGfjOQ6zVA3Mb7Uc4nz
	 P22qyM1Wfe8MBgDcuCRNoMG2Viz86ReEup2fmPjDH7OfrW3nQdpW9DwyFU7M/ZnsxvXJc
	 gbiSCHF8NC7tlqwx2/058fEnPMbmG2vyhxZ6N3cpfOBTYOlHskyjWYW8BG2d/ifHDbQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BKKXkXqg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789132408;
	bh=8rpzn//uZ75EBbmaptjd2f7pqFdZBCSiMcR/xOmvntA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=izdwdG1/IVUDKeucKxj2ze5OqfWCBAFp+kWle1RgH7+Ol8X9/a6eXmbyBa/g7LiSx
	 r59LGyxPxgKSY9Nc7/SgPUbkrrEOqxjc3NvbI9mKMJoCFXs9KDBMEc4EZKpWjMBCqW
	 Cymwh54mDnWz1BurYWtCv45bYV1dA6f7h2PpbjEguePmQut5axdmJqlCnRkJNsG/29
	 sY0UTBHtXIF00gbrk6IeaSBZDxg3eea/Q6KfhJPGHkosQ4SKtVe0uh4mbp4QYhPsYf
	 UlGLkOjG15qlcc6IM+IV+uGPdgWSFBl1uH+5MBy9OVafHraJhGNVpdC8yX/oTdkN6I
	 qIgvYDcBzqTJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1319360644;
	Fri, 11 Sep 2026 13:13:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A18332F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF99160644
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ADTVV0nkEyg for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:13:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 25A4360635
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789132404;
 b=UxN+LVZntpQF2ebwc7ZoTDrVWsrS+wRWwm6cjQCFo5LfitkPcrdK0vVMdMmiq2CmLZqt
 un3Mzga0fqn/T0BurBIclFoaFD9vZ1Mwl5vD65gsEXsfK8cWIFjoznZpBMBoo+yFH+UsU
 Fxe9bKbuUK69R/FOsPG9SaHs3GT9t94ot9HipxIl8cjvg1xp/rhADAo8HxREJprx9V8zE
 Bt9CbGeXWGxR/7fMADiv9gd5nJWXDqI4IE5GkivJjvr+wVpTy0ASp+WzaCtjWfQQ35iXB
 fXK8nGn4vEAg6jBMef9Q4ZRI4+C0QIEa9YntREdG8DaZzNKAMQvm0WR67qcpc5skLdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789132404;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=8rpzn//uZ75EBbmaptjd2f7pqFdZBCSiMcR/xOmvntA=;
 b=OoB9tGQaL11brZ9fclEiuk1yGVwax7u91J8F/q0KXEUhmuHyBhlTUv/vRZLruxfEdqrt
 pQw8OmYPPc+QbbM4uerQjb05hBS+gV+Eh/RdvN90cvronj5NQNqQ94Rf3wKUQJaa7J4M5
 mMfplFooUyiDoJnhihZNIGVuujHGGeL+Z3rvUSX1+y81f8DoJXtpPlVgdQmhefRK48ZZt
 p5nVExdymaPP7wcwZBT5KgpKhZYEqzSnYTWlfDzK2k7e3RFaIt0emavXttzU43IbxpN73
 KsSrgUqJhqc0Og7D6WiOYXU9K2Pg35130z3EOHNxuiU4/licTaWS13LTsRsoRMdhSgQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=BKKXkXqg; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=BKKXkXqg
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25A4360635
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:13:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id CAB364E401EF;
 Fri, 11 Sep 2026 13:13:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9CD09601DE;
 Fri, 11 Sep 2026 13:13:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 78F1C11C7AFAC; 
 Fri, 11 Sep 2026 15:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789132394; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=8rpzn//uZ75EBbmaptjd2f7pqFdZBCSiMcR/xOmvntA=;
 b=BKKXkXqgaseukxnLDC9RVlB3k+xNWNej6RLqUruLJnPnIKTnnAEmXcvKQZNqA18J0BZiqR
 FDGp+tOp8aXEiwwt3CV+iWBfBSq1QMyGS0pMvEezlgMLWFThJoxIirDjpIR4TRyy/uK/Rx
 5gkMuafa3xRF80o4OlupN6mDqGBqybkCnGicQ+cPQE37B9OV8GPoyFN5MMLk0lwxatQiBi
 SeIlLfnCBUIRGF8obSqr7fG+Ef+KzGWTndec3jrE5PI6PqAclfqCPG+E95x9v9jSIhfDcj
 jp66Eerd3JesrGcsVFNOSQMTIESuxY0zLNtIVswFHe4PcfNr/cLzy4ZovasQUg==
Message-ID: <3adda04c-8a9c-4047-a6ed-14b4d97fe502@bootlin.com>
Date: Fri, 11 Sep 2026 15:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] binman: add nxp_imx93cst etype for i.MX93
 flash.bin signing
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Denis Mukhin <dmukhin@ford.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Alice Guo <alice.guo@nxp.com>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Christophe Guerreiro <christophe.guerreiro@non.se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260901-imx93-secureboot-v2-0-9638de817dfa@bootlin.com>
Content-Language: en-US, fr
From: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260901-imx93-secureboot-v2-0-9638de817dfa@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello all,

One of my colleagues has identified a few issues in the documentation 
with CST v4.0.1. I'll send out a version 3 fixing these.

Best regards,

Jérémie

On 9/1/26 18:38, Jérémie Dautheribes (Schneider Electric) wrote:
> Hello,
> 
> This series adds support for signing i.MX93 images by leveraging binman
> and CST, the NXP tool used for secure boot. This introduces a new binman
> entry type (etype) for this purpose.
> 
> The implementation is largely derived from the existing i.MX8M support,
> since the two share much of the same signing infrastructure.
> 
> This procedure has been tested on the imx93-evk board, using both ECDSA
> and RSA-PSS keys.
> 
> Patch 1: introduces the new etype
> Patch 2: updates the imx93-u-boot.dtsi description to include the new
> signing nodes
> Patches 3-4: documentation
> Patch 5: adds test coverage
> 
> Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
> ---
> Changes in v2:
> - Following Simong Glass' feedback:
>      - Created a new common class shared between the nxp_imx8mcst and the
>      nxp_imx93cst etypes
>      - rewrote the doc in reStructuredText and mention binman instead of
>      imx-mkimage
>      - took into account the other minor suggestions
> - Link to v1: https://patch.msgid.link/20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com
> 
> ---
> Jérémie Dautheribes (Schneider Electric) (5):
>        tools: binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
>        imx93-u-boot: wrap SPL and U-Boot nodes in a CST node if AHAB_BOOT enabled
>        doc: imx: ahab: add AHAB introduction
>        doc: imx: ahab: add i.MX93 secure boot guide
>        binman: test: add code coverage for nxp_imx93cst etype
> 
>   .gitignore                                         |   2 +
>   arch/arm/dts/imx93-u-boot.dtsi                     |  54 ++-
>   doc/board/nxp/index.rst                            |   2 +
>   doc/imx/ahab/guides/mx93_secure_boot.rst           | 297 +++++++++++++
>   doc/imx/ahab/guides/mx93_secure_boot.txt           | 269 ++++++++++++
>   doc/imx/ahab/introduction_ahab.rst                 | 465 +++++++++++++++++++++
>   doc/imx/ahab/introduction_ahab.txt                 | 445 ++++++++++++++++++++
>   doc/imx/index.rst                                  |  14 +
>   tools/binman/etype/nxp_imx8mcst.py                 |  60 +--
>   tools/binman/etype/nxp_imx93cst.py                 | 112 +++++
>   tools/binman/etype/nxp_imxcst.py                   | 121 ++++++
>   tools/binman/ftest.py                              |  85 ++++
>   tools/binman/test/vendor/nxp_imx93_csf.dts         |  18 +
>   .../binman/test/vendor/nxp_imx93_csf_imagename.dts |  24 ++
>   14 files changed, 1899 insertions(+), 69 deletions(-)
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> change-id: 20260814-imx93-secureboot-b914e7b6cbbf
> 
> Best regards,
> --
> Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>

-- 
Jérémie Dautheribes, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

