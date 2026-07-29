Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45F0C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69D8B60838;
	Wed, 29 Jul 2026 21:52:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9OdAyJCSUJu2; Wed, 29 Jul 2026 21:52:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E7FE607DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361939;
	bh=EfiF5QOb6H9lXOo8XrvwkF/5zBby2swHfEXJKKo8MOY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mQ7MsuYvFm4xGV08pDya0A9gIC72tJQABo+toWX6WuhPt5tboxZwn3llQC+a6MKtg
	 78N9MH8I4htLmvsXYPbv2e+Ol3NXz8ay3i6E6pEAB2b7IniV40/0CejQCb381KlQq7
	 8uG6Ev94k87Z/+4s4UyJU20LDb2WLAw+KwhZMsuddtZSLgb52Alr5OflDt4iGWOZXy
	 x5Mvb1ojbi1FtEtGftT2OQ31ZOIJtvElLxWcVyNS2L0RU0j2SXY9ztprqqLCqnwXOC
	 wPgdNRDTAS+DCva3AY9lWEPAWPepo2saPcSXekYWS+/Db0JCPk11tiG45/JthGoZ5w
	 SXPc8Cby4wVaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E7FE607DE;
	Wed, 29 Jul 2026 21:52:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D6F9C197
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB6EE606EF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PS38TLAQSARv for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 18:25:37 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8C6D1606E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C6D1606E9
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C6D1606E9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:36 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c1f758014b8so114217066b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785349534; x=1785954334;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EfiF5QOb6H9lXOo8XrvwkF/5zBby2swHfEXJKKo8MOY=;
 b=BKZyHv1pV6AyAr52tG5qLRc1TK+XXTxBW9BgMoUH/0rC+wiCQCcoc+WdXS6/LJXNjd
 5C6g0gRx1N3Be7+6JTwzR2gIfurXtVgCggI3TT9JKCmKeVbiZXYgVPXSAKMQREHY4sd4
 NIlWRS61AzohL0XiKFspjdv3zuzxwoqOdMxE6ZZbQIbEWKxAznOaBuFC9Vz1PAQUEF3R
 DLe7K74AbuDKFKe9gCmRVtw0h7E0Wh1UmH1Bp2hp0HV1m2gGPde7EMRP4cG0KHuki0Z1
 Ukgxx5muUz+YnCz1xL+Jm/+22hntCuFCIePdX6RL6L+1PIRTesdfWGWz2S8Wgh59Z2pV
 E2CQ==
X-Gm-Message-State: AOJu0YyW6y+XXFw+dCphB3kxuMH1+42maipyDIdmzzNcczHOhTtGj5Kq
 qlkBPwybNqrDA9Lsmse5JSlfw/wk13lBSh/xCx2emmjhll3UyqwVhgRFixRBGHPwOqg=
X-Gm-Gg: AR+sD13A3otc12wi/eftrlJ8ILBWmxYluJjla33VCbqvSFy5lng1iBRILBi+33XNhyX
 Vyv3jAj7pYa3nRBUCP5/O02RgS2XNqHTJOi/SBdcNKC1s07Ws9wfHWKmcR5IaA398G/MKWg+ucY
 JJtO7OcYfN0uC+dAOyMfNUrji4QanS6Hv+lC7S3VaMz569NGmC4ecoIIl7s/hd7zIxllh/ytyQ5
 aLhpFjDEHXbaHafj5CwXmsAFcx9Nu6WTtv8lRGt32Iv8NEV/FgL3orJnqV+T4WMBNqhvd0UNQ8q
 IVxsINT3k7ijJuaR8H5mWTMM+jTUDCHH38UZ2zNGHN3k8mX3zl5cL/yTZ3H7+sM3WzrhqK9jAFH
 PucA9GCAxIFjfd1HbN/t0we5Y5+ctrIpBgg85bYMOrghGyyo72HhROTGFXW1uueibJpkBiad4yo
 GY4X6RFgzkSLrMOPbfyTpfcu87DPbkk4U+n6iEo3dL7ffHSJjf+IUFr627HRPNx+/1cZGDL2B69
 fWdN37H0wj33Abf3pmf9c/pBy6aRv7xybBzpX7LNjVggKlEGTz1iA==
X-Received: by 2002:a17:907:e008:10b0:c16:739e:e836 with SMTP id
 a640c23a62f3a-c1f72148021mr302654666b.35.1785349534514; 
 Wed, 29 Jul 2026 11:25:34 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f0047bee160d2cc76b5.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:47be:e160:d2cc:76b5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f83f4dd91sm145977866b.39.2026.07.29.11.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 11:25:34 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v4 0/2] tpm: bounds-check device-reported response lengths
Date: Wed, 29 Jul 2026 20:25:21 +0200
Message-Id: <20260729-tpm-trunc-resp-v4-0-5dd1a634ea4d@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJFFamoC/3XN0Q6CIBgF4FdxXIdDQNSueo/WBdBPUksdoMs53
 z20G5d1ebZzvjMhD86CR8dkQg4G623bxMAPCdK1bG6A7TVmRAkVpKAMh+6Jg+sbjR34DgvBJVN
 SmUwbFEedA2NfK3i+fLLv1R10WJSlUVsfWjeuj0O29P7iQ4YJLqjMudSMGG5Oagzg5JjqNu0fa
 DkY6JbgO4JGgpVZmRdQ5ZURvwi2JcodwSJRAiVKGyW4zr+JeZ7fqL23XkgBAAA=
X-Change-ID: 20260723-tpm-trunc-resp-664a3babf1cf
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Jul 2026 21:52:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785349534; x=1785954334;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EfiF5QOb6H9lXOo8XrvwkF/5zBby2swHfEXJKKo8MOY=;
 b=UFxs8dwOxiqRHDboDf80mOVALTr1NH+9nrsTDZ9O7k8BuaQiILN35+bkTcQf9ml4Dv
 5M7h6cTyjetNmgSvjfiQavErD0wHPywU/+zg1I77VBJEzB9ZD5m7INPensstFf7xUgzJ
 +tqeGrGh3nZ+P4Vhk4bjMasA5dYfRWjosaw8Xzw+YidArkv+XsYj9kHRMjxf9dVX7M4O
 bhawI6U0Sd3rcNxxXvSUcw0Y9SL0IkjRf8lBiSZG7VskXkhaADS6Hog3g/RIBX9uddro
 pdJd8rrgHIgMR2dZ/BpUwpaphpq5gNvvps7tZ5KVIDOuKzIK5BhvH7hM0c/s41tJdbDH
 2xtw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=UFxs8dwO
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

A TPM reply's length is taken from the device and only upper-capped, then
several callers use it unchecked: the TPM1 OIAP helpers and the TPM2
GetCapability parser subtract a fixed header length from it, so a reply too
short underflows the subtraction into a huge memcpy; the GetCapability
parser then copies that many bytes into the caller's buffer, so a reply
longer than the buffer overruns it. Because a TPM sits on a physically
accessible bus, a cheap bus interposer (the kind used to sniff
disk-encryption keys) can inject such a reply, and on the TPM2 path this
parsing runs during measured boot, which is exactly the physical attacker
that measured boot is meant to resist.

Patch 1 checks the reported length once in tpm_sendrecv_command(), so every
command that reads a reply rejects a too-short response, and passes the
caller's buffer size to tpm2_get_capability() so its copy cannot overrun for
any capability. Patch 2 adds regression tests driving the GetCapability
parser and the TPM1 OIAP helpers with truncated and over-long replies
through the sandbox emulator.

Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Changes in v4:
- tpm2_get_capability(): bound the copy by the caller's buffer size, passed
  in as a new buf_size argument, instead of a prop_count-derived guess; this
  covers every capability, not just the properties query. Document @buf_size
  and @prop_count. (Simon Glass)
- Add regression tests for the TPM1 OIAP tpm1_load_key2_oiap() and
  tpm1_get_pub_key_oiap() length checks; enable CONFIG_TPM_AUTH_SESSIONS in
  the sandbox config so they build. (Simon Glass)

Changes in v3:
- Rework per review: check the response length once in
  tpm_sendrecv_command() instead of at each call site, so every command
  that reads a reply is guarded. Drop the per-site lower-bound checks; keep
  the GetCapability buffer bound.
- Drop Miquel's Acked-by, as the fix changed substantially.

Changes in v2:
- Use my real name in the From and Signed-off-by (Miquel Raynal)

---
Shahriyar Jalayeri (2):
      tpm: bounds-check the device-reported response length
      test: tpm: check malformed capability and OIAP responses are rejected

 cmd/tpm-v2.c                   |  4 +-
 configs/sandbox_defconfig      |  1 +
 drivers/tpm/tpm2_tis_sandbox.c | 28 ++++++++++++++
 drivers/tpm/tpm_tis_sandbox.c  |  9 +++++
 include/tpm-v2.h               | 15 ++++++-
 lib/efi_loader/efi_tcg2.c      |  9 +++--
 lib/tpm-common.c               | 16 ++++++--
 lib/tpm-utils.h                |  8 +++-
 lib/tpm-v1.c                   | 59 ++++++++++++++++------------
 lib/tpm-v2.c                   | 60 ++++++++++++++++------------
 lib/tpm_api.c                  |  4 +-
 test/dm/tpm.c                  | 88 ++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 242 insertions(+), 59 deletions(-)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260723-tpm-trunc-resp-664a3babf1cf

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

