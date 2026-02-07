Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC1AEE0ADC
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 14:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB7C83BDD;
	Sat,  7 Feb 2026 15:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=rwahl@gmx.de header.b="MYBwhNrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3C083A64; Sat,  7 Feb 2026 13:42:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E96C83642
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 13:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rwahl@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770468144; x=1771072944; i=rwahl@gmx.de;
 bh=KxjqWUmED32MzaW6Lv55XSaAdJ9kmt3CZJG0yp7WGtg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MYBwhNrYm59YFWNYPF6fALB6oUEwe8mQTZXNP2evu429+ydIKuG093exJt5XS6Y3
 VAdDmG20PCTP7foKHvYX9Ejz90eTExsv+wmpiozl7FoZ9e4x+BNaPgFCAc4zaZTVg
 V40gGvxcf1V1f/IFh9yighTv8HeKH4AVLXxJCLBojzlBjsu5/BCB7mmCiO2qOaaNx
 5b9F0Qp7dUtY31LmP0qat39Rh/9p7P0aDFEkfEZzm/xRSqW4q1ix+nvPagaNVwNit
 Vaflwfg/3pZrzCNB7zPLiigbXT4GDDF38Vtdfz7sGh6VxAgkAdjr1/xa+FFZJvX0k
 y1GHKs/DGKAdevlePA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.24] ([84.156.147.204]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Mj-1vEoap0oBH-00kp6G; Sat, 07
 Feb 2026 13:42:24 +0100
Message-ID: <85942c08-47ba-4874-870e-700d32a9356f@gmx.de>
Date: Sat, 7 Feb 2026 13:42:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ronald Wahl <rwahl@gmx.de>
Subject: Confusing memory layout after spl_relocate_stack_gd()
To: Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jIL9cJjer3w245CUhAYpgYyrTXuBnNm1rN4uE+pnOk/q7xtKdtp
 MO0ArEohw0FxYOvPr5G7lwWg5/7Zp4cF6MjqjQhT1/t17nxS2PyqnRQGlHJAFR0RqzXV/53
 lZdVnRv2yxRjpP5Eih2IYqGM3y5LwI+HrPa0FwWqlz+dq2bulXGtgMKGQGAGU1t1/rvz3nn
 PTd5OX0w4cdenyEW3GvCQ==
UI-OutboundReport: notjunk:1;M01:P0:2O2ueKR8nDA=;c2SWio9j7iJfmkO0B1NBopSLcrQ
 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
 NGe/yQ3Tm47Dg27mDXd1BZ4HRflFlewGJD0T3x
X-Mailman-Approved-At: Sat, 07 Feb 2026 15:18:52 +0100
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

Hi,

I'm a bit confused about the stack location after calling=20
spl_relocate_stack_gd(). Looking at the code of this function I see that=
=20
the stack pointer is in the simple_malloc heap before the global data.=20
That means that the stack is growing downwards into the heap. Also the=20
malloc_limit includes the global data memory. This looks quite odd.=20
Wouldn't it be better to set the stack base the same address as malloc_bas=
e?

In the documentation[1] there is also a picture (DRAM SPL after=20
relocation) that illustrates this. The Stack region is just placed wrong=
=20
there and never used as the stack grows downwards. It must be above=20
malloc_base.

If you think my thoughts are correct I can prepare a patch.

thanks,
ron

[1] https://docs.u-boot.org/en/latest/develop/memory.html
