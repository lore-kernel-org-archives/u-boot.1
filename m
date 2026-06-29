Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E33C43327
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27456846A4;
	Mon, 29 Jun 2026 10:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="VjsLaxO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC5B984844; Mon, 29 Jun 2026 08:25:50 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1490984105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=13738176232@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=y5X67G0nf1UNDJ9TUuLlP3w7QClJxDkfbgS/GeevQAw=; b=V
 jsLaxO/nTv85T9HipSj7fucQRqfMa28qIobOrO0XDvrQ/vhOW4x2+7IKo+iSUWWJ
 XAgPQZo71Kvk3OZA0MIt70LjrzgDBboO4Cu3DJ8sDMufTEnzu4hkPHwKfMXFNIIs
 C2hfF9kl7czf6uj/b76V+DpXNl3r55tGsgaGVj5oog=
Received: from 13738176232$163.com ( [240e:471:cb0:aede:f47d:49ff:fef5:d7d0]
 ) by ajax-webmail-wzpm-k8s-gz (Coremail) ; Mon, 29 Jun 2026 14:25:41 +0800
 (GMT+08:00)
X-Originating-IP: [240e:471:cb0:aede:f47d:49ff:fef5:d7d0]
Date: Mon, 29 Jun 2026 14:25:41 +0800 (GMT+08:00)
From: m13738176232 <13738176232@163.com>
To: "marek.vasut" <marek.vasut@mailbox.org>
Cc: u-boot <u-boot@lists.denx.de>, "bmeng.cn" <bmeng.cn@gmail.com>
Subject: Re: Re: [PATCH] usb: xhci: Fix bNbrPorts overwritten by another
 controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) MailAndroid/7.25.10_(16) Copyright (c) 2002-2026
 www.mailtech.cn 163com
In-Reply-To: <dc5ecf1c-ee61-4434-a19b-966f287f1533@mailbox.org>
References: <1782563839-11379-1-git-send-email-13738176232@163.com>
 <dc5ecf1c-ee61-4434-a19b-966f287f1533@mailbox.org>
X-CM-CTRLMSGS: Ye7/zXRyYWNlS2V5PWM0OGU4NmZlNzUwODQyYjJhYjIzZTE0OWI4YjJjYzA4
X-NTES-MT-INF: c48e86fe750842b2ab23e149b8b2cc08
X-NTES-SC: AL_Qu2TAPuau0sv5yGbY+kcnU0XguY9XMK4uvUl345Qc8cDvwPq+SEHcm1fDGfO2cmkJB+UujioVht29tZkcqxfGeRnXF6YqsWRm9fYOwcryQ==
MIME-Version: 1.0
Message-ID: <5165dbf8.4708d.19f120e171a.Coremail.13738176232@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wDn_+7lD0JqWNFFAA--.7811W
X-CM-SenderInfo: zprtljayrxljits6il2tof0z/xtbC7wUok2pCD+VIlwAA3M
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Mon, 29 Jun 2026 10:17:36 +0200
Content-Type: text/plain; charset=UTF-8
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

Rm9yIHRoZSBgc3RydWN0IGRlc2NyaXB0b3JgLCBvbmx5IHRoZSBgaHViYCBwYXJ0IChgYk5iclBv
cnRzYCBhbmQgYHdIdWJDaGFyYWN0ZXJpc3RpY3NgKSBpcyBkaWZmZXJlbnQgZm9yIGVhY2ggY29u
dHJvbGxlcjsgdGhlIG90aGVyIGZpdmUgbWVtYmVycyAoZGV2aWNlLCBjb25maWcsIGludGVyZmFj
ZSwgZW5kcG9pbnQsZXBfY29tcGFuaW9uKWFyZSBpZGVudGljYWwgZm9yIGFsbCBYSENJIHJvb3Qg
aHVicy4KCk15IHByZXZpb3VzIHBhdGNoIG9ubHkgZml4ZWQgdGhlIGR5bmFtaWMgcmVhZGluZyBv
ZiBgYk5iclBvcnRzYCwgYnV0IGB3SHViQ2hhcmFjdGVyaXN0aWNzYCBpcyBhbHNvIGRpZmZlcmVu
dCBmb3IgZWFjaCBjb250cm9sbGVyIGFuZCB3aWxsIGJlIG92ZXJyaWRkZW4gYnkgdGhlIGxhc3Qg
Y29udHJvbGxlci4KCk5ldyBwYXRjaCBhcyBiZWxvdyBmb3IgcmVmZXJyZW5jZS4KClNpZ25lZC1v
ZmYtYnk6IEJlaWJlaSBZYW5nIDwxMzczODE3NjIzMkAxNjMuY29tPgoKSW5kZXg6IGRyaXZlcnMv
dXNiL2hvc3QveGhjaS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyaXZlcnMvdXNiL2hvc3QveGhjaS5jICAg
ICAocmV2aXNpb24gMTA0NDYpCisrKyBkcml2ZXJzL3VzYi9ob3N0L3hoY2kuYyAgICAgKHdvcmtp
bmcgY29weSkKQEAgLTk1NCwxMyArOTU0LDcgQEAKICAgICAgICAgICAgICAgY2FzZSBVU0JfRFRf
SFVCOgogICAgICAgICAgICAgICBjYXNlIFVTQl9EVF9TU19IVUI6CiAgICAgICAgICAgICAgICAg
ICAgICAgZGVidWcoIlVTQl9EVF9IVUIgY29uZmlnXG4iKTsKLSAgICAgICAgICAgICAgICAgICAg
ICAgc3JjcHRyID0gJmRlc2NyaXB0b3IuaHViOworICAgICAgICAgICAgICAgICAgICAgICBzcmNw
dHIgPSAmY3RybC0+aHViX2Rlc2M7CiAgICAgICAgICAgICAgICAgICAgICAgc3JjbGVuID0gMHg4
OwogICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICAgICBkZWZhdWx0OgpA
QCAtMTIyMSwyMCArMTIxNSwyMSBAQAogICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKCiAg
ICAgICByZWcgPSB4aGNpX3JlYWRsKCZoY2NyLT5jcl9oY3NwYXJhbXMxKTsKLSAgICAgICBkZXNj
cmlwdG9yLmh1Yi5iTmJyUG9ydHMgPSAoKHJlZyAmIEhDU19NQVhfUE9SVFNfTUFTSykgPj4KLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSENTX01BWF9QT1JU
U19TSElGVCk7Ci0gICAgICAgcHJpbnRmKCJSZWdpc3RlciAleCBOYnJQb3J0cyAlZFxuIiwgcmVn
LCBkZXNjcmlwdG9yLmh1Yi5iTmJyUG9ydHMpOworICAgICAgIGN0cmwtPmh1Yl9kZXNjID0gZGVz
Y3JpcHRvci5odWI7CisgICAgICAgY3RybC0+aHViX2Rlc2MuYk5iclBvcnRzID0gKChyZWcgJiBI
Q1NfTUFYX1BPUlRTX01BU0spID4+CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBIQ1NfTUFYX1BPUlRTX1NISUZUKTsKKyAgICAgICBwcmludGYoIlJlZ2lzdGVyICV4IE5i
clBvcnRzICVkXG4iLCByZWcsIGN0cmwtPmh1Yl9kZXNjLmJOYnJQb3J0cyk7CgogICAgICAgLyog
UG9ydCBJbmRpY2F0b3JzICovCiAgICAgICByZWcgPSB4aGNpX3JlYWRsKCZoY2NyLT5jcl9oY2Nw
YXJhbXMpOwogICAgICAgaWYgKEhDU19JTkRJQ0FUT1IocmVnKSkKLSAgICAgICAgICAgICAgIHB1
dF91bmFsaWduZWQoZ2V0X3VuYWxpZ25lZCgmZGVzY3JpcHRvci5odWIud0h1YkNoYXJhY3Rlcmlz
dGljcykKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDB4ODAsICZkZXNjcmlwdG9y
Lmh1Yi53SHViQ2hhcmFjdGVyaXN0aWNzKTsKKyAgICAgICAgICAgICAgIHB1dF91bmFsaWduZWQo
Z2V0X3VuYWxpZ25lZCgmY3RybC0+aHViX2Rlc2Mud0h1YkNoYXJhY3RlcmlzdGljcykKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDB4ODAsICZjdHJsLT5odWJfZGVzYy53SHViQ2hh
cmFjdGVyaXN0aWNzKTsKCiAgICAgICAvKiBQb3J0IFBvd2VyIENvbnRyb2wgKi8KICAgICAgIGlm
IChIQ0NfUFBDKHJlZykpCi0gICAgICAgICAgICAgICBwdXRfdW5hbGlnbmVkKGdldF91bmFsaWdu
ZWQoJmRlc2NyaXB0b3IuaHViLndIdWJDaGFyYWN0ZXJpc3RpY3MpCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAweDAxLCAmZGVzY3JpcHRvci5odWIud0h1YkNoYXJhY3RlcmlzdGlj
cyk7CisgICAgICAgICAgICAgICBwdXRfdW5hbGlnbmVkKGdldF91bmFsaWduZWQoJmN0cmwtPmh1
Yl9kZXNjLndIdWJDaGFyYWN0ZXJpc3RpY3MpCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAweDAxLCAmY3RybC0+aHViX2Rlc2Mud0h1YkNoYXJhY3RlcmlzdGljcyk7CgogICAgICAg
aWYgKHhoY2lfc3RhcnQoaGNvcikpIHsKICAgICAgICAgICAgICAgeGhjaV9yZXNldChoY29yKTsK
SW5kZXg6IGluY2x1ZGUvdXNiL3hoY2kuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBpbmNsdWRlL3VzYi94aGNp
LmggIChyZXZpc2lvbiAxMDQ0NikKKysrIGluY2x1ZGUvdXNiL3hoY2kuaCAgKHdvcmtpbmcgY29w
eSkKQEAgLTIxLDYgKzIxLDcgQEAKI2luY2x1ZGUgPGFzbS9pby5oPgojaW5jbHVkZSA8bGludXgv
bGlzdC5oPgojaW5jbHVkZSA8bGludXgvY29tcGF0Lmg+CisjaW5jbHVkZSA8dXNiLmg+CgojZGVm
aW5lIE1BWF9FUF9DVFhfTlVNICAgICAgICAgMzEKI2RlZmluZSBYSENJX0FMSUdOTUVOVCAgICAg
ICAgIDY0CkBAIC0xMjI5LDYgKzEyMzAsNyBAQAogICAgICAgc3RydWN0IHhoY2lfZXJzdF9lbnRy
eSBlbnRyeVtFUlNUX05VTV9TRUdTXTsKICAgICAgIHN0cnVjdCB4aGNpX3NjcmF0Y2hwYWQgKnNj
cmF0Y2hwYWQ7CiAgICAgICBzdHJ1Y3QgeGhjaV92aXJ0X2RldmljZSAqZGV2c1tNQVhfSENfU0xP
VFNdOworICAgICAgIHN0cnVjdCB1c2JfaHViX2Rlc2NyaXB0b3IgaHViX2Rlc2M7CiAgICAgICBp
bnQgcm9vdGRldjsKfTsKCgoKCi0tLS0gUmVwbGllZCBNZXNzYWdlIC0tLS0KfCBGcm9tIHwgTWFy
ZWsgVmFzdXQ8bWFyZWsudmFzdXRAbWFpbGJveC5vcmc+IHwKfCBEYXRlIHwgMDYvMjgvMjAyNiAw
NDoxMCB8CnwgVG8gfCBCZWliZWkgWWFuZzwxMzczODE3NjIzMkAxNjMuY29tPuOAgXUtYm9vdEBs
aXN0cy5kZW54LmRlIHwKfCBDYyB8IGJtZW5nLmNuQGdtYWlsLmNvbSB8CnwgU3ViamVjdCB8IFJl
OiBbUEFUQ0hdIHVzYjogeGhjaTogRml4IGJOYnJQb3J0cyBvdmVyd3JpdHRlbiBieSBhbm90aGVy
IGNvbnRyb2xsZXIgfApPbiA2LzI3LzI2IDI6MzcgUE0sIEJlaWJlaSBZYW5nIHdyb3RlOgo+IElu
IGEgc3lzdGVtIHdpdGggbXVsdGlwbGUgWEhDSSBjb250cm9sbGVycywgdGhlIGdsb2JhbCBkZXNj
cmlwdG9yLmh1Ygo+IChiTmJyUG9ydHMpIGNhbiBiZSBvdmVyd3JpdHRlbiBieSBhIGxhdGVyIGlu
aXRpYWxpemVkIGNvbnRyb2xsZXIsCj4gY2F1c2luZyB0aGUgcm9vdCBodWIgb2YgYW4gZWFybGll
ciBjb250cm9sbGVyIHRvIHJlcG9ydCB3cm9uZyBwb3J0Cj4gbnVtYmVycy4KPgo+IEZpeCB0aGlz
IGJ5IGR5bmFtaWNhbGx5IHNldHRpbmcgYk5iclBvcnRzIGZyb20gdGhlIGN1cnJlbnQgY29udHJv
bGxlcidzCj4gaGNzcGFyYW1zMSBpbiB0aGUgVVNCX0RUX0hVQiByZXF1ZXN0IGhhbmRsZXIsIGlu
c3RlYWQgb2YgcmVseWluZyBvbgo+IGEgc3RhbGUgZ2xvYmFsIHZhbHVlLgoKSG93IGFib3V0IGhh
dmluZyBvbmUgZGVzY3JpcHRvciBwZXIgY29udHJvbGxlciA/CgpUaGlzIGlzIHByb2JhYmx5IGVh
c2lseSBkb2FibGUgaW4geGhjaV9sb3dsZXZlbF9pbml0KCkgd2l0aCBzb21lCmN0cmwtPmh1Yl9k
ZXNjID0ga21lbWR1cChkZXNjcmlwdG9yLmh1YiwuLi4pOyBhbmQgcmVsYXRlZCB0d2Vha3MuCgpX
aGF0IGRvIHlvdSB0aGluayA/Cg==
