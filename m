Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74C4C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 21:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3C7D87073;
	Mon,  8 Jan 2024 22:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="TI2Dy+1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E162D875EB; Mon,  8 Jan 2024 22:44:07 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F188A87645
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 22:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1704750244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vr+b7cu6mxM/lvdCzZ2AT43bg1IJT7GIWnz5EfA+Yyg=;
 b=TI2Dy+1IemqmmsnkU+CAYBxlJBTdeZuFlYZ/u6oYEs9ALzpx0Z7ee+PLDl8BbYUHwxp+w0
 R0/u1K0z1BHtY/g/oqJJS5JYw2PSIQC6dOT+Q0yKjz2liM+zTxJaV69BXO7c7krlBJ8yN6
 vqxyDjk60Ach1qlAH4oj2fw77j38WZ+s+CDxZLdJJ1zrhSbOFVsyqZ0tzBrEe/Z0mVlGnD
 ZSTb7KGuaAK7NJw33MvDCxre9EG5i8ay3wId3KSzKc2/J/833cReRFeDNve4urQpWycBNI
 1LFOUwrh6cqm/l8L+QjtFVMCdQaPpYQt7o+Jcvg56xOcJBR1ZfIRWJqgAZs4FA==
Date: Mon, 08 Jan 2024 22:44:04 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Tobias Deiminger <tdmg@linutronix.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Harald Seiler
 <hws@denx.de>
Subject: Re: [PATCH 0/1] Skip cleanup test if not built out of tree
In-Reply-To: <20240108211100.112730-1-tdmg@linutronix.de>
References: <20240108211100.112730-1-tdmg@linutronix.de>
Message-ID: <bd3c01be5893082c93efab185979aeee@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-01-08 22:10, Tobias Deiminger wrote:
> This patch avoids false positives in cases where tests are invoked with
> test.py --build-dir=./ .
> 
> See tbot issue 107 [1] for motivation and prior discussion.
> 
> Previously it resulted in:
> E   AssertionError: leftovers: net/mdio-uclass.c, net/bootp.c, [...]
> 
> Now it results in:
> SKIPPED [2] test/py/tests/test_cleanup_build.py:23: Leftover detection
> requires out of tree build.
> 
> [1] https://github.com/Rahix/tbot/issues/107#issuecomment-1880192186

If I may suggest, there's no need for a cover letter for a single patch. 
  If you want to include some notes in the patch submission, which aren't 
supposed to be part of the commit summary, you can do that in the patch 
itself.

> Tobias Deiminger (1):
>   test: Skip cleanup test if not built out of tree
> 
>  test/py/tests/test_cleanup_build.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> 
> base-commit: 93d91e9485d902a1836a22e72d1a545b587adf36
