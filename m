Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBE3C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 444B260671;
	Mon, 17 Aug 2026 15:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfBp5OAF6NbK; Mon, 17 Aug 2026 15:50:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FB2B6072A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981846;
	bh=jpy1QOH5Ch05AS6syPya31ce440h3WjM4Hb2FuybbQE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=P9VXE6iV6xwVTf5OfgKQixKZPzUGLRn31cGpfbHfZxzN7UkZXxY+2AfLVAZmYEjUo
	 6l5nOP5HSSUMgBDH1kpJTZdTAylpmQyPeS/QFJBzGHKYlTNU8DM2mpkW+VbCHPTJv0
	 PXpQhFvxuJgAzhahkNKFswahKwB/acHunyjq9tTfwzlYdnGs2TgWN/cswpIdCzZgzG
	 ZvIu0TO2XcdravzQi3ZcbIAXAqM6MvLkLR32KdjFNQLhwYWD4W0x3PeW8HcoR0POnk
	 fYRSLt/uqINNPpYAeeJmrQR9infi+jae39pJyF+l+VFl7k8XpXsUohd8Ce0DAHqfgj
	 fz7g1ecEHCD8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FB2B6072A;
	Mon, 17 Aug 2026 15:50:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 963A7337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C4936078D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WNkeRRkMJ8gw for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:50:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A2CCE6072A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2CCE6072A
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2CCE6072A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:50:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id BB8341A16E5;
 Mon, 17 Aug 2026 15:50:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8F33F60352;
 Mon, 17 Aug 2026 15:50:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E624411C7375A; 
 Mon, 17 Aug 2026 17:50:35 +0200 (CEST)
Message-ID: <13c3fccd-1fd3-4ae2-a44a-84e00c382f33@bootlin.com>
Date: Mon, 17 Aug 2026 17:50:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/5] binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
 <CAFLszTiAmCFn0pt6x6uNfHdG3YBz=AAHT257ArJQUBCpmZX-wA@mail.gmail.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <CAFLszTiAmCFn0pt6x6uNfHdG3YBz=AAHT257ArJQUBCpmZX-wA@mail.gmail.com>
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_via_U-Boot?=
 <u-boot@lists.u-boot-project.org>
Reply-To: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

First, thank you for your thorough review!

On 8/15/26 00:31, Simon Glass wrote:
> Hi Jérémie,
> 
> On 2026-08-14T17:07:09, Jérémie Dautheribes
> <jeremie.dautheribes@bootlin.com> wrote:
> 
>> Patch 1: introduces the new etype
>> Patch 2: updates the imx93-u-boot.dtsi description to include the new
>> signing nodes
>> Patches 3-4: documentation
>> Patch 5: adds test coverage
> [..]
>> The implementation is largely derived from the existing i.MX8M support,
>> since the two share much of the same signing infrastructure.
> 
> Given how close this is to nxp_imx8mcst, please say in the cover
> letter whether you considered factoring out a common base class rather
> than duplicating the etype, and why you decided against it.

On second thought, I think it makes sense to factor out a common base 
class shared between the two etypes, so I'll do that for v2.
Thanks!

Best regards,

Jérémie
-- 
Jérémie Dautheribes, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

