Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B92606A323
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NQXlkTv1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B2C081203;
	Sat, 14 Nov 2026 04:51:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qdmc1qiW8dRt; Sat, 14 Nov 2026 04:51:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AB95F812BD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794631903;
	b=NH89dNmkMm2DDv/wHL7k+/emPjyS0KuTE16usepy4NtoB9S6BLggpcUt5kfp4fH0jqkF
	 8nEB1Nuw8BXRbi1hMfFGp2mcSx0kM/KWeIreqkTfftpSdpIzcQ2Mqvj7MEvTZc2mR77au
	 A+ZzNN/XFh06e1ZYWLXDyZJ1jk+6AOO5/Ft9B2HUgfkbrIipYnBunGuQ34ZcgY4rCpp51
	 s8Lf80n1CdM7LZmC7MukwfSK9Net0vJ9WBixIDJ95pNQUgiebx/mKJgmj/NVSI7cHcUyH
	 dY1SUM2m7ofCTs5hlVLlaYCiMf+TnAM3rFr92aDc0Bo6fUeL2NlnTWpHhT4BmZyz5lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794631903;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received:Received:X-Originating-IP:
	 Date:X-CM-HeaderCharset:From:To:Cc:Subject:X-Priority:X-Mailer:
	 In-Reply-To:References:X-CM-CTRLMSGS:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=scja8HS3OX6WH7etUKUUt4WtGRY9oBJBy8anJidtOtg=;
	b=QxKnBMngAksG1QG3Y/8pQUckGKSyaURAeyvmjjK0HPPg6cFMNWZoUcFTN7MCYZkbOD3m
	 HDTKrKV5MN6Q0+Awwl6VtqB+83GfyoDJ4vhnpQps0v1kGc/BHKPDwNMGLFV4bmRPV5+yY
	 iMJghRAA3nd6zvRvfEE1BOPo+sxDoT3Vpb2G3v1/c1JXlzDYRbNNcv12poZLhYMBSUA5O
	 0/XLRHNicxvvL1OpZFed8TeBBLFwlLss5p7eJ9R7mZ6kpC1zVp22hOXnXi3zk4ySL8Lo/
	 ALQt90NfD2HYBZ5YcRxYSWH1OTrcLRPkgPlD0ent+1iy+/+FLHYO6R3z7Mpj172hegA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794631903;
	bh=scja8HS3OX6WH7etUKUUt4WtGRY9oBJBy8anJidtOtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NQXlkTv1KkOUzActg57m5TbPelcyN0HQDV0b1oeh93NziuLnRtPZtzCcVgydBCl8E
	 HsXDjwXuqk9cJOkuB854bJpIzWNQYcd+GDYmVFs0ByMGN2vuIgKs9m5I4O86lXHuLP
	 +1ZAcaOZ0tYRmrQYeTFY1gey0iYFXEBrVsCz7naJ1ZNwEyhvDcRX0AsjE4RvQUHoYC
	 v5P198NvyrWJG7wHSDrFGMv77BY/z14oDOhlnXXmWiafnckkveFk8pV42qqp3faVfh
	 QodA6ZDHHWkWBWxQVV2Q9JTOI+JCG6Q02+9FbbeaPMzwhFT/p3Asj0zM1hkMrlkuXF
	 Fvrj4W2aNIdQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB95F812BD;
	Sat, 14 Nov 2026 04:51:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 931DB2E5
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 714E460DA5
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:51:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LY6NNIGsxsRj for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 04:51:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 28DF9606F1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=202.118.224.63
Received: from mail.hit.edu.cn (mail.hit.edu.cn [202.118.224.63])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28DF9606F1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:51:31 +0000 (UTC)
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=alu.hit.edu.cn
Authentication-Results: smtp3.osuosl.org; spf=pass smtp.mailfrom=alu.hit.edu.cn
Received: from 220110626hanxuechao$alu.hit.edu.cn ( [219.223.232.197] ) by
 ajax-webmail-mail-appserver02 (Coremail) ; Sat, 14 Nov 2026 12:51:23 +0800
 (GMT+08:00)
Date: Sat, 14 Nov 2026 12:51:23 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: 220110626hanxuechao@alu.hit.edu.cn
To: "Jonas Karlman" <jonas@kwiboo.se>, "Quentin Schulz" <u-boot@0leil.net>
Cc: "Kever Yang" <kever.yang@rock-chips.com>, "Simon Glass" <sjg@chromium.org>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v2] board: rockchip: Add LCKFB TaishanPi 3M
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2026.2-cmXT5 build
 20261015(8d7e304b) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-0670b814-d594-4118-92e0-dc1bc2f00e12-hit.edu.cn
In-Reply-To: <5f481ac3-f885-4b14-a67e-680f2d9f36f1@kwiboo.se>
References: <20261111165135.245826-1-220110626hanxuechao@alu.hit.edu.cn>
 <179441628581.251684.11046053143224226025@alu.hit.edu.cn>
 <7f90a097-1b57-417d-9e35-d66b1cf898f1@0leil.net>
 <5f481ac3-f885-4b14-a67e-680f2d9f36f1@kwiboo.se>
X-CM-CTRLMSGS: =?B?KqbeDDiH6nJ5xwDR7hwMki1N8jM=
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-ID: <5c5d5535.23e9.1a1d8655b95.Coremail.220110626hanxuechao@alu.hit.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: PkWgCgAnhULL6Pdq3zYhAA--.2946W
X-CM-SenderInfo: yssqiiaqwslx5dq03vpfkd0qhdoxhxllwovvfxof0/1tbiAQQLAGr
 2+2MkIQAAsP
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgSm9uYXMsCgpUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4KCj4gVGhlIGNkLWdwaW9zIHNo
b3VsZCB0eXBpY2FsbHkgb25seSBiZSBuZWVkZWQgZm9yIGNhc2VzIHdoZW4gYSBkaWZmZXJlbnQg
cGFkCj4gaXMgdXNlZCBmb3IgY2FyZCBkZXRlY3Rpb24gc2lnbmFsIG9yIHdoZW4gY2FyZCBkZXRl
Y3Rpb24gaXMgbm90IHRyaWdnZXJlZAo+IHVzaW5nIHRoZSBjb250cm9sbGVyIGRldGVjdGlvbiBs
b2dpYyBkdWUgdG8gZS5nLiBjb250cm9sbGVyIGRldGVjdGlvbiBub3QKPiB3b3JraW5nIHdoZW4g
cG93ZXJlZCBkb3duIGFuZCBHUElPIGZ1bmMgaW5zdGVhZCBjYW4gaGVscCBkZXRlY3Qgd2hlbiBh
IGNhcmQKPiBpcyBpbnNlcnRlZCBhbmQgcG93ZXIgb24gdGhlIGNvbnRyb2xsZXIgKHJrMzU4OCBp
ZiBJIGFtIG5vdCBtaXN0YWtlbikuCj4KPiBOb3Qgc3VyZSByazM1NzYgaGFzIHNpbWlsYXIgZGV0
ZWN0aW9uIGlzc3VlLCBpZiBhIG5ldyBjYXJkIGNhbiBiZSBkZXRlY3RlZAo+IGJ5IExpbnV4IHVz
aW5nIGludGVybmFsIENERVRFQ1QgKG5vIGNkLWdwaW9zKSBhZnRlciBiZWluZyBwb3dlcmVkIG9u
IHdpdGhvdXQKPiBhIGNhcmQgaW5zZXJ0ZWQgdGhlcmUgc2hvdWxkIGxpa2VseSBub3QgYmUgYW55
IG5lZWQgdG8gdXNlIHRoZSBHUElPIGZ1bmMgbXV4Cj4gKHdpdGggY2QtZ3Bpb3MpIGZvciB0aGUg
Ym9hcmQuCgpSZWdhcmRpbmcgdGhlIHNkbW1jIGlzc3VlLCBJIG5lZWQgdG8gZGV0ZXJtaW5lIHRo
ZSBzcGVjaWZpYyByZWFzb24gd2h5CnVwc3RyZWFtIHVzZXMgc2RtbWMwX2RldF9sLiBUaGlzIG1h
eSB0YWtlIGxvbmdlciwgYW5kIEkgd2lsbCByZXBseSBhZnRlcgpJIGhhdmUgZnVydGhlciByZXN1
bHRzLgoKPiBUaGlzIHNvdW5kcyBsaWtlIGEgc3RyYW5nZSBiZWhhdmlvciwgdGhlIGVmaSBib290
bWdyIHNob3VsZCBub3JtYWxseSBiZQo+IGRlZmVycmVkIHVudGlsIGp1c3QgYmVmb3JlICdzbG93
JyBib290IG1lZGlhIGlzIHByb2JlZCAobmV0d29yayksIHN0YXJ0aW5nCj4gZnJvbSB2MjAyNi4w
MS1yYzEuIENvdWxkIGl0IGJlIEJPT1RNRVRIX0VGSUxPQURFUiBiZWhhdmlvciB5b3UgYXJlIG9i
c2VydmluZwo+IGFuZCBwb3NzaWJsZSB3YW50IHRvIGRpc2FibGU/CgpXaGF0IEkgbWVhbnQgaXMg
dGhlIGdsb2JhbCBib290Zmxvd3Mgd2hpY2ggY2FuIGJlIHNraXBwZWQgd2l0aCAiYm9vdGZsb3cg
c2NhbgotRyIuIERpc2FibGluZyBDT05GSUdfQk9PVE1FVEhfRUZJX0JPT1RNR1Igd2FzIGEgcGVy
c29uYWwgcmVxdWlyZW1lbnQsIHNvIEkKd2lsbCBkcm9wIGl0IGFuZCBrZWVwIHRoZSBkZWZhdWx0
IGJvb3QgZmxvdy4KClRoYW5rcywKWHVlY2hhbw==
