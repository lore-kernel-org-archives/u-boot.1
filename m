Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47678EE57D7
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 22:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C67188B6A;
	Thu, 12 Sep 2024 00:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ELvs6xiu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2527D892F2; Wed, 11 Sep 2024 19:39:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EACA892E5
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 19:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726076394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cMao8FqkBxTFSg60mgSwIu6DzkfqktabapyMwR+IR+c=;
 b=ELvs6xiutaBZ7pB9twPz7cxwjmTiSnHhH9ex33GD9DRAp5TcElJjY3MMAs1DqsQ5sqd1/A
 njaULB28YKRnfqx/BPWY67/cpVbFMYd2Rwut+C+miaiSNHnFDulxJXzS9ZNh2B+7Pug1Dj
 hBaPwUFhuSTudwwPl46OfToBLeDNeKw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-ZWQ1ikhYNdKNh5wcxkdmCg-1; Wed, 11 Sep 2024 13:39:53 -0400
X-MC-Unique: ZWQ1ikhYNdKNh5wcxkdmCg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4584bf37e23so199831cf.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 10:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726076393; x=1726681193;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cMao8FqkBxTFSg60mgSwIu6DzkfqktabapyMwR+IR+c=;
 b=q5sTK98ryud7fkBiXZvgSFlAzBhEXFV8YYxya8vu0aCq2bqzo7MKq+VJtoHxPkwemn
 boS+WugZlS+6u+1POi5Ov2FZsbnP+L+P1ncgweqKC3sXNuib+vlnBrNQom57B/Oo8tgf
 7ocN7GgFz2w9WfVlFzUOlkMAHKGL6QopT4KugJha/Y/ljOCZWfyjRkvtijeHsVh4KmDM
 7zg1NI4gu+adQnVNapi/dJIN9GD6+x57V+Kq1AeFxrUrgab7OEx92DFLZIYWZJK+nmZJ
 sCc7/kafDHJh+0YGlRyf1NNDz+SGq5VVGBxbSne5YE/QGQrwOEcwb8HHDbLYOleBfcHY
 dYKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2OvFNowBxOGcfzsw7MMEg4KGJl14uKODp0UHUPceft0aArWPUfDX+zhr92dt3iNRpL2cyJiQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwU1RuaqlkM0+9mGPgXmwIc7F0ejo99xnCSaq42pIynWw/KtlI3
 233B2keIg902n2jKZWNbLAVMSUvyiifpLxOe6Soq3xm0Nt5HX3UOgogjbEP4+jNEsckF/BzgDQY
 BM37oO+Dclk0yVDHzcD2NhsuKVa6VG0vaRDuVduby++5bnxLvDhs=
X-Received: by 2002:ac8:570d:0:b0:458:367b:aec7 with SMTP id
 d75a77b69052e-458603ee8bemr1446691cf.37.1726076392721; 
 Wed, 11 Sep 2024 10:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbjjG8LP0IfcRMc4Ct5EnTGMXcphJnxpfuSLBVIVjUgNTzCwOzkhJhFOz6hS09cN27X70gPQ==
X-Received: by 2002:ac8:570d:0:b0:458:367b:aec7 with SMTP id
 d75a77b69052e-458603ee8bemr1446401cf.37.1726076392272; 
 Wed, 11 Sep 2024 10:39:52 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::33])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822eb0027sm43663781cf.53.2024.09.11.10.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 10:39:51 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH RFC/RFT v2 0/4] k3-j784s4-r5-evm: Enable ESMs and related PMIC
Date: Wed, 11 Sep 2024 12:39:46 -0500
Message-Id: <20240911-j784s4-esm-enable-v2-0-957f56b588d9@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOLV4WYC/32NQQ6CMBBFr0Jm7WjBkYIrExMOQNwZFqUMUiNgW
 tJoCHe36QFcvrz891dwbA07OCcrWPbGmXkKkO0S0IOaHoymCwyZyEiUIsenLMgRshuRJ9W+GEl
 Tn5dFz1IThN3bcm8+sXmHuroe6uoGTRCDcctsv/HLp1H/yfoUBbbFsU1ld1KS6GK5G9Sy1/MIz
 bZtPyx5p1q8AAAA
To: Apurva Nandan <a-nandan@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
 Udit Kumar <u-kumar1@ti.com>, j-humphreys@ti.com, 
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 00:03:14 +0200
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

NOTE: this relies on the linked devicetree changes to land in Linux
first and get synced here, otherwise the board will fail to boot!
I'm leaving this as a RFC/RFT at this time for that reason until
things get merged and synced over (if there's a faster way to get that
done please let me know, otherwise I'll be patient. Maybe the
cherry-picking described over at
https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
would be appropriate to do *in* this series after that is merged in
Linux?).

This enables the ESMs and the associated PMIC. Programming these bits is
a requirement to make the watchdog actually reset the board.

I've tested this series (with the linked change) on the k3-j784s4-evm,
but not its sibling the k3-am69-sk. I'd appreciate at a minimum someone
to test on that platform to ensure this doesn't break boot.

Link: https://lore.kernel.org/lkml/20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com/
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Changes in v2:
- Loop over ESMs, only configure if prior was successful
  as without all of them they're not useful (Udit)
- Add am69-sk PMIC ESM node (Udit)
- Link to v1: https://lore.kernel.org/r/20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com

---
Andrew Halaney (2):
      arm: dts: k3-am69-r5-evm: Add the PMIC ESM node
      configs: j784s4_evm_r5: Enable ESM related configs

Keerthy (1):
      board: ti: j784s4: Initialize the ESM & PMIC ESM

Neha Malcom Francis (1):
      arm: dts: k3-j784s4-r5-evm: Add the PMIC ESM node

 arch/arm/dts/k3-am69-r5-sk.dts    |  7 +++++++
 arch/arm/dts/k3-j784s4-r5-evm.dts |  7 +++++++
 board/ti/j784s4/evm.c             | 24 ++++++++++++++++++++++++
 configs/j784s4_evm_r5_defconfig   |  7 +++++++
 4 files changed, 45 insertions(+)
---
base-commit: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
change-id: 20240906-j784s4-esm-enable-4c4f698fe7c4

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>

