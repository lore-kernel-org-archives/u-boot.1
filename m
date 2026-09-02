Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D24C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 21:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B026180D07;
	Wed,  2 Sep 2026 21:58:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DNodR_epGZAR; Wed,  2 Sep 2026 21:58:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD2EC80D09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788386334;
	b=qM1ZkgMEDPp6yTMSw4aZqADGIDdOjPFvSxUcW98C7gxokhy58eHJNFeJQMjN4Czrrsp8
	 /3AKTqFzDD1EZiSOaRNStvjaaZN7w56YVLMWmFlqj9/XbALJjoxY4tnYoza1JyxdIMfLs
	 2qQMloXNkNMh/3PbSS/n0BDYweGL615kDn/pbrDMxrBZKxRqwORF3B9HOJ4+berSjU1HO
	 e/bcDLkxMo/INEIyrSYPDqN94uKfQcoglLdujs69eoqeFyqTJYt1a+Ew8y3lpQcOCCssL
	 F0AXSWBy4MBzQfdygWQMyv5fzINtwryMzFO3wZuYcXOkaG0z3v9l0txgRUsalLoQdmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788386334;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0BW/h44lAnlL52sZ0ROROLHXPEuRuhnb/YC0bjbjoGw=;
	b=VGR0WHMikBdoLF33TSzPNd/gUrUCCYE+zgaQhTYozwR5Ybquji2fPzrMAOhQUVHrEg47
	 CoXoebyMYoK/kRRWGPOjJGJbVDLnPFEh4WtviYLWkv/bwtsCORbB0hYcJBJrrKE/LwHsR
	 K3ESEVIa/zRIoRMyOxOH8Y4d+7zUyT/Rx9Fbfk0C7U7+UfbaIK3WDQO0tmQLV8/sBv769
	 ZzjmYsySvnIxrqFrZ7Eyj+wRarguutjJcRiIFXKDSCgB4jRBq3U2FU1tQluLD0DBV4TWQ
	 sRI8E+flVuAVGx0Z999wZaMLJ1OoCwocrS7PqSb7jsyYSHHYlzg5/h4B+BUxed+zWqw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788386333;
	bh=0BW/h44lAnlL52sZ0ROROLHXPEuRuhnb/YC0bjbjoGw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yZDiHX1+DhaQliWgwwu8NN+C4LPLaVo83hP3wTSwt//UCnBRzqIi++8yKh0zoEEPx
	 5M5D680oPLgf/+u3vQEEqNj4kzYJe7sKm6vISWSEJ1yibHJXjSmdmms5NGNrSRSCPs
	 kzMPOLg/B9dkcPmDNIpFVs1njWGybGLK9zMswUbV86LZ6tDx5pobcY03b8vDgMCOrU
	 kudGd4VQCBYlzpEXWCxueh/+ABaoA1LldgZha8F4y02grnXYk9l2CNc+ISc5Lj138Y
	 w/MlyYR0/bBbdhB9XGwP3+KwiEccr/RQBnszVUtifczKWRsRYidug2OlnbbCYTDrsc
	 glCjuiWjICJ2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD2EC80D09;
	Wed,  2 Sep 2026 21:58:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 88807498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 79F2240A28
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id on8NVJKA_vIe for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 21:23:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4EECA40A3A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::72b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788384230;
 b=rd1vWrEwUeqnTjHuma/hTHe5wtWXOups2tK/LNpqJluBY1rNHJRouHpYSqw5CDWg8fAn
 8j8D3rvHQCNouK2lmfQFce1DoceczM3M7PcFep3oKZP1AuMO0bCqh0TDE/LZD0qluu9sy
 euA/ijlrr8LLp4sV9mV5o+N9LRRLianc6GZpXELCw2E56DzMpxyDyeY91HroM6AizSak7
 t0LltAxzTJm+1vd3z4PyXiOLJFoJdMAGJV14pfyI4fI3sY42t+cLT5Lfz3GORXoqS1r62
 ZsPDduH58t4818/FiKuhBFpdOMbdptG4Cs5U8AEXb+KrKi2F1gK4bJ3pHvjMpIDEv8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788384230;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=0BW/h44lAnlL52sZ0ROROLHXPEuRuhnb/YC0bjbjoGw=;
 b=cY3RqT1JijM4bMjjvQBTlj2ojal4xdxVdUFFcEx/HFS5vW7mw9qcP5w+SMRBGbD0v1WB
 ko+vaE9bWF2+ULqwHUXYpRLGk4KR0kMDWQYY7cqa97r8N/owfqrF9YMzhHz641qt3ZRMa
 6nI65uEd8EjAEVrL95ijUetixX2DYahP/QuigK0EJybDaS8iJY4LQ9aacPgv91/EK2qpO
 9BlISITN1Ewco3y7KkGhV382T4xWh7WYqRZJnCyEkXyXaDVnFjMSy5LibsevjPzsvvJY1
 hqyuLxYp9XsN3i+SH8l5pq5vM72s5d7p53B943migI5cb3fFrqZEXRu7GEFmud0bUTA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=binarly.io; 
 dkim=pass header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=RV1tf0at; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::72b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=RV1tf0at
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EECA40A3A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 21:23:49 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-934956bee57so239335285a.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1788384228; x=1788989028;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0BW/h44lAnlL52sZ0ROROLHXPEuRuhnb/YC0bjbjoGw=;
 b=RV1tf0atG1ppq2Rd4+EmfGvwOwD+nLhkHL5rJF5r9t113N3DQmrpEwUPp+SiEGLZQ4
 ISzjVRytSCFYnnsRODOJdzi0ksrbEDUJKlfa1ihsnZvdEQ7aUVojU3w4WWdsxRH6B4nK
 Ia/epEChx3FlrH6cu5wHlxImutTSFP3wleNEu1s2eMFrTfuJ0faRjlWQXIc8+v+Nv3nU
 Rtpgr3OOUv4X2Q5ZQSpO2f2XHSNiQ0KCEbU69JH0vxZdpLPBOES22qD3OSUKoXIxFtll
 Akb/qQRoczVZLAH6COScUZCTxz9qlrRxhmmSFAk/4zVT/SBuh40PpsqMb6u6FGuxoKr2
 65vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788384228; x=1788989028;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0BW/h44lAnlL52sZ0ROROLHXPEuRuhnb/YC0bjbjoGw=;
 b=WVgVp3ggaS66hpGsRsw8KzsDDOAwKDmimTVXkIgCdBJokgOsWD3qejVYm1h5p7HZlv
 2S2cUOPYoOChw4Zq+0e7YmDrTkvtWoG6snSt4q9sEa+vg5xEAMlQv6xnvVEX0IfoTWuM
 gvvzCXVNP9dU5IrqdSoE7F4smLNlmnxfYEIedYq/M+HyOrRHOZZBo3UtR4KP8wfe9fdc
 4TNzM0qoOQfGqqIIEsE96/+knC5cHzJ4oemsoRtAQFvxBb6Cabbr544su0LF67KswXU5
 /5vgcAyldUEcMq5yPGHA0gL9Kw4VUsFYMHAQjCd/gpKoGbDLrTvTR02WTIAmFKqvALQF
 ENpA==
X-Gm-Message-State: AFuF++nUqs1cA0lwBoxn1mKYNw2btLZ7VXX8U99eU58GtfJWzC6MxRJI
 o54VqH52wBcsAfJYaYlwJDg9Rc+emAlEJVjpMiUFJGGZuG1Z9urUZhyN+R8Kvc9k718=
X-Gm-Gg: AYBFou0ao8e5fVpJvdTGQdjVvycYhOlhqUBLJXyMNAU4oA22kkW/lROoy5ZYFHHJmBC
 ekNJ3LFqVx1cQ/RiAj/XbSH2cYUxZigYB2judakfK/sBxvLepiBR3S0OF1WDYLe0QcoFh40rLIj
 Kp9CB8x6fd8MiG1+L/N0WvpYhbmYdHgdLHRaaNajHBZ16SR2wQ3ORwwAQK6u6KeudpMG2v5dW02
 sruh7J8WnSiA8j6ZmPpYjDAvGTneYM/laqT/EMvO9ALKxk5n90vBOO+AdyEkxHUp+5UNGo+esES
 oGbyF6NYGd9pd4YDMTXz7OuQ2K06WgBxkXdb0MCi6vhVn6kEmVrZe98F6b3cFksazm8K9YjR24F
 E8sCXSyilkqYrHSXtqvf0kMkiuKinOAzV8/Chg75khgaHmfoYJJuSx7iXyPv74CB02wDUysSkbg
 6xFkpmQ5byDWtnYmt60632jR51Qr2MfhI1j9OaosNbU0bea1xp5cdxZOx4NjB86cjYVPDaJ4eEL
 un9ItyFKUFGMkaD
X-Received: by 2002:a05:620a:240f:10b0:936:bcd6:269d with SMTP id
 af79cd13be357-93960c909c5mr770766185a.6.1788384227998; 
 Wed, 02 Sep 2026 14:23:47 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm19948755e9.13.2026.09.02.14.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 14:23:47 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
Subject: [PATCH v4 0/4] fit: Harden handling of external-data properties
Date: Wed, 02 Sep 2026 22:23:22 +0100
Message-Id: <20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTU7DMBAF4KtUXjPIYztxwop7IBb+mTSDkFPZJ
 mpV5e44ZQEIqWL5pDffm6solJmKeDpcRaaVCy+pBfNwEGF26UjAsWWhpOql1RK8gYkr0LlCdNX
 B7HKkxOkIaLVxo5Ladlq0+1Omic83++X1K5cP/0ah7uDemLnUJV9u4yvuvf/srAgSjOv9iKSt7
 /DZc3L5/fLIi9iHVvVNDbK/R6lGeRwwuIBdUOMfSv+g8O5XulFocTAh+sFO8Re1bdsn665fvms
 BAAA=
X-Change-ID: 20260730-b4-fit-ext-data-hardening-1734a9203753
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1788384226; l=3570;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=G9kD6o8bT6aR0rguRgJ56BmnjmJOVLuWs1visLl0YSk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCSCq7CmelL4vg2NZcJ80hmY0i1UqeI2tN0L8lpV4PepixzFonoJgaA1aEza4QbpT9nTtWelNHD
 WNIXd8/22OAs=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Wed, 02 Sep 2026 21:58:52 +0000
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

The data-offset, data-position and data-size FIT properties are 32-bit
unsigned values, but were read through signed int. Also, they are
excluded from the configuration signature, so they are attacker
controlled.

Patch 1 switches the accessors and their callers to u32, removing
the ad-hoc handling of "negative" values in U-Boot proper. This
transition was discussed and agreed on in [1].

The SPL loader has its own copy of this logic with the same problems
and fewer checks. Patch 2 factors out a test helper, patch 3 makes the
SPL offset/size arithmetic overflow-safe, and patch 4 adds the
addressable-range and FIT_SIGNATURE_MAX_SIZE bounds check that U-Boot
proper already performs in fit_image_get_data().

Patches 3 and 4 build on each other and on patch 1, so they are not
intended to be cherry-picked individually.

[1] https://lore.kernel.org/u-boot/CAPWaX55XWFLcMGRuaUuXXn__MX_UG4J8QTd6rvXZmJ4WSOCy9w@mail.gmail.com/

---
Changes in v4:
- Patches 3 and 4: the new diagnostics use log_debug() instead of
  printf(), in order to keep SPL size minimal; log_debug() compiles
  out in a non-debug SPL build. This is the only code change.
- Fixed broken build of am335x_evm, which has only 100 bytes spare
  under CONFIG_SPL_MAX_SIZE (0x1b000) at the base commit; v3 overflowed
  it by 216 bytes, while this version leaves 113 bytes spare.
- Patches 3 and 4: code-size figures re-measured with buildman -S
  inside the u-boot-gitlab-ci-runner container, so they match what CI
  sees, and they now cover every configuration rather than a sample:
  of the 413 boards that build spl_fit.c there are seven combinations
  of the options the changed code depends on, and each patch quotes
  one board per combination.
- Patch 3: added Simon's Reviewed-by tag.
- Link to v3: https://lore.kernel.org/all/20260810-b4-fit-ext-data-hardening-v3-0-17184cdb87fd@binarly.io/

Changes in v3:
- No code changes.
- Patches 1, 2 and 4: added Simon's Reviewed-by tags, which were
  missing from the v2 patches.
- Link to v2: https://lore.kernel.org/all/20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io/

Changes in v2:
- Patch 1: keep the 0xffffffff data-position and data-size test cases
  instead of dropping them; they are renamed and repointed at the
  "FIT external data is out of bounds" message they now hit.
- Patches 3 and 4: no code changes, added SPL code-size figures
- Link to v1: https://lore.kernel.org/all/20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io/

All four patches carry Reviewed-by: Simon Glass. Patches 3 and 4 are
unchanged since v3 apart from their diagnostics becoming log_debug().

---
Anton Ivanov (4):
      image-fit: Use unsigned types for external data properties
      test: spl: Factor out external-data FIT property checks
      spl: fit: Harden external-data offset and size arithmetic
      spl: fit: Bound external data like U-Boot proper

 boot/image-fit.c               |  29 ++++------
 common/spl/spl_fit.c           | 122 +++++++++++++++++++++++++--------------
 common/splash_source.c         |   2 +-
 drivers/fpga/socfpga_arria10.c |   3 +-
 include/image.h                |   6 +-
 test/image/spl_load.c          | 128 +++++++++++++++++++++++++++++++++++------
 test/py/tests/test_vboot.py    |  10 ++--
 7 files changed, 210 insertions(+), 90 deletions(-)
---
base-commit: 94b349bd902d9e38e1846c157fadd9054c34680a
change-id: 20260730-b4-fit-ext-data-hardening-1734a9203753

Best regards,
--  
Anton Ivanov <anton@binarly.io>

