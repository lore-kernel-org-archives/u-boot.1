Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B675C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 14:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0657874DD;
	Tue, 12 Dec 2023 15:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J1MEFOHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779D3877CD; Tue, 12 Dec 2023 15:12:02 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00DE686E65
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 15:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77f2f492a43so318603385a.2
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 06:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702390319; x=1702995119; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4j0nCBkGGJQwj35jWIGakQMHyUzXzmTlOIHOC/CgU08=;
 b=J1MEFOHU3CUT4uxa0zWeZBnWiAdPcCfNBbZHDX9ZroRStjWSWx37+6TuHgKxIqxvSl
 U4D1dm4hHiLuSjsgJeosAMM/4zOT8GYlnUyx5fC5YKMmN0/NF4TtPZwSQqwUK8ZUfOhU
 wFHbOq2v14PQMBaA21RvBfZL/Ozf3pjUFn3ecSzqZw/qE+uWfNcFkZJt4xiwsaju4jky
 V9TeTrruuK0amS+r9DMDA9AnSmZoQdaf9qeOugbJTOiwAKDQC8ftVZww2GMW1M2cOBdz
 VWBEl6fItkjGH3ti4DFAlqHcIj36LUxfff0HEfiAtD9PnBSbGAkLItff9w0zqHrInaEI
 RfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702390319; x=1702995119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4j0nCBkGGJQwj35jWIGakQMHyUzXzmTlOIHOC/CgU08=;
 b=ZyHGuZGp6qcK56aJLIzAZgFbl+tiONhANxr1iRQuuZ5bUwrRQ/VbG4iwr4XxSRQOMl
 wcpDQU+D/QzgX/Y6+/qPBw/d6ZwQA3dVmz6KzOeBfbD+Ad6uwC8wLQoa2oTFTOvmew9K
 s+PAWo9bhn8ngmbx11L2/dIo6pdKXm2tgWZpob+cWppdZTZv1NKoPEK7PUEK2tgdqIKF
 ghiUFjOBb+Y6Z1saY8uTTqAvIA8EXBc4IWot1s7eTT8AwlDJqPvutMXXIKOuVyz4WhTy
 4iPtzylwDO4nG/grb8nsnAJanatdngacvCP3N2ACwWRmmF8l4wmyS6j6m0FOrEX0HwZX
 W02Q==
X-Gm-Message-State: AOJu0YynwNuZowl0HXJiW2JWYBpIhIdcC0dhhiL7lOwIRKDmAse0jFp4
 Jp/iZOmBrHoz5ksZAP89hMc=
X-Google-Smtp-Source: AGHT+IHrvGfKuhcNbnpEDNsa84QYxiXGbwiVGYrR+zxObhr3UMxVE8PMAbDlnmbghhdrnCqTSEOKGA==
X-Received: by 2002:a05:620a:42:b0:77e:fba3:936e with SMTP id
 t2-20020a05620a004200b0077efba3936emr6219816qkt.80.1702390318677; 
 Tue, 12 Dec 2023 06:11:58 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 po6-20020a05620a384600b0077d9fdde1dcsm3737299qkn.42.2023.12.12.06.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 06:11:58 -0800 (PST)
Message-ID: <9760cfbe-ad54-8a38-a9a7-9308b0b7ca25@gmail.com>
Date: Tue, 12 Dec 2023 09:11:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 0/8] clk: Switch from soc_clk_dump to clk_ops function
Content-Language: en-US
To: neil.armstrong@linaro.org, Igor Prusov <ivprusov@sberdevices.ru>,
 u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20231109105516.24892-1-ivprusov@sberdevices.ru>
 <88960dfc-441f-49fb-bd36-ee32e754b003@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <88960dfc-441f-49fb-bd36-ee32e754b003@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
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

T24gMTIvMTIvMjMgMDk6MDMsIE5laWwgQXJtc3Ryb25nIHdyb3RlOg0KPiBIaSBJZ29yLCBT
ZWFuLA0KPiANCj4gT24gMDkvMTEvMjAyMyAxMTo1NSwgSWdvciBQcnVzb3Ygd3JvdGU6DQo+
PiBDdXJyZW50bHkgY2xvY2sgcHJvdmlkZXJzIG1heSBvdmVycmlkZSBkZWZhdWx0IGltcGxl
bWVudGF0aW9uIG9mDQo+PiBzb2NfY2xrX2R1bXAgZnVuY3Rpb24gdG8gcmVwbGFjZSBjbGsg
ZHVtcCBjb21tYW5kIG91dHB1dC4gVGhpcyBjYXVzZXMNCj4+IGNvbmZ1c2luZyBiZWhhdmlv
dXIgd2hlbiB1LWJvb3QgaXMgYnVpbHQgd2l0aCBvbmUgb2Ygc3VjaCBkcml2ZXJzDQo+PiBl
bmFibGVkIGJ1dCBzdGlsbCBoYXMgY2xvY2tzIGRlZmluZWQgdXNpbmcgQ0NGLiBGb3IgZXhh
bXBsZSwgZW5hYmxpbmcNCj4+IENNRF9DTEsgYW5kIHVzaW5nIGNsayBkdW1wIG9uIHNhbmRi
b3ggdGFyZ2V0IHdpbGwgbm90IHNob3cgQ0NGIGNsb2Nrcw0KPj4gYmVjYXVzZSBrMjEwIGRy
aXZlciBvdmVycmlkZXMgY29tbW9uIHNvY19jbGtfZHVtcC4NCj4gDQo+IFdoYXQncyB0aGUg
c3RhdGUgb2YgdGhpcyBzZXJpZSA/DQoNCkF3YWl0aW5nIHVwc3RyZWFtLiBJIHdpbGwgbWFr
ZSBhIFBSIHdpdGggaXQgZm9yIG5leHQuDQoNCi0tU2Vhbg0KDQo+IFRoYW5rcywNCj4gTmVp
bA0KPiANCj4+DQo+PiBDaGFuZ2Vsb2c6DQo+PiDCoCB2MSAtPiB2MjoNCj4+IMKgIC0gQWRk
IG1pc3Npbmcgc3RhdGljIHRvIGR1bXAgZnVuY3Rpb25zDQo+Pg0KPj4gwqAgdjIgLT4gdjM6
DQo+PiDCoCAtIE1ha2Ugc29jX2Nsa19kdW1wIGluIGNtZC9jbGsuYyBzdGF0aWMgaW5zdGVh
ZCBvZiByZW1vdmluZyBfX3dlYWsNCj4+DQo+PiDCoCB2MyAtPiB2NDoNCj4+IMKgIC0gUmVi
YXNlIGFuZCByZWZhY3RvciBkdW1wIGZvciBuZXcgQW1sb2dpYyBBMSBjbG9jayBjb250cm9s
bGVyIGRyaXZlcg0KPj4NCj4+IMKgIHY0IC0+IHY1Og0KPj4gwqAgLSBBZGQgZG9jcyBmb3Ig
ZHVtcCgpIGZ1bmN0aW9uIGluIGNsa19vcHMNCj4+IMKgIC0gUHJpbnQgZHJpdmVyIGFuZCBk
ZXZpY2UgbmFtZXMgYmVmb3JlIGNhbGxpbmcgY29ycmVzcG9uZGluZyBkdW1wKCkNCj4+DQo+
PiDCoCB2NSAtPiB2NjoNCj4+IMKgIC0gZHVtcCgpIHJldHVybiB0eXBlIGNoYW5nZWQgdG8g
dm9pZA0KPj4gwqAgLSBtZXNvbl9jbGtfZHVtcCgpIGFuZCBoZWxwZXIgZnVuY3Rpb25zIG1v
dmVkIHVuZGVyIENPTkZJR19DTURfQ0xLIHRvDQo+PiDCoMKgwqAgZml4IHVudXNlZC1mdW5j
dGlvbiBkaWFnbm9zdGljDQo+Pg0KPj4gdjYgLT4gdjc6DQo+PiDCoCAtIGZpeCByZXR1cm4g
dHlwZSBvZiBrMjEwX2Nsa19kdW1wKCkNCj4+IMKgIC0gZml4IGNsa19vcHMgZHVtcCgpIGRv
Y3Mgc2luY2UgaXQgcmV0dXJucyB2b2lkIG5vdw0KPj4NCj4+IElnb3IgUHJ1c292ICg4KToN
Cj4+IMKgwqAgY2xrOiB6eW5xOiBNb3ZlIHNvY19jbGtfZHVtcCB0byBaeW5xIGNsb2NrIGRy
aXZlcg0KPj4gwqDCoCBjbGs6IGFzdDI2MDA6IE1vdmUgc29jX2Nsa19kdW1wIGZ1bmN0aW9u
DQo+PiDCoMKgIGNsazogazIxMDogTW92ZSBzb2NfY2xrX2R1bXAgZnVuY3Rpb24NCj4+IMKg
wqAgY2xrOiBhbWxvZ2ljOiBNb3ZlIGRyaXZlciBhbmQgb3BzIHN0cnVjdHMNCj4+IMKgwqAg
Y2xrOiBBZGQgZHVtcCBvcGVyYXRpb24gdG8gY2xrX29wcw0KPj4gwqDCoCBjbWQ6IGNsazog
VXNlIGR1bXAgZnVuY3Rpb24gZnJvbSBjbGtfb3BzDQo+PiDCoMKgIGNsazogdHJlZXdpZGU6
IHN3aXRjaCB0byBjbG9jayBkdW1wIGZyb20gY2xrX29wcw0KPj4gwqDCoCBjbWQ6IGNsazog
TWFrZSBzb2NfY2xrX2R1bXAgc3RhdGljDQo+Pg0KPj4gwqAgYXJjaC9hcm0vbWFjaC16eW5x
L2Nsay5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNTcgLS0tLS0tLS0tLS0t
LS0NCj4+IMKgIGFyY2gvbWlwcy9tYWNoLXBpYzMyL2NwdS5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCAyMyAtLS0tLS0NCj4+IMKgIGNtZC9jbGsuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEzICsrKy0N
Cj4+IMKgIGRyaXZlcnMvY2xrL2FzcGVlZC9jbGtfYXN0MjYwMC5jwqDCoMKgwqDCoMKgIHzC
oCA4MyArKysrKysrKysrLS0tLS0tLS0tLQ0KPj4gwqAgZHJpdmVycy9jbGsvY2xrX2syMTAu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTA0ICsrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0NCj4+IMKgIGRyaXZlcnMvY2xrL2Nsa19waWMzMi5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzNyArKysrKysrKysNCj4+IMKgIGRyaXZlcnMvY2xr
L2Nsa192ZXJzYWwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOSArKy0N
Cj4+IMKgIGRyaXZlcnMvY2xrL2Nsa196eW5xLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgNTIgKysrKysrKysrKysrKw0KPj4gwqAgZHJpdmVycy9jbGsvY2xrX3p5
bnFtcC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMjIgKysrLS0tDQo+PiDC
oCBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDguY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMTMgKy0tLQ0KPj4gwqAgZHJpdmVycy9jbGsvbWVzb24vYTEuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA1OCArKysrKystLS0tLS0tLQ0KPj4gwqAgZHJpdmVy
cy9jbGsvbXZlYnUvYXJtYWRhLTM3eHgtcGVyaXBoLmMgfMKgIDIwICsrKy0tDQo+PiDCoCBk
cml2ZXJzL2Nsay9zdG0zMi9jbGstc3RtMzJtcDEuY8KgwqDCoMKgwqDCoCB8wqAgMzEgKyst
LS0tLS0NCj4+IMKgIGluY2x1ZGUvY2xrLXVjbGFzcy5owqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAxMyArKysrDQo+PiDCoCBpbmNsdWRlL2Nsay5owqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiAt
DQo+PiDCoCAxNSBmaWxlcyBjaGFuZ2VkLCAyNjkgaW5zZXJ0aW9ucygrKSwgMjY4IGRlbGV0
aW9ucygtKQ0KPj4NCj4gDQoNCg==
