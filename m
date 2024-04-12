Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C03C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 13:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 723F487F04;
	Fri, 12 Apr 2024 15:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="DLErBudE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F8C87E74; Fri, 12 Apr 2024 12:11:54 +0200 (CEST)
Received: from m15.mail.163.com (m16.mail.163.com [117.135.210.5])
 by phobos.denx.de (Postfix) with ESMTP id 42BF58785F
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 12:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=18304935041@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=MpSAPU6r6E9K0SDY4K0u02cO4G/R5N3NS6CiFHBJKG0=; b=D
 LErBudEUnWvcAYV28nHOcNwlaiRZ0U/MzQN9IhIxr77CAFIHFnuEqlCMt4oP7bbf
 CKYCpiKYqk3xg0Lr+yxT7Ehx+hOaVgFzoEqsirhNbkvLwMZw5EmQWxqAEE0bm+7X
 FTrkfNohvnKrJJmbJUbx4ZNO1g7+fF472nbNB2Wyxo=
Received: from 18304935041$163.com ( [121.18.90.146] ) by
 ajax-webmail-wzpm-k8s-gz (Coremail) ; Fri, 12 Apr 2024 18:11:46 +0800
 (GMT+08:00)
X-Originating-IP: [121.18.90.146]
Date: Fri, 12 Apr 2024 18:11:46 +0800 (GMT+08:00)
From: 18304935041 <18304935041@163.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [U-Boot] [PATCH] mmc: dw-mmc: support DesignWare MMC controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT build
 20230828(bca80109) MailMasterPC/5.0.9.1006_(10.0.22631) Copyright (c)
 2002-2024 www.mailtech.cn 163com
X-CM-CTRLMSGS: EBUio3RyYWNlS2V5PTY5YmI3ZTVjZDhhZGI3Njk5MDJkNzliOTMxZDZhY2Qz
X-NTES-SC: AL_Qu2aAPWauU8r4CefbOkfm0cUgek7W8qyvP8h2YRVO51wjATuxjwKbXNqIFnm1eaSDgCxiDG+XB5V8M9YVIRlb5AX6yl4+g3WxKVKWY8SmXZllg==
MIME-Version: 1.0
Message-ID: <1e0e4980.3448f.18ed1cab5e1.Coremail.18304935041@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wDnj87jCBlmIAENAA--.56508W
X-CM-SenderInfo: jpryjiiuztkiiur6il2tof0z/1tbiqA2tz2VOC-ws6AAEsb
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Fri, 12 Apr 2024 15:29:37 +0200
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

RGVhciBNci4gSmFlaG9vbiBDaHVuZywgSGVsbG8hCgpJIGFtIGxlYXJuaW5nIHRvIHdyaXRlIGFu
IG1tYyBkcml2ZXIsIEkgc2F3IHRoaXMgZHJpdmVyIGNvZGUgeW91IHdyb3RlIGluIDIwMTIgaW4g
VS1ib290IHNvdXJjZSBjb2RlLCBJIGNhbid0IGRvd25sb2FkIHRoZSBkb2N1bWVudGF0aW9uIG9m
IERlc2lnbldhcmUgTU1DIGNvbnRyb2xsZXIsIHNvIEkgY2FuJ3Qgd29yayBvbiBteSBkcml2ZXIg
ZGV2ZWxvcG1lbnQuIApJIGhvcGUgeW91IGNhbiBwcm92aWRlIHNvbWUgaGVscCEgSGF2ZSBhIG5p
Y2UgbGlmZSE=
