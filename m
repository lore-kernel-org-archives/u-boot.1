Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AF606A327
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zVtiXm3w;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=p11FeBqL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC230607D2;
	Wed, 25 Nov 2026 11:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ezrl4HVo6v3b; Wed, 25 Nov 2026 11:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B289D606D6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795606252;
	b=qhc2LVWIjzUThNZCYBHdffcMhdo8tUPdJc0R+P9k4mK20NzEVmDoszeCLwYuRqFFG9p6
	 uFVUs8gwJEuYEZ94bltiWjtSxnwlzLY2Gl2o/4q1mwyr3c9HMUwMUJTWOIIpz/RVAFxCP
	 02FNNKirpM44foWVX2shRPqXdP7QBqC1nD9ZdKBIbVg1SYHCGohJDroai9UZ1I0qjSje7
	 1RkC7hKgvJc2YLYoe84zHBsFy4l+qnWKQXTgTRHFiJJnS5AQ6eBiq3BzUB8I2J/CmCzUZ
	 0zGW4gGQSbs6THIgjmiCveT0iUtaW8/6QW635LGtjl1218EimtYXVkN0DxIGWf9GwZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795606252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xrDVsap9GjNlKNQpqSa6Tah4F3zE8uk5sWYCmtJ9iOk=;
	b=PDCuHE3SCSpGOd+b3q6R9P+VUZr5Kq2Rx1MxhrT8LR5z0+Ivxyy0yezPG0H+B48eNX+O
	 SJEiaPpZTGwRtrOic8mTPQJIc7i6qshohEs+BFUCv0+vGVLr37Y7JjBxC73YiTbbHhDKP
	 vLl/6hGp11o+q8qIMBnZiHRzlfMceNNMexTRVod7B4ziwohhacM0yHBNmYpEF1IESpnC1
	 uqEUWZHgeJFw74X7SwSZq6KcBjc5xGAnifeyNbcaZ6i4ZSQ3cUZTVCgb9qoGlySpJR+zg
	 XH8Y7vl2rbQ1oeE7OSARE494IR8j+FkScKQ0hPYuszKLvfPCrGqV/IktsrD777ljlmA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795606252;
	bh=xrDVsap9GjNlKNQpqSa6Tah4F3zE8uk5sWYCmtJ9iOk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zVtiXm3wi0kQLBNuF/1O4/qVJpB85vDvVK8Br7NA0juPVImVV3l5Ey0qdIija5+tv
	 AaEzEdiE29SzDx0+UF/8jullbECmTawJxOGOu2FUCoMFOBa00mVlXcDpKXa7Lq9mZ7
	 IT95TDwVx5Lr7rct487wi4EAJ801N1xeyPOW4T/OB/eVJrr1OmmkAk7wetGI7ltFVv
	 ojzahU5BMivyOoKqzW5bSMDJb5eJZbeMzcf805MPi9v718jyzrLI7kvhzxQC5HT56V
	 TaQZ7Me8n3PqxjG+a4Kfo4EY/z6/fnJYf8RebGGDhfD55Tspstp3cTHDfx+C3LdGQq
	 PEFR7AwL50nMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B289D606D6;
	Wed, 25 Nov 2026 11:30:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7507C311
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66A1B80CA8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TiWJaiNpmEgx for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:30:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E752807F8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=jpanis@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=p11FeBqL
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E752807F8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:48 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so4627340f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795606247; x=1796211047;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xrDVsap9GjNlKNQpqSa6Tah4F3zE8uk5sWYCmtJ9iOk=;
 b=p11FeBqLv+W5Qf9NtbIM6fZoq6jDbzLIVaUs5H0CqoglzmhnWbc/DeFbyCEFPz08Mo
 jXirBnBq6/KNkSWKRvPy0gISRKqi1UiRz2N8pXso0UJdwJ2S5miD4jT8MTjEUQ88TxV2
 h3Tj724KPjoGIp0xoRN08YhCBy4/Y+Bhgp4H19kiCQT42ec3PV5UVboaQcbJlh7bzO2b
 bpKk/jSGQNeiaFuEdqFDYnii/L23fKKMnxzt2Rdpm2kGyr5Z2SDC4bCQMEmmeosCI/2p
 MuHSBXilBUA/thjUEIoNFl3h7w6CmYSahbd1sfLCBszUbk/YpkSHCEhDe8XjB2x/tBGy
 mL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606247; x=1796211047;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xrDVsap9GjNlKNQpqSa6Tah4F3zE8uk5sWYCmtJ9iOk=;
 b=WXDl8QX/6RiAXpk9+mp9potPgghqFODG5F8ExXtb9/Dd8Q01MvUphk7a1oivVXdILw
 3xoGm4RYZ624K4qFrsH+TmGpzm7U7c2VWxujmZPyFmh0Wg2ptW/HGmMRWJRY4O4YFjZV
 F+TN0zXVO/6dx0gheRQd+TiqwYOkqp5ZtoKCFB7YPl22kx90WXc72vNOEVOVinS18ZFA
 /17xu5vCPHl5bpkghJtxzjlmpfxWqklxEz30rrHGid/Os5lzxBOFP2uv8jJR7A+HPdTh
 sObcI0ov4JFPqQp7yL7uTDkn92ohWCSwubpxlTSReQfSw9sgqf8/Zoaakxt0vCLK4nZJ
 Jquw==
X-Gm-Message-State: APuU4Z+0+QOXiUQhsrwfJ/Xi2kzvmCZmSh3M+jGVnDfo5SI7XxkrugSI
 3GUypeg62qNRTMKOKmVGp1jyyCSTe/Z+7y0p+5Nfqo3BP9NgPxJqFskj6ZX+znAADh4=
X-Gm-Gg: AZFdTZf+lk2a8ROcVw8hKTSwJyCbo1X0me8PSD0RhVxdXgRetSeWdQxfS/o58/LKZEc
 VHh6+yUP815WxX02ync3gVuQxDqaKT+OmQkE2f8Sl66yO1vV+LhVZIPQsIjTsOVq/K+u6lgoGuX
 HaHUQSJA9WUCL8zsga8f/6D2uk/+PbAKNSttMu7QomRPYKLK5jFn50UnpyTNSvefbObKPJctxzq
 qIM2RjobJfNVIVFXrOcFKyPrWYJLgQdJdA37UPLWOFCQk//ZaufE3LY7tU6wqIs4q+bFgr/tWIm
 VSpeOn/I8sXDfu5fkgLpbKZOGrPoV8DLWu0PfT2DjHUH+2VFBadNuPNM4wD3p/JiXRQj+4XLh5x
 7qjrtKeOxxB6aw+/a4HG2l4hdiBpGzDnXkqqHik8iH1VTh2+Ed4F99LsRHczwWSIWaGTZbx4n5l
 QoIFjwCAn6BWn6QVlBkAxvihP+E9YL/zXlP+Sxw//xf4hbsjqsGQDvIXt99HUf1IW1gJnZPtEJi
 VsnVJyxF+xV29zPjzOL5aHkf+PIkybP3tL8f1lDY9OoPd/Y3N7/XhMNyvH8GIo/TrvuTj93tXSZ
 NjeefQMzOAmNnWJIMtAnvZamoQjEx3p/je0d7svdn9JMM6Jm5tdzz26k7Em4FLhRr6reA4695zM
 0hKDX2uIl3QtEiuRq
X-Received: by 2002:a05:6000:470e:b0:4aa:323a:d7b7 with SMTP id
 ffacd0b85a97d-4abb16e310bmr33985016f8f.23.1795606246854; 
 Wed, 25 Nov 2026 03:30:46 -0800 (PST)
Received: from [127.0.1.1]
 (2a02-842a-aa82-f701-cd04-e538-7ddd-cfa8.rev.sfr.net.
 [2a02:842a:aa82:f701:cd04:e538:7ddd:cfa8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm39870905f8f.21.2026.11.25.03.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:30:46 -0800 (PST)
From: "Julien Panis (TI)" <jpanis@baylibre.com>
Subject: [PATCH v3 0/7] arm: dts: am43xx: Switch to OF_UPSTREAM
Date: Wed, 25 Nov 2026 12:30:27 +0100
Message-Id: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-0-7f5c72c1116b@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANPGBmsC/52OwW7CMAxAfwXlPE9x2tKO0/5j2iFxXQiiTZekE
 Qj135fAxCSO3Pwsy+9dRWBvOYjd5io8JxusmzJUbxtBBz3tGWyfWSiptrJTLaQyAUqY+Bwhutk
 S6LFuwA3LHKJnPRbOCA9uDTVo2po0scifZ8+DPd+sX993Dos5MsWi+rvw/LPknPh/drAhOn+5t
 SYs23vWh6xeykoIEuqWkbZVj11Hn0ZfTtZ4fic3iqJM6qFBlPVrGpU1uRK5N6bBQT9p1nX9BUl
 VvVKHAQAA
To: u-boot@lists.u-boot-project.org
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 "Julien Panis (TI)" <jpanis@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Andrew F. Davis" <afd@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Nikita Kiryanov <nikita@compulab.co.il>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795606245; l=3714;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=JZ8l7tY3Y5G+8Cy6ASoU0X3syprNg+xpCwFXQawWmqA=;
 b=UaT3bS36pK3N/oVfqeBQFe873NUdAVUVtgTNb2v8pZ8U9bD6iVoZE6xd1PF44nWhzPMnD2bEd
 SWR2QJQvLA+DFDwNt1dRpEVRgwkltIEzCCHdn1MCfdlU3YBGjYFzfSy
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

this series does the final changes to switch on OF_UPSTREAM on am43xx.
Mainly it adds some -u-boot.dtsi files to define tick-timer and other
necessary pieces. It changes the defconfigs and removes the old
devicetrees.

This series does not have any dependencies that are not merged.

It was tested on am437x industrial EVM with mmc. Help testing is
appreciated.

Best,
Markus / Julien

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Signed-off-by: Julien Panis (TI) <jpanis@baylibre.com>
---
Changes in v3:
- Disable mmc3 in GP and SK board u-boot overrides.
  This change is folded into the switch commit.
- Link to v2: https://lore.kernel.org/r/20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com

Changes in v2:
- Rebased, all dependencies were merged
- Add patch to remove the generic devicetree because of a missing
  upstream one. This broke the build in v1 as I had a temporary
  workaround still in place uncommitted.
- Add patch enabling PHANDLE_CHECK_SEQ
- Add patch to use usb aliases
- Add bootph-some-ram to device nodes to be able to read EEPROM early
- Link to v1: https://patch.msgid.link/20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: "Andrew F. Davis" <afd@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Nikita Kiryanov <nikita@compulab.co.il>

---
Markus Schneider-Pargmann (TI) (7):
      board: ti: am43xx: Remove am4372-generic devicetree
      arm: dts: am43xx: Add missing board u-boot.dtsi files
      arm: dts: am4372-u-boot.dtsi: Add tick-timer
      configs: am43xx: Enable PHANDLE_CHECK_SEQ
      board: ti: am43xx: Use aliases for USB controllers
      configs: am43xx: Switch to upstream devicetree
      arm: dts: am43xx: Remove local devicetrees for migrated boards

 arch/arm/dts/Makefile                     |    5 -
 arch/arm/dts/am4372-generic-u-boot.dtsi   |   16 -
 arch/arm/dts/am4372-generic.dts           |   23 -
 arch/arm/dts/am4372-u-boot.dtsi           |   72 ++-
 arch/arm/dts/am4372.dtsi                  | 1006 -----------------------------
 arch/arm/dts/am437x-cm-t43-u-boot.dtsi    |   21 +
 arch/arm/dts/am437x-cm-t43.dts            |  420 ------------
 arch/arm/dts/am437x-gp-evm-u-boot.dtsi    |   13 +-
 arch/arm/dts/am437x-gp-evm.dts            |  798 -----------------------
 arch/arm/dts/am437x-idk-evm.dts           |  420 ------------
 arch/arm/dts/am437x-sk-evm-u-boot.dtsi    |    5 +
 arch/arm/dts/am437x-sk-evm.dts            |  710 --------------------
 arch/arm/dts/am43x-epos-evm-u-boot.dtsi   |   21 +
 arch/arm/dts/am43x-epos-evm.dts           |  803 -----------------------
 arch/arm/dts/am43xx-clocks.dtsi           |  754 ---------------------
 board/ti/am43xx/board.c                   |   10 +-
 configs/am43xx_evm_defconfig              |   23 +-
 configs/am43xx_evm_qspiboot_defconfig     |   15 +-
 configs/am43xx_evm_rtconly_defconfig      |   23 +-
 configs/am43xx_evm_usbhost_boot_defconfig |   23 +-
 configs/am43xx_hs_evm_defconfig           |   23 +-
 configs/am43xx_hs_evm_qspi_defconfig      |   15 +-
 configs/cm_t43_defconfig                  |   17 +-
 23 files changed, 242 insertions(+), 4994 deletions(-)
---
base-commit: 903c9578eeb36d72f087082da494c605ddaed3b2
change-id: 20260827-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-7bc51b74cace

Best regards,
-- 
Julien Panis (TI) <jpanis@baylibre.com>

