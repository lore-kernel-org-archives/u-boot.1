Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B49606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r9YuPUeQ;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JprMSUvV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76ABC40792;
	Wed, 28 Oct 2026 14:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LaEYoGJ8Kx7I; Wed, 28 Oct 2026 14:46:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0BA0D405F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198807;
	b=n8rumxM4ACLhZ60Mz9Nd+vD0pn1zmMIRYvcsVz7iSRfgzbtgrQfalvGRoGdxI+Pn74tN
	 wWDN6nGaLzbCa7iBNMgi2AM7Fn6t53Au5wgUNXGzmR30YjcnDe+ZtINChKraIL4J7D7fk
	 loT6WSqlQvPH49zVgJMw2gQ5goNMlCcwSg3+GNaYCwUJVWNMQbE/0SQ9jmC+iLVw68T4q
	 23aqnY5iF1n+YrSsCq4EX2t8m5YyjqgpJy3P81sUqkx8MdMWl6wvbG3QhX36zbAOgCdwn
	 +tDM90SC+rrZxvuYwtPUiOPzkXkvzoN0fKBUDa4noU5KWSq7zNZMG66rURHm+GoJu7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J3aLEXFX5LZDIODOauS+VXAuyQa9qG0uRrY7YCrZ1LA=;
	b=EEkLfVq1pzYfNbKTVzLhfjreO3OkfDvdg1yzxaS3pg4mrocvvriUDHUSUQZ0KaR9Gc18
	 MikMFttHQ7OBM6b6XWJAVKrNI86Ns0z1WZxBLbM+K4aFdHP/PYpDZaEbwNDNCadBbCyOd
	 jT9G02dEvpH6utqLjiyLwiyIAHDFzJyWLs4Br2H4LzhF+Shp2HBWosFxOEcpZ7gm82gxl
	 +LsQGatvWUwgwFU+nPzgtCE3K8Ul7Nmg11bOe6v00ub/e7PlruCyqYbWOuXe7uWrX41ob
	 lYQRX6Ua9yLxbXs2841GWv/PcNWNEtQ4mR7yw8on+0TrQrDo38fm2QdhZHsEVO5gNEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198807;
	bh=J3aLEXFX5LZDIODOauS+VXAuyQa9qG0uRrY7YCrZ1LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r9YuPUeQanUQfUzX9ood5WGCSCdar9B3TCcCswSBZLXxVB5Zt/70lNiWogLvplACv
	 XjM2kqW9hATQmO8ozZv1SRgAUJqhMgdXdmnIJJPgV+drJ4o5ZgubSmEqrSBBlUYetR
	 1jkWy7kvLG5FowkjcxKHAN4wSe3rFVcK9Kco93KAvECsloDCNYLPBu+yhzT0CN67Ux
	 sk7GQyVpp7phDc2fXOoBkUutfVEwnforN8tuEFAARBQF9Rcyf+gYktR+ZJTf43NFtR
	 JkpGQPFEUUiHt2jqIDPgdAwCtii2wILeJ2Qmt9e8E+59zH5GpULCb0PQ1H54llEBeU
	 Bw9eTXf4OYlUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BA0D405F3;
	Wed, 28 Oct 2026 14:46:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 08FD0380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0663680C26
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5T6V6vkM_-Pj for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D13C480BCD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196709;
 b=sllpiE12KuAG89MiHAXya6UpF+rM9BopSRpdglWDWKxziVip0i75PRPDpX0jH50g0NwM
 Bl/8fED6GjXshelgcj+x5McM265NeanyEfols03rzNqKYzapc4cS9xJVOCdgMI9afIYw6
 c+J4nxK3EBXoMsRDZcOWO9WR3yTBakk8NsBSpUJYHi6NYNAPHtZRR0NxHQI3Z4EByr4NR
 TrZ6jGOww3+CBaCteOPrwT8Tjk6fMqXx2H9QDLWg4HahGk4WDWMwPV7Y0uXbmAEAGFTHH
 ZTEhiICCPzSBuG8b1kDtmYkFZzlj6eBKkYQ/ig9BJUXUupYH0xvdjqqaAb9oeAULbWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196709;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=J3aLEXFX5LZDIODOauS+VXAuyQa9qG0uRrY7YCrZ1LA=;
 b=YooqX/cXRvd19LlHXOhjRtzmpUiVpLkpvD6jIowMaS2BZIRNlCIt2EZDDL8VQJXE6nOo
 y2h9kKCfFT1ihX9wxxhzIgCYBAy8On9PvNZJ+rgDBAz7TFeS5XICGsnp8V030l4gX9DBi
 Wmar6GO0vE3HU5rMMb1WAN047tCmMC0ppGkJqeMNT4kaPrZlwbioll5RTtNaZGs2wjprj
 wf/TM5ScCr5gcngHXkx6CMUEgGmcqc58nXhui8Gs/i9Uati1VsmsXgpiJJm84VCJubYEE
 tCjaZV78E2apAiB/+PxKOBX9zNxY0lrGup6pY8QOMbAEOUbfkeAfeeqraSBHfOS2I1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JprMSUvV; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=JprMSUvV
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D13C480BCD
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:48 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c40db84b4b5so12830166b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196706; x=1793801506;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J3aLEXFX5LZDIODOauS+VXAuyQa9qG0uRrY7YCrZ1LA=;
 b=JprMSUvVB5q107A0iolIuVzK99kFelpPfPx9EURj8HBfPavH2bhn/nF7Dgkf51tS6H
 MKbaBoJ+noO7WmbC9XkXcCNiZZx6I7Yjn9ziPXAOj4OkJQclQf2PNvgT+E7JE/hhEyHZ
 p1/+8IJYQI2PaHwBurN+SpoBVJv7ctlhrIoCE1IT+qggzLG4XJVCx+/o7QzKqetEQIR7
 cM8fZbeaT96jGTLnDZkVNwtZXDhVhbF+mDuZBXX5JLBiBKb6icVTIyfeCjlAtS9jGM9Y
 9FEh0nJOy+Rx4Q/yexNeGkcLMRNwsimSqyDTMjTvguA34UF6AK2+5yiwgchi+YOkBq4o
 U5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196706; x=1793801506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J3aLEXFX5LZDIODOauS+VXAuyQa9qG0uRrY7YCrZ1LA=;
 b=dZtn6NykkqwjYyNAi9nu/BIUSVx8hBxNU7AGNASq9NOKvyRR6DLPR/Bui0zkdhbIhS
 tG/nt5Q06gueRQW1NRKg2ikE1caGAygMjy6odOcf6LrJoGINTXHhvA5vn7VvTEvf+sUX
 eK3WveWKGEk2xgOEQSW2T5LWlXqy28bfBeTYc/kYRefcfQ93ZhJdG6BQGvFD1oC0Vr4a
 OFyRptP2qbrekLSTCMyNhz8nI+y6DwdGrwfbK7KYgteuFWTZwZjMeCuxiG8tp0tVe2+C
 cxc1fegiJbGfkE+0/pWfAXrMA2Cjlz1ysBys7PiBxEFw41Tq0h2i7Ea98vsDdlCfb6r2
 CETA==
X-Gm-Message-State: AFq9FYKaP7a8YSBz3k9cZiXuEZVQQ7jWgGMyPbXVgmUTSqCbf2B76dbH
 bNOibxXB5crl0M/CNgSMAOYjhsWlfYodGvC6inseBW4uLGrbRuelSAsT9lk3DfdJyoKanVsThmq
 SCSfk
X-Gm-Gg: AYBFou0Q02TPNxSznmUWr5jxqaqmQZPXHDSeUaiDD3YYxoYWs/KpjQOl3SpvKxL6UUo
 SJbWFWGgkEeksbgNHnkxz0BpnQ0TBsV+iZ4WdtM/Tq9s7DIf5vxjiCXSLQXVYE9JpGYo8KOzhaa
 xVIMhwAPgo22TXsRlqhLZNQ83UUi5aZXlJ8RPSzXvmzgVhjFm2M8dqMCCLOZAQlw/sosRJwntHL
 TNI06JpJCY0Rcc4mvNtdwygYPGw/M/YkfSrT7VUKvQk5AU4qLKjcGE2IlyFVp3UlRs0rdBmR82L
 RwzD35E4L4der+qkchBP7kfRro96HdcBf5N9tZPnSaXUXZ0NF3EGvS5LECS+SMUpN6UJVTD0Ou2
 Fp68ywwX5syqw8gpXmH3nTmmkv47oK/uvMcFPcTjDrkZ2d1yc67v1UrEovto+sZwnOQCbg+iv2s
 9z2/DpjaZiCS7zhd2kB7vtS5m7OdOrKT/VNhAHRihr+bvU+qbrzOZNwDx62YQF0rGlSFNYF9dey
 C04FUxxSddU+3Eu0F8HxI/GcAfxsZrac7gBEnSpfDq6dswD6Enn8zm7RNU37T3Nm1RDR5HVDwXU
 2pRKLKo5MZQCQeUL/at340RH6UHsEz0287JzDSWaTc5vWPGbyIcW1IrN1vphOHzyGaP1743cJoP
 PPhIwtTqr1Npc9qagxe2F/QxAIwxxd3o=
X-Received: by 2002:a17:906:66d5:b0:c49:9a88:75f6 with SMTP id
 a640c23a62f3a-c49bdedd106mr234860666b.2.1793196706208; 
 Wed, 28 Oct 2026 07:11:46 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64a02csm611738166b.44.2026.10.28.07.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:11:45 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 28/63] usb: dwc3: import from kernel v5.3
Date: Wed, 28 Oct 2026 15:08:54 +0100
Message-ID: <20261028140930.3025368-29-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.2 to v5.3.

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

List of commits: git log --oneline v5.2..v5.3
Commits imported:
332694f8a4f7 Revert "usb:gadget Separated decoding functions from dwc3 driver."
3db1b636c07e usb:gadget Separated decoding functions from dwc3 driver.
aa23ce847dda usb: dwc3: remove unused @lock member of dwc3_ep struct
729dcffd1ed3 usb: dwc3: gadget: Add support for disabling U1 and U2 entries
dc1b5d9aed17 usb: dwc3: Fix core validation in probe, move after clocks are enabled

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 16 +++++++++++-----
 drivers/usb/dwc3/core.h   |  6 ++++--
 drivers/usb/dwc3/ep0.c    |  9 ++++++++-
 drivers/usb/dwc3/gadget.c | 22 ++++++++++++++++++++--
 drivers/usb/dwc3/gadget.h |  6 ++++++
 5 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4aff1d8dbc4f..c9bb93a2c81e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1282,6 +1282,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis_u2_susphy_quirk");
 	dwc->dis_enblslpm_quirk = device_property_read_bool(dev,
 				"snps,dis_enblslpm_quirk");
+	dwc->dis_u1_entry_quirk = device_property_read_bool(dev,
+				"snps,dis-u1-entry-quirk");
+	dwc->dis_u2_entry_quirk = device_property_read_bool(dev,
+				"snps,dis-u2-entry-quirk");
 	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
 				"snps,dis_rxdet_inp3_quirk");
 	dwc->dis_u2_freeclk_exists_quirk = device_property_read_bool(dev,
@@ -1423,11 +1427,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->regs	= regs;
 	dwc->regs_size	= resource_size(&dwc_res);
 
-	if (!dwc3_core_is_valid(dwc)) {
-		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
-		return -ENODEV;
-	}
-
 	dwc3_get_properties(dwc);
 
 	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
@@ -1460,6 +1459,12 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (ret)
 		goto unprepare_clks;
 
+	if (!dwc3_core_is_valid(dwc)) {
+		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
+		ret = -ENODEV;
+		goto disable_clks;
+	}
+
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
 
@@ -1525,6 +1530,7 @@ err1:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+disable_clks:
 	clk_bulk_disable(dwc->num_clks, dwc->clks);
 unprepare_clks:
 	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index f19cbeb01087..3dd783b889cb 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -649,7 +649,6 @@ struct dwc3_event_buffer {
  * @cancelled_list: list of cancelled requests for this endpoint
  * @pending_list: list of pending requests for this endpoint
  * @started_list: list of started requests on this endpoint
- * @lock: spinlock for endpoint request queue traversal
  * @regs: pointer to first endpoint register
  * @trb_pool: array of transaction buffers
  * @trb_pool_dma: dma address of @trb_pool
@@ -677,7 +676,6 @@ struct dwc3_ep {
 	struct list_head	pending_list;
 	struct list_head	started_list;
 
-	spinlock_t		lock;
 	void __iomem		*regs;
 
 	struct dwc3_trb		*trb_pool;
@@ -1014,6 +1012,8 @@ struct dwc3_scratchpad_array {
  * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
  * @dis_enblslpm_quirk: set if we clear enblslpm in GUSB2PHYCFG,
  *                      disabling the suspend signal to the PHY.
+ * @dis_u1_entry_quirk: set if link entering into U1 state needs to be disabled.
+ * @dis_u2_entry_quirk: set if link entering into U2 state needs to be disabled.
  * @dis_rxdet_inp3_quirk: set if we disable Rx.Detect in P3
  * @dis_u2_freeclk_exists_quirk : set if we clear u2_freeclk_exists
  *			in GUSB2PHYCFG, specify that USB2 PHY doesn't
@@ -1205,6 +1205,8 @@ struct dwc3 {
 	unsigned		dis_u3_susphy_quirk:1;
 	unsigned		dis_u2_susphy_quirk:1;
 	unsigned		dis_enblslpm_quirk:1;
+	unsigned		dis_u1_entry_quirk:1;
+	unsigned		dis_u2_entry_quirk:1;
 	unsigned		dis_rxdet_inp3_quirk:1;
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 8efde178eef4..3996b9c4ff8d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -379,6 +379,8 @@ static int dwc3_ep0_handle_u1(struct dwc3 *dwc, enum usb_device_state state,
 	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
 			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return -EINVAL;
+	if (set && dwc->dis_u1_entry_quirk)
+		return -EINVAL;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (set)
@@ -401,6 +403,8 @@ static int dwc3_ep0_handle_u2(struct dwc3 *dwc, enum usb_device_state state,
 	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
 			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return -EINVAL;
+	if (set && dwc->dis_u2_entry_quirk)
+		return -EINVAL;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (set)
@@ -626,7 +630,10 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 			 * nothing is pending from application.
 			 */
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-			reg |= (DWC3_DCTL_ACCEPTU1ENA | DWC3_DCTL_ACCEPTU2ENA);
+			if (!dwc->dis_u1_entry_quirk)
+				reg |= DWC3_DCTL_ACCEPTU1ENA;
+			if (!dwc->dis_u2_entry_quirk)
+				reg |= DWC3_DCTL_ACCEPTU2ENA;
 			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 		}
 		break;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d67655384eb2..173f5329d3d9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2073,6 +2073,25 @@ out:
 	return 0;
 }
 
+static void dwc3_gadget_config_params(struct usb_gadget *g,
+				      struct usb_dcd_config_params *params)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+
+	/* U1 Device exit Latency */
+	if (dwc->dis_u1_entry_quirk)
+		params->bU1devExitLat = 0;
+	else
+		params->bU1devExitLat = DWC3_DEFAULT_U1_DEV_EXIT_LAT;
+
+	/* U2 Device exit Latency */
+	if (dwc->dis_u2_entry_quirk)
+		params->bU2DevExitLat = 0;
+	else
+		params->bU2DevExitLat =
+				cpu_to_le16(DWC3_DEFAULT_U2_DEV_EXIT_LAT);
+}
+
 static void dwc3_gadget_set_speed(struct usb_gadget *g,
 				  enum usb_device_speed speed)
 {
@@ -2142,6 +2161,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.udc_start		= dwc3_gadget_start,
 	.udc_stop		= dwc3_gadget_stop,
 	.udc_set_speed		= dwc3_gadget_set_speed,
+	.get_config_params	= dwc3_gadget_config_params,
 };
 
 /* -------------------------------------------------------------------------- */
@@ -2251,8 +2271,6 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 		dep->endpoint.comp_desc = NULL;
 	}
 
-	spin_lock_init(&dep->lock);
-
 	if (num == 0)
 		ret = dwc3_gadget_init_control_endpoint(dep);
 	else if (direction)
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 3ed738e86ea7..5faf4d1249e0 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -48,6 +48,12 @@ struct dwc3;
 /* DEPXFERCFG parameter 0 */
 #define DWC3_DEPXFERCFG_NUM_XFER_RES(n)	((n) & 0xffff)
 
+/* U1 Device exit Latency */
+#define DWC3_DEFAULT_U1_DEV_EXIT_LAT	0x0A	/* Less then 10 microsec */
+
+/* U2 Device exit Latency */
+#define DWC3_DEFAULT_U2_DEV_EXIT_LAT	0x1FF	/* Less then 511 microsec */
+
 /* -------------------------------------------------------------------------- */
 
 #define to_dwc3_request(r)	(container_of(r, struct dwc3_request, request))
-- 
2.53.0

