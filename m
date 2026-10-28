Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125A606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kMEoiddC;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rh2rOZaE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6215D8195C;
	Wed, 28 Oct 2026 14:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zt3qYfeAhCp; Wed, 28 Oct 2026 14:50:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 346C3813AB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198929;
	b=eM/TUu+GAA+lLscW6CZZ2/4ew47qm0ySN/whsPPI4PHAFxBmiaGZj4NZFmN67jbutpUl
	 8WZkUHquXcXB9JAbCYlvNA/8xrt3k4p36yCxSrNHqBvdJLFMhrCPfybyI8vLYHk4ubNdc
	 h1o4kZI/ka+QcKd66yqoFiAunI8aUcNlGER2AkShARsGDnpuxvC3v6RzrzlnFqxf4lzKG
	 FCScXLeZMi+9uczEwB5WYTL5kHL4ZMC5b7mWhPocqaw3Q63rmXzfDiXOQGhvsCoXTO5Va
	 VIarpVW7LApDxO2Qk+fdY1CxlGcUrDU4JY9fyBxeBVP5QAf9v/vFB8/73U3RlJpcw0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198929;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
	b=BFWi6m4qUrrkiAkzktPQy1FF5sqmXrlkezaOkuTMBqUK1gRkCQRfx9vP/48ggyaj+h+S
	 TTIfh5hFllAS/DvTXd5qoEdib28vUa+nuYGyHkX5VQ8Sr4QrrgMpMJCV16pFR9lLz8qNm
	 lR+/JllLPtQ1QbYqzaW3lsZhc/jF/9gNsMaW37oX3h1lYAH+XxyenPRrrD0XkvBRAlGuc
	 aspkviATjywNWbb73UjfVU6c2RDmqaffF5ixHFBI3Qt2qFpXuFXYxV9VKncRs5KRbMmo1
	 KpFwMAoiXAoYobkhDU1Oz0hDwHK4o4oXy0VUMe4s6W0NNie6fJZ7yXShPJbcNgwvfHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198929;
	bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kMEoiddCCu2MZ6maN6Q3CjUPMwU/J77X+lKKDfPiH81XTLeJQGSP3YC+r7nzmgaGo
	 mDL1ktyhOTBFkPsFAMgCKpIHGMUx43MiC2fzyP2aC+xEYd99LUweDr0eNd7BCoDNT8
	 mCSqsR4VJmoEKE9+JYxc3ZX+/EDL35Rict1VS7vi3PyuvxhqMCcO7cEQfln82FYrHG
	 29bfu7zR/jVhJmOLz0c4K0fb/OnxMSI0eYKzTyStjUwM9RxzYv/ntxIHnoG0p4sxk6
	 0aPMdsizx9L6SMIp/z3nAO6AYpn1fwXuF66zr1nJyn5cVBrjcwymY0LAuF01N2uGIS
	 cNWlCRG7s5wYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 346C3813AB;
	Wed, 28 Oct 2026 14:48:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 43A10972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29ADC40557
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GgOPRQ2nWF5F for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 44D7F40550
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197072;
 b=ntqbTxruJyJc2DseiPjRF+llt1o2oCcTkjNWQLC0J0b9A4u5eX5NajeF4SJmMl4uVWbX
 o3AAp29qOVpmv9tfOk1/fSFYh1XFG59A5cOO4Vncn4WPGmddxMRZ7lpkg5UaH6nRtJ23K
 4wjn217gNtBN+QdZms1MzdPRnfmZ66EJuonYo4iN9mN9CtFeEl0Wdd3RdPwxoFVoe1OZR
 ZVxd8HHoo5Fc8utNRgIfCjr6Pffi6FZHfgAOD48g/jnnZVzT7c61oYNIpHaH2wCJ9nIac
 ITGHHlFSoOFvsYEitVdUXjPO18wXnmwOgp43GRlyfAnXxIuByQ7ttR0Dp0RWBjkdbYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197072;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
 b=iK7vrqzNiEZohSA4eEH/njdEnqM7sQ6xecGiInXs2KuZstxO71h5oWFhv7l58GWKn9Ao
 o0VcKFZL/+FAzTXB3RZwZcEsXp/IDpLQBdzGQnusWUAaUM7MfLNKxK6lMJ0QZXS78YJsi
 Ycb+Gnvd/IhSsSLwO/usxVSBNfbbKuzaRxU6D98Ela3ioFg2PmGJX95tkLhTXlg8a0WF0
 1+TXB6YmQ5sse7zY83dUNilIpBqm84+Lx1fDJmgvZ6Fq/+vZKA7X1sVDK1py4PF2vkW4R
 IS8lN82gKjWLwnETCW+CDF6E8415lqBmdcfHpyv9ILKJJrwBx8s1/YQpUWUNYhw8aSA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Rh2rOZaE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Rh2rOZaE
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44D7F40550
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:51 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c407213696aso10490466b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197070; x=1793801870;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
 b=Rh2rOZaEHWuo5/LRMHxr0EqLofRMOHQR9Ha2MF1CTuxgL0QWLhrF0Zc44BTu4T1M1D
 ucPTGIuP4tbfAmyLCszqQefY5ra8hpwsgiM+8PQGWJb0ZGPJJztX4KABjsU6UNYE2LVD
 XnHaHwkjNI9E17HpQBJaWJ14cwuzMlvXC2UhGV8bOvWYoq8R7WlTxzEBMTTiK6sYjf0I
 YBb9seayxIb6U+XKgMoocVR70QcL1LOPWB4LwJzHMhfp1xYfGi8BlESQJ1L+FHx+qqr0
 7BfoOnZ1Nc2q8LBuNFtUnMpvytQ2kAs/MSq4v2sQnPxGs+h6TZ5Xj2ySqFqlismz4cL4
 opCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197070; x=1793801870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TbLu4+BmfBOAc3klzg50hlo+gcQYDPB7oC3ERAwixmA=;
 b=Foi+3yTa2yjEkD/Hrv+Q0SjVUDjsFMvLspjlFFt41BVmpTeSCc1XtmHzrqwiRxKCRo
 jM2vBp9wRmUy5mP5RCEnf2+bXUO8DDLM5J15iIdsqIFdIf+CxRQ4vX+evZrW39lIrYzx
 gcSag21zpADXn0TG9Fk/Fx76pmpbtQ22x8CKPJZZEpKuJgC2FcQTU6O2BOldK6/2XpmJ
 p8u9W4GJYdhghEFJMaTRgNlPMiL6kZBJdrTt1G/fR1AV/kSoEQK0/XqvRkDucXzN+J5a
 wlWy5IYRSpDBWGRgPBJGABnQIDTNPmKAxMuGzcVEDhbrszC/nRtzvpk/1X3D/xin1p1K
 aVBg==
X-Gm-Message-State: AFq9FYJsJ4l9P7IQo5WBss2BQQjbGfe6llfkq3P6QewXKaTOttXazI3y
 2HJXatBPv1bDRG6thPLzZyYxTV+0duVg6OEKxqyHz67jg+4ZKWJ9XBjtibvKSvTVQ1DUkCrnvib
 n40uX
X-Gm-Gg: AYBFou0z9lhnKsf8am91AVzEkcir8czaykxaLCaNGOSX8UasFyVz+elXxgkz4NTf0hB
 8dr4m8SlAGofO7wAgIwFSV+M9c9jYGVyuXD13zf9rRLrh1SI0EZXDt9yJCfFf1ukCq1z4Az/nxE
 mRYtL43gNodI289Kx+OBCtXaFIRc71v0JPknOx4D/taMICM9zIzY6wak0LE+3LLIFyB+PjOz7iX
 yvDPLW7zZs6m1ZbwfLdeMe0B3JHxqV5Hwav2/kGxDDkIxFZSzuBnIXN1CsZbqyS2ndPhr4nIrnH
 Bt69igrIb3pPTiTfKeeXwHiVQ9+TBKQgvyNHnodNpubdeNihjL93kVryyPOvbf9UZ61wvgiAFLL
 gbfKx2q4ocu2OJP/TpJ8HAVa2KZ3Qe1KtRY/cVQOCAIGzY3KAw4aKQMKPyK8QjvHR1I5N907gDF
 ph0QGlUcp1fISD5x8nRDYONWLuNKx/lBaJu/xUSGlnQVcod1G4uoVATPm0TR0WxcElIG4b035oa
 wFax0cL+lu603+Vip1kxlrc8UHNdAV9nPkKnI2UdRawDeUJXQx7B/OXoRy9NVOMePrsqXp8oOS1
 1WoEBF7FhEPZAfb5I26P/x3YYDtxnEaKoC08sVDza4qbnfWicvxl7j0JZBBxXFiXLlweQmr5QZz
 jdCpTpp3BSQ==
X-Received: by 2002:a17:906:d932:b0:c43:f1ab:167c with SMTP id
 a640c23a62f3a-c49bdd9ab19mr230752166b.1.1793197070091; 
 Wed, 28 Oct 2026 07:17:50 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd0f6f1asm618675366b.0.2026.10.28.07.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:49 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v10 28/30] usb: host: xhci: fix up after the resync
Date: Wed, 28 Oct 2026 15:15:52 +0100
Message-ID: <20261028141554.3073545-29-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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

Adapt the xhci glue to the re-imported xhci-ext-caps.h.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/host/xhci-dwc3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 3504a7cf42ce..488d39fe72fd 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -51,7 +51,7 @@ static void dwc3_phy_reset(struct dwc3 *dwc3_reg)
 	clrbits_le32(&dwc3_reg->g_usb2phycfg, DWC3_GUSB2PHYCFG_PHYSOFTRST);
 }
 
-void dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
+static void _dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
 {
 	/* Before Resetting PHY, put Core in Reset */
 	setbits_le32(&dwc3_reg->g_ctl, DWC3_GCTL_CORESOFTRESET);
@@ -79,7 +79,7 @@ int dwc3_core_init(struct dwc3 *dwc3_reg)
 		return -1;
 	}
 
-	dwc3_core_soft_reset(dwc3_reg);
+	_dwc3_core_soft_reset(dwc3_reg);
 
 	dwc3_hwparams1 = readl(&dwc3_reg->g_hwparams1);
 
-- 
2.53.0

