Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AD7C55173
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 19:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C72360657;
	Fri, 31 Jul 2026 19:39:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J5VHvhIsyOMD; Fri, 31 Jul 2026 19:39:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CBBC6067D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785526759;
	bh=LG3dlM3SxKa4533JJf3om/1a7pt0kwNFpFOVOkRiSF0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xzvi6CL1euS0lefAcNhbwGAnZ4ARlnAUw7j7S9taKQyc/Mctylxu/9oS/hTyxt7vb
	 JmSiuAdNaskdZ+CfnmqzKUUj4Qbjx18Gaw7wPvXS6N/Y+HsU3qJ4VBW5cGkfzRavO0
	 H1JLwdSSiXSL2K7Tp3RRMGe98KscJiq83SBPXRViAbgVrhiBrNOqwZSPk1Gu2WM5Ou
	 TWWvIRd9URXkLznj/25UosuE9uDNRxzmYfCC4DdfDRoiNRqvVgC1YC0wmUi2d9zJ0L
	 3u1Ni4gcDGvLlQQnc/+PIxSi5BFqmHPKXUWKzBoYGg6B73q4rI+R6aHCPWoqV2F6SS
	 ssaSISOAFkLTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CBBC6067D;
	Fri, 31 Jul 2026 19:39:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC7F569
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94F0240116
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZnIseYi3379 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 19:39:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 132A54007F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 132A54007F
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 132A54007F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:15 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso1506884a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785526754; x=1786131554;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LG3dlM3SxKa4533JJf3om/1a7pt0kwNFpFOVOkRiSF0=;
 b=mQDoQBIPLCsmOnx1OWaQQbZS+90wZUlMyBOOscxxiQRvJsj/N3PeanIAu5lqgtdX+I
 txgZY9AudZO00pHf9umRG5QGsvmu/eEGp8NTPnsKl3kcrnHYJ4rlNHSniasHBpDJaz5t
 cYEtoJO2FdVDFrNM799x0eCefyVxOaqOCRtRuVRnCMBaJTlOwndKh6R1LevatJjiAHNY
 o50TV+O14SKrPdAWbu+4Qb6UK2Iti6UCuswRSM7CERA0QQBWJcrUu/sPPTBDskW/sYEJ
 mJHnIpoNF3c9/EugrsEaR4spFJSU67nvFiVLFpwul23jNNSpZ/GNh1s1nmEmgkwH7mwv
 c2iA==
X-Gm-Message-State: AOJu0YwbwwOFIwaWXH+zqPIZwYADZ7+i6XNVu7ePMcBOfCKiNPN5RolZ
 iW92Ffc9iHnBdRBuIZ/4rWKPHaJerk6iMYKhVG7IYkdWx7nsdnrOD0feuZTMp66TUvc=
X-Gm-Gg: AR+sD13RUMSCGJegpRt7iDSuIP6BLyqWjKz0kCXwveDWTDyxMNxj35GttUatzvQPGH0
 5Vq1wgBUdLitRfbTGuwIL/wbQaGHrwDp+KrTDSBMh0BotQw+PdCbD+10M4k2REPYiFMCfy8uUvK
 CsJbUXvIGVPlzerjZsG6InoUPzb+qu0Fmimy9QXH14UXmzzUZA4EQsngvlpxr5Y6eeINl1uZ1F1
 V6VtNYWh3AEEE0jIavCLac1JJGL0X6RqDBtstSnEcQENn07w5W5jRJKpPUXvX8dp2qRJf3LAcTH
 8ixLzEpa3pW+Q3B7ADfycYj++y7E6iISCvxLRTNF3sYQnxvKgvbIsU2522vBuae1c1X9/HfSoT0
 LETmYv0pTPDVykhyU1h258eg4p/SDdSg2F8hnkEl0XCDmgcKWJxzDGJM1tbZQQs19ou0hFCQ0tD
 WjrCv244H4a0ByldtolQEePlVOeSS4vAaWiB6xllL/QPemgjHe1pqnzD2gDYE3C377cA==
X-Received: by 2002:a05:6830:6a92:b0:7e6:f7fb:967f with SMTP id
 46e09a7af769-7f196b60dd9mr2526993a34.2.1785526754595; 
 Fri, 31 Jul 2026 12:39:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18ed3e91bsm1359205a34.4.2026.07.31.12.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 12:39:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/3] serial: mtk: clock rate fixes
Date: Fri, 31 Jul 2026 14:38:37 -0500
Message-Id: <20260731-serial-mtk-clock-fixes-v2-0-022110a9ec3e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBCFr0Jm7Rg6SlFX3sOwoO0olZ+aFomEc
 HdbPIDLL+977y0Q2FsOcMkW8DzZYN0QgXYZ6KYeHozWRAbKSeYllZj8usN+bFF3Trd4tx8OSFK
 yFIbMWZQQyy/PWxC7t+rH4a2erMe0lozGhtH5eXueRPL+nkwCcxSmKI5k+GDodFX13Fnlea9dD
 9W6rl8LQnmo0QAAAA==
X-Change-ID: 20260727-serial-mtk-clock-fixes-266e61d2d917
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=850; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=P6V55Q+2ZdOV74kQSXYq33ZulpnOhYdTAclOuR1gMn4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqbPnFvD1qpOLlh7fr7xv0QRyF9/HnT/BC7DFey
 4noVwwiotCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamz5xRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjnMH/1M8HnqRTveYcOt5beqlTaWJLyVjDludd4dJMyt
 u9cBxf/FxoFJWMUFLdA23cAjlSdbpdJ5rrXQwrLEKePOwweKMxUY65/66gMgSfu/KYuJynYFLtm
 sRXshuMh2ovLtxshn/4+gM8IdiAlja95qJo5TkIBKqUVg4WpCgCpIV20ecH07UlthhRZFxTC34a
 2e1pPip9zIyiGosRn/f2kUuOdNiE9Da8Tk7fq8/T7+lPxXU39SXTYhBtG0bzkGstEUHMoAXp5EH
 mpEzzvC1ZRuy8oB6kLkVsgx8fNh6hZG7SV9InT5660SuJFY2rY7H5iVVmzq5gFJ/7lI48mPUGFs
 U+HY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785526754; x=1786131554;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LG3dlM3SxKa4533JJf3om/1a7pt0kwNFpFOVOkRiSF0=;
 b=Nhp5B3ScKkTmHumMMUlTQyzmlYy1u8BzLvBPD4XmUXAaQC1spqI3eANDElJ5rHS+of
 Y5pO6UwI0nRvjStWeLIGlUUuCfLL5jzxuMv6VQ3IQY8uRVvYHwPogxI3ccTKqcj/GOFb
 D02FwMmqmoOzvm0hLOG8bQ0AZMrvDFnIPlL87q4qVZUkwTeKw4dVMvRvcggXvrpPTldj
 /Cno0BtOI34cXTzihAtTF/sFR6XYlmKOzstLf7gifWrsyGhKn9yE+tzZWDVOeT/wga/i
 /rlVAH+GLkT+Uj9ufvYaB9zWLjT02GSiZp6sBYy2/NkbbRB/otwXcO0GCwB2rlGKlntR
 ep8Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Nhp5B3Sc
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

While working on SPL support, we noticed a few bugs in the MediaTek
serial driver related to clock rate handling. Here are the fixes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Moved return value change to a new patch.
- Link to v1: https://patch.msgid.link/20260727-serial-mtk-clock-fixes-v1-0-1d5542de3d28@baylibre.com

---
David Lechner (1):
      serial: mtk: return error value from clk_get_rate()

Suhrid Subramaniam (2):
      serial: mtk: use ulong for clk_rate
      serial: mtk: guard clk ops on clk.dev

 drivers/serial/serial_mtk.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)
---
base-commit: 5c215cb75c3723cbf77c36cbac3e60b001721c79
change-id: 20260727-serial-mtk-clock-fixes-266e61d2d917

Best regards,
--  
David Lechner <dlechner@baylibre.com>

