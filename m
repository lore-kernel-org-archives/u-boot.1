Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7A6C55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DAEE80FF7;
	Thu, 30 Jul 2026 13:35:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WhoSLsQyIc30; Thu, 30 Jul 2026 13:35:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4246B80EA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418515;
	bh=RJSN008zdNvLLRyUi97lntBsZpLSyU5RA1oGBg2r/7E=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qWAFjBYu28uujdGaWQqkQ/BN9/IitRLFUs5SG1yZncBeR61J0hUWbufXqPtAglKq6
	 ZDirtt6OP/F/XKohfO0idR+0DCKkfC0/rH5JCHX5D/OTk2lEUqxCZh2q/AymbVU55b
	 hWYZpdXEIpB3Zme/rdRUiLI3YD3eUlu7bh1KrHzJooWZLBPXnsZxj6qMpA4qgZlfrS
	 Ui38LGeB9Bx0nqPbdudfBNFIWLj365rBdU0UmLGUrwmRV8pJRKAP6YcKym15G3UHqc
	 0KGFKlcqSxQXaZ4eKTFePyBWS1Lzdxugdk1+kel8lmBDF5y/Zwjkf6ZNj7WYPVTq/9
	 fWDsnH6f8LXlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4246B80EA7;
	Thu, 30 Jul 2026 13:35:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 715E6197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56CAB80EA7
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HcpSw96DaPiA for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:35:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 302E080DB8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 302E080DB8
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 302E080DB8
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:13 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69848c9462aso283057a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418511; x=1786023311;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJSN008zdNvLLRyUi97lntBsZpLSyU5RA1oGBg2r/7E=;
 b=cLvymVZycPvxEyWb36z7FfWvTFlKPpAIbk8cOpRfLGZ7GP+Eh2bbzZRapIhV1Rl91f
 pxFc6kkbdjmKM2H9NtOroBkolwCCTXm7HZpD8GPWsQEl56ekuuBnq6a2Jvq2UPuak+Q3
 B3js0ikmy7Hyeeh60LG/dACeSHpF25SO8DkGHnj6FO2DSvw8vH1d8aX+jqyjJ23unHFZ
 JdFkMlEnJVN1mDV4Tgw1RjGs6kLHvgeDCNNUe/U1zhcLFbiKuvjEOA2nNEYrEFlORCh1
 xi667ILNVsnQpGhdJ88Nsw/jpGZ6IUZKZTBgEoyKYgF9dOEGz3spDdrzv9VQzxiGDX7K
 4YlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqn+chWRYTquS41p2sM0O8pvTQU/4KhYulum3SJkKNN2+YzPlVC66eZUaxtO8/s7tpZxEY3kBU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz6UiEPWGRJ7BBoUXyfmq6gBVsCWvO4UB5d0rPwL3Yt6+fYmYLa
 5JQmunnxDS2wH3T2LhZ7jvQ/JVhWY/q+s2iMga4ad+DdHNIXoGxK7pxw
X-Gm-Gg: AR+sD10UiUimzX2Q5SnzdusJWFeSUodbkd13FFAip/bg7oMtsl0XDRm3bvk9Hko8vgI
 cvidTtuLOr4x0WKjeKgXorIMDdB4xOEblrdfXER1kRB5nRrSjJhl1bz2VXd1lWDg/Ee8hpp6g9w
 2RbHZkRlQCGSMlBxeylyU2QwvRWxHISDQ5FmAfgyPtpLvLUMtOTBOogYGm4vDABM0rVcQqipWhx
 YOcJxhCX1Mj2erkVTI/0aJ0+lf3FXLfrwLuZMdOg0xwEokoG8rZ6hKl2AYpfi40rSqWkYi8X8OT
 UDjxI9r8EL7s4ZHTql9nOVEzHlf5Tvb43U1JMEUKcV8UH58/Gt/u6fNfmuWFzUhYG6YT3mCBYCH
 0vrKmkSgeh8YpilEcFph6sGNnusUH8MxMGsaGL8x/m6KqRhFGMbH+gWPcf5YOtS/04EWMSRNQo7
 ui8VXiwA2bGTH8ovwYNZ6oJ8YKbMVotCn0mX4ztoqZhIwcJB2sRIyGzTgPN+lnMClGWN6eijHgo
 lI/QWCwbPw8YTdsCMTCEE6OkKk=
X-Received: by 2002:a17:907:60d0:b0:c15:e0d3:3fd8 with SMTP id
 a640c23a62f3a-c1fbcc8fd97mr28935366b.3.1785418510985; 
 Thu, 30 Jul 2026 06:35:10 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851b6adsm68441266b.11.2026.07.30.06.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:35:10 -0700 (PDT)
Message-ID: <b6f80fe1-f0ee-4750-a74a-97398a91dc08@gmail.com>
Date: Thu, 30 Jul 2026 15:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 08/12] rockchip: tools: add comment section to rksd.c
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418511; x=1786023311;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJSN008zdNvLLRyUi97lntBsZpLSyU5RA1oGBg2r/7E=;
 b=dTVyv+K/XBx+/7bcut7cYtdvDae4/tLhGRFY3gtaYr1qLcCFoEqQ43IlKem5ECp/1a
 TPqMCuOzaiVq3AUmNTz6Kc21Wa81X79fmAVbfazPRJX27Q4PWtykhbIziPke7KK3E5sP
 gGpIjNlQ1IzM06yS28v680pnP8omFHKLN+aQJRrR/XXof8zHSugfbroaUOy9xDgAjq3K
 WzwvaTvQcGHBE1iCywRIz51rXL283fDheClBKKDYvs3NGG6Dalc7jzWbfVNRhTauFojv
 BIx1fxNETbQL51zDQYFdrWtA4p1IMVxNuEY42YxovDGuv9OiUqWdBxkVSHl6BE4amYob
 iIpg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dTVyv+K/
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

README.rockchip must be removed.
Move the rksd comment section to rksd.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 tools/rksd.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/rksd.c b/tools/rksd.c
index 7d46a1b07b3a..ea12b9cac12e 100644
--- a/tools/rksd.c
+++ b/tools/rksd.c
@@ -3,7 +3,26 @@
  * (C) Copyright 2015 Google,  Inc
  * Written by Simon Glass <sjg@chromium.org>
  *
- * See README.rockchip for details of the rksd format
+ * rksd.c produces an image consisting of 32KB of empty space, a header and
+ * u-boot-spl-dtb.bin. The header is defined by 'struct header0_info' although
+ * most of the fields are unused by U-Boot. We just need to specify the
+ * signature, a flag and the block offset and size of the SPL image.
+ *
+ * The header occupies a single block but we pad it out to 4 blocks. The header
+ * is encoding using RC4 with the key 7c4e0304550509072d2c7b38170d1711. The SPL
+ * image can be encoded too but we don't do that.
+ *
+ * The maximum size of u-boot-spl-dtb.bin which the boot ROM will read is 32KB,
+ * or 0x40 blocks. This is a severe and annoying limitation. There may be a way
+ * around this limitation, since there is plenty of SRAM, but at present the
+ * board refuses to boot if this limit is exceeded.
+ *
+ * The image produced is padded up to a block boundary (512 bytes). It should be
+ * written to the start of an SD card using dd.
+ *
+ * Since this image is set to load U-Boot from the SD card at block offset,
+ * CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR, dd should be used to write
+ * u-boot-dtb.img to the SD card at that offset.
  */

 #include "imagetool.h"
--
2.39.5

