Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A601FD2D8F9
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 11:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF0983FFE;
	Tue, 27 Jan 2026 12:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="286uc978";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F3984019; Tue, 27 Jan 2026 12:04:22 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E45F83FD9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 12:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so17867105e9.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769511859; x=1770116659;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i2+snXLjUowmfrFshaDeZdmyX47CgES3P0bjJlQ9cHc=;
 b=286uc978s52lSeFzJE43NBLGJyQhyFWYI2OLbZ4PM/VkcpT8Uwfq/hwJ221WBPYils
 IZS3yxAvWxXRVUvmVOalhH5sdA3Xyt9wqj7BCJkKAHVztzJ2mU03FvTI+C14aF91tMiT
 2EtNPrlfOwK2OQCKILhQFn1vASoRdJklslAKkqQaAxiiAEGPfCbY/W8CdxVhsh5HgJ6g
 a6E86eTTBfgEC12OO8VrPmgkL8SyJV8Gq6mrK8s30/2gGswMlQVpBQjuG/c7usE8pim1
 iiwJCW//ZW1xCMGUXKEhYMmYl0PcN+VKwazsjwYPzW5hguxI9h8wIg+kJSkebEaRqpyr
 z+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511859; x=1770116659;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2+snXLjUowmfrFshaDeZdmyX47CgES3P0bjJlQ9cHc=;
 b=aORGu5l0Z8PTdOqPSYakqABXMuHersHq3fRgSYSnfaY5195Ghzf/6nPWr+IRuPQ2UW
 nDhG7L1CJBqR7jQI4I4hxUnMHufYlPRNrVWsq9HEQgRm5v6H9wu14mwzzDAvrXqG2TGk
 OiTqvA8ETD7p9VAXpONhrcCxfTNI9LVcNy4/ZuXN7k+o/Wtp/T4v+TEodEv2iOO+Dsdc
 hpuiO8U+mLZ+4TLHaUlLqlMleomVHvaLuqEv9uc9CNZNl+WZ//AXl9Lkl5r7ByLzdWLV
 9jzRrEYL1ELL2tjIdATygHbqFpSXutXFfmun3oSFbMhEWSiTCDVQcwLx8/H0ylCdo0Vr
 kgzw==
X-Gm-Message-State: AOJu0YyzgiDetR9HjmHOxC/3v+Ku+OF0urkWeUxj2L19jtD2fhWU5niD
 g1g3nPEvOof+ajMbPYHQscxuDGe3fJKLn7oXNFZs1YX/ElQxR+WalAZLuZHY0wBywcQ=
X-Gm-Gg: AZuq6aLH8SDfBZUhvu5yJHucZOtHx/bv75SmXv4mjrme72EOwEnTccZXZVxQKCG920N
 oBdAuVdBpJRGZU1wZQITeEUfz8BBSfJOt0iI90+jDbNHoBemA02TAxn6tpGiB8kiuETuIsAEiEo
 3lrnDZNrywvCUovNbdjSwHjLe08G3EcLehubetPpklxBzXoiauo6SAB5UPBjz01vDom6fgjlIlp
 0kIf5AaW/Fwdm4kegXrCqUMcZu+u+XqjYiVYzxA2GrhbskpUW71eaa8QgbIIeiy6pDGhuZGw5ol
 qgU7YIoh1vLf8ke1yvpdEs7HyxGQCvkvC9/ECOryqDt7VqPk6ydfTSWjY4TXpVfIhtQj7Td5QOZ
 3nvO1+FuzoriEFNq3ZSBdh/nCN5QQ54keCBIy5k7VLZPsHcR80nyl/87oEZQDBeuC/Hp7fvE3eO
 cpbTRHE7/Y
X-Received: by 2002:a05:600c:3b8e:b0:477:b642:9dc9 with SMTP id
 5b1f17b1804b1-48069c54c3bmr17627905e9.28.1769511859413; 
 Tue, 27 Jan 2026 03:04:19 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm36991609f8f.9.2026.01.27.03.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:04:18 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v4 0/7] dm: core: Support same compatible in host/gadget
 musb drivers
Date: Tue, 27 Jan 2026 12:03:34 +0100
Message-Id: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIabeGkC/33NwWoCMRDG8VeRnDslk8Rs1pPvUTxsshMdqJsl0
 VCRfXejIJRS9vj/Bn5zF4UyUxG7zV1kqlw4TS3Mx0aE0zAdCXhsLZRUW0S1hUuaOcD5WjzMOXm
 ejlDb0YJEQG10jNFhZ71owpwp8s9L/zq0PnG5pHx7Pav4XN+uXXUrgoTmji4Y16GWez/cvtln+
 gzpLJ50VW/OSpRunVONU4PpgiVJnR7+4fQvDs06pxtH3rux76Xvx/iHW5blAfCxZlRnAQAA
X-Change-ID: 20251125-topic-musb-probing-v2026-01-1343fff8176b
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551; i=msp@baylibre.com;
 h=from:subject:message-id; bh=3hYDL+r+Pb9OjIAqir5l9IlLifUqXU3myxsqLekSlxQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyK2d2Xbzmplkq8/tr7IVZoW87Pa6vUrfK0E2zPi4a3T
 ulae3FiRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExEwpSR4ffLLQHCjUzPoto8
 TC/0bf4SvuW1xFOONtVDoW1JT8XvWzL8d3eR0jyS+jB+zkJpY43mVL8XzWuTfZPeFKipniyb8cC
 cEQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Hi,

musb currently uses a wrapper driver that binds on the parent device of
the actual musb devices to manage the differentiation between gadget and
host modes. However in the upstream devicetree this parent devicetree
node can not be used to match the wrapper driver.

To be able to probe the musb devices in host/gadget mode directly, this
series introduces support for returning -ENODEV in bind functions
resulting in iterating the remaining drivers potentially binding to
other drivers that match the compatible.

It also changes the address parsing of musb-ctrl to be able to parse
relative addresses.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v4:
- Remove log message changes and push into separate patch as suggested
  by Mattijs
- Fix commit message as pointed out by Mattijs
- Link to v3: https://lore.kernel.org/r/20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com

Changes in v3:
- Add short paragraph about performance implications to the commit
  message
- Add a new line in the test
- Link to v2: https://lore.kernel.org/r/20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com

Changes in v2:
- Added a few patches to remove nearly unused variables
- Changed the inner loop in lists_bind_fdt to support set drv and not
  set entry->of_match.
- Cleanup the loop a bit more
- Link to v1: https://lore.kernel.org/r/20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com

---
Markus Schneider-Pargmann (TI) (1):
      dm: core: lists_bind_fdt: Indent continuation debug log message

Markus Schneider-Pargmann (TI.com) (6):
      dm: core: lists_bind_fdt: Remove unused variable
      dm: core: lists_bind_fdt: Replace found variable
      dm: core: Support multiple drivers with same compatibles
      test: dm: Add compatible multimatch test
      usb: musb-new: Relative ctrl_mod address parsing
      usb: musb-new: Add compatibles for ti,musb-am33xx

 arch/sandbox/dts/test.dts      |  4 +++
 drivers/core/lists.c           | 73 +++++++++++++++++++++---------------------
 drivers/usb/musb-new/ti-musb.c | 36 ++++++++++++++++++++-
 test/dm/core.c                 | 15 +++++++++
 test/dm/test-driver.c          | 26 +++++++++++++++
 5 files changed, 116 insertions(+), 38 deletions(-)
---
base-commit: aa4f687977a449686498236722ee5e93d8b39918
change-id: 20251125-topic-musb-probing-v2026-01-1343fff8176b

Best regards,
-- 
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

