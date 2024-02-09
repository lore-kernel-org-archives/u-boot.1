Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA460C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 12:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE09F87E60;
	Fri,  9 Feb 2024 13:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=olakrutrim.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=olakrutrim.com header.i=@olakrutrim.com header.b="JBr9/5Fx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B25F687E39; Fri,  9 Feb 2024 08:52:24 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EAF387B6B
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 08:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=olakrutrim.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=selvakumar.velandi@olakrutrim.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-296c2b74448so463098a91.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 23:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=olakrutrim.com; s=google; t=1707465140; x=1708069940; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cXdwy1tfCqNJc7HySyBudeCO2ixFHGyic8IWRB1Xtoo=;
 b=JBr9/5FxBsRNFjVpPdFprpSQ/HdPfokvu+LOyYOMn4UIpFyffrlYQWdniAU39c1u3E
 dF8m4J7zyF2AAy4o05HYbTGIB1FKfqA3DXhyOz3M9ytxW4hc/YrG9AVhgcwYhpqc97Ew
 Zm247aq0rLwdwcUQcb8j1yfAwz0R95fMfu8EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707465140; x=1708069940;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cXdwy1tfCqNJc7HySyBudeCO2ixFHGyic8IWRB1Xtoo=;
 b=bj6dSYGpfXVhTRwdk3mmfRe+8Semj87KIBjSvYgFAZTcuRz8g6oCbm+7REtWBPCUj0
 mjU3S64Sd/2OC5fQzonC5Ro1JtQsTns6Po3wQ4HdWV5AeBsJZU5p1HLIG6xH/btziHXG
 qg5XKZqQHqSg5hjaJAWyiR99TOO7qinF4cQbprBtOZd8Qyc+IoP58XuM2CqN+gl7rfd/
 z+FmSBolfVz177pZSLNnqL2H8a7VRa2RlJsy1irbs9Oul4bgvgflSmFup/zQ1CTzLS1e
 PCe5O5mIY53gVwbuHjXZe1s43IE+ha0hntYyH1qAmMl2Vp7AZlf5Er0gk/WCgIHQtYOS
 fGUQ==
X-Gm-Message-State: AOJu0YzijL616RY5+SdhMNNlKulhs7sROQE8Zg6fsuCVlyRdbe42lSCB
 KUwTwnxBkbeWFtDet52S3XvFH5z7bgtjEzmqRkZrV9GbrlfiQogSksvuqmCKJ8RcI5aSICpoO2j
 O+SjINudDpqVg9ESF9IUMVb5M4CW8EUUh/CSrFWv0excXmlF6Jp20ccvY9RsxRjAIW9LBh3aZVK
 Y6cxbLFX34s+n7dtlD5IsPHY3D0Vp8rw==
X-Google-Smtp-Source: AGHT+IGCyO+R/m6JAfT9q5wWsIIpOxMZd8XHijxu21D780LHpKmzWF0XjicrfGSVolPM0B8QWPVRjA6U0f1XO0HWCJU=
X-Received: by 2002:a17:90a:7527:b0:295:eaff:78f3 with SMTP id
 q36-20020a17090a752700b00295eaff78f3mr717375pjk.8.1707465140074; Thu, 08 Feb
 2024 23:52:20 -0800 (PST)
MIME-Version: 1.0
From: Selvakumar Velandi <selvakumar.velandi@olakrutrim.com>
Date: Fri, 9 Feb 2024 13:22:08 +0530
Message-ID: <CAJ-dvqwMWvWw0=34ZLkG37MwTRG1m_tabSi0zLkoHNY8CjR_PQ@mail.gmail.com>
Subject: [PATCH] Added FDT PAD memory size while reserving memory for FDT to
 avoid some memory corruption issue
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="0000000000002486cf0610ee35c5"
X-Mailman-Approved-At: Fri, 09 Feb 2024 13:04:59 +0100
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

--0000000000002486cf0610ee35c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Issue:
Linux kernel getting crash after loading kernel in VM system using RISCV
QEMU.

RootCause:
Memory corruption in uboot FDT memory while launching a VM system in RISCV
QEMU.

Fix:
In the board_f.c file the FDT memory region is reserved without FDT padding
bytes. uboot will add some params like bootargs while launching linux.
While relocate the FDT, if its decided as run in the Fixed memory location
i.e fdy_high is set as -1, then the padding bytes not added while
relocating the FDT,
but the size is blindly added with padding bytes without reserving the
physical memory in the FDT header in the image_fdt.c file.

Please find the attached patch file to fix the issue. Please review and
revert your comments.

Regards,
SelvakumarVelandi
Krutrim SI designs

--=20
***
This communication is confidential, may be privileged and is meant only=20
for the intended recipient and purpose. No part of this email or any files=
=20
transmitted with it can be shared, copied, forwarded or published online or=
=20
offline, without=C2=A0prior=C2=A0written consent of the sender. If you are =
not the=20
intended recipient, please preserve the confidentiality, delete the e-mail=
=20
and attachments, if any from your system and inform the sender immediately.=
=C2=A0
=C2=A0

***






--0000000000002486cf0610ee35c5
Content-Type: application/x-patch; 
	name="0001-PATCH-RISCV-QEMU-Add-PAD-size-during-the-FDT-memory-.patch"
Content-Disposition: attachment; 
	filename="0001-PATCH-RISCV-QEMU-Add-PAD-size-during-the-FDT-memory-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lsbflb0r0>
X-Attachment-Id: f_lsbflb0r0

RnJvbSBmMTI4YzMwOWEwNDgxMzYzOTUyZjcxOTYxODBmODNjZTM3NjYzMTkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWx2YWt1bWFyIFZlbGFuZGkgPHNlbHZha3VtYXIudmVsYW5k
aUBvbGFzaWxpY29uLmNvbT4KRGF0ZTogV2VkLCA3IEZlYiAyMDI0IDEyOjE2OjU5ICswNTMwClN1
YmplY3Q6IFtQQVRDSF0gW1BBVENIXSBSSVNDViBRRU1VOiBBZGQgUEFEIHNpemUgZHVyaW5nIHRo
ZSBGRFQgbWVtb3J5CiByZXNlcnZhdGlvbiBhbmQgdXBkYXRlIHRoZSBGRFQgc2l6ZSBhbHNvLgoK
LS0tCiBib290L2ltYWdlLWZkdC5jIHwgMTAgKysrKysrKystLQogY29tbW9uL2JvYXJkX2YuYyB8
IDEyICsrKysrKysrKysrLQogMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Jvb3QvaW1hZ2UtZmR0LmMgYi9ib290L2ltYWdlLWZk
dC5jCmluZGV4IDc1YmRkNTVmMzIuLmNhYzVkYzEwYjQgMTAwNjQ0Ci0tLSBhL2Jvb3QvaW1hZ2Ut
ZmR0LmMKKysrIGIvYm9vdC9pbWFnZS1mZHQuYwpAQCAtMTc4LDggKzE3OCw3IEBAIGludCBib290
X3JlbG9jYXRlX2ZkdChzdHJ1Y3QgbG1iICpsbWIsIGNoYXIgKipvZl9mbGF0X3RyZWUsIHVsb25n
ICpvZl9zaXplKQogCX0KIAogCS8qIHBvc2l0aW9uIG9uIGEgNEsgYm91bmRhcnkgYmVmb3JlIHRo
ZSBhbGxvY19jdXJyZW50ICovCi0JLyogUGFkIHRoZSBGRFQgYnkgYSBzcGVjaWZpZWQgYW1vdW50
ICovCi0Jb2ZfbGVuID0gKm9mX3NpemUgKyBDT05GSUdfU1lTX0ZEVF9QQUQ7CisJb2ZfbGVuID0g
Km9mX3NpemU7CiAKIAkvKiBJZiBmZHRfaGlnaCBpcyBzZXQgdXNlIGl0IHRvIHNlbGVjdCB0aGUg
cmVsb2NhdGlvbiBhZGRyZXNzICovCiAJZmR0X2hpZ2ggPSBlbnZfZ2V0KCJmZHRfaGlnaCIpOwpA
QCAtMTkzLDYgKzE5Miw4IEBAIGludCBib290X3JlbG9jYXRlX2ZkdChzdHJ1Y3QgbG1iICpsbWIs
IGNoYXIgKipvZl9mbGF0X3RyZWUsIHVsb25nICpvZl9zaXplKQogCQkJbG1iX3Jlc2VydmUobG1i
LCBtYXBfdG9fc3lzbWVtKG9mX3N0YXJ0KSwgb2ZfbGVuKTsKIAkJCWRpc2FibGVfcmVsb2NhdGlv
biA9IDE7CiAJCX0gZWxzZSBpZiAoZGVzaXJlZF9hZGRyKSB7CisJCQkvKiBQYWQgdGhlIEZEVCBi
eSBhIHNwZWNpZmllZCBhbW91bnQgKi8KKwkJCW9mX2xlbiArPSBDT05GSUdfU1lTX0ZEVF9QQUQ7
CiAJCQlhZGRyID0gbG1iX2FsbG9jX2Jhc2UobG1iLCBvZl9sZW4sIDB4MTAwMCwKIAkJCQkJICAg
ICAgZGVzaXJlZF9hZGRyKTsKIAkJCW9mX3N0YXJ0ID0gbWFwX3N5c21lbShhZGRyLCBvZl9sZW4p
OwpAQCAtMjAxLDYgKzIwMiw4IEBAIGludCBib290X3JlbG9jYXRlX2ZkdChzdHJ1Y3QgbG1iICps
bWIsIGNoYXIgKipvZl9mbGF0X3RyZWUsIHVsb25nICpvZl9zaXplKQogCQkJCWdvdG8gZXJyb3I7
CiAJCQl9CiAJCX0gZWxzZSB7CisJCQkvKiBQYWQgdGhlIEZEVCBieSBhIHNwZWNpZmllZCBhbW91
bnQgKi8KKwkJCW9mX2xlbiArPSBDT05GSUdfU1lTX0ZEVF9QQUQ7CiAJCQlhZGRyID0gbG1iX2Fs
bG9jKGxtYiwgb2ZfbGVuLCAweDEwMDApOwogCQkJb2Zfc3RhcnQgPSBtYXBfc3lzbWVtKGFkZHIs
IG9mX2xlbik7CiAJCX0KQEAgLTIwOSw2ICsyMTIsOSBAQCBpbnQgYm9vdF9yZWxvY2F0ZV9mZHQo
c3RydWN0IGxtYiAqbG1iLCBjaGFyICoqb2ZfZmxhdF90cmVlLCB1bG9uZyAqb2Zfc2l6ZSkKIAkJ
bG93ID0gZW52X2dldF9ib290bV9sb3coKTsKIAkJb2Zfc3RhcnQgPSBOVUxMOwogCisJCS8qIFBh
ZCB0aGUgRkRUIGJ5IGEgc3BlY2lmaWVkIGFtb3VudCAqLworCQlvZl9sZW4gKz0gQ09ORklHX1NZ
U19GRFRfUEFEOworCiAJCWZvciAoYmFuayA9IDA7IGJhbmsgPCBDT05GSUdfTlJfRFJBTV9CQU5L
UzsgYmFuaysrKSB7CiAJCQlzdGFydCA9IGdkLT5iZC0+YmlfZHJhbVtiYW5rXS5zdGFydDsKIAkJ
CXNpemUgPSBnZC0+YmQtPmJpX2RyYW1bYmFua10uc2l6ZTsKZGlmZiAtLWdpdCBhL2NvbW1vbi9i
b2FyZF9mLmMgYi9jb21tb24vYm9hcmRfZi5jCmluZGV4IDQ0MmI4MzQ5ZDAuLmFhYjc0ZmI0NGQg
MTAwNjQ0Ci0tLSBhL2NvbW1vbi9ib2FyZF9mLmMKKysrIGIvY29tbW9uL2JvYXJkX2YuYwpAQCAt
NTcyLDcgKzU3MiwxMiBAQCBzdGF0aWMgaW50IHJlc2VydmVfZmR0KHZvaWQpCiAJCSAqIHNlY3Rp
b24sIHRoZW4gaXQgd2lsbCBiZSByZWxvY2F0ZWQgd2l0aCBvdGhlciBkYXRhLgogCQkgKi8KIAkJ
aWYgKGdkLT5mZHRfYmxvYikgewotCQkJZ2QtPmZkdF9zaXplID0gQUxJR04oZmR0X3RvdGFsc2l6
ZShnZC0+ZmR0X2Jsb2IpLCAzMik7CisJCQkvKgorCQkJICogUmVzZXJ2ZSB0aGUgRkRUIHdpdGgg
cGFkZGVkIGJ5dGVzIHRvIG9mIGJyZWF0aGluZyByb29tIGluIGNhc2UKKwkJCSAqIHRoZSBkZXZp
Y2UgdHJlZSBuZWVkcyB0byBiZSBleHBhbmRlZCBsYXRlci4KKwkJCSAqIFVwZGF0ZSB0aGUgc2l6
ZSBpbiBmZHQgaGVhZGVyIGR1cmluZyByZWxvY2F0ZS4KKwkJCSAqLworCQkJZ2QtPmZkdF9zaXpl
ID0gQUxJR04oKGZkdF90b3RhbHNpemUoZ2QtPmZkdF9ibG9iKSArIENPTkZJR19TWVNfRkRUX1BB
RCksIDMyKTsKIAogCQkJZ2QtPnN0YXJ0X2FkZHJfc3AgPSByZXNlcnZlX3N0YWNrX2FsaWduZWQo
Z2QtPmZkdF9zaXplKTsKIAkJCWdkLT5uZXdfZmR0ID0gbWFwX3N5c21lbShnZC0+c3RhcnRfYWRk
cl9zcCwgZ2QtPmZkdF9zaXplKTsKQEAgLTY2OSw2ICs2NzQsMTEgQEAgc3RhdGljIGludCByZWxv
Y19mZHQodm9pZCkKIAkJCW1lbWNweShnZC0+bmV3X2ZkdCwgZ2QtPmZkdF9ibG9iLAogCQkJICAg
ICAgIGZkdF90b3RhbHNpemUoZ2QtPmZkdF9ibG9iKSk7CiAJCQlnZC0+ZmR0X2Jsb2IgPSBnZC0+
bmV3X2ZkdDsKKwkJCS8qCisJCQkgKiBTaXplIG1heWJlIHVwZGF0ZWQgd2l0aCBwYWRkZWQgYnl0
ZXMgaW4gbmV3IGZkdCByZXNlcnZhdGlvbgorCQkJICogU28gdXBkYXRlIHRoZSBGRFQgc2l6ZSBh
bHNvLgorCQkJICovCisJCQlmZHRfc2V0X3RvdGFsc2l6ZShnZC0+ZmR0X2Jsb2IsIGdkLT5mZHRf
c2l6ZSk7CiAJCX0KIAl9CiAKLS0gCjIuMzQuMQoK
--0000000000002486cf0610ee35c5--
