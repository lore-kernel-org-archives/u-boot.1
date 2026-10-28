Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zHwOWUVs;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aI4Ss5B6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A65A8125D;
	Wed, 28 Oct 2026 14:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i3o8atoc_6Ce; Wed, 28 Oct 2026 14:48:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 53C7980F71
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198825;
	b=AlATrqcMpiPZjadEz/LetFutKQAAP5cD7a1ahul8jy2zuwrppjyvNAfYgLzHO8O5tuvd
	 oFuwuZUT0fesSULDnylzQWnGWQ4YaWgFVwpGTckvgBT6j8BJu+dr8Vq+U0g0Wxcrc6UKJ
	 rjhJ3EXDyLSY0yPxGDSIdKdEvtXvcZrxU0gF+FGmL2eI4BnjNlhw5O7YwJQ3nClgOGezY
	 cPX9lzm17WYay2L8MY1V4iypqFAmAys4C+UztkRzTepZmp8HVVYq/ZDsBEwbzsVXq2m2v
	 9LgsUlsrD9AoHZBb2TfRDeW+AsxC8YHhEgLBezQewE6A3rvpW5wNc0eMQ2/szMUsWnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198825;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AGvjrOKtqBLnGGb10xg9yAGwXxGwzg5MgTlcsQKTa+A=;
	b=IWqmpAEXmtbbN6Z1uBdXBRiNUm2SFLURYw1f8VvnF1gUaw3CAxkZLK3vNqlyv4wIOned
	 APWGOmnUlukqn1xhIKm9G3OSL+im5TlvNz9hnKFLJTDQHDNzevQxKbXkzmhcwtMrP2dPh
	 S3Jg/bauT31gx3MzoVZGr0k6XAvZl/ySwLVb1ZvNCt3iNYgPuOPa0XDUCBkegvxkRQ4UQ
	 wqlvRyLRCWG2OP/nHPX641RRkwplx8G93iYVGrQCgBU2+JWN6s5eiz0/liwpxjOUXTlz4
	 E5Hw688OWVVsbhAOg9qA24YX2I1gmmp3aESquUrLsiYwMJACpcQ6syXlXjZVt7wq5gg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198825;
	bh=AGvjrOKtqBLnGGb10xg9yAGwXxGwzg5MgTlcsQKTa+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zHwOWUVsTLXCfyTX+X5UEfQumZFdl7JfJAUsVAegY9jhlG5YdZP3wO8QpH6t7r5xl
	 YX9lMHRIhY+dGLVq+jjl9mWJncw1wJQlZF3FOZ48IkmgCUxwV3sNdiaPe1T40iv/BR
	 +JpItPrSPdheiorHjXLtKUz1Nf+MJlAKLrjdW1aGDIyfQw3OXk1LfMNoG5dML1wJuU
	 4NantWdYZYZptolfMuxDW9DQVwJiugNjXEwU+M6XB4NAoPV9sHFb5VazJfsbLZIqgR
	 5JU05BDyXxu9ExgU354gkWe7h1Tj0CpGDhMLsogyil8xIGT1n01673QePzXasJrFqw
	 cec2YFDRJWeDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53C7980F71;
	Wed, 28 Oct 2026 14:47:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92047A0B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77C366060B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0yHG9wYQX59p for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:12:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 51951605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196756;
 b=LJp2c4fepGRQXCnCbbnm327sIXH7ygaeveHD/01rX48RAb8Be06rTUKTLuvnyx3CXsgX
 VZbY62FKvxWcWGu12rBX8TOkX+087/kKLEr4cosU22s3gUO3D/bVa9wbXZ9+HiEHg5iRz
 e9fk279DWuVNMPQpET3LA1pEdxkO8DUAZhUp/HYOtN7wbmEr/FZmRZG6Ip5jdGKg3zhCN
 9ktUoCGE9DL0b6mtOz8bMu+HxYw/1jUhC7MbFCF4ZwF+QpAXt5JM/hJVV+uWv2h4anJR+
 MKZ9ba7WlQCFEX5t+C7b+f8iRu+3pjeRBRH3CditFrjOjvnoQ1/ZrB5dJJyewhZItOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196756;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=AGvjrOKtqBLnGGb10xg9yAGwXxGwzg5MgTlcsQKTa+A=;
 b=U+KkYh2FV5PhCpR6EdNhs5mLcNRStkFyom7EclJxxkEEvfeyovYz4eELg5BUeAvAKhml
 jskjrAwaX8WF4MSTDE8VdWORmEpGc6EEyrXYQwdTx7cuGGRbgqmMcueWcQMTKuhUiuLKl
 WQQ2MOtdi9q015jKZrIqVf9fmW47EBLn8Q9Y/Umn4ZPWNvalPl4ILfoTjS4TA3biMU0Zm
 I5RJiEI6GV6gsEqJh0vPI/s0ZXK+XEqr5LXhxNReLZyelGSfW+iwD7ItoJmjYfgXWbIqD
 8qDSAyEgTGshYHWLgDI//DLmRNJXH3IoR/yIpoP019weGTzu1ks4IzkNcKVcpeTDoEA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=aI4Ss5B6; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=aI4Ss5B6
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51951605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:35 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c4015fb0b42so10404866b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196754; x=1793801554;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AGvjrOKtqBLnGGb10xg9yAGwXxGwzg5MgTlcsQKTa+A=;
 b=aI4Ss5B618HCWxVqyIBERHIM3xmNJbs0TQmyjd43kT1IWwWnQ+rLSBm9RceMeU91XM
 Ri/nKFdXUvOkGCF+wVc/0tkmf1iBymN4fRAhJEq35KBguCQZsL1pflgBCPZ8bRfT8ZMo
 jr9oyifdZnUmKJw63Fm1PQlQsVaEUDHH6Cc/lg7egNHAN2F1F5dxRn/Y1vQSwK/9Ohev
 BUGlCI+ZJS0iiD8qMpFwICH2qHkLfKPyqra9EHmLPwKcct5YWBwtVTbqix3qwvfjO3TN
 K62l29TAKmyikh4u1U8cOhMYhStPccEMgeIfiQIxaro46lSlEYX9SqKe4H+Nb9FeBD1z
 ZxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196754; x=1793801554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AGvjrOKtqBLnGGb10xg9yAGwXxGwzg5MgTlcsQKTa+A=;
 b=w76XP9YeGESOg1z0KU0xSySXLY11Ar5p12Uz/hfqDvckEFFweB0jefxCRjYwStZ0t+
 D1dleEZKbb+M/XA2HJevBhcvt8KdLUPUSMYk9wExCyqw2QskawcSjfGjWFNCERUQ+vs/
 Y/fwxhzByIo04eIoq2J3rVmcd7CiCsVjxaxV8uiW6gZF5ypKE5FF8SR5az2p/AS6pM0O
 RegZ3sjaOumfvlMOB6frOPRDckq83fAjZqJOiZo1QC5Cln6FxyZHCr8J423ASIQNn1JB
 NyIUF4V38MW9ygigfKMgjjsfsG2iuOhRR7UWGLL4vOaGEniBJEND+nH9PDuJeaXC7OkE
 lmrg==
X-Gm-Message-State: AFq9FYJTBSvITTs2AN+oUhNQZLfMh5Lbt4vZVRjg8gbmty2dBp96tL5Q
 K3QTH2hWKux8QCaC7zPU1QSg+piNX8V57Ap1CsWaXFrguFQ+H7++oEWzWOx5b/rC+yoij2cyVWJ
 YR+54
X-Gm-Gg: AYBFou3jHcwUDQvkXhtVAH3jreP4nnpXXUPOod4GKqLCVwDBhKlmduPFQoBN0FHv/uJ
 gZBXid4jPOswjZhv0H5o0KxI7TaZfw66cYF8ZNud3Zyt7TUFvM6wsmxNnJr3SAa7ECm8TPzGv/B
 WROQl4gMTZusPDZ/IXLib4Fwk9uP80FWT+VQGMIw1qM7uxGZWbAcWMis07pCfu1lqCZfcxm/9Yv
 jrqPtKOV1MVzxkkl2EnlYQ9RAdGbPbFB5ThADUVT40BpsFsGu6vt2eFM8uStrhu1zt5xKZc+hGz
 Q+KjGrv2clQ4xOX4zBhdVEzufwtG7HAJDIA1A8gDVHrvjiBWaEUWaPMzWsEKBk8j8uc2hNk06aK
 +cMRFX75hLJwkV6LSHRAGUjSAjWNuhQLUVlWv5HSfzVxyacJhuglGDZZPB8+6afy2qE7VRY6J2T
 Ofy28+EzcbCVeT5kIzhYhRxGeciifssrEPx4uafXGag71wHlj4zV2L+irMxmINL7ZtwkgWpk+h9
 5+/fu25ZoAm/Lg3ymnf/SjLG89o/OhG3h4v9V3Njiz0Tt0bQ1gTk2qMYHfUca8KTeu8kVlMVNO0
 gE+n/MBBAlOzWU3sw9i16kAe13lYuOD0dAhvwmakBTOluM8NWnwlIuWdw2JFdTqeTQwsoEwIx+F
 JbnRjs57/uA==
X-Received: by 2002:a17:906:584:b0:c41:8e21:4d62 with SMTP id
 a640c23a62f3a-c49bdd71afdmr213630266b.1.1793196753544; 
 Wed, 28 Oct 2026 07:12:33 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea351sm606060666b.28.2026.10.28.07.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:12:33 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 39/63] usb: dwc3: import from kernel v5.14
Date: Wed, 28 Oct 2026 15:09:05 +0100
Message-ID: <20261028140930.3025368-40-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.13 to v5.14.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v5.13..v5.14
Commits imported:
4a1e25c0a029 usb: dwc3: gadget: Stop EP0 transfers during pullup disable
51f1954ad853 usb: dwc3: gadget: Fix dwc3_calc_trbs_left()
664cc971fb25 Revert "usb: dwc3: gadget: Use list_replace_init() before traversing lists"
cb10f68ad815 usb: dwc3: gadget: Avoid runtime resume if disabling pullup
d25d85061bd8 usb: dwc3: gadget: Use list_replace_init() before traversing lists
40edb52298df usb: dwc3: avoid NULL access of usb_gadget_driver
84524d1232ec usb: dwc3: Fix debugfs creation flow
8562d5bfc0fc USB: dwc3: remove debugfs root dentry storage
45d39448b4d0 usb: dwc3: support 64 bit DMA in platform driver
2a042767814b usb: dwc3: core: fix kernel panic when do reboot
5ff90af9da8f usb: dwc3: debugfs: Add and remove endpoint dirs dynamically

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  7 ++++-
 drivers/usb/dwc3/core.h   |  3 +-
 drivers/usb/dwc3/ep0.c    | 10 ++++---
 drivers/usb/dwc3/gadget.c | 59 +++++++++++++++++++++++++++------------
 4 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4ac397e43e19..ba74ad7f6995 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1545,6 +1545,10 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
@@ -1616,17 +1620,18 @@ static int dwc3_probe(struct platform_device *pdev)
 	}
 
 	dwc3_check_params(dwc);
+	dwc3_debugfs_init(dwc);
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
 		goto err5;
 
-	dwc3_debugfs_init(dwc);
 	pm_runtime_put(dev);
 
 	return 0;
 
 err5:
+	dwc3_debugfs_exit(dwc);
 	dwc3_event_buffers_cleanup(dwc);
 
 	usb_phy_shutdown(dwc->usb2_phy);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c5d5760cdf53..5991766239ba 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1013,7 +1013,6 @@ struct dwc3_scratchpad_array {
  * @link_state: link state
  * @speed: device speed (super, high, full, low)
  * @hwparams: copy of hwparams registers
- * @root: debugfs root folder pointer
  * @regset: debugfs pointer to regdump file
  * @dbg_lsp_select: current debug lsp mux register selection
  * @test_mode: true when we're entering a USB test mode
@@ -1222,7 +1221,6 @@ struct dwc3 {
 	u8			num_eps;
 
 	struct dwc3_hwparams	hwparams;
-	struct dentry		*root;
 	struct debugfs_regset32	*regset;
 
 	u32			dbg_lsp_select;
@@ -1281,6 +1279,7 @@ struct dwc3 {
 	unsigned		dis_metastability_quirk:1;
 
 	unsigned		dis_split_quirk:1;
+	unsigned		async_callbacks:1;
 
 	u16			imod_interval;
 };
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 3cd294264372..2f9e45eed228 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -597,11 +597,13 @@ static int dwc3_ep0_set_address(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 
 static int dwc3_ep0_delegate_req(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 {
-	int ret;
+	int ret = -EINVAL;
 
-	spin_unlock(&dwc->lock);
-	ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
-	spin_lock(&dwc->lock);
+	if (dwc->async_callbacks) {
+		spin_unlock(&dwc->lock);
+		ret = dwc->gadget_driver->setup(dwc->gadget, ctrl);
+		spin_lock(&dwc->lock);
+	}
 	return ret;
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f14c2aa83759..ccb68fe6202e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -940,19 +940,19 @@ static struct dwc3_trb *dwc3_ep_prev_trb(struct dwc3_ep *dep, u8 index)
 
 static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 {
-	struct dwc3_trb		*tmp;
 	u8			trbs_left;
 
 	/*
-	 * If enqueue & dequeue are equal than it is either full or empty.
-	 *
-	 * One way to know for sure is if the TRB right before us has HWO bit
-	 * set or not. If it has, then we're definitely full and can't fit any
-	 * more transfers in our ring.
+	 * If the enqueue & dequeue are equal then the TRB ring is either full
+	 * or empty. It's considered full when there are DWC3_TRB_NUM-1 of TRBs
+	 * pending to be processed by the driver.
 	 */
 	if (dep->trb_enqueue == dep->trb_dequeue) {
-		tmp = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
-		if (tmp->ctrl & DWC3_TRB_CTRL_HWO)
+		/*
+		 * If there is any request remained in the started_list at
+		 * this point, that means there is no TRB available.
+		 */
+		if (!list_empty(&dep->started_list))
 			return 0;
 
 		return DWC3_TRB_NUM - 1;
@@ -2243,10 +2243,19 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
 				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
-		if (ret == 0) {
-			dev_err(dwc->dev, "timed out waiting for SETUP phase\n");
-			return -ETIMEDOUT;
-		}
+		if (ret == 0)
+			dev_warn(dwc->dev, "timed out waiting for SETUP phase\n");
+	}
+
+	/*
+	 * Avoid issuing a runtime resume if the device is already in the
+	 * suspended state during gadget disconnect.  DWC3 gadget was already
+	 * halted/stopped during runtime suspend.
+	 */
+	if (!is_on) {
+		pm_runtime_barrier(dwc->dev);
+		if (pm_runtime_suspended(dwc->dev))
+			return 0;
 	}
 
 	/*
@@ -2447,6 +2456,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	/* begin to receive SETUP packets */
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
+	dwc->delayed_status = false;
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
@@ -2585,6 +2595,16 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 	return ret;
 }
 
+static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->async_callbacks = enable;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
@@ -2596,6 +2616,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.udc_set_ssp_rate	= dwc3_gadget_set_ssp_rate,
 	.get_config_params	= dwc3_gadget_config_params,
 	.vbus_draw		= dwc3_gadget_vbus_draw,
+	.udc_async_callbacks	= dwc3_gadget_async_callbacks,
 };
 
 /* -------------------------------------------------------------------------- */
@@ -2798,7 +2819,9 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 			list_del(&dep->endpoint.ep_list);
 		}
 
-		debugfs_remove_recursive(debugfs_lookup(dep->name, dwc->root));
+		debugfs_remove_recursive(debugfs_lookup(dep->name,
+				debugfs_lookup(dev_name(dep->dwc->dev),
+					       usb_debug_root)));
 		kfree(dep);
 	}
 }
@@ -3229,7 +3252,7 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 
 static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->disconnect) {
+	if (dwc->async_callbacks && dwc->gadget_driver->disconnect) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->disconnect(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3238,7 +3261,7 @@ static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 
 static void dwc3_suspend_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->suspend) {
+	if (dwc->async_callbacks && dwc->gadget_driver->suspend) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->suspend(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3247,7 +3270,7 @@ static void dwc3_suspend_gadget(struct dwc3 *dwc)
 
 static void dwc3_resume_gadget(struct dwc3 *dwc)
 {
-	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
@@ -3259,7 +3282,7 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	if (!dwc->gadget_driver)
 		return;
 
-	if (dwc->gadget->speed != USB_SPEED_UNKNOWN) {
+	if (dwc->async_callbacks && dwc->gadget->speed != USB_SPEED_UNKNOWN) {
 		spin_unlock(&dwc->lock);
 		usb_gadget_udc_reset(dwc->gadget, dwc->gadget_driver);
 		spin_lock(&dwc->lock);
@@ -3583,7 +3606,7 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 	 * implemented.
 	 */
 
-	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
 		spin_unlock(&dwc->lock);
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
-- 
2.53.0

