Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ED2C87FCA
	for <u-boot@archiver.kernel.org>; Sat, 26 Jul 2025 12:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C070682E67;
	Sat, 26 Jul 2025 14:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=beckhoff.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=permerror (0-bit key) header.d=beckhoff.com header.i=@beckhoff.com header.b="AAnEjKYJ";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=beckhoff.com header.i=@beckhoff.com header.b="n8Ey7ExF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D42A0835A2; Sat, 26 Jul 2025 07:38:52 +0200 (CEST)
Received: from netsrv01.beckhoff.com (netsrv01.beckhoff.com [62.159.14.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 285CB83020
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 07:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=beckhoff.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=P.Bruenn@beckhoff.com
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1753508329; bh=QmR9qB2jgIXZ9Z0nv82SVopu0Eh277VQqTnrcbObA5Y=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 AAnEjKYJyMW4iHU+txDJ4k9J9/HIPu7as8YcwRpplTCGu/ux2OTuzk7wQ4rYKIKBCEGAfF/5yjwdF2Sx8RYoDw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1753508329; bh=QmR9qB2jgIXZ9Z0nv82SVopu0Eh277VQqTnrcbObA5Y=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 n8Ey7ExFPY1yV/SEZx4AyxlM8BSFtdgLt+Q3Swl0LxAw2xZPS09IO6s+1KRIo0Uo0W13oB3M2K1tEQcS7LR+uzBuvLhrRn69mhBsgzxaUdDF/tL1gjq/TQfSfYUxRT0tLarV8HoDDhdnlzaX54zEtYiNFCFTdYkojjO2DewDGRazsmE8jrRIy1vyrIHHjDZ5pnxhGNO+FzWx324WpMsWz9sd9ctMmo6YevhR9llojmMEYj/Jb4LlB4QK5ol+i/l7MeQIVoCqN6F9enXVtLVgfnqDwp9DjeVv4P1f9BW5pCDpEwIJJlJkVI6LZfV+UDp/g/i6I+TlU/ynDkLEFKzRkw==
Received: from 172.17.6.17 by netsrv01.beckhoff.com
 (TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384); Sat, 26 Jul 2025 05:38:49 GMT
Received: from ex09.beckhoff.com (172.17.6.17) by ex09.beckhoff.com
 (172.17.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Sat, 26 Jul
 2025 07:38:47 +0200
Received: from ex09.beckhoff.com ([fe80::6f50:ad73:308d:1a24]) by
 ex09.beckhoff.com ([fe80::6f50:ad73:308d:1a24%9]) with mapi id
 15.02.1748.026; Sat, 26 Jul 2025 07:38:47 +0200
From: =?utf-8?B?UGF0cmljayBCcsO8bm4=?= <P.Bruenn@beckhoff.com>
To: Michal Simek <michal.simek@amd.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git@xilinx.com"
 <git@xilinx.com>, Alexander Dahl <ada@thorsis.com>, Alexander Graf
 <agraf@csgraf.de>, Dmitry Rokosov <ddrokosov@salutedevices.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, "Pieter
 Van Trappen" <pieter.van.trappen@cern.ch>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/3] fpga: Remove lattice and ACEX1 support
Thread-Topic: [PATCH 0/3] fpga: Remove lattice and ACEX1 support
Thread-Index: AQHb/Vbwc0NfTLHkLka/TUt8vcQhAbRD5G9B
Date: Sat, 26 Jul 2025 05:38:47 +0000
Message-ID: <53B89D35-7347-4017-A17C-82D049803B05@beckhoff.com>
References: <cover.1753442748.git.michal.simek@amd.com>
In-Reply-To: <cover.1753442748.git.michal.simek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-olx-disclaimer: EX09.BECKHOFF.COM
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 26 Jul 2025 14:36:52 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

DQoNCkFtIDIwMjUtMDctMjUgdW0gMTQ6MjYgc2NocmllYiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5z
aW1la0BhbWQuY29tPjoNCg0KSGksDQpIaSBNaWNoYWVsIGFuZCBBbGV4LA0KDQp3aGVuIGZwZ2Eg
ZHJpdmVycyB3ZXJlIGVuYWJsZWQgdmlhIHNhbmRib3ggc29tZSBjb3Zlcml0eSBpc3N1ZXMgY2Ft
ZSBhbmQNCm1ha2Ugbm8gc2Vuc2UgdG8gZml4IHRoZW0gd2hlbiB0aGVyZSBpcyBubyB1c2VyIG9m
IHRoZXNlIGRyaXZlcnMgdGhhdCdzIHdoeQ0KaXQgaXMgZWFzaWVyIGp1c3QgcmVtb3ZlIHRoZW0g
Y29tcGxldGVseS4NCg0KQW5vdGhlciBjYW5kaWRhdGUgZm9yIHJlbW92YWwgaXMgRlBHQV9DWUNM
T04yIHdoaWNoIGlzIGVuYWJsZWQgb25seSBieQ0KbXg1M2N4OTAyMF9kZWZjb25maWcuDQpQYXRy
aWNrOiBJcyB0aGlzIGJvYXJkIHN0aWxsIG1haW50YWluZWQ/DQpUaGUgaGFyZHdhcmUgeWVzLCB3
ZSBzdGlsbCBwcm9kdWNlIGFuZCBzZWxsIHRoZXNlIGRldmljZXNbMV0uIE9uIHRoZSBzb2Z0d2Fy
ZSBzaWRlIEkgaGF2ZSB0byBiZSBob25lc3Qgd2UgZGlkbuKAmXQgdG91Y2ggdGhpcyBzaW5jZSBi
ZWdpbm5pbmcgb2YgMjAyM1syXS4NCldlIHVwc3RyZWFtZWQgdWJvb3QgdG8gZ2l2ZSBvdXIgY3Vz
dG9tZXJzIHRoZSBvcHBvcnR1bml0eSB0byBydW4gdGhlaXIgb3duIGltYWdlcywgc28gaXQgaXMg
cG9zc2libGUgYnV0IHVubGlrZWx5IHNvbWUgb2YgdGhlbSBydW4gYSBtb3JlIHJlY2VudCB1Ym9v
dC4NCldlIGRpZG7igJl0IGdvdCBtdWNoIGZlZWRiYWNrIGZyb20gY3VzdG9tZXJzIGluIHRoZSBs
YXN0IHR3byB5ZWFycywgc28gd2UgZGlkbuKAmXQgc3BlbmQgdGhlIHRpbWUgdG8gYWRkIHRoaXMg
b2xkIGhhcmR3YXJlIHRvIG91ciBtb2Rlcm4gY2kuDQpCdXQgaWYgaXQgaGVscHMgb3RoZXIgRlBH
QV9DWUNMT04yIHVzZXJzIGluIHRoZSBzaGFkb3dzLCBJIHdpbGwgdHJ5IHRvIGJyaW5nIHRoaXMg
Ym9hcmQgdXAgdG8gZGF0ZSB3aGVuIElhbSBiYWNrIGZyb20gdmFjYXRpb24gaW4gdHdvIHdlZWtz
Lg0KDQpSZWdhcmRzLA0KUGF0cmljaw0KDQoNClsxXSBodHRwczovL3d3dy5iZWNraG9mZi5jb20v
ZW4tZW4vcHJvZHVjdHMvaXBjL2VtYmVkZGVkLXBjcy9jeDkwMjAtYXJtLXItY29ydGV4LXItYTgv
Y3g5MDIwLmh0bWwNClsyXSBodHRwczovL2dpdGh1Yi5jb20vQmVja2hvZmYvQ1g5MDIwL2NvbW1p
dC81MjRjNzRjZjFlZmMwOGQ0Mzc1ZjU4MTU3YzRjODMxNTQ5NTYzYjcwDQoNCg0KVGhhbmtzLA0K
TWljaGFsDQoNCg0K4oCmDQoNClRoaXMgZW1haWwgY29udGFpbnMgY29uZmlkZW50aWFsIGluZm9y
bWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgeW91IG11c3Qgbm90IHJl
YWQsIHVzZSwgY29weSBvciBwYXNzIG9uIHRoaXMgZS1tYWlsIG9yIGl0cyBhdHRhY2htZW50cy4N
CklmIHlvdSBoYXZlIHJlY2VpdmVkIHRoZSBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBpbmZvcm0g
bWUgaW1tZWRpYXRlbHkgYnkgcmVwbHkgZS1tYWlsIGFuZCB0aGVuIGRlbGV0ZSB0aGlzIGUtbWFp
bCBmcm9tIHlvdXIgc3lzdGVtLiBUaGFuayB5b3UNCg0KRGllc2UgRS1NYWlsIGVudGjDpGx0IHZl
cnRyYXVsaWNoZSBJbmZvcm1hdGlvbmVuLiBTb2xsdGVuIFNpZSBzaWUgaXJydMO8bWxpY2ggZXJo
YWx0ZW4gaGFiZW4sIGTDvHJmZW4gU2llIGRpZXNlIEUtTWFpbCBvZGVyIGlocmUgQW5ow6RuZ2Ug
bmljaHQgbGVzZW4sIHZlcndlbmRlbiwga29waWVyZW4gb2RlciB3ZWl0ZXJnZWJlbi4NClNvbGx0
ZW4gU2llIGRpZSBNYWlsIHZlcnNlaGVudGxpY2ggZXJoYWx0ZW4gaGFiZW4sIHRlaWxlbiBTaWUg
bWlyIGRpZXMgYml0dGUgdW1nZWhlbmQgcGVyIEFudHdvcnQtRS1NYWlsIG1pdCB1bmQgbMO2c2No
ZW4gU2llIGRpZXNlIEUtTWFpbCBkYW5uIGF1cyBJaHJlbSBTeXN0ZW0uIFZpZWxlbiBEYW5rDQoN
CkJlY2tob2ZmIEF1dG9tYXRpb24gR21iSCAmIENvLiBLRyB8IE1hbmFnaW5nIERpcmVjdG9yOiBE
aXBsLiBQaHlzLiBIYW5zIEJlY2tob2ZmDQpSZWdpc3RlcmVkIG9mZmljZTogVmVybCwgR2VybWFu
eSB8IFJlZ2lzdGVyIGNvdXJ0OiBHdWV0ZXJzbG9oIEhSQSA3MDc1DQoNCg==
