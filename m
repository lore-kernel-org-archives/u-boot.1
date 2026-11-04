Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7A606A329
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jf3Rbr11;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mPsHO2if
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A216F60759;
	Wed,  4 Nov 2026 09:48:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qxrNGjATtp8x; Wed,  4 Nov 2026 09:48:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC52F606FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785728;
	b=rQz853KrIa4WFclH3FJ1lMMia3k4dwqRUREE5qNRWM1haAYyAAosF6QKjSOX0ogUh5zD
	 s40AVWpduG/8vaSbI13j+oQJ157lLqN1Be6Vwni53anzXV3Q6NA5mR/6KzOVeQMU7tKql
	 eig5DZY17rPbiRW9fjkDRN+IcXfgBZLrvqB8MvERaq0V7+xN5TcTTM7vQEy0pLo1pJtQz
	 8/AkHmqMISvNysP0RXwp1uQqvPL1F3N0ejtPyZ7ZbV87h/cb+38yr2rErA5S28j1AuSu7
	 OA92UVVa/EYGxYiQkVtZwXU67NRcAp9tMIymLzPX5GHkR9dZLSfhDmrMoUfP/dYpdoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785728;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R+yw19VjxrJgcg3JhIiNat7wKimRdAvK5oZ2p1v/1s4=;
	b=lphWXnbuWd169NxZxG7g+dleMzJRCepGix3wKFA0ozm6wXjQXNO7dQjmuJ6zH4yQcIYQ
	 gNxg7AKk19+SFh7BfvlOJmoNbyaJzt5Cb4cFslmCN8yjoTeKQUH3Lp9h3zIvhoTdwOyWf
	 hAZalEDaJIZuQkpv7SO77PYGpbjdLz1VdEtI0+y3YdiKQav7xb61qdzGd28tS6RsAgohP
	 n9nQQigzsOWi/jqAZumqy36bf/rvpi/YoRI8Om6MSOOHnljIynl9pGnN9p0BBumyLPMdP
	 4mlFuDiTpzkuPCuEXhrUAyi3cpH6FE0UndPW3KgMs0BPt+N1nSM5lpKW/10HaoBivLw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785728;
	bh=R+yw19VjxrJgcg3JhIiNat7wKimRdAvK5oZ2p1v/1s4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jf3Rbr11aEoPGOYrm7JE+mRFbVDdQq84G3nmyyN7GWL3S4F3V/O4Gqo+/Q+y1YSFy
	 77smUTkoQktVFLYtZAXP6W74VC2cfGFJws1N6OG2/L57ahP5SuyKH5bw45ZV6UB0Ur
	 9RhKutYvsroOpx1y6EI2e4csE75tXkuW+Ftzhss0bBKx9pUEqImXR9Lx2biY6ZALcj
	 kt1+Fd5ID6ddWpsN++SZSSIU4/oJMcnq5LdB0GdjSqvEAPoMPUflud4qNvPtB4ZEpG
	 SKQ99wZGiN6cnziCeKeZSxdiNhmK9ItyGM1ep5Ihcap7k5PzPoX2Xy0z3nKBdSarmo
	 sh5KHpW1FAFfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC52F606FA;
	Wed,  4 Nov 2026 09:48:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6239337B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F9E9406F6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cCOsSwgGgWA for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:48:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61DDA40652
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785720;
 b=k0yj7Pq/8fJg99FO0W0tSnLwrbazNrvqmuRjypYys51Cy9QYaDSVx/d+UDFDn6sclP4S
 gn5r2duI1xW5aXx71/j4gq2vkm13M12gYb/QZ0LrqEotIC9mkjTNzbbm5hWjYgj1eQNyZ
 y9W65KUO/rTm6Tu8SIdo2QoxbTT3Mp9LFJeNaghJrz1ZuML+b6ruUDByhv/OU5wqulCVr
 qzqjjzPuzUljJ7b2wr+7/t4AO50nuxEiLE6rK59JKa27MKmUokCap83d9mkn2DaOHUXAs
 1X2uLixszH9ts7wnB0lk1u6jwGIF4P+BhPmKqnM78fDyS3uppV3Bzig1btpIoRaQMGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785720;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=R+yw19VjxrJgcg3JhIiNat7wKimRdAvK5oZ2p1v/1s4=;
 b=ZRSxjmiNykmy47/US1NqstS2uLz2deIVptJESIx2XYzWPeoSkl8vgqtxVCSDGSo9OVIc
 WCU15nk/zI28B2XiUU7NdWNj5D3yaVj9bk+37OywL7V4FlUQRFPBvljeEwY5Rdc7jIka8
 2OWxlc9w80/h5Z6JYcLr7x8NnMES7xBQwyo2OV3BYPwJCYlGLo/VBqmAiGvQmvk/B64MS
 5rGiLDKHJ32X1jk2mczjMIm41YdCDzdu3rz8EfzZEbWoZTRfR8QbYzKl6c1E/cOhUjZ8f
 KeIlPF2hqnl/jlz2kbaz5t8ngMylHYFMGeo/XP0vAlWJyeSYtw2Wddh0txudrpdSYDA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mPsHO2if; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mPsHO2if
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61DDA40652
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:39 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso3476975e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785718; x=1794390518;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R+yw19VjxrJgcg3JhIiNat7wKimRdAvK5oZ2p1v/1s4=;
 b=mPsHO2if/yqlz+QxPfBlkh24l0bNAlK5WzxRMUn1PKB4RI21BQ3CXwU9GLl7+ffySZ
 EZCG9fHCYHicUu/cSnakLStyhtiRM0dNp2WX/LUFR6yx/D3jk2p0fSQ+6T2+mAtm2kCM
 z7xuYa4WlyJdgd6ox+l5n7pGV73m/7YEeLrSMj9DFEUCJsz16PEaDezn5QmU60DjbiTY
 oecWmAgX62gqABHSV2/2lAr7uc8LrZQysUsXCW+xCQM7wH4S0P+ZLT3UOSMtesH8WX8w
 /Kl2nn7VAS+q1aSoSlk0P30WCTtq7LmfVlB1G/zmeP0+jFxLYoqnObWJt/q4QiW+yJYw
 YJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785718; x=1794390518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R+yw19VjxrJgcg3JhIiNat7wKimRdAvK5oZ2p1v/1s4=;
 b=WHo0comGxCBPbuBzZRLiEug7COVOiKzREfmiW91eNjTDcVAvAmssTnlTNDRzO36Kef
 w0Tk9IFA77dGS35dZZwrLON66S4GgSskBV95Jl1hPB/ADpvha3YkA2gYeDdAZc9olrzM
 mygKCfDI3zpPm1cVKLz4xz8gFR4V/QgKtZKey7GrXjXDORmirVqADDf+9cqIWUcbZvU3
 17CDSkxwCkw0/v7E3Lf7b+x+nHmb29QxnN3/i4pECNJAQYp54EFy7rJTUYUfhtCinXxr
 9Wo3En6T3OxLBzVWktl9XPmLm8QX+pgQeX5ZPFdxIHhkhRRuiX28sjvdGkYzZY9KKEg9
 IW/Q==
X-Gm-Message-State: APuU4Z/KNm0/x+KCe4V/Hyj1ArZfwGUle+dFJQEcsSrh1nQTlElmiiym
 ik2oAiYHIy7zu5gt3binEQ9l7d01gGSHWzRhtwdPJk7VQeveoIMhA/Epy8YmrfAr8TE=
X-Gm-Gg: AYBFou2RN/UkwDVy3MiIHRXvc1sATCnxOWFdbrkyKEUFV3F2CLIjnoFIeQwA6/9MM5Q
 IA/r2vvkojjA1KV+inhgWZTdoxad5ebhFjJMgu1sMeS9v4CrOeobyaJ4Ke0MUhkN6mzApZr5gTP
 +/DogFIT29OSlwl0noZFfgRr70SNEGOO3DecrDkd6cumEsavDgrWvptdAxCVQYdutGoNl94dvt/
 AtiXroQFL+7Mctt9IzqJApcldigjcMNFb6FvsWGYnOoABk+UiLCoqvGmuWP3eSV2WENCseeSTXW
 KlJYsWnjutjRJQeivNwMWmFfycfzhAeAaXjgsM2J+bq9tv6S4MQ5+2k4rF8/qMXERWvp6GGjYWe
 Lf8AP4quJq+nvlTzTKDU7wG1/Eqi0N4rncGGYu+47/m5aLTfyf6LOmYKr7H52rEhlASKmz56Xyy
 YeENcedyB8NgqMt69Yw1WYqs7BfLmEaIg1qWT/g5nroaaCtinKbC1ZlWu/w861LNr3DIPCXadue
 bVbjywRgj5LZQ+uB5ZUF5EJRoIK4oEsrihTSK+IHsyz2GRQrRH935yHgy2LNdCkAHZgeMoAFBUG
 UiIQjCQcAHHlGw+nzzYT8mg2aw==
X-Received: by 2002:a05:600c:46c8:b0:4a2:397:73f6 with SMTP id
 5b1f17b1804b1-4ac174713fbmr380230315e9.8.1793785718074; 
 Wed, 04 Nov 2026 01:48:38 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aae24b32sm119963075e9.12.2026.11.04.01.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:48:37 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 04 Nov 2026 10:47:51 +0100
Subject: [PATCH v2 4/7] configs: am43xx: Enable PHANDLE_CHECK_SEQ
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-4-6091edbb51fa@baylibre.com>
References: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3050; i=msp@baylibre.com;
 h=from:subject:message-id; bh=T8gPy0bhYMrVxRL2d5L5PB/zVQ+uqdhE8nSE4PKkVkE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqxX/6Nvddy9+b3LWfy+ySmV6wFu99JbD65OVWwtP3T7d
 ecvlpJ9HaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARXlWG/37HprsdWHOz33D/
 QYdwyfQ1HYelD78MlLhtuOngvsvZH+8x/A9fFpTXn35Ml0F/1kX5AIOFiSbBD2vK7vrEa2a/uXi
 5kB0A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

In upstream am43xx many of the actual devices are embedded in ti,sysc
nodes. This leads to them being for example i2c@0. To avoid conflict
PHANDLE_CHECK_SEQ needs to be enabled.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 configs/am43xx_evm_defconfig              | 1 +
 configs/am43xx_evm_qspiboot_defconfig     | 1 +
 configs/am43xx_evm_rtconly_defconfig      | 1 +
 configs/am43xx_evm_usbhost_boot_defconfig | 1 +
 configs/am43xx_hs_evm_defconfig           | 1 +
 configs/am43xx_hs_evm_qspi_defconfig      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index 741f8f85f801..743ef0a88f2b 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -102,3 +102,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index 817b97b4b277..e612dde93ee0 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -68,3 +68,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index 11310935e7e8..e4102c902485 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -84,3 +84,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index f2dfb79802f1..bbf57a8ed797 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -104,3 +104,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index fca9ea21a778..af93fecc8e9d 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -101,3 +101,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index 715e2ac4be21..ad84ee36cc48 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -70,3 +70,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_PHANDLE_CHECK_SEQ=y

-- 
2.55.0

