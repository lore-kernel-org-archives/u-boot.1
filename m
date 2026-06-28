Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97358C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 06:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7441583FEE;
	Sun, 28 Jun 2026 08:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="hM9yqxFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8405B84409; Sun, 28 Jun 2026 04:37:31 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35813805D7
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 04:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=13738176232@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=87t/lXDFZj2Nh4I2ezA+YSht7G+hnLHHCWem8Qs0ntg=; b=h
 M9yqxFMg3BRW8HrCd6aglpxww3EvSBP/QmButHgq88eLn/EfVEGtFVTFrWIfNEFw
 77QJL0klU6hOpEpU+GxmlKdi/XZ6U1p4blhTd7XQ3j49+llme3rLbTp3gh2nMWuh
 30NbV/C3Papt7oGAW0UHL01wN1APs99epMdPnY9GBA=
Received: from 13738176232$163.com ( [2409:8a28:ccd:4b56:100a:111:27:679e] )
 by ajax-webmail-wmsvr-40-116 (Coremail) ; Sun, 28 Jun 2026 10:37:22 +0800
 (CST)
X-Originating-IP: [2409:8a28:ccd:4b56:100a:111:27:679e]
Date: Sun, 28 Jun 2026 10:37:22 +0800 (CST)
From: BruceYang  <13738176232@163.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com
Subject: Re:Re: [PATCH] usb: xhci: Fix bNbrPorts overwritten by another
 controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <dc5ecf1c-ee61-4434-a19b-966f287f1533@mailbox.org>
References: <1782563839-11379-1-git-send-email-13738176232@163.com>
 <dc5ecf1c-ee61-4434-a19b-966f287f1533@mailbox.org>
X-NTES-SC: AL_Qu2TAPqau0ov5CafZukfmUsVj+04Xsu5vPQn24FWPJh6jD3p+T0FelhFGkna/OOANDiCtxWtVyRP2uREYYZKR5I00qovB388OoGnAcCUu59W7A==
MIME-Version: 1.0
Message-ID: <763c3285.647.19f0c16b57a.Coremail.13738176232@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dCgvCgDXP0XiiEBqDyQSAA--.312W
X-CM-SenderInfo: zprtljayrxljits6il2tof0z/xtbCzQIFcGpAiOK+KAAA3s
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Sun, 28 Jun 2026 08:06:14 +0200
Content-Type: text/plain; charset=GBK
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

TXkgcGF0Y2gganVzdCBmaXggc2V0IGEgY29ycmVjdCBiTmJyUG9ydHMgdmFsdWUgZm9yIHBlciBY
SENJIGNvbnRyb2xsZXIsIGJ1dCB0aGlzIGNvZGUgbW9kaWZpY2F0aW9uIGlzIGxlc3MuIApZZXMs
IHlvdXIgYWR2aWNlIGhhdmluZyBvbmUgZGVzY3JpcHRvciBwZXIgY29udHJvbGxlciBpcyBtb3Jl
IHByb3Blcmx5LCB0aGlzIGNhbiBzb2x2ZSBhbGwgb3RoZXIgcG90ZW50aWFsIHByb2JsZW1zLiAK
CgoKCgoKCgoKCgoKQXQgMjAyNi0wNi0yOCAwNDoxMDoxMywgIk1hcmVrIFZhc3V0IiA8bWFyZWsu
dmFzdXRAbWFpbGJveC5vcmc+IHdyb3RlOgo+T24gNi8yNy8yNiAyOjM3IFBNLCBCZWliZWkgWWFu
ZyB3cm90ZToKPj4gSW4gYSBzeXN0ZW0gd2l0aCBtdWx0aXBsZSBYSENJIGNvbnRyb2xsZXJzLCB0
aGUgZ2xvYmFsIGRlc2NyaXB0b3IuaHViCj4+IChiTmJyUG9ydHMpIGNhbiBiZSBvdmVyd3JpdHRl
biBieSBhIGxhdGVyIGluaXRpYWxpemVkIGNvbnRyb2xsZXIsCj4+IGNhdXNpbmcgdGhlIHJvb3Qg
aHViIG9mIGFuIGVhcmxpZXIgY29udHJvbGxlciB0byByZXBvcnQgd3JvbmcgcG9ydAo+PiBudW1i
ZXJzLgo+PiAKPj4gRml4IHRoaXMgYnkgZHluYW1pY2FsbHkgc2V0dGluZyBiTmJyUG9ydHMgZnJv
bSB0aGUgY3VycmVudCBjb250cm9sbGVyJ3MKPj4gaGNzcGFyYW1zMSBpbiB0aGUgVVNCX0RUX0hV
QiByZXF1ZXN0IGhhbmRsZXIsIGluc3RlYWQgb2YgcmVseWluZyBvbgo+PiBhIHN0YWxlIGdsb2Jh
bCB2YWx1ZS4KPgo+SG93IGFib3V0IGhhdmluZyBvbmUgZGVzY3JpcHRvciBwZXIgY29udHJvbGxl
ciA/Cj4KPlRoaXMgaXMgcHJvYmFibHkgZWFzaWx5IGRvYWJsZSBpbiB4aGNpX2xvd2xldmVsX2lu
aXQoKSB3aXRoIHNvbWUgCj5jdHJsLT5odWJfZGVzYyA9IGttZW1kdXAoZGVzY3JpcHRvci5odWIs
Li4uKTsgYW5kIHJlbGF0ZWQgdHdlYWtzLgo+Cj5XaGF0IGRvIHlvdSB0aGluayA/Cg==
