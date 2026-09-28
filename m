Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAA5C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9A7580EA1;
	Mon, 28 Sep 2026 13:42:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z9nFZfk0xXbh; Mon, 28 Sep 2026 13:42:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 02BD080E22
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602922;
	b=ftmGqr94b0pPnfizsEqG8XUSnRwyyCc5RLOEJEgGSOQ5K2orj5AcnVcD+1nvhgsTHFAA
	 n8lSc4L2yuJJjYq5nBHviIgO2SGeBGyis1iI0rjzFB9PmklQjUxSnHgynnOD3YhLcq6mj
	 hmCYk84od8S41OfXWo+wPrS3jS1KXKth1f0amPfB2LqJFfVUMoijDnjeWFUBaxqHGfTPi
	 xMfw+7geYxNcTO7owp2aR7fLXbYMwSSndv/vwtsWp1wnlPX6W5zWRisAsXx6mT1y0UIj9
	 JxktHq0t+w+Zokqxz/WLZwxSHvOZbPa8oAxSBtk9+p/w0OPZuohe2gInVDQ1sxBxmRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602922;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SZr0awnwILCngSBkKNAEzY4ka8QclMsQ0UIyqrWst94=;
	b=HCD3KAHgZqyzSSRzqq68gPB+eV6cXskK37nqZ9/D9JBsN3/QFffPFwF0pPsXVqvU4fCT
	 wVXP2+TfbLEXr+lYLFOD8gOyDCR4IaX8HgDlMfXNG/ePVt0KAZx1gz9/0O2QpXdHlBG49
	 258lmuF1MJlHY2L7QBY3yVI+ilk9bcpOvTy1/pjXJ+oz67KmfR99LFn9RUcW0nw1fZIO/
	 iE19FN+Je9WNmOx5y0P3PZtaLhW8+tPBELKQL3Cn8Z0K0rIETrNSm+7btNJoxrNxLPNHA
	 yVAhb0ydEHasX3panbjXYEFIRghcmxB7JrcWNGyU6cpJWXfAQpoSR8w4KPhQ3z7OMnQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602922;
	bh=SZr0awnwILCngSBkKNAEzY4ka8QclMsQ0UIyqrWst94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SX7zn+ber08q98+B9nFLgMGPv/sgxQLQQHnT7nIAG3BFwA4Tb5mtBnh0T9hyTJPtD
	 CrHp1gmJx5EcJ8JZsEy8K9ed3kGrt5rjkrzsFMd+RYPR25OQh3J/qGgK0/wHlqWqFF
	 y/mwjev57Z9FLUPcX/oLCv2iZFxJC4SGvgCtmPq73ctej/BaBFx8YTsRhNQpEn6EGR
	 7bQEJc0r9Zw3HYfa1lmQTAsjsrO1iSOLqHG9ZN+rVxEl18Dx01amrcp4dXUI4/yI84
	 tIRyxdJqtvVJWiZ8m5Hu5a33wdeLNNjuHl5izlB2NFYw1V1SFjBXLkqfMu0f+nYuVO
	 cTnqJcQQpBNbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02BD080E22;
	Mon, 28 Sep 2026 13:42:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 95532194
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BAF0400E0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MOQ8gQWINXEP for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 08:38:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4A12E400AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790584708;
 b=BK2Pb9euUwpJ/jGfwSnDGL9QOwd8iOS2tqBAMI+wycfDZzFhsK5td8lau2XeYLfncrg2
 DNdKWI3L6jA6fMLPoK64d8vuQ20BtoNwnoFMfmHpoKgXKDV0Y2Dzkd1NPdgRaM0X36onw
 5lV1WYzj7Szebx9sIpd+vIftUTGJbyPdCabBkOVdvmlf3z6722ykZuyOKi3eb9TAOSU4y
 xlmiUgzbpjcQV8QtXNWhctmw+fvWB/B9ZJWx7/O0W6BthyPb1UEhrdr2yrfP9tAbYH8an
 jbRhNof+wl8e+d9HIVKy0e1pI6tcZunouZsDyubFVUl5NCv9dAGXxyjxhGKmRX4vhlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790584708;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SZr0awnwILCngSBkKNAEzY4ka8QclMsQ0UIyqrWst94=;
 b=AbnAUch0MsbqfNQ1Ckd8iTPOgpsPX62jNl8gFY4NF7VdjaBRIb+lLJOKIQhuGI1Zb+Ng
 c0y0VZsHJXwGD39z5ETg6kfPtdExxXKNaBVmlf0CicqJkjHBXPiHrgKwHypag+mapM8n7
 EfdQODXrRGJuZVgVBEPHbeVZMCF84IVbZE4FlHFvSoVQgDl/Df68sA0P6TERlMUmA9CBF
 ouUc9TDhVJA2tO7RGjkb1lgAU/1IUwi40uwuKCAheBqyKbZdg5i9Iiz/vV0/G3K4M+hTN
 a7jWxyoO3ET/hRZWRfFo3LzZksLIFWLlZV2g+t4EMJcNs5XFT5O7eeUvf3TBXQ7V3Hg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FNHcOGNM; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FNHcOGNM
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A12E400AF
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:38:28 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso20034775e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790584706; x=1791189506;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SZr0awnwILCngSBkKNAEzY4ka8QclMsQ0UIyqrWst94=;
 b=FNHcOGNMlzctMQc7PP72m5w3UG8tp1nBOntiAAvfsfWNS8EijbBY/20THSWZA+gSkw
 oXOQgVHwRsiXXplSEpd5QF6VZ6SPGuoGkraDSHNi2R2X9ZC+Ik8kf1wxarRTr+PjLmlZ
 nFIPD9UtwEJXjY3LZZo4pUyvIvwKyQ6MRae3sVacESa4HX6KZzm3gXmuDGA38il3r0LN
 pmNzftPLUk8Fbe6UDYFFUWUmAfcb6PJXwdfEMRSP11FyHqby0K2WFboof8hnB0D5r64m
 KbKdMlQFYZ9j5z5tg/hbSMSY7LBlm6xqS1p744yjpevkT3FQ8O5rV46F0HoyDLO4Q9Rp
 ck3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790584706; x=1791189506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SZr0awnwILCngSBkKNAEzY4ka8QclMsQ0UIyqrWst94=;
 b=jRcGxv9cKcZC61Ev0C3bBT9QUrBcH/dyCiUnEPZ81vvG0HGSfXqPWtDHApsDD6Hbbo
 lJK4TPLwjOM3bRPvEfxDXso2iDjy9kBOfiiy1rm00WRHR0lNb+RFKtzEFn3+Y8oRsUdc
 J+rY0j5+NoHCTU3o6CSM3Xf02re04M//+AAA/YlDgwNpdaEdPabjGZRfvNb1pRmedjUB
 KFM3qVlV5Wn0ShA27S0aCnoTX/ZUEwC1kykVQSIH2nBWt5KUwYMZlbniwhs8sadjqhjw
 0AjTiBBRrs/OWYNLaIugRHMv2fSd3m1cJwEr2xwhDXaB7/VCk4p3UGwInr35WHSUYkXF
 kovw==
X-Gm-Message-State: AFuF++kV/QzpwlsNKdn0HUGH2aZeDZaPnhYiCjrAfcT8bQ77Qkc22Z5e
 Agz/nsvdZKaR4RiMCqaLl8mrjQLQYjWShd6dHjx4hPZ8HdaF7RDY9xlfpQLhTnnD7l0z+w==
X-Gm-Gg: AYBFou0SBtI7a4stHdolpiQCu3kEoV0cvyStGgG6oQ3X9duEpBZDewwLD3iLyW/7pVZ
 SgMX/TQcRESM4MoNbUi4nbB9aklX0hUJStmbaaXdA+PNQgvezvA1i0V+RXNnvgO/b8Ul5G0bIeb
 au+BBG9nCQIVjeuFUDF1yJWOLvET+f0cMsLcZvO+PrbjiDNQ6Bqlsz1Bs02gMNjlpCh7hj8A9gs
 EXSCLcgmoCITlOUkD0wpb+37oOyiWKnyZ23w/Gi5rjOeKtBVFFArjVpEz0DzCInEPyce3q+zyxg
 lAl7madcikvKLYlCCkZQR5HVceg/2YZTbICISKZfLmyKlMQtalzW1oogAGRXfjg/IJU7Yw8pF5g
 OAjTuE2FW0zrhZJeYD8yvvqUaqKdDoeO36RNi9AUQfLQhNjv15f8uJSNSkBeRqyUAm4Dqf3+cla
 p9zipRjYoQzTFTBvuxzMwhUapaM4w+qA01EUm18U8PgzxX108Byw37YjqE96KLBsUalFPNv1MYh
 aVng+ILCu68pg5bNWVN5R6dWX3jDEpyVwnXC8/yQ79TOzkQ2nQrgnWqJgMzCN7qq+ce4edtavyW
 /SHHyeUE+MFtiGsoQyMWf8tpjBCdemehZtw3dA2Gi0w5eCK2H7MPb6R9GptupkTmxek6bbVJAQq
 AU5qdA8jKBw3Y9V/cc2xxBq3Ff1CWXr+q
X-Received: by 2002:a05:600c:83ce:b0:49f:ffa2:1c67 with SMTP id
 5b1f17b1804b1-49fffa222demr61625825e9.7.1790584705884; 
 Mon, 28 Sep 2026 01:38:25 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-c000-0ddf-e9a2-82c8-47dc-7bbb.ipv6.o2.cz.
 [2a00:1028:c000:ddf:e9a2:82c8:47dc:7bbb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00179c729sm191700405e9.15.2026.09.28.01.38.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 01:38:25 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Priyanka Jain <priyanka.jain@nxp.com>, Heiko Schocher <hs@nabladev.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>
Subject: [PATCH 1/3] ddr: fsl: Fix SPD read when legacy I2C is used
Date: Mon, 28 Sep 2026 10:38:18 +0200
Message-ID: <20260928083820.62352-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928083820.62352-1-pepe.schlehofer@gmail.com>
References: <20260928083820.62352-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

Commit 98dfa70f84f0 ("fsl: mxc: Drop legacy I2c") replaced the legacy
I2C branch of ddr_i2c_read() with a stub that returns 0 without reading
anything. The legacy branch is taken whenever the phase that
initializes DDR does not enable DM_I2C, so those boards get an
all-zero SPD and either stop with "Error: No valid SPD detected." or
fall back to raw timings.

Restore the legacy read.

Tested on CZ.NIC Turris 1.1 (SD boot).

Fixes: 98dfa70f84f0 ("fsl: mxc: Drop legacy I2c")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
---
The i2c_set_bus_num() call that the same commit removed is not needed:
every phase that reaches this code calls i2c_init_all(), which selects
CONFIG_SYS_SPD_BUS_NUM, right before dram_init(). Converting these
SPLs to DM_I2C is left for later.

The SD card SPL built from main (v2026.10-rc2) set up DDR with this
patch and stopped with "Error: No valid SPD detected." without it. A
full SD boot needs "mtd: rawnand: fsl_elbc: Select NAND_ECC_BCH" from
the LTO series for next, and was tested with that series.
---
 drivers/ddr/fsl/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ddr/fsl/main.c b/drivers/ddr/fsl/main.c
index 2b879c63b5f..bf471ca97dc 100644
--- a/drivers/ddr/fsl/main.c
+++ b/drivers/ddr/fsl/main.c
@@ -111,7 +111,7 @@ static int ddr_i2c_read(DEV_TYPE *dev, unsigned int addr,
 #if CONFIG_IS_ENABLED(DM_I2C)
 	ret = dm_i2c_read(dev, 0, buf, len);
 #else
-	ret = 0;
+	ret = i2c_read(dev->chip, addr, alen, buf, len);
 #endif
 
 	return ret;
-- 
2.54.0 (Apple Git-157)

