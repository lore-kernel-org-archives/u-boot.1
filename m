Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86923CA5FAE
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0332A607F6;
	Tue, 29 Sep 2026 22:21:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-CBeiHkF7iu; Tue, 29 Sep 2026 22:21:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 51904607E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790720480;
	b=SM3ZuJENp50D91uMdYpxfjeuCt6L4Aif99PwG9HXxYUZ3Li3tG/xzirqtImgOhAOf/GA
	 L8D/TnhXh4VTnQ8OTHqosZXPqsrWmJEi9HrpAfMUJPRLdu6cOO8Zq5gRiXr+4hWrqNWed
	 Zu20Ia9dxI/8MDALbDWMyA2x48N0VuYh0vtopYKRLst3sGaPsLZLF1wKDWR5IB558EsL0
	 TDcWYJM8NNICr/T0BIsWJp7hw/N1sDQ/95mPSLZ/R1W/R8BwO8BorlA72e6YidDv0W+lg
	 shgaQ6lCZ6X74F3xSliTV54qtV90Y4j4rdtY5gp7Fek7a8HtZw7QtA7iPM15b0jiyhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790720480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GXBdatEqSB0Qot25W6ZuvQc51y3T7BG4xQ9YRSKthNQ=;
	b=rWiPeoCzT4LAEf+na1wtNCeR+hC+9fd3U0VPqn9s8948P9inI/1S4vtlafTsqXWQH3mC
	 6Jqfdp6pbD1GSkuOcIqBh2PCprfElgNw6YTCv1zQjy/D83uoDba+zK0SwcQB4rbWjMDH+
	 e+d/4BHokTFi+u4azVdLRayWt68yiR/5PYU90W9serpvNQzOOyXVhj7PJ5lq7OjYrvt9s
	 NUWHKkTxP6KoPRi0GV4Gn0oxWUUyoS5oUsD+JL+vtDK+t/8Aox1CesscEH5ZulYYzXUvH
	 KPQQC1SX2GVvXj2TPReYicdjtxbon5mYEBiyG0Hmc4R70M708zmIGQsf3K72gUId4uw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790720480;
	bh=GXBdatEqSB0Qot25W6ZuvQc51y3T7BG4xQ9YRSKthNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=drI0JrznLGRIqDiPV0gXPGNR38rojymM5ID/xK53AgqH3gVL86056yRoOyjgnwcSR
	 fd4UTP4NTeWEmuekm8Jz6YTQ3MtoDvjnRHTtqU5vnLZiF8liVDMLaQL9QcIljz4JHM
	 yqf2uR2ozf0nT6N4mDwWGK5l65iACyUmI4hfkru7Nf9UMdkD5yXQHGEMeEPx5yZ2Yp
	 1Y1UleGLluTxA8DToGhaOzQcO4GZluZeMrUjhXkeZu5NqEnYskM4s19TOIKITDj4Gp
	 vDv8PA6/MSYWWb8pZ1ddSOaMk64UwFSlys8lolwTUg7qdcgH1/aRyholgsrg5cY7Io
	 /7mobEFDoNLlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51904607E6;
	Tue, 29 Sep 2026 22:21:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 065EC24E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFB7440242
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id emwC8uJfRbTc for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 22:21:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 30CCD400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790720478;
 b=PecF5v+9NMKr2lDAuK/hTxyduNJM2xiITGVBSqOQXspM7ExbVB7yVgR0n9krX6/VdEf0
 iBBQgZcHAu+H/PkFXBfDtYDlYtmd4FZHKsars7rYERGjOH8jzhy+o2a7NvE2tFr1T0WrW
 9K1vXxfStuIXzw8Pib+ynnBlI3BV17Gs+jxDiS9mGCf9clYQQs5Jw2DjEhRVjDSGQfErM
 GXJa0t3zRRRgqoqUw6rFKdojuZUzOuNzv2tnD6lEsy6uaVNINxGobHDEhqWaFvL8be7fl
 Oa7vPpQppz89rncnc0BEVYEBBUY3UIeRYhkcQxnxFtJ68sbr0xUmKc9+Jl8A9xTA++A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790720478;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=GXBdatEqSB0Qot25W6ZuvQc51y3T7BG4xQ9YRSKthNQ=;
 b=FOe5L1tUXlaVhCTH4w068rDFF2m541LaapVAWdHAYAyEh5R+m509exdFusK/m1h4DrL8
 wDVUUKUfSVjT3yZbnJcFT0ueKtgajlcFhF/Ibg1OJqQ4Kq1ZkrAxAF4pcZNlplX2pbwGf
 Pzd3rsh6CwTu9DdnADxhX3Gze+w1H38zgQCLtM1oCvIkANKpmylK3sGX4vFoF3CCyQT7K
 xz71/H9L1Z1iLfFLGE9lKXU2cq/ToVjNDc36N9osyiTeyowPXtFqptazGQl8TsizDhms9
 hSlkv/7iZ4RD7R2g+gbLvE1kX+EhlT0UqaAO4f69iZmdkyDrZSa2nb1igRUagrpZk2A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OdrDnKY8; 
 arc=none smtp.remote-ip="2a00:1450:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:39::10; helo=mail-ua2-x10.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OdrDnKY8
Received: from mail-ua2-x10.google.com (mail-ua2-x10.google.com
 [IPv6:2a00:1450:4864:39::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30CCD400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:17 +0000 (UTC)
Received: by mail-ua2-x10.google.com with SMTP id
 a1e0cc1a2514c-97ea5bd53b4so1128590241.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790720476; x=1791325276;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GXBdatEqSB0Qot25W6ZuvQc51y3T7BG4xQ9YRSKthNQ=;
 b=OdrDnKY8dGZxCV/uciH3SU7UItET2qiTcASetTew1CgAc1EVHfI24RyXks0d5o19OG
 yz7HrOMG/NPiRQ02xCbrzUla826raFp6Aalo2p0y2x/CxT/thuQGWRemak1HZ5m6740X
 EDgja4RasaOE8dDofYwX90rZeVDPQRgwaHPFcuq4VsL7FNCxTYQjvnnXBerAxQ8gKHaM
 LOtIGoA+FFTEA355EFvjnuUW0uPt7i0887ZeLycc0lZ+cmQ+Tn3XXBpTpnTC52P+a1lD
 ORvJM47/8h2Yl2Kos6PJeS7gp2qwEkBgHkDmgD5DlyANRV7KtPzgkU8FsbcZZxb1aps2
 dwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790720476; x=1791325276;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GXBdatEqSB0Qot25W6ZuvQc51y3T7BG4xQ9YRSKthNQ=;
 b=DqMvkql6Fyzd8InQKzfdNPuI+4COvi9ObY6xjwijFHI4qWzs2zdhudSz9/rPeoivln
 iiG6Xr/LQcK3jeMkQSJb8L5cbMZk7BAfmmpvG8ByZvtCQ/L+3IESra2kKMQhoaOv7bKL
 WBnKwKfkZPuPn+oSqcSIS+Sh1cLMUcPiCn9J75oK0Wdi1Rk+c8Yu3g7Gpk89mdFcTOjt
 ApnTUHuuTmL9xw9PG3yEsf2IVeGxwR6DmuG/dDd9S2wWsMcDhQF/2YRo8vinJKgfzMNy
 gR2zbnJk/o8nxaAn4y5/jVRi8dZsX+Mlx75X1hzGPWKgoUOmSUiyFTopO60gaew1Y68O
 xm0Q==
X-Gm-Message-State: AFq9FYL9Mbkq/HLnksGLLzlFCbmRtV6Nf2dIFDuwI4AVFy4NFRFMtQr6
 MNYkHJoxs/UBrjBnHyqH1XDB62K3URGRcsDy+gGkXmDYy2P0jNF64PyHF/uPnFoHISs=
X-Gm-Gg: AYBFou3DZLFxjwD3FrMdpfILy5Q4MmTVOOIi8wS+mZBYbwmsLEzB/8w19OQoo/e2uXC
 zH8sqPV0NZNqB5MDPa74eBehTU9UM3saSY1wP1yW3SAKwo3oOrFhhvFJIFBiVeRcQUci37yP6Q3
 ZOVbfMvTrMHk8EDGBNdgpE4cobtgjMKf12wTRWR7M4mpUAwhZMsk1IgUaVuUarDPtfkdkyjd9GQ
 7Le5GGPvkJMWZ32uTZiGrX0879T4KzPdrQtynioLpi8THr6OimzkgJZ0OnCLcysR2V7vudbZ2Wq
 LkqA8zpeXsPGiGdraCl898EUGvqDTDxzVQ3ppo4HRXnXb7/9RZP4boY/rwpbZNcZ97PqQrfXRjg
 mnfj90ulU/TEe61regucujXAm9/D8u6jpxxcztccjAHyGSZK/jkYtAvnK0jRWgseUSlRg9VWVXI
 HR1JupFexTRtuW7BvwHSh99yEZ7xohxMKL8TZy0f7PhoZMFB8GnTEQz/kfYhVvcOX/zORx9ZHn4
 MX2RZy1CGQydCL64N/daT4VaAhIY8WoC+Molg==
X-Received: by 2002:a05:6102:8657:10b0:7b5:4700:3a58 with SMTP id
 ada2fe7eead31-7bc493fedbfmr203864137.31.1790720476537; 
 Tue, 29 Sep 2026 15:21:16 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:9534::ddab])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-988d2a051f8sm746472241.3.2026.09.29.15.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:21:16 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Tue, 29 Sep 2026 19:20:31 -0300
Subject: [PATCH 1/3] board: sophgo: milkv_duo: add environment for standard
 boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-milkv-duo-bootstd-v1-1-1b75c9ad6483@baylibre.com>
References: <20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com>
In-Reply-To: <20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>
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

Add the load addresses needed by standard boot. They must fit in the
64MB of DRAM:

  kernel_addr_r       0x80200000  (16MB)
  kernel_comp_addr_r  0x81200000  (16MB)
  fdt_addr_r          0x82200000
  scriptaddr          0x82300000
  pxefile_addr_r      0x82400000
  ramdisk_addr_r      0x82500000

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 board/sophgo/milkv_duo/milkv_duo.env | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/sophgo/milkv_duo/milkv_duo.env b/board/sophgo/milkv_duo/milkv_duo.env
new file mode 100644
index 00000000000..38b972c7b57
--- /dev/null
+++ b/board/sophgo/milkv_duo/milkv_duo.env
@@ -0,0 +1,8 @@
+fdt_addr_r=0x82200000
+fdtfile=DEFAULT_DEVICE_TREE.dtb
+kernel_addr_r=0x80200000
+kernel_comp_addr_r=0x81200000
+kernel_comp_size=0x1000000
+pxefile_addr_r=0x82400000
+ramdisk_addr_r=0x82500000
+scriptaddr=0x82300000

-- 
2.53.0

