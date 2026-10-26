Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DDA606A322
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=esJ4rrEi;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hxf9xndt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CFE580E2B;
	Mon, 26 Oct 2026 13:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JVxAeCNEnBOD; Mon, 26 Oct 2026 13:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D762C80E18
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793022036;
	b=UqYk9/8Vuq+pt21Mytqh043+qz/iZftA3yqFK8VOHGFtrgdbOIaZbBZyKsuUa4y3UBw3
	 fNNVXp04hAmhGbCri6tK11WNWcEufviRSa+YUhoHpvC616Pd3lF163sTD/EtNpuqKev+E
	 2g9Q9EpP4sfDnFk2Sru0D4gv+FafjbnHGIG4k37E+r46Wna76kuDjlH6WM7ZJk3v8gmK6
	 3lSEZXPfb1XXe40RmAqNVwCxzXZJQlGDWXH+tOx4DCOG3ivqpAghqdqbSDH+mBarG1Tf7
	 VcplHOCOI+rQYZF9vlS/eGwPUyvqZu/9W6BNxXfa6oJuoTY+2UbrfocHVzV8/t/N+Ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793022036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
	b=sMc8WIFLpBpLfZHlP1kxLacqAn7o7IqmHvEI0VPrdK2z0T4UUSMovmTMDRzCAO6LFcRx
	 KuO1Swc0C8sTZ37rfHbPvv3cn9ExTq8aKlrvRi+qoNfaeOE5R3HdQE4J0gzVpia/JgFSV
	 feGwajYchS+cL/dXGwfWBn12HAfge8B1RF7NWBYjNVbTWem8lqkcS0C7VMQQvl7t5o9+N
	 U70TMj6pMKk3J3udpfBJxQmd49Hxiu3xFWvZ1lueKW44ak0iZ9s9znWUVbSrbB4tNMtkb
	 lTd9baBi4RoBwp0kTQhYTkXw8WCYVLCKg6MZNvAx0jNESaRL3QBL+O4NPLjZCZv5xJA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793022036;
	bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=esJ4rrEitxmn1DoCsaoy3gCv185gBtwoM/7iIiXTRNM8bN7LY8i6urVKkHyOekpGP
	 OQql2ZyAfyuA16jUAaz98QAmZ/lAdfbt3bPk1Lw19ePF+j9hKPyvJ9bfFPWpFS+96w
	 Buz+fX13ncq90QcOqCx/MwBpYM0V9IT78ZGaEdwCokCwJnu0HK3fdUVRKBROvNnRUP
	 380/4hqGlIALWmpB/kSkaKiRw34rEKwgzTh92QiwPFdtkvtHIvBGiLY6mul9rsd/o1
	 NRGWc8/izMVrMUjHunjh+kDg52BAr4GiZ3YkRmVds6DdqqjBCFaYxWCeH15yICIAJJ
	 0Od6zsfBuf9yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D762C80E18;
	Mon, 26 Oct 2026 13:40:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF5023B6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C55A660608
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id adVq14MFHcwF for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A1F3605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793022028;
 b=deqPOC9vXGNedyel8/91DSIL4QIIVYUb7+5XXyYZ9HfarwjDtXUNayRcGHVw5/WUU8mh
 IRBFxGrXmyAmfIuAiw5YGXsJ7JBbWbOv7AvIKznqbg8uCYiZzuyLlWGSVpReQd1piqKOD
 pPkLcdU6Pi+MqC/VxIoo7LFO62zv4UU+45ysLLG/OOjZb75T+zcThLRekeZKOZ6SAYx5s
 SsYWoJpkl97c4yozlHGeNrOqQ+7RViy7VtuKC7T2UaAf/BcbvHlKU3iUpfSQGr999CQE4
 0XM60BBT4D9PyES0naZIipDQFjySXC9w2CmJa78Y79wuBnmTPhloIGpuRsvIJTKvnCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793022028;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
 b=RoXQgSCQuOddfGVPfKZsxguJVrE7yGlaWqe+dG0w0ogZ55G5xRL0X9CIXwXN1DmWQidu
 n7Jd0z+OwSE+VgwII8H8rlLhPoHlLzAG0wwsrnT5+sIUFFSqdYI76rAC+A6soJqfIp74h
 onVFzcMlQr9d44GaFQAvJ2JJvmQKbZAbDyWtiSWD8x0bnb4oCsV69RxWHMtVnnq8VtqAp
 mG0xUcdOz/xVMmvg0gHmT9xE/GzVYW8fjS1BS04g/8/qFX2obOcfyLybwp+8G17FM67yw
 n/C9HnAtiVHiKMTEsZ5D8b8ZBJXsSLvoBdJsymoDLRQfYmzHMG0GdegEuSc1ldIiUxQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Hxf9xndt; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Hxf9xndt
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A1F3605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:28 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so25343065e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793022026; x=1793626826;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
 b=Hxf9xndtI7QUjb5LfJvUOEjhmkEFNCebjQd6wwSW6kKwqiavaO494kM2CCu+jdh1JT
 jbVM7M0iSpRmFI/O2tLZ6XEmdAeKrBgg3GZnBufRMWybhbuU6oNkl0aSXgMkFi+Ps21p
 /yBGky10d52K10YEyYPBY/f0evDIzurGVhhSnI07JqC+wCzE56hCagBKocYWIdaCFg5v
 Sbj+0WQZVeVzGEt74VmQ7pRb81q1+PbXtKRuGdrXD5HowW/S5mPUDq/3cwNpo4uyD6Jj
 /8qVb0DNU1Mec1y/2FyEkzoWKjuFvQoGeUuriEyfWqJttmPPhZYZBwaRwmKjyfWTapPK
 hayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793022026; x=1793626826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
 b=bimCW5nGF+9XXpSOHeo1qI2upzoTtPqlMtYuut9zz2O+qoGxDhSJf4YwfI9HQwCaCO
 tIVtJWDH5pYf/0Xoz3zp6G4EpXfQe+ZLF0AcOFeoFIwSI2Ko/2ZQuQhkjCV1F/Uu8US2
 qf4/jVh/SD1QfwzGZgtfHfHRf9s0cUqikijYYPnoAZyv3vq5I06uNv/1zgGAfn+WIg+F
 U5eZr3ZR7yGHpyCDjCRtk42U0eJWRhN0Mi9K67clpmXkDlG7Sy711TRlb4DbgGqUu4oU
 k5uK+NrTfDthGbLgeFosgLq94FBqkAmLcFRxUPXcSd4YH9d6rR82bHF7QWT2NJi7KBS7
 KsqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0qObS56vTSFPEqJLigR0EWQ9atkLwUb7hd3vK4MURlM2NXE5pDZiWcWJ8N3XrM7Kvt0Rp2C0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLu8PrKmXAyTTt8Z6VpWCCj7kKHdfEyhAxbleiT4c216oepq757
 so8GjLtKi6rXCVVr0Lq7MW3SWIBoYs/+S8crZJtO1zGc28poNvM5MJvo
X-Gm-Gg: AYBFou12F2r3QjL0e7qxgxVmeocz+kGgcSf33fhL2xwNjDFr9SmnXVeH0K2TER0nhaQ
 onRQ1ywxqqxmmjP5fHBZ3f1s7AX09YkGFPDi8rDNBIqYyGkxm0/RybjDsn9yaRBL/vLRjZN8GJ1
 ECw80G9DNmUCgl1WKk4QJuwwOEUKwzjSNm477oiykH1Wa/wM59Ml1HPM8BQxuNTHw/8wznDAiZN
 tiKbklBGzjgF9QIgfrqys/w1AKx7hR72oySI4HDWxMIvfUWj/dU5BJPktaKMskdxklWpJWmkip8
 5ZO3ZJ/WGoVSSSw8mt0Xns329Nj4ZWuQTOHPj0E3qfdnnLcUpJbNXP81Qi81NEV6xdGzsfGz/6c
 EIKYDhkUHcs4wmEtpGGHp/4f73LrQtCgVxt66MCRyU7iW0TPS6EJAMBMQud5Y5KEOFpbTpn52gL
 zdv6quACl2qOvZkmZqXs4J24xaSw+4bosqfxeQYRmFtTaa0iiHHJQ4oIPFI3KyoUuHNAAW0jdrp
 RpZ+uEOnPfo+3G6HAY961NuGvw4blL4vV0S0QPujNRJ1OSmcotW7AKaCeUCuMOmeSM5VtTbguOz
 V/SZ5wngvL4isznnJVCbe52gWIAlnTu459QIRJsSWUoM0CF7WrGXpLmr8vT5
X-Received: by 2002:a05:600c:4e44:b0:4a2:86b7:b76e with SMTP id
 5b1f17b1804b1-4a35ac95a17mr119359775e9.13.1793022026075; 
 Mon, 26 Oct 2026 06:40:26 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2c0458sm194344375e9.11.2026.10.26.06.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:40:25 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Daniel Golle <daniel@makrotopia.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Randolph Sapp <rs@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v10 6/8] doc: dtbinding: Update documentation for Generic
 Firmware loader
Date: Mon, 26 Oct 2026 14:39:59 +0100
Message-ID: <20261026134002.109025-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026134002.109025-1-ansuelsmth@gmail.com>
References: <20261026134002.109025-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update documentation for Generic Firmware loader to YAML schema,
generalize it from FS specific and add new property and example
for FIP loader.

Also add details on the usage of 'phandlepart', 'mtdpart' and 'ubivol'
property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/device-tree-bindings/misc/fs_loader.txt  |  48 --------
 doc/device-tree-bindings/misc/fw_loader.yaml | 112 +++++++++++++++++++
 2 files changed, 112 insertions(+), 48 deletions(-)
 delete mode 100644 doc/device-tree-bindings/misc/fs_loader.txt
 create mode 100644 doc/device-tree-bindings/misc/fw_loader.yaml

diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fs_loader.txt
deleted file mode 100644
index 542be4b25a0a..000000000000
--- a/doc/device-tree-bindings/misc/fs_loader.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* File system firmware loader
-
-Required properties:
---------------------
-
-- compatible: should contain "u-boot,fs-loader"
-- phandlepart: which block storage device and partition the image loading from,
-	       this property is required for mmc, usb and sata. This is unsigned
-	       32-bit array. For example phandlepart=<&mmc_0 1>, meaning use
-	       that MMC0 node pointer, partition 1.
-- mdtpart: which partition of ubi the image loading from, this property is
-	   required for ubi and mounting.
-- ubivol: which volume of ubi the image loading from, this property is required
-	  for ubi and mounting.
-
-Example of storage device and partition search set for mmc, usb, sata and
-ubi in device tree source as shown in below:
-
-	Example of storage type and device partition search set for mmc, usb,
-	sata and ubi as shown in below:
-	Example for mmc:
-	fs_loader0: fs-loader@0 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&mmc_0 1>;
-	};
-
-	Example for usb:
-	fs_loader1: fs-loader@1 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&usb0 1>;
-	};
-
-	Example for sata:
-	fs_loader2: fs-loader@2 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&sata0 1>;
-	};
-
-	Example for ubi:
-	fs_loader3: fs-loader@3 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		mtdpart = "UBI",
-		ubivol = "ubi0";
-	};
diff --git a/doc/device-tree-bindings/misc/fw_loader.yaml b/doc/device-tree-bindings/misc/fw_loader.yaml
new file mode 100644
index 000000000000..9a767ff57469
--- /dev/null
+++ b/doc/device-tree-bindings/misc/fw_loader.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/fw_loader.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot Generic Firmware Loader
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Generic firmware loader for loading images from block storage devices
+  (MMC, USB, SATA) and UBI storage.
+
+  The fs-loader loads firmware images, while the fip-loader locates a
+  Firmware Image Package (FIP), optionally at a specified byte offset
+  within the selected partition.
+
+properties:
+  compatible:
+    enum:
+      - u-boot,fs-loader
+      - u-boot,fip-loader
+
+  phandlepart:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Specifies the block storage device and partition from which the
+      image is loaded. Required for MMC, USB, and SATA devices.
+
+      The first cell is a phandle to the storage device, and the second
+      cell is the partition number.
+
+  mtdpart:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Specifies the MTD partition from which the image is loaded.
+      Required for UBI devices.
+
+  ubivol:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Specifies the UBI volume from which the image is loaded.
+      Required when loading from a UBI device.
+
+  partoffset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Byte offset within the selected partition where the FIP header
+      is located.
+
+required:
+  - compatible
+
+oneOf:
+  - required:
+      - phandlepart
+
+    properties:
+      mtdpart: false
+      ubivol: false
+
+  - required:
+      - mtdpart
+      - ubivol
+
+    properties:
+      phandlepart: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: u-boot,fs-loader
+    then:
+      properties:
+        partoffset: false
+
+additionalProperties: false
+
+examples:
+  - |
+    fw_loader0: fs-loader@0 {
+        bootph-all;
+        compatible = "u-boot,fs-loader";
+        phandlepart = <&mmc_0 1>;
+    };
+
+  - |
+    fw_loader3: fs-loader@3 {
+        bootph-all;
+        compatible = "u-boot,fs-loader";
+        mtdpart = "UBI";
+        ubivol = "ubi0";
+    };
+
+  - |
+    fw_loader4: fip-loader@4 {
+        bootph-all;
+        compatible = "u-boot,fip-loader";
+        phandlepart = <&mmc0 0>;
+        partoffset = <0x100>;
+    };
+
+  - |
+    fw_loader5: fip-loader@5 {
+        bootph-all;
+        compatible = "u-boot,fip-loader";
+        mtdpart = "ubi";
+        ubivol = "bl31";
+    };
-- 
2.55.0

