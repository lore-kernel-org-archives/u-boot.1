Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE0CC624D3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5255440758;
	Tue,  1 Sep 2026 14:39:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hC_rq_PmXwYl; Tue,  1 Sep 2026 14:39:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273543;
	bh=zaHoEUwRGmt16iqJfruLbjPP94O5Km04ZeciuPhYI+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fZX5oqIMFGbrnB1oqqKwVU5TTL6whmj5w3tNpp9Lt42Vots00YKM/wjh8JCJo3exn
	 vXz57fvK67Xyw/re57Wr3gBaFc7xqfKe51/4ef7JZIcDPAd6Tuklp3taYs9lq40hSP
	 F7WGhmavUk4FP6eJBeZoHgcsbBzB273PSlaKa0fymd8mgN2p7P5ZAqJY40sgX4qu88
	 qbG7/p7t5QkAb7piC7+N8afnk8OB+BhsUwI2Yhng87XFd77k+yTJK1yPmwkiwLi52R
	 tIycqyZ6Jp1kMDWm6uPd7mOc6daEpc+SG/JFeKFLXj2Fh7d+db7ZtETdR3B6pXr/6E
	 y5u1m1oeU/qGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8869A40755;
	Tue,  1 Sep 2026 14:39:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 49CC1363
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C4454070B
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-SjjUtxfDGl for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:38:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iq4BcsA7
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3458C4071B
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:56 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so48417095e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273535; x=1788878335;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zaHoEUwRGmt16iqJfruLbjPP94O5Km04ZeciuPhYI+E=;
 b=iq4BcsA750g8Wa6qIyaOmzZ1Ruf4Ih2Y/CQGmzdBtKULEVSXV+yytMMuQm2t1gSXE6
 x/LTxpdyffIOC1JBrPUsgF7XgmmDnwZ0zd1QfqJlXP1fKQHJJb7EpTZHFTmHjpKGCJGd
 SXNqu5QgfqG7ntcpBlXGM+vLUJNhAUUxyzTunuwbaFNHU2soMkPsQpEXU6oypTJq7ofi
 Mjv3nkiHsCdQDqbEr/QE0Za8oe+3mQbaf1nSD+ZKg7e5t2vj9gIy7iMYGZhiBrkmd7NC
 4NW7nLhtv4Xcb2HuT9FvFXKtR1HZ9r8TEXCowdz2VCRnc2o4lV+wMFHTvjC7rpcYslca
 mvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273535; x=1788878335;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zaHoEUwRGmt16iqJfruLbjPP94O5Km04ZeciuPhYI+E=;
 b=hX09RQYpCYzDENHlg1a5ygLD0IGkq3UrM1lmttDlZig5Y1rPz/3QT+1ruK+tdf+qlr
 mylzFXItypKleeRKhjb0zkxRXiQ0mhgd53BF6VQa5tNtiaO9o5jWbJobD+2ABznpT99A
 dzxTsxm/XnZQpnjqT2bocvWpsB4BocXL03/sm0xe3u7ap8pTcR2iPSFZB99HtcxkP/DK
 07ze+RMhmKTdtMx+qwVx149zB2ldLybGdKIeS271AM1N66VxQGg2Y57IkYF7fIAuGiTt
 UcJBsAvlWYITBIwleb50olSMRl6LgB8gdQ8QNGFpcfv/7FcXOJQ2Q0ZiOwu/vdBRYBDn
 D1Mw==
X-Gm-Message-State: AFuF++llXohZbGYncrmgY3YseTGfU+jjgN7+7g2SnjDmi5PTDH4ldOdi
 Gg9lVB5ngNW0SzQwW2zaaWh1ksKhnouzl84zsP8rQW85SiB5S5cob80xN2MR+hgZoss=
X-Gm-Gg: AR+sD139RzquwEBDq7v0GhHsNkLl2EZoYTd6lBTKO10YGsiIP90qIcUfAnN/s5+R0y7
 nNzx/hsmrSXhRUfGoU/AK91CCivkc3KRxdcg7sCC+6ySLBw08X7NQ0QeJzgnqthfxbY/wxKOepx
 b1QoYtEOCsJjNFXTQfGP6Wlr43GADv1ww15CUTLCYk/OqBnvWhTtzwks883TXt9UgiaDgbHVKMP
 KBwqGir9Hbb/Yea+Ef3TNhve0JvpyXML+kOhTMl7EJJ+M/aJl4bjCgkH/Suy2fFt0y1hJSe/uo+
 oCNKXrUNw22x9NyTyoIxsvozdZwGOgYEaaR0uFsU6tFN56qsB5cXpfz+aVhey0pac+iZm88UCrP
 RlHX3WA0+qsUVQrzt8IQFLVwKCeGaprUZQQofrChrepFZnFlDaDWjVKW9jCLcaSGTpfn60gulPa
 Nd0nOan2beDh0S8V0wnApptpwgi6aeQrZwSUwHUwyJLcF0U9TsmOVHSwuEKnouELAH3wPojE2DY
 ql7zfkwducjEpWKis2ab1Wq4pnHxvsNWpaq5q3tQEK3RYAKblQOsZj3fiUrPKlzRXPyPq3PZC4y
 6EJ4QuuAXslIwRnI9/rWswRfWtiHIC9ABlbkv1f+wveYH8m/hUeUc0Y=
X-Received: by 2002:a05:600c:a48:b0:499:9eb8:a1d7 with SMTP id
 5b1f17b1804b1-49b91c3b7b6mr453498635e9.9.1788273534865; 
 Tue, 01 Sep 2026 07:38:54 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:54 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:55 +0200
Subject: [PATCH v3 09/14] asm-generic: unaligned: add get_unaligned_le24()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-9-38194a531b9f@baylibre.com>
References: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
In-Reply-To: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
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

