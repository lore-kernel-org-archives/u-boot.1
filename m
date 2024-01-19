Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594F0C47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 14:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59E948746C;
	Fri, 19 Jan 2024 15:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="kusVisUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0860987CAF; Fri, 19 Jan 2024 15:09:00 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de
 [IPv6:2a01:238:43f2:8900:dd04:e3a0:ee11:a73d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C828746C
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 15:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (ip5f5a836f.dynamic.kabel-deutschland.de
 [95.90.131.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id 8BDD03D48651;
 Fri, 19 Jan 2024 15:08:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705673337;
 bh=kSqaFLr9cHJ+lhfMT8CPQwqgaS+sQeWHQUrEjsG5zzQ=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=kusVisUsyfduHzdwM38sOJxqyqO7nPzb68BVI4TtWHQJzH1QYuJVbUeS+1gHTFARJ
 Is/Uu4eKyB+VQg1H0HmnKS2cnyDxz7Ht0EzIBCreSLITmdPdV55SQC2Vt60d/8bN9A
 G/r6b1arONBxlceuCvOJ8+5boPlvfEDXAtNPtS0U=
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <fa7j66z5r7pul6zp5ljcntrb7xbazqxesz6wysrslrpxxhpafc@krztduo6pjm6>
Date: Fri, 19 Jan 2024 15:08:46 +0100
Cc: Stefan Wahren <wahrenst@gmx.net>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
References: <454FB8E4-52A8-482D-8671-5650F8C4773C@suse.de>
 <A26CEBAE-9950-4304-B3A2-1BAB4035437A@jens-maus.de>
 <zmxxqxlbhdhngu36ft4yrqxtjkmvalvhbgbl2uzsj2jgnq7zje@qtncpq2nss57>
 <DCAD0173-2377-4B89-92EB-F38ED1CA938B@jens-maus.de>
 <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
 <418F8AAE-136A-44A0-80C3-D01FFE00EC2E@jens-maus.de>
 <sjmi6dftbgx56isfyjtaryehzq2iollwxm2etlspiygehh3n6v@k4ws56nsbgfn>
 <6C9E5E0C-9C27-45A4-886F-8B8C641EF7A3@jens-maus.de>
 <ejituxf7ggiu2ciswrwoeqqjytb7mj2vn6gkxllywtnlm4aefi@br4zq7rfytlo>
 <3FB75D28-9BF9-4518-8BF1-519C884516F7@jens-maus.de>
 <fa7j66z5r7pul6zp5ljcntrb7xbazqxesz6wysrslrpxxhpafc@krztduo6pjm6>
To: "Ivan T. Ivanov" <iivanov@suse.de>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
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


> Am 19.01.2024 um 15:06 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>=20
> On 01-19 14:54, Jens Maus wrote:
>>=20
>>> Am 19.01.2024 um 14:46 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>>>=20
>>> Same here, expect that they are more memory banks, of course.
>>> It is really strange that you don't seen even single message
>>> from the U-Boot..
>>=20
>> Indeed. Not a single line, nor any U-Boot logo or anything on HDMI. =
Do you see any debug output on the serial debug probe connection to the =
rpi5?
>=20
> Yes, there is even small submarine on the top right side of the screen
> while U-Boot is running.

On the HDMI port, right? But what about the serial UART output? Is there =
anything U-Boot outputs right after the rpi boot loader is done? Here =
not. And as said, the same u-boot.bin boots up perfectly with a rpi4 and =
I can see the U-Boot submarine logo on the HDMI.

regards,
jens
--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

