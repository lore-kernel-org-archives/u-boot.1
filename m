Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F74DC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 15:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9C686983;
	Mon,  4 Sep 2023 17:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693840679;
	bh=xUXZnlixfsxeOzVeZvc2kpnqVFo9+VBvjFwQ/nvTPNA=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=B4rd/808pI9Lzlqi/ZzBxwXl0GR0PKNA9Jijx7b73BKq5llMPt6fuKX21jN+Oof/B
	 epLvy2HRGTZVY3MTdS/d24qDn+t5Fysjs6vB9e+5FihciHu1NC193do/CXQEoB85GN
	 r1UOun796DmvMKgDiJa/0GuEjls6vupTZUUegGFlSt0Qa45QE5wN9pcxbSAc3kuc2e
	 vlGrf3etO1wy2ohRm12TPOicx42kfTcTfgOuQB9k30ECepMpdqLdLaULTZ3TxnAL2c
	 dE73R5KA8TbGoyH5lKHiS9tCxDGJCTfA+WmmVYE9CJp8N3MOlpLCqjfSDlgSKu4QeC
	 //UX+EXwOujow==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C38B86977; Mon,  4 Sep 2023 17:17:57 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F17CB863CF
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 17:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4RfXM644vbz1r2s2;
 Mon,  4 Sep 2023 17:17:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4RfXM61zSrz1qqlS;
 Mon,  4 Sep 2023 17:17:54 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id V3GykC7O1BtW; Mon,  4 Sep 2023 17:17:53 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon,  4 Sep 2023 17:17:53 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Tim Harvey <tharvey@gateworks.com>
X-Patchwork-Id: 1821580
X-Patchwork-Delegate: sbabic@denx.de
To: Tim Harvey <tharvey@gateworks.com>,u-boot@lists.denx.de
Subject: [PATCH 1/6] board: gateworks: venice: fix gw7904
In-reply-to: <20230815220115.2000851-1-tharvey@gateworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Message-Id: <20230904151757.6C38B86977@phobos.denx.de>
Date: Mon,  4 Sep 2023 17:17:55 +0200 (CEST)
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

PiBBZGQgbWlzc2luZyBpbXg4bW0tdmVuaWNlLWd3NzkwNCB0byBDT05GSUdfT0ZfTElTVAo+IEZp
eGVzIGNvbW1pdCA2MWU3Zjk3MzI1NjUgKCJib2FyZDogZ2F0ZXdvcmtzOiB2ZW5pY2U6IGFkZCBp
bXg4bW0tZ3c3OTA0IHN1cHBvcnQiKQo+IFNpZ25lZC1vZmYtYnk6IFRpbSBIYXJ2ZXkgPHRoYXJ2
ZXlAZ2F0ZXdvcmtzLmNvbT4KQXBwbGllZCB0byB1LWJvb3QtaW14LCBtYXN0ZXIsIHRoYW5rcyAh
CgpCZXN0IHJlZ2FyZHMsClN0ZWZhbm8gQmFiaWMKCi0tIAo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KREVOWCBTb2Z0
d2FyZSBFbmdpbmVlcmluZyBHbWJILCAgICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6IEVyaWthIFVu
dGVyICAKSFJCIDE2NTIzNSBNdW5pY2gsICAgT2ZmaWNlOiBLaXJjaGVuc3RyLjUsIDgyMTk0IEdy
b2ViZW56ZWxsLCBHZXJtYW55ClBob25lOiArNDktODE0Mi02Njk4OS01MyBGYXg6ICs0OS04MTQy
LTY2OTg5LTgwIEVtYWlsOiBzYmFiaWNAZGVueC5kZQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
