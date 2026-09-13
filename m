Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40A7C88E56
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 04:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44CD680E97;
	Sun, 13 Sep 2026 04:23:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ip34wGcDKod0; Sun, 13 Sep 2026 04:23:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4762680E79
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789273406;
	b=Em8e3PeuBt+zgpMdUd3ADXm9sRUaX78KER+ikwByJGM5q37SizH9EVv5LvET9TVcI0i8
	 7yv1u6MQ7hsrWTyAbiBLav6TXREEDzD/Zi3BERT/CjiRcemGxPKFTfCEyjkOzDjGRQDBs
	 MvHJ7iVrLxfwx0/FkEljvZik01Mz0sBiJfQqWuEsTVk8dBx2faz30vhxmJ604K/TCYAsQ
	 iodGv0tdYURVSzIjf+XEibimTjkhxjfm9VOZr13Z93/luZ8G9icjQpCkTzKnPvMaoIbDl
	 DOPknAUjRXu3ycYYQAyNj3DaNYt+5gjP1w3q8zFodjUdCiDOSq5cDyKqP8qZyQpSwaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789273406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eJW6wZk9a/QPMwU6XvghvUGRwgl+2tauDdUT1A0z8Sk=;
	b=mxXYVVF3G9XhWQ0NmtSckoTmlAA5B0iDndVRpMCXpCshXZJgGqpqMpM5MPd9oLtQYd7c
	 QB7XkcYZzDjNz+SHxId6iFTXhnBm4+mb2lA7X7eoyaEATZ1zUDjdle83kixZzfDRLSisl
	 Pgjo3KV7IHjcj9SpazJvsXt9Xn740kpfykmGE83gw0Dhjqau+lvbqL1r+8oShORRN/31s
	 toq6M8O3oBQtKhT0HOYkfEXYEDi4Jwr3IwZTIy6gK3JFpARfEYIehVk71ym2QHN6BeYWn
	 AtSKpThnK67YuSNCCg/CD2fT/kczkzKHMTXRhnnYutb4VcN6+cBYtMt6IVvtViiFOkA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789273406;
	bh=eJW6wZk9a/QPMwU6XvghvUGRwgl+2tauDdUT1A0z8Sk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Wk6ZP+ArWgUEUmHUppmsydArHLdXVeeJ8qy+G+mlNRJ//W8+Tq/5VAApxbSq2HAFr
	 jpB+cv7d7XpsacCNF2pLkmIGwvF9DYhhFuAlVQUh8D8S3cN53E7OIFbwecQgJGCR6f
	 GSfRa/ae3tT4zyuswtk2tlVlIUltsetbFnImpa+6y5/1PRBWPIyhN9LiGxcV89VfGY
	 rNYFH/lHLbsPQOPx9w0HzpRN7v3em6GLPJgoh08CJRxjr3zuyebtE75JcQq6mmZ6/B
	 DMVCX3Lxv4WhTkZ/0DkJaVGwpbxztEnMqDodeNvMXXH0MtiO3y2Plxx3J6UQanW+2c
	 vS9oH+C6gUuXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4762680E79;
	Sun, 13 Sep 2026 04:23:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 39E6E109
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 202136060C
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lLeq3ZdROO4S for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 04:23:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B413160604
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789273403;
 b=pqNj+ZPIOReJrpA56y5jItwpTkMlgwgCAGpCkxc6AmXes/YSW0vmR6wnCJ8Bwck6LfqD
 jtMu44c5Ul4xRMs/N3L83TlGkgW3LjQ8QJ5KT0w9kNE3C0+kDOS/AS0If3Sop2NTsepxz
 miDiboAp4tYrJp+nnlXYWMOHmhqk1MqpExIiz2hYXXZMartWUpc4A8g1y1rX3w4aZOdtx
 Wr1jZhhheK8Mjk4ReuJyuI3BtZNhnGNNMbk0Ciau/lOpBJZgLd9sijyb0cXthIYN1jgrh
 79P3iLK50V+Lo6QQCmVoxCg7vmq6Uc9HUUhVAWx7V87qo+lHgoPPwKG6CNtlmIrz+bA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789273403;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=eJW6wZk9a/QPMwU6XvghvUGRwgl+2tauDdUT1A0z8Sk=;
 b=TWzhvgeeif4VCEvHa1Hw9StWFP/SUGLr3pKgVlSWqL+XURMM1SGrS2MmChOozekCDmYL
 fEVINh3pRAX1jjc6pfpYaFjIkXUsaZba26AYgpuMlxD0U4IJbjf+euU2PHIz2MrmzLIdz
 fcqEBODNX1QCj6CdniZebfCDIqfadWWK8ZrhkXN3IlqTXNvGUDn2DrPHKMYOQriCpKW9I
 XyhdBLYed2i5bMBwH9F3xmgB12+aoy6/1kdq9/YhtYN0+63bUUc3p3bAThB0tZ1bX6Xfj
 AmU/2RHLjbbFgTFeZnH/goP6th4et87bpNbPuGbgjsToMWU1304Jaf+ZjOstZdDwacA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=HnC5A2uD; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=HnC5A2uD
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B413160604
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:22 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-398b1e63c49so2797656a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 21:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789273402; x=1789878202;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eJW6wZk9a/QPMwU6XvghvUGRwgl+2tauDdUT1A0z8Sk=;
 b=HnC5A2uDXsyo/2H7ImqbI4RJ6G0L6SCh0Pl+3I2GZk0XPWfJBiO/xyBs6r3kUYjcoy
 rouNp3yRhB5U07/SYOfGtVa87EQHM5mRdPn1m4zSOUkZCsLdP2+McAGDh42jUF5z2OBN
 EHQXAPcyjNQkSAmDwokpZI1u/oWf0FWFj4tNQrI5ahOPpv1Et7cTrmtT5aDnI+b5lUvo
 BZ+6jC58EFUhGebKHAO2OkGTJ4Iqe03AdtcyN6fRRHSF74Wz3AwCdTFufyEc0kmGKBTO
 WMxa3YYjXbrpMsHT59QsMrA7gTUAafp3AktTVv0Q2mFu+7H3J6yUIfvwLsX/FogCTdrQ
 e8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789273402; x=1789878202;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eJW6wZk9a/QPMwU6XvghvUGRwgl+2tauDdUT1A0z8Sk=;
 b=AKge6xeNLlmDF61q9Hic6MG5GkLmmnXc1P6I12LRk1d1RuDD3v9RROC6iNmvbEYOD2
 qg3EUTxvn1hihhbLDKL7EOeunpRvWhEEYO3+6bsUB42irm8CWCFo2CS2HSg4b7ZjOYfV
 UyP7Wkht/ZQNUcYKZrzG4/CqacNLOdWami587wZt2nKADk0h+DE40RHr6Q0Z53sT7s2o
 zDbgl17goBQIhUrYhGxLDGsKaZTVhWpYMlONwXYTT0tvvEYrmde1Zgg5eNqJNA0hxU9I
 AcaZTPUpTUy0JB+LSCYcMwuQn2AS5BAuPJqLJvW0beY3dD1GXwlkG1+IGKgsnHZNtu/S
 6GJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWAyZidfJkicGD4YYd8HjpR8fhdvvsGbgck4hcdorTjbqO4OhGTdEvDEfZDq8sIF/fV0K7Kn0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mWxp3PfW6gkZVguuMZi98BOCi/vNhPx2ep8lOkEhb2WyvXiHu5
 6mNQm5qPP35Izqb39bjtRDDwBSpN9R3qhfap3+vm72BMVR2BO2f2XJQKwhRb36654wE=
X-Gm-Gg: AYBFou1y0EfhiOvbFAaJlWQlj20e2vbcRuv43AmGc/iT5MRDFFJm3E2gI6jHeVq2Zhx
 lxGkJT51BFBbvh52bFt2WPaBj7SYAy2b5LCzkovcEWtH0Wbsl1CW37TEdm0cWZ5qaoJYoWx+ihf
 9/foCmLyYejTlpyVnExQdR4k9XhDa9MdcwltW4F+03dxLxBVqRrd5YVL4rr/58z4j7Ff1e8jbKO
 hgxlsd6AhWlWcAN/xkuEy7UzSo/1SfiVo4KDO1vUiD9bN3An7cSS8HaTjaTNHwlhOE4RX2VbvVy
 cc40Bx0QGpTffiats/Sf2s2cEP9s50h21gW4/p1u8vt7PjjN30esU8P9voAsi7V7Mia58CNDzB6
 yfCQ6Rfoj5VOXHk+xw9s5J7RUyMRroSXD8/SVIYsU+gdNRTcUEhQoJcujssQBQPwM5i+uohE/qH
 aai9gAnumPsRukLtElsL7upgIhIZf/Ll5/iROj6KVLXQVBhSyxGeFlJU/0FebK+VR8bQmgD0gel
 A0C+O+ccXCUGKDJPSYOzEetmkUYTB7ei6tNUDcx6uce0t+4dwhuXAVFLtFesGxRe3qd/slrDx4y
 ClI4kkuOtaOMqMEX2jnse1ZosTLyRqfLU+/L
X-Received: by 2002:a17:90b:258e:b0:39d:a282:7f30 with SMTP id
 98e67ed59e1d1-39dd570ad72mr1112919a91.28.1789273401719; 
 Sat, 12 Sep 2026 21:23:21 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ed295esm19389409eec.15.2026.09.12.21.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 21:23:21 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v2 0/4] pci: enable designware pci and phy on spacemit k1 SoC
Date: Sun, 13 Sep 2026 12:23:09 +0800
Message-Id: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0lpmoC/1WNQQ6CMBBFr0Jmbc3QUktceQ/DopRRxkQgHSQaw
 t1tceXyJe+/v4JQZBI4FytEWlh4HBLoQwGh98OdFHeJQaM+oUOrpsDK1MbWrXXYoYFkTpFu/N4
 r1+bH8mofFOY8zUbPMo/xs98sZfb+i0upULUUfG2qCr12l8gSZPbxGMYnNNu2fQHt50HMqwAAA
 A==
X-Change-ID: 20260705-pci-38358b570d03
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Scott Bambrough <scott@riststar.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Siu Ming Tong <smtong@axiado.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15.2
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

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
Changes in v2:
- dts: Rebase on upstream DTS. So drop the changes in overlay DTS.
- pci: Find the phy by index instead.
- maintainer: Add the driver in the Spacemit MAINTAINER entry.
- Link to v1: https://patch.msgid.link/20260705-pci-v1-0-beca83440a27@riscstar.com

To: u-boot@lists.u-boot-project.org
To: u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Siu Ming Tong <smtong@axiado.com>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Pranav Sanwal <pranav.sanwal@amd.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Yixun Lan <dlan@gentoo.org>

---
Eric Chung (4):
      phy: spacemit: add K1 PCIe/USB3 combo PHY driver
      pci: spacemit: add DesignWare PCIe host controller driver
      configs: k1: enable PCIe and NVMe support
      MAINTAINER: add K1 PCIe driver to Spacemit entry

 board/spacemit/k1/MAINTAINERS      |   1 +
 configs/spacemit_k1_defconfig      |  10 +
 drivers/pci/Kconfig                |   7 +
 drivers/pci/Makefile               |   1 +
 drivers/pci/pcie_dw_spacemit.c     | 391 +++++++++++++++++++++++++++++
 drivers/pci/pcie_dw_spacemit.h     |  78 ++++++
 drivers/phy/Kconfig                |   1 +
 drivers/phy/Makefile               |   1 +
 drivers/phy/spacemit/Kconfig       |  11 +
 drivers/phy/spacemit/Makefile      |   1 +
 drivers/phy/spacemit/phy-k1-pcie.c | 492 +++++++++++++++++++++++++++++++++++++
 11 files changed, 994 insertions(+)
---
base-commit: b739fb09a011558396287e077108d2e5379069c1
change-id: 20260705-pci-38358b570d03

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

