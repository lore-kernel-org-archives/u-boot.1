Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E1DC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C26060821;
	Mon, 17 Aug 2026 13:34:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Li-WlLYAA1o4; Mon, 17 Aug 2026 13:34:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1888760780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973664;
	bh=dm6NCKjx4VBhVQkpQ3J9WKHWij/psxEACH65CnQtxdk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=po9UN/2SN96npGyGbGYgcxai6z1LfovEfcJriczRbf+aTAKxGLzCWQRkmKv2nT4TU
	 xeoXnXKjB9ltuPJWj67lv6sWjpNLVc9rmZcNSKUYpjgK4u5N9IZbPNC/kyi6ut4Hx6
	 4Rsz4X7CECNiqqoh4gINbWnuSXt0K8b/cKDmVMTjaFNVJYCWgcZXL7v/yYtY+3UI+Y
	 d0AXdTYPCSzlSwLLvckhvcPMyTJiIbHhxx/lLkOErL24Nu1w8OtM0963DwySUl+0XM
	 OcA7XD/pnqpO5lt7jojoYk09QLHVFVRtnMgQgCV+Em48YTVAwwHPypwKeQdm74ISmH
	 FjFYRa5BwV6Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1888760780;
	Mon, 17 Aug 2026 13:34:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F12623F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 808E640360
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8JXoXx6M08JB for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:16:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.28.2;
 helo=out28-2.mail.aliyun.com; envelope-from=pcb@armdesigner.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 534CD40352
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=armdesigner.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 534CD40352
Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 534CD40352
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:16:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09281676|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.22982-0.00347802-0.766702;
 FP=4706977368275842873|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037026024;
 MF=pcb@armdesigner.com; NM=1; PH=DS; RN=1; RT=1; SR=0;
 TI=SMTPD_---.ip.PkBT_1786958198; 
Received: from DESKTOP-F4DGRM2(mailfrom:pcb@armdesigner.com
 fp:SMTPD_---.ip.PkBT_1786958198 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 17 Aug 2026 17:16:39 +0800
Date: Mon, 17 Aug 2026 17:16:38 +0800
From: pcb <pcb@armdesigner.com>
To: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH 11/15] clk: rockchip: rk3576: Fix trivial clock
 configuration errors
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.563[cn]
Mime-Version: 1.0
Message-ID: <202608171716374871622@armdesigner.com>
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

SGkgSm9uYXMsIFF1ZW50aW4sIA0KDQpXZSBhcmUgYW4gZW1iZWRkZWQgZGVzaWduIGhvdXNlIGJ1
aWxkaW5nIHByb2R1Y3RzIG9uIHRoZSBSSzM1NzYsIGFuZCB0aGlzIHNlcmllcyBsaW5lcyB1cCB3
aXRoIHNldmVyYWwgY2xvY2stcmVsYXRlZCBpc3N1ZXMgd2UgaGF2ZSBoaXQgZHVyaW5nIG91ciBv
d24gVS1Cb290IGJyaW5nLXVwLiANClRoYW5rcyBmb3IgcHV0dGluZyBpdCB0b2dldGhlciChqiBh
bmQgZm9yIHRoZSBob25lc3Qgbm90ZSB0aGF0IHNvbWUgb2YgdGhlc2UgZml4ZXMgYXJlIG9ubHkg
Y29tcGlsZS10ZXN0ZWQuIFRoYXQgaXMgZXhhY3RseSB0aGUgZ2FwIHdlIGNhbiBoZWxwIGNsb3Nl
LiANCk9uIHRoZSBSSzM1NzYgc2lkZSBzcGVjaWZpY2FsbHksIHRoZSBmaXhlcyBpbiBwYXRjaCAx
MSB0aGF0IG1hdHRlciBtb3N0IHRvIHVzIGluIHByb2R1Y3Rpb24gYXJlIHRoZSBWUExMIG1vZGUg
cmVnaXN0ZXIgY29ycmVjdGlvbiAod2UgcmVseSBvbiBWUExMIGZvciBkaXNwbGF5IGNsb2Nrcykg
DQphbmQgdGhlIFBQTEwgYmFzZSBmaXggZnJvbSBQTVUgZG9tYWluIHRvIFBIUCBkb21haW4gKFBQ
TEwgZmVlZHMgdGhlIERSQU0gY29udHJvbGxlciwgc28gYSB3cm9uZyByZWdpc3RlciB3aW5kb3cg
aGVyZSBpcyB0aGUga2luZCBvZiB0aGluZyB0aGF0IG9ubHkgc2hvd3MgdXAgYXMgaW50ZXJtaXR0
ZW50IGluc3RhYmlsaXR5IHJhdGhlciB0aGFuIGEgY2xlYW4gZmFpbHVyZSkuIA0KDQpIYXBweSB0
byBzaGFyZSBtb3JlIGNvbmNyZXRlIG9ic2VydmF0aW9ucyBpZiB1c2VmdWwuIE9uIFF1ZW50aW4n
cyBwb2ludCBhYm91dCBSSzM1NzZfTU9ERV9DT04wIGJlaW5nIGluY29ycmVjdCBmb3IgUFBMTCBi
dXQgbWFza2VkIGJ5IFJPQ0tDSElQX1BMTF9GSVhFRF9NT0RFOiBJIGFncmVlIGEgbmV3IG1hY3Jv
IGlzIHRoZSByaWdodCBsb25nLXRlcm0gZGlyZWN0aW9uLCANCmFuZCBJIHdvdWxkIGFkZCBvbmUg
bW9yZSBhbmdsZSChqiB0aGUgc2FtZSBsYXRlbnQgaGF6YXJkIGV4aXN0cyBpbiB0aGUgUkszNTg4
IFBQTEwgZW50cnksIHNvIHdoYXRldmVyIHdlIHNldHRsZSBvbiBzaG91bGQgYmUgYXBwbGllZCB0
byBib3RoIGRyaXZlcnMgaW4gdGhlIHNhbWUgc2VyaWVzLiANCkluIHRoZSBtZWFudGltZSwgYSBj
b21waWxlLXRpbWUgYXNzZXJ0aW9uIGluIHRoZSBQTEwoKSBtYWNybyAoZS5nLiBCVUlMRF9CVUdf
T04gd2hlbiBGSVhFRF9NT0RFIGlzIHNldCBidXQgYSBtb2RlIHJlZ2lzdGVyIGlzIHN0aWxsIHJl
cXVpcmVkKSB3b3VsZCBwcmV2ZW50IGZ1dHVyZSBjb250cmlidXRvcnMgZnJvbSBzaWxlbnRseSBy
ZWludHJvZHVjaW5nIHRoZSB3cm9uZyBhZGRyZXNzLg0KSWYgdXNlZnVsLCB3ZSBjYW4gZHJhZnQg
dGhhdCBhcyBhIGZvbGxvdy11cCBwYXRjaC4gRmluYWxseSwgaWYgYSB2MiBpcyBub3QgYWxyZWFk
eSBpbiBmbGlnaHQ6IHdlIHdvdWxkIGJlIGhhcHB5IHRvIHRlc3QgcGF0Y2hlcyA0LCA1LCBhbmQg
MTEgb24gb3VyIFJLMzU3NiByZWZlcmVuY2UgaGFyZHdhcmUgKEREUiBpbml0LCBWUExML2Rpc3Bs
YXkgYnJpbmctdXAsIGFuZCBJMkMgcGFyZW50IHNlbGVjdGlvbiBhcmUgYWxsIGV4ZXJjaXNlZCBk
dXJpbmcgb3VyIHJlZ3VsYXIgYm9vdCB0ZXN0aW5nKSBhbmQgcHJvdmlkZSBUZXN0ZWQtYnkgdGFn
cyBwbHVzIGFueSByYXRlIG1pc21hdGNoZXMgd2Ugb2JzZXJ2ZS4gQmVzdCByZWdhcmRzLA0KDQpP
d2VuDQpCb2FyZGNvbiBFbWJlZGRlZCBEZXNpZ24gTGltaXRlZA0KaHR0cHM6Ly93d3cuYm9hcmRj
b24uY29tDQoNCg0KDQo=
