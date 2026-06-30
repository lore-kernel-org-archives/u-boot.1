Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E893C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 13:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7812384AC8;
	Tue, 30 Jun 2026 15:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="nFC1xFVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B09484A77; Tue, 30 Jun 2026 15:25:27 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08DA884A52
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 15:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=13738176232@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=YH7FONEYl5eU77xV88lGuRGis+0jg10T7zm5orBdvHc=; b=n
 FC1xFVDdyXSIkT5AXagHhIy046mUkyTj88gA+EgcNjdUFTvSs6lcETohkwswgLtY
 gIqB52zhFGVm2eczTzseJ3w7cqhw5+eokzjfAGWzWfgT/6AAYRrghx/KD2m0dOKg
 2gkTKoW10B2uV9npRkpwsDUP5KMoslgjTCyZ2LWNos=
Received: from 13738176232$163.com (
 [2409:8a28:ccd:4b56:bd85:3670:c797:8bd2] ) by ajax-webmail-wmsvr-40-119
 (Coremail) ; Tue, 30 Jun 2026 21:25:18 +0800 (CST)
X-Originating-IP: [2409:8a28:ccd:4b56:bd85:3670:c797:8bd2]
Date: Tue, 30 Jun 2026 21:25:18 +0800 (CST)
From: BruceYang  <13738176232@163.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>
Cc: u-boot <u-boot@lists.denx.de>, "bmeng.cn" <bmeng.cn@gmail.com>
Subject: Re:Re: [PATCH] usb: xhci: Fix bNbrPorts overwritten by another
 controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <3e01c1fe-3e8f-402c-a823-8fca9f6c2a3a@mailbox.org>
References: <1782563839-11379-1-git-send-email-13738176232@163.com>
 <dc5ecf1c-ee61-4434-a19b-966f287f1533@mailbox.org>
 <5165dbf8.4708d.19f120e171a.Coremail.13738176232@163.com>
 <3e01c1fe-3e8f-402c-a823-8fca9f6c2a3a@mailbox.org>
X-NTES-SC: AL_Qu2TAPSZukEq7iaZYekfmUsVj+04Xsu5vPQn24FWPJh6jD7p4AocfVhFMH3S+uGQLQmujAOQYAZJ9ORFWbVmdZMGqOFg2MJ+xkLEM6PgDy+h1Q==
Content-Type: multipart/mixed; 
 boundary="----=_Part_149439_1614822023.1782825918623"
MIME-Version: 1.0
Message-ID: <53ed0453.9aa5.19f18b4a0a0.Coremail.13738176232@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dygvCgD3f+i+w0NqmysUAA--.1501W
X-CM-SenderInfo: zprtljayrxljits6il2tof0z/xtbCzh6L9mpDw77QxwAA3u
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Tue, 30 Jun 2026 15:39:51 +0200
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

------=_Part_149439_1614822023.1782825918623
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

TmV3IHBhdGNoIGFzIGF0dGFjaG1lbnQsIHRoYW5rIHlvdS4KCgoKCgoKCgoKCgpBdCAyMDI2LTA2
LTMwIDA1OjQ5OjQ1LCAiTWFyZWsgVmFzdXQiIDxtYXJlay52YXN1dEBtYWlsYm94Lm9yZz4gd3Jv
dGU6Cj5PbiA2LzI5LzI2IDg6MjUgQU0sIG0xMzczODE3NjIzMiB3cm90ZToKPj4gRm9yIHRoZSBg
c3RydWN0IGRlc2NyaXB0b3JgLCBvbmx5IHRoZSBgaHViYCBwYXJ0IChgYk5iclBvcnRzYCBhbmQg
YHdIdWJDaGFyYWN0ZXJpc3RpY3NgKSBpcyBkaWZmZXJlbnQgZm9yIGVhY2ggY29udHJvbGxlcjsg
dGhlIG90aGVyIGZpdmUgbWVtYmVycyAoZGV2aWNlLCBjb25maWcsIGludGVyZmFjZSwgZW5kcG9p
bnQsZXBfY29tcGFuaW9uKWFyZSBpZGVudGljYWwgZm9yIGFsbCBYSENJIHJvb3QgaHVicy4KPj4g
Cj4+IE15IHByZXZpb3VzIHBhdGNoIG9ubHkgZml4ZWQgdGhlIGR5bmFtaWMgcmVhZGluZyBvZiBg
Yk5iclBvcnRzYCwgYnV0IGB3SHViQ2hhcmFjdGVyaXN0aWNzYCBpcyBhbHNvIGRpZmZlcmVudCBm
b3IgZWFjaCBjb250cm9sbGVyIGFuZCB3aWxsIGJlIG92ZXJyaWRkZW4gYnkgdGhlIGxhc3QgY29u
dHJvbGxlci4KPj4gCj4+IE5ldyBwYXRjaCBhcyBiZWxvdyBmb3IgcmVmZXJyZW5jZS4KPlBsZWFz
ZSBzZW5kIHRoaXMgYXMgYSBWMiBwcm9wZXJseS4gVGhhbmsgeW91ICEK
------=_Part_149439_1614822023.1782825918623
Content-Type: application/octet-stream; 
	name=0001-fix-bNbrPorts-wHubCharacteristics-overWritten-by-another-controller_v2.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-fix-bNbrPorts-wHubCharacteristics-overWritten-by-another-controller_v2.patch"

RnJvbTogQmVpYmVpIFlhbmcgPDEzNzM4MTc2MjMyQDE2My5jb20+DQpTdWJqZWN0OiBbUEFUQ0hd
IHVzYjogeGhjaTogRml4IGJOYnJQb3J0cyBhbmQgd0h1YkNoYXJhY3RlcmlzdGljcyAgb3Zlcndy
aXR0ZW4gYnkgYW5vdGhlciBjb250cm9sbGVyDQoNCkZvciB0aGUgYHN0cnVjdCBkZXNjcmlwdG9y
YCwgb25seSB0aGUgYGh1YmAgcGFydCAoYGJOYnJQb3J0c2AgYW5kIGB3SHViQ2hhcmFjdGVyaXN0
aWNzYCkgaXMgZGlmZmVyZW50IGZvciBlYWNoIGNvbnRyb2xsZXIsIHRoZSBvdGhlciBmaXZlIG1l
bWJlcnMgKGRldmljZSwgY29uZmlnLCBpbnRlcmZhY2UsIGVuZHBvaW50LGVwX2NvbXBhbmlvbilh
cmUgaWRlbnRpY2FsIGZvciBhbGwgWEhDSSByb290IGh1YnMuDQoNClNpZ25lZC1vZmYtYnk6IEJl
aWJlaSBZYW5nIDwxMzczODE3NjIzMkAxNjMuY29tPg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvaG9zdC94aGNpLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYw0KaW5kZXggZGJlYjg4YS4u
MTQ2OWIzZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5jDQorKysgYi9kcml2
ZXJzL3VzYi9ob3N0L3hoY2kuYw0KQEAgLTk0Miw3ICs5NDIsNyBAQCBzdGF0aWMgaW50IHhoY2lf
c3VibWl0X3Jvb3Qoc3RydWN0IHVzYl9kZXZpY2UgKnVkZXYsIHVuc2lnbmVkIGxvbmcgcGlwZSwN
CiAJCWNhc2UgVVNCX0RUX0hVQjoNCiAJCWNhc2UgVVNCX0RUX1NTX0hVQjoNCiAJCQlkZWJ1Zygi
VVNCX0RUX0hVQiBjb25maWdcbiIpOw0KLQkJCXNyY3B0ciA9ICZkZXNjcmlwdG9yLmh1YjsNCisJ
CQlzcmNwdHIgPSAmY3RybC0+aHViX2Rlc2M7DQogCQkJc3JjbGVuID0gMHg4Ow0KIAkJCWJyZWFr
Ow0KIAkJZGVmYXVsdDoNCkBAIC0xMjAzLDE5ICsxMjAzLDIxIEBAIHN0YXRpYyBpbnQgeGhjaV9s
b3dsZXZlbF9pbml0KHN0cnVjdCB4aGNpX2N0cmwgKmN0cmwpDQogCQlyZXR1cm4gLUVOT01FTTsN
CiANCiAJcmVnID0geGhjaV9yZWFkbCgmaGNjci0+Y3JfaGNzcGFyYW1zMSk7DQotCWRlc2NyaXB0
b3IuaHViLmJOYnJQb3J0cyA9IEhDU19NQVhfUE9SVFMocmVnKTsNCi0JcHJpbnRmKCJSZWdpc3Rl
ciAleCBOYnJQb3J0cyAlZFxuIiwgcmVnLCBkZXNjcmlwdG9yLmh1Yi5iTmJyUG9ydHMpOw0KKwlj
dHJsLT5odWJfZGVzYyA9IGRlc2NyaXB0b3IuaHViOw0KKwljdHJsLT5odWJfZGVzYy5iTmJyUG9y
dHMgPSAoKHJlZyAmIEhDU19NQVhfUE9SVFNfTUFTSykgPj4NCisJCUhDU19NQVhfUE9SVFNfU0hJ
RlQpOw0KKwlwcmludGYoIlJlZ2lzdGVyICV4IE5iclBvcnRzICVkXG4iLCByZWcsIGN0cmwtPmh1
Yl9kZXNjLmJOYnJQb3J0cyk7DQogDQogCS8qIFBvcnQgSW5kaWNhdG9ycyAqLw0KIAlyZWcgPSB4
aGNpX3JlYWRsKCZoY2NyLT5jcl9oY2NwYXJhbXMpOw0KIAlpZiAoSENTX0lORElDQVRPUihyZWcp
KQ0KLQkJcHV0X3VuYWxpZ25lZChnZXRfdW5hbGlnbmVkKCZkZXNjcmlwdG9yLmh1Yi53SHViQ2hh
cmFjdGVyaXN0aWNzKQ0KLQkJCQl8IDB4ODAsICZkZXNjcmlwdG9yLmh1Yi53SHViQ2hhcmFjdGVy
aXN0aWNzKTsNCisJCXB1dF91bmFsaWduZWQoZ2V0X3VuYWxpZ25lZCgmY3RybC0+aHViX2Rlc2Mu
d0h1YkNoYXJhY3RlcmlzdGljcykNCisJCQkJfCAweDgwLCAmY3RybC0+aHViX2Rlc2Mud0h1YkNo
YXJhY3RlcmlzdGljcyk7DQogDQogCS8qIFBvcnQgUG93ZXIgQ29udHJvbCAqLw0KIAlpZiAoSEND
X1BQQyhyZWcpKQ0KLQkJcHV0X3VuYWxpZ25lZChnZXRfdW5hbGlnbmVkKCZkZXNjcmlwdG9yLmh1
Yi53SHViQ2hhcmFjdGVyaXN0aWNzKQ0KLQkJCQl8IDB4MDEsICZkZXNjcmlwdG9yLmh1Yi53SHVi
Q2hhcmFjdGVyaXN0aWNzKTsNCisJCXB1dF91bmFsaWduZWQoZ2V0X3VuYWxpZ25lZCgmY3RybC0+
aHViX2Rlc2Mud0h1YkNoYXJhY3RlcmlzdGljcykNCisJCQkJfCAweDAxLCAmY3RybC0+aHViX2Rl
c2Mud0h1YkNoYXJhY3RlcmlzdGljcyk7DQogDQogCWlmICh4aGNpX3N0YXJ0KGhjb3IpKSB7DQog
CQl4aGNpX3Jlc2V0KGhjb3IpOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdXNiL3hoY2kuaCBiL2lu
Y2x1ZGUvdXNiL3hoY2kuaA0KaW5kZXggZWE0Y2YzZi4uOWZlYjNhYSAxMDA2NDQNCi0tLSBhL2lu
Y2x1ZGUvdXNiL3hoY2kuaA0KKysrIGIvaW5jbHVkZS91c2IveGhjaS5oDQpAQCAtMjIsNiArMjIs
NyBAQA0KICNpbmNsdWRlIDxhc20vaW8uaD4NCiAjaW5jbHVkZSA8bGludXgvbGlzdC5oPg0KICNp
bmNsdWRlIDxsaW51eC9jb21wYXQuaD4NCisjaW5jbHVkZSA8dXNiLmg+DQogDQogI2RlZmluZSBN
QVhfRVBfQ1RYX05VTQkJMzENCiAjZGVmaW5lIFhIQ0lfQUxJR05NRU5UCQk2NA0KQEAgLTEyMTQs
NiArMTIxNSw3IEBAIHN0cnVjdCB4aGNpX2N0cmwgew0KIAlzdHJ1Y3QgeGhjaV9lcnN0X2VudHJ5
IGVudHJ5W0VSU1RfTlVNX1NFR1NdOw0KIAlzdHJ1Y3QgeGhjaV9zY3JhdGNocGFkICpzY3JhdGNo
cGFkOw0KIAlzdHJ1Y3QgeGhjaV92aXJ0X2RldmljZSAqZGV2c1tNQVhfSENfU0xPVFNdOw0KKwlz
dHJ1Y3QgdXNiX2h1Yl9kZXNjcmlwdG9yIGh1Yl9kZXNjOw0KIAlpbnQgcm9vdGRldjsNCiAJdTE2
IGhjaV92ZXJzaW9uOw0KIAl1MzIgcXVpcmtzOw==
------=_Part_149439_1614822023.1782825918623--

