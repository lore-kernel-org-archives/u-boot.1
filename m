Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC88CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 19:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9507838C5;
	Fri,  3 Oct 2025 21:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NNMjGImJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15DA68386F; Fri,  3 Oct 2025 21:23:01 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0309E838CE
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 21:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-92aee734485so111655839f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759519377; x=1760124177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wjjyTVKkQqgND/J+YvFO0/ETgFFj2XhC3kXF/pUeps=;
 b=NNMjGImJzAdnGROyz2DuYOiaspG9euqC5wuuauaa9JE9NJjYFuKN0q36Rwqk0reLUW
 B52IGGbQ20UDSMu5y9wzCiOG37wfgS5jIQrl2cKTqXfcycgS1bf9xwN69SipSlIWxZTH
 CN1TWO5hhySuvCMXolrvi9vPRDkJEV190YZbr3U8TXSBF2/3P5Jl5k74mniFLN/aQ8VH
 onmJKniscCHx0XVvubHCV0uFI++o4YsNn1HOaMHl7u9RYtIR8fjdVbnQQaayu+JZxztW
 UgUi21ijhg+00Cq3jh4sR0LuCJEMCbBK8DhYJlv7CZ34nYi6ThyzUvVtOQ8N2nWqh+Tj
 ssdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519377; x=1760124177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wjjyTVKkQqgND/J+YvFO0/ETgFFj2XhC3kXF/pUeps=;
 b=kD4mcccUyF2cL+RHzD46KatHtw+cO/MsrdUC4w3z6RcNRabfFGum1BMY3Ds3CaoSrh
 KfSvq0z3gJ/m37igvrgEemOkuAu69nNUd8m/+wzY1eu+4SHzi1WO5HMoaCD/mPmYlAa2
 yYl4HKCyPAN37Gh7jH6yJdbEs3+IT/FWyf6TLD1et0031A9PDHY6nbBJ9AowqtkMs2YJ
 pYBlRhVx6iJVr9IkcuNQNTb7nJgG9aagpOiN/39IZ3pP4wVA9kmFKZi7EUXZ84hZDhVO
 pGeUWWNbXjQRO7i5/IR0VN7WmzQ+mwgtcTmx/E5UEWg4zYpw0hg8dbOJ8MAlAGdOivvX
 G3BA==
X-Gm-Message-State: AOJu0YyFOgG+ygBBA7amZQ35D+x9V/MEzA2gzDpNEhW9VE9dCzHpVSrB
 7QRFifscdVAeIXe9E0SyR9EtYZE8QInocBGVuqid3h1dT38cVtXHBVeNrZEqb3KcQU18y3tnLR+
 ac3UH
X-Gm-Gg: ASbGncuNvhFeA0ioHcg76lQjDaQ1UJSe+IIeJ7NeY7Ka1ByckTLMU+GrJnrHXwjjjJn
 O3aJ/uKCWH+E+jsX/QT0DN6fF6hGQvr6bycSiZUrQ3MogiEPIWVKA46W0d+FAdMxt/AHMR6kRKy
 XvPaMAKn1FI5DZOB90+Obr/oVD0P9vs210yENlmDYBfQIQsATcqC9xSM6nXGBSk6Tf0wnjb+S4r
 BVhjypI7wtp5CkA3P+zquZhKMkgcMRmx+j7BYe8RbemVNJG7PqWtl2FIrYpxbp0kkK0T726zS6s
 pJJAKhefREJ1Sd3s8pC8ojLMpwuYI9kfEh7eO2pp1w1XOwpe1MfNwJZ2SogiVKaKrYCnSUhp/OZ
 iBxfMn8CVyuafvNPBs/E318znvQ5WyT2sbjP7Grg3rzzgp1PPR9BuoUOVdOf+eYNj0kPWgnUPcx
 fusfCeCx8G
X-Google-Smtp-Source: AGHT+IErJdb5shYpk3prNHcx9okMNF7dubKjGs1FHmWdZhs6x7998dfRtR3JqQMXYPskiaEPCTduqw==
X-Received: by 2002:a05:6602:6429:b0:936:eded:d78a with SMTP id
 ca18e2360f4ac-93b9696e5ebmr547866339f.6.1759519377399; 
 Fri, 03 Oct 2025 12:22:57 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a7d81bf16sm208975239f.4.2025.10.03.12.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:22:56 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 3/5] configs: select CMD_BLOBLIST for Firmware Handoff
 testing
Date: Fri,  3 Oct 2025 12:22:17 -0700
Message-Id: <20251003192222.767882-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251003192222.767882-1-raymond.mao@linaro.org>
References: <20251003192222.767882-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Firmware Handoff tests will leverage the same board type 'qemu_arm64'
with a new board ID 'fw_handoff_tfa_optee', thus select CMD_BLOBLIST
in qemu_arm64_defconfig for running the test.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- None.

 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 358bb1aeeb9..0a43abf8fbf 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -32,6 +32,7 @@ CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_BLOBLIST=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
-- 
2.25.1

