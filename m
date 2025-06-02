Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD584C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 12:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55CD38212B;
	Mon,  2 Jun 2025 14:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1748868013;
	bh=Mbyns4Whs/4FB9/vS8igwzjR2Rd6Xf8DoCPNsVmIF8Y=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=cNj/qs8nbeSPfubMrBca9W9jRFfl8odr30S+BMwPiv8RQUZdrkbuwanwHFpCYJDps
	 5uDJWITMt/R4EzN7O+n26Bi8AsRLkpk0yY0N238Que7xKbj1IHT9cLO8VlUCzWW8M8
	 vmsfnorooDZAa1yLd8aRWue1AKufy56z7+A+yrFFXlBlBlZVk43c6x7vqzwhEf9W7j
	 bQFzGAtuH+ILbVQt+OsVmVXfAzQDLMwPoiphkg8C2S1U7DNBsP+xt1YPmIe8cZ6VLU
	 E9y3ngTmx4MJgkHaF/OHO8Y6+Zm/9T752y+rmNCJtpXC6RX6RfnvgWCFanRvxE6bZ0
	 w9gTirGyXv3dw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE1E82A46; Mon,  2 Jun 2025 14:40:11 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F8E81FEE
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 14:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JQg1ewzt"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D8B6610397298; 
 Mon,  2 Jun 2025 14:40:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1748868008;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=Mbyns4Whs/4FB9/vS8igwzjR2Rd6Xf8DoCPNsVmIF8Y=;
 b=JQg1ewztDLEq3d+L8ldQfqFnbwK99dIBfRvK3ibKUvUblO904zcH52cTtAOUD6Il5TNLVb
 ZKmR8Eo3l7YVqKCzbmBRn/+NpMIFDWvPJBaoFSXP7Hz3YWew/ZJ+5d1Hm6/pA2SP3CJ1cM
 xD4HBg5YaxVyi9q1GS6WwlnrRpzlIROvM4RJ23IWCSK/uRIFoV3c5MhRVHgazoGKgE9OEY
 Q+wQsJLiwGnwakm6CKvXRyNvvF3d1V5BUaCLxVe1YBTl6g2RoCx66M7TSE6QtG+dWsu8/2
 rdnGmrM44zoAN+TA36Ikl5HFpkZwFnSUO1Cpk01kHC2LH4oYmtXiNSD22Ns10w==
Message-ID: <e23cecfa-7b2c-64fd-5850-e85326e69e22@denx.de>
Date: Mon, 2 Jun 2025 14:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Wojciech Szamocki <wojciech.szamocki@nokia.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-i2c master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

The following changes since commit b22a276f039f818d5564bec6637071cfc8a7e432:

   image: android: fix ramdisk default address (2025-05-30 13:44:05 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfixes-for-2025.07-rc4

for you to fetch changes up to ec7b49c4108afdca3864da45b5444efb327ce75c:

   i2c: designware_i2c Return -ETIMEDOUT for timeout errors (2025-06-02 11:02:58 +0200)

----------------------------------------------------------------
i2c bugfixes for v2025.07-rc4
- designware_i2c: fix globally wrong return value -1 into -ETIMEDOUT
   in driver, which leaded in silent errors as a timeout resulted in
   an uninitialized value being returned, potentially causing
   unexpected behavior.

----------------------------------------------------------------
Wojciech Szamocki (1):
       i2c: designware_i2c Return -ETIMEDOUT for timeout errors

  drivers/i2c/designware_i2c.c | 30 +++++++++++++++++++-----------
  1 file changed, 19 insertions(+), 11 deletions(-)

Azure build is fine:
https://dev.azure.com/hs0298/hs/_build/results?buildId=177&view=results

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
