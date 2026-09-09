Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88D7C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A28B94073F;
	Wed,  9 Sep 2026 12:46:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FpchQQjQyw2Q; Wed,  9 Sep 2026 12:46:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BA8F440817
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788958004;
	b=tG3dpUCn0okmwQi2JPsMi+uy2IkcO+d/MxC5GgoDxRWwDGUONMxadMRA80fpGrW6iI6e
	 kbXKwcpvJKa6VMr4Hb/sdZoKkmMtvCP/i67fAl3sn3eSwVOvHH8BKF6h7ytTjKAhfQ+/X
	 UBIpMMbeSCOlaO1Kl9ltQgscmJZESxQRMVNsOKO7vTdpVxoRP3I0d4AQKKugci4tjUfyn
	 9sicQzl4l4zoDtBo44g8UQHcNNGdgzpDuVEWKS8EJPp346bgzOTtdeGi2gLRz9h5beIz3
	 +gbTF0YfieiGH29p8XizlKBdobZdTk34Z3fr4NqM3Roe9t7D91Ycsb1XE480WBJfaig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788958004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
	b=SEAnYqYttGx24eHdgttgQRVoDZ+60MILqQLO3kphmDQ8AWmnjcQlwX8RV8UOWMw5XB5M
	 Aa65vi3jgzFfuOzQ82w7rG3TBjbnAGScFd9bKiv1QtGC9OACXFiGgrcrdnG8POfYue6/u
	 3exa7306DhOiEAwSv69Zb+8EPk2WXKa9c41fPKAqyOut+G74FRXoOWWNQSs8ywlQIHf8G
	 fQ9MYlhPzqjZBOrP6X09bpHmydLyh5XuQzdZBQtfj7X8GaVN1IDAinaAFJit8fkrLJDZw
	 BgVt+GXPmiiqQz8iS2MQk2ABc/T/gd4evsIOs8aOS2wwrh4vjLcNH6xirAIdQ5xZTFA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788958003;
	bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uy5nR2UIXH8CfEtrAQXDh7gudSg4ebSZrqS0nyOueNeaegacUZA0L89SZ2MXm2b6R
	 8XL6gCUTpzu+jnN2DrZndzZhrNr5zAirwpD5iy1MqoDIeRaDo+9ezM3ZVQm510dSrR
	 nz2nTUFn3lySIq3kn3esiosI6y4w8feQfDYvDQUnBSOf2XtMJdk2s6g9CmR/Eozasr
	 r+IymeW44x9rFQRceXI/h6tCusUXG6Il910nyy6vq9aca/+q7rsvVdhdTlht8bgGT3
	 sJ22RKQkBVF9PPvwoMDGwouMoo6tGQMjl9dZsai8mxM3KGxTc45DdKkxqzwvSy+sbT
	 lCxN7HFzn6cDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA8F440817;
	Wed,  9 Sep 2026 12:46:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EF569701
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5416606D3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOYLtiChz66L for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0E72A60639
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788944011;
 b=M5XskGgnNAbZ9If3PJnfFPXd6i0iVJj3qLkZXRWgPkThwGHHpcbxh23eU9k6eRc12kPp
 k3sh/IMZrK/E7Zvgbj9GPPhN/B1uO/KN1thtMWDy91uLzN8lxsrtgiFR4BQqVfcuCLVeU
 TwT6hGKYC0Q7eciyp4xQmVdJLpETul5iXg+OmMChDHeQqvXa2jXgIYfJL0VNGKzUJoIpT
 umaIutxyuhrhbrFIrDsVcJXf4KT2eSFDHo1QXsxBvc3sILjVTY0dHoH28AfaPXdtVIGUr
 4pr0m/TXGNxzLil3tyGpxR1bUo224FPuZ8gJWgO2Y8GWI/JmFpc1TDKIR4NaQPZES6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788944011;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=iAemBNQQ4HY9q41k4Mfb8w1eoTKRclNxY8hJ8LsCJ+X8EeqfBlwl1DCYbebV60Q5kH5T
 hi1AS/ejXTCs0gwEMytilpdaoZK+S/Pss4AMGV8QKl9+nYB1LpFtovBoKh70u9r4k4JJH
 9E655EKQRX36LvWZ4AShjnQ+kRTU0L2rVlaO+/q98xA5Nbu3NyYbs4VH18wx1J7v0Q2FT
 M+lYHhxmuoR9ZoyE/HMTcPM7f6CYaZsnZGBdnN9KgFYVcybQPrS/BkAYoaIxNI8MRr5WB
 w4LOWXqp/mKzUw5p1Y3pnRLgFCCYv/JdK+axsE5XchBGTvzmot5rYJo2i1kA6t2Pz2Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=NvJZfsbG; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=NvJZfsbG
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E72A60639
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:30 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2533bd37f0so67250166b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788944009; x=1789548809;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=NvJZfsbGKwH+Tt7ZEavf5LwrOZaGTmGwQzwUzGVDfNeA2Da6AFi7rxbGEKYu5hzFNQ
 BIKx5p5Wv3NGgT2kZWlwnrFlHW/f7adSskVjcsDBYq6GCfBFF9uXSiyjOFMs/cf9s31K
 X0Yg+yG64ulbjpK7TmqKyxY/o5sWNYu8b5mhliIFqfEWZ56WzW/WkI8LXAZDmfuAGI3U
 3MRRT2Y7kjhAuSjSGKi1ek+IRvydN0aR7PLKJGxqgZ4EVk/WJzCuIjGsUOaFuxCqzZpC
 AJio3lULqYBweO+wDoigxViISKrYsApCxb2G1aPZZxVfXmJC6vdUoTE7WCWWC8zwbn7g
 fHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788944009; x=1789548809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=G6SJ3muC8WzLKL1wOUtarmrcQF6UcdrNQFYxsJVqFQfKFb+3dRN9e9aiYlMp+NiYLO
 eIdG+i/g2JOfJYjXVVq/a4+OJdP8dKtILp+yO1ZDrWnwc9L/twLOB5Nj3xpbCjFHd6tZ
 vNigHLECygbbDQHXWwtjH2fbDgN4uomloYc8WHAXGHFu9z6M+v2DEg2/yK/16iToW+Ux
 2FaUrdGUq60hFOfhrne2O6a+whrxATTJswoj65Yon5qSEBdPAN5G+XbExbW77Q5Wk8Jz
 vai3Hf3MGx3AW7Hr9vZNFOQBhau6ge+8iS11iZZZlfjJJowcSfJdv5mQ8tqBTifWdn2J
 Tv2w==
X-Gm-Message-State: AFuF++lw5vO1PhRGiDYVYcmlaOXMpovQqdTumznf7peO1FrvepIE1u7H
 ToWfhhlc6A2rAcO8wRtgmx+26zjs25t8AGO8DR/lijMxl2UBrd1jo1A4T6Eiw/TtGTEkrj158Br
 piLMG
X-Gm-Gg: AYBFou11Djs5rBdJbEWBbcqnuJ51F9kMn+MKxMlouLqGgFmjMpsxl5m7Xi8g0AOmn8l
 8f97HeArBjJzaIxwcmB0nAFzztbtxhrKaJs4wq7foULOTyGLWLYQXUSVgLW5IfdpgLqnItBDkjU
 xUBiLwHSF0vtMctMy7Q6+P/D7F0UWecPLbvLrWF1bZPOIxTSP+Uy1UxW5DLYK2+/B8O5Zl0tl9l
 GJvJ0YdZGrvQCy1l5kjr+FiGOXW+Rla64TZpVwbI4tlRrMDwD2aCjHvfSaNlxT8/yMDKxrwi1Cu
 oUlx6CO1b3zW0UAep0Z5fyyYF0FsrWc3cpDUwZFggcgxWtG/cPw3QUJXPlQ03Q8kKXn+bWeqqB4
 ChRPfAaYb5/6HAih/oFUgWlILqYGnwVWFtx9QXgYZPCZ5mLIalGo86qI5YNl8JqNsIZU/jyBmir
 sEih3yRv7iF1k1Wib0cyxHqJg84Gfsj2D8l+0KGAx2pVuc1NaYW171xlTBVGF8V5D8jk47fBgmd
 eohIIELCYYkrxFFETtm3SgEuuiT+XRmGQ==
X-Received: by 2002:a17:907:9717:b0:c15:c651:f28f with SMTP id
 a640c23a62f3a-c262505e28fmr1044601766b.3.1788944008867; 
 Wed, 09 Sep 2026 01:53:28 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c262f97f1a3sm557381266b.19.2026.09.09.01.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:53:28 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 25/25] usb: cdns3: fix up after the resync
Date: Wed,  9 Sep 2026 10:50:15 +0200
Message-ID: <20260909085015.2480097-26-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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

Adapt the cdns3 gadget code to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/cdns3/ep0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index acff79ae1ca1..40282cbc3234 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -341,10 +341,10 @@ static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
 			return -EINVAL;
 
 		switch (tmode >> 8) {
-		case TEST_J:
-		case TEST_K:
-		case TEST_SE0_NAK:
-		case TEST_PACKET:
+		case USB_TEST_J:
+		case USB_TEST_K:
+		case USB_TEST_SE0_NAK:
+		case USB_TEST_PACKET:
 			cdns3_ep0_complete_setup(priv_dev, 0, 1);
 			/**
 			 *  Little delay to give the controller some time
-- 
2.53.0

