Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE00CCFA18
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 13:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB85783E85;
	Sat,  8 Nov 2025 14:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xc67SQv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A8D283E85; Sat,  8 Nov 2025 14:26:06 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B67283E61
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 14:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3e3dac349easo1032018fac.2
 for <u-boot@lists.denx.de>; Sat, 08 Nov 2025 05:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762608363; x=1763213163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/nd7GTFcnV30sH9d5oGZRPGwvKGh2hqrHzKv7Igxv0=;
 b=Xc67SQv/Bj8flz3jmj77aB94Db5kcFsXqkp2UZXw3nGkvH5JyK768kRYugWfWxu4Wc
 X9/reIqCiIOxxAZ9qlKXP8HLl64UxHv8w0EBf8C42SKUFs5SHJtCr6Hwrst/4IxOhUsI
 xr6AySXq23JcBHM0XHlsAlMWyYIMd0ZmhP/b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762608363; x=1763213163;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B/nd7GTFcnV30sH9d5oGZRPGwvKGh2hqrHzKv7Igxv0=;
 b=l6/r9+q24Uxlvoiqmh0H5z1hRbVHWPVQDHU6inIXb2y5FzPXw9o3ktlTh6VnF1XX7h
 t5+gIprx98XLGiKeVy0lR7RIRdWoWr38ZkC2e7mvSR1PLBr3lSJKxiESsO0pZJ3YBcO/
 D9eIGmfTk9h4gK3+0/wpQ1q4lcDvCj+ka0eOt50csdgw+KoeFoYwY1Jd9vVkvrKAtDSA
 VRZbWqCiEGmAX9xzLAsuZ7j1V3E1Zjz2q8L96spq+U8fw6MOWFQwlX8IEMqEFMnJHnBk
 Y7wSUUD3hnv3pNxz2h/kBFdHzRduYganJ9HofnTw6SbsLUY5lzx3XMbg3Zkwd/hgbL3V
 RE4g==
X-Gm-Message-State: AOJu0YxvV83FKp+zxCrxfw6dqQ/PdLLVIMU0f8h+/Ox3X5pp9Bg1R6BX
 rKK1dLymKjjNCoG/NtaOf0ofLdNy4o9qMXss6nbhEhmMO7OAwukeUKsQ9PEbGaOWTrgMPM8zRz3
 tggATSKE+OQ==
X-Gm-Gg: ASbGncudYqed0aKF6KbI7g4BWHVkU2RQSfTshPZo6oQGxgQQzJYvDcDTxxh3lA5gTDa
 4iHmDtkJtrZj1U8e/MkvH5ewiBmF3MEfN6e6fRpu0xpyY7fXNJhZgn3aSlOQfCN792Amhuzzu/E
 tkMLrJua+88w1QWH1jPe4de1QoR5LZsAO4LgA09VBuTvWlqfHtk+mP/U/yQYDYTmbvF7h3SOXZn
 pDbROo+5cOB+p3ykfQl3wFZBiWR9SWxT9qA96IeDF7rk1xR/CmPlRq0o3s3zFqHzCaf1K7EPhYf
 1957L0XpQ1fhOjL8fBFgqn6sWym1cVvCkVA6YtAs+aV+Wo4Z3XzuyIhQJL1+RuFpHaUIL/SJOWx
 R21WiBjdsTBPlrhxgYwOCKomcDiRTUv7xp+r+fsmMpGUPfBieco1y7nwwvXj8UcqtpZf1vP/t3P
 WV5jI9DatPxeqegAZ0FZpFymVIxY+Ix2D1ye1m4mwwHH+VWzdv
X-Google-Smtp-Source: AGHT+IE30uUVR/rMGwr/OGLQvL1aq3LcNnYDkt8Cwj619TtCwoXN4VzGgx5GbBfqe3gEDD1kQxmwsg==
X-Received: by 2002:a05:6870:3c0f:b0:3d2:5b03:f4a1 with SMTP id
 586e51a60fabf-3e7c2b9ec77mr1538402fac.42.1762608362995; 
 Sat, 08 Nov 2025 05:26:02 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41f13a512sm3581636fac.12.2025.11.08.05.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Nov 2025 05:26:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Bryan Brattlof <bb@ti.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Cc: Garrett Giordano <ggiordano@phytec.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Neha Malcom Francis <n-francis@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Santhosh Kumar K <s-k6@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Prasanth Babu Mantena <p-mantena@ti.com>, 
 Judith Mendez <jm@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dhruva Gole <d-gole@ti.com>, Andrew Davis <afd@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aashvij Shenai <a-shenai@ti.com>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20251103-am62xeeprom-v3-0-e390779c0fc5@baylibre.com>
References: <20251103-am62xeeprom-v3-0-e390779c0fc5@baylibre.com>
Subject: Re: [PATCH v3 0/4] board: ti: am62x: Add EEPROM support and
 refactor board detection
Message-Id: <176260836097.3710933.12569013432017170226.b4-ty@konsulko.com>
Date: Sat, 08 Nov 2025 07:26:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 03 Nov 2025 19:40:01 +0100, Guillaume La Roque (TI.com) wrote:

> This series adds EEPROM board detection support for AM62x and refactors
> the board detection code across AM6x family boards to eliminate code
> duplication.
> 
> The series introduces two new generic functions for AM6x boards:
> - do_board_detect_am6(): Reads the on-board EEPROM with fallback logic
>   to alternate I2C addresses
> - setup_serial_am6(): Sets up the serial number environment variable
>   from EEPROM data
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] board: ti: common: Add generic AM6x board detection functions
      commit: 46684bb0369879413015c93c61998ff2986e0617
[2/4] board: am62x: Add support for reading eeprom data
      commit: ff1b83c095c2b96b6092099180d9a563702ee256
[3/4] board: am64x: Use generic AM6x board detection functions
      commit: ce56e553c31377b9cda7c53e2161c8e02071fc4e
[4/4] board: am65x: Use generic AM6x board detection function
      commit: 804b80288ac048f3c4403ddbb48f0944a3b5cc7e
-- 
Tom


