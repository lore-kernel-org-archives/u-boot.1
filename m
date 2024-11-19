Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40BED6DDC4
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 17:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49CFA891CD;
	Tue, 19 Nov 2024 18:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="QTEPdS3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF4289020; Tue, 19 Nov 2024 18:51:06 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DEDF89586
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 18:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732038658;
 bh=GYT/RBeVVAU9o0g8WsRS0Qg+GmJd0J2ZlFGUU9Lj688=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=QTEPdS3tRR8Ecve+PZmnMIfD4yRzKDX6p7U4iRvFT+Dru7S0ejMMBuescECIC2WVd
 q9qz+6rNKozoroW19IXIXxFRKVsuOSwHvbOQTvhkvHFy6tZNKHMzJabbq6mkZ8w9kA
 zecaSXEjx49y7Khf6TIOW1f94/0PJ34MusMLcL+0uNijsprEy2uUWwfkVMlODMtsSj
 EE9qVA0a3d8i8KpGmbEDY6+jA8Z+aw6isLlt909ghWlOcSOGrevqxoX+kHvV1FSKPc
 FJGu6CkzNQXY7f4r8OUn+7zsYAsQ7e1pUWxmtDao5OYw7r+KuU7Pe4iaekpBqfpemC
 4S5d7qKc2CW+A==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH] env: Switch the callback static list to Kconfig
Thread-Topic: [PATCH] env: Switch the callback static list to Kconfig
Thread-Index: AQHbOnIX4P3r9wnYMU+CahtlikVpKrK+lxcAgABKsSA=
Date: Tue, 19 Nov 2024 17:50:56 +0000
Message-ID: <9addc8f8a61c4365a4a1b0f14a5eb6f7@dh-electronics.com>
References: <20241119105750.27747-1-cniedermaier@dh-electronics.com>
 <f0abf894-9323-426a-acbe-547e4f1ea98b@denx.de>
In-Reply-To: <f0abf894-9323-426a-acbe-547e4f1ea98b@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBUdWVzZGF5LCBOb3ZlbWJl
ciAxOSwgMjAyNCAzOjIyIFBNDQo+IE9uIDExLzE5LzI0IDExOjU3IEFNLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+PiBTd2l0Y2ggdGhlIGNhbGxiYWNrIHN0YXRpYyBsaXN0IGZyb20g
dGhlIGJvYXJkIGNvbmZpZ3VyYXRpb24gdmFyaWJhbGUNCj4gDQo+IHZhcmlhYmxlICwgdHlwbw0K
PiANCj4+IENGR19FTlZfQ0FMTEJBQ0tfTElTVF9TVEFUSUMgdG8gS2NvbmZpZyBDT05GSUdfRU5W
X0NBTExCQUNLX0xJU1RfU1RBVElDLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBO
aWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRoLWVsZWN0cm9uaWNzLmNvbT4NCj4gDQo+IFdpdGgg
dGhlIGFib3ZlIHR5cG8gZml4ZWQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+DQoNCk9LLCBJIHdpbGwgZml4IGl0IGluIFYyLg0KDQoNClJlZ2FyZHMNCkNo
cmlzdG9waA0K
