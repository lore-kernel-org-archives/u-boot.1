Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4148C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 12:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE78887BA;
	Tue, 30 Apr 2024 14:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE61E889B0; Tue, 30 Apr 2024 10:34:54 +0200 (CEST)
Received: from tianjin2.rivoreo.one (unknown [60.25.139.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE3A8889AB
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 10:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=whr@rivoreo.one
Received: from [10.1.105.1] (localhost [127.0.0.1])
 by tianjin2.rivoreo.one (Postfix) with ESMTP id EF01871C2F;
 Tue, 30 Apr 2024 16:34:42 +0800 (CST)
Received: from 10.1.107.31 (SquirrelMail authenticated user whr)
 by _ with HTTP; Tue, 30 Apr 2024 16:34:42 +0800
Message-ID: <80535f3983d4df93bfbeaed881e60096.squirrel@_>
Date: Tue, 30 Apr 2024 16:34:42 +0800
Subject: [PATCH] sandbox: make function 'do_undefined' properly compiles for
 PowerPC
From: whr@rivoreo.one
To: u-boot@lists.denx.de
Cc: "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20240430163442_22446"
X-Priority: 3 (Normal)
Importance: Normal
X-Mailman-Approved-At: Tue, 30 Apr 2024 14:18:01 +0200
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

------=_20240430163442_22446
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The 2 bytes 0xffff is too short for being a PowerPC instruction, resulting
in an error similar to:
    /tmp/ccW8yjie.s: Assembler messages:
    /tmp/ccW8yjie.s: Error: unaligned opcodes detected in executable segment
    /tmp/ccW8yjie.s:223: Error: instruction address is not a multiple of 4
    make[2]: *** [/tmp/ccyF4HIC.mk:17: /tmp/ccCKUFuF.ltrans5.ltrans.o]
Error 1

Signed-off-by: WHR <msl0000023508@gmail.com>

------=_20240430163442_22446
Content-Type: /;
 name="0001-sandbox-make-function-do_undefined-properly-compiles"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-sandbox-make-function-do_undefined-properly-compiles"

ZGlmZiAtLWdpdCBhL2NtZC9zYW5kYm94L2V4Y2VwdGlvbi5jIGIvY21kL3NhbmRib3gvZXhjZXB0
aW9uLmMKaW5kZXggY2ZhMTUzZGEyNi4uZjljODQ3ZDhmZiAxMDA2NDQKLS0tIGEvY21kL3NhbmRi
b3gvZXhjZXB0aW9uLmMKKysrIGIvY21kL3NhbmRib3gvZXhjZXB0aW9uLmMKQEAgLTE5LDcgKzE5
LDExIEBAIHN0YXRpYyBpbnQgZG9fc2lnc2VndihzdHJ1Y3QgY21kX3RibCAqY21kdHAsIGludCBm
bGFnLCBpbnQgYXJnYywKIHN0YXRpYyBpbnQgZG9fdW5kZWZpbmVkKHN0cnVjdCBjbWRfdGJsICpj
bWR0cCwgaW50IGZsYWcsIGludCBhcmdjLAogCQkJY2hhciAqY29uc3QgYXJndltdKQogeworI2lm
ZGVmIF9fcG93ZXJwY19fCisJYXNtIHZvbGF0aWxlICgiLmxvbmcgMHhmZmZmZmZmZlxuIik7Cisj
ZWxzZQogCWFzbSB2b2xhdGlsZSAoIi53b3JkIDB4ZmZmZlxuIik7CisjZW5kaWYKIAlyZXR1cm4g
Q01EX1JFVF9GQUlMVVJFOwogfQogCg==
------=_20240430163442_22446--


