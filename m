Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F96C98311
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 08:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 539CC40DD6;
	Thu, 24 Sep 2026 08:59:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1oSKkHbstLxO; Thu, 24 Sep 2026 08:59:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 605AC40DD8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790240346;
	b=rtL45xZfpIMzO1O0KjnqSIy8ikjpiPs8ZxE2zBIe4pfjqFo5kF/CjvGD2+D3c7KvJpaW
	 cIKT1o5dwjMXUKBfit7YQaxB/rjniz5ijMgQkvQhVZ4BD77V3THvhIRwbeBrcTAGMmmTz
	 +SJimYL/FR5SEA1waZVhte/z47qVKewJrTXoI858jtV3N7rdjgoongZ0DyYt7Tq+Nt6+i
	 frx7LwlPV83WGYBZWaurelRDrcqUE6FIlPhoN9cJ5NRHMvJRDYd3JkoxtwkkJdOK+3kge
	 7RMVsyoQo4C3GkgOMfdUlimeYzU8sqMIf6tsFZPxzGCtYplBHbn0cafT0qVPdOWROwg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790240346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LUVFPEMpo6bQ544/X9SR6dkB0ZV3J4+6XSWIK0Z1xZI=;
	b=TV+WrRsn1RUI1cUn1iXR6NJKOCXzTZ2dc0aN8Caq37wVYftop/kF03WSD89j6Rjl2IDx
	 9jtPDWg3q2bi0l7ddjQpo8VM/xQ6nSw1Uj4YpcKpyVOALVXujghqpEv6vkOpkQvyxHBPW
	 BX5PZj8a/IO+1k2kd7StSbyU/NHbC5s36RErYA83EuVcx65b/QNOXdE6iAFKDHIUXM47+
	 ulAJtZ2blBKltm1K+nCPblXbI4ZOGEnir8UcYH1C9hFb5FXmaTOxHj1Qd+GhRGKXsi4NH
	 aYPeAs8t5phDqhN+zd6PJqo08lihlIMaFYVFSF5j+m9IRO0R6P2LsZ+Nb6Nz2VulbUw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790240346;
	bh=LUVFPEMpo6bQ544/X9SR6dkB0ZV3J4+6XSWIK0Z1xZI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lFvZ/QITpUVMl0V2vfCMzaBFfOGi579+xiz+0KxCXd6v5uZ9tiI20e6Vl4LXL0LiW
	 oE7rxZyAP9Tx3iexBuhmH00chQDxTuvjOgdoip7wItsvNow49fWW/VoDNOzn1eLdDK
	 U5BtNWgDCynVgohDo4UOCqOhQ1YWRr1NodhQR297gVe0a+OKFx7wAPa/ZnclDqgnr4
	 5I2mSNDUr7E+fy2CS/6uDR0CWyPEJCB4q3AWTGAS1M0trFkwvDsjSudm6cU6qJyNs7
	 5YgV3RFpw3rgdu5gvxCPq3R9+bMTnJTAfE7rdQleDT71v/vfxeeVpM4RVPr2lX4TXN
	 ZObpanlY8Uy4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 605AC40DD8;
	Thu, 24 Sep 2026 08:59:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D004392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 04:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4695F6086B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 04:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AjLr-Wap9-Fj for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 04:08:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4AAEE60860
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790222880;
 b=BEe0mK2VMQ4SWQVhQU7nDwPporP3JHM1yrXgFnkmYjoeS8SdZK4e0cBwTgrANlQV7bhd
 Xnn4k/ppJlFOkdtD2QrJAE8yMQwtKcttDIWL6ILTKfZuiOyimUoKcB4dVzxJ/I0KNCulP
 QRz1Yi7S5h9yK2C3SRGMVUIT2+4Cw3Q3Lo65Ss5sICfmOxYtzIB6teC6ja6WyhceHmTBj
 hD4oJv6c1wkNbSy+AwVCzKqaAJeFhL/HBb70oktlYPrE1bOahzT1E5KDoTgxAflTT/aLX
 VbT9a5RfU/9loyEiQcjs8PiX0icxer0j6zIzGrY+bt77q3q/fMGkcU38gBcsaUcFjdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790222880;
 h=Received-SPF:DKIM-Signature:Received:Mime-Version:
 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
 From:To:X-Mailer:References:In-Reply-To:Feedback-ID:
 X-Zoho-CM-AccountID:X-ZohoMailClient;
 bh=LUVFPEMpo6bQ544/X9SR6dkB0ZV3J4+6XSWIK0Z1xZI=;
 b=AdsM0SBIh04VGLSqt14bUm2Oeaz236rapEDNzjl0qUNkiXxytGVKn0kxTDGjkro9GS5r
 a5THie/8CtZce8jTLWwNrECG6/499HqT8X5ccZQ58MgfYMwM6kCZF58ovGnGt1rAZkcJs
 OX1orv3KTPD3dl56lZHn65m5gBcAWCTT82DIyNK93qK+QkW1D60Hj52BZVe2hZg8rOVre
 0PafCFwS5PwBbhd3nLhbVi5WH4ipiW3FP884ZVhHg+CTPZuyGIfQDeuIMy3rWC3WD2s5q
 q9JtpXTxs43YM69tMqO8zWq5ZeVRsR1AnOGzLda8je7zDmtwF4BadZef6k2qKJTZuZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=C53kcyyW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Temperror (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=C53kcyyW
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4AAEE60860
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 04:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790222766; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CjJdTOtDeY1Nchbg7hKo1b1+UoaG2UCU+9ncKOYRme6yAefvUQJcPGIKQ3f/Sk+1c8keN0Q+8Ng40wglsUZJiLCDHzFJuRdo+9h+Wyl+dBzsr2sXt42XI5GbIXpWf0zSFBNYgMw0fKR5QUQw6Jk5x39POIzjqg0FGG668z2vxmY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790222766;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LUVFPEMpo6bQ544/X9SR6dkB0ZV3J4+6XSWIK0Z1xZI=; 
 b=HHd9cf3SMwwca5vzKaiMGBD7kfbMDWoHRd7s0fapbQd9FWwJBVj/qms9BGaV3m4JftKH8AEMC9ejSY7Ve/B4eAIxO6uYk6/MOT8cLnvAmOoIb595VRhm403ROb05a7lNs0on4sbUvUK9/SAsDRmtoDF4QcOqR3GA6ZGYjRtOe5E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790222766; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Feedback-ID:Reply-To;
 bh=LUVFPEMpo6bQ544/X9SR6dkB0ZV3J4+6XSWIK0Z1xZI=;
 b=C53kcyyWdALie9A9vhkUNKhyHHY0t/76pqZFf7K8E+zKN/OoRy07m5KmJOxFwQGr
 u/pm2V+o/Icq0R0wk/RsbvcL2nv56GtApwws3OWhyqokHCx3rTVAsvgNxUuNB5OdCPM
 jSgNiHhvWaSieiSzOcBwINfGaeCXcsJFRi6pFZ2I=
Received: by smtp.zohomail.com with SMTPS id 1790222765223313.13792709832956; 
 Wed, 23 Sep 2026 21:06:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 12:05:52 +0800
Message-Id: <DLN902USHBOD.1ODD26B7FLRM2@zohomail.com>
Cc: "Lukasz Majewski" <lukma@denx.de>, "Tom Rini" <trini@konsulko.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Stefan Roese" <stefan.roese@mailbox.org>, "Hiago De Franco"
 <hfranco@baylibre.com>, "Sumit Garg" <sumit.garg@kernel.org>, "Inochi
 Amaoto" <inochiama@gmail.com>, "Conor Dooley" <conor.dooley@microchip.com>,
 "Chen-Yu Yeh" <chenyou910331@gmail.com>, "Chen Wang" <chen.wang@linux.dev>,
 "Kongyang Liu" <seashell11234455@gmail.com>, "Leo Liang"
 <leo.liang@sifive.com>, "Thomas Bonnefille"
 <thomas.bonnefille@bootlin.com>, "Quentin Schulz"
 <quentin.schulz@cherry.de>, "Johan Jonker" <jbx6244@gmail.com>, "Casey
 Connolly" <casey.connolly@linaro.org>, "Varadarajan Narayanan"
 <varadarajan.narayanan@oss.qualcomm.com>, "Alexander Koch"
 <akoch@initse.com>, "Andreas Schwab" <schwab@suse.de>, "Junhui Liu"
 <junhui.liu@pigmoral.tech>, "Marek Vasut" <marex@nabladev.com>, "Sumit
 Garg" <sumit.garg@oss.qualcomm.com>, "Peter Robinson"
 <pbrobinson@gmail.com>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v4 09/11] rtc: cv1800: Add RTC and system reset support
From: "Zhuxu Ran" <zhuxu_ran@zohomail.com>
To: "Yao Zi" <me@ziyao.cc>, "Zhuxu Ran" <zhuxu_ran@zohomail.com>,
 <u-boot@lists.u-boot-project.org>, "Chao Wei" <chao.wei@sophgo.com>, "Chen
 Wang" <unicorn_wang@outlook.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
 <20260922-milkv-duo-upstream-dts-v4-9-d45b74dfad36@zohomail.com>
 <arQRjOUExoQro4ub@pie>
In-Reply-To: <arQRjOUExoQro4ub@pie>
Feedback-ID: zu08011227fb1a3a6ed9fb6da673b8eee80000964a23c4c3955024924b2df0c59d27d64d9a87e493d73a95d8:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 24 Sep 2026 08:59:03 +0000
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

On Thu Sep 24, 2026 at 1:51 AM CST, Yao Zi wrote:
> On Tue, Sep 22, 2026 at 11:46:24PM +0800, Zhuxu Ran wrote:
>> The upstream devicetrees describe the CV1800 RTC subsystem with the
>> "sophgo,cv1800b-rtc" compatible string. The RTC seconds counter and the
>> system-reset controls share the same register range.
>>=20
>> Add an RTC driver which directly matches this node, enables its clock,
>> and implements reading and setting the 32-bit seconds counter. Bind the
>> CV1800B sysreset driver as a child from the RTC driver's bind callback s=
o
>> both functions can be instantiated from the same devicetree node.
>>=20
>> Initialize the RTC and sysreset register maps from their shared devicetr=
ee
>> node instead of using hard-coded MMIO addresses. Remove the board-level
>> sysreset binding from Milk-V Duo. Boards using the upstream RTC node can
>> now instantiate both functions without board-specific binding code.
>>=20
>> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
>
> This patch looks quite large, and comparing to other parts of the
> series, it adds new drivers and modifies existing driver massively, so
> I think it makes sense to separate it out of the series, i.e., send a
> separate series converting sysreset-related ABI to match upstream first.
>
>> ---
>>  board/sophgo/milkv_duo/board.c         |   5 --
>>  configs/milkv_duo_256m_defconfig       |   2 +
>>  configs/milkv_duo_defconfig            |   2 +
>>  configs/sipeed_licheerv_nano_defconfig |   2 +
>>  drivers/rtc/Kconfig                    |   9 +++
>>  drivers/rtc/Makefile                   |   1 +
>>  drivers/rtc/rtc-cv1800.c               | 122 ++++++++++++++++++++++++++=
+++++++
>>  drivers/sysreset/Kconfig               |   6 +-
>>  drivers/sysreset/sysreset_cv1800b.c    |  86 ++++++++++++++---------
>
> This involves multiple subsystems, please separate rtc/sysreset/
> board-level changes into different patches. Bisectability might be
> broken for one or two commits, but I think it would be much clear to
> handle.
>
> Regards,
> Yao Zi

Hi Yao,

Thanks for the review.

I agree that the RTC and sysreset changes should be handled separately
from the devicetree conversion. I will prepare that work as a separate
series first, with the RTC driver, sysreset changes, and board-level
changes split into individual patches.

The next revision of this series will keep the existing board-level
sysreset setup and focus on the devicetree conversion.

--=20
Best regards,
Zhuxu Ran

