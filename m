Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8124CCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A2B83EDC;
	Tue, 18 Nov 2025 09:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TVS8qZIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4053B83CB9; Tue, 18 Nov 2025 09:28:32 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5127D83C65
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 09:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so35249295e9.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 00:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763454510; x=1764059310; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DQYMpLJKpBAe6nQG3hwPJMRE58tBlJCweot7OWVwp1w=;
 b=TVS8qZIjiLxV7+h2EF0cUdCYURj0B7xx+pTTFO9mOOeLWDj6KO8feSEiFbsFHLXSRC
 zYXZqJS1VFvdXMxURLtDPG50MmNM2nLNmt1X1egGuifLDULcT32auDlazzqaaphF7Clr
 ZrgD1iFi1GjRspRrjyqoyQp3Go2pDPojMjbM4mo8c3Af/toMWIQEaXsG/1oLEQl24KhA
 3WjuaPGWu+8S62D8HZkXdl8on4P9aP6PontZ8aGbyOVtws6iUtbrQXu/ZyVhKXtdp1Oz
 MPqPHdlLVYwiG4jrMPFouEWxcFgD9X4ip5Bigv5Rbx/pQqDLcOVVBhFurzjDxv96plZT
 gOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763454510; x=1764059310;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DQYMpLJKpBAe6nQG3hwPJMRE58tBlJCweot7OWVwp1w=;
 b=Fq6TBI4soHMa00O/I2jP9z6g8yWg/aLbgyL2hcJyvuT6DMN1QWhxqg5Ae+EGPB22gI
 OPiX0xK3eN9m1QDUq5DsycJCSvMNfAqjOPH/SVFjI4kWgACLopDEpS90DcuE8Kb9FSJJ
 s+xga4EGR4yE63ZjDatGE/phiYIJ6+OJtSeCAldeXJbXXlEunBRbHSrQvoNht931OkUK
 p9/ePwMM9iwTBOVFaF51D6sQl6Bqs2QhcdxNLua1bZdrPdO2ykLUUJ+5QBtacV4t+Hhf
 IagSkI4fvebNpOXMAgHr4T1Yvbc75xgyFAWwosF0VcQyvOAwqJnCt8ZsTrdfNkVzGWn3
 OpQg==
X-Gm-Message-State: AOJu0Yz7buaiKQlM6YPe1OrANdcYJW0kDqXGET+OWqp3NZIUDEFoZPrI
 BBZtA9wGWXTL/EcTQUaWNwsj8WdMV0aerHRyLyd2bJ7W78P/JLDse5imoblGT8NRMrE=
X-Gm-Gg: ASbGnct7XrdG0cBgtpbEvrt3iSqi4nn8YCRy7LymWbtJoupBFdDkMZua/vLjKeG9fRr
 /c+dEgpN+0bqQT4+1q1ZuQ5XJnUBoyMIHv7SS+6qKXxjEKA0o+W8XQZ5Oua1MIEkSCcVhVFXGOH
 bFoUeFevp+MRTUelqqLslMKI9bxwxCqhvGBLN9MQF9lNpNxZbqqBR32OB2ynfi5M6r5GnzrG+gU
 C6HFANovIKnS8Cixd1AuNO/RugUaIVLWUXEF150USJEn1t1iT2KUvOyp9NpLxaf5AQiKS28Ki55
 lQ7IkWwcs1zefiIVJtNu07UuQe7ykB/XLzM3IvILWdwpJxbk525bk6wR/MO4afiH+gZpAlrGwHc
 RvRoPBpvl4MXCS8RmvQ/lprua8sEFJsFRMriLAXOSqYtZ1WkVdJen9L2UX93FZreFc6LuxYXPDk
 0WcnBHL0Ydd0Y0Vr3pBrz5Qv41gUUivurLDja1Q0mDTw==
X-Google-Smtp-Source: AGHT+IH+VgBUpFj4KhrW2jb2F4ABSIPuE2R/enYuq+0GRtUU7vN3CTmI2WBbU3U8EhNmvXNAoex1NQ==
X-Received: by 2002:a05:600c:3587:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-477a94b3961mr22438715e9.8.1763454509364; 
 Tue, 18 Nov 2025 00:28:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a7cb24dfsm72698875e9.14.2025.11.18.00.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 00:28:28 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Nov 2025 09:28:17 +0100
Subject: [PATCH v4 7/7] qcom_defconfig: enable interconnect for SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-interconnect-next-v4-7-9c00d6b19add@linaro.org>
References: <20251118-topic-interconnect-next-v4-0-9c00d6b19add@linaro.org>
In-Reply-To: <20251118-topic-interconnect-next-v4-0-9c00d6b19add@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Anurag Dutta <a-dutta@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Alexander Graf <agraf@csgraf.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=617;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=l1OaNqfAmhRIe48N3BIxIps8arKvVqV7RbWbaTnuCcw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpHC4gQU3v4aMAkl6n74OY6+yL3KGPzr5jjBI1mSZC
 jE1FI3qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaRwuIAAKCRB33NvayMhJ0U1eEA
 CRJ0TqTNMIhYp5HLmCz4ltyFb0RFad4y2BsMSk+GtuN08ciB7l2eyftN4+hajJVkDGRQu1cAAZsmc+
 t0cTaUa66/0/t1OFKhG8fufv/Vj6ymMey0opX03xYBcdH68LTynZktd7KUheTirLNMrm2GMdt/IXhO
 5qxFnVGfhtlMe2xKorwkBRuO9iO6jNydIyguvL/DCY0LBdK2sFrbDzGZddufA4BeWdcyLlxAjeU5Ab
 +Zcn0pMsTuduei4wFysfvdLsuWdVgJMJwUVOvqXBwsQZvBiSiXEszI8uusO3gurv/8yaQSn4aoS0C8
 /xiH+9ggFnQfAPzS6A0AwK4TuOU7n5yX90T8kL+sLEL7W8B5aqbj3Diyt9KtUsSxRgeZkz1WA23Vhw
 CMyWPtDq1z0NpVrcQFuXx44db1dC2zZbaL9hOvwBDBQMG7Zq6bFdYa4ZKtaQgFleSiE+FOVcQfNO44
 q3dj9vL6zZt1lOrTY0MHEuC1vcNeOgefkbDqcq46MNUsHwmWRd2/2CiWxNZHSZurdKSCghTVIs8HUM
 iq4Rv5kRBaQUZ9yrocLn+pvE8kncGtzPzSBc5p6px4pcZQvyf7hOHrT7LVns0O5zFxJQPC9bhS0Asw
 9MY0FRBxnQfuuBX5iDjgRvA8BWftV/ggWwyIv+/fvIp3H0BpCLyLU54KKFGw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Enable the Interconnect drivers for SM8650

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e686ea857b9..a56e1282821 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -87,6 +87,9 @@ CONFIG_SYS_I2C_GENI=y
 CONFIG_I2C_MUX=y
 CONFIG_DM_KEYBOARD=y
 CONFIG_BUTTON_KEYBOARD=y
+CONFIG_INTERCONNECT=y
+CONFIG_INTERCONNECT_QCOM_RPMH=y
+CONFIG_INTERCONNECT_QCOM_SM8650=y
 CONFIG_IOMMU=y
 CONFIG_QCOM_HYP_SMMU=y
 CONFIG_MISC=y

-- 
2.34.1

