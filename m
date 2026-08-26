Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6530DC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D79180C73;
	Wed, 26 Aug 2026 13:09:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pJbPdb8ze3YO; Wed, 26 Aug 2026 13:09:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749790;
	bh=DIh+NRyy6mfbF5e+KGfDVaqlKhXH4a6jii0WVd/Yj+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0vjnSnt1E9vz+L7DJl3MJ678TLj6pxW1tnUUvjYpqhlSoFojcJ6nHUk4F7HbRmcN/
	 q1kvN21akDWWcXJT5ypm1RPQakqSl74hWHHCtHnbOix0XPV2hw/8l3cfLALFJ/+1YJ
	 e5r+ebdl56Fh9enXJoPVx9XP4p2b0/jSbGlQk4KyibBjEOX3O+Jhxhj4DU3h0AQozC
	 A6N6HnlekzkTaI8kkDIiAPqZAySp07co68zE8O0VmopprbbJ2ctdWi6Tq1SG3j3ii5
	 DxotD2yYMeiH8VMmUo6NVG77BVUgCOZRo4DJW70SWWFc8kvEYEbuWC6fZKy0hGUMgK
	 51HEYuObiJXRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63E2D80C7A;
	Wed, 26 Aug 2026 13:09:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EAD33AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8523D80C6F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xbOG2TcgQVQ4 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Z/KbuaFH
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E25D80B6B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:44 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so720128f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749782; x=1788354582;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DIh+NRyy6mfbF5e+KGfDVaqlKhXH4a6jii0WVd/Yj+4=;
 b=Z/KbuaFHwoTpiES+czscY4n2j59I791fs5z26QsCiHmxQiGdTDCXoW+slvZgZc1kVE
 NAIKlMBBIUyDT0enIj/ralyhPDLHHH1ce0LXcMmB0bbxiafc6DEs8aIpEJKUV5BlMmHj
 HaATdMgrK6tQpSFmxe//I3/dA8qEGmfYl0YKszcHuPJbL0iCbLTdZqLBDTJX3LWOAsl5
 8Zo89esJdBmN0GXI3ZmG4SHnZQ2/wP38uZJgTayEmiWFPjLog2vJVcirTi6l79J/ouAa
 JAG+rGYBql5UE3AgztyP6xhhh3FHWiQU+iN0Hx/C4phLm+TC1XGJXJapnxmTMzuxZx+o
 rxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749782; x=1788354582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DIh+NRyy6mfbF5e+KGfDVaqlKhXH4a6jii0WVd/Yj+4=;
 b=HXnWpQAmzNsbIXyn6YRox0aeRRrTvFsizEqJx0qGyi6oDuBjlExN0uhcIvcL/D4qj1
 aH6SJUvgEGVdWaCthfdPeMiPcbHq+E0ySLMt0u7k6LxYgMjS1m+uFbca2M/reLC1xhBN
 ICNfmNQ+7w+mRXx0OWiYTWTWGourQrW9ul+EouZSrQD+Op4lv20gFGKQ/HtT2xk2G+rc
 t1AiobdciN3uWBXG4xs8EZ94HqRThk8r6LUjupiNSFdvn5r/ube18Tjmtm57qjea5Hmp
 5J1qbvaFsQhdmH1e3ZO9J4oFWqMhnknccJJ9aN4U0VNyl+Yc+zgmZmdWzP0BUPg5OUr4
 oIVw==
X-Gm-Message-State: AFuF++kOHUyuumB2hgukqw6Q8YWJhrtkgc4cMbK0xAf3dXyWLb+dFXcS
 xdJEkjIhEiJQqQonWulhnZCpvmJ0Dg/WsRNYHrZTGCRoVsC4AXr8ubO5Flw24e9dU2s=
X-Gm-Gg: AR+sD128M+Qf60QaGbNGzFFe+MO1CBzSIsHE2xtU2RgUnPcmtvONpeH1zFsjKSwL11k
 ij4BuzuxMHurPfnvaHkVuGPKVDdYXLMvMotTROB5hodJSkBK8CXiLF8n0v686nZTKJaUILbtigS
 G7xRT/0G80QTLVZ3uOL1n8Ft29D5/SdK8bk+sERToG/6ErMUyl0IeybPqi3imb1/XF2GdswnAQm
 cuu4RBgkVU6R5/+5J+l1rO2Sxue4H9Pxl0DZzD+jLIbYf0/g4E1DBZImEOKeUjRynuWgJgyMD8C
 rSGGfYWOZ1JTxKxzhk+xC7w3FnDM+SOm8z2Ngy/EYGiCBpIeeRZZtOyvaE/c9+bZ8w/ly1wufET
 sMVUmmREVHFBKZcrsXhAh8DV9d0aZ16gPcO2lhb304Li0o08lKKCOhObA3SOeCi0ZS1dhlNQ+xG
 5GfgXp7HXlJmwr47C8Q37ZV+1CDTSWrkY6wddqlVLpitM4Soc0czuOJ04WKX1fYtJaLgOJbqF2g
 v6hcxhKGyF9w92++dTnyDzP/NIvcMcx3CfqMYFVIHbwwcD0f2lSSpApmmQMlW8+L/KsfwqNMmQo
 3XxPPb4HprpSJfrqhCB8TpWX29Eksu+ZUFqdS3G9yAcB7HP2PDQgAczg
X-Received: by 2002:a05:6000:4685:b0:47f:8ac0:ccb4 with SMTP id
 ffacd0b85a97d-482e26d9adbmr5887848f8f.10.1787749782170; 
 Wed, 26 Aug 2026 06:09:42 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:41 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:36 +0200
Subject: [PATCH v2 09/14] asm-generic: unaligned: add get_unaligned_le24()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-9-68ebb1bf17df@baylibre.com>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
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
2.54.0

