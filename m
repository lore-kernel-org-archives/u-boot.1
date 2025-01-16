Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC87C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 00:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60AE18033D;
	Thu, 16 Jan 2025 01:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="PC4NqLfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A9A88069D; Thu, 16 Jan 2025 01:24:53 +0100 (CET)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B3BC80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 01:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1736987085; bh=sKaTFM8lUoT6CHV+wUua6N0CToCb020B2LyXcwYJdtc=;
 h=In-Reply-To:References:From:To:Cc:Subject:Date;
 b=PC4NqLfu4yxjqHjVStxuhoAHT+f2uNpXf1nKJJkkuHamV81U4o1UVUbtIOTHgwxWR
 +mNnNVkQZ9DE9T+ceYzLXAJPDXGRUElilUDhudZAhwxkz0HrpWPkQZwSMszZ7VGQuY
 NPV89o/VzBZS+kd6mFUZSXJJErxODg3NnbuV0L+o=
X-QQ-FEAT: oHWrrGTW1dCni6VLWI7Xi3lwP5c1dnPf
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-XMAILINFO: Md8NwmqZYy3fvageUsGvioLMQKwZ/e5O3VMtFpPZYs5KnR8tc42GI9P7oqBZiL
 hhDlD7aIptDJE8mKxJ5t6g4pel0mPGXmcZC4OqqXRQmeAo/fvdk52uJqRcyxDiTceJUtMtSJUqHPc
 PTfkg+UrR2AZNovMCvR8Qpw/HY6GYf0ZQUQKbiPGIxzFjgX5rG9rY4/VqJIB/1T+k3hiewODDJ9kV
 81KoGMdmKndyLr1X8dThSYJajVEX6HkFkR0KJIv3Q0UVD6agAT3RbeGHrdsE25wuG8k+n5iZgpv9b
 F0tQ0IPWl3Sk61UZ8XPbluumfdx736n5CGKwN391pb60VN7HG7tv5gRlqi+HuLjdCEkr1yBGmf4Kq
 V+KrfCsL9dCWP0k4UKcMb8gkSE7TqFEeU54Ux5QaT2Fv1ItX+AHJhV5xcdxtCoZfqsYS9BvmtaoMd
 6Wsm+zQC3XQ46FInpAkJ00GAtdXy23l/zLUSe5PWqL+iHOswPAn1hIlwu/02if+jppBMAcToJKHyl
 otaH4sQfIPkiv59WqA8tAuXvapEwL4i//OyQ5b/De47Cgp3+SXUF6OUpiaonGfEn8somn1SvdFVzy
 OC2Ku6iP7VDonaLlZMOujJyJqA3ycxqX8Gp9JYaB29/grTFMQFeZPuy4yFDQfHNLMnMqNSdAER3vA
 FB0C36F8kSR3EAPjLPXIpDY1Haol1LwsX77uDAHb7mAFX5mOxYcxcI7atx4NY1IkGHh+8YdnYhQTG
 /H+XiOLU438FskeDQGAMterm46fCKbM6KDVUcE+TIfdChEAHtkaPMQ2bAyB2immS0qJ0ovMhbIqPq
 NZe0IhpPZHNtu77/pDQMh3kIE2TBDjzMA271WqAEEZ8vMHMULyzXmJCSqoScxG+kFF94OJtR8iy5d
 /cHgAAmdUY6MRBzc/R2EYQRqDzknC7FHDkBTWPBivkhnFZuvtgTqIh3C7sLRzHBsdGfWC5edAAxJ3
 I7tVPX8khaJjONX1d/
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 218.104.148.31
In-Reply-To: <3d51107a-4761-4de8-9bae-a462c2a8e890@cherry.de>
References: <tencent_9739C1044069984893BE3E6D3DB783BB6C08@qq.com>
 <3d51107a-4761-4de8-9bae-a462c2a8e890@cherry.de>
X-QQ-STYLE: 
X-QQ-mid: webmail864t1736987084t294286
From: "=?gb18030?B?u8bA+9HH?=" <1425075683@qq.com>
To: "=?gb18030?B?UXVlbnRpbiBTY2h1bHo=?=" <quentin.schulz@cherry.de>,
 "=?gb18030?B?dS1ib290?=" <u-boot@lists.denx.de>
Cc: "=?gb18030?B?U2ltb24gR2xhc3M=?=" <sjg@chromium.org>,
 "=?gb18030?B?VG9tIFJpbmk=?=" <trini@konsulko.com>
Subject: =?gb18030?B?u9i4tKO6IFtQQVRDSF0gbGlua2VyX2xpc3RzOiBV?=
 =?gb18030?B?cGRhdGUgdGhlIGFsaWdubWVudCB1c2luZyBDT05G?=
 =?gb18030?B?SUdfTElOS0VSX0xJU1RfQUxJR04=?=
Mime-Version: 1.0
Date: Thu, 16 Jan 2025 08:24:44 +0800
X-Priority: 3
Message-ID: <tencent_B912404198CB93E73E013D2783596C4DC108@qq.com>
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

U29ycnkgZm9yIHRoZSBjb25mdXNpb24gYW5kIGRpc3J1cHRpb24uJm5ic3A7DQpJIGhhdmVu
J3Qgc3VibWl0dGVkIHBhdGNoZXMgdGhpcyB3YXkgYmVmb3JlLCZuYnNwOw0KYW5kIG15IEVu
Z2xpc2ggaXMgbm90IHZlcnkgZ29vZC4mbmJzcDsNCkkgd2FzIGNvbmR1Y3RlZCBhY2NvcmRp
bmcgdG8gdGhlIHN0ZXBzJm5ic3A7DQppbiB0aGUgaHR0cHM6Ly9kb2NzLnUtYm9vdC5vcmcv
ZW4vbGF0ZXN0L2RldmVsb3AvcGF0bWFuLmh0bWwgb3BlcmF0aW9uLg0KDQoNCkNhbiB5b3Ug
dGVsbCBtZSB3aGF0IGVsc2UgSSBuZWVkIHRvIGRvPyZuYnNwOw0KV2hhdCBJIGtub3cgc28g
ZmFyIGlzIDoNCjEuIEkgc2hvdWxkIHVzZSBhbm90aGVyIGVtYWlsIGFkZHJlc3M7Jm5ic3A7
DQoyLiBTZWVtcyBsaWtlIGkgc2hvdWxkbid0IHNlbmQgcGF0Y2hlcyBkaXJlY3RseSB0byB0
aGlzIGxpc3Q/DQombmJzcDtBbmQgaXQncyBvbmx5IHN1Ym1pdHRlZCB0byB0aGUgcmV2aWV3
ZXIgZm9yIHJldmlldyBhbmQgdGhlbiBzdWJtaXR0ZWQgYnkgdGhlIHJldmlld2VyPw0KDQoN
Cg0KDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tJm5ic3A71K3KvNPKvP4mbmJzcDstLS0tLS0t
LS0tLS0tLS0tLS0NCreivP7IyzogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiUXVlbnRpbiBTY2h1bHoiICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgPHF1ZW50aW4uc2NodWx6QGNoZXJyeS5kZSZndDs7
DQq3osvNyrG85DombmJzcDsyMDI1xOox1MIxNcjVKNDHxtrI/Skgze3JzzY6NTgNCsrVvP7I
yzombmJzcDsiu8bA+9HHIjwxNDI1MDc1NjgzQHFxLmNvbSZndDs7InUtYm9vdCI8dS1ib290
QGxpc3RzLmRlbnguZGUmZ3Q7Ow0Ks63LzTombmJzcDsiU2ltb24gR2xhc3MiPHNqZ0BjaHJv
bWl1bS5vcmcmZ3Q7OyJUb20gUmluaSI8dHJpbmlAa29uc3Vsa28uY29tJmd0OzsNCtb3zOI6
Jm5ic3A7UmU6IFtQQVRDSF0gbGlua2VyX2xpc3RzOiBVcGRhdGUgdGhlIGFsaWdubWVudCB1
c2luZyBDT05GSUdfTElOS0VSX0xJU1RfQUxJR04NCg0KDQoNCkhpIExpeWEsDQoNCk9uIDEv
MTQvMjUgODowOSBBTSwgMTQyNTA3NTY4M0BxcS5jb20gd3JvdGU6DQomZ3Q7IFtZb3UgZG9u
J3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gMTQyNTA3NTY4M0BxcS5jb20uIExlYXJuIHdoeSB0
aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRl
bnRpZmljYXRpb24gXQ0KJmd0OyANCiZndDsgRnJvbTogTGl5YSBIdWFuZyA8MTQyNTA3NTY4
M0BxcS5jb20mZ3Q7DQomZ3Q7IA0KJmd0OyBUaGlzIHBhdGNoIHVwZGF0ZXMgdGhlIGFsaWdu
bWVudCBvZiBsaW5rZXIgbGlzdHMgdG8gdXNlIHRoZQ0KJmd0OyBDT05GSUdfTElOS0VSX0xJ
U1RfQUxJR04gbWFjcm8gaW5zdGVhZCBvZiBhIGhhcmRjb2RlZCB2YWx1ZS4NCiZndDsgVGhp
cyBlbnN1cmVzIHRoYXQgdGhlIGFsaWdubWVudCBpcyBjb25zaXN0ZW50IHdpdGggdGhlIGNv
bmZpZ3VyYXRpb24uDQomZ3Q7IFJlcGxhY2UgX19hdHRyaWJ1dGVfXygodW51c2VkKSkgd2l0
aCBfX21heWJlX3VudXNlZCBhbmQNCiZndDsgX19hbHdheXNfdW51c2VkIHRvIGVsaW1pbmF0
ZSB0aGUgd2FybmluZyBvZiBjaGVja3BhdGNoLnBsLg0KJmd0OyANCiZndDsgUmV2aWV3ZWQt
Ynk6IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnJmd0Ow0KDQpUaGlzLi4uIGlzIG9k
ZC4gSSBkb24ndCBzZWUgYW4gZWFybGllciB2ZXJzaW9uIG9mIHRoYXQgcGF0Y2ggYW5kIHlv
dXIgDQpuYW1lL21haWwgb25seSByZXR1cm5zIHR3byBwYXRjaGVzIG9uIHRoZSBVLUJvb3Qg
bWFpbGluZyBsaXN0LiBJIGJlbGlldmUgDQpSZXZpZXdlZC1ieSBuZWVkcyB0byBiZSBwdWJs
aWNseSBnaXZlbiBvbiB0aGUgTUwgYXMgdGhleSBhcmUgYSBwcm9vZiBvZiANCnJldmlldyBi
eSB0aGUgbWVudGlvbmVkIHBlcnNvbiBhbmQgaXMgdXN1YWxseSBhIHRydXN0IG1hcmsgZm9y
IA0KbWFpbnRhaW5lcnMgdG8gbWVyZ2UgY29kZS4gSGVyZSBpdCBtYXkgaGF2ZSBiZWVuIGFk
ZGVkIHdpdGhvdXQgU2ltb24ncyANCmNvbnNlbnQuIE5vdyBpbWFnaW5lIFNpbW9uIGlzIG5v
dCBhbnN3ZXJpbmcgZm9yIGEgZmV3IGRheXMvd2Vla3MsIHRoZSANCm1haW50YWluZXIgY291
bGQgc3RpbGwgYmVsaWV2ZSBTaW1vbiB3ZW50IHRocm91Z2ggYSBwcm9wZXIgcmV2aWV3IGFu
ZCANCm1lcmdlIHRoYXQgcGF0Y2ggdGFraW5nIHRoYXQgaW50byBhY2NvdW50IHdoaWxlIG5v
IHJldmlldyBtYXkgYWN0dWFsbHkgDQpoYXZlIGJlZW4gY29uZHVjdGVkLiBUaGlzIGlzIG1h
a2luZyBtZSB1bmNvbWZvcnRhYmxlLg0KDQpTYW1lIGlzc3VlIGZvciANCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3UtYm9vdC90ZW5jZW50X0NDRTgzMDM5MjY5NTdDNDI3QUFFMDZGOUQ5
MTI4MjQ1ODEwOUBxcS5jb20vLg0KDQpJJ20gbm90IHNheWluZyByZXZpZXcgd2Fzbid0IGRv
bmUgcHJvcGVybHksIGJ1dCBpdHMgYWNrbm93bGVkZ21lbnQgDQpzaG91bGQgYmUgbWFkZSBw
dWJsaWMgYnkgdGhlIG1lbnRpb25lZCBwZXJzb24gaW5zdGVhZCBvZiBiZWluZyBwdXQgaW50
byANCnRoZSB2MS4NCg0KSGF2ZSBJIG1pc3NlZCBhbiBlYXJsaWVyIHZlcnNpb24gb3IgZGlz
Y3Vzc2lvbiBtYXliZT8NCg0KQ2hlZXJzLA0KUXVlbnRpbg==
