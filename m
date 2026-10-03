Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F95BCA5FE4
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 20:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D567C40AFD;
	Sat,  3 Oct 2026 20:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RVblgI9DqhC4; Sat,  3 Oct 2026 20:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B85E740A8C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791058092;
	b=CgKsun1xMOQC6VHSDYBs5OAE4+xzsIFhBuT2BlJmIWe+722jfsUAC2WYV5sJYIocrG70
	 INykklBG/G7nWuT13ro7Ja2e8rQr//2tzrJlTyUAOA8qyIsA4NnPdf/Q2znp4C1tjKaWs
	 bffv6T7NLDFYHE4rsDm58Wyy68mE17LODz/18BwnVB7pU6rC2mr9dAffzKnZOPoISkUKo
	 8iudVw5M3V6RcuJIAUpBcjF3s+OGoL0J8RQ4Cuf4FuSK60qxIog23K4LrgBax5T3BDISz
	 j1k5+KDXb99PyhXkkZ51mN9nvNPljJSIPhJDJPxHTcg/09N9/RCXnfMPUfGRndSUXRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791058092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LQJoN9n62st+Z8IIcrkjrJhTwQ7N/7f1ES7mS9DD/co=;
	b=YfrX+Fy3NE7YTHu1jXQFfKd2dK8qfGrdwQeDYSrHzWpLQomk6XrS5fIIRNusAwvwGoAL
	 +9Te2ZqbbEtKFPcfGCnTPUK4SgSbnpv8ZTU6WxGvyK+M+FWABGXwiFqZquTRjwpps2yvy
	 qLMK+5JfpNLmyyuZVOUaougI7C21NCfuRntQmUlINe1dJCKZVW+GRxk+AnmicCNSAau4Y
	 V6CuZSbRLdM2cWtg9n1Vg4PwO0FOISKdR77+QUr4znq2NDrRmMYnRVDEJaBXtsvJa4/R6
	 ua47wqwGj3YYFDbH8AtWbLW5CqyBrj1HggaQOsInvfPsgWn3ccDiZCvcIV+zLhpr4qg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791058092;
	bh=LQJoN9n62st+Z8IIcrkjrJhTwQ7N/7f1ES7mS9DD/co=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zhgtwwYsHZJwBxvB9WLmbOG0Cjv376smRMnQj2XCPZoTXxXIhxorLH16D8VujaDBq
	 V7oTOcWOtFfrqqQSFQWxxQYMESS7+OFIEGILnOr+kTXTcupErc47jCGazFCZcR/luD
	 F/KlqmjnZeGSfNdr/9GodgB2uhr4CBiJopg/N3d0zVLVE2RTy8VZUSndTdGCghwhs/
	 4kI/aSI4qmvPCNJRquehYWPbqMHjAZQdDF3VjBU5PJVmZLvREaoZkw2T5T5bB4cOBI
	 21LcyC2wVRjGrMyFQuwHYt/ENiAWfVnmnkaGK4MlqeKLMcAv8xgb4D9XwuFjyej2FZ
	 WY/302hAGc15g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B85E740A8C;
	Sat,  3 Oct 2026 20:08:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B301C1D2
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3F7B80FA0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pg9SeTd9zywv for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 20:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 064C980F56
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791058089;
 b=FwCg6QlX4Rlz4tgQAxosf4K0kdLUNHbbSy8TVbpLI2/1SIgzqW+uyFhwGjhqsKvaxJMj
 LUoOQFK4X8iOxYQp8BEVDDOxoBMWKipgY4FOHYU2bbAJ0ANevpDSDziCwuhKLofFlir2d
 mbLffAmQ687Oi33ekZOdPpYUcMXDfIuO1Ylsa+ACFMlVNIdFC2PAehYU3jQv6hjeQ+9pR
 Bxa7RxhM4j0c8MZ4ldbJ9xGPJrnZTuzv++Iae0j+g6tR8uCl9Rk69KJ202/Sq8z/w2dBz
 bPWS1xZngDIRlvOqtAFyN+3nLWlihs6zEFh0FfpZtP9qMHIepT4Q2O6zvLiLPF+6CBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791058089;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=LQJoN9n62st+Z8IIcrkjrJhTwQ7N/7f1ES7mS9DD/co=;
 b=j9vdsu1EGEJqNHN2M+boBIzdWA57zIy/97bGiH8vun0MOe4CRoWR4iXm0zBdMUupVw/L
 ndxAJzzguKMKZktxpKprij5xzbpoyDOq55jQGEUwOWjlxLXi5wZv85sT+Z3Px2yAza/ru
 DJso2uBMoYhoHsqPIfkO1dZXmkVZzTnX6us4EC6waSN84APO8mnBNc4MqerPe7NrXvDLT
 yKPNlnpIkGpXaZKQPshI2SRJ8juG67mGEI0AyErQ6EJJR82TmMLd5DGSjUbFtJLi1Qxf0
 iVAJK+SkpIscW2yDCi1BLdhUJmJ1qwBNy5VhcEiQiy2Mk5p0OublIyCzwLCbsG2pD0A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.tenstorrent.com; 
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=MfF16JGv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::c;
 helo=mail-yx2-x0c.google.com; envelope-from=asrinivasan@tenstorrent.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=MfF16JGv
Received: from mail-yx2-x0c.google.com (mail-yx2-x0c.google.com
 [IPv6:2607:f8b0:4864:41::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 064C980F56
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:08 +0000 (UTC)
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-675686b026dso162523d50.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791058087; x=1791662887;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LQJoN9n62st+Z8IIcrkjrJhTwQ7N/7f1ES7mS9DD/co=;
 b=MfF16JGv+0yjrhm0zR8zlOCAU9iaYkYeZ2qNpsjwHzddqFIGi/qF5DAwfgSSaiNUpT
 wS4wp+P/l6mu6omccUjDcOjqqvw5Au03+MIEvT7OD6riGgOnIJ/4B2VHIMfNPuWQ+9BT
 R1W61NFgbtDqArGzJ7g6c+yxZhoEPrDBifk9V7AZ15uDA1B2WsZE3FayDvdraD6qY/FB
 kkQMlcQxtYneUikcAUd0bjx2zF78WNyjNM8IC7nCNubdlXuSvEkQ2N89AfNfmGm8VhPw
 KeM8HJBpR9uZVDG0YROkW7xhg7xzQLKP8oREo/ink7X0s4vH2FFLEHyJ9TT1cY6vVurY
 T0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791058087; x=1791662887;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LQJoN9n62st+Z8IIcrkjrJhTwQ7N/7f1ES7mS9DD/co=;
 b=ro/w+KsYUtroHwii0MxyL6IRGhJ7B6geG8zetYPzeIsKcEMTWubvST3oY+KwTbs8Pj
 5KtbAPE44iihxwMrC1b2FM7UoTH7/IVAMVEKlUifF+qvLEHurTtVOlgHth/uvj+174+4
 n2ZyAyeDrhyVHb1TbUVi8iuj/iNY9szRJeoe9MtlIsnHya9fvSkZLv3G9eeFSRddR7hA
 31WWTu9crocmSO1OqwXoKvUpoIYM+UNRVU2kcewmbTsCBJb2zBxOcu9HRMjOIo49yflc
 cb+Iu/phzWc70eWG9HgOWfOHmQ8mRN9OG6lg+WdmqUQzePBvdiYlsll1U+WfX0POXtLm
 QA0A==
X-Gm-Message-State: AFq9FYK/uL0KRSa1ut8r1/VGoeN/J/AYP2bwEbv/FXXfi/lIixf/bHUI
 afUObwCob2e8lGbVCXhdINygq0gDU/jAVE4XtF9n1Al0gDFN1vsUATwmpp4SHtghUoc=
X-Gm-Gg: AYBFou2e4dc4wJd60ER80Z3Y0tsu6wHpYqQOBwWMxWFIH1NVFDzn/R6JioP9GPIsCVr
 6az3sSYvkwbe8UZN3vW1//LTjRisNDSpQVrJcaMVDKJtmpxUVsUl262HsXcgDk/aX+zbbgZzvaU
 1Fq5MvMDmDfrQPUi4KxriuNjkWoefuN9xou6//bn8ARI+UADHRC5PcSnZLG2lppe4iasSjwWgOx
 lUuAl2txn+kkKh17n2wABlvT/WAc+6RbnN4jozXglXeuajo2PKFmTGGB37fan08MMAxvKNsbyQh
 qWPi9UFKGGpFpmSpIIuSveybBXZsXNNdWFsyCvWTdtHNnN+Yx+Cr+LKyvl1jllWoygky1xNVEs5
 uA7ZGZ9lfMvzSGf/NYn6TXd6jRBxYDO2tO2Q8r/fCJ0Rl/n7n+6a45ixnc7BcOiZxvxZObgqjHe
 tb+RSDdtixAngPUcne4nctmBpGOfym55H3wWCZYfvyySIL/fLAVrqobk3jkvC01I7JXq2XKaeF3
 J/lgpinNWETBxo30FZS6di4nZ+7GuqR7rLAJVfgMkeK4Hp2UR7rGA==
X-Received: by 2002:a05:690e:b4b:b0:675:61ed:ae79 with SMTP id
 956f58d0204a3-677ac211bb1mr2420719d50.40.1791058087217; 
 Sat, 03 Oct 2026 13:08:07 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:e2e9:9d9a:5aeb:a046])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-677c16c243esm986048d50.0.2026.10.03.13.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 13:08:06 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Subject: [PATCH v2 0/5] Misc Fixes for VGA BIOS Emulation
Date: Sat, 03 Oct 2026 15:07:54 -0500
Message-Id: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJpgwWoC/22NTQ6CMBBGr0K6tqQ0IMUV9zCEQBlkTGxJpzYaw
 t1tMe5cvnw/b2MEDoHYJduYg4CE1kSQp4zpZTA34DhFZlLIs6gLxQdaAaY+jGipn/EFxKdSNUK
 DrFStWRyuDo4g7q7dl+k53kH79JQaC5K37n1YQ5F6P0HzTxAKLrhuyliZpZKVaC1R7sGkFwfG5
 9o+WLfv+wepYBcq0AAAAA==
X-Change-ID: 20260718-aspeed_vbios_fixes-d4890ce2587c
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
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

This series contains a bunch of mischallaneous fixes to the BIOSEMU
codebase to get display output working in u-boot using an Aspeed AST2600
PCIE VGA card on a RISC-V system that doesn't support I/O ports. This
was tested by passing the card through to a qemu riscv64 VM, but should
work on any board supporting PCIe in u-boot.

v2 of this series only contains the first 5 patches from v1, which are
misc fixes to drivers/bios_emulator. Based on the feedback from v1, the
last 3 patches implementing a aspeed_video driver/overriding the biosemu
functionality in a hacky manner have been dropped. This will be
implemented in a manner where the video driver can provide custom ops
that override biosemu's read/write calls, and will be sent in the future.

There some checkpatch warnings, but these are from existing pieces of
code that I've copied/refer to, so I haven't tried fixing/changing them.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Changes in v2:
- Dropped patches 6-8. Those will be implemented using custom ops for reads/writes that the driver can override (like Simon suggested) and be sent at a later date
- Cleaned up typos based on Simon's feedback
- Changed BE_inw to use 2 BE_inb calls instead of VGA_inb
- Link to v1: https://patch.msgid.link/20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com

---
Anirudh Srinivasan (5):
      bios_emulator: select X86EMU_RAW_IO only on x86
      bios_emulator: don't free a caller-supplied BIOS image in biosemu_run
      bios_emulator: use driver-model functions for PCI config acceses
      bios_emulator: support 16-bit reads on VGA port
      bios_emulator: extend VGA I/O ports to include ports 0x3B4-0x3DA

 drivers/bios_emulator/Kconfig   |  4 ++--
 drivers/bios_emulator/atibios.c |  2 +-
 drivers/bios_emulator/besys.c   | 50 ++++++++++++++++++++++++++++++++---------
 3 files changed, 43 insertions(+), 13 deletions(-)
---
base-commit: 5c215cb75c3723cbf77c36cbac3e60b001721c79
change-id: 20260718-aspeed_vbios_fixes-d4890ce2587c

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

