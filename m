Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E449C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 16:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3748860685;
	Thu, 13 Aug 2026 16:00:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEERqWVr2bGP; Thu, 13 Aug 2026 16:00:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EC33606A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636849;
	bh=RC3N394t2asFz137oCxr5iT9MP8LFsrxzuIuyy7K06M=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k4ysjAmjbVfXTEVh2V67umdJa4AOTbsolSBVT2oYWhjzl7NzOMBkkHoqhIwX9l/8s
	 XPFhQpUUKAIB7w5t+kjZeRwx2fWCJt1nO7RKQ4863Vasppluf8k4GAwrPA9S3UuDgy
	 Ep+hBQtGUjb3+sizcb4WPFnE4IGo4dvwM7VQ2pBcuphCR7egK6ozPwcKHhbx4z2DZc
	 sYgt9ZZ8Z95C72ikU3gzJiqBKRZDOxP/mJl0JeiCqObS1dZv1l9ATl05oV1jbS6oRO
	 C7fYlzQOb106uEBKTldeIqv/L69jfkDuM1wOqwQnozvUBggtXxaxnRHQ8cXWLPerWC
	 GjOu935Qv2BhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EC33606A3;
	Thu, 13 Aug 2026 16:00:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3740F23F
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1DC74812A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:58:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q3OvL5PYGzRs for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:58:54 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DD72A81285
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD72A81285
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD72A81285
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:58:53 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c15d111ca99so13674566b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636732; x=1787241532;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RC3N394t2asFz137oCxr5iT9MP8LFsrxzuIuyy7K06M=;
 b=DbPFBhiDqXcyzWIkTR9ljnYBLVVMFUBjatYm/h/0QT45ddc9nqtrtx4v6mevaPE79j
 IpQrAzlheDLf3wh5mnGTMGFi4nay+DgDPCM6/0R1fluoqTN2qu+/x+x9u1JWA8Ch2cG6
 QvKTk8OWQoJMvCv+WCRdzh2QWzO0N2iEupQbgHFf2HF7rBsoSMY2G4yPnkfr5ynZEHmi
 jH1QQHY/GEvsvfeufLeqqDgLoTKf2MGda4/q7iE8AL9esPWgzkqMv1zUpqYk90wBVIj5
 lLWgs5palY9gu/Nvhxigx2yguMak2T/NZj3iHTDYQK2V9uGVtfWOTElpOBcMBkdb7lM1
 ksZQ==
X-Gm-Message-State: AOJu0YySkPdpN5S3Flxdv43uEiOiMKpBxL7usXVXNvHLTqeuh0unETz4
 jGljMMcq00fCZ3bbt41XXIVRDVKLomOZQ1Acia0T5u6fWphxoD7+eiA74Ih+3JQc2+k=
X-Gm-Gg: AR+sD13+sgux46Lajk0XlLlhLfnKipg3f6u+lXqhkmo4558WW9NQkiCl3LAlM3ALqWw
 GXEaNFk1YjxGP/x4AXRSFufFEbVbwVeGzhjz1Pgy8El/DAbHbl1ht1zvHePQ19Va8GZLFpuzb2E
 wtxmX/RrXgmWmrgBnBthVUb95pLaWq8WwPggiY2Zv1W/tq6s3a8azNb3wDERF+qfjlS3zQNBg3M
 pnfeXckZo5kULGEdBstHPXNtEsU28lriUiRfP78PWOmWTn/JCUNlFo7Ktwcp1oODsA+X1uIU7KX
 GJ+S811KWTCSNYiv+y5o4VnlBRmjzWTmoc5FPaHOuav8XHJNqOuS5+DKys9sgv0BN8vEGswhEs0
 VSutpr9AE9IrJBs8ltTIwWEpvxkJEKuPUkY6nSGRykkLsUnRM+06IBIFDW/HyXc97R8tQiTDG5s
 hSZ7ksQdfPiWoZC4lntI4AujmRszIgpuZ0HW+WZCELPlrktV0BY0bTFhZ/tM1onm9VKKTVKedrE
 2nRrvSQt7W+FvihZoRaUoEZg3aTkgB7IoOhq7w8T/2KsQjbVBcX
X-Received: by 2002:a17:907:94cb:b0:c20:5121:89c1 with SMTP id
 a640c23a62f3a-c2108f21e4dmr316397066b.12.1786636731786; 
 Thu, 13 Aug 2026 08:58:51 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00b49b9d175e416b42.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b49b:9d17:5e41:6b42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21233a12e6sm9087366b.12.2026.08.13.08.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:58:51 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v5 0/2] tpm: bounds-check device-reported response lengths
Date: Thu, 13 Aug 2026 17:58:42 +0200
Message-Id: <20260813-tpm-trunc-resp-v5-0-153b492a3256@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALLpfWoC/3XNTW7DIBQE4KtErEvEzwPbXfUeVReAHwmJaluAr
 ViR7x6cbqw6WY40882dJIwBE/k83EnEKaTQdyWojwNxZ9OdkIa2ZCKY0KwSkubhl+Y4do5GTAP
 VGoy0xnruPCmjIaIPtyf4/fOX02gv6PKqrI1zSLmP8/Nx4mvvLT5xymgljALjJPPgv+ycMZr56
 PrjeCXrwSS2BOwIUQhZ81pV2KjG61eE3BL1jpCFqFEw67zV4NQrArZEsyOgEKptudES0ED7n1i
 W5QEExf2biwEAAA==
X-Change-ID: 20260723-tpm-trunc-resp-664a3babf1cf
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 16:00:48 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786636732; x=1787241532;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RC3N394t2asFz137oCxr5iT9MP8LFsrxzuIuyy7K06M=;
 b=jmQtVjDvD2jR4IaMf2S6nXDqoCqlr/zI2QOXWBbglwSoF1tHCChtcuF0hWgVjgyRo3
 dGcQlZmbTZlLwZO48k/Ajo5eJO4BEJuOxNrkhfJo/bU4KbHZGOyjRLC5WrSomjW8ka0q
 yOVyfgg8ruaDwYp+5Eea0EqlRSUQy+5Tu/VfaPRZIJbT6x+8KeKXNMVRsX64tGgLkd7j
 OUgF7ACCDv0vCAX/yu6jU7tEVeu4YmTmCgMS9lDyMJSOEjFyndeM2UduQn/eZD+Jyu7q
 mzKYGnDX7Wz6M1PNvx/x3Ncy1lKcr6L2xOhuZ0Q61s/p27rIXaRebrFx+cEAadWcHiSf
 zqRg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=jmQtVjDv
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
Changes in v5:
- Count the TPM1 LoadKey2 minimum reply length from the header, like the
  other commands, so it is 55 rather than 41. (Ilias Apalodimas)
- Move the TPM2_PT_SANDBOX_* test-hook properties out of the common
  tpm-v2.h into the sandbox TPM header drivers/tpm/sandbox_common.h.
  (Ilias Apalodimas)

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
 drivers/tpm/sandbox_common.h   | 10 +++++
 drivers/tpm/tpm2_tis_sandbox.c | 28 +++++++++++++
 drivers/tpm/tpm_tis_sandbox.c  |  9 +++++
 include/tpm-v2.h               |  5 ++-
 lib/efi_loader/efi_tcg2.c      |  9 +++--
 lib/tpm-common.c               | 16 ++++++--
 lib/tpm-utils.h                |  6 ++-
 lib/tpm-v1.c                   | 62 +++++++++++++++++------------
 lib/tpm-v2.c                   | 60 ++++++++++++++++------------
 lib/tpm_api.c                  |  4 +-
 test/dm/tpm.c                  | 89 ++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 244 insertions(+), 59 deletions(-)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260723-tpm-trunc-resp-664a3babf1cf

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

