Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC3CC88E77
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 786DE606FD;
	Mon, 14 Sep 2026 14:17:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cwxGTc4Xtdli; Mon, 14 Sep 2026 14:17:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C84B3606F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395444;
	b=tVlTZPmCmpBHRLcTC2LAbMWmz9iYVYQVlTdSo2ohD8yGjmihr0h1Z4N9dKJF3bMRu7oI
	 +CVSKc1coxN7uq8TvD3Xb43XfHdgNChgRKxyHWcdmUdqVW+XxNJLjRrwopvXcipewQTk6
	 Iu9ub7eUgo3K5OG0YgT74dXt/W0Lo7Sckt7ge2AUoKWUL+xIKpSIfPAhVaDipRBryrd1C
	 TopHjSYHBV1EHBKJh4xGPR7L9xJnv/tK3OlU2bngLlVT1mW5oMbGa2jfrScRjeHadNOIB
	 GNlFKank0ZA+AD7JBgTmHyZKoshz493yVlI2sIAcvP1vq8NnENdGaeDidEpjP7tOKMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lawja6GadAOLvSoI/ZoG5rzQdtfWch4+Uhia9kCpJsQ=;
	b=hYZtsDmrgq1mDKR3niD3a/dArkNvzw4teFo6ENixpNDtx7KXKN+h0/7aOFgTLGCB1GWs
	 dcmf+dc++sDJxNKHOZkYHUd/MQK9cKqZ304eVMAxibALZ7FOUFNDn6S87AK1uHA75sTr8
	 SeUDMEU0Jm0UlHZgv2TlHLv3UItZyFWcHZ89NUHwztWVeOB+duzJJbD5hWtsWu/vZ9fnh
	 IlB5mixJ2/73MG8RanvK4O3gTIeSZIFcO40C4lJ2yOXkEOoKB/V47XqnPLKJZ/dZ3xZO2
	 rMWbBbTX8g0UWxwv5yyUSCEYo510NzgKs/Xrj3aP/KG+GZGZElmPN79o7X0j+Ivz2Hg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395443;
	bh=lawja6GadAOLvSoI/ZoG5rzQdtfWch4+Uhia9kCpJsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zpx174uzxLSuAAArSSwwMe12nz3thrrFqzluhon4UzDKuwDYk27QWKvAqIXE4sj5C
	 xy9RkGdsyxLy6mkLt+fMUe/ctS1aumC8iy+YV2wqRKDVE9kgyE0rWsoXc2f+h4QuGw
	 QAltXdBMJ9GY95zkUaU1vJtwCHg0QGRy4Xb7+5v6UhXAYvi64g4/i36wnD7gOfnOqn
	 ZNUy0KY4BRQmaMcRa91MYumVN0ISUv6hQ74Bf1QFGihn9l3yw9EPDuPBh0iXweR/gR
	 rwNC6ddSpA8Nabil3QhdN17fc24hlEww2ZE5NumD7n9B8Ukbr4nR3gczP8Shh8ROnH
	 Xp0ynNmj2C/Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C84B3606F7;
	Mon, 14 Sep 2026 14:17:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 42D7429B
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34BE080C0F
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsHrkTBVQqeD for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 07:43:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5EEAD80A79
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789371809;
 b=XrtgteRRS6umPSlQtESztCYjItNQkFCrNsfVCN7cpJHs15Yw6NBBZJDJzYuqlQ95mQgw
 0Cgp59ncDHiVhCEW8P/0EbgdP6yKWRkpIIlJogLButa6260RC/FQry2+/U2/BMRLfPyd6
 4YEsIp0TeSDeKJNAyleG03rYXK5odYEUo4R8JfVDqp6Q8ErJ3Bgxym9hFmm8JvUGZe1ko
 FqhDwY7rmSV6mOf09jSpV+ZjjWW8b1WwbkDyShMYXgqjH12CZyDsPjAVzn11tor+8oCqi
 zc62xP49cFHFfOV1nRAn4gAEReIrRuT9y3mxe9iQb4Q7QEOqzaIgZxWmMUex3t5WEzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789371809;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=lawja6GadAOLvSoI/ZoG5rzQdtfWch4+Uhia9kCpJsQ=;
 b=o3YBB0IlSe+8XUdM/mU+gsFXPa8tQTdK2o+YvOMOhT3TNuXzZfggBBYImWYXDFx1B31L
 Jyt4HvGs68YskLNUhtrNFpLknJ/rrqXNFLThuXDqn90LRPWBmLfCZ6eetzwzhw4eWX1lJ
 geHnbeMIIgyUBMYN2kte72vbHkKQvnkiGvBj87d2cMNXMmG8imvJ71zm5vKtrPWUCDiQQ
 fPze7VNN4oOE7dUzre/Z3y1Btuq/zcoaCvhlEAuhH6WW30y9MDZZFTHtdHQslmZsWgshC
 l1LsqxH7vBHVQFrIf1i+wWhu54H6hg53X8HCYhYeZZixORyRxIqYHVbzxyCMTzghjTA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SFeafxfi; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SFeafxfi
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EEAD80A79
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:28 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so1940271f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 00:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789371807; x=1789976607;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lawja6GadAOLvSoI/ZoG5rzQdtfWch4+Uhia9kCpJsQ=;
 b=SFeafxfiEd3AKv4dgDxhjm2GN0DN3HeY9ixa3S8ZRG7vli4SuQxd7aTF/2IhM05iIW
 d0M+7+bFzbFh7MThCafZz5+dSRQmdl+Aahpai7BYn9AstRbe1uq/lxQ6mQqg4vULY02X
 UK+1/MhA7kAIkMkT+IGWj7gfnUcTLZDrca2tTp0nUhafOjTqrG342iWwrJ3RpAMoRqhc
 nXTQ7eCQRx/yHWFLUTQMvAp0UWQD7cePIyWwWXPI/4xLyml75/ZyBM9j8DQFpb4OzlO0
 H0LQeJG2PO78zl1QbB897iX5LZaf4K+lwxt/1M2V7xn3jdbiVmY/1fo7n8UluKhnLthp
 kPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371807; x=1789976607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lawja6GadAOLvSoI/ZoG5rzQdtfWch4+Uhia9kCpJsQ=;
 b=FTYuEwylApLuwuyYJ5Uo6qsQKPw6Z28CLonRWF4/pzVimrr+PtgCDx3MOcueMGraiU
 rxlmYi3O6ryzhspwqtKrPPLmuwaG5dcdEHiMravfhDxOxR7ebBTJ+nJeFhGG+Lh13gV2
 Y9PCobglIDW7jQ6hyMYCgg57skJRi31/Ob61lkUFqtTbDcOPapeMGtNbhY/RwVsVcMEc
 90Yx4bIgYSYmnJuZjL50OBO1g7yH+PZqmqYnntI39KOJbkmkhsuQANnWaCfy/AJeiS7z
 gFp+KEt+ueue6bqyUAG5omwr49vsgCzfKqREGFkpzcfGKkNIw95i4a5uRpyZMTS+dSYj
 78wQ==
X-Gm-Message-State: AFuF++kAlOBbYpQAJ8rVi/1sXk86i8a//d16B5hh2+cqDCPDPX3UVU4n
 2nEQ3Mg8XJyg1x/edxzcpSDEmF/j6xYGxfuigQwTskHisg6v9qF6nJzy
X-Gm-Gg: AYBFou1HY7ZckqYaZwqm2r+QoiHauueuDp5lvqCOBuLLcgxF0R8F54e8G6oRvuXyv+Q
 Of+60IkgDcKi/j9rsZwng2AI1wWNES+OqATfXdyApyPGet/8bZrQv5Wiv+ylGiNSCpoEyX5eA6q
 SjqTSVmkiV7OCb6wY6OnIwJTeyns8DBmqwW/K7lu3CdtEwuUuGSLFvnKCgScK/rOLWQK0E2SFlg
 HBqbYl6sePgDvxa4tpW1KDlIBa4JPM4EHwHqN17YiJga4HOXT9ArYMkzZ3fScAF5ycfvdU/7iON
 bXi6BKv7PNpn7mnHUJDimGNmZvFEH/pphfFCQLc6408SxoVMizUg24T7NZGHbH1CK5Ode7at1cn
 y1B/VEcw5MKf/JwTa7GtlOAJD6f+rScmwjssKXsOdH88uPSTb2uYUpOcA5tyqHg3BKKguURdNM6
 JGJ9FXUMiE8iAhshwtShaYdbKniNUAU/QceJv1GHCeykjPxGEWz6/uLTJLqhwcfQ0Z
X-Received: by 2002:a05:600c:37c3:b0:49c:fc6e:a3d9 with SMTP id
 5b1f17b1804b1-49e7a678879mr16242485e9.24.1789371806558; 
 Mon, 14 Sep 2026 00:43:26 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02c92sm184611495e9.2.2026.09.14.00.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:43:26 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, lukma@denx.de,
 mkorpershoek@kernel.org, antoine.gouby@toradex.com, alice.guo@nxp.com,
 stefan.eichenberger@toradex.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 ye.li@nxp.com, xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 5/7] configs: verdin-imx95: enable CI_UDC usb gadget driver
Date: Mon, 14 Sep 2026 09:42:47 +0200
Message-ID: <20260914074314.12522-6-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914074314.12522-1-eichest@gmail.com>
References: <20260914074314.12522-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Enable CONFIG_CI_UDC, which now provides a driver model driver for the
"fsl,imx27-usb" node. The node is an OTG port, so the EHCI host driver
stays bound next to it and "usb start" keeps working.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 configs/verdin-imx95_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
index daf41a8b830..77b22a2f8a5 100644
--- a/configs/verdin-imx95_defconfig
+++ b/configs/verdin-imx95_defconfig
@@ -179,6 +179,7 @@ CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
 CONFIG_USB_GADGET_OS_DESCRIPTORS=y
+CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x90400000
 CONFIG_ULP_WATCHDOG=y
 CONFIG_WDT=y
-- 
2.55.0

