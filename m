Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC22606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qlnGM67P;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JIAcY+DX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7A6B607CA;
	Sat,  7 Nov 2026 12:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jYI5d85KcgCx; Sat,  7 Nov 2026 12:50:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 187A1607E2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055851;
	b=k34ptX3w/K4j+0rvBmyh78t8Cpua2Ly4EEuMyDEJv+um0pW/dpqjcj5dPfsyVbqen97A
	 j55MyI38SNFuQNeP/hZqNp9zijS+xDyTBjqqBFxpQTtOiO0cv+rxklRZ/KV/EycIwBvd6
	 GbEbZditqcorRGsM5Of888QOkobjSMp0ZQhUlpqNCxpSc62cZTKu9WT1ogG+6N4kz+eEJ
	 ch6M0FkkMdf+hT1aIoTr8eNXbGiX84Uf9RQEH50dztqEuoUh9hPhM8dN8IbXg6J+dwKl5
	 03KJmMDgUJPkxXzMROLgcroECc6Q7vuodtoWujLIYFJdvZy4m4RzaxORR3DH9IofMLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055851;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
	b=bA8m7RXT7hAnhz4urqnFDGzCNWXM9uQtzTOPC3UWw+Z4KY1aGOT5n435cSLZqFk9efNU
	 oIa+ixoax4swfJEOcQYIbQcijldKNaq/eg4QUjGor+RaxsQqjjUs7sDM9juoTiHgPOjBV
	 6clcHBjw/7ayFpRGKa9z1/DU8UjSShlsCZlQhM4axZj14oq7YneSrE8WcZ7o0U4Qtvyuk
	 Axp+SaiaRPH/OxgSGv9Qw8A1kcU/8S33fDMWK08Lb1X9to920+bGNHZXZB6hPWeh/7AJ4
	 lysQCEwT9TAjDEzc6FTFjObmHN3yhZSXZNynh8URTsxYDiFGl6XMrIN8kR+upeRKp2A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055851;
	bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qlnGM67PshOP8DbHN9Lid9obYDMeAr87hqEKkseIGUe/IbRbzoQMSdc+047VOgHg+
	 MSH+ziTQIFaUNKofrZfo8Ra7AfO4ESbZ/O4NLb/OvhDn841xaNT6NctXC6WxsPVPYe
	 QOkteWrDuN8+OBMUW+78jAQbfln3arA7USHlSLcsXqxXZIcY5Yqo/ne+ezXoE1fb/U
	 zkXSzNF65Y75nH+fQ8rSd3GgNl7PnYtozhLHI+kiDe/JzihQQp2QUfuoMRfdZPT8J1
	 70xLZ6qkOIUV+LPDlqzwY79P6ceJcEuvtflWSPi1HjrG0tIgWHKp+oDkkamok1/vOz
	 kFKo55uuHClzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 187A1607E2;
	Sat,  7 Nov 2026 12:50:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7697034D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6812A81223
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aimpgc5l5z4c for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:24:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7E06C811BF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=JIAcY+DX
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E06C811BF
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:49 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b56521181cso215455a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036288; x=1794641088;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
 b=JIAcY+DX37jCdcZTC2LCZyT+YN8NCRXq9cRjJxL42jCQbUHZUJ0lx7G0sKyV6WfWdo
 9Iie2KF+X1550gKlMh2xSpikknMLBuIWc1Rvk2FL30fumLQK0moS9uHB+5QOlBXu9YKk
 iYA5REVMdiNmgoiiD19JINfNpMgThZJQ67EQ307kMKzd7dOL+BdA9FKdxs5w/nQDYJdg
 Rzt5EIo5AcY+5JMg98pyw7Kf9XKlr6Sa3zhq8DpMTtMFItSvKVf/X42W7wOU7fimnFGg
 AWFq6B3KqlVgGctpAoNnOHP4B6Ki7+2P2nBPnmO+vuGs3+zA1FPJRSswMEkZCx7fhjFn
 ugIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036288; x=1794641088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
 b=GCcZfDx7jS3bY34rgQc+f6gpSCmNkQfSwRzkA2YF0h7LSrHo2iEG6PmoA78y4unnoU
 KUDHCvrxAEc6e9J9U/FD9wA8xFPIw7/KFVekTqJhsNdy3u2sPfwtVK9j1UPKC6pB8se3
 n1lPGLnheJH0d4UhpoY2LbAREn4/KLbu1XzUGGornI47QHwvNi52X+1ALHwhIKXlY3yg
 8DczswkxWGtR0ImGOGaN9yGMiPl9UvdX4SKD9qQioNxs/L18b7pu1kNTvwAc7rlAHVf0
 SnE/AtegOzuson3sfBsZknlVon4yS8COymlFZtwu3eGcKzhKkplkGgJ/xr+WJOJ4NpBD
 TUDg==
X-Gm-Message-State: APuU4Z8bzfhrxKbJaZKKWOd4Yq/EoCLd+IeZiHI3lnuXrdE6ziYF72Rp
 7Dm+sl3QegSfAKwZ1PWNm7SA0hQ8Q02da8j/Tby8erlg3NjoIDBc9tjJt2nCSA+b3/CA1wqCeZK
 HaCMD
X-Gm-Gg: AYBFou1We+77DVwv4C/WtmSUAyYXzDafa5xOx0rl1tczdhY+IzLFUy5VpDMLxF1kNqq
 9H86wV2nGKHpxvLylt9j6DEZV84fe5gAHFrCTEV5WhXZkaWImz0eiA7RpAGCRSRsTqOeDY2Fz0b
 kNlU5VHL7dZ6LbGIBMVQFDSUe6RWx/Do9omKMOZKmVTqHaYXZLMkADk9cP85X9NghpHJqifWjjj
 8J2yRO2aU5K7LFIz0ixORKVUq1LLDxSQnzzfMp6S+LztlNs10s7m9ulDmchX0XCp+Qx3cudU1kv
 tLqmCjTfD9ts3f73Oy2P/J/gRkd+5pydfDoxNH6SMLy/djZczETowu209FLDDHqCYq4NrjbNzbZ
 U1CRFCRwuWZjhuw18nJSQ+oIXLDQcpKRYgIH2Pm+lt5nJHDEW1hREuqoPG1ft/bkbeoqWCb3Udq
 hZlmUPW/NSWuqwUjm8h7zOAGUfzIqJkKx37rCnMgf5u4J5YnSGPfVgv2p4YoHnsoln21JMrXiYE
 8KW6QesNYJRUTfDo87rVN/4f7LJKfg+UvuIExRmBs7UhuQLBkWS4abaNtnqf7CFAweZD6KCmXqS
 W6Z2MDjM0TI2i+Mukmto0Cr6N8u2PR80IHl0f0sDatVy1J8Wh5OuCPxGVAkxLIoPAeb5A4TMNMV
 lERBLV8mThA==
X-Received: by 2002:a05:6402:a186:b0:6b5:8233:4ce1 with SMTP id
 4fb4d7f45d1cf-6b5977d73ebmr3952856a12.2.1794036287987; 
 Fri, 06 Nov 2026 23:24:47 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664b165e9sm1476562a12.29.2026.11.06.23.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:24:47 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 30/30] usb: dwc3: enable SUSPHY again after xhci is
 registered
Date: Sat,  7 Nov 2026 08:22:24 +0100
Message-ID: <20261107072224.3492260-31-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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

The resynced core clears SUSPHY when it switches a DRD controller to
host mode. Linux sets it again in dwc3_xhci_plat_start(), but U-Boot
has no such hook and the bit stays off. The old code never cleared it.

Enable SUSPHY in the generic and layerscape host probe after
xhci_register(). That is a bit later than Linux. It is still before
any device is enumerated.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c    | 8 ++++++--
 drivers/usb/dwc3/dwc3-layerscape.c | 8 +++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2406f8446179..cd4170bcb817 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -278,10 +278,14 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 			HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
 
 	rc = xhci_register(dev, hccr, hcor);
-	if (rc)
+	if (rc) {
 		regulator_set_enable_if_allowed(priv->vbus_supply, false);
+		return rc;
+	}
 
-	return rc;
+	dwc3_enable_susphy(&priv->gen_priv.dwc3, true);
+
+	return 0;
 }
 
 static int dwc3_generic_host_remove(struct udevice *dev)
diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-layerscape.c
index 108b44c67eb0..afa31c48be6c 100644
--- a/drivers/usb/dwc3/dwc3-layerscape.c
+++ b/drivers/usb/dwc3/dwc3-layerscape.c
@@ -153,7 +153,13 @@ static int dwc3_layerscape_host_probe(struct udevice *dev)
 	hccr = priv->gen_priv.base;
 	hcor = priv->gen_priv.base + HC_LENGTH(xhci_readl(&hccr->cr_capbase));
 
-	return xhci_register(dev, hccr, hcor);
+	rc = xhci_register(dev, hccr, hcor);
+	if (rc)
+		return rc;
+
+	dwc3_enable_susphy(&priv->gen_priv.dwc3, true);
+
+	return 0;
 }
 
 static int dwc3_layerscape_host_remove(struct udevice *dev)
-- 
2.53.0

