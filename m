Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7834EC55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:34:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36E2980FD8;
	Thu, 30 Jul 2026 13:34:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dTPjQOnyEJds; Thu, 30 Jul 2026 13:34:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9BFB80F8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418450;
	bh=rzUraaaevPzNaw9hF/iXQ5y4DeOHe/eClCVZxB4kUUs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W4waNWQP6hvLihtEqkfiPv6hnlO/WjoT4vhnCmOwivhWn7cS8ZNacMKYEqiK6m+nz
	 2RffJMRiZyPnyO4yHKebOvV2LK0gG3P7ALug2OKJdkgisDt+72zw26cYp7GEDCg6/d
	 IZ/NG99yUZl7m3vv2DftEkLmhjqZdwVV1FwOVcWGrTyutaRRVQWFnVduaX2F4kOwJM
	 0e6p2kVAk7Cm2woYdGSGMCmCGRcs85mboxLSrt42G60TKpC2p1g/tAWwG253wSBegN
	 r3fPwRJZyobZ4XIi3PdrEEOGg6NvPkY5jm4dzwPueTX+gL+XzUi5uxNHDYsIGt52UJ
	 5mrbJn9tN1wsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9BFB80F8D;
	Thu, 30 Jul 2026 13:34:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 38CEC197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AEC060895
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AdjgnuBB2c6u for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:34:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 452616085F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 452616085F
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 452616085F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:34:08 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15c1f1be0bso29312266b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418446; x=1786023246;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rzUraaaevPzNaw9hF/iXQ5y4DeOHe/eClCVZxB4kUUs=;
 b=ECleTXNXX0eKW72RVOmiUJz0ZMTJ7yFty74zTXNDRH1Kpjq1QnNhiqy/cpzsn5a7XA
 HrMG1RUkBrorMnVGvzlrZPbsdcGFVJ0Or8fGHEcXfI3vd21Pqp0QDaXSzMX7NT6oPxUH
 e8rO6ucWT6re7CmCKrVEIkQnbSw5O0Ac9jSbPjUGwPgs1nbgmay+WtY9SAXhWTaH6H9B
 LFmAalfkwiCf3yRc45+ZEYitHHIy6SI2JX2qN6owKnUAuwZn0VrpnQww1/cAQBm1Vwfk
 jmPPKw3eKFIXoOHyOvucEBJNsUKTFBvtAS12m+q4gdkAWm/T+PzGZ69C91rMoccNS8z7
 hbZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPCEu8Jsr+0Y9vZBx4DN7Mje4TExdpvFtFvFJr2ej7Gk3BiNATaJCBysczXMI0hME7CKK4Vak=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywf/avvYHz4Q7NzU4EOARhYMlR8BexY/AFy60CHQ7lZXiaofS7Z
 eiPdueuWohWbxebY8ZzhxULixTs/M0Fik8nlfTldNsH3cQng8b9Kz5Vu
X-Gm-Gg: AR+sD10vfTLZnA7Y5wQsADLHUV8AwJYUSan9EWgTCrgGbMlOFQ0Kjoa7N+B7oD/clws
 cQg7halP/t1xxqMHY3zr2QNZ1/nnEq1xtVa8JLD5rxhqy3Eq9tvXQk44/ntH7QgB0KgGRUO45eg
 R1sESPdGFJMS4RQluuTeys1llrei9f/gn2PpNOEwUxvFMiEYupgDYRntfa4ChnEEA4B6iywVjJi
 tnUZ4Ztl5RDmTP4UsqkD13QflGxT7bqTgQ+JRmvqNNpW7H2g72+O+0+lIxOYFEQLO6xtl3ALxwD
 pE74ktfjsHodqE/bP0ndMMB8N5s2YDua13eRC40MS6Sd1aG2eqyZHlGAeApZFizy+uZwgy9wS5g
 Ln01/hldBqJTXRzdxyGQKmPkZm9fAf3pjwHFGGa8UQIJdNdA01+zsVfmQwMJKt57gJ8yEKj/Iz9
 eRJWxQA2W8Gp4GHc/AWzcVUsImw4snYREML/FrjRltildKcTEvXpPHRTOy/Kk9tMePYMt9EkgvZ
 d1CT4RvRL/mqraUQB8ox1K7LAxz
X-Received: by 2002:a17:906:9f89:b0:c1f:4754:d87b with SMTP id
 a640c23a62f3a-c1fbca0d5ecmr32291266b.1.1785418446056; 
 Thu, 30 Jul 2026 06:34:06 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851b670sm68624666b.6.2026.07.30.06.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:34:05 -0700 (PDT)
Message-ID: <9958b697-d8d5-4505-8d39-36f735bbc05c@gmail.com>
Date: Thu, 30 Jul 2026 15:34:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 05/12] rockchip: doc: add more building instructions
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418446; x=1786023246;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rzUraaaevPzNaw9hF/iXQ5y4DeOHe/eClCVZxB4kUUs=;
 b=VWsCVSYdqq9QO1t0lybnH9/ambTf3AwtxPECG2fQXyN7I8bFSI1pC2D/yA/PyKBoN9
 OmEgvGccv61anRmwQ0vyeShzW6+WUxZqcUmrhRGE0Akb3quqri5Gv+2H2g+WqBvDFv13
 xC5GhchlSn1FTi6qzjM6EsUYPp8sA4BaXoZE2HFEkQfTzzw2HQHmTPTTKTtuIr8/m/W2
 T3/b/uIsm3J/TLdsrN6zr5sI7nXjulcjQkKvXg/36IRu2G59+BCmMKfhGns/qS4n/a4E
 fw+678igE5zY9GQxwq0kBPnyEXcsD/TTF0iC3wh+4BEuWj+nXMTkplWuF9irz9FBM8cD
 X+DQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=VWsCVSYd
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add more building instructions for existing SoCs.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/board/rockchip/rockchip.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 04ea191c0e1c..af5c00591234 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -241,6 +241,13 @@ To build px30 boards:
         make evb-px30_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-

+To build rk3036 boards:
+
+.. code-block:: bash
+
+        make evb-rk3036_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
 To build rk3066 boards:

 .. code-block:: bash
@@ -248,6 +255,27 @@ To build rk3066 boards:
         make mk808_defconfig
         make CROSS_COMPILE=arm-linux-gnueabihf-

+To build rk3128 boards:
+
+.. code-block:: bash
+
+        make evb-rk3128_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
+To build rk3188 boards:
+
+.. code-block:: bash
+
+        make rock_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
+To build rk3229 boards:
+
+.. code-block:: bash
+
+        make evb-rk3229_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
 To build rk3288 boards:

 .. code-block:: bash
--
2.39.5

