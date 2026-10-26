Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6515A606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yged0R6b;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WBXL51lK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1EA080ABB;
	Mon, 26 Oct 2026 23:46:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bwC2qnEgqXBp; Mon, 26 Oct 2026 23:46:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E55B880BB8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058403;
	b=Mk/dTDndRMFo8Z0w63Z6Qh4P1VyUTiQRN4mF25fQQqmJm5moKT8EvO72Tykm7i8YQERE
	 6HV/E4mJ1Pld0g7/nlkr84l79BxVNn1/mLrQbHmMmX3V04DTzWx0h1K0GIVeXRpp9Ia8M
	 /uiPYXbsH5rmar3CoMBCATcKBRn6d6KvjedVWprrL8dMeBSqrNh0L5wOEqU+rEx4RPsOE
	 yHs03mfpou4LeN25VgC8YqZuQMbhdiP1du0N+Tfz0poVl5ICiz8jHDiCJpNrdVevAvzoM
	 m974rQkmrk4hKcRFI60Jq9tnwlXERjPR0fJl3eLqWg9TIXXaDhv5rnBY33ysCzqXKcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3XnOpZ1A5ajjeuT7LLk2nhUP0BXNDRovOmoy/NSGRw0=;
	b=Lzt1yHiSAk1IO2gFA9FOeq4TGa7KS9E6AZk4/vlPa6xCGbMovZM+uT9cokzoyN6uubTd
	 gl6rY9ZXOY6RiJcsygL5sZg61cowPCqJ4FJ/YqeOzKa7ByiYItlFbFqzL5XetwOh2lwKl
	 Y6i0EoYov5pFddHiSN3p5tYm3+V5OlqLhAeQH+QEdUfe1tSQ7uuzoF5dvfxqfOmJSS0Ql
	 dN2A1EZ4focGuJgy6Hlfqjp7YyFWJVXomRT7gd5FKQn+V7IaYHKVnlBoTK3MXhlRXN4XQ
	 g39cz6o1FizVo5Jn7aGjPYZgN9BFm13G+L4DlTh9VDug72GlPSKC5ZmWCB+rn0mGjRw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058403;
	bh=3XnOpZ1A5ajjeuT7LLk2nhUP0BXNDRovOmoy/NSGRw0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yged0R6bZEy2yk/G9EIMNb16Dh8d8Bw9UtXz95OOy6/c/NrcWbGBuHpAACj/yqWyK
	 XbgJHKQ1UlTwVzoZtMh4CCE1TJdlWlcRQDfHXkG8Wds4tiKij5BwcHXuZNvAG+FvZ6
	 XT3cWhZD0V+LIjuM2t0Yb+hjC+4OPibazy+DblMSNRE4D28oufVn90hjpAUphVEVHU
	 mVF9PVGsbrsyPubcfc99S0NtDSIAzCumVHHA+F48wbyroheTSWuBjajMVqZQN0axFF
	 Z3sHiwwRzjhIGihS1y98Qm1VpMLpYqewmYJxBrGkjrNfYBOZz3EotopzC8f8ZcJlwd
	 hnZUdWjYFZ1Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E55B880BB8;
	Mon, 26 Oct 2026 23:46:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 56E9B3421
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 490594050E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66GyNCOqFC4w for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:46:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 655914050C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058400;
 b=RN5ra3wGUN3iDM1n3DD3nkR60HbQ/eqmwQLq3VN6BQtFI1dfwlIaddtnXWk3fE3Wc1B6
 6p0YZTxho2ij7D9NDLJ8k+75TtX3LKS9XHo6NJTA7yJ/QaRvYs89lqUAgrmzJHL4pOgx/
 U8pa25TW2x2jYZ60kzhKzhmYgVaVGn8Zdr+Ax0Zwvd80MUO8jLSbg1g2rRFYTajhwNng7
 t4rE4wrzkAgV9cLpAzXxfvcoJ7VztrQVzDqCLgAx37/n1YD7QB02CnpKdW6ahblNGs8r6
 k7Us/YUC1r0BmuvoiwaDbmggnbkCIw4AT45P+wbgc2WotbZhsfobJlzdINhUqTLQjxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058400;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=3XnOpZ1A5ajjeuT7LLk2nhUP0BXNDRovOmoy/NSGRw0=;
 b=QpWRzpZpZD7zfwJb8cgay2Ti7h1uxOQ0BSwULAH8ROzr5VTWlaLBLnYZxl9mYuBjDlVU
 7kkQpTNthX/88eOyDvqZSQakf0bPPUG609luMPaj2BRtyOD6PiAgdFud9jSZyzT69aFeg
 cTRkSjQ7QOIYHjopEbdo5D/LE10mRpvy6YtMxphptTulY+iDGlI1CsGogRN4B8+kFN8W1
 FP1YK34V6PZvpI1BG7TFAs3iiFBga1+0/K4BF6atp7NA9jwyyJdVtU5i0jCG+p/L2gLhq
 J3f+r4fT+xocDyLn+QmpWQ61OYssZ+QGLIa3FFXZpOzInvrtFzke95ffwYRIPobXd4Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WBXL51lK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WBXL51lK
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 655914050C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:39 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-8241a56cd70so2314877a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058399; x=1793663199;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3XnOpZ1A5ajjeuT7LLk2nhUP0BXNDRovOmoy/NSGRw0=;
 b=WBXL51lKUF2Elb6L9k3y0KEta+Bi5qwlUfLEC9JVY1G4m+vxV3cwYSQAbViXVzXz+C
 AypQa7a8p8xIU+PZ5jmTkLEchnStkS+ECwSl5aPRzrwVvmhsKks1Hpc+GV6TBwVPj3jk
 O0csJx+Fk0Jjw1KUVI0+6ILsgBfyRWiKvZhhgy1tXTxdzlZCIgYrf2YABrDYQ9UJZbZ7
 mWdctGu+WAQQswuipNJUxVQiQJnWIqb7gL+ZFC8Dch8SezJa8ZE/ZpZaprkEF0VzO4b2
 9dYQ/h2Say9+ibqKjFxsK+qg58A9mmS1eeceuIcO5+YMsNIQPdK+krMYhy8JkYQZaoTJ
 EGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058399; x=1793663199;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3XnOpZ1A5ajjeuT7LLk2nhUP0BXNDRovOmoy/NSGRw0=;
 b=QXImFJ5AZT1q0yTeuTF2iHPqzxxsf/GNvpnpAF6SQTiPKCRwXqWvqOmd+68igjqBEE
 DdHrwYEMd0quunad9dooo5wM369CgxmN9TqRPhCnlbEUfKVN9+C07U+TOTWA7VphZyw7
 7sOKiAyWoHsFR9EL9/Wlvj86b7xP/OD1XoKmed0c/6S0RQKOzkoIouJN9JlFplKnq5D5
 rehCPbTqPXsHCEN3bYTKm9JoEwzpf8+5uTg2q/2APh9DkSh2Hlnra/xpFQwRT30QqglK
 FIRDBXDXEaw1GuZOVbQIxFzy59Wd7hy3SYl+94/bDvaOSFZvj0OKHVV4miK+Vjh21zY3
 B+Yw==
X-Gm-Message-State: AFq9FYIbVwHP/z0uj4ugZgpvSYuy2ZXgc1Dvn7IZaDY63V8osCFSsbe5
 zfI1qhATIRPV8Wxszv10dJTqPGCTXkhfstiqG7UYG73/hod815LorBqq
X-Gm-Gg: AYBFou3574qrGMjABh9CbYWS2pGhnNghMkyGOfs2+kyfqc+BoI9LW9tHalDpiThfd/n
 ewwoiAETsOuXp2OoxE7DzLUpHCT91SGMxM0X5Rw+jnHbrBOkzl9SqUYmfhmKBDINazB67yV1sOS
 mQEekwD9WpsG7pDiHS3RyiGeSjKPRLqns5C0u8ac9RnPU4gWjakZtcuzjrMaZvyvYkz4alNmXCa
 +9bWFzR9eqlM3Z6wB2kpRQZeKpT6y090FTya6MzMD1A9qPvawdVv2UOEwfzBuUbFcm5Ohcnw5l9
 KPs00TxKC96cX000+x4dZqxrlB3rkEk99i54/uCexVMR0a4P4DohOcULbVhxP/tpARnC3x27RX2
 gaA4FLkHuQRk3igbK5NcNQqwm2RaIer3eq5kw8jjpXEnpkBpe4gukegg1Adwo001Rp8plppm6Os
 Rn7nU84aicJL49RPbjM5D4v1xeGtoWXgmO7d9GETEeTTOjR0zBk0OpaNDnTj8bmho7H9iZdYOe8
 3wNFykpOPqeHco+CcC4PkR6s5itZiA0pMCb+VZRohVNxl1exVkRoIiOz0va20/La8cB/oVF4uqr
 g0ldHxLJFW3Y4pm5EKQkykq/+z9RAVmANsA9BM/DZC6H8HeVeL5qoSvZYU/JylQHVsHbzSInsGi
 hEgR2Dyy+dPcCYalQakZTEXRQ6fb1c3YMWDhVUrhpX1yliTaf63XzDA4TW5GaG4RunSCLPhdg8Q
 F47KY=
X-Received: by 2002:a05:6830:3489:b0:81c:37e2:2008 with SMTP id
 46e09a7af769-850fe01b8d0mr6979052a34.14.1793058398800; 
 Mon, 26 Oct 2026 16:46:38 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc005bd7sm9509137a34.24.2026.10.26.16.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 16:46:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/9] net: sunxi: support AC200/AC300 PHYs and H616 EMAC1
Date: Mon, 26 Oct 2026 17:46:32 -0600
Message-Id: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNTQ6CMBBA4auQWTtJf6JGr2JclHaQMVKaDmIN4
 e4UXb7N9xYQykwC12aBTDMLj7GGPjTgexcfhBxqg1HmpJU5orzbgScsafxQFnS+KIWU+i8OjuO
 LI+Gsse3I2hDOVtkLVCtl6rj8Prf7vyv0JD/tOKzrBmcR2k+JAAAA
X-Change-ID: 20261025-submit-xpowers-acx00-ephy-mainline-v1-bfe33dd73039
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, kongchen <3305708832@qq.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Port the mainline Linux AC200/AC300 PHY initialization to U-Boot using
the Ethernet PHY package bindings. Keep the shared link-side tuning
separate from AC200's I2C register provider and AC300's secondary MDIO
control interface. Resolve the package variant from its configuration
cell before accessing either control path.

Require the described clocks and supplies, apply the calibration and
MII/RMII settings, and propagate initialization failures to the MAC.
Keep the RMII reference clock running between network commands so the
MAC can reset before restarting the PHY.

Add H616 EMAC1 match data for its syscon control register and expose the
EMAC1 and I2C3 pinmux functions. These let the MAC bind to its dedicated
compatible, select the RMII pins and configure the AC200 control bus
through the device tree.

The preparation patches preserve PHY setup errors, release the MDIO bus
after failed PHY setup and add the H616 MAC and pinctrl support. Node-based
NVMEM lookup, an Allwinner SID provider and AC200 register access precede
the PHY driver.

Based on U-Boot main at b0da72e3e8e7, with no external prerequisites.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (8):
      net: phy: check the first status read when resetting a PHY
      net: sun8i-emac: propagate MDIO and PHY setup errors
      pinctrl: sunxi: add H616 I2C3 function
      net: sun8i-emac: add H616 EMAC1 support
      nvmem: add node-based cell lookup helpers
      misc: add Allwinner SID NVMEM provider
      misc: add X-Powers AC200 register provider
      net: phy: add X-Powers AC200/AC300 Ethernet PHY support

Richard Genoud (1):
      pinctrl: sunxi: add the H616 EMAC1 function

 MAINTAINERS                           |   8 +
 drivers/misc/Kconfig                  |  19 ++
 drivers/misc/Makefile                 |   2 +
 drivers/misc/nvmem.c                  |  36 ++-
 drivers/misc/sunxi_sid.c              | 118 +++++++++
 drivers/misc/xpowers-ac200.c          | 148 +++++++++++
 drivers/net/phy/Kconfig               |  10 +
 drivers/net/phy/Makefile              |   1 +
 drivers/net/phy/phy.c                 |  18 +-
 drivers/net/phy/xpowers/Makefile      |   2 +
 drivers/net/phy/xpowers/ac200.c       | 150 +++++++++++
 drivers/net/phy/xpowers/ac300.c       | 252 ++++++++++++++++++
 drivers/net/phy/xpowers/acx00.c       | 485 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/xpowers/acx00.h       |  40 +++
 drivers/net/sun8i_emac.c              |  43 ++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c |   2 +
 include/nvmem.h                       |  41 +++
 include/xpowers-ac200.h               |  34 +++
 18 files changed, 1378 insertions(+), 31 deletions(-)
---
base-commit: b0da72e3e8e77e36c29a5f3fecc04c47764031bf
change-id: 20261025-submit-xpowers-acx00-ephy-mainline-v1-bfe33dd73039

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

