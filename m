Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCBDC982C3
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 643CE4071F;
	Wed, 16 Sep 2026 13:08:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MeIw8P9oNxeS; Wed, 16 Sep 2026 13:08:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2FA03406BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564116;
	b=ogF+TYMlmHY0IV6MY3VO26NUduNS5AuTGpKj5yfl1FB+3NC5MQspLDcmZ14oQ2pwoPJX
	 bUmTiRegmRS7ifqCxGOmUqYx9k2iu1k+VS3Ygd2RW2XtkbObZ7ZXV+FLoQH8KgYRIGkKU
	 b6hvK9kuSl/92scC4TklgKQIlqNR4DJSYzzc8Cu/p4fXE/zKi2N4QxkuiPlFeMAT+19bh
	 WQCjBwN9/YMcEQQVqV1aDpgAX2gqlqhuhxZuvWqQfJ2Gtn/CRF47AcjUlaedLr69s3L4x
	 EOp85Wihip5j6V4P3JSuHBBqdiq0iiTlGzHzs0ispV1UlXwLvA1LiepvdLDofp3rPYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MPCUyRPhL1RR4HHBkHwKJ4RB/GsJ5mh2xVBl5+Q3To4=;
	b=fZ7IMTUWWTkDDgRgaXKsv3bfaPdG54mFb7UVyr7h/BWFZBCqV4KEDtEzGd07vklyFI7y
	 ZAI4iORGTcNCjXkW1KvxDnWDOdFnVTXyPgCyvfsMOxC4P2zsFSKXxTBFl1uNBC/ZArsmL
	 qQCHYEG3JD3KUJBtdLa082urmCFoNxjpW3BXnjYUPJTjhRcvWGkwJxpTVub871mvY1ANs
	 xx25FbPoDaEOp72CJ7IwI6oPAk1XLF2q1WOie9t2BG6JKNpdmDwO+z5mS4icGR5YfM0SQ
	 2gwLwzjVdkuAiSjE0pfDrWikgzhaVuVnXRkzcJMnaMPiATQadZKnrktGFKeT3dz8HoQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l413NkV+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564116;
	bh=MPCUyRPhL1RR4HHBkHwKJ4RB/GsJ5mh2xVBl5+Q3To4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LO3KBEwlu7OBvm+w2PU5j+uvbJ045mCIZoi8XFzaAMkZda/Jw7AyM95BmADYcz7Y1
	 TQXMLLqSTOPk3/1XfURQPJCu9vx2WQEZDS4qoGzckoJgt9GrA017eD0yVxDkbMElkH
	 PDHEyCKIIcH6ZYWsURcyOUq8ttGLUe78EhqQTmSsVOtBiXtsV4Fs977V3HPMP0YcYy
	 QpBSPCBtV5lyVLahDQWUJmUgS/+ydLYHHr2Q4L6/P42MyAFWEAW1RMO2IkmQxWEUv1
	 jANTrPr9TrgDeX5IpdNKKMHkwVrBq27G9QBI3estJN51mh5jDjK4Q+ybN/Zl8gWiEG
	 tWRM7jlBCQV0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FA03406BC;
	Wed, 16 Sep 2026 13:08:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 45B68DD7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37A8A406FB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q5-9U_oP5rZz for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:39:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CFC0D406EB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562354;
 b=V4x072poZE+vVuChVOLTDIXNBZWxA48oIyj3wYmBp3Yixt9bXg7UU9GA64Nsxb2jQw0n
 H18l/0U2BO3LYqQ+F0FENw6HBFNbFcTzAQFO7ZCYw5iWzUBK5skvuagc+RkP5YzCXqvzO
 bSeKmX0zJGq9oGux+Hny/luB4nzWBaCKKChV1vERMavyRCM0TwujFtctbG/Ct2zANo+Vm
 Qz0c+JoZrxsSsmg5Hm9i9L3DA9kwL+2MJ7r3t62ua6Ns+TkK/bHP3Jr5l22z5KafAlKYy
 VOxU2WHi3vZh59WZGE5XaVXnjsTFWaIjfj56PY6JnrDxEAWxvoESkXple/7APYKRa7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562354;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=MPCUyRPhL1RR4HHBkHwKJ4RB/GsJ5mh2xVBl5+Q3To4=;
 b=Tj0a5kt6x0Tdoo5tm23THFQpcLjtSq+r22TehhSxb2y287DHcbcrT6xxQbg2nDSJboTL
 FHvHcf0jg0iI079dX/l0an6HW2jzj1QZKT9nMTyQNA5XAxg8TBFAao4U5nphR6uXl1b49
 LE1+Oh3TnKb0xUqhTiWfocpG8ocKjeMdT5yyPn+/t3l3Gfw4vRd+j884LFZVbObTXlUUm
 3fmiDanWGFf4xOdzgMn6537kDItYuN7apokhxekKpXQw6y2dw8MwOwVuzOFtFb/XREM6P
 0Jql/fTC/ndATUYFqy3Oc/fQJARYLDLIHwo/SzBq1aMdIJv2M9OLGsnNMDImKH9F7/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=l413NkV+; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=l413NkV+
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CFC0D406EB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:13 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254c50ff6fso13553266b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562351; x=1790167151;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MPCUyRPhL1RR4HHBkHwKJ4RB/GsJ5mh2xVBl5+Q3To4=;
 b=l413NkV+S6sRqjTjcwrlIcv9aLHfvF6r6B/Q4Diyc4bQiklzMzVlK4IvlG4Dv6kYbG
 wO0cICrHKQXDQdLuZ9PZ9BR+2SlhRTlsg174GSwq6DJWGpvXlr7IMYF1u/5KurlvkGel
 47FAGcdahzQ86l7nLc05V3i2YJJPpklwwq3PAEcJQNCiJh9r9VIRl5Z+Dr0qY9YJMx5v
 efnKY0F8j0oIp7I4S8DG7tUZ3KdwehU6p9J8THLNQ0DK8Kz4radpKJDXQ02VaSGUjoh1
 DgeHg+GBwV0YY4Ldw1DpOx86+sehm5G++FBnPADTIMezo8cauUkIVQjyuD0Iz0d/uHFK
 UEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562351; x=1790167151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MPCUyRPhL1RR4HHBkHwKJ4RB/GsJ5mh2xVBl5+Q3To4=;
 b=J1HykllQsbCnvV7EEARl9MYzmuRfswi3K1ouB952fbg0mBtUJjtCay+OkhUlfkXjzl
 NMKCjZx3jQ9JkI8loSw1N/+iwwqCSBKtI9hq9R6XiE+vp9+ObDZPZ43qclYiT4yeWVaa
 4Go7OZJ4vvUIL85ai2tZAzlEUvM3qbTBYprcwKvIAeeEHPllFgOnEWMz1VMQwBRm0/EY
 kLHRaG+ZnYvffeC8Qg9BrQZP32XcjMjHRzMaRw8cB6IjseIXb/WasJKHp2HF/jLNBm2F
 Rckqt9njpJpDL4CP3TLaUUBbnyX57C2LUylPq33gZYxCPcJ/X0GlZUmg7KjYHQAQYvYD
 S2Aw==
X-Gm-Message-State: AFuF++mNDCWv3b4hyqsoPny7+fM+Eyqb3uvS4SHDC++QtqQ3jrmyWcOj
 azYrErwYR2+M9VrZueo1Zay5wJIB2ya6BjOA+Gn3sYznfqCYoZcgJjWgGMtut7ViwlDnZb8dgFt
 cFKk6
X-Gm-Gg: AYBFou0c4gcmv7TxAl5q3LSF0hBXeaESvN4CozwWPaSIHM4I629xfI5lBRkJI0mCTIm
 zeLN9gypSqxlmWwzdGskqEhxI3hSeX7kIshDrX6BBTohXTrPHUBBpEGhAaDr4y7QgVLvRXEigbj
 LNqY0hSlQSkW0O/cYhsLOiZcwcWPXhfy8QmX6Ov8DgzWJfqI8aEAXj80oMwMjJ4qqfc9h69EnKm
 2Zu1HqguZXKqZln0ip7mA2pfVbb+Dwb1bot60+u7kYZWfB+RSenfKuunNW2bN7KnkkcK+v1u3qQ
 O5Un46dxOH/3rQ6eAaCgfsWtR7BUg2kKPEIh9tHMG/vr+LLMS+c2we0sRx0PPn3eIBKjBJE8mS4
 hCKGQV1u1xK1XnfGR+A6dSDiLvXfWhzxd0nnWblwtBLdlpvY1aQG/LdtytXyJhPXRDnp2p2QiG5
 l5x/T6I71tS0DBpfnBeDlSk0wgkqyQPvxG4vfQJvYu7JPMMFHjxP9x1zHnFLqiUqpYt42mGrXmJ
 k5RTc0kpoQuFtrlCJaiezkl74UySHlS745hCzx7141OiQkmh6DRaD6w
X-Received: by 2002:a17:907:720b:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c29e4ee4e75mr186749966b.0.1789562351337; 
 Wed, 16 Sep 2026 05:39:11 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de086aa3sm136889166b.6.2026.09.16.05.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:39:10 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
Date: Wed, 16 Sep 2026 14:38:00 +0200
Message-ID: <20260916123826.517181-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

Hi,

This is part two of two. It applies on top of part one [5], which resets
the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
the build for every board that enables DWC3. This part adds back the
U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
builds and the gadget works again. It builds on Jerome's work [2].

The two parts have to go in together.

Part one is unchanged since v7, so I did not resend it. All 63 patches
there have a Reviewed-by from Mattijs.

The resynced epautoconf matches endpoints on their caps field instead of
on their name. Five UDC drivers never filled that in, so each one gets a
patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
and mtu3. With those and dwc2, every UDC driver in the tree sets caps.

Build tested one board per driver: every DWC3 glue layer in the tree,
dwc2 with and without DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc,
musb-new and mtu3. 17 boards in total.

DFU and ums are tested on hardware on BeagleBoard-X15. Anshul tested DFU
and ums on AM62p and BeaglePlay. ci_udc is tested on an i.MX93 board with
ums. Love tested v7 on AMD/Xilinx boards. The rest is build tested only.

One thing is still open. Anshul sees a single "unknown endpoint event 0"
line on AM62p during enumeration. It is there with and without the cache
patch, and the transfers work anyway. I do not see it on X15, and we do
not know yet if it is older than this series.

x86 builds again, but CI still fails on am335x_evm. The SPL does not fit
in SRAM anymore, it is 184 bytes too big. The resynced udc-core is bigger
and am335x_evm had almost no room left before this series. I would like
some input on how to handle it.

The branch has both parts [4].

[1] v5: https://lore.kernel.org/u-boot/20260716134305.614278-1-anders.roxell@linaro.org/
[2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
[3] dwc2 prep: https://lore.kernel.org/all/20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org/
[4] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v9
[5] part one: https://lore.kernel.org/u-boot/20260824152734.159794-1-anders.roxell@linaro.org/
    subject: [PATCH v7 00/63] usb: dwc3: part 1, reset and import from
    Linux v6.16
[6] v7 part two: https://lore.kernel.org/u-boot/20260824154133.217744-1-anders.roxell@linaro.org/
[7] v8 part two: https://lore.kernel.org/u-boot/20260909085015.2480097-1-anders.roxell@linaro.org/

v8 -> v9:
- New patch first in the series, "x86: asm: io.h: add rmb() and wmb()".
  v8 kept the two wmb() in dwc3 gadget.c, but x86 only had dmb() and
  mb(). So the x86 boards did not build and Marek's CI failed [7].
- "dm: add helpers needed by the resynced DWC3 code": picked up
  Reviewed-by from Mattijs.
- "usb: phy: add the usb_phy helpers needed by the resynced DWC3 code":
  picked up Reviewed-by from Mattijs. Added the blank line before the
  last return that he asked for.
- u-boot -> U-Boot in all commit messages. Mattijs pointed it out on two
  patches, and the same spelling was used in 8 more. Four subjects change
  because of this.
- Part one is untouched.

v7 -> v8:
- New patch, "usb: dwc3: gadget: flush and invalidate cache around
  transfers". The resync dropped the cache maintenance for the normal
  endpoints, so ums did not work. Anshul found it on AM62p and
  BeaglePlay, and we both tested the fix.
- "make gadget and ep0 build in u-boot" no longer comments out the two
  wmb() in dwc3 gadget.c. They come from the kernel import and the port
  had no reason to remove them.

Older changes are listed in v7 [6] and v5 [1].

Cheers,
Anders

Anders Roxell (26):
  x86: asm: io.h: add rmb() and wmb()
  dm: add helpers needed by the resynced DWC3 code
  usb: phy: add the usb_phy helpers needed by the resynced DWC3 code
  usb: gadget: adapt the gadget API after the resync
  usb: gadget: udc: make udc-core build in U-Boot
  usb: dwc3: make the core driver build in U-Boot
  usb: dwc3: bring back the samsung usb phy driver
  usb: dwc3: make gadget and ep0 build in U-Boot
  usb: gadget: udc: enable async callbacks on bind
  usb: dwc3: ep0: flush and invalidate cache around ep0 transfers
  usb: dwc3: gadget: flush and invalidate cache around transfers
  usb: dwc3: make the am62 glue build in U-Boot
  usb: gadget: ci_udc: move to the udc-core registration
  usb: gadget: ci_udc: set endpoint capabilities
  usb: gadget: dwc2_udc_otg: fix up after the resync
  usb: gadget: fix up the function drivers after the resync
  usb: gadget: fix up the last UDC drivers after the resync
  usb: gadget: atmel_usba_udc: set endpoint capabilities
  usb: gadget: at91_udc: register with udc-core
  usb: gadget: at91_udc: set endpoint capabilities
  usb: musb-new: fix up after the resync
  usb: musb-new: set endpoint capabilities
  usb: mtu3: fix up after the resync
  usb: mtu3: set endpoint capabilities
  usb: host: xhci: fix up after the resync
  usb: cdns3: fix up after the resync

 arch/x86/include/asm/io.h              |    2 +
 drivers/usb/cdns3/ep0.c                |    8 +-
 drivers/usb/dwc3/Makefile              |   16 +-
 drivers/usb/dwc3/core.c                | 1761 ++++++------------------
 drivers/usb/dwc3/core.h                |   39 +-
 drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
 drivers/usb/dwc3/dwc3-omap.c           |    2 -
 drivers/usb/dwc3/ep0.c                 |  117 +-
 drivers/usb/dwc3/gadget.c              |  724 ++--------
 drivers/usb/dwc3/gadget.h              |    4 +-
 drivers/usb/dwc3/io.h                  |   36 +-
 drivers/usb/dwc3/samsung_usb_phy.c     |   77 ++
 drivers/usb/dwc3/ti_usb_phy.c          |    2 -
 drivers/usb/gadget/at91_udc.c          |   83 +-
 drivers/usb/gadget/atmel_usba_udc.c    |  114 +-
 drivers/usb/gadget/ci_udc.c            |   86 +-
 drivers/usb/gadget/composite.c         |    2 +-
 drivers/usb/gadget/dwc2_udc_otg.c      |   86 +-
 drivers/usb/gadget/epautoconf.c        |    2 -
 drivers/usb/gadget/ether.c             |   21 +-
 drivers/usb/gadget/f_acm.c             |   20 +-
 drivers/usb/gadget/f_fastboot.c        |   10 +-
 drivers/usb/gadget/f_mass_storage.c    |    5 +-
 drivers/usb/gadget/f_rockusb.c         |   11 +-
 drivers/usb/gadget/f_sdp.c             |   12 +-
 drivers/usb/gadget/f_thor.c            |   19 +-
 drivers/usb/gadget/udc/Makefile        |    1 +
 drivers/usb/gadget/udc/udc-core.c      |  933 ++-----------
 drivers/usb/host/xhci-dwc3.c           |    4 +-
 drivers/usb/mtu3/mtu3_gadget.c         |   10 +
 drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
 drivers/usb/musb-new/musb_gadget.c     |   21 +-
 drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
 drivers/usb/musb-new/musb_uboot.c      |   39 -
 include/dm/device_compat.h             |   13 +
 include/dm/read.h                      |   51 +
 include/linux/compat.h                 |   15 +
 include/linux/usb/ch9.h                |   25 +-
 include/linux/usb/gadget.h             |  529 ++-----
 include/linux/usb/phy.h                |   57 +
 40 files changed, 1416 insertions(+), 4005 deletions(-)
 create mode 100644 drivers/usb/dwc3/samsung_usb_phy.c

-- 
2.53.0

