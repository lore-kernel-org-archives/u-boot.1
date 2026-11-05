Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDA606A32F
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AtHuoRfY;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=h04KeQpt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6244A408D7;
	Thu,  5 Nov 2026 23:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Srbxpm1qa5vs; Thu,  5 Nov 2026 23:46:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A7ECC40818
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793922396;
	b=TTCUq27MgfX7eGRLA7NUTlcXCG8zyElUgvs0GoQMBafl+3Xdq3aldHvy6XlHlEQ2ZJky
	 AwXIP/8yjFonHH95zTBSUjq8r5O4iHWiyLVh7DeJOQj61UX88c6zRjPcbHXqXrXvTN0P1
	 IcdyfsVFNgkIQEw0SFNGPjz7K3PVnEuCWaobYxj0xYJ64mQzoxOP1vG1p+rdEtGehzHC5
	 4tSV9j2S6RQv2Q+kqBFoNIFsvPlHSpxqjLFaNJdpRkBM1VDFoC8IxPDRfV2JEpNQDNhu1
	 8PdInVxGYhfxR1E3Yb9r9nZi5ImaH7LlA/M8RfSFDhlc922c1NZp6n1vMoMpOeXQGcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793922396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0QAMQ7Q0LKencEv+sePhyXehSmT9jF5bkrNHFfrjGqc=;
	b=eTiK2qEOZ+7AV3sna3eykPfYiE8ZvU0aMzR5s02wacGa/Uoe46U1HsWdz9WMSI7jQ0nn
	 Q9evv+BALADS7O7NrB/pdXdl7gYVrGDNcXY0+eBF7o60qflDJm2cLeCESyoplERSLrFPu
	 x/IdiozhksbYH+RN3O0XXZfaePjp57X/cowIZjQtP7TyRJ6MmenzoeJP4jp5cVHN3BFp0
	 yTJsqIwJokOs/GIy0QpBtKjzOypi5VDXyrjWsrStOMffBMHConkMd35WzVNP+zHsX6vCY
	 wtKSEpm80rGo4ljd6eJ0Jb9m1lsQYTdqtM2EihZ6UNoYF63S2kV3V3xLn1XbkKnrCIQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793922396;
	bh=0QAMQ7Q0LKencEv+sePhyXehSmT9jF5bkrNHFfrjGqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AtHuoRfYcO6p0s5sZBtCQwSKIXFtcud0l56Z556/96y7RQNKHiWYtjqL7QtxQJsw+
	 PtDtfzoHEivR9LYHXKX2AQrFvJqvNVAcjzr1GftGbxYzAfSVGyoyqRJzGKkGB72IZs
	 ncT22YOGTM+DY46PIbTwHGZBkHvLPIe5+nzpuRVxPaikSahyPDKr4ONg9sIz7WQgzg
	 yYtJ3Xxsp9lISF3jLD/6+1lSaQUYyS9w3mCK4suGb2bFVi12+8mDtCaoPrs6V2N4Pl
	 VdAtaj63JcKHDViCbP1l6Fh7EQWoRP+6Ff2Baj5XGdV4e5cR8K/BzITUrlF1lLb4KQ
	 pKFQZEV0OtfqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7ECC40818;
	Thu,  5 Nov 2026 23:46:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A206649B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9440C6085B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PBzPMVMzrcpD for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 23:46:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DEA32605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=h04KeQpt
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEA32605DF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:32 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-716d052dc23so52127eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 15:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793922391; x=1794527191;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0QAMQ7Q0LKencEv+sePhyXehSmT9jF5bkrNHFfrjGqc=;
 b=h04KeQptguAKXngHwgGU5iToO7jhlcQowI09ZiAXxiq58ohRyBTIkMfIcLeGWIpA4T
 nhXATMOxGs1kERmlMjGyxjWO9Kfu2vFG5EEkKoaNvDw1VMRBu2jttJHLnDFbtQmgvfIW
 eUoCWefpqhH6cRJuHKIJm1IaFA1Z5ueDr3FLtz8dn8zLDAfbWY1Xapckoaz9jDUCNAsf
 EPVCPuoSeQUmzu7b6VN0tzpcOTUe5vMI9Spltt0XmuB1yAjy/0S0TzPfgSOh8ydmnt9B
 GiM/1KZa9p17V/hS3+JllA+nEGuBiN2f4h7ut2cuS9lKa8NJDqsBkBLU00B4XilA8nZr
 Hi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793922391; x=1794527191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0QAMQ7Q0LKencEv+sePhyXehSmT9jF5bkrNHFfrjGqc=;
 b=pSVQzO/dXOpj99/JafOCSk/vda6uElgTGsWVekxKd+/ffKQio2n/3mSPrZVZNRyeLe
 gK27wvkwL678ahF0p9+spsb8W6jiW4sB/0TObkzOhPJb8LWG+ho2Ni1NS29ormpRSaf6
 ygr82Uc47tNY9qZdZrghGuTn9YtRQQDgiNYL7s4v/SmJvCTwmkAnwFhdMyOGZ+vvoWnN
 q493dmMM6ehbB8PHCYvBx+O558zJGt+HGZUTkbyagMkWmg9RwCyqGbjkXRNYiSjEXgqg
 U6aAaVT08xKEQlXIML9TZAwQ02rS9mf5DQkJzBHL1QgmXOtsYri6rz4tUkE8rG7IehHY
 Rb4w==
X-Gm-Message-State: APuU4Z+Py07ZaIEPfSQjeibeMfpJpFloSdhWWQPdxy7AMHO/0eeRWkan
 hfPxFlEtEtH7MGpsjSZf1mVt8UfoCbG/6FNNpqUSPXPal/pBDZK8QPwB0T+D0hQi8I89R/TfZ8j
 ZcGlcWf4=
X-Gm-Gg: AYBFou2asWqh4xjWJShXWAEEuVKzxcYjIK9Fg7SM58ZyqtPLCadtJ6xTE06btOkd3Qw
 6vWCsrzvFFqjV5RutuBm2V45SucW8t8tGmI3H6OwlXuBVUXth96UXOe1MuGntayjmO1nWIeM15c
 lfL2YR0TwMoXjYbEzWiLnok7Aaq4SYT5Zm1mbwDexzwAsczfQ/OOJmVmCXmNq1062JnM96wDTTn
 Xu8/vL4tr0pkCYq6urS7+wx94CWj4eyAGHDylY762g93uXYTh9jsYOG3KeOy52w59GK22Bflo52
 J4IDrPS7ynUTGLX5OuQYQrm6uYUI82CI6Sd7w5wZSnCjjgq+MdvUqBR6T7dr3Z4zdejO5cpMzts
 jaUVj92ZwbISlWcSKx0uTptEJKF1GUjW6d0ZazMU+whptXAwdvTAEkehRoS/fvDc40RRQAeQGlX
 8zD/IG8iAhixIyXoQYvhKofICg1Fg2SD5dwDlxONZ07M7gX3if7EO4wP7KBXoFEle5EnSwvVCR0
 kSpGK4C7TsXI1Q/qTLExRs5FRJQ+PUB9XDuEDAiovkwaV5Jjn2+4D8PwGbKjz6SsiW/x2Csqut/
 dp6raL4xw/Gw3qDHZ8QlBvJQQT9ZxAVauA==
X-Received: by 2002:a05:6820:1346:b0:70d:8086:e48e with SMTP id
 006d021491bc7-716e78bfdb5mr701418eaf.20.1793922391479; 
 Thu, 05 Nov 2026 15:46:31 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de4e53dsm592122a34.20.2026.11.05.15.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 15:46:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 17:45:25 -0600
Subject: [PATCH v2 3/8] configs: mt8189: enable bloblist support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-mt8189-tfa-fdt-v2-3-c168a7b4041c@baylibre.com>
References: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
In-Reply-To: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QIiGeu0RlcPtvISTnFwTfRFWm4zx4eUS3GBGnJBRZa8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7RUqdzmKemRyQ2KWtRqIY7xqv4+TWPD7/DuVn
 3CyYhvta+iJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau0VKhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AEXIH/3U3BH6rrjhmhTFdJrg2py+DvEwQqwjaDKGY+en
 8g9q8QrVdMoX3bKJnrZ24U5b0mBSxSPCRgfTqIlpDA4XtoiZSkbTgZmgdEDYA6jXBBhij/rW0a+
 HHBiTuCSvrYwMeHyGRCH0Ybu9Slby5xUadQEfE01CKqObb3E3i+ImKZXeEaj/mnQImnz5rtTCq8
 4ESkLz94y+PqYYFHcQo6/euhSNGwKxcFCXZemHBsXUkOTOsc1YUKNVue2DXF5vh5I1Sg6nOkY1S
 sFtkJoXD6JIbBWMmy/q99UyBcPKAcmzmzNTM0xFivW5lO12JQk5JxiLMmLx7rrpHHGAqSM+GK4m
 wbuA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Enable bloblist support so that U-Boot can pick up a Firmware Handoff
transfer list from the boot stage that initializes the DRAM.

That boot stage can describe the DRAM with a devicetree overlay in the
transfer list: its size and the regions reserved for the DRAM
controller, which depend on the DRAM fitted to the board and so cannot
be described by the devicetree built into U-Boot.

Allocate the bloblist in SPL. SPL otherwise defaults to a bloblist at a
fixed address, which this configuration does not set.

Reviewed-by: Carlo Caione <ccaione@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 7d526041ebf..efa95a2fe03 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -12,6 +12,7 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOARD_INIT is not set
+CONFIG_BLOBLIST=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -96,3 +97,4 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=1
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_BLOBLIST_ALLOC=y

-- 
2.53.0

