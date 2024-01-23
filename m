Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27264C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 19:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F51F87CA1;
	Tue, 23 Jan 2024 20:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=supermicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=supermicro.com header.i=@supermicro.com header.b="S87XTxTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D22F887CAA; Tue, 23 Jan 2024 20:20:29 +0100 (CET)
Received: from MGA.supermicro.com (mga.supermicro.com [207.212.57.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C5E8746C
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 20:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=supermicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liuw@supermicro.com
Received: from pps.filterd (MGA.supermicro.com [127.0.0.1])
 by MGA.supermicro.com (8.17.1.19/8.17.1.19) with ESMTP id 40NEvfjH027367;
 Tue, 23 Jan 2024 11:20:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=supermicro.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=DKIM;
 bh=gKg1nKUkKJ0ydezwxx+gVoX3Jet+CCp/cmuTDKH8TEs=;
 b=S87XTxTfCsztc9q0ittdoP+iukcXK4bLnexz83bK71RNvf0EoPLKrsMowPRqsigtm0f1
 NT6uhwFmU/Qrygb1UoT/qJled7YhwEh1jOll9H1ABN2zyrg+HlN1pl7cuFa9AP/p7bXG
 xoKTv7mtg9U7W/8wYHybV9uRVvgSCH6zcl1x7RI1K0mlir6T+XAJ7/75zViwvaWI7H4H
 4AdOudanIGJCvMK3P2brlel8KZC2+l80AfRjm9FDpLBkcBJ9mslC/K4TvDYQesmiUKUR
 5532WNaZ2Mkq5NYhenw1sursGaTAZ+DCCVlOIQHPCdvcOjLXQY9/SIGp5MHwgaSLUZQH dg== 
Received: from ex2013-mbx3.supermicro.com (EX2013-MBX3.supermicro.com
 [10.2.1.46]) by MGA.supermicro.com (PPS) with ESMTPS id 3vrenwv3p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 23 Jan 2024 11:20:22 -0800
Received: from us-ex2019-mbx4.supermicro.com (10.2.6.160) by
 EX2013-MBX3.supermicro.com (10.2.1.46) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 23 Jan 2024 11:20:17 -0800
Received: from us-ex2019-mbx1.supermicro.com (10.2.6.157) by
 us-ex2019-mbx4.supermicro.com (10.2.6.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 23 Jan 2024 11:20:17 -0800
Received: from us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f]) by
 us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f%16]) with
 mapi id 15.02.1118.037; Tue, 23 Jan 2024 11:20:17 -0800
From: Liu Wang <liuw@supermicro.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: Could you please help me in resolving the "
 /reset.c:42:(.text.do_reset+0x20): undefined reference to `reset_cpu'?"
Thread-Topic: Could you please help me in resolving the "
 /reset.c:42:(.text.do_reset+0x20): undefined reference to `reset_cpu'?"
Thread-Index: AQHaTZ8+mgOmQY3mrU+FK1vlIrAoDrDnNtEAgACLaRA=
Date: Tue, 23 Jan 2024 19:20:16 +0000
Message-ID: <169de53f8b31460db561e775657492a3@supermicro.com>
References: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
 <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
 <0934648988c9444aaf85f2e3163c0f4b@supermicro.com>
 <CAOMZO5Cy8as7b_cup6J+PYbN-stkj4Vz2wsLB_1=NN3vx5SVWQ@mail.gmail.com>
 <728CCDD9-CEA4-4ED1-9143-189C3F257097@supermicro.com>
 <9c2e7790f0c94b0ebf0e840100eae2c0@supermicro.com>
 <be10a49d2381407fb955958fbc87ecd4@supermicro.com>
 <CAOMZO5D5g6izBC=aCumX_H1tbo5uXTfuhQekSuH_XDqUAN91Kg@mail.gmail.com>
 <8ACC66AF-9761-44E2-A36E-62C8EAADA09C@supermicro.com>
 <509c10723aed4965aceabbd28d36b847@supermicro.com>
 <CAOMZO5DUrxpRAt6Fn7xofHGH7B3ngrkdPm9c0YUd4r-19CB+ng@mail.gmail.com>
In-Reply-To: <CAOMZO5DUrxpRAt6Fn7xofHGH7B3ngrkdPm9c0YUd4r-19CB+ng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.8.23]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Mailman-Approved-At: Tue, 23 Jan 2024 20:21:55 +0100
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

SGkgRmFiaW8sDQoNClRoYW5rIHlvdSBmb3IgeW91ciBoZWxwLg0KDQpBdHRhY2hlZCBpcyB0aGUg
J2dpdCBzdGF0dXMnIGFuZCAnZ2l0IGxvZycgaW4gbXkgcG9ydGluZyB1LWJvb3QgdG8gbXkgY3Nl
X3B0am9iX2NiM19yMTAyIGNvbnRyb2wgYm9hcmQgYnkgZm9sbG93aW5nIFJFQURNRSBpbiB1LWJv
b3QgYW5kIGJlaW5nIGJsb2NrZWQgd2l0aCB0aGUgaHVyZGxlIG9mICAidW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgcmVzZXRfY3B1JyIgaW4gaG9wZSB5b3Ugc3BvdCBzb21ldGhpbmcgZmFtaWxpYXIg
YW5kIHNoZWQgYSBsaWdodCBpbiBteSBidWlsZGluZyBlZmZvcnQuDQoNClNpbmNlcmVseSwNCkxp
dSBXYW5nDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KbGl1
d0BsaXV3LVNZUy1FMTAwLTEyVC1IOn4vRG93bmxvYWRzL3UtYm9vdCQgZ2l0IGxvZw0KY29tbWl0
IDA1MGFjZWUxMTliMzc1N2ZlZTNiZDEyOGY1NWQ3MjBmZGQ5YmI4OTAgKEhFQUQsIHRhZzogdjIw
MjAuMTAsIGxpc3QpDQpBdXRob3I6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQpEYXRl
OiAgIE1vbiBPY3QgNSAxMToxNTozMiAyMDIwIC0wNDAwDQoNCiAgICBQcmVwYXJlIHYyMDIwLjEw
DQogICAgDQogICAgU2lnbmVkLW9mZi1ieTogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4N
Cg0KY29tbWl0IDBmM2UyOTQyYzllMDFiNWRmYzAxZjNkYWJlMGUyZjJhYjhmZDhiODQNCkF1dGhv
cjogU29lcmVuIE1vY2ggPHNtb2NoQHdlYi5kZT4NCkRhdGU6ICAgVGh1IEF1ZyAyNyAyMTo1Mjo0
NiAyMDIwICswMjAwDQoNCiAgICBib2FyZDogdGJzMjkxMDogVXNlIHJlY29tbWVuZGVkIGRpc3Ry
b2Jvb3QgYWRkcmVzc2VzDQogICAgDQogICAgQWNjb3JkaW5nIHRvIGRvYy9SRUFETUUuZGlzdHJv
IGZkdF9hZGRyIG11c3Qgbm90IGJlIHNldCB3aGVuIERUQiBpcyBub3QNCiAgICBhdmFpbGFibGUg
ZnJvbSBoYXJkd2FyZS4gU28gcmVtb3ZlIHRoaXMgZW50cnkuDQogICAgDQogICAgVXNlIGFkZHJl
c3MgMzJNQiBhYm92ZSB0aGUgc3RhcnQgb2YgRFJBTSBmb3Iga2VybmVsX2FkZHJfci4gVGhpcyB3
YXkNCiAgICB3ZSBsaWtlbHkgY2FuIGF2b2lkIHRoZSBzZWxmLXJlbG9jYXRpb24gb2YgdGhlIGNv
bXByZXNzZWQga2VybmVsIGltYWdlDQogICAgYmVmb3JlIGl0IGRlY29tcHJlc3NlcyB0byBvZmZz
ZXQgMHg4MDAwIGZyb20gc3RhcnQgb2YgRFJBTS4NCiAgICANCiAgICBVc2UgYWRkcmVzcyAxMjhN
QiBhYm92ZSB0aGUgc3RhcnQgb2YgRFJBTSBmb3IgZmR0X2FkZHJfciwgc2luY2UgdGhpcyBpcw0K
ICAgIHRoZSBtYXhpbXVtIGxvY2F0aW9uIGZvciB0aGUgZW5kIG9mIHRoZSBrZXJuZWwuIFNvIHdl
IGF2b2lkIG92ZXJ3cml0aW5nDQogICAgdGhlIERUQi4NCiAgICANCiAgICBVc2UgNTEyayBhYm92
ZSB0aGF0IGZvciByYW1kaXNrX2FkZHJfci4gVGhpcyBzaG91bGQgYmUgZW5vdWdoIGZvciB0aGUN
CiAgICBEVEIsIHJlc3Qgb2YgRFJBTSBjYW4gYmUgdXNlZCBmb3IgaW5pdHJkLg0KICAgIA0KbGl1
d0BsaXV3LVNZUy1FMTAwLTEyVC1IOn4vRG93bmxvYWRzL3UtYm9vdCQNCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCmxpdXdAbGl1dy1TWVMtRTEwMC0xMlQtSDp+L0Rvd25sb2Fkcy91LWJvb3QkIGdp
dCBzdGF0dXMNCkhFQUQgZGV0YWNoZWQgYXQgdjIwMjAuMTANCkNoYW5nZXMgbm90IHN0YWdlZCBm
b3IgY29tbWl0Og0KICAodXNlICJnaXQgYWRkIDxmaWxlPi4uLiIgdG8gdXBkYXRlIHdoYXQgd2ls
bCBiZSBjb21taXR0ZWQpDQogICh1c2UgImdpdCByZXN0b3JlIDxmaWxlPi4uLiIgdG8gZGlzY2Fy
ZCBjaGFuZ2VzIGluIHdvcmtpbmcgZGlyZWN0b3J5KQ0KCW1vZGlmaWVkOiAgIGFyY2gvYXJtL0tj
b25maWcNCgltb2RpZmllZDogICBhcmNoL2FybS9pbmNsdWRlL2FzbS9hcmNoLWFzcGVlZC9wbGF0
Zm9ybS5oDQoJbW9kaWZpZWQ6ICAgYXJjaC9hcm0vaW5jbHVkZS9hc20vZ2xvYmFsX2RhdGEuaA0K
CW1vZGlmaWVkOiAgIGNtZC9ib290bS5jDQoJbW9kaWZpZWQ6ICAgY21kL2kyYy5jDQoJbW9kaWZp
ZWQ6ICAgY21kL2xvYWQuYw0KCW1vZGlmaWVkOiAgIGNtZC9zb3VyY2UuYw0KCW1vZGlmaWVkOiAg
IGNvbW1vbi9pbWFnZS5jDQoJbW9kaWZpZWQ6ICAgZnMvZnMuYw0KCW1vZGlmaWVkOiAgIGluY2x1
ZGUvY29tbWFuZC5oDQoJbW9kaWZpZWQ6ICAgaW5jbHVkZS9uczE2NTUwLmgNCg0KVW50cmFja2Vk
IGZpbGVzOg0KICAodXNlICJnaXQgYWRkIDxmaWxlPi4uLiIgdG8gaW5jbHVkZSBpbiB3aGF0IHdp
bGwgYmUgY29tbWl0dGVkKQ0KCWJvYXJkL3N1cGVybWljcm8vDQoJY29uZmlncy9jc2VfcHRqb2Jf
Y2IzX3IxMDJfZGVmY29uZmlnDQoJaW5jbHVkZS9jb25maWdzL2Nhc3RfY29tbW9uLmgNCglpbmNs
dWRlL2NvbmZpZ3MvY3NlX3B0am9iX2NiM19yMTAyLmgNCglsaXN0QmluDQoJbG9nMjAyNDAxMTYx
Nm1ha2VBbGwueW1sDQoJbG9nbWFrZWFsbDIwMjQwMTIyMTgNCgltYWtlbG9nDQoNCm5vIGNoYW5n
ZXMgYWRkZWQgdG8gY29tbWl0ICh1c2UgImdpdCBhZGQiIGFuZC9vciAiZ2l0IGNvbW1pdCAtYSIp
DQpsaXV3QGxpdXctU1lTLUUxMDAtMTJULUg6fi9Eb3dubG9hZHMvdS1ib290JA0KDQoNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdt
YWlsLmNvbT4gDQpTZW50OiBNb25kYXksIEphbnVhcnkgMjIsIDIwMjQgNjo0NCBQTQ0KVG86IExp
dSBXYW5nIChIVykgPGxpdXdAc3VwZXJtaWNyby5jb20+DQpDYzogdS1ib290QGxpc3RzLmRlbngu
ZGUNClN1YmplY3Q6IFJlOiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgbWUgaW4gcmVzb2x2aW5nIHRo
ZSAiIC9yZXNldC5jOjQyOigudGV4dC5kb19yZXNldCsweDIwKTogdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0byBgcmVzZXRfY3B1Jz8iDQoNCltDQVVUSU9OOiBFeHRlcm5hbCBNYWlsXQ0KDQpIaSBMaXUg
V2FuZywNCg0KT24gTW9uLCBKYW4gMjIsIDIwMjQgYXQgMTA6NTXigK9QTSBMaXUgV2FuZyA8bGl1
d0BzdXBlcm1pY3JvLmNvbT4gd3JvdGU6DQo+DQo+IEhpIEZhYmlvLA0KPg0KPiBDb3VsZCB5b3Ug
cGxlYXNlIGhlbHAgbWUgaW4gcmVzb2x2aW5nIHRoZSAiIC9yZXNldC5jOjQyOigudGV4dC5kb19y
ZXNldCsweDIwKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcmVzZXRfY3B1Jz8iIGZyb206IHUt
Ym9vdCRtYWtlIGFsbDoNCg0KTG9va2luZyBhdCB0aGUgZXJyb3JzIGJlbG93LCB0aGVyZSBhcmUg
c2V2ZXJhbCBlcnJvcnMgYmVzaWRlcyB0aGUgcmVzZXRfY3B1IG9uZS4NCg0KQXMgeW91IGFyZSB1
c2luZyBhbiBvdXQtb2YtdHJlZSBVLUJvb3QsIHRoZXJlIGlzIG5vdCBtdWNoIHRoZSBVLUJvb3QN
CmNvbW11bml0eSBjYW4gZG8gdG8gaGVscCB5b3UsIHNvcnJ5Lg0KDQpZb3UgbmVlZCB0byBnZXQg
YXNzaXN0YW5jZSBmcm9tIHRoZSBVLUJvb3QgcHJvdmlkZXIgdGhhdCB5b3UgYXJlIHVzaW5nLg0K
