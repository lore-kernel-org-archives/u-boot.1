Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE085C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7D3787767;
	Wed, 20 Dec 2023 13:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="WBZpO9+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA8787767; Wed, 20 Dec 2023 13:19:11 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDD1387705
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Wed, 20 Dec 2023 13:19:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1703074749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=acBTvWrrZ0vALGtORGu5MwKo0oYnx3l9QmS5hc/mjJA=;
 b=WBZpO9+HXPSEsAYXwW25yurQQ2abCfIq0/ohAEXfeMmXFBJ6PAJIIdMHrT3/T4Vz+7QAeU
 57KagB7lD05YprvYzmBcwSCMp7CzLpbyeb6hiEtf73MpMexvrEuwrhhRXVhAQo58xGeRH7
 5APmnQp3zNV0QUMWzIHB6iiIgePGIvzOqSaHmhsBc807FMiw1jHB0cIsz3zxxsxKMWQAng
 5NL7noDac7aa8mxucuZ35wsujC7lwPUnRGTS/8udPzAWmEJkm8lrExFUiAS3ArIClRPR0C
 ofWO2UVDMWF+U0EGwB4ITjLzPfUjf7u98C0cNnfOnvmZCJZ+OVbzEY3O/AMCHA==
From: Alexander Dahl <ada@thorsis.com>
To: Kledson Silva <preventivaclinica@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Problem with CROSS_COMPILE
Message-ID: <20231220-7038940eb70911fac7f0c5a1@thorsis.com>
Mail-Followup-To: Kledson Silva <preventivaclinica@gmail.com>,
 u-boot@lists.denx.de
References: <CAJik2ecgeu+zhzJK_bjJGi8_q2A81LpszO-ZJVDxvq5cynSGHQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJik2ecgeu+zhzJK_bjJGi8_q2A81LpszO-ZJVDxvq5cynSGHQ@mail.gmail.com>
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

Hei hei,

Am Tue, Dec 19, 2023 at 11:03:12PM -0300 schrieb Kledson Silva:
> Hi,
> I need help, if possible with for compile and install VxWorks in my
> Raspbery 4
> 
> I follow the steps in page of WindRiver, but this step
> (CROSS_COMPILE=aarch64-linux-gnu-
> make), i have the problem below:
> 
> 
> include/image.h:1397:12: fatal error: openssl/evp.h: No such file or
> directory
>  1397 | #  include <openssl/evp.h>
>       |            ^~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.host:112: tools/aisimage.o] Error 1
> make: *** [Makefile:1858: tools] Error 2
> 
> Please, any idea? its for a my project of university

Your build host needs OpenSSL development library/headers installed.
Depending on your Linux distribution this package might be named
'libssl-dev' or similar.

Greets
Alex

> 
> Thank you very much!
> Best regards
