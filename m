Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1942CA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 12:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FB5860B0B;
	Wed, 30 Sep 2026 12:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GKo3G8CqGQoO; Wed, 30 Sep 2026 12:52:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ADBBD60B2C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790772737;
	b=ZDISZs63XxUytGj7lU5ShtSE2SCU5YFkOQVbuATiP8rjOVk9h2izyGeeSDv1vHE3fPH/
	 TIg4dCyQiXSLawQRbzbLllb/hrysXWSRwyXTzf6Qzg0s/ewTKA9iUwjDXTJxrcbDRxZx1
	 Y3wOmxiFkyeU2RynY3/V5u6dg2RsM/xTMBlJGvzsf2zweCysllNB59Q9+9RNOkE9JNTyS
	 HYxSwCVoGVAKAUYtGhyRJV0vbmlIISJrCRAlflsyjQzrcMzFvgVgJcFXVYRQvhy5eFyUX
	 z6MUGKgn3hoKAI2TVxCz1X7nrMpjOVSW0li0RzMu3fFFEgcbXYv5By5JHgd1nzhWVXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790772737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=doK06mJAf6ycQxb6bVPiGcCcBGimTq34aj5lSCOcw5s=;
	b=pztih5dwJnP4wO9pVW7C5Qhe6xHYks2YYiq7CUCNd4lC2Pvk+vGH/BnzHEooF2sv4Flf
	 VQI+ccA0Zno2JLj4fBOXYdCoaUXdziGzHV1CbdykQ0rJUnl8GWwKHkIf8Ar31PNUl1mjN
	 0WraCxH7+EWR4t5eq5rSEeUsjSDIW2y0llxLlvc5HZR35HFF+mfI+VhR+Q8UVq+BMvxLp
	 dJ7aL6YGdZCsCtoHSMRLRx2kkS/UVO6T2dA8BuCE6VYRy9fL6AFYqFXqlnmrjRagaEhRu
	 XRd2z7ppFuplU/IsMqBVJq8iOGDyUOsyOP91ATun5dZVre3iXhfTB9DrC4nNxqpXEDA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790772737;
	bh=doK06mJAf6ycQxb6bVPiGcCcBGimTq34aj5lSCOcw5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SsY5YdZbh/lXJXkM7zybuTkbWree5BGch87iO0lgPiBPHXJIqW1nfP3XscAvDGAsv
	 5qi+BrCP7JnZn2pObQzZsP0gp/VoLRUXB/ThEhBZnaxRfYjyi/io+sqUuM9M/3WwHs
	 e4IFgLwZsRe4tx+fp1QQn5UVmZmnSMoX8LKJXLCqJZ4e5ETvQXSQ3Me3nqpqTTASQh
	 LxxNV/fvxdOY2PlXsNGBpagCZiZFyOpTi8rwmj3mnQ/+zz4EIl1/tJmd/u1k6Spbv5
	 UHN7eRX+88yQ4+WoOuTI3gsouR+wFR4POS/fMHKKneHti1CtIIwe06KPz5Soo0lS+w
	 3DfEHnp30EwYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADBBD60B2C;
	Wed, 30 Sep 2026 12:52:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1016334E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0172140A71
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2OQp7IFusAtp for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 12:52:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 57F8F40A6C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790772734;
 b=Dnku/a53blEXtrxQHhv51xgtXpGlgwyJAah2YO2MonZnAV9s62zh+SBjWUgvukDECPgG
 ha1sNwjVowXg6MfndhN4wUK01mlmKHVlkiVwgWdWwA9qKwSmSnV1OCUssea+LSbDgdBe1
 eX4HbXkOsMEVtZYXPQRFcIAaWPJnOUnaPaRVZ+Gr2iNUjWgqUlHR8I96bxC5fYmDGNt+9
 IVrOyNRfxxPAIj94k7CMSU8hvBc0LGDi3eSmmjvnWznHchgGyhcGO5z7RPapeRQRKd5Rk
 f2qXfF2PkwPoLl2A+WDapnWRAPTqkyUDHWxYOxG1mitJg6BhyWU/pRpOfprQs3ywoAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790772734;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=doK06mJAf6ycQxb6bVPiGcCcBGimTq34aj5lSCOcw5s=;
 b=OZDTSLccQso+udcHtFSJ2p1pe9JSNBEw1gbVTnIVsnKUjCNb/WpCJnweOrc2K4yjmuA7
 Ja2JqMJAocumII3RPzHKXW+CwvtwsINw8rZ07IwskW81++oxkoB95IgAQSM1F/yKZC4y5
 EFRoXU/xgERQsBVW/DjOvH8Kp9HYEYjiBGPTtMSlhjqBJJL12WkivzIUCF4kPebuI4b3n
 R9ttRxlna6aPBxsT9wEYfzKA6c/APM/F3Q+P+2Ko2Z6jZzVDiHC4N0OBu7TtUVaxGpByT
 V7iV/nPJKTcKIawZMtPfGX26oe/tIH9qnPROxge43QnUVlBI+gmwcW7NNB56xKdcGZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DfcgdCqk; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DfcgdCqk
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57F8F40A6C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:12 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so39843465e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 05:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790772730; x=1791377530;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=doK06mJAf6ycQxb6bVPiGcCcBGimTq34aj5lSCOcw5s=;
 b=DfcgdCqkxO98ouTqrv0qVFFnz0GqHWrqqW8Bs7eCixxEgGuUU5a519Lv+ezhjYw9Pa
 t9ZIw05XQoxjczD7CX6zwQF9taC15XPexPMMxPwX+Z3rYgYp6eNmsejDUgBDcNLEuzdz
 Nskm0GRZwNFTMpdCeDJz3oa4TSbiTB7z8ZABnLXTgwEGHLVna6afUZCz8TfenNnEURpi
 9Hcii5zoJfsi70S6etkoW1+IELHIOLgKKVnkQAC2jIFmHbnAF8zTl+FMMraIVcrmRDFW
 fCTGS9waFjp+NBO4OlqeA7OWUPCgBq9bj0O+GcJZyCdY/QfAfeffiY65u5YSvVfA490i
 tEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790772730; x=1791377530;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=doK06mJAf6ycQxb6bVPiGcCcBGimTq34aj5lSCOcw5s=;
 b=klBX8mKsQX+q5ymE3tOH7TBEQBinKvwWGOUXAUtL3AtBNiY40V7Xud5ze0UTOEvmom
 95BQcoIb/4LpDQrQimAG39CFEIokjuFs0OTEjckzygoFN6say9YFSSuWRl7sG708FZk0
 kfSkukOb9K5xP06I2VhqCoEqWC9tUn8HquX0Ljau9onIMLkteeMBH3LvjLFsX37D4VGS
 btkRJNbGydWxSFpjxOdNHxQDDTOEipY9cclaXYI0TDWnRsmXKV9R7NSnetO91vGb9c2R
 zrCFkLbZvIpzvpW3he3jSEluTM0q8qw34nybaw0gKTSV3fRxQ8BS9fgDvf0uCsehqD61
 Kfig==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/SRudEB4k3e5fra1PvNbFG2F0zNfWgBluCYMoqmAxsSE9HWZP0yT/d9HbTZ3jhCuwURGBj3s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kU5dx+guRNOFjoPbRuc1rpEb0hu/i3Tj+vBkbR/u5rCdGs2rAT
 0sqSRoUQ+tFu8neeIaeCq1wZMKLh+dVywi6Xd83x7yLSojkJe3MtCRv7A0k5W9ZihWg=
X-Gm-Gg: AYBFou3ugkJ3tAtiJxHyj3NZO9VNmVg08QZebEuTQUCjQAyZOUWfkktPehAIT9p2Ve2
 Qb0cmespwEcO1l0jHcjI39mU6fMBqX+vWcP9c7YAXJh1uKU1izxK3Gz5uIMuvYcWFvzzMIKGkCQ
 NIZlSIspm+hvfH+5I0EmxmOT7JKOo43Mg7zDujve+dENmOwCYhsJC9/w6VaKbXRIOM8yk2tAvnm
 J1ey3TySTCahmdbYvADj9HAGDq6dNjY1vSyqOR34NDSiJzKZvFSEC8PAO+lw9Gi8Nqc5H72+CDb
 Fa3i160VqEdNzNBjpFs9/tBgRvuNxzoFsNgxkmSRhndYcGay2S/0M7Nz8D3HIGz6QTEWMb9Mzu+
 lkhJz7RuYTAaA7669HzGt0asweddloxZ+4Cz9Vzim2z7qV9VR0gambKMsCHooIV27aG35uPhKob
 kisugfd/n92WXGhfld7ia6uHwa+/lSFqVC6LWg6BaV2ZeLy5GFh7jnZYstaoqh5xuxUAL3EcL15
 J1bU6huZjPGtIeSnVIAkw6bP9H29l3+Ci1yAaI+w57VG4HjbLGbO8WarTX5VpAOvTFmsUDkZcim
 yziqt1WnPE9S
X-Received: by 2002:a05:600c:4714:b0:49f:fe88:e7d1 with SMTP id
 5b1f17b1804b1-4a01affe8bdmr25108615e9.15.1790772729809; 
 Wed, 30 Sep 2026 05:52:09 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ca32a44sm9928905e9.0.2026.09.30.05.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 05:52:09 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 30 Sep 2026 14:51:34 +0200
Subject: [PATCH v3 2/4] arm: mediatek: enable SPL fastboot DAs on Genio 510
 and 700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ccaione-upstream-mt8390-da-v3-2-ae6091c7eda0@baylibre.com>
References: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
In-Reply-To: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Carlo Caione <ccaione@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
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

From: Julien Masson <jmasson@baylibre.com>

Genio 510 and 700 need a way to provision blank eMMC and recover from
unusable boot firmware without relying on the installed bootloader. Add
a BootROM-loaded fastboot agent that also prepares the eMMC boot
settings so newly flashed firmware can boot.

U-Boot proper is preferred when the complete agent fits BootROM's SRAM
download area before DRAM initialization. Provide the SPL alternative
for tighter payload budgets, avoiding the space required by BL31 and
U-Boot proper. An external DDR loader is still required.

DA authentication belongs to the BootROM download flow, so provisioning
agents must not require the keys used to sign normal storage images.
Sparse flashing needs a 16 MiB heap to accommodate the writer's 8 MiB
buffer alongside fastboot state.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  4 ++
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi           | 61 +++++++++++++++++++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  4 ++
 arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       | 16 +++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  2 +-
 arch/arm/mach-mediatek/Kconfig                     | 28 +++++++++
 arch/arm/mach-mediatek/Makefile                    |  3 +
 arch/arm/mach-mediatek/download_agent.c            | 69 ++++++++++++++++++++++
 board/mediatek/MAINTAINERS                         | 12 ++--
 common/spl/Kconfig                                 |  2 +-
 configs/mt8370-genio-da-spl-fastboot.config        | 21 +++++++
 configs/mt8370-genio-da.config                     | 12 ++++
 configs/mt8370_genio_510_evk_da_spl_defconfig      |  2 +
 configs/mt8390_genio_700_evk_da_spl_defconfig      |  2 +
 14 files changed, 229 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 10b9a142f37..2ee7fb1f40c 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -14,3 +14,7 @@
 #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
 #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
 #endif
+
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#include "mt8370-genio-da-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
new file mode 100644
index 00000000000..9d0d057cfc9
--- /dev/null
+++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+/*
+ * Download agents (DAs) run from RAM to provision or recover eMMC.
+ * Both variants expose USB0 as a peripheral and leave unused USB
+ * controllers disabled, independently of the normal boot USB setup.
+ */
+
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-da-binman-u-boot.dtsi"
+
+&ssusb0 {
+	dr_mode = "peripheral";
+};
+
+&ssusb1 {
+	status = "disabled";
+};
+
+&ssusb2 {
+	status = "disabled";
+};
+
+/* Only the SPL fastboot variant needs these USB dependencies in SPL. */
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
+&pericfg_ao {
+	bootph-pre-ram;
+};
+
+&ssusb0 {
+	bootph-pre-ram;
+};
+
+&u3phy0 {
+	bootph-pre-ram;
+};
+
+&u2port0 {
+	bootph-pre-ram;
+};
+
+&usb_default_pins {
+	bootph-pre-ram;
+
+	pins-iddig {
+		bootph-pre-ram;
+	};
+
+	pins-valid {
+		bootph-pre-ram;
+	};
+
+	pins-vbus {
+		bootph-pre-ram;
+	};
+};
+#endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 6230b016ca0..4fedbda9b3f 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -14,3 +14,7 @@
 #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
 #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
 #endif
+
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#include "mt8370-genio-da-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
new file mode 100644
index 00000000000..fb6fadb492f
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+&binman {
+	da: da {
+		filename = "da.bin";
+		pad-byte = <0>;
+
+/* DA authentication is handled by the BootROM download tooling. */
+#define MTK_GENIO_SPL_NO_FIT_KEYS
+#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
+	};
+};
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
index 2dd13d261a0..6c99d0926c4 100644
--- a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
@@ -12,7 +12,7 @@ ddr-loader {
 	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
 };
 
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#if defined(CONFIG_SPL_FIT_SIGNATURE) && !defined(MTK_GENIO_SPL_NO_FIT_KEYS)
 u-boot-spl {
 	type = "section";
 	size = <CONFIG_SPL_MAX_SIZE>;
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index e572cfe8571..eece6456e43 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -249,6 +249,34 @@ config MTK_GENIO_BL31_LOAD_ADDR
 
 endif
 
+config MTK_BROM_DOWNLOAD_AGENT
+	bool
+	depends on TARGET_MT8188 && SPL
+	select BINMAN
+	select MTK_GENIO_IMAGE_CONTRACT
+
+choice
+	prompt "MediaTek BootROM download agent"
+	optional
+	depends on TARGET_MT8188 && SPL && SUPPORT_EMMC_BOOT
+	depends on !MTK_GENIO_BOOT_IMAGES
+	help
+	  Select where to run fastboot after the BootROM downloads the agent
+	  into RAM. Leave this disabled for normal storage boot.
+	  Download agents cannot also build the normal storage-boot images.
+
+config MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
+	bool "Run download-agent fastboot from SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC
+	select MTK_BROM_DOWNLOAD_AGENT
+	select SPL_BOARD_INIT
+	help
+	  Build an SPL which enters USB fastboot after the MediaTek BootROM
+	  downloads it into RAM. The download agent also configures the eMMC
+	  boot partition so that a newly flashed board can boot normally.
+
+endchoice
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 35f748a70d6..0f0bd8fda01 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -4,6 +4,9 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
+ifdef CONFIG_XPL_BUILD
+obj-$(CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT)	+= download_agent.o
+endif
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
 obj-$(CONFIG_TARGET_MT7623) += mt7623/
diff --git a/arch/arm/mach-mediatek/download_agent.c b/arch/arm/mach-mediatek/download_agent.c
new file mode 100644
index 00000000000..e73b6a6b161
--- /dev/null
+++ b/arch/arm/mach-mediatek/download_agent.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#include <dm/uclass.h>
+#include <fastboot.h>
+#include <mmc.h>
+#include <stdio.h>
+#include <linux/errno.h>
+
+static int mtk_mmc_boot_prepare(void)
+{
+	struct udevice *dev;
+	struct mmc *mmc;
+	int ret;
+
+	/* No storage loader has run yet, so probe the device here. */
+	ret = uclass_get_device_by_seq(UCLASS_MMC,
+				       CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV), &dev);
+	if (ret) {
+		printf("Cannot load MMC device: %d\n", ret);
+		return ret;
+	}
+
+	mmc = mmc_get_mmc_dev(dev);
+	if (!mmc)
+		return -ENODEV;
+
+	ret = mmc_init(mmc);
+	if (ret) {
+		printf("MMC init failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Enable BOOT1 and boot acknowledgment for normal BootROM startup. */
+	ret = mmc_set_part_conf(mmc, 1, 1, 0);
+	if (ret)
+		printf("Cannot configure the eMMC boot partition: %d\n", ret);
+
+	/* Reset to x1 SDR, backward-compatible timing for each boot. */
+	ret = mmc_set_boot_bus_width(mmc, 0, 0, 0);
+	if (ret)
+		printf("Cannot configure the eMMC boot bus: %d\n", ret);
+
+	/* This permanently enables the reset pin; it cannot be undone. */
+	if (!mmc->ext_csd[EXT_CSD_RST_N_FUNCTION]) {
+		ret = mmc_set_rst_n_function(mmc, 1);
+		if (ret)
+			printf("Cannot enable the eMMC reset function: %d\n", ret);
+	}
+
+	return 0;
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	ret = mtk_mmc_boot_prepare();
+	if (ret)
+		printf("MMC boot preparation failed: %d\n", ret);
+
+	puts("Waiting for fastboot commands...\n");
+	ret = fastboot_usb_run(0, NULL, 0);
+	if (ret)
+		printf("Fastboot failed: %d\n", ret);
+}
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 20befdba0e2..696b87c1524 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -18,14 +18,12 @@ MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
-F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
-F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
-F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
-F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
-F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
+F:	arch/arm/dts/mt8370*
+F:	arch/arm/dts/mt8390*
+F:	arch/arm/dts/mtk-genio*
 F:	configs/mt8188.config
-F:	configs/mt8370_genio_510_evk_defconfig
-F:	configs/mt8390_genio_700_evk_defconfig
+F:	configs/mt8370*
+F:	configs/mt8390*
 F:	doc/board/mediatek/mt8188-genio-evk.rst
 
 MT8195/MT8395
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4930ecb0861..fb8bbbd2f5c 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -194,7 +194,7 @@ config SPL_SHOW_ERRORS
 config SPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in SPL"
 	depends on SPL_FRAMEWORK && BINMAN
-	default n if MTK_GENIO_BOOT_IMAGES
+	default n if MTK_GENIO_IMAGE_CONTRACT
 	default y
 	help
 	  This enables use of symbols in SPL which refer to other entries in
diff --git a/configs/mt8370-genio-da-spl-fastboot.config b/configs/mt8370-genio-da-spl-fastboot.config
new file mode 100644
index 00000000000..6ba12f7d282
--- /dev/null
+++ b/configs/mt8370-genio-da-spl-fastboot.config
@@ -0,0 +1,21 @@
+#include <configs/mt8370-genio-da.config>
+
+CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT=y
+# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
+# dlmalloc also caps individual SPL allocations at SYS_MALLOC_LEN.
+CONFIG_SYS_MALLOC_LEN=0x1000000
+# Resume from the user-area FIT after fastboot continue.
+CONFIG_SUPPORT_EMMC_BOOT_OVERRIDE_PART_CONFIG=y
+CONFIG_SYS_MMCSD_RAW_MODE_EMMC_BOOT_PARTITION=0
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_USB_MTU3=y
+CONFIG_SPL_FASTBOOT=y
+CONFIG_SPL_FASTBOOT_REBOOT=y
+CONFIG_SPL_FASTBOOT_FLASH_MMC=y
+CONFIG_SPL_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_SPL_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_SPL_FASTBOOT_MMC_USER_SUPPORT=y
diff --git a/configs/mt8370-genio-da.config b/configs/mt8370-genio-da.config
new file mode 100644
index 00000000000..46cb42b37ba
--- /dev/null
+++ b/configs/mt8370-genio-da.config
@@ -0,0 +1,12 @@
+# USB identity and transfer buffer shared by both download-agent modes.
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_MTU3=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0e8d
+CONFIG_USB_GADGET_PRODUCT_NUM=0x201c
+CONFIG_FASTBOOT_BUF_ADDR=0x65000000
+CONFIG_FASTBOOT_BUF_SIZE=0x15000000
diff --git a/configs/mt8370_genio_510_evk_da_spl_defconfig b/configs/mt8370_genio_510_evk_da_spl_defconfig
new file mode 100644
index 00000000000..bb537616b53
--- /dev/null
+++ b/configs/mt8370_genio_510_evk_da_spl_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8370_genio_510_evk_defconfig>
+#include <configs/mt8370-genio-da-spl-fastboot.config>
diff --git a/configs/mt8390_genio_700_evk_da_spl_defconfig b/configs/mt8390_genio_700_evk_da_spl_defconfig
new file mode 100644
index 00000000000..7f1ba02c6e7
--- /dev/null
+++ b/configs/mt8390_genio_700_evk_da_spl_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8390_genio_700_evk_defconfig>
+#include <configs/mt8370-genio-da-spl-fastboot.config>

-- 
2.56.0

