Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F38C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 12:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746DD889AF;
	Tue, 30 Apr 2024 14:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA61888B9; Tue, 30 Apr 2024 11:57:57 +0200 (CEST)
Received: from tianjin2.rivoreo.one (unknown [60.25.139.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85250886BF
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 11:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=whr@rivoreo.one
Received: from [10.1.105.1] (localhost [127.0.0.1])
 by tianjin2.rivoreo.one (Postfix) with ESMTP id 5CC9D71CDC;
 Tue, 30 Apr 2024 17:57:45 +0800 (CST)
Received: from 10.1.107.31 (SquirrelMail authenticated user whr)
 by _ with HTTP; Tue, 30 Apr 2024 17:57:45 +0800
Message-ID: <682d8b79cb2c1ef72eebf9a25329e938.squirrel@_>
Date: Tue, 30 Apr 2024 17:57:45 +0800
Subject: [PATCH] zfs: fix function 'zlib_decompress' pointlessly calling itself
From: whr@rivoreo.one
To: u-boot@lists.denx.de
Cc: "Tom Rini" <trini@konsulko.com>,
 mwleeds@mailtundra.com
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20240430175745_55899"
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

------=_20240430175745_55899
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

To prevent crashing due infinite recursion and actually decompress the
requested data, call the zlib function 'uncompress' instead.

Signed-off-by: WHR <msl0000023508@gmail.com>

------=_20240430175745_55899
Content-Type: /;
 name="0001-zfs-fix-function-zlib_decompress-pointlessly-calling"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-zfs-fix-function-zlib_decompress-pointlessly-calling"

ZGlmZiAtLWdpdCBhL2ZzL3pmcy96ZnMuYyBiL2ZzL3pmcy96ZnMuYwppbmRleCBiZmMxMWZhNjY3
Li40ODk2Y2MxOGVmIDEwMDY0NAotLS0gYS9mcy96ZnMvemZzLmMKKysrIGIvZnMvemZzL3pmcy5j
CkBAIC0xNyw2ICsxNyw3IEBACiAjaW5jbHVkZSA8bGludXgvdGltZS5oPgogI2luY2x1ZGUgPGxp
bnV4L2N0eXBlLmg+CiAjaW5jbHVkZSA8YXNtL2J5dGVvcmRlci5oPgorI2luY2x1ZGUgPHUtYm9v
dC96bGliLmg+CiAjaW5jbHVkZSAiemZzX2NvbW1vbi5oIgogI2luY2x1ZGUgImRpdjY0LmgiCiAK
QEAgLTE4Myw3ICsxODQsOCBAQCBzdGF0aWMgaW50CiB6bGliX2RlY29tcHJlc3Modm9pZCAqcywg
dm9pZCAqZCwKIAkJCQl1aW50MzJfdCBzbGVuLCB1aW50MzJfdCBkbGVuKQogewotCWlmICh6bGli
X2RlY29tcHJlc3MocywgZCwgc2xlbiwgZGxlbikgPCAwKQorCXVMb25nZiB6X2Rlc3RfbGVuID0g
ZGxlbjsKKwlpZiAodW5jb21wcmVzcyhkLCAmel9kZXN0X2xlbiwgcywgc2xlbikgIT0gWl9PSykK
IAkJcmV0dXJuIFpGU19FUlJfQkFEX0ZTOwogCXJldHVybiBaRlNfRVJSX05PTkU7CiB9Cg==
------=_20240430175745_55899--


