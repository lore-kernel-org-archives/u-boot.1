Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78451606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MLQUlDmc;
	dkim=pass (2048-bit key, unprotected) header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=DFsBZsjz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AEBD409B6;
	Fri,  6 Nov 2026 18:23:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oF2aG6J8e-a9; Fri,  6 Nov 2026 18:23:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5309C409B2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989392;
	b=m+WOQSKNDVUaw8+1eMd3sY8H42+UHC/TQOAkwWvuqC1Bg+og61rxQzVPb87PrFha9zGP
	 D3Xw/rsqAV8sIYeVTSMFB7QLRebpSiWSon5p3DhFqGBvhJudMOtn+yKQWb+uDZI0CV9if
	 SgKIzgR7gwirwIRj+Cw6kumfrus5IITaDQp+ehmUX390wOBWHChvcuP0uD8prd6HSVryo
	 XroXzU+aBHHB5hk23PMIEM61pEUAdfQJhYR5dSBAQvi1rJZMQ+ZdivWRevfV9VF9T1q59
	 Q4VsEVqzToWHXSJfPGImgVIWThWIKnYfVgmJaTrhpMa22AZ+SzabpMWOBJsddS9+dyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q8loCBYkOVKrLTMIa6j6vkAIiPU2GkAK6rtY/3f4hmA=;
	b=nkfGDluRu4OnM/WuGxTHs9rF5jIhq3kmomnYisFyVF1I8tTuB7vdbWvciZJdK1HKgdQp
	 ITmthnwxz+sHRYSHjBRDRSxPQhx/ws6FEUUatmRFWjsdPZWLmIjUS/eKEbAc3phuSFShv
	 ShATXo1o+0PHNrdRjxAs+3/ox2ATeZGK+xqgEcMEoQ8/KakjNHSod2WL8Fqhbav6ALkAT
	 ETakH1qu5RMDohER8ui4Doym8UDkN0LJk+mjKmd+owCUOaons/0/zlsgPIx//FnMz/mfl
	 EBgSVNny2b2sXj4N1icD6K/f5ePOjtU/eyJdCX+FAdNfcqYXrdQttw3dhvmUKHRQ/Hw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989392;
	bh=Q8loCBYkOVKrLTMIa6j6vkAIiPU2GkAK6rtY/3f4hmA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MLQUlDmcaSatZIZBbQiFKJKLCYUK8QhISAaWnG6QBXWag6JaRDDodaeaGDmOYZ/S2
	 dzDgWcyhGVUZ6VViVzC85EjRIAaG2mCsdTNMJ7jf+uw/ToDvOmOe3QpxVjbsVgySwQ
	 oUR5AjBhYV9rUoOZOrELExp/x5Fe2ukQCOUBRPbxBddI+jxMQzxsnyJrwjE8KO0onO
	 eIUleTqH592QeM1YsL2KW/niPz7lBPjlGOa4YCwvGR/cIca8esaBcNEa4CQ0Mgh2lp
	 cLlQOUnRuIJK2lOZ1jWJSPztp3c0cYaTb8b/APvBuJLfSXHw85UyteWbZKcuK2nMvN
	 I+zAdqT3AQJqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5309C409B2;
	Fri,  6 Nov 2026 18:23:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD2DC32A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A37B2606EB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id letIwo6OUeDM for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:10:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CE0A8606BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=DFsBZsjz
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE0A8606BB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:33 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2e9d7791b00so6043895ad.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1793985033; x=1794589833;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q8loCBYkOVKrLTMIa6j6vkAIiPU2GkAK6rtY/3f4hmA=;
 b=DFsBZsjzOv9QuVBroxsn9fe0gMTUpSSl/rc/Iw6RbisWJ8/0X+ZZg7qcoEhiymdWp9
 yaWyQCDifehjkCWwWBlg2ENvWPcs7JX/d2UtaoQkLPP5lLTF3IjyxddJvlDE/ZGQdPVa
 /ALptxXTEOjzJ2BD4VKicoDtKiptyj21b7j1fg+Wehnho5ERRxKwg77wiqgE3tMpBk2E
 miu1lsoFrL+YqbMCGs2eCMfoXhrcOjuGbAgBrRmJpAX+tCIXkQxkPuuDgjZnBzx3lghY
 UjGq5SQIwm3rwSTZkFRVr78cC4Crelw7C95x5nkZAB9L+9WRsTFe6/6ijyzlIxn06sST
 3g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793985033; x=1794589833;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q8loCBYkOVKrLTMIa6j6vkAIiPU2GkAK6rtY/3f4hmA=;
 b=PZ2Q7HLwAIrAGIdwCGS9kZEMPLC3HRU+pwuND3Glg4MQAOUtUBPohyXua8fg6tDdbl
 BEe9BPFGCbDexoDnmLSHE6PVUOoVtdjAoUjQVLNszw/BA6zHuGFexuvKfUl1/ewKimWM
 EtMFVg3S9VBdDUx9zCXgCmIduVUnNKR7yw8pykf9ccdzTcCBBn/bZZIFADHH75ihqZ0c
 vE+M24JTyiBOM2GkV+XwtqwkbrvArus2zZHHrYQOMVGj4n+zHPy8MUhzRzY19P1sqwYW
 5rh5onA3LsVHBGaxkCH6oDNX21V/sRejq1rbTJZhfpq7Z4s4j5n9YWxMu8mCsMQTr+2A
 3JbQ==
X-Gm-Message-State: APuU4Z/nWW41oRMWt2xKFoadHUklPjvkID0e677YUTI6UqMB5ojr2Fdc
 0Wspnz9cexypoBrKbH9yrPcYaMLI7KVHC83AmYUH+C3wANOcjecYaICSTcdglb6qV/4=
X-Gm-Gg: AYBFou0gM4buF3zHctUSePJlybQNUTEaOzRrQgaxMB8Z8TvYZLv5p15TAlKZi/keJcV
 gY55H4u83wHyOQDxZNUlqmgu5h92xuq1qcLN78HUfwpht7TRtVcm00tN7R4giq6G1X3Wx32slaX
 wJZa4d0Z8pzn1ZZIBOUkXs4GgSDs7QC/Fnj8mAQwJ3PVZsZQU+epFEmDrBV3eJWhQb0iXwSnApn
 K09SMatDYbb7RgzLIcZTRuip491cW/wXD1b08pziZFdNFcHyUsF75C2DJlBv2QIt2Pm12gwPzo4
 XLLOmbTzEaDxIDgF7GrpZY3LlN2wRqM+T52Cg7tONYYXvCR1i/XM2qO01VX5lpP0fuM5AH7e2sq
 RHQ2P4u8t7dxaxCnaH2504Z5EYpeB+5mJlTzJF0pCRyEupynFMKsjkjSBgYBIDrfzEzLwY974iX
 dfguKjuAN+fhVhEmq9QAX5tx3auJZKkjhXO3PYLEihVgPQkAjrtJV4M72WzIH23gppG2xJJMeuq
 NggXjHrkx4YkmHaQmn2O9nq7BlTbJpVFEZgDJy1XkKxIFnHFyBZQWsAVQPmA4hnqZhv4lDF4MkG
 gnhHGf2+/SZmIkxY2LsBEr9mH1fxKfHJ8zZVNYYw+aXjA/1BZKBga/meKofpqRTo9yPEGqUSKYd
 r
X-Received: by 2002:a17:902:eccd:b0:2ea:7180:3a82 with SMTP id
 d9443c01a7336-2ed404dd1damr38212675ad.1.1793985032679; 
 Fri, 06 Nov 2026 09:10:32 -0800 (PST)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d4079asm7345295ad.36.2026.11.06.09.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:10:32 -0800 (PST)
From: Graeme Smecher <gsmecher@t0.technology>
Date: Fri, 06 Nov 2026 10:09:25 -0700
Subject: [PATCH v4] net: eth-phy: release reset GPIO and reset control on
 device removal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-eth-phy-release-reset-v4-1-191b196ef4bb@t0.technology>
X-B4-Tracking: v=1; b=H4sIAMQJ7moC/x2M0QpAQBQFf0X32a3djQ2/Ig/isLeE9kok/27zN
 M3DzEOKKFBqsociTlHZ1iRFntEQ+nUGy5icnHHeWuMZR+A93ByxoFckKg42qMvalh5uqCi1e8Q
 k1/9tu/f9AEJEmIhnAAAA
X-Change-ID: 20261106-eth-phy-release-reset-0e959156e2c8
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Graeme Smecher <gsmecher@t0.technology>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793984965; l=2652;
 i=gsmecher@t0.technology; s=20261103; h=from:subject:message-id;
 bh=CXzRnEknM9ap4z+AuhHDn6OJa5fYnxI/QSnLRsXbo/Y=;
 b=ZWkaOivVsmOT9GowMYIse41xIkpPGJAoCnKJtcWPsif+1YPNUUkWeBuNBsLYc0yzemldGKNUa
 kr4ZE3YnjBgAvex4b5GGLk0R1mkc3wOGmpc0yASMEu+FpdM5BIDlsyJ
X-Developer-Key: i=gsmecher@t0.technology; a=ed25519;
 pk=HArD3wunb+MyhiMSP+Hd9fErsJgMgfaKpINxIisnHbk=
X-Mailman-Approved-At: Fri, 06 Nov 2026 18:22:59 +0000
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

eth_phy_of_to_plat() claims the PHY reset GPIO with
gpio_request_by_name() and the PHY reset control with
reset_get_by_index(), but nothing releases either when the device is
removed. When retrying a wedged PHY, any follow-up probes fail because
the reset GPIO is already claimed.

Add a pre_remove hook that frees both.

Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
Acked-by: Michal Simek <michal.simek@amd.com>
---
This patch was 4/4 of the zynq_gem resource leak series up to v3. As
Michal Simek requested, it is now sent separately so that it can go
through the net tree; the zynq_gem patches continue as their own v4.

Tested on QEMU (xilinx-zynq-a9, xilinx_zynq_virt), with a PHY that
has reset-gpios and a (syscon-reset) resets property: after repeated
unbind/bind of the ethernet controller, the eth-phy device probes
again. Without this patch, the next probe fails because the reset GPIO
is still claimed.

Changes in v4:
- Split out of the zynq_gem series; no code changes
- Rebased onto current main
- Add Acked-by from Michal Simek
- Link to v3: https://lore.kernel.org/r/20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology

Changes in v3:
- Rebased onto the eth-phy reset control support; also release the
  reset control with reset_free(). Use per-feature DM_GPIO/DM_RESET
  guards, and reword the subject accordingly
---
 drivers/net/eth-phy-uclass.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/eth-phy-uclass.c b/drivers/net/eth-phy-uclass.c
index a13e2fc7c50a239bdea4aaeb6d77496cc86b3575..7ac1876f846abbddd23117db235a535eb96d234b 100644
--- a/drivers/net/eth-phy-uclass.c
+++ b/drivers/net/eth-phy-uclass.c
@@ -191,11 +191,25 @@ static int eth_phy_pre_probe(struct udevice *dev)
 	return 0;
 }
 
+static int eth_phy_pre_remove(struct udevice *dev)
+{
+	struct eth_phy_device_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&uc_priv->reset_gpio))
+		dm_gpio_free(dev, &uc_priv->reset_gpio);
+
+	if (CONFIG_IS_ENABLED(DM_RESET) && reset_valid(&uc_priv->reset_ctrl))
+		reset_free(&uc_priv->reset_ctrl);
+
+	return 0;
+}
+
 UCLASS_DRIVER(eth_phy_generic) = {
 	.id		= UCLASS_ETH_PHY,
 	.name		= "eth_phy_generic",
 	.per_device_auto	= sizeof(struct eth_phy_device_priv),
 	.pre_probe	= eth_phy_pre_probe,
+	.pre_remove	= eth_phy_pre_remove,
 };
 
 U_BOOT_DRIVER(eth_phy_generic_drv) = {

---
base-commit: 709a97a05df66e394f40d249105d0baade46f107
change-id: 20261106-eth-phy-release-reset-0e959156e2c8

Best regards,
-- 
Graeme Smecher <gsmecher@t0.technology>

