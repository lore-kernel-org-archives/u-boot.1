Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D556606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S/MuweE9;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DW0nNyr9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22771405E9;
	Wed,  4 Nov 2026 13:31:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ojba_3l10sIk; Wed,  4 Nov 2026 13:31:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4991F40566
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793799078;
	b=bmctyimdlA4gHXwvBv/yo+47FD+Hvp01Y6dQpcrtjNEBg5RvJmMp7a+muYFjBS0vtM9d
	 5mDUysNgJHzaNhKN/gVgryCpRoRtZFuw51y4r614W3uIm5AcJsuKCKfNKY47gmX5oeIP5
	 holYigIFHQUQa022KsKFO33c4roue8XL6glCvaloo6IHzloWHN6Snc5Fsyca2lHdxci8l
	 +KLwDSTuVAbiRlDPvRBce3zTsqsHYYDjNzFoJhT8bFKecz3QxNLZZMG0E7hnPCV1B0pYx
	 uJYTmJcRD95S2SSxK6dlXZ7Y5zt9vopII5HmzQILCoDy26rW5KG8rqUl+1hUuOtwB5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793799078;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b/wo6OGhX3Keox+10l1/d9nMLw/AXAKqjbbjhiFhjhM=;
	b=GrCNZPurlgwxfAkv7iusrijvqpp9izrVtcMR+faDZuq61oujm225i3OKfEw++w7O9EgF
	 rQsJG/mVelDShJa0a42v3loOq+mOUSVB+8vbkZs8AliGZEpAnCa7K2uFV1oiyJq0nd4pJ
	 E0PmeXFpgu9kE0Tgc9+Y1USGTLN2txWIbzlNS30p6XdNp548ifanQCPil9BsaNxpua8t6
	 4VfUNGQWcc2Ajwsp1HfI3VDR+EigLx7nIQOm1G1OBc5wY5ePjnRMy1cZe0cUZVum9orSf
	 hbnaJ48vIS5LaWw8WwUZf6QzlE6gMtwLkxbEAw6aCWR0unAXbjo88XT5EcSvcHk//dw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DW0nNyr9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793799078;
	bh=b/wo6OGhX3Keox+10l1/d9nMLw/AXAKqjbbjhiFhjhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S/MuweE98wULOoZBLE8BJRdkLvZOIHah/HnYXBJJEbS0KXPhN7VaJxpc8qN35RDTi
	 dMwK8iZu1Ew2ZC5Bjhc1I7YFOn2lc4R4OUiiTQ96j/5FdTHeNcsynuTPIvnUMOS/eO
	 06rGznQ0+eYfM1WNbf+mdaPxPYFjXOq8mFTRgqaEuY+Efo5dt2rSBvZMMOp4bI6QSG
	 LJ6hn2/4tH0E8NFu67K3yJk5Lqsf0Fka1GBdIBBSPsacVZChoxIMP0KtdFVr7VZPE6
	 vD/jkJr6IWPfxbPyArETckDHE++LtvqlxW6lf3GgHumzky0eTQllOhrFSLQ1lF6qyT
	 1/LWkIqYA3+5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4991F40566;
	Wed,  4 Nov 2026 13:31:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 179A437B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0900740743
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtVSfy1GAop9 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:32:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4ED3040198
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793784731;
 b=hsXeZAOrr8/NUa6aNxc6a/93xhAjS9f7gYSv/FmWyKUqju4hpjB0YDyYfPu/W0ue3TVw
 P34PvTwjM3ccBCE2i/lSpkltev9QP6VQVA4yPJI9ZOsSVE2JrHbcvMeFxnhYmXddJJ7+k
 UjSbSec+WYmop8XwgNJUH0Xrhrw9JNtn2Fn4oJbU3XYQUeIUGjySRphULXFtIxP9YsV9O
 haBvjCVMNXyTMWBMHKC8HIcy8S+b7Coba8izZoKon2S65D9xs8ys2T9LW0GX1DuCm43rQ
 sdhlJMb3BQgEyJ0Eqq6CcA6VN2ZaWfhEde2IAoZ4eK+hIMAB7S6+yJmOnb483AiAWIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793784731;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=b/wo6OGhX3Keox+10l1/d9nMLw/AXAKqjbbjhiFhjhM=;
 b=hYPP8jrxzwIng8LNYTyoQTLu1rymBxOimtnuDMCgf/ik6EDrMBB244jsUzMu3sR8mpxu
 g8iYw4pEAhv6pU4y4bsKlZX4UmMMsvznsMqv6BInsBi04E+BiiZi1aDpUQ48carK8w0gi
 MWlOA409EnSh10ZdpQcst7sNwYiaJDjEubEhqdiheGTU/ZEAAeyeDaMWdHzh+GOlRcvrI
 PDOVCAJKCqb8okFP20g1bRJbBLiP1iKTqaXfs1BL0mP32SCwtsgg0dbOtBvAJDfz4yAh/
 9bwtfGTFJEA21tH4JE6c1+DcaP59CEG11cfE9WWCfC5YkgeX4wag1YzfFreyv735Hrg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=DW0nNyr9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com;
 envelope-from=nguyenanhgiau1008@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=DW0nNyr9
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4ED3040198
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:32:09 +0000 (UTC)
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1ae58d17cd9so48496c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793784729; x=1794389529;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b/wo6OGhX3Keox+10l1/d9nMLw/AXAKqjbbjhiFhjhM=;
 b=DW0nNyr9WaHQ8BwahdMpCXrx2RqNvRyF8ipixfB6ILPRbyW4UPKy250Q/33Qx0sK6D
 BaOHdR7Z0qzJ/4r9+SQDz/lj0Gm0gm9Efc13FB+aStmTVzPMevWTLe6zUTYh67SxJfRl
 1KGu47DJSgpr8DTif9CsTs659u1Jji8H5QALAaj+2QLXlVIBxDkBNHVum/6Hbk/jIa1C
 lljoZJwPg8xUNz9Ell+VYBSGjDuzlfTYTcyHUzOAK8VHzOB5ZK+S1RFUhkDAcLIYkdpt
 mydb/9V6ZuxAC9dizYw9dqXh/FkrRm6MnOi1DUGTmfTE7qja/DUQVsGkIOF1+REQRTKi
 5ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793784729; x=1794389529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b/wo6OGhX3Keox+10l1/d9nMLw/AXAKqjbbjhiFhjhM=;
 b=HcCSob3rbBhptGFTSVNfC3wSinDzTmJV5WltDSkRLbIslN79s1g/HeUt0LfYMLEyZH
 3XCY5SFZm1lrtbxM3TQfxnFOF543eXIkqi1wCfyB5XJ0uwWV65CMMbAGt5drJQ117sTA
 Pg9CZjWjYgJa2SAkKKrip0WaNb4sd7rh2vGrOSGxhuUKIWHVzzNCXwMAUcdTRG91JPwU
 8FSW/7FyPJceZJHIH+7E7cpPwRg+13x/wCrnfiHJbJ/bjUlgngcOJQ679lMAA3UZD6N6
 V9UWxFV2l9mtuNdjS2LuSc+9V15B0uqhu+kL0CEejl4EMs3uIAM//9BUnHkEZmqNHeeY
 iN6w==
X-Gm-Message-State: APuU4Z9HosEuMP+6gU71TJsLZjDJVw9csOTi54dWcvbNdiw97AqmTIu7
 RPQ0QrjS8khRMM0OgpOjRtp/LO2OVej5HmOGUI8XGj8mfwXZO8Ze0jpxhDi2CPoxMZaG3Q==
X-Gm-Gg: AYBFou3xuMP1dRhj8MOheZAIFVSwXkugiesjxVam6z77zQYn6CZ2T18S5ImL5vCsOpT
 AUQvfpCNPk5lw7ehIBTzaf4IiBbb/F/ekbfhs2GPJaO7SJFZ7NSTmH9UkDGvYXFjZC5x+CalBaX
 0c+dUkwQzFYvuQB4yLDif99uZp729U7OIcCP6RKCT+7jUSMKcL9nOEBkjqQTIk5rhBJ0Qwx3LA2
 giPLPsXLHOHJzQtjuYXjI/e340jLmAhKcbB2+PuxUVq+FNwlMWKwj25gUcs/PxZ0QjJ5E+ZrcxS
 sCCPwQtqmBl2LiLZL+p0I3n808PwMNoYwi7l/HovXgLV84bmY3j4Qe4WiVCXxNQ+CbW0swewxV9
 guI/HQDG74T9Sg5/aUrXCFtkOsUeNOlprbARguidv6memsRmd7dXwcrlYlipNtCFOAWXgaU9BV6
 RlG6Ci6wBHCTPJd69Z/EiGh3qfOnCrD1o0LX18yJViNByrR7/GL/c1k6+f88Kk/wAEHwzhs5N8a
 /V/9n2ZVB5e3Ex8wk/DByRO4mjUZFuCvzyE+NG1r2AU8y5wQ/VD+SlBuIr8I+PM2PBR29HfU10t
 rg+YKLM78DHfNYfIZtcHuJSnbrwJwpiZP/WpQeU=
X-Received: by 2002:a05:7022:f908:b0:144:c123:4036 with SMTP id
 a92af1059eb24-1ac5d2c5c0amr20874840c88.35.1793784728954; 
 Wed, 04 Nov 2026 01:32:08 -0800 (PST)
Received: from R3700x.lan ([2405:4803:217b:bca0:fde9:1c92:911f:3a66])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca3958746sm6030224eec.22.2026.11.04.01.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:32:08 -0800 (PST)
From: Giau Nguyen <nguyenanhgiau1008@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Giau Nguyen <nguyenanhgiau1008@gmail.com>
Subject: [PATCH v4 2/2] configs: rpi: Enable BCM2835 I2C controller
Date: Wed,  4 Nov 2026 16:31:01 +0700
Message-Id: <20261104093101.500696-2-nguyenanhgiau1008@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104093101.500696-1-nguyenanhgiau1008@gmail.com>
References: <20261104093101.500696-1-nguyenanhgiau1008@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 13:31:11 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the newly added BCM2835 I2C controller driver
(CONFIG_SYS_I2C_BCM2835) and the 'i2c' command in rpi_4_defconfig and
rpi_arm64_defconfig.

Note that the I2C controller nodes are disabled in the firmware device
tree by default. Add e.g. "dtparam=i2c_arm=on" to config.txt so that
the firmware enables the I2C1 bus before U-Boot is started.

Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
---

Notes:
    v4:
     - Split the defconfig change out of the driver patch into this patch.
     - Also enable the driver in rpi_arm64_defconfig, in addition to
       rpi_4_defconfig.
     - Order the options as generated by 'make savedefconfig' and drop the
       redundant CONFIG_I2C.
     - Mention in the commit message that the I2C nodes need to be enabled
       via config.txt.

 configs/rpi_4_defconfig     | 3 +++
 configs/rpi_arm64_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
index 850f8c7d1c6..b48abd2b040 100644
--- a/configs/rpi_4_defconfig
+++ b/configs/rpi_4_defconfig
@@ -24,6 +24,7 @@ CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
@@ -38,6 +39,8 @@ CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
 CONFIG_BCM2835_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_BCM2835=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_BCM2835=y
diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 87780c2286c..7eebf114df2 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -23,6 +23,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
@@ -38,6 +39,8 @@ CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
 CONFIG_BCM2835_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_BCM2835=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_BCM2835=y
-- 
2.34.1

