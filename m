Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066E3C0218A
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 01:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C2E81101;
	Wed, 29 Jan 2025 02:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="LMpe7dyJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D15B81111; Wed, 29 Jan 2025 02:29:06 +0100 (CET)
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com
 [203.205.221.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7039A810FE
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 02:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1738114138; bh=VFluMrtppOya3p5jaYFJcFcVeLOCXk1IbeHVWWnOGVA=;
 h=In-Reply-To:References:From:To:Cc:Subject:Date;
 b=LMpe7dyJd02XhEkVpgn7BpolHWFoWAfUlXCyjtx6oKDviTXiHvbZ/7gVGV+CHOV1V
 XXfAW27ouk9vRwYFpnuNhgJXgOrmBONIAW3nxSuWP38rVls4S8/npcXZtsb31jER6y
 wbJTsDcFX3LSXyC6l5wSXEqynNAQcJoaaRYjLbu4=
X-QQ-FEAT: oHWrrGTW1dCni6VLWI7Xi3lwP5c1dnPf
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-XMAILINFO: OS8jRRLK0oVlb1kX/Gj4aZfDHWZ8ukFsDwPoArnLQLBjYnbXwQ+jhEIwDWWQCa
 Zp4sxJ8lKhmcl6HyhvUaAfJAZnH61ho+bKpUjEtQVk7PTe81zJKn6cMSjX9rpVWBW3m4t+mTaXnRD
 xg1om9Lf/9y3N8n8llbmXZ7Dul8lvQpkJFAaiO7aDr0VjTRR5VpG9M8m+oA3njicHxedzIPqyJjD8
 RdVWpZK66tBr1ROeMUGbjYBAjpcBHn0lKsf6ax6lLWqh1LdKwyv5C3QJzm83KtvpZ74iGu/Y/l+Q0
 6PU2yK+RSiCGxbxRPtiGzRgq9+VPiW0wDbBeuK8mafngUaIgr3BAGsEEJtI6R9F2Xw3Ygzm8Kd2Ro
 +2iqfU/MA6qLwPmBbOUhuZs0XujvOGM6uD7ZK4sRgyq60Z+BYUza73kLR8H5hetEyN73xWBH0HF7u
 8YkBMbhplVIeQBGvN0DY5iKtArWijpg8ijkGSd3Lb9TEKiQ3moF2uFup/WV8ZV7Ucx4Mvp18krDYg
 kxYq9JWJbub4+vsTqfhvPCzBe5iUgitUir4OTey9u00GEJCj3rHoHEW/qv8BFvI5BnjJkzZOsgogM
 AZU4EbG3AsRox5UJrzEJ/Ip2MW4FFrDsjSS70VCXcaVIObqvVsv/hD/CHOy81GF6r+zky7E84vYi6
 L4NzhIYEW4FYTC+H+IN3QD6VvyPdtHA8129SiCGXLclIlHPM9+TIZir+D57xqPkKp0F5wnCiXiqb0
 QL4Pu9JIItA+Otumlt8GUebFhERK1dXsA6/NhKZB03hFEk0SirGjmKdZqW1x50V3WPEa6NGtwUiAG
 5OsecC5YBw7kLfAJPvfiBHc9k+3hPEWcNPmBp21AyTPL4h8M9CmdVYpBpyP7UMMwAw8zzuvnMtfN0
 jZjmNg4d8Z3ZE71psekRKoyOQaYNAdU9Jnabh3mF5bx6d3ziAtSf8xKM58lSUpeSPF7t3hoC19cDV
 0y5DWeCMqnkQflUr3rJqKO5tba9PLSQcjLrdBboVH34nMhAF/B
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 255.179.3.112
In-Reply-To: <20250128155542.426d3d8a@donnerap.manchester.arm.com>
References: <tencent_1A2035CCAD490A9F919EF0412BB6E3E02407@qq.com>
 <20250128155542.426d3d8a@donnerap.manchester.arm.com>
X-QQ-STYLE: 
X-QQ-mid: webmail864t1738114137t816450
From: "=?gb18030?B?u8bA+9HH?=" <1425075683@qq.com>
To: "=?gb18030?B?QW5kcmUgUHJ6eXdhcmE=?=" <andre.przywara@arm.com>
Cc: "=?gb18030?B?Q2hyaXMgTW9yZ2Fu?=" <macromorgan@hotmail.com>,
 "=?gb18030?B?SmFnYW4gVGVraQ==?=" <jagan@amarulasolutions.com>,
 "=?gb18030?B?SmVybmVqIFNrcmFiZWM=?=" <jernej.skrabec@gmail.com>,
 "=?gb18030?B?TWFrc2ltIEtpc2VsZXY=?=" <bigunclemax@gmail.com>,
 "=?gb18030?B?TWljaGFlbCBXYWxsZQ==?=" <mwalle@kernel.org>,
 "=?gb18030?B?U2FtdWVsIEhvbGxhbmQ=?=" <samuel@sholland.org>,
 "=?gb18030?B?U2ltb24gR2xhc3M=?=" <sjg@chromium.org>,
 "=?gb18030?B?U3VtaXRHYXJn?=" <sumit.garg@linaro.org>,
 "=?gb18030?B?VG9tIFJpbmk=?=" <trini@konsulko.com>,
 "=?gb18030?B?dS1ib290?=" <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: The CHIP DIP SCAN option should not be displayed in
 other mach
Mime-Version: 1.0
Date: Wed, 29 Jan 2025 09:28:56 +0800
X-Priority: 3
Message-ID: <tencent_2626B0B5076700D962EA4E8EFBDCF5880C0A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
Content-Type: text/plain;
	charset="gb18030"
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

SGksDQoNCg0KVGhhdCdzIHRoZSBmaXJzdCBxdWVzdGlvbi5Ob3cgSSBzZWUgdGhpcyBvcHRp
b24gaW4gbWVudWNvbmZpZywgaXQgc2hvdWxkIG5vdCBiZSBhdmFpbGFibGUgb24gb3RoZXIg
bW9kZWxzLkkgdXNlZCB0aGUgZm9sbG93aW5nIGNvbW1hbmQ6DQombmJzcDsmbmJzcDsmbmJz
cDsgZXhwb3J0IENST1NTX0NPTVBJTEU9YXJtLW5vbmUtZWFiaS0gQVJDSD1hcm0NCiZuYnNw
OyZuYnNwOyZuYnNwOyBtYWtlIHN0bTMyaDc1MC1hcnQtcGlfZGVmY29uZmlnDQombmJzcDsm
bmJzcDsmbmJzcDsgbWFrZSBtZW51Y29uZmlnDQombmJzcDsgJm5ic3A7IEFSTSBhcmNoaXRl
Y3R1cmUmbmJzcDsgLS0tJmd0O0VuYWJsZSBESVBzIGRldGVjdGlvbiBmb3IgQ0hJUCBib2Fy
ZCAoTkVXKQ0KDQoNClNvIEkgaW1wbGVtZW50ZWQgdGhpcyBwYXRjaCB0byBmaXggaXQuDQpC
dXQgSSBmaW5kIHRoYXQgdGhlIHJvb3QgY2F1c2UgaXMgdGhhdCB0aGlzJm5ic3A7DQpjb25m
aWcgaXMgbm90IGluY2x1ZGVkIGluIGlmIEFSQ0hfU1VOWEkuJm5ic3A7DQoNCg0KVGhpcyBp
cyB0aGUgc2Vjb25kIHByb2JsZW0uSSB0cmllZCB0byBpbmNsdWRlIGl0LCZuYnNwOw0KYnV0
IGdvdCBhIGNvbXBpbGVyIGVycm9yLg0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1z
dW54aS9LY29uZmlnIGIvYXJjaC9hcm0vbWFjaC1zdW54aS9LY29uZmlnDQppbmRleCBiYTFi
MTU0MTQzNy4uYjQ2N2FiMDk4YzAgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9tYWNoLXN1bnhp
L0tjb25maWcNCisrKyBiL2FyY2gvYXJtL21hY2gtc3VueGkvS2NvbmZpZw0KQEAgLTExMzMs
OCArMTEzMyw2IEBAIGNvbmZpZyBCTFVFVE9PVEhfRFRfREVWSUNFX0ZJWFVQDQombmJzcDsN
CiZuYnNwO3NvdXJjZSAiYm9hcmQvc3VueGkvS2NvbmZpZyINCiZuYnNwOw0KLWVuZGlmDQot
DQombmJzcDtjb25maWcgQ0hJUF9ESVBfU0NBTg0KJm5ic3A7CWJvb2wgIkVuYWJsZSBESVBz
IGRldGVjdGlvbiBmb3IgQ0hJUCBib2FyZCINCiZuYnNwOwlzZWxlY3QgU1VQUE9SVF9FWFRF
TlNJT05fU0NBTg0KQEAgLTExNDMsMyArMTE0MSw2IEBAIGNvbmZpZyBDSElQX0RJUF9TQ0FO
DQombmJzcDsJc2VsZWN0IFcxX0VFUFJPTQ0KJm5ic3A7CXNlbGVjdCBXMV9FRVBST01fRFMy
NFhYWA0KJm5ic3A7CXNlbGVjdCBDTURfRVhURU5TSU9ODQorDQorDQorZW5kaWYNCg0KDQoN
ClRoZSBlcnJvciBtZXNzYWdlIGZvciBydW5uaW5nIG1ha2UgbWVudWNvbmZpZyBpcyBhcyBm
b2xsb3dzOg0KYXJjaC9hcm0vbWFjaC1zdW54aS9LY29uZmlnOjExNDY6ICdlbmRpZicgaW4g
ZGlmZmVyZW50IGZpbGUgdGhhbiAnaWYnDQphcmNoL2FybS9tYWNoLXN1bnhpL0tjb25maWc6
MTogbG9jYXRpb24gb2YgdGhlICdpZicNCmFyY2gvYXJtL0tjb25maWc6MjQxNzogJ2VuZG1l
bnUnIGluIGRpZmZlcmVudCBmaWxlIHRoYW4gJ21lbnUnDQphcmNoL2FybS9tYWNoLXN1bnhp
L0tjb25maWc6MTogbG9jYXRpb24gb2YgdGhlICdtZW51DQoNCg0KQ2hlZXJzLA0KTGlZYQ0K
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLSZuYnNwO09yaWdpbmFsJm5ic3A7LS0tLS0tLS0tLS0t
LS0tLS0tDQpGcm9tOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICJBbmRyZSBQcnp5d2FyYSIgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA8YW5kcmUucHJ6eXdhcmFAYXJtLmNvbSZndDs7DQpEYXRlOiZu
YnNwO1R1ZSwgSmFuIDI4LCAyMDI1IDExOjU1IFBNDQpUbzombmJzcDsiu8bA+9HHIjwxNDI1
MDc1NjgzQHFxLmNvbSZndDs7DQpDYzombmJzcDsiQ2hyaXMgTW9yZ2FuIjxtYWNyb21vcmdh
bkBob3RtYWlsLmNvbSZndDs7IkphZ2FuIFRla2kiPGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMu
Y29tJmd0OzsiSmVybmVqIFNrcmFiZWMiPGplcm5lai5za3JhYmVjQGdtYWlsLmNvbSZndDs7
Ik1ha3NpbSBLaXNlbGV2IjxiaWd1bmNsZW1heEBnbWFpbC5jb20mZ3Q7OyJNaWNoYWVsIFdh
bGxlIjxtd2FsbGVAa2VybmVsLm9yZyZndDs7IlNhbXVlbCBIb2xsYW5kIjxzYW11ZWxAc2hv
bGxhbmQub3JnJmd0OzsiU2ltb24gR2xhc3MiPHNqZ0BjaHJvbWl1bS5vcmcmZ3Q7OyJTdW1p
dEdhcmciPHN1bWl0LmdhcmdAbGluYXJvLm9yZyZndDs7IlRvbSBSaW5pIjx0cmluaUBrb25z
dWxrby5jb20mZ3Q7OyJ1LWJvb3QiPHUtYm9vdEBsaXN0cy5kZW54LmRlJmd0OzsNClN1Ympl
Y3Q6Jm5ic3A7UmU6IFtQQVRDSF0gYXJtOiBUaGUgQ0hJUCBESVAgU0NBTiBvcHRpb24gc2hv
dWxkIG5vdCBiZSBkaXNwbGF5ZWQgaW4gb3RoZXIgbWFjaA0KDQoNCg0KT24gVHVlLCAyOCBK
YW4gMjAyNSAyMTozNzozNyArMDgwMA0KMTQyNTA3NTY4M0BxcS5jb20gd3JvdGU6DQoNCkhp
LA0KDQomZ3Q7IEZyb206IExpeWEgSHVhbmcgPDE0MjUwNzU2ODNAcXEuY29tJmd0Ow0KJmd0
OyANCiZndDsgV2hlbiBJIHVzZSBtYWNoIFNUTTMyLA0KJmd0OyBtZW51Y29uZmlnIHNlZXMg
dGhpcyBvcHRpb247IEl0IGJvdGhlcnMgbWUuDQomZ3Q7IEkgb2JzZXJ2ZWQgdGhhdCB0aGUg
cm9vdCBjYXVzZSB3YXMgdGhhdCB0aGUNCiZndDsgb3B0aW9uIHdhcyBub3QgaW5jbHVkZWQg
aW4gdGhlIGVuZGlmLA0KJmd0OyBidXQgd2hlbiBJIHRyaWVkIHRvIGZpeCBpdCwgYW4gZXJy
b3Igb2NjdXJyZWQuDQoNCkNhbiB5b3Ugc2F5IHdoYXQgdGhlIGVycm9yIGlzLCBleGFjdGx5
Pw0KQmVjYXVzZSB5b3UgYXJlIHJpZ2h0LCBpdCBzaG91bGQgYmUgYmVmb3JlIHRoZSBlbmRp
Zi4NCkkgbW92ZWQgdGhhdCwgYW5kIGNvbXBpbGVkIGl0IGZvciBhbGwgQWxsd2lubmVyIGJv
YXJkcywgd2hpY2ggd29ya2VkLg0KU28gd2hhdCBpcyB0aGUgcHJvYmxlbSB0aGVyZSwgZXhh
Y3RseT8NCg0KQ2hlZXJzLA0KQW5kcmUNCg0KJmd0OyBJIGRpZG4ndCBmaW5kIGEgc29sdXRp
b24uIE9ubHkgZGVwb25kcyBjYW4gYmUgdXNlZCBmb3IgaGlkaW5nLg0KJmd0OyANCiZndDsg
U2lnbmVkLW9mZi1ieTogTGl5YSBIdWFuZyA8MTQyNTA3NTY4M0BxcS5jb20mZ3Q7DQomZ3Q7
IC0tLQ0KJmd0OyANCiZndDsmbmJzcDsgYXJjaC9hcm0vbWFjaC1zdW54aS9LY29uZmlnIHwg
MSArDQomZ3Q7Jm5ic3A7IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KJmd0OyAN
CiZndDsgZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtc3VueGkvS2NvbmZpZyBiL2FyY2gv
YXJtL21hY2gtc3VueGkvS2NvbmZpZw0KJmd0OyBpbmRleCBiYTFiMTU0MTQzNy4uNDhkZDFl
NjgzNjMgMTAwNjQ0DQomZ3Q7IC0tLSBhL2FyY2gvYXJtL21hY2gtc3VueGkvS2NvbmZpZw0K
Jmd0OyArKysgYi9hcmNoL2FybS9tYWNoLXN1bnhpL0tjb25maWcNCiZndDsgQEAgLTExMzcs
NiArMTEzNyw3IEBAIGVuZGlmDQomZ3Q7Jm5ic3A7IA0KJmd0OyZuYnNwOyBjb25maWcgQ0hJ
UF9ESVBfU0NBTg0KJmd0OyZuYnNwOyAJYm9vbCAiRW5hYmxlIERJUHMgZGV0ZWN0aW9uIGZv
ciBDSElQIGJvYXJkIg0KJmd0OyArCWRlcGVuZHMgb24gQVJDSF9TVU5YSQ0KJmd0OyZuYnNw
OyAJc2VsZWN0IFNVUFBPUlRfRVhURU5TSU9OX1NDQU4NCiZndDsmbmJzcDsgCXNlbGVjdCBX
MQ0KJmd0OyZuYnNwOyAJc2VsZWN0IFcxX0dQSU8=
