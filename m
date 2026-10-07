Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60F8CA6007
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 16:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7730E406C3;
	Wed,  7 Oct 2026 16:07:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUmiGVJxB5yB; Wed,  7 Oct 2026 16:07:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 80DD440655
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791389235;
	b=m/4qlThvOOJnJVhP9Hmu24i8hyFtNy19N1gqfVvk7Vlvt252jy9nBbuubWv3hB8W6Aga
	 JKJSm3Qjlw9sT8ztWD2KqpQNXPjw4ps9kv9kTEHNiqJQOOHEfg41y+Dovxh0zJaj5KrMe
	 xAcT5a3fFTtA6adLU0iDwDhGQwC66GOXk1kDlPeAhm86TglQ2KesK8lRKMsb1y+NOcQ2B
	 LpaodvLmkFtcflN7VbLpIcFM6XzlLEbRS0oOoiHXH89BAq0/w0wafASWToW6mPjs+wv6C
	 iFMc0W2gxMmL3+3Og0ArIJU+dsj/oMxzhxt8t6r4+eMdgV7J5BRWXNzK6Ps/RJq6uww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791389235;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dZyzuBlmcY6XR+twlKeYRRbBC1UAXSTx45oueI77oZA=;
	b=Tvmugdn/OImokNOtW4AfMV0fIuISQQfe0vKTn8khC7nrk/iGYnSd5kMgopNRVYR2eHCO
	 lxtjwZdyZ8o/YKgLyp+JLLrBt3N2V209AYS2n3lQIcjeHPo22wsRqu/YfhING9YNlGyFS
	 crrTD7mffu3tr9MWbCxHzUlk1JzJxnBfVxgZFM0b2Y4Zdxk7yK7eiMUHQ6osyLZGP+jhV
	 3HAHr1l8lSynCqy2KwPXEk/E3LkuSbSzZSlJgntID5Srtc5GD3m/5Y5pI4HBkSJfp3jDp
	 6S6wfWad7zqo7yPABODrFn5XZHOrElt4Q5TeWwm1qkCm7dEaCkWW9eun3N3XTdsciLA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791389235;
	bh=dZyzuBlmcY6XR+twlKeYRRbBC1UAXSTx45oueI77oZA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hYTmltJte0e4KjKsEYVhkl3Zk27GIwnQ0cgu9f+EzZ2OU3dyUdgAR+PItrs0jB9Q9
	 0dqOQKddFUYyP25x/AdTcJfydz7iA8vQmmkOJ/eG5gO7fnGHPfkeU8cVLVv+RLgHxN
	 5o5HrTKmXcINxsrdqFJRBI9EbEKlSZYjBRBqJ/Is3mu1O3EskaDwjLbgNj9wwTpndB
	 cpcQc8/CNV8LJ1yA6MPxoisT+FjDMiJSY4QGGgrxMcRjMZUsYiNt93l+b6/YYChOG1
	 Jrasn3HN4I9C5DQXLj7XSfoSnz+ahlCBGGgOalOfnfCt3IJY/gkVCYo4/TDZjVPp5I
	 G71rmEgY04Eiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80DD440655;
	Wed,  7 Oct 2026 16:07:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EB62335
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B9BB80ED9
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWyQRd4Ym1_X for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 14:45:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4746080BA6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791384351;
 b=SpbL72bEn/tEC2uARNg/OF3GLV3ZabFKuuI2omCQqAE3DX5P2I3rVtf2HvRqFABwu66P
 dNzedL8Kn2ODoIaTY0Sh7zfFeeA7liCI0gxQ2aT/heMl8DxBq+kfFI08+NRsAO6m23fCJ
 BhfcXfksY7aUmB3zvvPC1PBShbIoX01BWiVyr/0UwVmjMpzWdaJWumtKYqClIxuDCUXLu
 b48BnOaUY99fFAfPn69gYLSY0kV+3PB+gl/c3h6qaX++d7s1PghCJRW+Jl6Q+uVPwH4cQ
 BvRDErpkXYpgGnWj7XMtxvRMU4wvxs7RGJmtj0cziqF9mJQ4NWPtpjXafwFa6srkqlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791384351;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=dZyzuBlmcY6XR+twlKeYRRbBC1UAXSTx45oueI77oZA=;
 b=Mhgd8TPNUK13TETALHHnVBlYn5qfEYoZDNipp9FeJ8+revfT+C2uCxf5znDa/71uPEwj
 Bzzq+PxgF2RmIqXrG+gXqoTKnl5faIMHTSDpLiSrL3PJwUougJsjfxO4364rAafE3Omkn
 uuuwViXh2OqeWJOx7dca1v4OvQD0iDcAvjUs5De9V1SkJ/2uCaWY1Qsi1vkg9DZ+fr0iP
 H0hLPTzskYh7JIpr7g39nJ+bfqiFf4b9vq/OJsPJ1XCc8yF91H37Xb53KNWA22+i+xEZO
 HN9vDJog4qFn0i3dLr03a1Wj7CF4bV/nRJSeUmw/vgPjvzVRXbtTFqv+60brjAasOtA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KlurJqsS; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KlurJqsS
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4746080BA6
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:50 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a166199820so12384245e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791384349; x=1791989149;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dZyzuBlmcY6XR+twlKeYRRbBC1UAXSTx45oueI77oZA=;
 b=KlurJqsSNeBuocUEFM3Ne/OGT2aFxpTTvBGaI1Cg3odmi9V+biB7xhTiV9zrzGIhFE
 mZVCsrZfbosyl7cOUUjWQN53lFRLyeYqlZDN1vVOv4Du5YaYY7U8ZWr1W+sA3LElsc+D
 7xP/E8YShAJ1BxS+pSkP0pg+tlmSbEoh23G7LKdCax/V29gG8VusX1E93nNuFvGxqj2b
 bxlVv+8ExTVkAMu2Lgqnc+KQ6E8ED2ohKikSjPYXywtVJAEtdwdHg7kED8EGkE9ZLiwh
 EVjly2COXBPCyWeatbXnEk8Tg3YSNQIEG9B26KNtyp9UehEz9SMT0uPzn717fVP4RLXS
 pyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791384349; x=1791989149;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dZyzuBlmcY6XR+twlKeYRRbBC1UAXSTx45oueI77oZA=;
 b=ybJ0+JISTLuR7LXwi+Stf11qTCwOfBYfxk8zzGT10KS9zLa7rPezMcI0N8c46tgZhk
 LtM9EMyXTArKScf/xtGj7j7j/KH4JUuoxhLNFAu8KPqHno0IBkwgqY4b3S5nYiehqnJx
 bvFg1e9xl+7q6XGxghXra7Qkn9Jn+MOMEglkmDfBMjD4DIejh7DXNdVDCjQtFQlYvyyA
 NQCBxbs8nZO80O6BZ//Uh+9i4JVXRs9pjhzAHTKVDuAsWzoJEB30KNvJGPLe6f5ZRlEc
 Q+vCJaolhRE/IfZjsbYufTPFvVTyCiTgoIwhlCoEWqQ3NVRX4lLaP6TsamZpmbHEwQuh
 1dbg==
X-Forwarded-Encrypted: i=1;
 AKwUvByjEJZYZEaK2lVHbC3AJD61aWkH0EMFzvWsI/SN8aibNO0rZudXyHV8hLQ/2jdAHMhpE7kGlzw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k1QSoH/Of0JDmRXaOAFqj7som2CMhpYh/y0SBgevElZvBcSj63
 KC0cxVD3Ctm3FQsaV7uDiH04lw0CT3qLKIPQkgj6FBOFJ7V3vaDkKqY+
X-Gm-Gg: AYBFou0atZANwjb0K2yFccFT71pNYQqAWzBz9V4PhVjzzOn++ZTcRe2kH69CmJRSxbK
 0q7hBVuh30KeXnmQNUoft5JupycE68feH/djREWs3xRQwb+wBAoZculzmZsS5VAlPaU1xDRii1H
 f3Ujde1FfEHjy6XWhv8P9EoJ4+daNq8RcZKe0z8WLYlAq/KLsqAucwln3pBSx6RFwpq6zHElSIm
 5B9xakJQK1QYgySmR22PnpA/+D7oybc5zz5RhGrU8bRhuSughMsUI0IgxzVnnajx0SSSKgfiCet
 5sufVreAQ28XnW/KjxGLrCVmkomRSGUIF855E9DGsyfSzp2HBKn2IUN+MTu45+sGAI74elMKVk7
 VjEGsJLh5qPgnHGNDT0cetCotAC47bcoScS5PAOSJPuLfhp7ZwqqIE7eFn9/kVzoWn9c3ye3rD9
 kwtIfX0jPC4dn81W3TO5LXC3wqaCbHIvUEfthqtswDBBTqo0FdRLaAeok7k14MdKNLPkHIl0ZSL
 aMb
X-Received: by 2002:a05:600c:3e0a:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4a180455e96mr43174875e9.16.1791384347738; 
 Wed, 07 Oct 2026 07:45:47 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f557bcbsm111620105e9.9.2026.10.07.07.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 07:45:45 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v4 0/6] usb: ehci-vf: make the USB host port usable
Date: Wed,  7 Oct 2026 16:45:38 +0200
Message-ID: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

"usb start" on a Colibri VF50 or VF61 kills U-Boot with a data abort,
and even with that fixed the host port stays unpowered. This series
brings the two threads sent in August together on top of next, where
the regulator GPIO change they waited for has landed:

- patch 1 fixes the data abort: the controller index came from a
  sequence number that the usbphy aliases push past the driver's tables
- patches 2 to 5 drop the dead non-DM path and the empty bind hook,
  add ofnode_get_alias_seq() and take the PHY, usbmisc and anatop bases
  from the device tree instead of the tables
- patch 6 enables the vbus-supply of the port

Patches 2 to 5 are the follow-up Marek asked for in his review of
patch 1: the PHY and usbmisc tables are gone, and the port index that
is left, for board_ehci_hcd_init() and the anatop registers, comes
from the alias of the PHY node.

v4:
- rebased on next; the dm core change that moved of_to_plat() after
  pinctrl is gone, the regulator GPIO is now claimed at probe time
  upstream ("gpio: add a way to parse a GPIO now and request it later"
  and its users), which is what the vbus patch needed
- the data abort fix joins the series as patch 1, the register base
  patch depends on it
- the checkpatch warnings in patch 4 are in the body it moves, which is
  unchanged; its one check is the DM_TEST layout every test in
  test/dm/ofnode.c uses
- patch 6 enables VBUS in the reset hook only, as ehci-mx6 does; v3
  enabled it there and in the shared init, so the regulator counted two
  enables per probe and "usb stop" never switched VBUS off
- patch 4 gains a test and no longer documents -ENOENT for a missing
  alias, the live tree returns -ENODEV
- patch 5 drops two comments that repeated its commit message
- reworded the commit messages of patches 1, 5 and 6

v2 of the register base series:
https://lore.kernel.org/u-boot/20260820071511.1036506-1-mehmet.fide@gmail.com/
v3 of the vbus series:
https://lore.kernel.org/u-boot/20260820102523.1076815-1-mehmet.fide@gmail.com/
the data abort fix:
https://lore.kernel.org/u-boot/20260818151236.2891878-1-mehmet.fide@gmail.com/

Tested on a Colibri VF50 V1.2A on the Iris carrier, colibri_vf_defconfig
on next (ed869863c7e): "usb start" finds a USB stick behind the host
port at usb@400b4000 and reads the same data before and after
"usb reset", VBUS goes on at "usb start" and off at "usb stop", also
after repeated resets, and Linux takes the port over when U-Boot boots
it without "usb stop". An earlier build also brought up the host port
on a Colibri VF61 V1.2B. The five ARCH_VF610 boards build at every
patch, and "ut dm" on sandbox gives the same result as on next, plus
the new test on the live and the flat tree.

Mehmet Fide (6):
  usb: ehci-vf: take the controller index from the device tree
  usb: ehci-vf: remove the code path for a build without DM_USB
  usb: ehci-vf: drop the empty bind hook
  dm: core: add ofnode_get_alias_seq()
  usb: ehci-vf: take the register bases from the device tree
  usb: ehci-vf: enable the vbus supply of the port

 drivers/core/ofnode.c      |  20 ++++
 drivers/core/read.c        |  20 +---
 drivers/usb/host/ehci-vf.c | 187 +++++++++++++++++--------------------
 include/dm/ofnode.h        |  13 +++
 include/dm/read.h          |   8 +-
 test/dm/ofnode.c           |  20 ++++
 6 files changed, 144 insertions(+), 124 deletions(-)

-- 
2.55.0

