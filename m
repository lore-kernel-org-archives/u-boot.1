Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446001112241
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D624183F7D;
	Thu,  2 Apr 2026 01:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1s3btrcm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5188184056; Thu,  2 Apr 2026 01:35:56 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E70483CE3
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 01:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-67c1e0718f1so185920eaf.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1775086553; x=1775691353;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmZQuOBkR1X1nCSpHolyx/MfwPgtIUchz1rRsx51TJo=;
 b=1s3btrcmbbUwNvR0qoqj9yxp+eBYoQRMzQnqzYIuPZzfAQTsSBiuriRY4bPV+USyj/
 Yx4rGNxu2VnejSbjOdpxf6F9sUxUVt3vvwn2lbOVTHDdBqbd/AMpZE5DlzBconR+d8mv
 2z0+wb2qvDbMkSsfQH9B/YZHf2sVWN+t6g3ER/Svzakf330xqu2cjRdIuaAyqmvoQZw8
 5o/7f7hmp0Zorplh31CegKGHP1ERCBfKNsldJFjJ35NXtRwpRN5ce6vvUyrxLmy2y0pE
 SuMy2NEMUezFIn5NNINvtlesBtd+xMCdl5/xUpKnJz3CdEeGgSdiyASstaQkkyLhm55E
 kYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775086553; x=1775691353;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dmZQuOBkR1X1nCSpHolyx/MfwPgtIUchz1rRsx51TJo=;
 b=XS5u7s0Z4nJ9aTNL/D28oSc/fVDmdqngRCZgcNMie099hnTNFL0CN2VqrN5H5kzW1B
 Ypn4ZstgoB5qhdUJ0pHkxeC2oVTSn1W+6pFDxLGQKYyuRoMHXXYCLr9PUJwOlUkhN9GV
 kO5OSL+kF/KrPxI5SwNyMbDW9Xv9+9mX2/K6RH8Lsf18NZ2apVKq42ccBMQmn1mCMExx
 RrpFNYn3Avqu98i/EyAJ1/Aur4D2F+3xKXNd+OMEieIvymfX0Rcr5wKsaEFa9e477RyB
 ychX4kpPW4h9dte70gIDIWCYXYLGiCPZJoej9ZPriTgYtCQXUoDQMtucw2gBNIFDeLZ4
 rpaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtgoTy4ibDZk2CArydzXCtE2mYbVzc7vu2yZPGpuA/38x34n89UGrfjXlm4rM7LflbSfzN7/s=@lists.denx.de
X-Gm-Message-State: AOJu0YxBgjegZq18VPQsQ9+9r/sphgB/qd3nvG/Cxqqc3nO9nKOZTXEs
 0xCZkCHhDtuL9wRpYs9WY/Y9VzsqMfhmKfrfF/q2QIA0NMzkWvoKwlfQa2FXKJan6yk=
X-Gm-Gg: ATEYQzx972Njh+KRT/O3q0GTPw2yY1z3PSNRBLPTzwWiOoZw/QwsKx/pm9J9JaZlbix
 CnzJsSSZ4oEDplKYg3kPI3Tu24CN6HCi+2kWIXO7ugR0hIYALp4fZUxOuyjz52mTl0932IuD4pP
 fPPL9ZrbydV/L6t5DwvwR36sdjgypoeKHkvIhIqgPQGCVl3+E0gH/vHrNmQxCiLj7NtkOQLAmcB
 BOP9V9BplC1AhPyd6q/8mjJ4lmdS6nMhn4K6Suye2Kuul9dbwuA6GdND80eGbiakKD/McBJL+Qy
 hY++OnQTh0zj4snXhHlVsh+lIySDTowNagTO19hHELRxFFHxlXDzaDL35ZlciTsCUn7mc0aJKJl
 hgyCsO7ZIW9t0YEQnCrUiFLpQcQ9ERFhznyqRzFLs9W21vxZlnW+xK22hboCb7P64vcw4dbe4t5
 c2aPZBvMpeCZTBN/7c7qYRMg9Piuqr
X-Received: by 2002:a05:6820:1c8a:b0:67e:33a2:5963 with SMTP id
 006d021491bc7-67fabc10fb0mr3002585eaf.15.1775086552672; 
 Wed, 01 Apr 2026 16:35:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:57c4:ef89:4ac4:d6d9])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-680a540002csm723855eaf.1.2026.04.01.16.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 16:35:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
Subject: Re: [PATCH 00/17] arm: mediatek: clean up init code
Message-Id: <177508653792.3145336.17353042473788497796.b4-ty@b4>
Date: Wed, 01 Apr 2026 18:35:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2554; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=UJazjA2d1CSRvZDZorCn3q1u5A+R50ZdJVpJ7F5SMgQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpzavPwkGtMNsWMP34gotGSqKUAGqTaHX5MMitg
 Jlo1ujSTjiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCac2rzxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5FIIAJBVZaOuslCH6rpQy0oHHnrFbLjoGesF85MPc4g
 DQctaO6wywtAQVpKKfX0uy2XJRTxZUTJ5/14oQ9D2FlRM5j9HWaN1s7X8h9iKBkMNUab/bprr64
 LGBStuI7vNAf3NfXssaMZ85RG8Ss/0s1vWCP6vQaQz73VHOu6QjVa1alxzH2h5UWHdAV7MA/qCc
 l6r4JwF26NmHjyKSGics7G3K8tIvE0FkFy2pejT+khewqMMvtpLs9NHK0ShZFX240Da9Ssijjt4
 XmrRs93d6BoiBMBsrSLi5sKKQ7ePBfDWQdJCoqLjh0PxL4wOGbdNrELdDKE1Fllc1ESm2TiCR3Z
 aluU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, 19 Mar 2026 15:00:03 -0500, David Lechner wrote:
> arm: mediatek: clean up init code
> 
> While debugging an issue for Genio 520 EVK support [1], we found some
> issue with the various init functions that have clearly been copy-pasted
> between the different MediaTek SoCs. Most of this is cleaning up
> duplicate or dead code.
> 
> [...]

Applied to mediatek-for-next, thanks!

[01/17] arm: mediatek: mt7987: drop dram_init_banksize()
        commit: fc22db262c49d68d1b7e02fa71ea58afcb0d4aae
[02/17] arm: mediatek: mt7988: drop dram_init_banksize()
        commit: d4342f17b671165ef730211efc8ee4321f462e7c
[03/17] arm: mediatek: mt8183: drop dram_init_banksize()
        commit: b1f0998cf2cc10ab10b121da35a5ecee71da0f4a
[04/17] arm: mediatek: mt8183: remove call to fdtdec_setup_memory_banksize()
        commit: 7a19d4f8f664c4811de36038b8d2f3c365f2d422
[05/17] arm: mediatek: mt8188: drop dram_init_banksize()
        commit: 1d0286af06271f376743dfd7585d510af598baac
[06/17] arm: mediatek: mt8188: check return value of fdtdec_setup_mem_size_base()
        commit: 742d6607a95df457cc8871aa6a54b9b78ae70cd3
[07/17] arm: mediatek: mt8188: remove call to fdtdec_setup_memory_banksize()
        commit: 97c169e1e443832a3ee21457f06e4983f1408d4b
[08/17] arm: mediatek: mt8188: fix gd->ram_top limit
        commit: 7d93fd2795ae7c68dd1887f15a0c712ca3a361b8
[09/17] arm: mediatek: mt8195: drop dram_init_banksize()
        commit: e448f52c836eec66c20546e4ba462555820963b9
[10/17] arm: mediatek: mt8195: check return value of fdtdec_setup_mem_size_base()
        commit: 60230d8e19bb09a60a7722628ffa1c85c5b1afab
[11/17] arm: mediatek: mt8195: remove call to fdtdec_setup_memory_banksize()
        commit: 2fc6706cabe3430ef2706c63fef01ccecb198662
[12/17] arm: mediatek: mt8195: fix gd->ram_top limit
        commit: 6507f61fb195206aa2272c5dbf20f5c9f32b72bd
[13/17] arm: mediatek: mt8365: drop dram_init_banksize()
        commit: 4da82041b60cae37670e2536496c89950e5d2a94
[14/17] arm: mediatek: mt8512: drop dram_init_banksize()
        commit: de4a370b10165ed9786a0f99db03783e9fbffc6c
[15/17] arm: mediatek: mt8516: drop dram_init_banksize()
        commit: f3ede901f47f63ba67d8b2604a4bc6df6cec2960
[16/17] arm: mediatek: mt8518: drop dram_init_banksize()
        commit: b624a3d7cf4dbeaad475b7c686af830194122437
[17/17] arm: mediatek: mt8518: remove call to fdtdec_setup_memory_banksize()
        commit: 42520df342681f71507e2e4cb4c549d40cb78087

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

