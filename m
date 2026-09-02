Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484AAC624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 15:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11E276070F;
	Wed,  2 Sep 2026 15:57:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id flAcyF4lHQzd; Wed,  2 Sep 2026 15:57:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788364649;
	bh=CWQ0YCuOiYWiOddoaqm6Mj1uC8j7wUxMHpApYwMD7ws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ql+dYE8aH8PvV9TK1naUnQHI9/Wf+KnjXedDOZOm83AOTmeP8wyrsxbqCMI2w0eAT
	 UvJUM19kK/OARDzBhbR/DHuMjSHKI2zKaYadlINask31fhsXsQK1bKp7fsNz843bi9
	 qGPIoS+uy8IU6tqMC4iSszqRK+C4kOvx76VCuRg6q5H9OaXDbVjYILjg6N/41+jPTj
	 O4dX5PaPvf8f/XbCtCEICovhs/J6XVNY2Uq96HsVVd0Kq06jmFnUbb3c0E+DT+u4ri
	 7N0CA9Cmas6MBRHrb36T4NToErcI4X42vAe4Qe4YZqufqPzl0Bqr3wjPHbn4jfnbXB
	 uD8hMDvtWgTZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29E6E606E0;
	Wed,  2 Sep 2026 15:57:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A5D19498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97FF040099
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:57:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LIPto1LupPLZ for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 15:57:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gnegllgO
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3F1140096
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:57:26 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7f5a781972fso781080a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788364645; x=1788969445;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CWQ0YCuOiYWiOddoaqm6Mj1uC8j7wUxMHpApYwMD7ws=;
 b=gnegllgO66J8bSCMwZJsJt3YRceVMBD+J25f6m4m27MuT0A8iN61NJJfEYSqHh1DRz
 /coc8RbUjPcsk/RgEN1eZ/wCfszIBTMItB0Bk15gUBFZZFXqYXZ0Vds5DNnqklqhcagj
 EO/x27WxMctjfXTS1vfkImGBl2nSqTjJzd24iiOUWQQSDSDaEzHZnKsN/5Rs92wBzSQY
 IaUJr1MXZWMgyaYX1ymkqRtz/rH24A7dvcslaERgYEhFS6HvI2dLGLgE2KqZcAugUVjV
 jY8P9gX0YSc2TNLTb3iLsN8e70I14Xo1/CDitMmrr8dGVb3dl0mqgL+EyRqrRP0oU1tO
 opGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364645; x=1788969445;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CWQ0YCuOiYWiOddoaqm6Mj1uC8j7wUxMHpApYwMD7ws=;
 b=T2nQ/YqlpOc3/UJtcLUUfhZbDXdE+ugszLpi4UpT8vEuGfI1c/sdqIpQZ7oZaUjGlN
 S/tKEop+qD1koIYIKDlxEOltdVkVXipXInJ27NoPTdHZ1+AAXRRuwAazaT3uL5Y+oJQF
 ZjSFHhNciaz6Xfyxvj3I4L2CIRpal+quoyY080JmJsZfvsoukq7YFdMOFn3zj32kWZPq
 nKgDfxZ1gqQ3i3tJoRw6KY7NRFxP5LEU5/M3rY4YXdmawaoxXji4TBtyYRS+NAPQ0MI6
 +cTT+7k54Ts/CNZyDu6FMwsa8D2h4TEx+yOPHESEgwpBbAhugZCweCxMGJPpI73XkKnI
 UkFQ==
X-Gm-Message-State: AFuF++mATW4xy11c7KYyBClCGGKAKYn62ZDiKsLMOswBk4hbwGpKEqzE
 IxqRGmEsxWjIC3fjyh0KOQWLP+Mi7+lPlM6rhvQs2X9bqIDTiPVvCy+SD2h5eFM13jA=
X-Gm-Gg: AR+sD11pOSxO6YJrcd5qWyMmEwq+iHnf2WUPb3LrI/5+u4PiExENvbfoPaCT4NjebTa
 4R6huTMdowIGjGu9nlFPmOF1auhvMJdpIT5LGX8MExdeDE220h/5q2WK3ib3kYxQq7i3wgdQ9XC
 5vkVNgEWILOJ78Uw/AqUwxeV3GH1YFcIhSCVhO4OVGc++ihzmYzJU9VT2pZFAWbu6yS74/YVMO9
 vxtD+/V/9h//9IbKXegPmiFvIHs7p2S/5YTenitXyv+2SHYoVuJdtuIL9XJkJAUyAeXojfcq8NP
 XOHXsVm2Ry1b0FEB3wGNvx7Bgsm6+Scqdnb8zzFtGI9s3O266lzKw3tSn3JQ/p4N71tr4Q04y6Y
 pKxmlx9Mn4VRdKG7R2+VPyfUgdgP1VYFMgZ3g5XU9GuxbioQT7/gGxwgovoMoD5fvd1nZS8Gsf8
 YT1QraN6PC5CiImHlml6YyadA1ckooV7is5b5qNPgQ7E1hHtbyhMRBbll11YDbKnVEZw==
X-Received: by 2002:a05:6820:c84:b0:6b1:6136:956a with SMTP id
 006d021491bc7-6b47fc2dfa3mr4819680eaf.15.1788364645352; 
 Wed, 02 Sep 2026 08:57:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:518a:9db8:615b:293f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b40ba66da2sm3062462eaf.1.2026.09.02.08.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:57:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260818-mtk-power-domain-remove-dcm-v1-1-13de7925ceec@baylibre.com>
References: <20260818-mtk-power-domain-remove-dcm-v1-1-13de7925ceec@baylibre.com>
Subject: Re: [PATCH] power: domain: mtk: remove setting DCM_TOP_EN
Message-Id: <178836463472.2649860.10538363758822994925.b4-ty@b4>
Date: Wed, 02 Sep 2026 10:57:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=320; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xtdul1NMRmjJIICSY4EenTqu5cqR1fuA9yzah4cMbBc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmEdccwKWtJ/ckYRBdDgkj62RicrrunFtvA1Qb
 hw84bLiCweJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaphHXBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ADEgIAIIax4NHPzRqX1UF28p/JIbQjFwCU/yagLh8cv3
 Hrka5g+8WGmRjM8jXZrISXANMyTHPGeT0OdAUUBBHegzAzrZKucCwvkZRDjaRGf2PYqwsUE61WO
 5AKoB5SbQa4Uyt6ss5WznaD84yU6S/IIw057N6zuyVUu4mctqnBSdP+N/iGXFZ7+KL+9OhRfu1l
 6HJNLMmtTTerRKKHn89h06Vn8xgxg+cR5YZQ850E8T6ww+HaMlnX18vwTjx3ddq3k65G8xOXJJ6
 y1AVXTRb09xjG5pknOfA4bj0S2qpdqqnwefHqEua2/9IDL539vE+e3MTMtIm2YfUYSyonoyjMEp
 LZJA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Tue, 18 Aug 2026 08:34:17 -0500, David Lechner wrote:
> power: domain: mtk: remove setting DCM_TOP_EN

Applied to mediatek-for-next, thanks!

[1/1] power: domain: mtk: remove setting DCM_TOP_EN
      commit: 938e2774f01674a3a38cc6df5d20401cf09b1401

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

