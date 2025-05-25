Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BB7C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B7182B77;
	Sun, 25 May 2025 12:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mcmAPiZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8BE382C84; Sun, 25 May 2025 12:51:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED23A82B53
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748170261; x=1748775061; i=xypron.glpk@gmx.de;
 bh=fyaETMKkitDDLKbxqz0pR5EuPPc9JjX3Zgq9ZfHk0wM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mcmAPiZV1w3qLTFQ844PIiL9ly8qAWT7JZOf4lGAs6kNGnHNT95hDvOBQXFU6EUL
 kUuITC3XsFoRaja8uQj8qQxtHr3NqrQGIkOoLMBr4Ca4LAl5J6ZP13iy7Hrg0iIJG
 g1Sog8EC5hG/zTd2eCzdhHkq/MmPus1i3jJMhb0Uh800D3MjvAOG21fm1HLCE7PdD
 SaY0UF9cZjgnNM8dGeqvDQkmbDdmJhZfyT1JYZum8ukbQ3dk49mODFK4zsWacbup/
 4Dn9TLvtpgzWv9PjmgGK/PS5L3J4QB0D2YpeIslixcDg0d/ImThcd4Yjw2aDn+SYs
 vaY68dQaz6o2qWrifg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.142]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmUHj-1uje8i14q1-00kmWu; Sun, 25
 May 2025 12:51:01 +0200
Message-ID: <618b6efd-71a7-4cdb-b7d9-05a1c2012744@gmx.de>
Date: Sun, 25 May 2025 12:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [BUG] buildman fails to build with --in-tree
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ot+M5Pu/R2fgc5CeSqzLQR7XkBnuJH0TQr9WCXYOx/idXHXDPoA
 vlTioivqLVmtAF4rssfu1xPR1Mvc9n8Yq99WZnlseeyNJ8BYrXOd301wNhPw5/fudg6pEx9
 rptgoXGbT+YnSfgB+gSgMsghEtkbaCBgKvLQ7RE6pPQh1Q/1yTM1aoZRY+i1nvAWWbh2Ttr
 CfIlTdy0Pxp/zkI0MNRNg==
UI-OutboundReport: notjunk:1;M01:P0:lG7vta9USlA=;UeXPNBAzP8wkYDz0w+hKfUu/DFO
 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
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

Hello Simon,

buildman has parameter -i, --in-tree. But building with it fails:

$ tools/buildman/buildman -i -k qemu-riscv32_spl
Building current source for 1 boards (1 thread, 8 jobs per thread)
    riscv32:  +   qemu-riscv32_spl
+make: *** No rule to make target 'qemu-riscv32_spl_defconfig'.  Stop.
     0    0    1 /1              qemu-riscv32_spl
Completed: 1 total built, 1 newly)

Best regards

Heinrich
