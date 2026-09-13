Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C56C88E40
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 07:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB38140687;
	Sun, 13 Sep 2026 07:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lttXWe7mUfnK; Sun, 13 Sep 2026 07:29:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A639340694
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789284543;
	b=dlecd6N74gwEH3RFChHT2jODQNtMNrZfeBECCjNa4/idWkdoiRMzBQqgxgVIbAf02y1G
	 rf2CW9B1yf3jnvDtIwKUyLNskMnSZ9sUcrbCK5vn/T4KC1RPFhxJQxtlZQu1XVrWsk5m9
	 knflqrD6L/YpZhNYSA3rKSi/UKFq9WdKLazb79erWFfVpXLW8jjxS5n+VcW7QQN62psbF
	 mF9X2XeDOx6DH4V37h1fdmc1KMCZytrqAzmcCu9aGK1XyxOadBgqFveO50c/YB5kA33Vj
	 H+VY8H6oHxhQ83QiuD5QhY1AEaopshZP2J75dhsE99A7aXwl+x988zmopGPk2cl51dA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789284543;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JX0fEN7IkAwzzok48Kd8uoOplTBq6o5iNZuDUjHpEL8=;
	b=MhNjW5PF1XPr3G4sMXa8epYN6Wnppg4kWt3xY8wP9Mh17Vtnr4T+kZ073QdJ3RvLIkFZ
	 vSN7B9s6a+RZEjecRd1osqLJZ7XUoMauv9wgkCwC3DvMyTLqpVAZUKdIrmB1tapeuOsIf
	 IIT2tt9mNPSpI21/s29JPbc3YgMpteNg9Js/wcw42PYDrhuO0uPKZsgzjZpwu1pZvNA+8
	 cSm81ovItEA67KtGjeaXsKQo5PAkN8kjxyqqJE/4D3pimMyO6Zi0vdhbqZ4iXuXJ4/wtw
	 iknfTviqwRKMZGJsL006fCkZ9v3Ojs9MqiR4dJ3yyGs8h82GPMr78N9aG4P7gY4ooyA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HVNYxjd9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789284543;
	bh=JX0fEN7IkAwzzok48Kd8uoOplTBq6o5iNZuDUjHpEL8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hbEbVN1gzE3RspJNxoicPEuGaoGKa66TTNl1dNHIk/3bFuvlSPWGUmRbERrUntT30
	 eJdcDUkkkqX2HDTqC7WXkLvZAk1cIknNE9+r2hEwNl0IKqRk5gX5eKwxXq2k07TtxE
	 /fDP4aJgwQUGzjwNKigYkd71gPe4EQupmrMWwbpNu35H8pnoevBRKZ9N8IuFF7KD+d
	 9IjQCbbesHpWFzMmpEfGmpkvt5fNJk+TaBRNBUo5L5aEDDHnTL35h1xtuAz4H72NH+
	 p7iYQfCYpQc7Ofh6SE2QNt8+S6SgLcJR5gLLgjwAUpxcSjL3GYdP8OUjQ2Dvh8Pb7R
	 EDFSVHuMTj6yQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A639340694;
	Sun, 13 Sep 2026 07:29:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEF86701
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4B0E40694
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4P6swcYivya for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 07:29:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7844D40687
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789284541;
 b=QLCtYRcWQrnuceNkFX+3ys5o7p/NBJCg14BXZuM38oVCG618cNqnFhXb/I+4/Jt9Y09V
 IBed6g1+XK5wUPblqSX782hLS+NZAUooXKUTgsYg+h7oqOgQr0jtycCKzZ/QquGVm72F3
 T4U80jDUzrB18yjeboUtqBbGxYnlLCTk2M55E2DUQ4W6d4cAvUN3NnHnReIv5gCwda6Al
 cE7v6Uk/JDkycxVuKNlRnYbWD19hVIQeDEYUQ8Q/IHsOWCKsqraFv3Sf1mGeSD+F10S5A
 lSpJa45XEKFdEnw5tTILHyI+IxlenxmnSc5lD4RAgpbHwn9sP1eRDg9SXKux89xNVPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789284541;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=JX0fEN7IkAwzzok48Kd8uoOplTBq6o5iNZuDUjHpEL8=;
 b=JYR3F/sTCsab2vz6Jvu6TD0TGAZ64zIlORb0fh648aBU1YHKloFcvu4ZM6MWR26mPH0w
 2frCYhEEki1VMZ6FY3419FhKzUIWfA5AibRc/0Q47jB9DoDx0tFUvDRHrwjgrQzQV00Re
 TXzBBh1DnjTUhQ8LrRYzxLJ3q77dXEoJyuTcepf6kkWnT8AIzFjIBERMIDiuY82f732r0
 E/yO6VT2tdI2ccEjbYmgwy3leJL4Wt9fkSnex1n8xXmN6mumb81Y5STZL7T1r5E2C4lF+
 2L3AP2PlcM0UgPBlsaHf0neY4HdyWapYCDO544KybxnIIJQZE1xgdOTRwgtNnOgAnfw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=HVNYxjd9; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=HVNYxjd9
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7844D40687
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:28:59 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so569313f8f.0
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789284538; x=1789889338;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JX0fEN7IkAwzzok48Kd8uoOplTBq6o5iNZuDUjHpEL8=;
 b=HVNYxjd91WJ72DKNYrwEeX77GtUW+05X+4TpQNrlubbJaPUTwRyKGJ0HpHFy7EsFYL
 IQyk5erfgBlYj64HM0Gc7+ToNA5QKfG5UoN5fO8BTIPx2ZuS/7iA2B5cnpz+EJteGft5
 lfyN5Ei4QYZDq30qD2jWD+tOcKVf2kWBOQ6LchCU4Ps5Tp4qfay+Hc8p5C2gOa0rCsGi
 IKadZzTNBHbAayDkPweav0u/IRQFYRIERbmkvSjtPFMFo9lj2vC26ktE21QNcFSw1Tkz
 r56OPLppAXMLwI1kwhnhgl4J6PNpSMQ6JQMbqUhv5o1gSoeUpSs0fkI471/BXJ0Nvrzb
 /Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789284538; x=1789889338;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JX0fEN7IkAwzzok48Kd8uoOplTBq6o5iNZuDUjHpEL8=;
 b=UYjfnhyNyt1C4FTJxZKRIVoVs7Xkczd7x/L6OzKUdb8WbpAdhjnUQ3hpBLU/ZwcHDS
 fCPKZFytzQKn2JkMZGVH5Dq8SLG2pozwLrNQpBSM2wJgUxv2jeUW+jRkxGUn3BD5xzx2
 Mhgo+D4MUaYDYdswzLwTK29TP7Vv9AEGszvcZjolLaoHGCduGjQhx+9V3S8jdXOgmdUZ
 NwelNncRbizbQabh/x6ZngvYfIB825oDCyX0So+9cTfLZLfT2t7ubFtc2uhZfYAKs1Y9
 leB97xbAD5HMEOKM0tvcetzyOkZ+uWLhrvnE1rdkkfauD2KZBrHYDzuAGKblbp1lMBrI
 /Csg==
X-Gm-Message-State: AFuF++m4o2J7s5fVu+W8ze3fAkZTq4+mBsXGYPbLm6gp2QGGIdpxOM4u
 cyjfIgqpH99ZO3lqU5yn0IZMe3ovOyqE8eFtOGAVIUoJNhVYNevQil+r5S0Kh+s+l1A=
X-Gm-Gg: AYBFou2t8tt+ww9Q+aSDebes0z91f41lNEYc3kkHwCvnTKxyRfmjYzrtSy7WaeN1dDX
 kFCk5OorK3OL4gvu49kLNUOGSHI1BfynttXWOyr6bejpHSq1RyeEQpUxvIap3CIwomjQiipQgLD
 PuJ79XFVXidTafGKFcrz9rK1BD6FYW/Hvc+j6O79lfN9/2E6UuY7a0hrou/TLeQA2669i1MAvEo
 1qii8zV1rvjrrrqgFYT8qr2olpPNoMjkRYw8XW0iC7JEieKVKXA/e0kbX9sW7Q5tniea72TdYC/
 5hd2DaOdOnWBJiNkr4jt3BPFrWQ+2B2GdOn/6J1loMBE+n5+L9eZgZycx/7uI5vAd/cwRbuI1Cn
 zLT0wdU3YZVtBs7+N0WiZZP/7j0No5BQjJ3QT6EcSsgqgtLp2jmAOCSjdPPdZMfgPaUIHiZKAv+
 uU3IoZ9wWS+4IeZEb+RAjZF2/OrIjxcfKJF7DavM9umGLAMGG8w0ASyj6Iptp3zxW5J2ip9YU5i
 P+bI5uE62rXbvrzmRwZb9n6V9JnO59u/D3SCAOCzl6BCGM14+AstQLAL0OleNa0QP3W24+YcbCp
 LcieI2CXpzmRx/a1v5uqN/Nfwg==
X-Received: by 2002:a05:600c:4e0c:b0:49c:ed94:cdd8 with SMTP id
 5b1f17b1804b1-49e6198734emr307830815e9.6.1789284537662; 
 Sun, 13 Sep 2026 00:28:57 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e71e300f3sm100788875e9.7.2026.09.13.00.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 00:28:57 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v6 0/5] Add fastboot to SPL
Date: Sun, 13 Sep 2026 09:28:42 +0200
Message-Id: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOTW7DIBAF4KtErEsLA5g4q96j6oIh45oq/hE4V
 qPIdy+kihJVlrxgMeLN9+bKEsVAiR12V4YuEcfoet/mmZ3HNEVy3VvnQs9edizSHFIY+vxZ5dG
 3rv8iHo4lDAIqYeWee+9yhPh9m6fxxBuXJhyGiUvdOMAK89OFHCM14efW//H5N6czfpOfCloSb
 UjTEC+3A2dZcveueqNrllxyX6NDgwKdhXd0l1PASK9+6Fipm+EJBNgCgQsO6FRjpdeAfgVUT6C
 SW6DK4BEpi402UNMKqB/gHsQWqDNoLBkqJ1p9XAHNA6xFtQWaDApQRlZkrQL5D1yW5RekBexCQ
 wIAAA==
X-Change-ID: 20260718-ccaione-upstream-spl-fastboot-14fa2b6b2b64
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
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

Some recovery and initial-provisioning flows need a standard host protocol
before usable firmware is available in persistent storage. U-Boot already
provides fastboot, but the implementation can currently be started only
from the U-Boot-proper command line.

This series makes USB fastboot available as an opt-in SPL service,
including MMC partition flashing and Android sparse images. The interface
is kept deliberately narrower in SPL: it does not support the boot command
or filesystem probing, and reboot support remains platform-dependent.

The first four patches separate the generic preparation from SPL
enablement. They factor out the USB session runner, route USB reboot
through the common handler, make shared fastboot configuration phase-aware,
and add phase-aware sparse-image support. The final patch then contains the
SPL-specific Kconfig, gadget behavior, documentation, and sandbox_spl build
coverage.

Boards which leave SPL_FASTBOOT disabled add no fastboot code or supporting
library to SPL. The sandbox_spl defconfig enables the core service so that
the SPL build remains covered by CI.

Changes in v6:
- Preserve the GPL-2.0+ SPDX identifier from the copied command code.
- Remove the added copyright from the moved USB session code.
- Use direct stdio and USB gadget headers in the USB session helper.
- Remove the command-specific exit message from the shared helper.
- Use out_ labels for cleanup shared by success and error paths.
- Collect Mattijs's Reviewed-by tags for patches 3 and 5.
- Link to v5: https://patch.msgid.link/20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com

Changes in v5:
- Preserve the command-line USB diagnostics and document teardown behavior.
- Finish converting shared fastboot configuration checks for build phases.
- Require reclaiming malloc for SPL sparse writes and use a 64 KiB fill buffer.
- Make environment-backed fastboot features optional in SPL.
- Document SPL command, buffer, allocator, printf and reset requirements.
- Build the core SPL fastboot service with sandbox_spl for CI coverage.
- Link to v4: https://patch.msgid.link/20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com

Changes in v4:
- Drop RFC status.
- Make the USB fastboot helper and gadget build rules phase-aware.
- Use a separate command table for the SPL-supported command subset.
- Document the commands available in SPL.
- Apply the requested Makefile, annotation and preprocessor cleanups.
- Link to v3: https://patch.msgid.link/20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com

Changes in v3:
- Rename the USB session helper to fastboot_usb_run().
- Initialize UDP and TCP sessions in their transport helpers.
- Remove a redundant USB session return assignment.
- Collect the Reviewed-by tag.
- Link to v2: https://patch.msgid.link/20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com

Changes in v2:
- Split the common USB session runner into a prerequisite patch.
- Route USB reboot through the common fastboot handler separately.
- Split phase-aware fastboot configuration and build rules.
- Split phase-aware Android sparse-image support.
- Keep SPL-specific behavior in the final patch.
- No functional change from v1.
- Link to v1: https://patch.msgid.link/20260719-ccaione-upstream-spl-fastboot-v1-1-c9bab5b0ba72@baylibre.com

---
Carlo Caione (5):
      fastboot: factor out the USB session runner
      fastboot: use the common handler for USB reboot
      fastboot: make shared configuration checks phase-aware
      image: sparse: add phase-aware SPL support
      fastboot: add SPL support

 cmd/fastboot.c                  |  53 ++------------------
 configs/sandbox_spl_defconfig   |   4 ++
 doc/android/fastboot.rst        |  48 +++++++++++++++++++
 drivers/Makefile                |   2 +-
 drivers/fastboot/Kconfig        | 104 ++++++++++++++++++++++++++++++++++++++--
 drivers/fastboot/Makefile       |   9 ++--
 drivers/fastboot/fb_block.c     |  11 +++--
 drivers/fastboot/fb_command.c   |  99 ++++++++++++++++++++++++++++++--------
 drivers/fastboot/fb_common.c    |  36 ++++++++++----
 drivers/fastboot/fb_getvar.c    |  30 +++++++-----
 drivers/fastboot/fb_mmc.c       |  49 +++++++++++--------
 drivers/fastboot/fb_nand.c      |   2 +-
 drivers/fastboot/fb_usb.c       |  67 ++++++++++++++++++++++++++
 drivers/usb/gadget/Makefile     |   2 +-
 drivers/usb/gadget/f_fastboot.c |   9 ++--
 include/fastboot.h              |  10 ++++
 lib/Kconfig                     |  13 +++++
 lib/Makefile                    |   3 +-
 lib/image-sparse.c              |   2 +-
 19 files changed, 423 insertions(+), 130 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260718-ccaione-upstream-spl-fastboot-14fa2b6b2b64

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

