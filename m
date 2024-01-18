Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00215C47258
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 00:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5208798C;
	Thu, 18 Jan 2024 01:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=supermicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=supermicro.com header.i=@supermicro.com header.b="rLn0qwfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26C06876D3; Thu, 18 Jan 2024 01:07:48 +0100 (CET)
Received: from MGB.supermicro.com (mgb.supermicro.com [207.212.57.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD85687887
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 01:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=supermicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liuw@supermicro.com
Received: from pps.filterd (MGB.supermicro.com [127.0.0.1])
 by MGB.supermicro.com (8.17.1.19/8.17.1.19) with ESMTP id 40HLfZV5024530;
 Wed, 17 Jan 2024 16:07:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=supermicro.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=DKIM;
 bh=Ohh11xOoGWqvisZfmfmbTtK5KO8xZNeu+iILe6MbndY=;
 b=rLn0qwfDHvc1RIAzQVve0d4mW6m8ILhMcZVOtuTH7Op9MQdSINLJdj08W9/Ic3q81bkw
 k7xKNe4d670b5sCu+O8JG86VDA9JnBL0N2ojJzVeKxYpvNzIlt1m1TA99aEQMNpn8v9R
 P3VS/NOSzCaUKgysmn6Opz3JusNah5QXHU9n6E5YtdLjsSCNnNn1BoemTxGwXnEagKWR
 KuJt8ep6zgdCtjoneWJHaVZfChBrWKVWEmjLEm0iIzlfi6o8uPzDIT3F6kPloKJkaq3H
 x1TwzbIYYVguS3crG7PaWUqB8hL7u6iyvBz79VE3y7ixvOIWeHh1/xTz6Ahk/WMfhE70 Tw== 
Received: from ex2013-mbx3.supermicro.com (EX2013-MBX3.supermicro.com
 [10.2.1.46]) by MGB.supermicro.com (PPS) with ESMTPS id 3vku0wd7s9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 16:07:40 -0800
Received: from us-ex2019-mbx1.supermicro.com (10.2.6.157) by
 EX2013-MBX3.supermicro.com (10.2.1.46) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 17 Jan 2024 16:07:40 -0800
Received: from us-ex2019-mbx1.supermicro.com (10.2.6.157) by
 us-ex2019-mbx1.supermicro.com (10.2.6.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 17 Jan 2024 16:07:37 -0800
Received: from us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f]) by
 us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f%16]) with
 mapi id 15.02.1118.037; Wed, 17 Jan 2024 16:07:37 -0800
From: Liu Wang <liuw@supermicro.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
Thread-Topic: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
Thread-Index: AdpI24I3kjWF6EnATLOPMIhQOQ7T3gAtdOcAAAg2JaAAAa1qgP//j+hE//+/RCA=
Date: Thu, 18 Jan 2024 00:07:37 +0000
Message-ID: <9c2e7790f0c94b0ebf0e840100eae2c0@supermicro.com>
References: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
 <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
 <0934648988c9444aaf85f2e3163c0f4b@supermicro.com>,
 <CAOMZO5Cy8as7b_cup6J+PYbN-stkj4Vz2wsLB_1=NN3vx5SVWQ@mail.gmail.com>
 <728CCDD9-CEA4-4ED1-9143-189C3F257097@supermicro.com>
In-Reply-To: <728CCDD9-CEA4-4ED1-9143-189C3F257097@supermicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.8.23]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Mailman-Approved-At: Thu, 18 Jan 2024 01:08:58 +0100
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

SGkgRmFiaW8sDQoNClRoYW5rIHlvdSBhZ2FpbiBmb3IgeW91ciBoZWxwLg0KDQpSdW4gaW50byBm
b3JtYXQgZXJyb3IgYWZ0ZXIgZXhwb3J0IHRvb2wgY2hhaW46IA0KLi4uZ251ZWFiaWhmLWdjYzog
Y2Fubm90IGV4ZWN1dGUgYmluYXJ5IGZpbGU6IEV4ZWMgZm9ybWF0IGVycm9yLi4uDQoNCkNvdWxk
IHlvdSBwbGVhc2Ugc2hhcmUgbW9yZSA/DQoNClNpbmNlcmVseSwNCkxpdSBXYW5nDQotLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KL2Jpbi9zaDogbGluZSAxOiAvaG9tZS9saXV3L2FybWdudXRvb2xjaGFp
bjEzMlJlbDFhYXJjaDY0YXJtbm9uZWxpbnV4Z251ZWFiaWhmL2FybS1nbnUtdG9vbGNoYWluLTEz
LjIuUmVsMS1hYXJjaDY0LWFybS1ub25lLWxpbnV4LWdudWVhYmloZi9iaW4vYXJtLW5vbmUtbGlu
dXgtZ251ZWFiaWhmLWdjYzogY2Fubm90IGV4ZWN1dGUgYmluYXJ5IGZpbGU6IEV4ZWMgZm9ybWF0
IGVycm9yDQovaG9tZS9saXV3L2FybWdudXRvb2xjaGFpbjEzMlJlbDFhYXJjaDY0YXJtbm9uZWxp
bnV4Z251ZWFiaWhmL2FybS1nbnUtdG9vbGNoYWluLTEzLjIuUmVsMS1hYXJjaDY0LWFybS1ub25l
LWxpbnV4LWdudWVhYmloZi9iaW4vYXJtLW5vbmUtbGludXgtZ251ZWFiaWhmLWdjYzogL2hvbWUv
bGl1dy9hcm1nbnV0b29sY2hhaW4xMzJSZWwxYWFyY2g2NGFybW5vbmVsaW51eGdudWVhYmloZi9h
cm0tZ251LXRvb2xjaGFpbi0xMy4yLlJlbDEtYWFyY2g2NC1hcm0tbm9uZS1saW51eC1nbnVlYWJp
aGYvYmluL2FybS1ub25lLWxpbnV4LWdudWVhYmloZi1nY2M6IGNhbm5vdCBleGVjdXRlIGJpbmFy
eSBmaWxlDQovYmluL3NoOiBsaW5lIDE6IC9ob21lL2xpdXcvYXJtZ251dG9vbGNoYWluMTMyUmVs
MWFhcmNoNjRhcm1ub25lbGludXhnbnVlYWJpaGYvYXJtLWdudS10b29sY2hhaW4tMTMuMi5SZWwx
LWFhcmNoNjQtYXJtLW5vbmUtbGludXgtZ251ZWFiaWhmL2Jpbi9hcm0tbm9uZS1saW51eC1nbnVl
YWJpaGYtZ2NjOiBjYW5ub3QgZXhlY3V0ZSBiaW5hcnkgZmlsZTogRXhlYyBmb3JtYXQgZXJyb3IN
CmRpcm5hbWU6IG1pc3Npbmcgb3BlcmFuZA0KVHJ5ICdkaXJuYW1lIC0taGVscCcgZm9yIG1vcmUg
aW5mb3JtYXRpb24uDQovYmluL3NoOiBsaW5lIDE6IC9ob21lL2xpdXcvYXJtZ251dG9vbGNoYWlu
MTMyUmVsMWFhcmNoNjRhcm1ub25lbGludXhnbnVlYWJpaGYvYXJtLWdudS10b29sY2hhaW4tMTMu
Mi5SZWwxLWFhcmNoNjQtYXJtLW5vbmUtbGludXgtZ251ZWFiaWhmL2Jpbi9hcm0tbm9uZS1saW51
eC1nbnVlYWJpaGYtZ2NjOiBjYW5ub3QgZXhlY3V0ZSBiaW5hcnkgZmlsZTogRXhlYyBmb3JtYXQg
ZXJyb3INCnNjcmlwdHMva2NvbmZpZy9jb25mICAtLXN5bmNjb25maWcgS2NvbmZpZw0KLi9zY3Jp
cHRzL2djYy12ZXJzaW9uLnNoOiBsaW5lIDI1OiAvaG9tZS9saXV3L2FybWdudXRvb2xjaGFpbjEz
MlJlbDFhYXJjaDY0YXJtbm9uZWxpbnV4Z251ZWFiaWhmL2FybS1nbnUtdG9vbGNoYWluLTEzLjIu
UmVsMS1hYXJjaDY0LWFybS1ub25lLWxpbnV4LWdudWVhYmloZi9iaW4vYXJtLW5vbmUtbGludXgt
Z251ZWFiaWhmLWdjYzogY2Fubm90IGV4ZWN1dGUgYmluYXJ5IGZpbGU6IEV4ZWMgZm9ybWF0IGVy
cm9yDQouL3NjcmlwdHMvZ2NjLXZlcnNpb24uc2g6IGxpbmUgMjY6IC9ob21lL2xpdXcvYXJtZ251
dG9vbGNoYWluMTMyUmVsMWFhcmNoNjRhcm1ub25lbGludXhnbnVlYWJpaGYvYXJtLWdudS10b29s
Y2hhaW4tMTMuMi5SZWwxLWFhcmNoNjQtYXJtLW5vbmUtbGludXgtZ251ZWFiaWhmL2Jpbi9hcm0t
bm9uZS1saW51eC1nbnVlYWJpaGYtZ2NjOiBjYW5ub3QgZXhlY3V0ZSBiaW5hcnkgZmlsZTogRXhl
YyBmb3JtYXQgZXJyb3INCi4vc2NyaXB0cy9nY2MtdmVyc2lvbi5zaDogbGluZSAyODogL2hvbWUv
bGl1dy9hcm1nbnV0b29sY2hhaW4xMzJSZWwxYWFyY2g2NGFybW5vbmVsaW51eGdudWVhYmloZi9h
cm0tZ251LXRvb2xjaGFpbi0xMy4yLlJlbDEtYWFyY2g2NC1hcm0tbm9uZS1saW51eC1nbnVlYWJp
aGYvYmluL2FybS1ub25lLWxpbnV4LWdudWVhYmloZi1nY2M6IGNhbm5vdCBleGVjdXRlIGJpbmFy
eSBmaWxlOiBFeGVjIGZvcm1hdCBlcnJvcg0KICBDRkcgICAgIHUtYm9vdC5jZmcNCi9iaW4vc2g6
IGxpbmUgMTogL2hvbWUvbGl1dy9hcm1nbnV0b29sY2hhaW4xMzJSZWwxYWFyY2g2NGFybW5vbmVs
aW51eGdudWVhYmloZi9hcm0tZ251LXRvb2xjaGFpbi0xMy4yLlJlbDEtYWFyY2g2NC1hcm0tbm9u
ZS1saW51eC1nbnVlYWJpaGYvYmluL2FybS1ub25lLWxpbnV4LWdudWVhYmloZi1nY2M6IGNhbm5v
dCBleGVjdXRlIGJpbmFyeSBmaWxlOiBFeGVjIGZvcm1hdCBlcnJvcg0KbWFrZVsxXTogKioqIFtz
Y3JpcHRzL01ha2VmaWxlLmF1dG9jb25mOjc3OiB1LWJvb3QuY2ZnXSBFcnJvciAxDQptYWtlOiAq
KiogTm8gcnVsZSB0byBtYWtlIHRhcmdldCAnaW5jbHVkZS9jb25maWcvYXV0by5jb25mJywgbmVl
ZGVkIGJ5ICdpbmNsdWRlL2NvbmZpZy91Ym9vdC5yZWxlYXNlJy4gIFN0b3AuDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMaXUgV2FuZyAoSFcpIDxsaXV3QHN1cGVybWljcm8u
Y29tPiANClNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAxNywgMjAyNCAxMjowOCBQTQ0KVG86IEZh
YmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCkNjOiB1LWJvb3RAbGlzdHMuZGVueC5k
ZQ0KU3ViamVjdDogUmU6IENvdWxkIHlvdSBwbGVhc2UgaGVscCBtZSBpbiByZXNvbHZpbmcgdGhl
ICJhcmNoL2FybS9saWIvdmVjdG9ycy5TOjg3OiBFcnJvcjogbm8gc3VjaCBpbnN0cnVjdGlvbjog
YGIgcmVzZXQnID8iDQoNCkhpIEZhYmlvLA0KDQpBcHByZWNpYXRlIQ0KDQpTaW5jZXJlbHksDQpM
aXUgIFdhbmcNCg0KPiBPbiBKYW4gMTcsIDIwMjQsIGF0IDEwOjQ5IEFNLCBGYWJpbyBFc3RldmFt
IDxmZXN0ZXZhbUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g77u/W0NBVVRJT046IEV4dGVybmFs
IE1haWxdDQo+IA0KPj4gT24gV2VkLCBKYW4gMTcsIDIwMjQgYXQgMzoyNeKAr1BNIExpdSBXYW5n
IDxsaXV3QHN1cGVybWljcm8uY29tPiB3cm90ZToNCj4+IA0KPj4gMi4gWW91IGFyZSByaWdodC4g
SSBoYXZlIG5vdCBleHBvcnRlZCB0aGUgdG9vbCBjaGFpbi4NCj4+IENvdWxkIHlvdSBwbGVhc2Ug
c2hhcmUgbWUgYSBsaW5rIHRvIGEgcmVhZG1lIGluIHNldHRpbmcgdXAgdGhlIHRvb2wgY2hhaW4g
Zm9yIFVidW50dSBjcm9zcyBidWlsZCBlbnZpcm9ubWVudCA/DQo+IA0KPiBZb3UgY2FuIGRvIGxp
a2UgdGhpczoNCj4gDQo+IGV4cG9ydCBBUkNIPWFybQ0KPiBleHBvcnQgQ1JPU1NfQ09NUElMRT0v
dXNyL2Jpbi9hcm0tbGludXgtZ251ZWFiaWhmLQ0KPiANCj4gbWFrZSBjc2VfcHRqb2JfY2IzX3Ix
MDJfZGVmY29uZmlnDQo+IG1ha2UNCg==
