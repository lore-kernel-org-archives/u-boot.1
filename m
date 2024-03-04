Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEEEC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8BBB87F8F;
	Mon,  4 Mar 2024 17:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="s1vqiT2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9736387F9F; Mon,  4 Mar 2024 17:08:12 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0A8A876A9
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 17:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709568490; x=1712160490;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rPBQh5T/9xKpXr5/b7eKtJwXHR0DpkVZUa4xWcrg7v4=;
 b=s1vqiT2ctErbDU4YMdmjv02coGZ1+0FfS9GveKW+uFqaZOBK4FNsZcXshYm7Odgt
 bJEY2XYoSeeRmk7C3vatR9Ha1HViTJYmItOut4MFPykrd5skxba0htXJTMBW2GwW
 rw8xChljflaRuWL1YSIfvlQg6wdEKE6KVUJRUKe/vnY=;
X-AuditID: ac14000a-fbefe7000000290d-f4-65e5f1eadfe1
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id BB.08.10509.AE1F5E56;
 Mon,  4 Mar 2024 17:08:10 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Mar 2024
 17:08:10 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 4 Mar 2024 17:08:10 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Fabio Estevam <festevam@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Teresa Remmet <T.Remmet@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] board: phytec: common: phytec_som_detection: Add
 phytec_get_som_type
Thread-Topic: [PATCH 1/2] board: phytec: common: phytec_som_detection: Add
 phytec_get_som_type
Thread-Index: AQHabi/QO/wgNsZjUEis7G9f/9TV97Enl0IAgAAX54A=
Date: Mon, 4 Mar 2024 16:08:10 +0000
Message-ID: <a109841a-1433-49dc-9a2b-85be164b6e5d@phytec.de>
References: <20240304-pcl-070-patches-v1-0-6aa6c89e3b81@phytec.de>
 <20240304-pcl-070-patches-v1-1-6aa6c89e3b81@phytec.de>
 <CAOMZO5B2BLAuMKeOHWJdpVwj0N9oWQJuNQOmcNfF_8b+5L+dRA@mail.gmail.com>
In-Reply-To: <CAOMZO5B2BLAuMKeOHWJdpVwj0N9oWQJuNQOmcNfF_8b+5L+dRA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FBC0CB5E76B664A81BEF3BA445B1E4C@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWyRpKBR/fVx6epBrueK1s8vOpvMXXSZnaL
 t3s72S2636k7sHjsnHWX3ePVgVXsHmfv7GD06O9uYQ1gieKySUnNySxLLdK3S+DK6D51gb2g
 i7/ixqwm5gbGG3xdjJwcEgImEuc+XmfrYuTiEBJYzCRxsa+NHcK5xyhxbflVJghnPaPEjvvb
 WEFa2ATUJHa9eQ1kc3CIANmn5+mD1DCD1Dz5+Y4ZpEZYIF5idutzMFtEIEHiV/8pVgjbSuLl
 zGlgcRYBFYnHF86zgdi8AjYST1/tYIVYdohRYvb3NWAJToFAiV/XIYoYBWQlNmw4D9bMLCAu
 senZd1aIHwQkluyBiEsIiEq8fPwPKi4vceLWNCaQQ5kFNCXW79KHaLWQuP2hmw3CVpSY0v2Q
 HeIGQYmTM5+wTGAUn4VkwyyE7llIumch6Z6FpHsBI+sqRqHczOTs1KLMbL2CjMqS1GS9lNRN
 jKB4FGHg2sHYN8fjECMTByPQmxzMSiK8Nb+epArxpiRWVqUW5ccXleakFh9ilOZgURLnXd0R
 nCokkJ5YkpqdmlqQWgSTZeLglGpg1N3pHnuU71ML/wVRKzE+Rl959h5vptpGn7WhXR5uWQ5/
 79q+fF28zu3kj0nTk1q26Apaf/yz0+519iGjST4ORufWPFN6VvOv1LyrPObrmV8sIvPazogb
 SIT/cl4/sych5kjDZI7W/+tvresWunha0kU7o6tG4/1r2zor+9D4wKatjqk66ueVWIozEg21
 mIuKEwFZROOttQIAAA==
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

T24gMDQuMDMuMjQgMTU6NDIsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+IE9uIE1vbiwgTWFyIDQs
IDIwMjQgYXQgOTozMeKAr0FNIEJlbmphbWluIEhhaG4gPEIuSGFobkBwaHl0ZWMuZGU+IHdyb3Rl
Og0KPj4gQWRkIGEgZnVuY3Rpb24gdGhhdCBnZXRzIHRoZSBzb21fdHlwZSBmcm9tIHRoZSBFRVBS
T00uDQo+PiBBZGQgYW4gZW51bSBmb3IgdGhlIHNvbV90eXBlLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEJlbmphbWluIEhhaG4gPEIuSGFobkBwaHl0ZWMuZGU+DQo+IFlvdXIgc2VyaWVzIGRvZXMg
bm90IGV2ZW4gYnVpbGQ6DQo+DQo+IGJvYXJkL3BoeXRlYy9jb21tb24vcGh5dGVjX3NvbV9kZXRl
Y3Rpb24uYzogSW4gZnVuY3Rpb24g4oCYcGh5dGVjX2dldF9zb21fdHlwZeKAmToNCj4gYm9hcmQv
cGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlvbi5jOjIxMDoxODogZXJyb3I6IOKAmHN0
cnVjdA0KPiBwaHl0ZWNfZWVwcm9tX2RhdGHigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJh2YWxp
ZOKAmQ0KPiAgICAyMTAgfCAgICAgICAgIGlmICghZGF0YS0+dmFsaWQgfHwgZGF0YS0+ZGF0YS5h
cGlfcmV2IDwgUEhZVEVDX0FQSV9SRVYyKQ0KPiAgICAgICAgfCAgICAgICAgICAgICAgICAgIF5+
DQo+IGJvYXJkL3BoeXRlYy9jb21tb24vcGh5dGVjX3NvbV9kZXRlY3Rpb24uYzoyMTA6Mzk6IGVy
cm9yOiDigJh1bmlvbg0KPiA8YW5vbnltb3VzPuKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmGFw
aV9yZXbigJkNCj4gICAgMjEwIHwgICAgICAgICBpZiAoIWRhdGEtPnZhbGlkIHx8IGRhdGEtPmRh
dGEuYXBpX3JldiA8IFBIWVRFQ19BUElfUkVWMikNCj4gICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeDQo+IGJvYXJkL3BoeXRlYy9jb21tb24vcGh5dGVjX3Nv
bV9kZXRlY3Rpb24uYzoyMTM6MjY6IGVycm9yOiDigJh1bmlvbg0KPiA8YW5vbnltb3VzPuKAmSBo
YXMgbm8gbWVtYmVyIG5hbWVkIOKAmGRhdGHigJkNCj4gICAgMjEzIHwgICAgICAgICByZXR1cm4g
ZGF0YS0+ZGF0YS5kYXRhLmRhdGFfYXBpMi5zb21fdHlwZTsNCj4gICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgIF4NCj4gYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVj
dGlvbi5jOjIxNDoxOiB3YXJuaW5nOiBjb250cm9sDQo+IHJlYWNoZXMgZW5kIG9mIG5vbi12b2lk
IGZ1bmN0aW9uIFstV3JldHVybi10eXBlXQ0KPiAgICAyMTQgfCB9DQo+ICAgICAgICB8IF4NCg0K
T2gsIEknbSB2ZXJ5IHNvcnJ5IGFib3V0IHRoYXQuIFNlZW1zIGxpa2UgSSBtYWRlIHNvbWUgbWlz
dGFrZXMgd2hlbiANCnBvcnRpbmcgdGhlIHBhdGNoZXMgdG8gdXBzdHJlYW0uDQoNCkkgc2VudCBh
IHYyLCB3aGVyZSBJIGZpeGVkIHRoZW0uDQoNCkJlbmphbWluDQoNCg==
