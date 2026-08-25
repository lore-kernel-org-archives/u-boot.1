Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3126C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 10:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA68780C79;
	Tue, 25 Aug 2026 10:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gm6HhAy0FDpm; Tue, 25 Aug 2026 10:59:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787655588;
	bh=8Np9zQkZg3MD+Y8pIxE8v8VtRDK4hclKwUVel2Voze0=;
	h=Date:From:Subject:References:To:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CH96OIXLP3AZZmcVVg7O+VOcbvukVkvVQmrOnHvD0hND7R69iXcYL1Qh1oTalv+pk
	 afnfdmOQKlU/jy0spPWe8T0XkRPQ9T3A0Z6n94dKFX8+fEiGiLyl8cwT+1j2c24Qqb
	 8yCY3Z7sDMBlUKTbwZgG079WrRAdPlRWgDwXQP2V7Utj9l7yZYolFj4HzuS7Oh6LsN
	 Pa3b0WMfhCMDjFaFljtkbBMTPAuctMd8Vc7angzAGMKTYdjYBs6oqu2vcr702cVMj/
	 8fAmPDqEYlecJWjdfTztJEGG3zoyfSlLI+m2TueKc2Myp4B2mwHjHNWrZPGkcDlkOW
	 +udA0pD6LBQNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12EE980C49;
	Tue, 25 Aug 2026 10:59:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 710FF2FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 10:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5708F6060B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 10:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kLPq9caz6zGo for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 10:59:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=129.217.128.51;
 helo=unimail.uni-dortmund.de; envelope-from=andre.althaus@tu-dortmund.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=tu-dortmund.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=tu-dortmund.de header.i=@tu-dortmund.de
 header.a=rsa-sha256 header.s=unimail header.b=nC5QFSlA
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de
 [129.217.128.51])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA68D60608
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
 s=unimail; t=1787655580;
 bh=8Np9zQkZg3MD+Y8pIxE8v8VtRDK4hclKwUVel2Voze0=;
 h=Date:From:Subject:References:To:In-Reply-To;
 b=nC5QFSlA38jECdHqpkHnDU/RF5Ljhz6GgAyHAYpltl/4IHDtmN05CykGwJzJhEq00
 bvszLXcuFgBTrcuRcON4XL0xpRRubn48g6cVUmAi8JuNg5WAdQ5gFrfOT2sR304qN/
 TfnTAQoaaVDiVBebAJ1XwsQhXei/NNQUaiG+ixbY=
Received: from [129.217.164.210] (sysrescue.buero.delta.tu-dortmund.de
 [129.217.164.210]) (authenticated bits=0)
 by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 67PAxebR018174
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:59:40 +0200 (CEST)
Message-ID: <019f9483-9642-4d3a-b27d-a0e80c131193@tu-dortmund.de>
Date: Tue, 25 Aug 2026 12:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Andr=C3=A9_Althaus?= <andre.althaus@tu-dortmund.de>
Subject: [PATCH] bcmgenet: Reset the PHY of Raspberry Pi
References: <>
Content-Language: en-US-large, de-DE
To: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
In-Reply-To: <>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms050903090602010507030504"
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

This is a cryptographically signed message in MIME format.

--------------ms050903090602010507030504
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

VGhlIFJhc3BiZXJyeSBQaSBmaXJtd2FyZSBzdXBwb3J0cyBuZXRib290aW5nIHZpYSB0ZnRw
Lg0KV2hlbiBVLUJvb3QgaXMgcnVuIHRoaXMgd2F5IGFzIHRoZSBrZXJuZWwsIHRoZSBuZXR3
b3JrIGluIFUtQm9vdA0KaXMgdW5zdGFibGUgcmVzdWx0aW5nIGluIG11bHRpcGxlIERIQ1Ag
cmV0cmllcyAoc29tZXRpbWVzIG5vIElQIGF0IGFsbCkNCmFuZCB0aW1lb3V0cyBkdXJpbmcg
VS1Cb290cyB0ZnRwIHRyYW5zZmVycy4NCg0KSXQgc2VlbXMgdGhhdCB0aGUgZmlybXdhcmUg
ZG9lcyBub3QgY29tcGxldGVseSByZXNldCB0aGUgUEhZIGFuZCB3aGVuDQpVLUJvb3QgY29u
ZmlndXJlcyBpdCwgc29tZSBzZXR0aW5ncyBhcmUgbm90IGNvcnJlY3QuDQpSZXNldCB0aGUg
cGh5IHZpYSBwaHlfcmVzZXQoKSBkdXJpbmcgdGhlIGJjbWdlbmV0X3BoeV9pbml0KCkgY2Fs
bC4NCg0KU2lnbmVkLW9mZi1ieTogQW5kcsOpIEFsdGhhdXMgPGFuZHJlLmFsdGhhdXNAdHUt
ZG9ydG11bmQuZGU+DQoNCi0tLQ0KSSB0ZXN0ZWQgaXQgb24gYSBSYXNwYmVycnkgUGkgNEIu
IFdoZW4gYm9vdGluZyBVLUJvb3QgZnJvbSBhbiBTRCBjYXJkLA0KdGhlIG5ldHdvcmsgaXMg
c3RhYmxlLCBib290aW5nIHdpdGggdGhlIHNhbWUgZmlsZXMgb3ZlciB0aGUgbmV0d29yaw0K
YW5kIGl0IGlzIHVuc3RhYmxlLiBBZnRlciBhcHBsaW5nIHRoZSBwYXRjaCB0aGUgbmV0d29y
ayBpcyBhbHNvDQpzdGFibGUgYWZ0ZXIgbmV0Ym9vdGluZy4NCi0tLQ0KICBkcml2ZXJzL25l
dC9iY21nZW5ldC5jIHwgNCArKysrDQogIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2JjbWdlbmV0LmMgYi9kcml2ZXJzL25l
dC9iY21nZW5ldC5jDQppbmRleCBhMDI2NGRjMzg2ZC4uZjIyNTNiMjViYzEgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL25ldC9iY21nZW5ldC5jDQorKysgYi9kcml2ZXJzL25ldC9iY21nZW5l
dC5jDQpAQCAtNTIyLDYgKzUyMiwxMCBAQCBzdGF0aWMgaW50IGJjbWdlbmV0X3BoeV9pbml0
KHN0cnVjdCANCmJjbWdlbmV0X2V0aF9wcml2ICpwcml2LCB2b2lkICpkZXYpDQogIAlpZiAo
IXBoeWRldikNCiAgCQlyZXR1cm4gLUVOT0RFVjsNCg0KKwlyZXQgPSBwaHlfcmVzZXQocGh5
ZGV2KTsNCisJaWYgKHJldCkNCisJCXJldHVybiByZXQ7DQorDQogIAlwaHlkZXYtPnN1cHBv
cnRlZCAmPSBQSFlfR0JJVF9GRUFUVVJFUzsNCiAgCWlmIChwcml2LT5zcGVlZCkgew0KICAJ
CXJldCA9IHBoeV9zZXRfc3VwcG9ydGVkKHByaXYtPnBoeWRldiwgcHJpdi0+c3BlZWQpOw0K
LS0gDQoyLjU1LjANCg0K

--------------ms050903090602010507030504
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Kryptografische S/MIME-Signatur

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
C6wwggVgMIIDyKADAgECAhAyEt9rKOAjKH3jCZM+23iLMA0GCSqGSIb3DQEBCwUAMGMxCzAJ
BgNVBAYTAkdSMTcwNQYDVQQKDC5IZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFyY2ggSW5z
dGl0dXRpb25zIENBMRswGQYDVQQDDBJHRUFOVCBTL01JTUUgUlNBIDEwHhcNMjUwNjEwMDgx
NzU5WhcNMjcwNjEwMDgxNzU5WjAtMSswKQYJKoZIhvcNAQkBFhxhbmRyZS5hbHRoYXVzQHR1
LWRvcnRtdW5kLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4pqo43YSc3ty
XKupACKwwbUB/zT6+5OczW6WCRayC8ygrIjaNULC2C7ZZpCiwGQxSPeOfoXoZOZEaqhND139
H0f/9Knt5nfTK6LKYcVw0nEu0FAKyScKj+tZnTPzSDO2EP7+H93LHKfTSzJSR2Xq1zGcHfyG
lmKN/hnKK1xko1CBgIbi4YmqBZbO8JNQQ2FUFcoV35IGu4/HkROzcby9YecnT37lGMGnXsDV
7hwyrTz2RBdWWrizyZqpLm9WhJgJLWQPp5uYTaUs6UEO6ByihmH5D4zrDIO6ZxTkajD4Uk3q
LbP0NTTxUzeDrOzkIB8PguQbpcmGcyTH5zrtC69SVwIDAQABo4IBxDCCAcAwHwYDVR0jBBgw
FoAU67IvO/2uAswqRAZdJc0dEiJosEcwSgYIKwYBBQUHAQEEPjA8MDoGCCsGAQUFBzAChi5o
dHRwOi8vY3J0LmhhcmljYS5nci9IQVJJQ0EtR0VBTlQtU01JTUUtUjEuY2VyMF0GA1UdEQRW
MFSBHGFuZHJlLmFsdGhhdXNAdHUtZG9ydG11bmQuZGWBHWFuZHJlLmFsdGhhdXNAdW5pLWRv
cnRtdW5kLmRlgRVhbmRyZS5hbHRoYXVzQHVkby5lZHUwYwYDVR0gBFwwWjAJBgdngQwBBQEC
MAgGBgQAj3oBAzBDBg0rBgEEAYHPEQEBAgECMDIwMAYIKwYBBQUHAgEWJGh0dHBzOi8vcmVw
by5oYXJpY2EuZ3IvZG9jdW1lbnRzL0NQUzAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUH
AwQwPwYDVR0fBDgwNjA0oDKgMIYuaHR0cDovL2NybC5oYXJpY2EuZ3IvSEFSSUNBLUdFQU5U
LVNNSU1FLVIxLmNybDAdBgNVHQ4EFgQUPCv1Yq79w7k5oLSorLTkLojYBm4wDgYDVR0PAQH/
BAQDAgWgMA0GCSqGSIb3DQEBCwUAA4IBgQBOjBEj+JDtxq9fN9uMpY6wGiW5dgctp84AKhPs
lWO4yZW/r9+IFKlDpNINbnZDtHmQNNn+tCh3ncndwKE3FMAuKdvZ5SWYSoYl45ImaYfn+WpR
my/F1WhiLvhTQ5zVW04Jf+lfQlEa2rY/pUM57SGpX+/JTnfQGf3ldQywS8r+PSBU3jEKeMc8
eYFh2khEDS/9DCX6o0SL878GNqtP3UMX+mGkcWj1BR7wMgMhxcAvTJ09HJQJb6rZKADAkuiZ
KcKdGfREe17uXywUFiHR2DhZH6zDvzdjk3FYKHYPuIcoTQBsb9se9a7jfoxF8+/WFaa6NIhZ
z1PIPcpEY5azOFaf/UoM+6owTyIyORSdw/8taS7JuHkk+W/wK1kZb8Z+dsS2QwK4lGpjSyxV
/2mePUrHIFTHMVftTuSny/sucGVgVwCGf3S7lZ4iQZ39ylv45abvBRPXTgDYR+80RnqDE0TZ
fbXQWMAQRvRf2A5yavNhWAhzJVA7pKIuC/EVmkms4uUwggZEMIIELKADAgECAhAV+a5sqo0u
1NNveH8e3HsBMA0GCSqGSIb3DQEBCwUAMG8xCzAJBgNVBAYTAkdSMTcwNQYDVQQKDC5IZWxs
ZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFyY2ggSW5zdGl0dXRpb25zIENBMScwJQYDVQQDDB5I
QVJJQ0EgQ2xpZW50IFJTQSBSb290IENBIDIwMjEwHhcNMjUwMTAzMTExMzA4WhcNMzkxMjMx
MTExMzA3WjBjMQswCQYDVQQGEwJHUjE3MDUGA1UECgwuSGVsbGVuaWMgQWNhZGVtaWMgYW5k
IFJlc2VhcmNoIEluc3RpdHV0aW9ucyBDQTEbMBkGA1UEAwwSR0VBTlQgUy9NSU1FIFJTQSAx
MIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAq7hur/5vIqMejblfPfZgGY75auSZ
z5SZ9x1dIIjvJrDBT0lIwQcAAoABJomkuv0kDK362UH+uf9JrOdLBjiKkEh99HQPmT+d1+Ij
nnd1aAjiL+2Q4aU16P/snITYJL2ROU46zqmDkdoOnCqMCEKSN74gHKDmApYfqXO8wmjmNA62
wYHarp7lxgrBr0sk4BxHyKq52z0sWyxsdIy5V1K5OOkCNwYupZ9b74LRhelYP5SieNDqU0S6
IpQOasVz5IS0vDnqVi2ni67Gbgtb8dBKzH6gbAwGppHoeEFDcvJ042Oxtxt6BGolkUmguyfA
geisRqDjhQi+NfNgkDH81OLBV0eV07twS9axwNvJAtH2SgGiWKrYeuBgVCzs1DFT7sws1KHy
LrOdZU0hJQSDfoz/8jwFmXhWoPvQQuWEoo3uvH6LsHAo53aDF1aAUmGQ/JC72j7zZH16leJF
uWj+t2TK/7YEVHtWluA9TOdx2Lz/SHh0/+pAVicD4N/QUWPuBhzPAgMBAAGjggFmMIIBYjAS
BgNVHRMBAf8ECDAGAQH/AgEAMB8GA1UdIwQYMBaAFKDWBz1eJPd7oEQuJFINGaorBJGnMFAG
CCsGAQUFBwEBBEQwQjBABggrBgEFBQcwAoY0aHR0cDovL2NydC5oYXJpY2EuZ3IvSEFSSUNB
LUNsaWVudC1Sb290LTIwMjEtUlNBLmNlcjBEBgNVHSAEPTA7MDkGBFUdIAAwMTAvBggrBgEF
BQcCARYjaHR0cDovL3JlcG8uaGFyaWNhLmdyL2RvY3VtZW50cy9DUFMwHQYDVR0lBBYwFAYI
KwYBBQUHAwIGCCsGAQUFBwMEMEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwuaGFyaWNh
LmdyL0hBUklDQS1DbGllbnQtUm9vdC0yMDIxLVJTQS5jcmwwHQYDVR0OBBYEFOuyLzv9rgLM
KkQGXSXNHRIiaLBHMA4GA1UdDwEB/wQEAwIBhjANBgkqhkiG9w0BAQsFAAOCAgEAO964Rfbc
PCuTKAq2wXsOZxMaaLxITbSOYkt7RMxPw3CzU2qmkTQALKbVqC1jUiNQWbkxZpsb8hy9FOHy
wH1xFmANAypks0Iuh+ovhqP90oFcfhvAfYxV2M0cGga9mTKFHP+QET7HW9pZdyWFZAw5fmdW
9Ex+IQmJii0w/sozzwhpVn0OQYkkRV+2ydRa68JZS2NqAPpdaWoseM2X4u5+Jn+H2UO9paob
X+ht91K2Ch8xzfREv4RLqBgpHBmkIDVygXNdXsKfDHy2hOXxtF6oI1d7ErPGWoBxFc86aUqQ
lC6pEjb3ug24w+eg1kJj7IufHJ3iRm67Rdw5M1OlWMzxu+DwAKqFJhqes0OL/NOJOTuDCb0b
IfVfjl8U0Y0QWCkhoCmNPZQQu6QM6Y/XxnALgRB4drA8kip98wSZQmbqptE8oac2ZzLKCHiJ
lTdBuREsundnpBXdahMSrJ/mYv2pMZLpYkbrkvyhorDVeH9t0a5UgPIFqGl8/ZzakJ3RQfr7
HvdGur0YWU6KNWvY5BK8qHMRM0b3XtK9xREIGEychAVReodDIhjrR4fWmjpa006r/UrmSk4b
pKrVFVzTYsSK3jy4ri1ExVQp6RI6Ou4ZdbfwOYCuI9wweMjpVBuqNzRKrVU/Pvp57gUzm4u+
JJRkdioMOoxZrwsUiYr2KIojwTcxggORMIIDjQIBATB3MGMxCzAJBgNVBAYTAkdSMTcwNQYD
VQQKDC5IZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFyY2ggSW5zdGl0dXRpb25zIENBMRsw
GQYDVQQDDBJHRUFOVCBTL01JTUUgUlNBIDECEDIS32so4CMofeMJkz7beIswDQYJYIZIAWUD
BAIBBQCgggHrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2
MDgyNTEwNTk0MFowLwYJKoZIhvcNAQkEMSIEIKkHC2lWO74maD4aD5eJIVYzSJXrHM1mUtfy
f0pL/1cWMIIBfgYJKoZIhvcNAQkPMYIBbzCCAWswCwYJYIZIAWUDBAEuMAsGCWCGSAFlAwQB
GjALBglghkgBZQMEAQYwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAN
BggqhkiG9w0DAgIBBTANBggqhkiG9w0DAgIBBTAHBgUrDgMCBzANBggqhkiG9w0DAgIBBTAH
BgUrDgMCGjALBglghkgBZQMEAgEwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCAzALBglghkgB
ZQMEAgQwCwYJYIZIAWUDBAIHMAsGCWCGSAFlAwQCCDALBglghkgBZQMEAgkwCwYJYIZIAWUD
BAIKMAsGCSqGSIb3DQEBATALBgkrgQUQhkg/AAIwCAYGK4EEAQsAMAgGBiuBBAELATAIBgYr
gQQBCwIwCAYGK4EEAQsDMAsGCSuBBRCGSD8AAzAIBgYrgQQBDgAwCAYGK4EEAQ4BMAgGBiuB
BAEOAjAIBgYrgQQBDgMwDQYJKoZIhvcNAQEBBQAEggEAYQhZfWxEyN+39akly8sA8RvUU648
ayCA33aL9JGZntkVdGH0IVMnFLB9UGddVQ2XEGrLLOW8lwf+kpTFzgNS21lH6PbC5DEGng6d
IRN7+tN1IIn9UwfwQ+LR+b1A+pgDY5fqFGCw/9x550vHXchgGa84g8PK8U7ReuEgKDOUZPxH
aNSy9NGhpuxeP37pK5iRlE8eE67+ARgS6Sl/Ycl+AYGMyCYewroI9pKRv0ANEFhvxPd9uJb+
tONX1g+GUf2abay002Xi++fCbn51tTTgxPn8cDuNx6l5mmACCtnlSLi6ECXdGz07IHv8HVc/
kc1VHhN0ZPEDp1qYhZNC2ABpJQAAAAAAAA==
--------------ms050903090602010507030504--
