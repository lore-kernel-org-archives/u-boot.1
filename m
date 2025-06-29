Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B832C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 14:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB9B381FEE;
	Sun, 29 Jun 2025 16:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="l+Dal8Kp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE97982E6A; Sun, 29 Jun 2025 16:43:04 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB1C800C1
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 16:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bVX8K273Gz9sp7;
 Sun, 29 Jun 2025 16:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751208177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r37fko8vhw4H6tFXKzjEzTK9Rc8wSMawCVsjnzkiur8=;
 b=l+Dal8KpgBRqi6Cv2Z/viDzULpqROi2ne2R/ZmWPD2cxniWbjMQf6z7pipRsgGyPWz2gzO
 BEuojVKOmsbv4p5jvQeI42Wl0RuaJfjDHRP6X1Q+9Z+zYNmG3fH5oZXTQhY9FA4kHe9dgJ
 +23HtyBIvpKbVi+pbIgOBuIbIy+zL3o7Zbzh3xlkqBcCUAA82EPtBygy1pAjKzBYqxLqmC
 p9wDx8JT9QyF8pitisx9/dSFEpRwL7INN2tujxFfnWQnXDBzsRDtPzDo7ZxzfyrCNg1ZLc
 jYzJ2ZxcvCLGHNLYZvnwYQfQQPh1K/hC/mWwPFoLug5NXtvnq/ZCROvCg9LGFg==
Message-ID: <e64e154e-1f74-4235-a1db-38034a704716@mailbox.org>
Date: Sun, 29 Jun 2025 16:42:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Put common r7s72100 code in board/renesas/common
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, geert+renesas@glider.be
References: <175109975905.52679.4087457787402643705.sendpatchset@1.0.0.127.in-addr.arpa>
 <175109976650.52679.843396826887967830.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175109976650.52679.843396826887967830.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 52eddfe38422076c6dd
X-MBO-RS-META: p7m1ez84mn4crh35zuwoa9o4s63bbati
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

On 6/28/25 10:36 AM, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Break out SoC specific code from the GR-Peach board and put it into the
> board/renesas/common directory so it can be easily shared between the
> GR-Peach and Genmai boards.
I've pushed an SH Ethernet clean up patchset , defconfig split patch and 
fixups for these two Genmai patches to [1].

The SH ethernet clean up patchset removes all SH ethernet related config 
options from include/configs/*h . The defconfig split patch deduplicates 
the RZ/A1 configs/*_defconfig files. The fixup! patches implement a 
couple of quick changes to this patchset, mainly duplicate newline 
removal, sort of various entries, and deduplication of genmai defconfig 
. No functional change is expected.

Can you please test the [1] on Genmai and see if nothing got broken ? If 
this works as expected, I will submit the SH ethernet clean up patchset 
and the defconfig split patch. If you agree with the fixup! patches, 
could you then please squash them into these two patches and submit V2 ?

Also, please update the subject prefix on these two patches and add 
"ARM: renesas: ..." subject tags .

[1] 
https://source.denx.de/u-boot/custodians/u-boot-sh/-/commits/test-sheth-genmai

Thank you
