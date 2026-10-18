Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05358CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 04:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4276440576;
	Sun, 18 Oct 2026 04:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H1y-Ar3mwe1I; Sun, 18 Oct 2026 04:24:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 519EC405FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792297446;
	b=L7+0VwzHpOWcKzAKPbBf4p/s5fYl0AlBopzR3gUrDBGlw5CZmuuI9j4aivG9HWfOBQ+y
	 hru2+TgEXtyDP3At6CbdFIiw2E8wD28NVlZrbxQsqKTgIPO4pNvlyx9T0PO392rsXDLmu
	 v/RALdbx50LqT4TCfZ2+Gn+ypQLsOorV281vkSZqF2aErPk02BVCBKoJUBeiWdVeUCaXb
	 u3Q50QxsDeXIBJqhH5g90/BGel+NNXMt3KxA01i9UKnWGxL4+LhFQv8DK+erbnvEftTq5
	 6vdW3lxMAnnh+aZbzqWF8Q+q7M74z1mjrENdC9iqyHAPXVvJ8QnUyNgRDjgV5LHawRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792297446;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4Ymbnd0bOO7dbTARi27bD2XsUVH+LYmMN67OXGDACv0=;
	b=MjVJ7LWlwE0ebD8JAA1o2TRBk0bdjzLCcxB/gqouPPBHbymWQulfCsyPWN5H0+qz1sJf
	 YSQeThQXWxsL+4WAtkRVuqA5R/VW5io94l5FJrsxU/dQYU4Kzxg7qqmUIDeqY5AE9AODo
	 f9JpdDsrgmbipI+L+WAxbYb5udXZAzw315y6bIPoPAgHIEks8OGWf4y0pWpOGoQIG2f1p
	 EUqTCgiu/zOpj1u/C49bsLcXTsg+nzjTfKm6JD6BmPza6qHrexfjByKXKPO3AcKzLXSGo
	 m7P20sHazrSUhNb/uGaJyo6UD+V6iytPQ1Kltf7YWvwz6T5OTkugTc1M4ylKUOs/g9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792297446;
	bh=4Ymbnd0bOO7dbTARi27bD2XsUVH+LYmMN67OXGDACv0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RRj0iM1rmgwoc505ws5Y0zzBkguDl9Tw25l0R5VqbwYJjZ7KCBCtxugWaIECAcTJm
	 //u0fdye61m159nRqmdvCepESNFcfND1q3EHdtqBzTaqkDeLfM238/mN0ecwm0bbvo
	 vWaY7ffmGscRNyjsqovCBP4ufYJiFZjJO03eMvc3ovx+gH9pfE4hujDLZUAL6/TR6Y
	 QRrlJHs3gx7OWPbv042LSGpKXCRZM9SrTrRv42PjAfVXX0+bfUCOdhECLZGE34KdlB
	 cTCTfar59tastMMXESksQSQd2eBOGtHE+ccdq5ZVLcac7/uXsX2PaLa303etlv0zG2
	 mYtSigQW7UOMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 519EC405FF;
	Sun, 18 Oct 2026 04:24:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2586A61
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1759C6061C
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PYeyLG9PlVZa for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 04:24:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6BDD360616
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792297443;
 b=XgfT/jaSMXTkmfRV8RufL8/Na2QsPr+YNLIfkgGh6niaiFT4AtAy96+PxAWi60QDumOo
 Amld5sw7aMzlA6AOjSjm9Sqh4NOSXet21zjIPHXtJUZiZnotny0XkAXqNlOV9aDNe/WiS
 Afad5zhYvRrCvYRP78tQAArIH+ES+Z34Ay5W77fI4jFxHvVCvS/4iFDPVgnXbT4yfEJoq
 ixyOHcPvWD6TErhtFoHJhxe/K9FoIW+O8NiF2GqMQ5DbMf3+HLpYuC+p0dSLBOqbhs0/P
 TSCWwwBit87dmJ8vQ4tocJAIopJ9Va1c+B/aot1ySAZrG0Oca+R8wGPBTgSKDhwKYYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792297443;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=4Ymbnd0bOO7dbTARi27bD2XsUVH+LYmMN67OXGDACv0=;
 b=oG2efFe96iLvIXdi8Z2amlP8SchIOr//SiB+YpZroiYyxynTkAVO8MUdhpyyvfRek4oa
 fQl+ZBjYoziBCMqpEQ73S9cA9XKn0FDsW5+Q2gRdg5UOwZr8Zou2u9ylLdrsZnlR0yXZX
 q74SfKZvHXEEDtM44D4rbDzPf5brzVHQsY0l1fpMB9rw1n01/ptSZ5KCjyE6MQUOL2/zj
 wjIpA6N3yITV6gu3utYKJuf9UpD7Ub+fIZd9ijjcbBvavjxzA4t9UuO/ZMiBCrGV91VHZ
 yB8OlFdGaWHU2PqyYGOuLy1JR6e18FZvnzfPubLF0I90B4soFPQf+OypNddvzuoXx7Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b="bNS6T/gI"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=bNS6T/gI
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BDD360616
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:02 +0000 (UTC)
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-679334baa1fso1034137d50.2
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 21:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792297441; x=1792902241;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4Ymbnd0bOO7dbTARi27bD2XsUVH+LYmMN67OXGDACv0=;
 b=bNS6T/gIcnhzVwsLegQupyyySSoHGLjvpljmSfXLaiF+aZu+I0L6gK3jJ6wc+ECqp3
 O13SjYR5PNxgOa3ARUTQXE5piF5bB0JjegRVQGC/f5Kez+nA5q2ehsIAAEdHrvl6jHPy
 5bPxSL1TVEH5kIYadfFLNNptSQJ/Fz8q5sd9Ec7gj/jbobrlIS8YxyiWzYl2KNpGpUs+
 cA642uHrfg6W1v+78tftBXxsSCGgO4yFIK4Qucqn7rvyYA513UWybnS9yt0wubZ/cvQs
 F/N9znKCq4exiuxIuK3aqrNcfK4MvvKbT3R6sb+XhebUMBi32rSzaKG8fOopPwbEHQwe
 R69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792297441; x=1792902241;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4Ymbnd0bOO7dbTARi27bD2XsUVH+LYmMN67OXGDACv0=;
 b=lFSGeNs04K8jDbNmvZ1i3z8/efYCTuCquLS1CAg9hrF8fXwXvl7Jy1UbIJo4s4OQHA
 IBuQ4EOXR02O7Y1LeohFdQ4mN8eO6NaC3rNeBqK7w3m5tgdG5/0vqdr7Xf2K2I3bsamo
 PFuGop8QyjmXDLSH/Awv7sI2Qbs6SmS1GkEM2XiLq3m5pQnwrgHCg60aXywITnsnuD7q
 jA5Y6N8adCrrCn5vcyGXw35qGuBDpqfI/Xz9KjaQk6CZy1OHrEC7XNFGDnSrIiuZ1iij
 5cLomY2JO3/BS+Mi4uAUR4P4gPju7+nFY6LXShvFvllfrayLdzIpZCMmbL59wityKXAK
 ZMDw==
X-Gm-Message-State: AFq9FYK92sOKhYQGY8XZjexz4C7S2fh3JeqPRpxhutAClg8ekwTBwtW1
 Cv50KXdtUdVlMRdCQrJefj8jVcaKjUkTu6TJxe9Ni/RcMPsHcTUqYLj73gIMh70jVp0=
X-Gm-Gg: AYBFou3yvzn3CKUyP/cENRK3wA9UZTsvA9VueMPYH7vZ5MgCCDYqFiocg4q/d0kEcrd
 LrHgQ4mjDjZXsTxWUgKDc7XVjfma11X1YSF5Jdx/4LJxFJP00h4fKS8kcNN/jYq6weIt+3JdfEu
 ICQ0hQhc3iqUjlPOwEi1iDFOqUZFlWY/9DhQLUdfZH4YqrvRFBBsBnFx7TjzoOQ4j06kiyp6JDH
 rIwWMLPeQyRyVtN8y3bEiKerynxxrWx6VdV2RtJP5VXGo63ZF2aLzQfh0rCxv3UVyxfh6hDpwYn
 4SX45Cv8JiCOb6EfYVVx8gQxO45j93vf+LDq9VoOYMhyJ2EhT1tlMcjRRbBdGQAvjxl7GYiQ8gD
 MgWY06i5pwu+41Nkh7N3R8CaTdbW3IPbNR0GwSfrANlU7uChnJvQ2SWeEl1NWvJjvuSM1sLGtq/
 OONvFYAekpeuRoKbTBqUfizOphUaZGtl0h31XBjzIH1aZwKgW2QneGRj4lG7DlHoemik3bXMGYV
 4/p6lurygcZDL+rR0bQem1eh5BQn2JQxm6H+92WrkJqXT6Z1DpJfL8=
X-Received: by 2002:a05:690e:11ca:b0:677:d155:1332 with SMTP id
 956f58d0204a3-679ca840618mr913621d50.56.1792297440985; 
 Sat, 17 Oct 2026 21:24:00 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:4b47:590f:51dd:a46d])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-679b1f0e01fsm2838791d50.20.2026.10.17.21.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 21:24:00 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Subject: [PATCH v3 0/5] Misc Fixes for VGA BIOS Emulation
Date: Sat, 17 Oct 2026 23:23:45 -0500
Message-Id: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFJ1GoC/22NQQ6CMBREr0K6tqQtIK0r72EMgfKRmtiSfmw0h
 LvbYnTFcjIz7y0EwRtAcsoW4iEYNM7GUBwyosfW3oCaPmYimDiymkva4gTQN6EzDpvBvABpX0r
 FNIhK1prE4+RhK+Lvcv1mfHZ30HMipcVocHb+vVkDT7ufQO0JAqeMalXGySCkqNjZIeYz2ETxY
 OdcuwdJqiD+MM5YsQsTETZIqFQxMFG23T5sXdcP28GdQB0BAAA=
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
Changes in v3:
- Cleaned up code/comments around freeing memory for allocated BIOS Image
- Added a vga_port_active() helper to besys.c to allow the handling of monochrome/color VGA ports in a shared code path
- Reads to 0x3DA status bits are updated to use this helper, so it doesn't decode in monochrome mode any more
- Link to v2: https://patch.msgid.link/20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com

Changes in v2:
- Dropped patches 6-8. Those will be implemented using custom ops for reads/writes that the driver can override (like Simon suggested) and be sent at a later date
- Cleaned up typos based on Simon's feedback
- Changed BE_inw to use 2 BE_inb calls instead of VGA_inb
- Link to v1: https://patch.msgid.link/20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com

---
Anirudh Srinivasan (5):
      bios_emulator: select X86EMU_RAW_IO only on x86
      bios_emulator: Don't free a caller's BIOS image
      bios_emulator: use driver-model functions for PCI config acceses
      bios_emulator: support 16-bit reads on VGA port
      bios_emulator: extend VGA I/O ports to include ports 0x3B4-0x3DA

 drivers/bios_emulator/Kconfig   |  4 +--
 drivers/bios_emulator/atibios.c |  3 +-
 drivers/bios_emulator/besys.c   | 68 ++++++++++++++++++++++++++++++-----------
 3 files changed, 54 insertions(+), 21 deletions(-)
---
base-commit: a6ab6a66146ed0bf1420db0ee858b49005783222
change-id: 20260718-aspeed_vbios_fixes-d4890ce2587c

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

