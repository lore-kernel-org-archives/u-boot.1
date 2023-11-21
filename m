Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7483C54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 12:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A6D287593;
	Tue, 21 Nov 2023 13:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=elsoft.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=elsoft.ch header.i=@elsoft.ch header.b="cmSNzmYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 785DE87596; Tue, 21 Nov 2023 13:08:31 +0100 (CET)
Received: from mail.hostpark.net (mail.hostpark.net [212.243.197.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A77087545
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 13:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=elsoft.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d.mueller@elsoft.ch
Received: from localhost (localhost [127.0.0.1])
 by mail.hostpark.net (Postfix) with ESMTP id 1C32F1622A;
 Tue, 21 Nov 2023 13:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elsoft.ch; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :user-agent:date:date:message-id:subject:subject:organization
 :from:from; s=sel2011a; t=1700568508; bh=UenapjPMByQKbIAjw0sjBRx
 YCkuP5nkEUlTJQFZm+Js=; b=cmSNzmYrfqDNc7S5W9BHFfTIVTBNCF18mRHPx8k
 iqgCnMwRN/5Ow9vpSeTWdmkzhqTOx5WE8KpdpZWTN6NwBI6rxc/XP1d0W1h22U7r
 zgeoY/seRHeoUgfwxknAvuHWMzIdjfUAzQNPadwAwTeNd55sMGcSm1kKUhoDvBGA
 FJr0=
Received: from mail.hostpark.net ([127.0.0.1])
 by localhost (mail1.hostpark.net [127.0.0.1]) (amavisd-new, port 10224)
 with ESMTP id ZMPzryeWAVoF; Tue, 21 Nov 2023 13:08:28 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
 by mail.hostpark.net (Postfix) with ESMTPA id B898F161E1;
 Tue, 21 Nov 2023 13:08:25 +0100 (CET)
To: Mario Six <mario.six@gdsys.cc>, Joe Hershberger <joe.hershberger@ni.com>
From: =?UTF-8?Q?David_M=c3=bcller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>
Organization: ELSOFT AG
Subject: RGMII handling in Marvell PHY driver wrong?
Cc: U-Boot <u-boot@lists.denx.de>
Message-ID: <8255385e-0b32-b9aa-c1f8-a75d30060463@elsoft.ch>
Date: Tue, 21 Nov 2023 13:08:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hello

Since commit 68e6ecadc551 ("net: phy: marvell 88e151x: Fix handling of 
RGMII interface types") it is possible to set the Rx/Tx delays settings 
of Marvell PHYs from the DTS.

The code handled all 4 possible cases ("PHY_INTERFACE_MODE_RGMII", 
"PHY_INTERFACE_MODE_RGMII_ID", "PHY_INTERFACE_MODE_RGMII_RXID", 
"PHY_INTERFACE_MODE_RGMII_TXID") of the Rx/Tx delay bits in the MSCR 
register.

Later, commit 431be621c6cb ("net: phy: marvell 88e151x: Fix handling of 
bare RGMII interface type") merged the "PHY_INTERFACE_MODE_RGMII" and 
"PHY_INTERFACE_MODE_RGMII_ID" cases, effectively loosing the possibility 
to specify Rx/Tx delay bits both cleared.

This looks wrong for at least two reasons:
  - How does one describe a system with a Rx/Tx delay bits clear
    requirement in the DTS properly?

  - The Linux Marvell PHY driver does not merge the
    "PHY_INTERFACE_MODE_RGMII" and "PHY_INTERFACE_MODE_RGMII_ID"
    cases either.

Therefore I think commit 431be621c6cb should be reverted.

Or am I missing something here?
