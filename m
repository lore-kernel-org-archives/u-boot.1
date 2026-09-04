Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A259C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 519D040C04;
	Fri,  4 Sep 2026 13:50:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0f9x5Xg9PuQA; Fri,  4 Sep 2026 13:50:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9440B40C05
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529834;
	b=dDip/8KKukdpO73U5ghiSEvkygBDFlLBtk7NvBJMAk8Z8twb3wABMd5bP6fCKBzQZn/A
	 oyJ2Lk1EMnBkDmvSlZ/FlopPzQE9tlq8yhZd4MeooO71XqlnoxXFt2xFBSN7xJ4x9+eJp
	 KPdaGb0/+gKvZ2MaskD/Vh/zJxgCnVDCubq+kMZMMOzna+QxbV3sNYkCbtUXkrUUfgGXx
	 4+oS8z9TRw285jum2AWd5aqHhj/cdqoql6E1WvvkUQk5N+G2ZekFykBKOtZXBRXozUjj9
	 WpZjYV+abUlSsyzF7AvFrwmexDyiHAViYvqJ+KdesS37yFbmGWYTrHG27i90CT00p9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529834;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
	b=rXA17Z0B8mvGZPjBc1pNCHEH+NBE8DERvsJQivD0ydbS8qAdKoGUPWdrr2IGFH0ha8p6
	 8Bxz8/hEGhfY6vt/BJrE5MYQBX/msXTi7FTT+h8c5MC1qk8gEFuG0tLdOl7fFtN4C7axj
	 zKIThAPr4ZChOns1gtsaFTbKe58pvY8aKkdBxR+WLDP/kbuUXYGvItC4qu05m6viDGbug
	 vx6CXiTFQP9VR4bNAeX5FBMd9FBJ0/NWIx3KyNpwOFZ1Z8EyIb7P+QpYmWGo0/OYHwvmJ
	 CrBYmSuuJ93Q8oaAt7dVJj8ba6g1hNHg+F6Tha7y/WyQlW7ox1aQM2fmufgwiuQt/eQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788529834;
	bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D+8K2A90+/xETSC7zF6RwK4uJtR6tA4RT+4qwKRN2qk8l9/z3jGgCL9gcgO1qntKs
	 ibBtGeigGRbNoDBsEn5iA93q/2JeH/Cj2o9yV0IHFuslmQmR7/bU3/9xXfXqlRv/+r
	 5LXAsWZTe1XaC0rCYh0XtBmqYiXqiyHvmrymgFPl/+IAjpvln9uGogevb7MECLR6/l
	 txCMcy92RDO2r8sdC8r8xft/Cu16eghr+y+LgYjRRydChrBUy87Pvp4Jw/0FjHFBtz
	 yE/zZ3UYHCTx3LFtZGZ+Sa44x8DUbZmrB3Lxwhwh1T8bTlPZOKMj2BaYbBMKZU4lx2
	 l5N50XxBEi/XA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9440B40C05;
	Fri,  4 Sep 2026 13:50:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C45F3DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22C9960BFF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aHCaQ_ftwmKA for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:50:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3C1FD60BD6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788529824;
 b=MsdaLfhMBq15+fFRCyYhuW+GJLeY6LpaGv0F8eHwJ0b2NbPQl3oz4wLtKmkKYL0as145
 ItdvYoqzsk4Ee3IS1C0A2+4UQ3mkx972d7sUiDxehHg+2UylYbxyJQqz/+tWR8RWxIVIP
 /hlrVUUfSZtaWzDi7vss4Gf+LTogF8uI5FaN07dUD/5/2NgyEtq7nHJNfXuseBtGUGKY2
 hMwjyh45UcTvGOOjLBGSfKW821NHbaBAONIpVhLsJpcefeIxjcC/z+5MNslDxrvtMTGkw
 S02dre/gDve80T9D/J7aUe24GsJx7NS8frGyLGYf4cAmvMlsM/hZRticf4152Y583Hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529824;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
 b=pp0L9WqF3pTDmF/+1leqy9W3FFYx/H0nPRt2K4bWqA2YX3B4eGrZ2zdYW+riqZWm7CI4
 N3lGfWbjiXj8UeiuYVGl1vjGz5+d581k6JFB2xnlosUt8LChsjeZM71jb4dgMmhV7I2vb
 C0agJ9X/QVC559lAi3oWh3GO94/bOU2G+LMMD33Y0tn2+lXZp/p4xat+4Qa6Lc+cQoYnC
 zR61BsDH5RaiOwUbvostG+ogkbMtz1VSChGTfBw6igM1yZFyQkMHUJmSWbIXdght0EG6H
 CrcJggLXg5+sA85PVoEi+BWdp+HSEZhoQ0iEZvBA6Tid+MLT8XC4mfrIsOUP2L9edww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MpAVaVHL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MpAVaVHL
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C1FD60BD6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:21 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso8951965e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788529820; x=1789134620;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
 b=MpAVaVHLdxdwjCz/Q6qM5KX6Y6wbAlmrCJuQbPWS7rm9cEQtXxiIwpdjL+PNx12kdo
 Z560n0/iXgWuj3UXAKdV7xQL+0dHqoBUeh9fAmxqRx/8otz3s05witSlFYtBSh1FIH+f
 Oz40fOw/hpihQ+DM8bd6Sf4e76w6lRZp0rUWgwrd/djumUuu3jK2tYqJP/IJxjd64Jwi
 nLU0/KKVFtahnR1Fs9J2GzlSOMDfPnY+JtCR2l+adXVJKpHvJ4oEhuHGdOytY0kKHuvt
 wrlsVOtXDCKFn8akiwhLFoSTwI0+M1JR8K4Ul0ScLoQmo2NtpWsPZf0i5NLLG9B37b/v
 SjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529820; x=1789134620;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IJoy8+q3aY5mofefSeFaAXJLhsFeRUtI4IV3U2VDJog=;
 b=AM+CVwMQp8pRuSViUSF+XUDmu6o2kdKVfXYNQtD/irJKueKmIHO7siuLQLgiYQRYi2
 s8Af3Hsr/4rR0Jus97lo1OHXFRNEduXScsxp/nEjahMNi9P/xqUQVdTjrDBhmjFvEoJ6
 GUTLhuLsKWqzWLzFHCebg6d44wsVJXPZhvCxbShGGeolKCVufKclvg+7s2YN10orPXUg
 zERER+8eJoSLwBRecwRwiJ3r90Liu3iQairxT22t0QyRZpvZyudn9XfTEAutWFIRPPIh
 PHAA72BFntnwKgdxh/Kqgg08JOTQV4Yfz419mkOr6ur0HrSh/dMf5ON+6cca9iUCdk7x
 65QA==
X-Gm-Message-State: AFuF++kRwAySSTC4W7jpC6tkKHQFuTwuGFe0vNvP+pgcmfQhenUMFLcy
 uOI1LFrxfKR33xFB+VdAa/8+ojnJ6MNwyg/vR4kJiuVG3CVSh/gqq44LWuRcER8b9W0=
X-Gm-Gg: AYBFou08a8MkbIvHukMeVlls6MPfQO7G91ZIsUgakc/gcJBQEvs3CT/NT/q0C0LU4Jn
 QToga4awJ2bzJKc94i3wMEIAOKKxAyAFFZ3nF7Yzczv95vzWyG2DE3Fy6BGHhgaiSoV7D8xUVU5
 ijTcLjbGvY58+9d0tQFwsmIrA9masHiE0XhU0SMSvyAr/AHZyT4QkMiwd3axyUeU1RoPKFBwjT3
 PytDvbnHTcdU150mcyea/JpBmJjrs0iqPzugpQzfFjQwDvUiczP8BTZ26HY4OjR+V4138zCW2q3
 ERQMrI0/CWKYUJUTwhQDbGgkberZfuYVnS0hPm6viKfBkyv5Jjw8wyf82ES3nMVL2gC3Rh6gxp4
 pOBFPxpCkrAMK77hUnBpGtXtXrbW52GeKbKMxAFt7UanKiIho7OxXRf+oz+IL2VypkMSv45eM9w
 Y0HgGQ+P1ys3TIDyoUz6RH2dFwYCG/KIMsEul0LrmZtDhxTsCg5hVd40wT0geB+kODZk0np5ePY
 8Y/Mnj1I8pQ7Kmq0xJr7yyjZgrzLGS0b5Jbbfxc4iTb/7YVAILE0My3PpVa3O2priFmt5PgWC/o
 tgTn5bMVkGOY8HVdiwsh1peKK4E2rvfQACYMg3LJ5OU=
X-Received: by 2002:a05:600c:1908:b0:49c:ed89:89a1 with SMTP id
 5b1f17b1804b1-49cee5e8c19mr162790925e9.9.1788529819960; 
 Fri, 04 Sep 2026 06:50:19 -0700 (PDT)
Received: from [192.168.1.60]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm6708786f8f.1.2026.09.04.06.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:50:18 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 04 Sep 2026 15:50:16 +0200
Subject: [PATCH v5 10/13] asm-generic: unaligned: add get_unaligned_le24()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-add-genio-510-and-genio-700-hdmi-v5-10-dd9dde2f972e@baylibre.com>
References: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
In-Reply-To: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
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
 Anshul Dalal <anshuld@ti.com>
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
 include/asm-generic/unaligned.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 9e5d93ec304..a68bd8f1991 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -22,6 +22,16 @@ static inline u16 get_unaligned_le16(const void *p)
 	return le16_to_cpu(__get_unaligned_t(__le16, p));
 }
 
+static inline u32 __get_unaligned_le24(const u8 *p)
+{
+	return p[0] | p[1] << 8 | p[2] << 16;
+}
+
+static inline u32 get_unaligned_le24(const void *p)
+{
+	return __get_unaligned_le24(p);
+}
+
 static inline u32 get_unaligned_le32(const void *p)
 {
 	return le32_to_cpu(__get_unaligned_t(__le32, p));

-- 
2.55.0

