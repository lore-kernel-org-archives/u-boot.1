Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E7606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IKcRrfXW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xt0NPvAs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD7A3810AD;
	Wed, 21 Oct 2026 04:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id booaAiLYfWQr; Wed, 21 Oct 2026 04:08:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1C0A780FFF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792555703;
	b=Wr3Hc9bfbqEwKhhkTJkV5buuoX0rqsH66lzk2mW/gHZxADwhziRbwf3buImegzf4g0XV
	 kJo2jOyd9583GPWB/82HFwTM8luNr61jydhVDxaZcvT0OOHWDGQTbiTLYE+4z51gtdeW0
	 BOZ8/x5x0Ht3qjm35HFrxT49evzJciISr4/IFiW17uhF2ec24wZ9D6lfLx4KcQTu8YEjQ
	 600z395/r1laXl1AIHtrpKMWoFuFuZZN1UsXw8Aec9goKDj2/2meBib0OtiziQF7ZN4ST
	 ZBCEUiejxqOCa02nPdK0r3cZ2yX+UIEotq//0F5J/hBQCGETLpWz8dpKDeVOKPIYOhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792555703;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Scb5yvOafX0do2N86H2hbwUxH2S4zNCs1pipGPfnUBc=;
	b=leGgn2lq+alE1KpjmmYiLqrTGmVQi99zQwSEs8VFP96dlto4c2kmnqXYYUywOW2PunHZ
	 Cw8bbnY+RqJbG5/4WMd0qmLQQ/na4BMw4a33Z2z50ibTD7M19ZOg+TXQ3xQQMxBuCwwVy
	 hlG1eVKCPqRs8Bg34GXZEAdVDR8N+egl6fIcNRZroqNnGr7/Y5LzKqQtwfv/tdi9/L9Sy
	 VxV5Gq/GjfUswMRVhO9W7n0X/qW1YavtWmT5+1vL6Fip8Xg31CEt1Ug5mWvbR4ev/7TQc
	 B9BfGQWuTQzaV6Lr34N5OgoWIV85h8mA5KqDIOj3rBUsTNWrhrDFEo2BEEB6cKr8hRg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792555703;
	bh=Scb5yvOafX0do2N86H2hbwUxH2S4zNCs1pipGPfnUBc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IKcRrfXWx/MvT7tFIulhsbhk9r2pMCWK0hmUYiYxtogKnoh1kSvoBoRQPXf06HohS
	 wryyO4KKl4fENE4S1XL+OUpM2yaGQcmD6pp9aZ7WtVMGuzIDxgz9+0z2/UDsLDwx0N
	 VxP+L8xZjqDU7jL5RqTEpXgG4yxa7ItmG9tOF+Czi6eYlueBRhqUPhTqtU5CckWhNo
	 Bg9mnG5/IaOsg7xisPP2yjgtxPmMTUIHUynErCKdHyWBEQNH96axf57f8bv//f/pLj
	 T5QOVEaApT+SZ17vGR3jIqqZpwtk2V+YOmbMkPjFmv2/r4NRDFY73TaVUgahhHnfFz
	 sk2RfWbCplOtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C0A780FFF;
	Wed, 21 Oct 2026 04:08:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 96B2B3A4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8835E4016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GHNRJ8bp21Xv for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:48:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D64C340060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792518506;
 b=tHkoBJf4FgsRouWHTLOeKuoYlqeNJmADQ/INkKJeYRKpDjAYJqtnXrmDr8yrWIgp42He
 DE60WsIk92xSbTm/9JZPUoSAgPjcWY3/aN9Y8ZZvSQIAZB4umpiD9aQVv/JPfDFCmY+Co
 AvdWohxTV3BmqhSvsANO+vMbkVL13oUwWC/BLbDZhVKYjqpN1NShQBL3Pwi3tZZTBhAJ/
 qtc3ilZ2KX4QS95B+XOInbqt71uIHxkOCw6YQ7/qTBuT1MXW67fF4Hz4ErrvnE6o/95MH
 g+CVzSObhr4uqUJE+NZtZBNR7qcmLr7NNxHe802IiMdHHb4PlNQqovFxHvt3ypaJwtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792518506;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Scb5yvOafX0do2N86H2hbwUxH2S4zNCs1pipGPfnUBc=;
 b=FQqZHq2rkqTQWL66womU9Eh6mcrJYrGP1g9K5it2gZjyQmpa3VaysdkeZhLX14EYkWtq
 UfNw95lop0GnbBEJW3Qg6oIBrbA68JxZmfCpn/uVH5qlPo+1kGoqT5w/CL/nJB4dCNpF9
 n3HLkSMN1/c0tCCp6/NcKst/RuPs7zsIAwgtmYaJD1lnq2RpCePygZKqSiaxXJ+R985EV
 lx9Q+wFZ23O5m0VJ1emHCsUZ9tURVUovvPbryzcpvBwkLlsRvWXAE5rDyCEDyJrysklGi
 Y3YRvT2bBMA/Zce6yFH2UW8gqUVywOpIHcU4+LSAWYM80Sjp3pJgKX9DC+0f8ZLRL+g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Xt0NPvAs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com;
 envelope-from=nimeshacharya197@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Xt0NPvAs
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D64C340060
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:48:25 +0000 (UTC)
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-15756f82e8aso399943c88.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792518504; x=1793123304;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Scb5yvOafX0do2N86H2hbwUxH2S4zNCs1pipGPfnUBc=;
 b=Xt0NPvAsuLFSNZhtzyffpNVfC4+LiMKmGD2zTOt4I2ROXSXZR41zgPLghQRe8sNGI0
 3fdfr9S1Y291AS1oZPGAhB2pKmEW7rbADVYhGgDAvhYVEux9JhERcTPjYApVNXx0598d
 Yzx2IICXcjQIqIcX36eB1FIReO6hagtqch0deKjzDDhTsEuS7nTbls3x767OmVajEc3e
 NZr2qZAZlJtV7FilwE76EtBarou5kNbyVke1Q5SFwLm4UD6o3e3PEM4lgGOkGVLXoXEB
 pKRulA4oLUcScGlup+aCqTsNHch6rm/viInP2yyKdjjuzHKVenihKzxwp3DwukjBPT89
 pFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792518504; x=1793123304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Scb5yvOafX0do2N86H2hbwUxH2S4zNCs1pipGPfnUBc=;
 b=Lyk1yMwtlcDexlatVQx9UNQKafK06gZf/ldxDQRxXtLDFCRNrUWVW65BmYd45yHN1l
 KtFYxThVL155v60lAibvowAPDn/PteFN77EzmIrNIAu0sXCiQIf1nAM023xgJSl0PxJ8
 OoMdrzO9ZTHKfM299k7GhB1dyq+PGc8JP3lLkZltmtRS+pRS+zgsUIuSaA5SnHjCj7PL
 +qeGSP3dsuJa2YJaVx9Hy9lntgRGq3FjKdh7HRiYtPIMhMUbJmt2X2WxBWPbiQRA0+jf
 EjHwadbFLS/FjlW5G0r/689RrTcR/4qxISnRjhjRxFU1s35boyuiqxmQSPBSLD15UWs+
 1dNA==
X-Gm-Message-State: AFq9FYK1E4uslbkAikmtDfmTKEeJvWQvsYxZr1xOrig1fhncu1FCsRFi
 ah2bvO4WZsQLVMHaiJcCTDw1xjyJ2md/hngJSLSjDfIUbDZq08WNc74oUJu1dCQJZn6VTg==
X-Gm-Gg: AYBFou1/j7Jn/Ykc9/VaQrzX1fD9GdWB4Ofx2VtppdBfBj4tmJumiIo/NL+KEeIqtoe
 qRCDXl68NDi2fXvyC0BLQlPt9yJd8AsPJugTJtOA7SG40/ANf0m9YueEuQdixOuvCliW/pO5IPU
 eW3p49B0/MwZOD2Mi2wIRw9fA8mckt/8DUwTBAfLD0Pk5f5v7xVYbd1UAgcz1d3NVZpiESHJ9AT
 kTOZjx8lYP+Axjr2TywFhZZyxmKH7Xo/GLZeB0+JGYkCCsV8sDg5/LvqkSGjL5x3SX9ksuKU4QQ
 bbIT3A2N5Spd9raOsF1MM3mbistAGOqrmJvLnj8wI8hJKy2Pbu4sAQ2KYfLUYrScQ1hCL4QYGdx
 UQT/GMqLUqVF2rdRbsPlIbS1wSTYcNosaGZ+RW1obPQBWnRbbkqzysfxLoPhNDQOwklPXnx0cBx
 edXbnePgRAGXcBjq0igLPYv6YFEA4IPQHLoTLnSeA7PWvfZpx+5ZZOhF2b5wqrqET7X5msM9LlF
 xjFBFC9zAOQ0w==
X-Received: by 2002:a05:7022:b047:20b0:14e:37c7:2b20 with SMTP id
 a92af1059eb24-18dbb92ae50mr3519069c88.20.1792518504020; 
 Tue, 20 Oct 2026 10:48:24 -0700 (PDT)
Received: from arctic.nitk.ac.in ([2400:4f20:11:a00:c772:7333:c781:5856])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903ca044d4sm150210c88.17.2026.10.20.10.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 10:48:23 -0700 (PDT)
From: Nimesh Acharya <nimeshacharya197@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Humberto Naves <hsnaves@gmail.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Nimesh Acharya <nimeshacharya197@gmail.com>
Subject: [PATCH v3] configs: socfpga_de10_standard: Fix raw partition booting
 from SDMMC
Date: Tue, 20 Oct 2026 23:16:28 +0530
Message-ID: <20261020174629.24277-1-nimeshacharya197@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 04:08:21 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When using the default meta-intel-fpga configuration in Yocto
6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load
U-Boot from the raw a2 partition on the SDMMC device.

This change configures SPL to locate the raw U-Boot image using the
partition type, rather than relying on the
default offset relative to the beginning of the SD card.

Signed-off-by: Nimesh Acharya <nimeshacharya197@gmail.com>
---
Changes in v3:
 - Drop CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET; not used.
 - Regenerate with savedefconfig.

Changes in v2:
 - Remove CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=0xa2 since its already the default.

 configs/socfpga_de10_standard_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
index 04f9d6c8494..a588a5eac51 100644
--- a/configs/socfpga_de10_standard_defconfig
+++ b/configs/socfpga_de10_standard_defconfig
@@ -27,6 +27,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CLOCKS=y
 CONFIG_SPL_PAD_TO=0x10000
 CONFIG_SPL_NO_BSS_LIMIT=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
 CONFIG_SYS_MAXARGS=32
-- 
2.56.0

