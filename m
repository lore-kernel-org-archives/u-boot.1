Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FF7CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 727DB80F44;
	Fri,  2 Oct 2026 13:22:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Njm7Kw7kfp_K; Fri,  2 Oct 2026 13:22:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CC3A180FB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947375;
	b=WhXGHO4oG6vnD/vPOSAQ48q29PRV/Et067YdWj8gSuhseuS+tQVEYm1RdBwKJQBJXt56
	 /hvtF7Chu6yiOBk5/euLLQWDF1SpXpGXxgtiKgMKRP+q0K4Q+Iq07g+/MdvvEzaHmp0AR
	 E+4J+901oatIYoe5lRbiK9u59oI9mqGmo4OflvtCfVoR5ehLTyzgb13MMGKbCG1Rji4rx
	 EGi3ZDCu/92Sx5DVtETQb574FtGLoy1xpxgocPSatullj2csEB3DcVnnkziyOiH01qvD5
	 QapKsHqkM11GPTUzK/uf8h9ft7MMEBIMJZ4xJYiFLdBQ8aSIJiST16ngyeejY/oe6Dg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
	b=om8Kb7wsGfCC8fljTogRTtfo3QztK2gW/eJnWW2pHb/VNF3EQg6hEhswE4/aKvjyUWtw
	 vioKHeU2KoIj2GyZHYgTsVd84zzNqo52iyBz4O/n0N+he1yTcu34hDyZJ6nLye/plylqK
	 rTd+vIVq5oriSIjARUZabipoTgUFmIV0vkTcdYiUHBhKZ58MujX/bFN39Qh52W5OcIKu7
	 yHimtA14zV7ETxSYAQ284+yMPCpGdrxIS0QneoqejI6iu5AQz0gO3g8MqZJFT87ARXyiO
	 q8W40rkGINhcldOkZqnrrFiKphWBfETiEzTqix3/YwC703vtih6Oh22L2RMNcQriBMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790947374;
	bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Csor3yIg4/DUE79tHLhGsvZkOfClv67hK+idgEMQk4ZOwPYVnw9g5c2Lc5gkssWaA
	 AQfTPz73DKD721oE9e3ggwFVvR8VutendsQVML4Bg1wTqk9s/PDJ4llfyTz/sBCcYi
	 C/5Ci9knrMYrZrFWYm8Ik6MNxBOO2ujrzSWNi/m5CeaYDFG85IbUeF1PArjjz9ENsX
	 NQoad0/bs3Ei747dej83DOHacjynvbb3y4HI9w2UN65c2nzibRjuuiQ+y+VeatRJo2
	 8mIxj2hIrvu8bu72pO4e9LK44ekGViK9RBsvpU3PI1B3X9mUg8L3VFveeevwb/910Z
	 guJR/8N7iGkkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC3A180FB2;
	Fri,  2 Oct 2026 13:22:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FFC8435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 361B360894
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T_sW4npo6Udj for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:22:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1212D60851
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947372;
 b=f4cpzf1N8eFC40psPegfH4pSODATV96xF6phpedh3PPpvTN8/ZvKVJ1l96uyjTmxa/gK
 PXex2xyUwUlagHiwdWHyZX+kWitzEP0idFqfd9jG+mPxUrpV2I3vpX2GUTvAcNAxQPJNG
 qj2NbKKNnja27tbwHz9QeZzGsP0SNGNysvw49Lbo9v+VMsirdT5CmTbqKDpaGF3E/Mw6N
 cb/uopeMg2T9S2FHSx4wERF7uWUhuWcA+At28fVg8s1mZ3o35fFw9iWmxacHfzHhb5aUj
 yFNcOYsc7iR7VBXNHvD4dc2JbHzIsC6T69e6+0033zt1c+ocaaWjh3AGs0sSFMBX7jQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947372;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=i9bRp9bYtZhy0aMz5cqY2Mz03u6raZuFxu1Hz1QDtZNRCqrYa8blBRbdD4pXKDmkiNVC
 sU3CKkZYOBVGvFfmQrEL6h/D+dX5p6hM/TdIUy8YnUScmJ7UqldphqpLoLHRdwEzXDg8o
 ziipNVdpxq7xoEydE8eIgiPKxWFUoyiTZezRyie0sfG28ZR4HpQTVl+1IQqTLPdzcA2sT
 w+f1FCc7MT9gKZmAmYjRI3xEC7CTZth7uqv/Z3DAv2feKFoQP8FLmkL3MaoZ2sz+HNj+l
 beOjgm17nSr2buEqGlCOgA7stViUmPGp0XLin9ZBzclAcjp08OAXzcHvnP7jEfx1PVg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=lKL1OzDC; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lKL1OzDC
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1212D60851
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:51 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffde3cec6so228775e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790947369; x=1791552169;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=lKL1OzDCGbBKcJU76LtNgxZAvzkesrwFSJ1Zq43+CDzH95yQs71wTnKlQ77m50+W/u
 NcI3MIMDBYJMmIb0vOZA/ukuld5EnSsxop+V8FO8jxuL5Ncr8NIeo0M62ycoGikN4nSf
 YtObdWXBqDN8ebh1rvek/BNskQBYBM8O97kc3qvo4vFj6XD9tGi6p3gILkGFrG6E+jQ9
 GNraXw+ouP4Hd1kueAJV2XYQKjQ2PFs6N79fLo7EQiosTDvhClHr/Klfj1iPt5rR6oPu
 H8ioozMFxNlQ8WkYaHLTJ889wUU63pDf054mPc3fegxoiTNR8GxcjvNSaIWbuB3T1lh7
 vJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790947369; x=1791552169;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=jUG4EIvStx1fddiE5v1OKubtps3GD8cO2pC2z6yu7CqCkKeJpfH7lOQoRE10f+2A4t
 l5HWLmdSlq/WzhqQc7+PseDBwDnt36E/inLpDP14SXcyM/5cU2Ks77+YLIRKs5Bppo0W
 XNCXygbxmascjoeaUiuVoPZpMyYp1JssrLsxipJnFdDfSRS7b7peuRiz2p7U0pu+w6LR
 tOXVnwqlYRTm0vgH3qEoI+azWKpqVUC+SDMkRa2u0aexIKirV1rHPX8KwqemShmaGWEu
 B/tY+sxNRbQIZsM0XwguGQ3nybWHUWBExrxcgx0h6WK361GNXBoamvGpCvXrrib27gK9
 rPRw==
X-Gm-Message-State: AFuF++mO9AvOeVxF3BbcCy+DRDtXDaEEdDMRxw+d8dESSgy6VkFlukCX
 aJGFh2jVNlj7349XlouHFpa72tz9xcWrGVEufH2osqaa166UHkWQM2l2hqzxPcPB4V8=
X-Gm-Gg: AYBFou0jdwjrcyaHV+tAF8WVS+anonxXZRDzFC+nQxyIcVcraiIFkj+38Dou0hWyQVH
 V4kn9rAVJP8QRGHEHGpxCEk6eBPAyL5GfdzfmCQVZIedstR3v+MiS9Sgwl9El682ey7L5hCR0ja
 s6Xm5mQcaV0NKtSd4T1kUVLQAarVAEkn3t2zu2ykE/XmJ3caXCZN9pxe3wRYAOYaB6hq3UVo+qd
 fkBJerGMfPbCrKit6WbDJ/i7KMr6Yg71y+ZyHduQq2icRc5nbib5baVkq15cpIOfnE4L1iHAzdq
 W2sYNEJfc1WCOQddtGehgcChUKVlOQY4O9DEJXYulQuC9ckY3abflGnRtBmniayIHF5gJohdOA4
 jJNdbeGrIsdOwI4ABjT35Qcx8mrr+V875cW+v17k94/6CaSnoaRd49nC0GabQK98H6UpQ1coM7N
 v2lBOm1Qn3AZEfukHYbhBrpJvybIASPZ+pTMSea6nNms+ZrTcI8FSDIJihtX1c9bx69e2rs8r/1
 Zl6Hp2tQ0+QQr1lIVuDTNzZ0JzOScdEOJOHaxeE9E6W0J8x9o10Bs5jw4qsIgw/HX/FtQqjQ9kR
 OUmJenl9n63+57txE86w7jG4FVXXp31kQCk6VcFaOmOdBggjsmUs5wtHiWQfQH+CrQ==
X-Received: by 2002:a05:600c:3510:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-4a027559c6fmr54306155e9.15.1790947369522; 
 Fri, 02 Oct 2026 06:22:49 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm6264125f8f.30.2026.10.02.06.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:22:49 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 15:25:35 +0200
Subject: [PATCH v8 01/12] memory: sort the Makefile alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-add-genio-510-and-genio-700-hdmi-v8-1-2a6de7cf2a88@baylibre.com>
References: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
In-Reply-To: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790947536; l=912;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=kojOq5I4JG/TQ2T0VIm/QKtZdOFjTH1Up0WKFX2Kzq8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF/LKrr0fmPdkVg8VQ/0eWbR+gBkQR3M+m1+wsLKnoO7rMUX5F8iKPX51Mfm1sPmZ+ywSNwZQdg
 l5/S5QJZtXAI=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

The obj- list is sorted by config symbol except for ATMEL_EBI, which
sits between STM32_OMM and TI_AEMIF. Move it to its place so that new
entries have an unambiguous spot to go to.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/memory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 77294fac69d..d5f5b073672 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -1,8 +1,8 @@
 
+obj-$(CONFIG_ATMEL_EBI) += atmel_ebi.o
 obj-$(CONFIG_MEMORY) += memory-uclass.o
 obj-$(CONFIG_SANDBOX_MEMORY) += memory-sandbox.o
 obj-$(CONFIG_STM32_FMC2_EBI) += stm32-fmc2-ebi.o
 obj-$(CONFIG_STM32_OMM) += stm32_omm.o
-obj-$(CONFIG_ATMEL_EBI) += atmel_ebi.o
 obj-$(CONFIG_TI_AEMIF) += ti-aemif.o ti-aemif-cs.o
 obj-$(CONFIG_TI_GPMC) += ti-gpmc.o

-- 
2.55.0

