Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278FDC531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEDFC60A59;
	Thu, 23 Jul 2026 15:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zq6c9B81SsF8; Thu, 23 Jul 2026 15:14:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9CF060A95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819654;
	bh=8oOAFMNsz4F4aRBNB/mFTK+Lc+EEKae23uUnmXYuRDw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dfzIItMbb+vL7jZCVuiNleLAq7614YqtVj7A/E5e5EYC1OMIl/+a3+iGPNJ6MZMzF
	 1HpqvrsWCKFeBl5ByQATqml/dt1hjRKythZwpbJAJDThFQR4N/Z0AhLBpTY/ltyK6C
	 REijXN1lnSXk/rO+6MVq1o9Iw5d5Gqe/mdkZ/9ZKRDJwKOnqy7ocMwrt7skReHZ12g
	 pJGV7Yu9QoJp/wN9I8VRPFDaIjR6SDz9q4ffy/4MrodiprqslMp7ixI40SzFAkMgL3
	 ZLgNTok1Jfy7Cvkpt5b6/ACjYBYWRbnoGiizNDonJM58Kbpp21VkiISzx7TiCcndUA
	 P13tUWXZqISWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9CF060A95;
	Thu, 23 Jul 2026 15:14:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E9B52E5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 709FD407B4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:01:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eV7sEl963VAQ for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:01:44 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 49AC6407A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49AC6407A9
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49AC6407A9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:01:44 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69c1220bd51so1152833a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784815302; x=1785420102;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8oOAFMNsz4F4aRBNB/mFTK+Lc+EEKae23uUnmXYuRDw=;
 b=AOI+SbFfMorkb1ofW/3AyXxGzXfSLVniKUGLv32Pr+pngz3UJbNYFFx71rFdR7r6h7
 FybvEPzwZia2ocjPLzxRtL9VICe7Jy5tvo3BPHZypeLxEJYJ6GMBEZFBXf1QrCsKI7tV
 f24XYjzosTvlVf0wWTVi6Io7J0Z7JxoymKZq3/MV0c7JkMphnLAGyAeWJ9RxUzEae4J1
 zeGhEhYnXso6rpnjAPcLI357i6lmRhXP6VWS7z+K/EoCYz+rWYoE+p5ef3G9bUm+Vf9h
 6/1U4VtJVJJryGxgMtgf/iH8wh7It8g/cQ7i1YuwNRPKoriz988/YUsnGU+tBNnN6FPl
 bYcw==
X-Gm-Message-State: AOJu0YySFjOzI38/N60NjjHxxy8iQfq+dqquanuFVS5D5oLed1KZIUEI
 I0t8d2+TJfGQVqYmZsFxZfPTZ0Dfl7KcyGSM74OdwV2rjpkzg7rT+pDDzUcnGdcHtl8HxMAwVWl
 M7VbobvA=
X-Gm-Gg: AR+sD12e63e2QpoCNHt/qHmzlIDSP3doGzkdwpqQuJUYKLFFkt+kcKXKu9mpVSD50O4
 tqXNHEIt4l+LxHjfD/TR+ZkBpI8E9gGmPBxkKtcaSkqo/Bz74qBXhib0GhZOry5u4oo4+sAyXV9
 UI3TpYegSJt9hZOpKBai6cYllzZaI8ZrZm8b3hfVT3uS/qMOCooQz+HLwO9Kq2MmB9Y80oSNega
 d0reasxeqk+7fpUwggDZyp/n7GiTY1curW9WZrWtq6EZyIuQRwN4ph/aTRqVmQoyO87Lx0D6sox
 O4L630OtAdo/q+7Iko2hegNy3YOIN5kUkvqNxjUkUHCkXH/BTpCrWZ9gYW77mN3IY/5AMf2xpeO
 XuJqubw0XBuBApvqie15DHomhwuvGROo3XyRUgLku5yon22duJHhNNaNq1U74+UOPfUw5wpPCEx
 edcERHgoUARTuj5n7PEuEWtD/XDTR84j0iKvqQm8iUbIhzgvM6AI3w/jiA9mh6NnUdNEh3ACZey
 NbpKA==
X-Received: by 2002:a05:6402:448a:b0:698:3b7b:e492 with SMTP id
 4fb4d7f45d1cf-69f6c6064f0mr1229845a12.40.1784815301951; 
 Thu, 23 Jul 2026 07:01:41 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed0099e3f3dc2d051096.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:99e3:f3dc:2d05:1096])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69f345b1decsm2137178a12.4.2026.07.23.07.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:01:41 -0700 (PDT)
From: shj <shahriyar@byteray.co.uk>
Subject: [PATCH 0/2] tpm: bounds-check device-reported response lengths
Date: Thu, 23 Jul 2026 16:01:27 +0200
Message-Id: <20260723-tpm-trunc-resp-v1-0-72a54ac30f4f@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALceYmoC/yXMQQqDMBBA0avIrB3QWFLoVcRFEic6haZhJpaCe
 PdGu3yL/3dQEiaFR7OD0IeV36mibxsIq0sLIc/VYDpju7sZsOQXFtlSQCHNaO3NDd752IcINcp
 Ckb/XcJz+1s0/KZTzAsfxAzKgYEFyAAAA
X-Change-ID: 20260723-tpm-trunc-resp-664a3babf1cf
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Andy Fleming <afleming@freescale.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Che-Liang Chiou <clchiou@chromium.org>, 
 Dirk Eibach <dirk.eibach@gdsys.cc>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, shj <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784815302; x=1785420102;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8oOAFMNsz4F4aRBNB/mFTK+Lc+EEKae23uUnmXYuRDw=;
 b=MU09s+lYyMWcNN/KdXIHnQlrbRHJrNkVI9qJdnt+jV9eypwKowQ67TvymTfV7IhW6e
 t5+d3Zz9mm/l9uNvistwBw/3FBB9xpV2ORCvCtedg2aFaprV9hj5q4FfvHdCGRJatyZP
 vPMAaeHyBp+d5fcgQCwKezkopJo5Tn//yfhRAmnOtJVGq754S6+hJxnXosdoTK/LFKOx
 ef3Tktu0juJ6oSkL4ayREz9zaD64lQBsPdc17MYMFtc26uw8vC339KhwsfkiXLU8GLCH
 OOEdi2WIBYnPtiqA47ztp2LHtjisbE8QY1IL549OY/nnCFqBKrkd5RrQvtDwUeq9D9+B
 brgw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=MU09s+lY
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

Patch 1 bounds the reported length against the header and, for a properties
query, the caller's buffer. Patch 2 adds regression tests driving the TPM2
parser with a truncated and an over-long reply through the sandbox emulator.

Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.

Signed-off-by: shj <shahriyar@byteray.co.uk>
---
shj (2):
      tpm: bounds-check the device-controlled response length
      test: tpm: check malformed capability responses are rejected

 drivers/tpm/tpm2_tis_sandbox.c | 27 +++++++++++++++++++++++++++
 include/tpm-v2.h               | 10 ++++++++++
 lib/tpm-v1.c                   |  6 ++++++
 lib/tpm-v2.c                   |  8 ++++++++
 test/dm/tpm.c                  | 41 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260723-tpm-trunc-resp-664a3babf1cf

Best regards,
--  
shj <shahriyar@byteray.co.uk>

