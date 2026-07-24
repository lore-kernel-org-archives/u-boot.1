Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A39C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 14:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A5C760B83;
	Fri, 24 Jul 2026 14:02:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q0n9aqXKMmem; Fri, 24 Jul 2026 14:02:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F32EA60B8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784901732;
	bh=ILk+CH5gFBeiROcrHZgl3CpaHkCWIj1Q/mre3B3nj38=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=aEJ2DM8WBKrVV1ZXnzhzjmdLhC41+a3ue7YgXQBRBKUJXsZ9qvLQ9B/XU2XuJOCJa
	 juiGikkgCPJCfxDhkdBa+PhbOauZjwezFZmcZCbgBjQhVw2IdDe5Eu3iATuoQ9ESkZ
	 jYkOPsw5uI7OdpYC8doa+wW45QQqdr0EV9GFMFAdxX1/HUUyxulWeL3kJdVWeNVzd/
	 lzSuqUj25lIZqHAtcpy6ZII3H46cj7tit35wwLf3I2JiDmyugoQ46RT4Ocs/7DLg59
	 U7jVoHhmEzdhHVyWlM3ffnvbFWIIri68LMgmRUZmwOFl/zbpHfH+q4yQn9ELmfDPDA
	 QgGLdVeZnLyOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F32EA60B8B;
	Fri, 24 Jul 2026 14:02:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 745832E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A1F581152
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:26:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3sqcP4kFP2xx for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:26:51 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=miquel.raynal@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6E8F281096
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E8F281096
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E8F281096
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:26:50 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4514A803F6; Fri, 24 Jul 2026 11:26:48 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41906800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 11:26:46 +0200 (CEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C418B4E40F20;
 Fri, 24 Jul 2026 09:26:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9500460395;
 Fri, 24 Jul 2026 09:26:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3438E11C11D9E; 
 Fri, 24 Jul 2026 11:26:41 +0200 (CEST)
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@0leil.net,  kever.yang@rock-chips.com,  sjg@chromium.org,
 dario.binacchi@amarulasolutions.com,  michael@amarulasolutions.com,
 trini@konsulko.com,  u-boot@lists.denx.de,  quentin.schulz@cherry.de,
 boogiepop@gmx.com,  richard@nod.at
Subject: Re: [PATCH v2] mtd: nand: raw: rockchip_nfc: fix ecc setup
In-Reply-To: <fdb929d4-19f9-4aad-ae2d-9d15e2552242@gmail.com> (Johan Jonker's
 message of "Wed, 22 Jul 2026 11:16:20 +0200")
References: <de3c0d84-8490-4bc9-8702-12c060eeb329@gmail.com>
 <fdb929d4-19f9-4aad-ae2d-9d15e2552242@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 24 Jul 2026 11:26:40 +0200
Message-ID: <87fr18sppr.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 24 Jul 2026 14:02:07 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=dkim; 
 t=1784885204; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ILk+CH5gFBeiROcrHZgl3CpaHkCWIj1Q/mre3B3nj38=;
 b=Q+VylnykBP9JxPT3rfJKqg0XUEPLEstZtnmDyyHdVFtLVapou9g+3KIN+RjJ8moaGkwoYS
 PXK2M6ll0KkOrmGzwKsUdpcNTbsnSqS3fDLCrN7bgDCYlC4ck2kFr2flWXTkW167cpU6ER
 UGrk/kwhmksAJEckcBeVRnELwcpTV+UNIgxlJYEmpXCATgG1R6Pv5KyIEH0xRT+QCf+YZx
 xOcZqNthd2KSSxpPCOHgrwjp8H9beLsWgB4NzMpiCiKM3uc5DEl6u0SJxyQ13lIP6vu094
 m2Fe5Y5jUPa4K4zxmfLJax0DAsl27seOhmT/TApvIdP6gDxAspcWanomQ/zTqg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=Q+Vylnyk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=miquel.raynal@bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Q+Vylnyk"; 
 dkim-atps=neutral
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
From: Miquel Raynal via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Miquel Raynal <miquel.raynal@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 22/07/2026 at 11:16:20 +02, Johan Jonker <jbx6244@gmail.com> wrote:

> Changed References:
> Added Linux MTD maintainers. Question below.
>
> Hi,
>
> On 7/22/26 00:56, Boogie wrote:
>> Hello Quentin
>>=20
>> I had reported this bug to Johan so i can give detailed explanation.
>>=20
>> The bug was really the lock of "&& nfc->selected_bank =3D=3D 0" not exis=
ting for write_page_* variants.
>>=20
>> When rockchip nfc was reading, it required bootblks to be a part of
>> the first nand chip only with the condition "nfc->selected_bank =3D=3D
>> 0". But when writing it interpreted 'all' nand chips first boot_blks
>> as boot blocks.
>>=20
>> The practical problem. I had mentioned this in V1 and give more explicit=
 details here.
>>=20
>> I have 2 nand chips, and a partition (linux below) starts in nand
>> chip 1 (CS=3D0 in below) and ends in chip2 (CS=3D2 below). And i am using
>> UBI on top of that mtd.
>> nand@0 {
>> =C2=A0=C2=A0=C2=A0 reg =3D <0>, <2>;
>> =C2=A0=C2=A0=C2=A0 label =3D "rk-nand-0";
>> =C2=A0=C2=A0=C2=A0 nand-bus-width =3D <8>;
>> =C2=A0=C2=A0=C2=A0 nand-ecc-mode =3D "hw";
>> =C2=A0=C2=A0=C2=A0 nand-ecc-step-size =3D <1024>;
>> =C2=A0=C2=A0=C2=A0 nand-ecc-strength =3D <40>;
>
>> =C2=A0=C2=A0=C2=A0 nand-is-boot-medium;

What you may want is to declare the NAND using two different nodes, then
use mtd-virt-concat to generate one bigger MTD device spanning across
the two devices.

The driver should not blindly check the 'cs =3D=3D0' condition but instead
also take nand-is-boot-medium into account (which would then only be
required in the NAND chip with the said boot partition) to make sure the
special handling is only applied on the boot partition.

Hope that helps.

Thanks,
Miqu=C3=A8l
