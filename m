Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32492C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 02:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AEAD879A6;
	Wed, 25 Oct 2023 04:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="o9xH5ard";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D308E8710A; Wed, 25 Oct 2023 02:00:46 +0200 (CEST)
Received: from m1345.mail.163.com (m1345.mail.163.com [220.181.13.45])
 by phobos.denx.de (Postfix) with ESMTP id 12FE5879AB
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 02:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=simitel@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=tnyfEyHS3vwU09rTCRyVTA7P9ZMX2F4wwbn0GL6Ev2s=; b=o
 9xH5ardvva8O4vHSqn8W1DSx9znMtgEnQnPRBTRFqlDwpUzuj2WjRPaylJhdZVtG
 EeaOKH/G8xHmUgQFL+yAHBMrroZU14NNAwRIHo6BPTPQicrJrs/QhV/GR9sPLJw0
 Actpn1x209XHCmbsIVTAgK357j5Qf/9tKiHL+An/bY=
Received: from simitel$163.com ( [103.150.184.106] ) by ajax-webmail-wmsvr45
 (Coremail) ; Wed, 25 Oct 2023 08:00:37 +0800 (CST)
X-Originating-IP: [103.150.184.106]
Date: Wed, 25 Oct 2023 08:00:37 +0800 (CST)
From: target <simitel@163.com>
To: u-boot@lists.denx.de
Subject: Failedto read big file with "Invald FAT entry' from USB disk (FAT16)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
X-NTES-SC: AL_QuySCv2SvUgo4SKcZekXnkwQj+c9W8WxuPsm2oRUO500hyn38CAEUkJyI0D4/d2rDQKqjSWbSyFs8eB3f5Fcfq2D7IfYZ6uXaJZ79xaF7BaO
MIME-Version: 1.0
Message-ID: <279f2b49.1e2.18b6422157c.Coremail.simitel@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LcGowAD33ymmWjhl6AYYAA--.7242W
X-CM-SenderInfo: pvlpx3lho6il2tof0z/xtbBogUTW1aEJ+VoUQAEsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Wed, 25 Oct 2023 04:34:13 +0200
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

SSBhbSB1c2luZyB1LWJvb3QgMjAxNy4wMyBpbiBteSBzeXN0ZW0gYW5kIGVuYWJsZWQgdGhlIGRl
YnVnIGluIGZzL2ZhdC9mYXQuYwpJIGhhZCBhIFVTQiBkaXNrIGZvcm1hdHRlZCBpbiBGQVQxNiBp
biBMaW51eCwgSSBwdXQgYSBiaWdmaWxlLmJpbiBpbnRvIC8gaW4gdGhlIFVTQiBkaXNrIGFuZCBw
bHVnZ2VkIHRoZSBkaXNrIGludG8gYnkgYm9hcmQuClRoZW4gSSB3YW50IHRvIHJlYWQvbG9hZCB0
aGUgYmlnZmlsZS5iaW4gaW50byBSQU0gd2l0aCB1LWJvb3QncyBmYXRsb2FkIGNvbW1hbmQsIEkg
ZGlkIGZvbGxvd2luZ3MuCgoKIyB1c2IgcmVzZXQKIyBmYXRscyB1c2IgMCwgaXQgc2hvd2QsClZG
QVQgU3VwcG9ydCBlbmFibGVkCkZBVDE2LCBmYXRfc2VjdDogMTI4LCBmYXRsZW5ndGg6IDEyOApS
b290ZGlyIGJlZ2lucyBhdCBjbHVzdGVyOiAwLCBzZWN0b3I6IDM4NCwgb2Zmc2V0OiAzMDAwMApE
YXRhIGJlZ2lucyBhdDogMjU2ClNlY3RvciBzaXplOiA1MTIsIGNsdXN0ZXIgc2l6ZTogMTI4CkZB
VCByZWFkKHNlY3Q9Mzg0LCBjbnQ6MiksIGNsdXN0X3NpemU9MTI4LCBESVJFTlRTUEVSQkxPQ0s9
MTYKIDM2NDM4MDE2ICAgYmlnZmlsZS5iaW4KICAgICAxMDEyICAgczAxc3lzbG9nZAogICAgIDEw
MDQgICBzMDJrbG9nZAogICAgIDE4NzYgICBzMDJzeXNjdGwKICAgICAxNjg0ICAgczIwdXJhbmRv
bQogICAgICAyMTQgICBzMjFtb3VudApFTkQgTE9PUDogYnVmZmVyX2Jsa19jbnQ9MCAgIGNsdXN0
X3NpemU9MTI4CkZBVCByZWFkKHNlY3Q9Mzg1LCBjbnQ6MiksIGNsdXN0X3NpemU9MTI4LCBESVJF
TlRTUEVSQkxPQ0s9MTYKICAgICAxNjM1ICAgczMwZGJ1cwogICAgICA0MzggICBzNDBuZXR3b3Jr
ClJvb3REZW50bmFtZSA9PSBOVUxMIC0gMTMKCgo4IGZpbGUocyksIDAgZGlyKHMpCiMgZmF0bG9h
ZCB1c2IgMCAweDEwMDAwMCBiaWdmaWxlLmJpbgpyZWFkaW5nIGJpZ2lsZS5iaW4KVkZBVCBTdXBw
b3J0IGVuYWJsZWQKRkFUMTYsIGZhdF9zZWN0OiAxMjgsIGZhdGxlbmd0aDogMTI4ClJvb3RkaXIg
YmVnaW5zIGF0IGNsdXN0ZXI6IDAsIHNlY3RvcjogMzg0LCBvZmZzZXQ6IDMwMDAwCkRhdGEgYmVn
aW5zIGF0OiAyNTYKU2VjdG9yIHNpemU6IDUxMiwgY2x1c3RlciBzaXplOiAxMjgKRkFUIHJlYWQo
c2VjdD0zODQsIGNudDoyKSwgY2x1c3Rfc2l6ZT0xMjgsIERJUkVOVFNQRVJCTE9DSz0xNgpSb290
dmZhdG5hbWU6IHxiaWdmaWxlLmJpbnwKUm9vdE5hbWU6IGJpZ2ZpbGUuYmluLCBzdGFydDogMHgz
LCBzaXplOiAgMHgyMmMwMDAwCkZpbGVzaXplOiAzNjQzODAxNiBieXRlcwozNjQzODAxNiBieXRl
cwpGQVQxNjogZW50cnk6IDB4MDAwMyA9IDMsIG9mZnNldDogMHgwMDAzID0gMwpGQVQxNjogcmV0
OiAwMDAwMDAwNCwgb2Zmc2V0OiAwMDAzCkZBVDE2OiBlbnRyeTogMHgwMDA0ID0gNCwgb2Zmc2V0
OiAweDAwMDQgPSA0CkZBVDE2OiByZXQ6IDAwMDAwMDA1LCBvZmZzZXQ6IDAwMDQKRkFUMTY6IGVu
dHJ5OiAweDAwMDUgPSA1LCBvZmZzZXQ6IDB4MDAwNSA9IDUKRkFUMTY6IHJldDogMDAwMDAwMDYs
IG9mZnNldDogMDAwNQpGQVQxNjogZW50cnk6IDB4MDAwNiA9IDYsIG9mZnNldDogMHgwMDA2ID0g
NgpGQVQxNjogcmV0OiAwMDAwMDAwNywgb2Zmc2V0OiAwMDA2CkZBVDE2OiBlbnRyeTogMHgwMDA3
ID0gNywgb2Zmc2V0OiAweDAwMDcgPSA3CkZBVDE2OiByZXQ6IDAwMDAwMDA4LCBvZmZzZXQ6IDAw
MDcKRkFUMTY6IGVudHJ5OiAweDAwMDggPSA4LCBvZmZzZXQ6IDB4MDAwOCA9IDgKRkFUMTY6IHJl
dDogMDAwMDAwMDksIG9mZnNldDogMDAwOApGQVQxNjogZW50cnk6IDB4MDAwOSA9IDksIG9mZnNl
dDogMHgwMDA5ID0gOQpGQVQxNjogcmV0OiAwMDAwMDAwYSwgb2Zmc2V0OiAwMDA5Ci4uLi4uCi4u
Li4uCkZBVDE2OiBlbnRyeTogMHgwMjBlID0gNTI2LCBvZmZzZXQ6IDB4MDIwZSA9IDUyNgpGQVQx
NjogcmV0OiAwMDAwMDIwZiwgb2Zmc2V0OiAwMjBlCkZBVDE2OiBlbnRyeTogMHgwMjBmID0gNTI3
LCBvZmZzZXQ6IDB4MDIwZiA9IDUyNwpGQVQxNjogcmV0OiAwMDAwMDIxMCwgb2Zmc2V0OiAwMjBm
CkZBVDE2OiBlbnRyeTogMHgwMjEwID0gNTI4LCBvZmZzZXQ6IDB4MDIxMCA9IDUyOApGQVQxNjog
cmV0OiAwMDAwZmZmZiwgb2Zmc2V0OiAwMjEwCmdjIC0gY2x1c3RudW06IDMsIHN0YXJ0c2VjdDog
NjQwCkZBVDE2OiBlbnRyeTogMHgwMjEwID0gNTI4LCBvZmZzZXQ6IDB4MDIxMCA9IDUyOApGQVQx
NjogcmV0OiAwMDAwZmZmZiwgb2Zmc2V0OiAwMjEwCmN1cmNsdXN0OiAweGZmZmYKSW52YWxpZCBG
QVQgZW50cnkKU2l6ZTogMzY0MzgwMTYsIGdvdDogMzQ0NzE5MzYKCgpJIGhhdmUgdHJpZWQgbWFu
eSB0aW1lcywgZXZlbiB3aXRoICJmYXRsb2FkIHVzYiAwIDB4MTAwMDAwIGJpZ2ZpbGUuYmluIDIw
MDAwMDAiLCBpdCBzdGlsbCBmYWlsZWQgd2l0aCBhYm92ZSBlcnJvci4KSSBjYW4gbm90IHRlc3Qg
bmV3ZXIgdmVyc2lvbiBvZiB1LWJvb3QsIHNpbmNlIHRoZXJlIGFyZSBsb3RzIG9mIG9sZCBkcml2
ZXJzIEkgYW0gdXNpbmcuCgoKCgoK
