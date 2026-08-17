Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B3FC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2563B4086C;
	Mon, 17 Aug 2026 18:45:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aO63Y7WnGbYw; Mon, 17 Aug 2026 18:45:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C579D40830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786992342;
	bh=Xg/FuQ1X5xhgiQr6Hc80/g3yjXOxv91ZPb+lzrIbdKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tf71ro0QYIUtritBT/5M25Y/DNl1gWLuEdBMnMqm+mEiyhw1/mPqhr5F4gx441+4x
	 ZhLuvJS7vQojJzasmn4leL0FY7zMxyhw5sKnUPnxrkcKkn7s5QUZQ2rU+CmBHjaNAA
	 tKy8bA1JyfGlCcsyVDiVLGPZwPWLuJHAUeD/QymvREIeHTW+ToY9KHI8X9QSa41ZpU
	 xguZWTK+4/rW8Omf8YEdJWNVcZ1j03XxqBsjz+jw8qD9qTonBw5bcbW/LI9327+kwo
	 dG18PZJeXEl7gs2KvpQMN9yQeffdyATswLOnIlVoKAQ3WF9UGikB02NbLEv34tr1XS
	 LJju35pIqfzXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C579D40830;
	Mon, 17 Aug 2026 18:45:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B58EF194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 18:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B356B6083A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 18:45:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lp35VqNyVzlx for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 18:45:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7F660607EB
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F660607EB
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=ImNkOV8v
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F660607EB
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 18:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786992330; x=1787597130; i=xypron.glpk@gmx.de;
 bh=Xg/FuQ1X5xhgiQr6Hc80/g3yjXOxv91ZPb+lzrIbdKE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ImNkOV8v1L/dJjVtMUQ4Iza1SqDZYSZk00qF/BNBNangQiaa4x+PaiapvShPZ5rs
 5jMnYyzHcSq/LXMDQEw87pNyDhiiDTrsZIVwrJ7o+UNyPFsHVvT3C3hZR5G3IrLEq
 UG5xArRqLShrDVjHNGGcu9NZNsXZoYgSd4mAGc76AY/BbKJ5XeesdHaW9yXD1hNV/
 QZ759QOxigfb584pRd+dP9YFeYDxcw1gDASJcw1EMkXaotRYcxt4nan9rcqzR28JY
 +5+CCwgUqKa9tObqr/VWRH2AjpZkGqOCOW232c1vgE73RCoOONXvUgS1suQctEs9H
 DZXePVNvTmYU+/WJig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Db0-1x2cyo10LA-000rMS; Mon, 17
 Aug 2026 20:45:30 +0200
Message-ID: <ad8b8f02-df18-4abb-8d93-3842aa2fabb5@gmx.de>
Date: Mon, 17 Aug 2026 20:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [security] Report of possible heap buffer overflow in U-Boot EFI
 image verification under Secure Boot (ANT-2026-R09Q9YM0)
To: ilias.apalodimas@linaro.org
Cc: David Korczynski <david@adalogics.com>,
 Adam Korczynski <adam@adalogics.com>,
 "security-cvd@anthropic.com" <security-cvd@anthropic.com>,
 trini@konsulko.com, Arthur Chan <arthur.chan@adalogics.com>,
 u-boot@lists.u-boot-project.org
References: <f9c67a7b-b7c0-445f-b9ed-7ab06c3f2f84@adalogics.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <f9c67a7b-b7c0-445f-b9ed-7ab06c3f2f84@adalogics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AE5lUDubkd0Aj+8EtDaVbK0NlE81wFR4xz5SsCy4y8qxdWh5DKi
 sa1plYMDc1xHt/jT1kbaHa/dUkDnw00yT5z6nxkSU2ZRsmy+vS6WSTyWA3DgN8qbIWgyJMo
 pDPtuHbBdEIXA5b3wloVXIyi1Ui7fDWDcHz+NZ1NneKQqrLkzu0cKsdGIahMY58w3TTXtbq
 h9c5tmwickNaxUh9qnPpQ==
UI-OutboundReport: notjunk:1;M01:P0:CJHlDdNflbk=;gnRmt+tJNSzEEpDLP2FGL6YnQCk
 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
 JyOA8OnE3akvMyUBhxc=
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

On 8/6/26 14:15, Arthur Chan wrote:
> Hello U-Boot maintainers,
>=20
> I'd like to report a High-severity security issue in=C2=A0 U-Boot (https=
://=20
> github.com/u-boot/u-boot / https://git.u-boot-project.org/u-boot/u-boot)=
=20
> related to possible heap buffer overflow in U-Boot EFI image=20
> verification under Secure Boot.
>=20
> I have attached 3 files with this email as described below.
> 1) report.md: A full description of the vulnerability and how to=20
> reproduce it, together with suggested fix of the issue.
> 2) Dockerfile: A Dockerfile for demonstrating the issue.
> 3) driver.c: Work with the Dockerfile to demonstrate the issue.
>=20
> Attribution
> *-----------*
> Please attribute Claude and Ada Logics. This issue was found by=20
> Anthropic from using agents to study security of open source projects,=
=20
> and I am from Ada Logics helping validate the found issues and creating=
=20
> the report manually and notify the maintainers.
>=20
> Disclosure
> *----------*
> This report follows a 90-day coordinated disclosure deadline. I'm happy=
=20
> to coordinate on the exact timing and to provide any further detail you=
=20
> need.
>=20
> Kind regards,
> Arthur Chan
>=20
>=20
> ADA Logics Ltd is registered in England. No: 11624074.
> Registered office: 266 Banbury Road, Post Box 292,
> OX2 7DL, Oxford, Oxfordshire , United Kingdom


@Ilias

There is no guarantee that the private exponent fits into 8 bytes. But=20
it would be highly unusual.

To be fully RSA compliant we probably would need to rewrite a lot of=20
code. An easier approach is probably to error out on long private exponent=
s.

Best regards

Heinrich


