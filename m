Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EE8C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0940E81099;
	Wed,  2 Sep 2026 14:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gZp2nGzaFyhN; Wed,  2 Sep 2026 14:17:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358612;
	bh=zaHoEUwRGmt16iqJfruLbjPP94O5Km04ZeciuPhYI+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sK+zo2vOnjtO7Myv7zJ+uCFz9LyGFVViqLiLkiRjwqnPZzQhTO53V5rAxEaIYmFSF
	 ABhrBjiDynZ4h8lm8pH0KMnVr46xZ7JKNEheBIFhSx3N046F+7cbGxrtwlyE7LJymL
	 kG2+IYMec9W6H3o/jm8SSnl9pt5t4TLxfZGY7bb3oJfw84rHhxrMpJB6SFPgwcA8OF
	 OozTh7r/nDsEVElJhZ64d+RntzmTkd4gc8ISutIB6KpE528JxIjSwx+oixUOz1zsiN
	 KubQcWxQhepGEducH2vL8/w3GaVxxsgj/wDnd2pg4YMWhHWDLYOt5PqvELwiyTgyb+
	 2FlpEMOcCHdDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A423E80F73;
	Wed,  2 Sep 2026 14:16:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F242363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B37081010
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s8Vm_xQP9Syn for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nOGNBYhZ
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7CB2780F1F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:34 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so1099870f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358592; x=1788963392;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zaHoEUwRGmt16iqJfruLbjPP94O5Km04ZeciuPhYI+E=;
 b=nOGNBYhZlSeinQeGzh6C/ncnBAjcfD2t3wz6RnkGjQSaIHXWSRPeMY1WJJDq7GoeZq
 /qw0w9xu0lneaIxcNyQ2NsnfkCttvJRF0BLomueHY61vKSXKcJTt1UPzlVtCuwG6lHFj
 XKF1XMEu+BmwI5eUn6r1wUPDISu2Km5iyfp+ISoz2wyzuQT93hR8RzhmcU7YJqV75qfN
 QvI2IE2zLNIdP9S3qeoltRpu639An9cuGJm1+poGYSlQNuZUPU3J5WzGin72/XD7I4v5
 xyjscbryqJZTyExbgew8XAd0T6bhbP8zLQpH5Ded9M+/8NRvZM7FRaCNAMtq1PAHWLne
 YHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358592; x=1788963392;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zaHoEUwRGmt16iqJfruLbjPP94O5Km04ZeciuPhYI+E=;
 b=cGGo3DO4Rg99g8gu6/afJy9FJ6FWV5T71khY3eFYWwWtuijZJltkOVGTT/jNkyuYK/
 tsYtWkwTOr/WHTqZpmH52ZoDhUvqeEBOTJCssvXG021qavFf0kvETL+H+IcNu/mnf41q
 jVM7ZBeM18TASfmVJHZ6UIHSzo60JxsBLQK8T/S/DEfwetfWdoBzUUV2Y2cY/hMFNaff
 nTChkja7wWa/ZQ3KuWcqKWlY3vgSDSPzNIyQKjgGOl0tV3OSzwwwUxCRozLKSHr1sN2a
 uUa9Oh8XgK/rJyRcWl1Y9cVM190YpbCaP7yFOOGmlW0cmm2kyn6XSj+ZYGQxGfseHCrB
 L9tw==
X-Gm-Message-State: AFuF++mINGHmsa/CZugqV/9hQhwTrPP8g6gUY9AQBwDUFr6bVMBORNv/
 cNjPefchPOKqP8Wk9z6KwGOx8kX3+Stxsla/7JDCM+vxeCToxG6pGyxE5K4NxJVmuyU=
X-Gm-Gg: AYBFou3sU2MmL071zACY4YyeINTr5RSOGvxcT0kFI5PtPXtGKVpNiCVgZyacc3z9X6g
 dLW/pxpRr7lB9TUVHwSFWZy+E81/mEFcs1ueg9jT6FxfHpWNbDSqe61IZcqbOX3WZWnmf3IPGg3
 j3wCFDmP03ean96rWs1h7aIOFSBb1uSe1xuPOu3Ic5QPTqCVGsQx9pmT8LvCqjs2HEcqe2MbRKy
 eIjl2DSJ/FhrflyixXXsI4RMwQPVIw6Sab5Z/Jy/8oP+gXYNMZ8/pvSgN+6XafpkaZXtGYje6Y/
 8WRXT55CKr6+MYCL/iEFI56jp/2DLJPtYIHza4wvBKZz/r9LFkdKq1jdqJlmsmTDqxuFgHZvCjy
 hEM0tDzlhYuLlE5aC7taGroX1VPyrrPDTlO3wxooJOnU/Gc0d8ITOwGMk6yH/DQYvzYR5PbvcMQ
 v0cODbh299tEFvMLkDFSubzEu9JHBTGrRUJYFSl8aELvqHdeaDsAO48alRwvKPiqwwTAibMIEFm
 mvm1Igy6E9j0DzjOVbyFq9fOSWZD6IKw0t267CSzAGG/1zBT+3PwN+Y4TT0NAyhlx3i2S0I5iJb
 ktg1CkVmIv8pcpMMDyUQ1r6anmq7qpSaOFtcs7kkARjoQwL+I4/nLCg=
X-Received: by 2002:a05:6000:1847:b0:484:3931:c698 with SMTP id
 ffacd0b85a97d-48488dee004mr9041047f8f.5.1788358592088; 
 Wed, 02 Sep 2026 07:16:32 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:31 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:15:59 +0200
Subject: [PATCH v4 09/14] asm-generic: unaligned: add get_unaligned_le24()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-9-7c3b4f068a56@baylibre.com>
References: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
In-Reply-To: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
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
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.15.2
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

Add get_unaligned_le24(), mirroring the helper of the same name in
Linux, to read a 24-bit little-endian value from a possibly unaligned
buffer. The MediaTek HDMI driver uses it to pack InfoFrame bytes into
the 24-bit little-endian controller register fields.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 include/asm-generic/unaligned.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 9e5d93ec304..8a181ba6682 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -32,6 +32,13 @@ static inline u64 get_unaligned_le64(const void *p)
 	return le64_to_cpu(__get_unaligned_t(__le64, p));
 }
 
+static inline u32 get_unaligned_le24(const void *p)
+{
+	const u8 *_p = p;
+
+	return _p[0] | _p[1] << 8 | _p[2] << 16;
+}
+
 static inline void put_unaligned_le16(u16 val, void *p)
 {
 	__put_unaligned_t(__le16, cpu_to_le16(val), p);

-- 
2.55.0

