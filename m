Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A3EC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B1DC82C57;
	Mon, 26 May 2025 09:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DiMIWHl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD8E82C96; Mon, 26 May 2025 09:42:58 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E92382A8B
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442f9043f56so12140535e9.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748245376; x=1748850176; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dumxCgxEYxyQcwfoh2pkLUbXwCODobvmaK495ggWtUI=;
 b=DiMIWHl+SF+4P+HE/psQuMej2gC/S4u6KDfh6GbRmIEhDw4GIAOt+67TAzWt2kjyDh
 E1buqONHBsFIQtR2GjN9OhD0Qa2oT2tqEVRp6teBCeu1a6yhKzWa35sbCtuoDLAqcqSu
 O1ka6I9shbFu5uJsFMSZq3z8xDS9ILBpCkdr1pvkyT8L92n+6MhqBbAO6XfFJXvf2SBc
 h9vhkQaiPcXALD0DMtO8KxHElI9giHxpxgQBlwpsp5Br9V9fLadZXOQAQtMcaSqwEB3c
 1kWwjglxbUR9SQSP/8u6iO1bEROETNom97i+/G+EPqJG+96KB8+LIrYnXCJpDdTintaH
 mSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748245376; x=1748850176;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dumxCgxEYxyQcwfoh2pkLUbXwCODobvmaK495ggWtUI=;
 b=lVW8ybJ+HS2w7TKEItHFq+6kZAgXQ+Vt90RNBVjquTv1HW15T0oINIzynPG6dwZuht
 U6UCov4prTb7gnvoEP9YtWMMXVkH9Nm2yzqdcsdSdzUX/isbscEA2w5kShmozMGYVE4v
 n4REay7HzT1lITFlIME4+Opo49ZI7khOQOjuyM6T+H6haGqP3XYFYM4DU7W2q/1MTnmj
 +qLIplhohS/wo9EX2fEwcYyQppRLgDBDL/4JaCuRBDQFXlqy7AFeI3yaNgFCtcynBAZ/
 gjvjrhYfka0Njt/MwuJIRNNuTU8etfEuhianP2/imn7rAt2trrPDXg5yIyQkw+KzJiDO
 XBRQ==
X-Gm-Message-State: AOJu0YwrTGtyMK8n54FKRTIeEomZP7+PEyrTg0DTZM3sKsFU4C39giRu
 Jj3aD8N3vJG8X8BC4ZewDMxTLLkbVP/QsDlVpJSh1lmslmTJEeidOsdTZUNtWM2QoJs=
X-Gm-Gg: ASbGncupT3425dQQ6FlNf1Zed9t6Q9UTUyJh8XFOW3lwchz2ogrPz3KTLRVXHi8FHza
 9fzEZEtlWAnhpUiwd7vO955DiLAQTZQaxxAZbml4bnCaalo2d7nXQpFN/QsRET9sO45ijYE5Os/
 4Q/OvjBiptmUib6SgyiDFdauvBTSygGGgFUhf6WrcV1LVjzzRltZqQAz2gtYEJFkU4QbXXY3U+W
 lalGtV3MWD2HKfvG6hMSmSnIvE98wHkmSDtOYSgncxu0p5AXjZExlcWz0a7OlEGEKzhuCUJBMsP
 N9+ksFGKrmkP5NAoFDxRg7tKRTXw20a7BpEGQpJtUeVV1KlAnmQ4VLONmdSNt7BGCR3f0dJ7
X-Google-Smtp-Source: AGHT+IFYXCDSCJPbkmYDQrQvPhYEar3CyoGb5DIR4/5Eg413UyT2ZT7L9yKCrFqPPHlujQ74oBGeIQ==
X-Received: by 2002:a05:6000:40ce:b0:3a4:dd02:f48a with SMTP id
 ffacd0b85a97d-3a4dd02f535mr629781f8f.11.1748245375819; 
 Mon, 26 May 2025 00:42:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d208ddb8sm4694045f8f.32.2025.05.26.00.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 00:42:55 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 26 May 2025 09:42:53 +0200
Subject: [PATCH] tcpm: fix pd_transmit poll condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-topic-tcpm-tx-poll-cond-v1-1-38a81560ffff@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHwbNGgC/x3MQQqEMAxA0atI1hPQDop4FXExTaIGtC1tGQTp3
 S0u3+L/G5JElQRTc0OUvyb1rqL7NED7z22CytVgWtO3vRkw+6CEmcKJ+cLgjwPJO8aR+SvWWmE
 mqHWIsur1nuellAc/bMtoaQAAAA==
X-Change-ID: 20250526-topic-tcpm-tx-poll-cond-8dd3ebbbeddc
To: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Wang Jie <dave.wang@rock-chips.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=darHGxBalzeoefiAptCSo5/gHHMPXbVTUx4XjyYpZiI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoNBt+Nsn9D5hYlQsQ7c/ynqJxYM21WEC09Ui13ikB
 4V1+2liJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaDQbfgAKCRB33NvayMhJ0ftDD/
 9yGWaEW09lufb4cuk6NfK95MkmIx84z8UBD5s66+17AnY5TgFrjknrvQV4AD+CIiYDm/f9DwrIGYe0
 eFa+veKt1zo3ZZTy9HSgIr/xrA/Ioi3DdUVnsT4H8isK9bT4xeLDDbmJbF1zuo4Hi/fbbA1DapG+Rk
 gUJ4PWTRr8mwY+Ac58sfR1Ia8L39TAvjxbXwFu2K5lqrRRwOT+bZV9MkqmuVKRLP20VlwPkuNJ0hiL
 zcVlCI0u2acAmFwEM7IqDrDivp80MfSL20m8No94GDWBj3ivnC7ciVvH+Qcl21hfbn09z1PUwi1yv1
 tX+tr4ux1lIsJyGZ0VPqxjiQ3qVbejhZ0WZxnVng/L4CfAiUpEpNK3SeQiR/NqQRXRM5RXsrYNFi2/
 3ERaofwm49LPsHn7m3dCpuse+rBLXmaOFCLBLd+LZWv0Wj0ypjySetBdklRWGgHlvDJcoFZxkRVNwj
 KW81C+1aHAfx9fre+g3ySBzOH563EhSlAkpIV7RndEvlahpzRiIuQ4hHhFQXpBy5BsdTgu0S/fyXgG
 SfBIf90DUnewXmd2LdmK2Y/eVCdF2aR3CjbiZCilFMcP44NqnMB9v3JO8V185ymJOFjQyH2jTHgkNP
 WnwENg0JikNlErulYh1ANyvI/gP/HDPm2yl5OT6QsNz9bZKmIO6E+YCgGtow==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The read_poll_timeout() exit "cond" parameter wait for a complete
transmit state.

The "!tx_complete" cond means that on the first tcpm_transmit_helper()
call, if the tx_complete returns to false, the poll loop would exit.
But since at probe the tx_status is left at 0, the tx is considered
as successful. And then later the proper status is returned and
ignored.

But if on the first tcpm_transmit_helper() call the TX status is
returned the read_poll_timeout() would return in timeout and the
negociation would fail.

Fixes: 1db4c0ac77e ("usb: tcpm: add core framework")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 0aee57cb2f4a44af7b483e0e609e39ba584a06c0..c8679615cd7701982b64b1905c5822ac98ed6f79 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -209,7 +209,7 @@ static int tcpm_pd_transmit(struct udevice *dev,
 	 */
 	timeout_us *= 5;
 	ret = read_poll_timeout(tcpm_transmit_helper, tx_complete,
-				!tx_complete, false, timeout_us, dev);
+				tx_complete, false, timeout_us, dev);
 	if (ret < 0) {
 		dev_err(dev, "TCPM: PD transmit data failed: %d\n", ret);
 		return ret;

---
base-commit: bab54f5942c428be698216224fd10b91d974d4da
change-id: 20250526-topic-tcpm-tx-poll-cond-8dd3ebbbeddc

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

