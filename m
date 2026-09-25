Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1325C9832E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C50C581131;
	Fri, 25 Sep 2026 13:42:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id api1yFfIhbzh; Fri, 25 Sep 2026 13:42:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1B1D9812E5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343758;
	b=JnC0Zv2h4RQTNEdwhO7BS7CmxWTuCCUO+hJbu43FAWyLg6wDihfp9YByQCDZnf5yN+7u
	 rSCp+L2F5mN6PG62FpBmBNLU6DYd8u/bFzGnryyP8UuRsu0yUUcPKfCSrvHF/uslZwE+h
	 S24+9gmGE64mTpGSCh14ZgadzIlWXtpnvk4tFokyKbocU54kLuHs5JxtZF3TOl+lzCIki
	 qOCynLCuMRdgUtRmX30btJbx+HjxqDzS+/fR4Gf6fR2ZzkP3ofydjZPSpVpCDWCPsvWmU
	 xcpJLlgy+gZ/eBK9H1GpmfymEuqDq7qukUI7dHJWsGZfKs12w6CXjkzPgVFqah20UlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343758;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sCycwxWCKUWrlTXAQFP8/HCsPLcRxsC7FGA4ECLrMM8=;
	b=eRdZIpAJ88h68WSGfDxp8rzFPH+OrGyTD+Lq3S/4A/G77f0QKLyKhP/A5McohBawUPyt
	 itBaEk8sn6Ti31uPH9XPIBeoCPeM0dSeDc37IavULeNUIKUx6UtJZ1jlzX8Yj5+0Jseab
	 DE82dD7MmjeChWTHtV33FPQ6AOvQz6UxjGr4fBRWLWMnkTY7TYvzAAgGxuyOsz3N0pDpd
	 m5rRkTAYP6jmcvJ8J3RYzrQkLuKHr52tY2qLefc2nAjhkTPFG5iINZjZDbzRHl8M+thcf
	 PpsKYz66iz256um0lWRD1k0gBDPxJaLy9+3FEp9kgOYPE4dltsNI7dyBD7fwWaHLJ1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Dc0VpX7z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343758;
	bh=sCycwxWCKUWrlTXAQFP8/HCsPLcRxsC7FGA4ECLrMM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lfb1z+nHQfmiK3si5DACQoJsdfmOCxmRoZL0JqR0Ck57RWABCpq+whc0gJLg/oAez
	 9NL/+YDLQ3kkRigYEp0w4BfV/DcXBavXqhH6EZCL5PNoFeqi7eXQjG7LjTCviSRwrE
	 vjqCWfYBugd8lNWNRa/mf99eXDy415JZYoz11y/3imLQMMyVjpetGk0g/kjW4Bzay/
	 Y5CplWSrLVOAQdU69Tpoyf1Gk0J+k8QLWSuckoKA0Zp8IvjqQM8WNBQMNOl+sOY2Yi
	 Ukz52WOc5waEw4OCUQY1x7euK9YL9MGE78Nl/rPsfJ9eM5bz4plgCXxQZ0WNdRDiYJ
	 z7gND+UoBVbnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B1D9812E5;
	Fri, 25 Sep 2026 13:42:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 00771B00
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3E76811AD
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ek4zqJumOT0d for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:42:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EEC8F81131
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343754;
 b=rWrdxSdLAM9TJJmj6FzqLlovitm9VlmoRM9eqjtSvJSAO7kbrnoerz0MXLFdaRlzXx09
 VeqzEik9srdiapFcu3eUl1JilG5zGYp4qkATeOJH2Fs37r7Y0+JLs1XNpWOIf2lrUKHPJ
 OGbbezZef+yUBaIfhRC6SICIryi5tvlPzB+P+V+zqztsNCtrLjMfMzaMMFtr42EilNdnU
 N8q5SRRhBD1HGGS1GAIV11fcn663acmQV2rnuByYZPuq6ZY4j5SVtuJJueCoRRX2WkL0L
 0bJNIaJAPVZ9vA8fPed5jZAHh9Ppgi5mG2NzpDI3cdd1EhyF5JHcf1gEOpC5jcxtvdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343754;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=sCycwxWCKUWrlTXAQFP8/HCsPLcRxsC7FGA4ECLrMM8=;
 b=rUvA0oVRDBh88MMFLUqalBxGTMghuy4jRIP+s0EZ1T0KA1XUwBtYGnjljHCvwuBl1iyz
 H7icSAADdZKK9zxLmF5run4YCpb5LQU2VVJzVQ6uXTUz2ObrsSdHCVf5yj5W6dZFln0tx
 YF0dOg+ige/UycioBZznQVacB/2cHLTznk8mH44IfLsv6t6FEUOnw9h7SfAZk36f4Fazq
 yLNLDLeZ/zqs+tJeJusL4anZUuw9X8rufZQlyQ/NEdSb7ZykwFEdNJT/UJzTu20M3bEDt
 SV1rrkewOLL1AkcW03j0JlnWnSV74YCABawBxg5C9hBDnU/JAEd9/fXtVfuUvAtNwuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Dc0VpX7z; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=glaroque@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Dc0VpX7z
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEC8F81131
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:33 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4888129c46eso329906f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343751; x=1790948551;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sCycwxWCKUWrlTXAQFP8/HCsPLcRxsC7FGA4ECLrMM8=;
 b=Dc0VpX7zKOsX1sZdIDjj9UZAwwU3pXjb0e19P2Me+1JAHzVlEsKQwqEO53VvIsOBL9
 SIuYEx7+/UU+0FDXYMC/iytF3U/EHNEW2tIQD92+68btJDi3+0lMq35PDlQ3Fw8x2eQz
 nhQFEH01by7lOZzn8PJ+sADiEH2nLW0k7mu3MvmapjRVfXkAQnTCOZJ74IPVER9SNp20
 cjo/EPSULL19mOmxNob+DH2utO5YL8TxhjxNgj/ova+WomXVFOO5uiq1cemnBV/IGLsO
 Tan74VTuV+/nux28QfPhXaaRwS4l0X29+FaSB9mBvOoznNPZPsGrOkyGRL226IbUe8N4
 t40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343751; x=1790948551;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sCycwxWCKUWrlTXAQFP8/HCsPLcRxsC7FGA4ECLrMM8=;
 b=hPFNeP58ZngbIElKbPJSXMGbWQgvbfQRtEz6ZwSltjaATUxZPs42rZZ4XV4LyfsbhS
 JZ80wagrjOiPwGV2Wna1cMLYQP7yasIoptmygj5GWQpOMJI+blVNoz7l5B/N7BEEl4+Q
 NQTH6rTUuXSaL4kQZ4tIpHSuko0YKKPIFFNZWytUgy4hE2coYgDp9ZDFGYb54TgwStA+
 ih/sC9wht3rQmoORvBZZBbX3WJC8dSGEXLJYXW08ePa2g37Xuzo76fio7FmIkjSPRTJW
 WhUytAsQuz6pfUOTB5ame3abfa/w/GyORJc1040W4Ya5p3kaNcmBIvxF6yzWe3ESbo1J
 dilw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlxcBPhy0R3qiEpJftA2KRUiEz24huEB0/lWO2z7KCpfd0YerMglQ/uwFEJMyrLnz+72/wLEE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mo/IZStTviGvEy0uIP20+qxuZowMn8/rP2aVxREmZ5Lq5a44dh
 5W0Kkh/tCclSpQnvJlQGI7JaEkDlxcE9NRg/KwvQI+QVTyBblejCi9wv4G42Mg/0gKI=
X-Gm-Gg: AYBFou3SXkyQnTJvGGgM3udT2YOUYFaMLEhFG8iF7iG+rZPGuzbymFKBcWr+7/PdIiY
 oKzO1ShaDDTRbInnz/xUqY7VFYwpbVXS2JZ1Z8mHUdr5Nxeb8dbp+8rwKYV8EvIt81Z9QbK5Mm2
 414+G/UkIWvj+KNurxSUj5X6Fyxg3EMNE8oZZ5IpX8Pv4HJx9ubRtvUS90DAGGIpE5Pr2lC+9/t
 wG/EzAZjUwRAt2ULP9kQ35BYkOnlfVqw4B9yzHgvJC1dCQ6CuwbUVQu06+yLH+YwmdtKINgvsQL
 AmIX7jJBPmt6pSt45LgDR5ptLXxQchqiI2rHhExmoHmRi9cRJg4DrMZXTPiIs4bTjD12keCTBbU
 NvuFO2v2ExoSyA1NSObZmuqmn1a1WzatoGPbL4wgvCZVCs/U1gQQtQ+YFgigsrVrj8k1ZTSiTrY
 jwFHUXPoD++qS1xYrlAlk/9JOQCj+qFgBfI7mADbALss/dCw63MIawO1UzWEsOTEpDZavgszRU
X-Received: by 2002:a05:600c:a4c:b0:49c:fa20:cc08 with SMTP id
 5b1f17b1804b1-49fe67060cemr101189575e9.31.1790343751341; 
 Fri, 25 Sep 2026 06:42:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff42b7074sm34738125e9.6.2026.09.25.06.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:42:31 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:25 +0200
Subject: [PATCH 2/4] configs: khadas-vim3: enlarge the fastboot buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-update_vim-v1-2-fddf7ba4dc34@baylibre.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
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

Increase the fastboot buffer from 112 MiB to 512 MiB on VIM3 and
VIM3L to allow larger downloads when flashing Android images.
The buffer fits within the RAM available on both boards.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig  | 1 +
 configs/khadas-vim3l_android_ab_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index 463dc31cb7f..9022587d5a7 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -63,6 +63,7 @@ CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=2
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index d0cf7d39482..6488211e9e4 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -63,6 +63,7 @@ CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=2
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y

-- 
2.34.1

