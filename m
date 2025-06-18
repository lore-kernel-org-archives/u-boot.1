Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11C4C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 13:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24C9880E9A;
	Wed, 18 Jun 2025 15:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kox2KW01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B14482B18; Wed, 18 Jun 2025 08:39:16 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED71782B0F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 08:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=00601wayne@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so5472821f8f.3
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750228753; x=1750833553; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+v8qxzri6lvmk8SB2scOc9QVXfVqNtxZ4Va2oq/eBy0=;
 b=kox2KW019O7wYSRHqDGqMIWGJlG1/4ngvLEVE0FuQoemT1Juu1UJHMm0KgbhvjkUH9
 WYPN+hNkgXPY+4HpUIlyQ42n47gIxCg7lGhMORCShwwZEDQ2F4nyOoTZOm/PUDDZG6XG
 E2c666XMB9EZXZ9LjNV98JFP//nD4JUrDoXLnEgaQ3WJxtUiv2nyccyHeptT7UgsZ8bS
 am5yRiZqtD5ysIUtRoVZvziJABngKmLFsmJKvVtwWK4ZTivAyaz/iNTngB96RNFGtaCA
 S7YvPMYMelqHga11DoIynBOkNKj/PsnVPvRVZmzJTIdGPaPAFljojldC/85vzMw/ldtw
 SHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750228753; x=1750833553;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+v8qxzri6lvmk8SB2scOc9QVXfVqNtxZ4Va2oq/eBy0=;
 b=Hs2lJvjAcomo15xI3E15BuZrdus97NnT3oMQ2HoHQXaTprJcvP4WMOagTLMOY16ZEY
 X7u4bCAu7uX/NbtpV9nPC0ML6chb3VIscSri1SRSvw47DPX1J4LQsWHM62GfW0vkAYq6
 bIGEWKEDh0cTeOOE+gZ3sw7aLdhR2Udcddh0TK9YtBUIMRVdY7fz2H+Jdb04KuNNfb4V
 mYHHfACKhFwEVzyM768qgcX7xvWtEErqR6LMGcfjMUtQxN6XjStJIzQIKejBIWLCipNl
 Z5ckUd6V1T+HdiX9gUvlfG+nV7TyEzvQEgoAHp1Qjypl8E1RVAmR5pyooQPWqZoZBkt+
 M4TA==
X-Gm-Message-State: AOJu0YwnwSvYCegDnJOMTbRnLRzr0ZsA7nb7NcmicNHffpcKAM0QrtJF
 Zqc4Vgvti/4DKyxnFmYPahIOhMBzFbBIZJQM/7DL7/C7sWRUKKxF+sSwmJeVGWz539RwYStgOo8
 EdPNt3GEgIRFZRiaNZIm7x0G/ewnBVdFuoNHF
X-Gm-Gg: ASbGncviterj6XlQstkbaKV1ynqMYVO8F0Ck0xYxDgXojq1JKPM2YhmWcItjc8UadKW
 rqHcRDhaQtNzOPAM+LW1ia29k1QA3rrXFRYsDX5jSrB7xDxkd+J+gr7G0kGkYhS52Ow1TXNSovC
 SnTFpf/AD8y18W6AuN6cydiRb9qTzytIqND5VpJLSqqjouyXpsm/f0i8GoHUdoC0UomdKfGxLvh
 rMi
X-Google-Smtp-Source: AGHT+IHvzB7AXF1CY+qujW2qCIOmQWmogbYC2lqtT1emIyLJXvA/58psOwJLIaq9fTWWOhAlggugVb1d7LsOzgAF490=
X-Received: by 2002:a5d:5f4e:0:b0:3a4:f893:3f03 with SMTP id
 ffacd0b85a97d-3a572e79692mr11677911f8f.45.1750228752968; Tue, 17 Jun 2025
 23:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAOZ77-G2V5Dq0rC-X9_6qHBA6Q30TjTPU-pKqDBgpp4b55GKog@mail.gmail.com>
In-Reply-To: <CAOZ77-G2V5Dq0rC-X9_6qHBA6Q30TjTPU-pKqDBgpp4b55GKog@mail.gmail.com>
From: Osaka Osaka <00601wayne@gmail.com>
Date: Wed, 18 Jun 2025 14:38:36 +0800
X-Gm-Features: Ac12FXxGYmt0bDP0-WOLKd6OT7oZRhD21GukzItZ0SzPzMHevf0JpG17bG6OX3s
Message-ID: <CAOZ77-HkGL4dp2tYLNv32UPdhh3odNkv10v6vrpSYx+K3PBEuA@mail.gmail.com>
Subject: Fwd: [BUG] bootm.c: Incorrect use of ft_len as end address in
 check_overlap()
To: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="00000000000018e44f0637d2e3af"
X-Mailman-Approved-At: Wed, 18 Jun 2025 15:50:29 +0200
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

--00000000000018e44f0637d2e3af
Content-Type: text/plain; charset="UTF-8"

Hi U-Boot maintainers,

I would like to report a potential issue in bootm.c regarding FDT/OS image
overlap checking.

In current mainline code:

https://github.com/u-boot/u-boot/blob/master/boot/bootm.c#L448

We have the following logic:

    if (check_overlap("FDT", map_to_sysmem(images->ft_addr),
                      images->ft_len, start, size))
        return 1;

However, `check_overlap()` expects the second and third parameters to be a
memory **range**: [start, end). Here, `images->ft_len` is being passed
directly as the `end` address, but in reality it is the **length**, not the
end.

This is misleading and could potentially cause overlap checks to pass
incorrectly, especially if `map_to_sysmem(images->ft_addr)` is non-zero.

To fix it, we should properly compute the end address:

```c
ulong fdt_start = map_to_sysmem(images->ft_addr);
ulong fdt_end = fdt_start + images->ft_len;

if (check_overlap("FDT", fdt_start, fdt_end, start, start + size))
    return 1;


if (check_overlap("FDT",
        map_to_sysmem(images->ft_addr),
        map_to_sysmem(images->ft_addr) + images->ft_len,
        start, start + size))
    return 1;



Let me know if I should send a proper patch for this.


-- 
*Best Regards*

*Wayne Lin*


-- 
*Best Regards*

*Wayne Lin*

--00000000000018e44f0637d2e3af
Content-Type: application/x-patch; 
	name="0001-bootm-fix-fdt-overlap-check.patch"
Content-Disposition: attachment; 
	filename="0001-bootm-fix-fdt-overlap-check.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mc1kxxfw0>
X-Attachment-Id: f_mc1kxxfw0

RnJvbSBhYmNkZWYxMjM0NTY3ODkwYWJjZGVmMTIzNDU2Nzg5MGFiY2RlZjEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogV2F5bmUgTGluIDwwMDYwMXdheW5lQGdtYWlsLmNvbT4NCkRh
dGU6IDIwMjUtMDYtMTgNClN1YmplY3Q6IFtQQVRDSF0gYm9vdG06IGZpeCBpbmNvcnJlY3QgdXNl
IG9mIGZ0X2xlbiBhcyBlbmQgYWRkcmVzcyBpbiBjaGVja19vdmVybGFwKCkNCg0KVGhlIGN1cnJl
bnQgRkRUIG92ZXJsYXAgY2hlY2sgaW4gYm9vdG0uYyBwYXNzZXMgYGltYWdlcy0+ZnRfbGVuYCBh
cyB0aGUNCmVuZCBhZGRyZXNzIHRvIGBjaGVja19vdmVybGFwKClgLCBidXQgYGZ0X2xlbmAgaXMg
dGhlIHNpemUgb2YgdGhlIEZEVCwNCm5vdCB0aGUgYWJzb2x1dGUgZW5kIGFkZHJlc3MuDQoNClRo
aXMgY2F1c2VzIGBjaGVja19vdmVybGFwKClgIHRvIG1pc2ludGVycHJldCB0aGUgcmFuZ2UgaWYN
CmBtYXBfdG9fc3lzbWVtKGltYWdlcy0+ZnRfYWRkcilgIGlzIG5vbi16ZXJvLCB3aGljaCBpdCB1
c3VhbGx5IGlzLg0KDQpUaGlzIHBhdGNoIGNvbXB1dGVzIHRoZSBjb3JyZWN0IGVuZCBhZGRyZXNz
IGJlZm9yZSBjYWxsaW5nDQpgY2hlY2tfb3ZlcmxhcCgpYC4NCg0KU2lnbmVkLW9mZi1ieTogV2F5
bmUgTGluIDwwMDYwMXdheW5lQGdtYWlsLmNvbT4NCi0tLQ0KIGJvb3QvYm9vdG0uYyB8IDYgKysr
Ky0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2Jvb3QvYm9vdG0uYyBiL2Jvb3QvYm9vdG0uYw0KaW5kZXggYjhmYTg1YjY4
Yy4uZjIzNDU2Nzg5YSAxMDA2NDQNCi0tLSBhL2Jvb3QvYm9vdG0uYw0KKysrIGIvYm9vdC9ib290
bS5jDQpAQCAtNDQ1LDggKzQ0NSwxMCBAQCBpbnQgYm9vdG1fZmluZF9pbWFnZXMoaW50IGZsYWcs
IGludCBhcmdjLCBjaGFyICogY29uc3QgYXJndltdKQ0KIA0KIAkvKiBjaGVjayBpZiBGRFQgb3Zl
cmxhcHMgT1MgaW1hZ2UgKi8NCi0JaWYgKGNoZWNrX292ZXJsYXAoIkZEVCIsIG1hcF90b19zeXNt
ZW0oaW1hZ2VzLT5mdF9hZGRyKSwNCi0JCQkgIGltYWdlcy0+ZnRfbGVuLCBzdGFydCwgc2l6ZSkp
DQorCXVsb25nIGZkdF9zdGFydCA9IG1hcF90b19zeXNtZW0oaW1hZ2VzLT5mdF9hZGRyKTsNCisJ
dWxvbmcgZmR0X2VuZCA9IGZkdF9zdGFydCArIGltYWdlcy0+ZnRfbGVuOw0KKwlpZiAoY2hlY2tf
b3ZlcmxhcCgiRkRUIiwgZmR0X3N0YXJ0LCBmZHRfZW5kLA0KKwkJCSAgc3RhcnQsIHN0YXJ0ICsg
c2l6ZSkpDQogCQlyZXR1cm4gMTsNCiANCiAJcmV0dXJuIDA7DQotLSANCjIuMzQuMQ0K
--00000000000018e44f0637d2e3af--
