Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FD606A31E
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=krxPOy+I;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gmCLMdhL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB42B6075B;
	Mon, 19 Oct 2026 21:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GRsky44a6vCu; Mon, 19 Oct 2026 21:15:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1245160747
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792444552;
	b=N9akO+pnD7V5bbmdseQf71WDR2G6RGAtQuPaLmrLZ1JqpXEcGQHc8c4bG6AU8A/Mchq5
	 Ck2pX8uKa0HjUoLDjJq398eDM6m0/0ePx2aghBNI9mPsd2koZ+dAH4FcC2wVWL5wrC9Vj
	 Pf6iPzIYoykGiuMmuDv3IN3UVtcz9tqWz6mwDu1+6cb1MPyVtopQD/UolCkCGjNjmuv66
	 e9JlLrMBMwjiOYJ8QtoFZYdTXkuoeZCz5hrcoh1tHKpMrsdoNxtetJkcsP1gcyJXje7zb
	 64V6hwUbVzpiYNWbLPXJpOpvSOF3oSP02RMc2FFdZzZjvEPSa0epVDkGF6uF/vcvh2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792444552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZK8ngS8bCQWTMateVFXvwgXgzezpXr6Kl8ZWnS1CgAY=;
	b=d266QWzkDK98wPAPNSTrpLUxz0z/a6DEBJ9bltI64u767FXb1PQ2XDMP7ouqqmhIv83w
	 NjUz2XhpE3PH+6D/Xv5kEyFK2jYIuE6XHd36uMa3rgQcXAqe8nheaElKHv9ya4hCDjDXU
	 u96XOniII+km0N+ftuAR2fUg6zSDNQlq7M+19HgNlYw0XmVSY/f9bCqZpCSnWJ6O0PERa
	 bEukeCV5UM5Pu7ES7/JYMHd2M/1qrSUrbEzwhsZJXw4RFszED9eLI71FeLb8SvLW3UC/6
	 px71dzbpk8zeKDrG+zIjKSbQfWDw2FNIX0mQ7KuanVbhCRjlD21MKq+XLuTjJg0BAKg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792444552;
	bh=ZK8ngS8bCQWTMateVFXvwgXgzezpXr6Kl8ZWnS1CgAY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=krxPOy+I2j4x+TRpwd8tIHDQVJUy1A19d+zYBuMqRUCQfbclOykFQYe7884ObDrmq
	 o+N2mQcf8hhV1djEB20zERfmJfjOuMl34JlgX1ZqKiU2GLTA5UjzUxCi9/kyUOU9t4
	 nW94SjQqhWxaouS+8RydKIf4CDFLMIyXdJEjWo9SxBkibnbvrX1vBMIoS4sNO4lg7d
	 g1M1/cwe8tbOkJwzHdSiRUJweTTUMM5ss487ucOKKsG1nLTB113OBXkizl4oBP9z0b
	 ZM4KjUcSMK/Hf3ejqdbUSSbHnRl73NnTvxNgIMnUKHRN4wsMrnIfQR8yDmCMPSGzpI
	 +a3LKk+JphhTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1245160747;
	Mon, 19 Oct 2026 21:15:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF50C12F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 21:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A544280DDC
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 21:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xop0kKblxXqO for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 21:00:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03EA880E9D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792443645;
 b=DfH+bRofrQLdO4fJjgftc6gYSOziJClszaMrfvz9Xz6FZs8B9dIymn5GghVsLoT5406D
 oTYnPWtkZENqO96b+9fVVbrTwDyi+w5o3nDvwCEXuZMB61aDfzsxGeY0kT2l+t0rKtWyb
 GpDAAYOVdWVKTMQptm9PQ2NyjMOHFCx7JGfnJog69hzXFq/pxcw4xm0XVZcZGWwpwkXs+
 E3Hu3A7Frpy0AjhI8RExlWKGfOKU7Z6dFX6BlHXFCv8/nOXLc5Ds3dGt1ZaIBHCOblxnK
 RgQTrg3KLeFZSgXZuAOjj/W8HZ4IckDFShGfTPYbK7hKwhqx/llnY0UHe0greGetUwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792443645;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ZK8ngS8bCQWTMateVFXvwgXgzezpXr6Kl8ZWnS1CgAY=;
 b=OrGosKB40VIM35T6M/nJ7iNPHTPe0IQKlqGf6vljImzVIfvmmsdxCNNm9UdR4AQXQ9UV
 Qur0AaQFyuksh9gDQioeU+TfyoKbCCn0CE1HbBKLVQ5uRZYgvdB1GWPOEMuUpfPiOh0ft
 5PHNKQ2m+P8o1MWM91mI1n1Y/gDQIYxzutVgm+1UFQDrUpIaHyB6FT4pETW4bMaFiooD1
 TEnLaFE8n41jiihW6Mktfg1uZ2ldpR51+t6DmMAkPDE6All9D/epJdTvY4wqJVHydOzgt
 2kW05iTe0qOiADDvU7NRdjnbFhq3c8VHAZ4uyaB3W+hv4ajgMp6XPZ8RtCrG1WGQtYA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gmCLMdhL; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com;
 envelope-from=nimeshacharya197@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gmCLMdhL
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03EA880E9D
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 21:00:44 +0000 (UTC)
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-3550c917fd3so3041227eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792443643; x=1793048443;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZK8ngS8bCQWTMateVFXvwgXgzezpXr6Kl8ZWnS1CgAY=;
 b=gmCLMdhLFZWdHpkTITrYX/EtKi9n4EuomBIqg+PH0CbWfajPEX0dMSGHH45TA2JuKx
 Il0+Clcq4bRQJ6UXsuDVEBqoveyKSO7DH5sYNTAhYGwK/x9podStfkeQNLMhaj6xQffL
 JHipnCxQPIVfdSDr6grhQeVBPqGIteE45R0MV79e2FVXv04Q9ofvYqq/VS9jbEMfeHNq
 ObaikygXBIC9zuawB+AlZv+Te8UaKh52pa0eVomflVC6PdQKzAb09U/9Q635VSLjDTFt
 Q4wG3PC7LfbddsllpR5fCRClT1AVCO8GVNKnefCIIqsA5tUnUXdYss146DFtKlaJ+dKD
 7E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792443643; x=1793048443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZK8ngS8bCQWTMateVFXvwgXgzezpXr6Kl8ZWnS1CgAY=;
 b=d4PhLuflPNYumugAZV0wbA8/fuuZMQLYgRzsrBMJ26SSnmoUPv3iWINBbnkT97rAfA
 ELubGZRFqxePXbYLAsgKPGQeCwqEW3L/LXVVDIYAGZIBoGWtU3gZksogGXdIeQhIo0tt
 6b1A98Sx5jU42Pn3EiAlYDo0hkkPuS8eXL7oJ9lkS2gvRQJxPA9YTrvVu1+zlP6bhfOr
 0k6gm4hmdhfRrCfVaC4fl81dDyGjk+sIg9hBJPrJoFQ21aBF+0p4Amko9o16z60ZrJn5
 ehqa2cmwNnZNw1x6mz4CkxQAfY0EBrudvH86Ogxx0NoZiqKRWt+gL+xF+F2zS67sstYs
 /DIQ==
X-Gm-Message-State: AFq9FYI21+wn5IYt0cNGr7PLmWVuPRAsZY08dSThqSNCETQaVXEXFLzn
 54Ns4c/zZ3h7i9HGMLs82MB2NiK53AI8QFJ1LSLeeoVinQZeU790UPueI886mmfzlUM=
X-Gm-Gg: AYBFou222G7pRXlSaf3qS0ZnTZxX1/MI+f7zaXYoZPTuNODD7eOWxFefud4X6hOshru
 ltZPR+aivotTvB/oTJikimaQDIjQ7sq5R/iSuKwwpl3zmKy3qQ7srVKBzqh5XsWlODgQPkdOkW9
 RlNyFqyWq16Bb6d8C5Z8kwZI604/bCBN7/z5jnID7P3rFNffiJvxosWHZ+2mWrKB9tm65JmLvg2
 bro+7yKmonOpCYsPqPJJVqRXnuElPtkNG2xhQwiLsFGX10hD2Vyxm1qZwV78+Jwcl7YYARHBn0Q
 M0jINHQmIPivRLjISZq/T84YBtDKUxIbHw/abwH5BwJlgbi5S5+7jpRiswdOehyvvsrgScilUj/
 oXJ7WC+XUhSR1Cw0XxoRn4tlIwQ7y2f9g9emECpToK2x3JnHruPVMEYRwGIU/svliEXL9krEXjS
 OkEbWeks8wdi4k71T7gQXz0h4ZpDkNPMo8fWYb0djmdqOXXvjyFqqxFZBTfqvevmePuFHCkq96i
 v7kOI/+lV6SfA==
X-Received: by 2002:a05:693c:638d:20b0:35b:cb8a:8d0e with SMTP id
 5a478bee46e88-361a18634c7mr12622877eec.16.1792443642862; 
 Mon, 19 Oct 2026 14:00:42 -0700 (PDT)
Received: from arctic.nitk.ac.in ([2400:4f20:11:a00:c772:7333:c781:5856])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360826875b3sm36486580eec.21.2026.10.19.14.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:00:42 -0700 (PDT)
From: Nimesh Acharya <nimeshacharya197@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: hsnaves@gmail.com, marek.vasut+socfpga@mailbox.org,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@altera.com,
 trini@konsulko.com, Nimesh Acharya <nimeshacharya197@gmail.com>
Subject: [PATCH] configs: socfpga_de10_standard: Fix raw partition booting
 from SDMMC
Date: Tue, 20 Oct 2026 02:29:32 +0530
Message-ID: <20261019205932.28038-1-nimeshacharya197@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 21:15:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When using the default meta-intel-fpga configuration in Yocto
6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load
U-Boot from the raw a2 partition on the SDMMC device.

This change configures SPL to locate the raw U-Boot image using the
partition type and data offset, rather than relying on the
default offset relative to the beginning of the SD card.

Signed-off-by: Nimesh Acharya <nimeshacharya197@gmail.com>
---
 configs/socfpga_de10_standard_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
index 04f9d6c8494..f170778c322 100644
--- a/configs/socfpga_de10_standard_defconfig
+++ b/configs/socfpga_de10_standard_defconfig
@@ -70,3 +70,8 @@ CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 # CONFIG_SPL_WDT is not set
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+
+# SPL Fails to load UBOOT without these!
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=0xa2
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x200
-- 
2.56.0

