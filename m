Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D231CA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB18760B55;
	Thu,  8 Oct 2026 12:52:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F5DYUXekTM9g; Thu,  8 Oct 2026 12:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AC344608CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463930;
	b=jU0JLK2ilMtf2sSZectFYIPwDqulTxhHQrQJF7OuaFeSz/2K8BrfzAeVYRJ16IJUhP1R
	 Kt3dTfx8qbzPq7Vq3IbEm/vYvPsSk8v2RjisxEOgc3xkIK4ZOgxvjxdxrlFUPYn7YQVZ9
	 5tW8bvp6vipYG89siEyPRKQStcfFbcVP1Fz4tDRpEZFtX7znVdZRB9XLHlOatKcS6pW/u
	 TtMKiJFFh7xJpQGk/MifOQFDDqkT7uu96+LEPVU/d3jY7zIOmXnxirHFVhc61sL+5omD3
	 JDOkQuZSlUfRGPRGEY8qkmFID5lLqjG2N48nl82PaTyEZJlTQLcxwV1GovsLXH92S5w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JTo4EBieiYswrx7zBBshLPY8NmoToaFaUaRgGWWtq9A=;
	b=g1kTe9ePeLbGidUbm1U5ZWk3Sax0LPHfyraP+EwAvt1ql3evQUW+GbKn9FDaUgZs3zSQ
	 s4M0gYkPHli/jXwGdQyqOoERK5iIhT63pByv+bhsJE6yDgdChUx71plt/WuafdvCxcsaG
	 9h9xT3/ASCWmUby7tf+BWGJ6L1p3yqdul2UKQqtzH3kGh/LlTWQN/iLRJfTi8afysP9ye
	 WiXAbA7uhOw8S+uijNsjvwnWe8neXw5PMYs8qkSKNPaMOVMLwl+NwZAeksgm4uk/XkD6S
	 Y85VrAxX7V25imT2AqJLfXX4H9FaVzM2mnnhm03y7UTiwxotqkCwPZIsoiOLuguky1A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463930;
	bh=JTo4EBieiYswrx7zBBshLPY8NmoToaFaUaRgGWWtq9A=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pJJDn52E0ew9l4oBPskCN5L4/Pv5RnOb2lzKe6EBefr3Zf1d+Xoy+wdUsCzcdo5qH
	 ny6YZPwbsnf9NWH6W+VBzqllJOo2ryxlzxdcWEpz8gF+qBGKany3qDWUDYpMPm1hlg
	 Mf/0gE0aMVxanOTq5h8ZRUfZfSaNE18iNYhyjYZ6eN7MX4uhvmGs8tcU+/iREs0xIJ
	 2suEVJT/Zohh1uxAN+bYzygzh+4NAxKefhHkMhwy8jx6JoFBSw18P1CcWrRPtYXaHv
	 gOkzIfn91Tv1FQYfODodnZr585cwyD88QQ0hpeZw2Cs/ufL27tki0BJI537Kx67hpW
	 wm9uc46hmj3Sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC344608CA;
	Thu,  8 Oct 2026 12:52:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 354FD2B2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26F978122B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2jvqFDa368k for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 11:40:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 10678811D1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791459639;
 b=gBYg/CJ4hHvcyHcEl6gC+SUF6X0oYtNRDFMfkaypA9ASduEhqt5X78bv4D9KeiCHnvUN
 IVQv0h8gPS9dmEifwrTeXWr/eB0yEVp/2fTDDGGRULi8PNVLB5iJzvagHqoztoC9DBbTQ
 alANm2DyzF9HhpV6bRiQGzW2Zl7KbFyarOVNQtBUSP3GnCtMnV3/5fQRgUW5Ify2Kjmko
 JgjFgR3qDJbVKgk821l3QJ2d6jc6B8dYgOk+5KFOYagTPYt0qUFKBTntd9SGvQw0TTxSq
 ArMNojq8ymaWTKQ3RW7arKkuS4KXdNdZmfQzX7a8fPzG0qhQO2yGNbnekhFBDqT6wRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791459639;
 h=Received-SPF:DKIM-Signature:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=JTo4EBieiYswrx7zBBshLPY8NmoToaFaUaRgGWWtq9A=;
 b=nkWHfwB2meOXQbrk9HmMRHBhCUSfWaGdH0ikVoLbTWrXPFhEzW80RAglmvbwTucR7M6Y
 6liHDNbaptCtZP8hQnAHyCcTU4GlwTlyFib7WnQmPhfb/P3JnPJ5E8KuRjwStxNfg02Hx
 h/nmSo9FvP4acQhqDfURf+FGEcMBYh013e4x7bfS4sPgnjybnnn8f6TXZcLAUDTAlQhtM
 dAOGAHjquBDsAhm3ss8uC+pkODQAF4npX84zZ9HxxAvPQ2ArzZ0op9mohr5/MyztXeMxp
 0YpehgQ9IXx43MBa0f5z7XHEGpvCFgEbQat4uxYG2jb017yZVJJYNAEZd6jKNmdishQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=YUFiV3xn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=YUFiV3xn
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10678811D1
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791459602; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Eb5ef5pYRjejbZ/sxEpUwBUvhVnp8W5icWUrvRmleIuMN02NJnaq85Buqgzkbo8L3J08LmGwmELZ3S4ShD1qzFsGcbrgLX1h/aI1dbGXaOVj4JyXyqBEu8fEs2q5JvURPnkTkJcJnU+zZcP66nTia/cSBBorOARBPnNyEQavtow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791459602;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JTo4EBieiYswrx7zBBshLPY8NmoToaFaUaRgGWWtq9A=; 
 b=NxBA6kiXwe1zuWcJeNoelESTG342IXInreqAnZUxCM5GHHqIhkRmcyB6Sh7161IVI63uDRgINCRJ/wyIceb99J/JhsmPC2UMqJ+uC2mvzhYnZkW+9pw3OumIUrI+YwmsVTRnwNSaWmbI8h/vUJVpGGH5dTNiGU4ueeOPLNw19s0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791459602; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=JTo4EBieiYswrx7zBBshLPY8NmoToaFaUaRgGWWtq9A=;
 b=YUFiV3xn/c63AYui2msmH3951bChIT2Kk5dR86jBrA5vDmRFbyNwXlNNYDPZS1/W
 rtcxCTYtZX6FROY6ta7EsAGAW/Es+YK/gQzvIg6j/Xl6qXKBi3ejlX4RXG80+evI5tT
 /d/gMpjMbg3f+BWrw2Vzv0vnqOJCOfXD38BcJrx8=
Received: by smtp.zohomail.com with SMTPS id 17914595999731022.1288973748335; 
 Thu, 8 Oct 2026 04:39:59 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: [PATCH v4 0/3] rtc: cv1800b: Use the RTC node for time and system
 reset
Date: Thu, 08 Oct 2026 19:30:45 +0800
Message-Id: <20261008-cv18xx-rtc-sysreset-v4-0-62cebd76d440@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QTU7DMBAF4KtEXmNke/xbIcQ9EAvHmVJD0xTbi
 Vqq3h0n7QJQlk8af/M8F5IxRcxk01xIwinmOBxqkA8NCTt/eEcau5qJYEIzJxwNE7enE00l0Hz
 OCTMW2lquUQPTIC2pL48Jt/G0qK9vt5zH9gNDman7RMKvsa4rtzHS+ow0DH0fy6bxTKN1vmUKv
 RetBSk7JThwB84BQOiMZh7VTPWYs196bpqne01D+7j/nGg3DnQ85pLQ97QrmU6KMmq2WjoLqBz
 yl+9hN/Q+7h/r7mcyt93FXIZ0Xk4y8aXczHLGYPX3E69mYBYMCo2tcH/MhZzEb0avM6Iy2lgjr
 LVgJa4w8Jsx6wxUhjuplNl2Co39x1yv1x+Z/I1O9QEAAA==
X-Change-ID: 20260929-cv18xx-rtc-sysreset-b816e6306348
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexander Koch <akoch@initse.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@nabladev.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112273fba02e9dba0c0dbcfd5b08e0000d30c3f541ce190c44bee331bc80097276c6fddc25fcb172c17:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 08 Oct 2026 12:52:09 +0000
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

The CV1800B RTC subsystem contains a seconds counter and system reset
controls in a shared register range. U-Boot currently binds the system
reset driver from Milk-V Duo board code and accesses fixed MMIO addresses.
The upstream devicetrees describe this subsystem with an RTC node, but
U-Boot has no driver matching that node.

Add an RTC driver for the seconds counter, bind the existing system reset
driver as its child, and obtain the reset register range from the shared
devicetree node. Keep the existing reset requests unchanged, including
the warm-reset sequence currently used for SYSRESET_COLD.

This series depends on the CV18xx upstream-devicetree conversion sent
as v5.

Tested on Milk-V Duo, Milk-V Duo 256M and LicheeRV Nano.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
Changes in v4:
- Add Jingbao Qiu's copyright attribution to the RTC driver.
- Keep the RTC clock handle local to probe().
- Simplify MMIO regmap accesses in the RTC and sysreset paths.
- Link to v3: https://patch.msgid.link/20261007-cv18xx-rtc-sysreset-v3-0-194557fd5e78@zohomail.com

Changes in v3:
- Rename the RTC driver file to cv1800b.c to match the RTC directory
  convention.
- Align the CV1800B sysreset register and request-bit definitions.
- Use uppercase hexadecimal digits in the sysreset driver.
- Link to v2: https://patch.msgid.link/20261006-cv18xx-rtc-sysreset-v2-0-67872888384e@zohomail.com

Changes in v2:
- Use CV1800B consistently in the RTC driver filename and identifiers.
- Link to v1: https://patch.msgid.link/20261003-cv18xx-rtc-sysreset-v1-0-c0837e26eb29@zohomail.com

---
Zhuxu Ran (3):
      rtc: cv1800b: Add seconds counter support
      riscv: sophgo: Enable RTC-backed system reset
      sysreset: cv1800b: Use the RTC device node for register access

 board/sophgo/milkv_duo/board.c         |   5 --
 configs/milkv_duo_256m_defconfig       |   2 +
 configs/milkv_duo_defconfig            |   2 +
 configs/sipeed_licheerv_nano_defconfig |   2 +
 drivers/rtc/Kconfig                    |   9 +++
 drivers/rtc/Makefile                   |   1 +
 drivers/rtc/cv1800b.c                  | 110 +++++++++++++++++++++++++++++++++
 drivers/sysreset/Kconfig               |   6 +-
 drivers/sysreset/sysreset_cv1800b.c    |  80 ++++++++++++++----------
 9 files changed, 176 insertions(+), 41 deletions(-)
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
change-id: 20260929-cv18xx-rtc-sysreset-b816e6306348
prerequisite-message-id: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
prerequisite-patch-id: b8e6815314b7881a02de0066232864d522c4a26c
prerequisite-patch-id: 0df1fa5db1b2bff402b429809796bad99a517483
prerequisite-patch-id: 49e1e8263cf0a5ba8d63c8b598b6382cde5284b2
prerequisite-patch-id: 86dd30e784f022f0a7bb6fbf125c9699467176d4
prerequisite-patch-id: 49070c05ecf58331ec519a57d1b82f8b2b835a89
prerequisite-patch-id: 6b6881e45cc6de6544aaa4509db21611158f4fa1
prerequisite-patch-id: 7198127d4602eeb14212087ce9bb694d84e71a4c
prerequisite-patch-id: 3a58bd8a061707ff27b8538d4897def3b595dc36
prerequisite-patch-id: 9055ea941b73e35d1e825787d7eca14ffceb8e8b
prerequisite-patch-id: 554c1487e8d596e0099677ca88eee0021b1ffbae

Best regards,
--  
Zhuxu Ran <zhuxu_ran@zohomail.com>

