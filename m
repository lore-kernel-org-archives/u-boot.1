Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F38C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 11:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC7788835;
	Thu, 15 Aug 2024 13:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="A8uJPszi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B776889A1; Thu, 15 Aug 2024 13:23:15 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D8B78865D
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1723720992; x=1726312992;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aYBVT7ICCnEvub9bAX63mKYW46Zs+u9dAj8IEdIm4QY=;
 b=A8uJPszi/rsw00GZC8wLdNBI+kx4Py3pw3DWmQCHQoIUIdWSC9KENqOX9JN3hRBP
 ESiOihP1vzW4U5dm/55SKJndzosTyRyVv1O4k0Cf2kMdHLQrj2mDfQnBdcmWR0CK
 NdHvSyVlPfc0ur6HPZ4nqXFa9EH0N68Q5rswMfufM+I=;
X-AuditID: ac14000a-03e52700000021bc-45-66bde520b741
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3D.1B.08636.025EDB66;
 Thu, 15 Aug 2024 13:23:12 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 15 Aug
 2024 13:23:12 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 15 Aug 2024 13:23:12 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "lukma@denx.de"
 <lukma@denx.de>
CC: "sjg@chromium.org" <sjg@chromium.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "festevam@gmail.com" <festevam@gmail.com>, "Benjamin
 Hahn" <B.Hahn@phytec.de>, Cem Tenruh <C.Tenruh@phytec.de>,
 "martyn.welch@collabora.com" <martyn.welch@collabora.com>
Subject: Re: [PATCH v4] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Topic: [PATCH v4] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Index: AQHa6ny7quAT53ftJUOz5UNYnLYo2rIoFIWA
Date: Thu, 15 Aug 2024 11:23:12 +0000
Message-ID: <c484a3542950c89b309a192e7894175229ac67d8.camel@phytec.de>
References: <20240809165332.1898756-1-lukma@denx.de>
In-Reply-To: <20240809165332.1898756-1-lukma@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B914908F47C61438AC173BDC19E7FC3@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWyRpKBV1fh6d40g4tztSweXvW3eP7uMpPF
 g4tdLBbftmxjtJg6aTO7xdu9newObB6zGy6yeOy4u4TRY96sEyweO2fdZfd4dWAVu8fZOzsY
 A9iiuGxSUnMyy1KL9O0SuDIu797FWtAhXrF52lrmBsY9Yl2MHBwSAiYSvW/Vuxg5OYQEljBJ
 dPy362LkArLvM0rMnbGWEcLZwCjR93EJI0gVm4CGxMsT3UwgzSICIRJTIWqYBVqZJPpnfgWr
 ERZIlVjZMRfMFhFIkzi49gYbhG0ksfvuEmYQm0VAVWL+vPUsIDavgJvE9YdP2CCuMJE40/Ub
 rJdTwFSiceI5MJtRQFZiw4bzYL3MAuISm559ZwWxJQQEJJbsgYhLCIhKvHz8DyouL3Hi1jSw
 O5kFNCXW79KHaLWQ2Nqxgx3CVpSY0v2QHeIEQYmTM5+wTGAUn4VkwyyE7llIumch6Z6FpHsB
 I+sqRqHczOTs1KLMbL2CjMqS1GS9lNRNjKCYFWHg2sHYN8fjECMTB+MhRgkOZiUR3kCTXWlC
 vCmJlVWpRfnxRaU5qcWHGKU5WJTEeVd3BKcKCaQnlqRmp6YWpBbBZJk4OKUaGHPzX3w7psL6
 6m2Q++utD29c7JZnOHNofiDD2+hs+4LqDQbPGiwX+EpZu09net1dtHLJZm2RxEcqf/fc/X68
 UGbDJ5NdpbO/LnaxXV9ecGLpO+W/sz48fNXBKDrzAfOcdz/yXJdZSji+PMFjFsqzkPv49HOm
 i1PvcBcGVag8slncLClQbPv11H8lluKMREMt5qLiRADTVluuxwIAAA==
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

QW0gRnJlaXRhZywgZGVtIDA5LjA4LjIwMjQgdW0gMTg6NTMgKzAyMDAgc2NocmllYiBMdWthc3og
TWFqZXdza2k6Cj4gVGhpcyBjb21tYW5kIGFsbG93cyBlYXN5IHVwZGF0ZSBvbiBTRCBjYXJkIG9y
IGVNTUMgb2YgdGhlIGZsYXNoLmJpbgo+IGdlbmVyYXRlZCAod2l0aCBiaW5tYW4pIGR1cmluZyB1
LWJvb3QgYnVpbGQuCj4gCj4gU2lnbmVkLW9mZi1ieTogTHVrYXN6IE1hamV3c2tpIDxsdWttYUBk
ZW54LmRlPgoKVGVzdGVkLWJ5OiBUZXJlc2EgUmVtbWV0IDx0LnJlbW1ldEBwaHl0ZWMuZGU+Cgo+
IC0tLQo+IENoYW5nZXMgZm9yIHYyOgo+IC0gUmVtb3ZlICd1cGRhdGVfbW1jX3BhcnQnIHZhcmlh
YmxlCj4gLSBDaGFuZ2UgcGF0aCBmb3IgaG9zdG5hbWUKPiAtIFVzZSBmdWxsIHZlcnNpb24gb2Yg
ZGhjcCBjb21tYW5kICgke2xvYWRhZGRyfSBhZGRlZCkKPiAKPiBDaGFuZ2VzIGZvciB2MzoKPiAt
IFJlbW92ZSArMSB3aGVuIGNhbGN1bGF0aW5nIHRoZSBzaXplIG9mIGJpbmFyeSB0byBiZSB3cml0
dGVuCj4gCj4gQ2hhbmdlcyBmb3IgdjQ6Cj4gLSBSZXBsYWNlICR7aG9zdG5hbWV9IHdpdGggJHt1
cGRhdGVfZmlsZXBhdGh9Cj4gLS0tCj4gwqBpbmNsdWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg4bW0u
aCB8IDggKysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKPiAKPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmgKPiBiL2luY2x1ZGUv
Y29uZmlncy9waHljb3JlX2lteDhtbS5oCj4gaW5kZXggZGQ3Y2ZkYmE1Mi4uMDkxMGFlMmQ4NyAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg4bW0uaAo+ICsrKyBiL2lu
Y2x1ZGUvY29uZmlncy9waHljb3JlX2lteDhtbS5oCj4gQEAgLTI5LDYgKzI5LDE0IEBACj4gwqDC
oMKgwqDCoMKgwqDCoCJtbWNkZXY9IiBfX3N0cmluZ2lmeShDT05GSUdfU1lTX01NQ19FTlZfREVW
KSAiXDAiIFwKPiDCoMKgwqDCoMKgwqDCoMKgIm1tY3BhcnQ9MVwwIiBcCj4gwqDCoMKgwqDCoMKg
wqDCoCJtbWNyb290PTJcMCIgXAo+ICvCoMKgwqDCoMKgwqDCoCJ1cGRhdGVfb2Zmc2V0PTB4NDJc
MCIgXAo+ICvCoMKgwqDCoMKgwqDCoCJ1cGRhdGVfZmlsZW5hbWU9Zmxhc2guYmluXDAiIFwKPiAr
wqDCoMKgwqDCoMKgwqAidXBkYXRlX2Jvb3RpbWc9IsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAKPiDCoMKgwqBcCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJtbWMgZGV2
ICR7bW1jZGV2fSA7ICLCoMKgwqDCoMKgwqDCoMKgwqDCoFwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgImlmIGRoY3AgJHtsb2FkYWRkcn0KPiAke3VwZGF0ZV9maWxlcGF0aH0vJHt1
cGRhdGVfZmlsZW5hbWV9IDsgdGhlbiAiwqDCoMKgwqDCoFwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgInNldGV4cHIgZndfc3ogJHtmaWxlc2l6ZX0gLyAweDIwMCA7ICLCoMKgLyog
U0QgYmxvY2sKPiBzaXplICovIFwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIm1t
YyB3cml0ZSAke2xvYWRhZGRyfSAke3VwZGF0ZV9vZmZzZXR9ICR7Zndfc3p9IDsKPiAiwqDCoMKg
wqBcCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJmaVwwIiBcCj4gwqDCoMKgwqDC
oMKgwqDCoCJtbWNhdXRvZGV0ZWN0PXllc1wwIiBcCj4gwqDCoMKgwqDCoMKgwqDCoCJtbWNhcmdz
PXNldGVudiBib290YXJncyBjb25zb2xlPSR7Y29uc29sZX0gIiBcCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAicm9vdD0vZGV2L21tY2JsayR7bW1jZGV2fXAke21tY3Jvb3R9IHJv
b3R3YWl0IHJ3XDAiCj4gXAoKLS0gClBIWVRFQyBNZXNzdGVjaG5payBHbWJIIHwgQmFyY2Vsb25h
LUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFueQoKR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwu
LUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8gSHViZXIsCkRpcGwuLUluZy4g
KEZIKSBNYXJrdXMgTGlja2VzIHwgSGFuZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2IHwKRmlu
YW56YW10IE1haW56IHwgU3QuTnIuIDI2NjUwMDYwOCwgREUgMTQ5MDU5ODU1Cg==
