Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0E606A332
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uY1c6g+r;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cxu37ngz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2820B81468;
	Fri,  6 Nov 2026 21:37:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5mSupV8-gGLb; Fri,  6 Nov 2026 21:36:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6242681421
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794001019;
	b=j/+YFnjXtbcAbIROumbdmk8MfzpOBQgJhE+9GWHIugYyzxHUjpUJ3mMRNhnSAE4FlHYq
	 /ysn7qlIsGPy9CyOSAMkWNjS6dOE7i22L6KEi6Q1khe9dFaziAg5KBSuxmYT85nYo38lP
	 piXvdlthyoy2Pd04h3bqnlYL9if13Lqrbk4YtNOqk69FIgERPhZt9l0JmzoIhb+cc8/rv
	 0hpY9crJz/u3LAjTymKAb+NVqTEoyUeoicezbkC8Av3Kpvtx3uQ/H1BIcnhDgHfu6/wSr
	 HiXWe6CGRUOkHseg9wX7In9ngnB4xD1l12Ec/ndMIbMYntmNYNtiJiNqOupMu8y5Yzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794001019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3KAchQGbg9slqMR4ZK5ajWu287DbbNEyAHhqR4J1rJU=;
	b=pDGAQN7IqwnnNFMcyyqL0Oc2fq3EhYeTCGUf8MREuqna0aXHcMzmH8orrm41ovaP8l0G
	 ircJFnce1/+kUtUHCeaCEI1h5Dq/0mkujtxNYG+J/w/w4HmC3oRnD6KtvBc7vFLkrSnop
	 9hVkhQbHwyZycDWLcS+0N7bus6h1nERENePjlXdITJwrPy+51q2ywd6s4/pwp3C8Ol1mi
	 NEAHdmIhtbnUt4MevqHRnbK7iLHzASSUxV+/SJXecdvPkYLcfCJrwdh1LLxmnPy34I38x
	 hw3fnixpMqNJMPOdoBSeTHPdV0zdc49E+AL1IN+f+U54P6+um6gD9BOGkFomkPGN9cw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cxu37ngz;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794001019;
	bh=3KAchQGbg9slqMR4ZK5ajWu287DbbNEyAHhqR4J1rJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uY1c6g+rQvgibcV01oOYIjfo2uT3V3nyrN1DPyMhoX9M5OaL6YTNIUVR5syHRo7hu
	 50UKg09XjkmuUxpUEt81qsu1iiPqPvUNaCmT1PAEUo0Xgm4D/IOahnP/EuTWgWwcFb
	 IcOH7jwE0ZNZjSioH3mnCg1ZVVnkwR1CLmKyn3lSX1XTD2UabOkSdnSsP48ANzRT0D
	 tfwZp8EIgnSkRdzshIRxDkt+4ie16WbavV5uQ+YKoY3kBEQre+dzHf8tJjV4GIt/Ru
	 XAfA3UC8weph6s+SlPuLFUYz56fN+IQeZRx+oYgG9c13+9Rh1P9tyyyuGWc6qrhzWh
	 CwOZ9wOxXFOZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6242681421;
	Fri,  6 Nov 2026 21:36:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E09931C6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D24B881421
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bl0_mAIyB2ho for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:36:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F23F881414
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cxu37ngz
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F23F881414
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:55 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-844a8bf7e25so645159a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794001014; x=1794605814;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3KAchQGbg9slqMR4ZK5ajWu287DbbNEyAHhqR4J1rJU=;
 b=cxu37ngzB2HPIl1dxIc8g+9RUBeV/9337pNqF+W7eGTl8Zp3AVr2qGfJdg3WFWm2/b
 T+PwtlRDrzKith0IIGFHDlOA1DiRUgOHgT/3HjDocv6OKqDEykn5/R+4ejWCaHnWZVZ9
 GamKuFI7JDhcFZ1B1+GsmJ9Yxhh0tiVvpST/dDua0VZJYMJxqckAmA3wVOzasxp6qSHc
 XcUz2jQUyie7PovU8cae5tV1H5PwtaixElRInvDbmy4KtEv/ZGRGv8Abr6tb93yeCMM9
 fdVjH/t0LkOwC60E0WZlKvL0aMoDHqGm+8kxIvduaWPQm5MaLL0lKDem1XOol08cPBh+
 azDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794001014; x=1794605814;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3KAchQGbg9slqMR4ZK5ajWu287DbbNEyAHhqR4J1rJU=;
 b=VOfa/lCH/2o6iG1oF/x5aRpmpSB69126XU86GCB7qDsrc2L3S28YtHqBt5GTlHg+lH
 20XBK+ly2G9boBqzdnrNtX0tjxrcUwc8+9ECystMjORh4Pc2kaG88QoIodD6sUlnqiy7
 Fmdaif6X2HI6SZ5MtsvLed+ZEjww1bbo5Lujg/DIkb8Vf/qKH/0+yT0Nxc5CHnwIkg9F
 Xj4DQ3IlCzILkyRTHf6NsD9yiZThqXXZWA2/tG6VFP6tFnsU9F86G0394NRp4cKLGgdT
 5PsfCkUINXcaFii4/13xlAKwUNQsSqJd7s+qMVnSQctN+sQuO6KkUYQfCG8Ai5jX7FZ3
 LGTg==
X-Gm-Message-State: APuU4Z9vwdUENrLF70k5CFFLJwtJk9KultmMyRiqAWCveEBQWyihxid4
 zX+eB4hJLZ4pmSKqBEjZ1b+E3qGGMUO7rSGfD46RgOwbrhoSe1ANJBkwKeIEkPI3U1E=
X-Gm-Gg: AYBFou3oFdSyapHFa+wxfA8iekAWUl9/eprOJjVCoUX2sALg9kfdpumcmaJ6Tztvwcu
 arV4AUZ95dm1jbMvSD2Er2zLNIQ19JVYo1InYXnHdz9dKEgkZ8sXtVJonB8603qmD55BTQ5LxDL
 uBYpQ3teqPZEz1JuHPs/+P8lrLqi6pHXJpPuArPH3gN6aXIg5KAxthlYq4rINTcg0SspzBast14
 nJmgyejCFLWsGzbi9Eq4jxdYqmOx7nWKD96eMVIUXxOUoKPZOM6uWAjloNIbLzKYmhgasPxfB0g
 RRcDDY6S34aSp8qbrqSPMPQdrLZb0YhLaeqzqKldaM7t5hYDLfjoZrptGKKq1+9l87o/vUtAiEW
 Dx/5fnUCzj3dHAOaDWe3h10ZgOUydRqcnGM9mDWMXnW9z5Qf/NUi2QOxJkg7xlw68gR2+60xyCv
 tSAkXUupYHQXm6Gf9WmfI0wuwOif+ML5dbeZZFugsA8z71yGbY+jAsJErnvtd8PiD7hsrEAo2a7
 GHnpSPEmTm8hYMMhJCYJXRP3kqa4jfKHgVLL/UW0Z/vq19k0vMPdPnXExIDagqjWCdyeEfrva1F
 I5XYgzar0uFFdfH0oz3Ejui/0QSrO9bmvQ==
X-Received: by 2002:a05:6808:14c6:b0:4fb:90ae:2afe with SMTP id
 5614622812f47-567e0f98ec8mr3228160b6e.18.1794001014402; 
 Fri, 06 Nov 2026 13:36:54 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7e70338sm2475624b6e.12.2026.11.06.13.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:36:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Nov 2026 15:35:52 -0600
Subject: [PATCH 2/7] ufs: mediatek: skip SiP calls when running at EL3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-mtk-genio-720-spl-ufs-v1-2-90c578b6c43b@baylibre.com>
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
In-Reply-To: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3TenDpTVXLQNjqiriBMgIFKk2GWLm1RYuGxYLZVcmSc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7khHdBdmnEoVbEaBXcYSQC0giHwEgkFlOu8Es
 8yvLZoFQjiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5IRxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AsjEIAJIdmSb6mblVdLTvPg3BPl6Rk6DmeS6pT7ax605
 suHhPDMzBpf30Sa6GW7x30Cdurlb5AtfpOt9do7DQFcwbTnNP043m6b46KYp5h4WJgieTsjw4Vn
 Fx9D8iqrRNWW0dwYIz0R4j6kkZGM+Wx+g0Qj0qbA+LTAEjFnUkBUXuQn7dWTyHGA1xSrmeZyg95
 usY0mouiJYRX0tdfeLRxH1f0WAGiew9tNt68WCNR6tEo4iWfxREK7pY4/msDXs5HReEy4KMBvZv
 F9bL/EcveAaTSSsI4ue/es36MNP1CvvuAdZHQOltK9bMWNtFot1H23Shirzu+quMEKLW6+AYto2
 TjAM=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do not issue the UFS SiP SMCs when U-Boot itself runs at EL3. There is
no secure monitor to handle them then, e.g. in SPL before BL31 has been
loaded, and an SMC would trap into U-Boot's own exception vectors.

The SiP calls only notify the secure world about the reference clock
and drive the device reset pin. The firmware stage that ran before SPL
has already brought up the UFS device, so the host can still be
initialized without them.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/ufs/ufs-mediatek-sip.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ufs/ufs-mediatek-sip.h b/drivers/ufs/ufs-mediatek-sip.h
index 6a61f7bac69..cb27da1458c 100644
--- a/drivers/ufs/ufs-mediatek-sip.h
+++ b/drivers/ufs/ufs-mediatek-sip.h
@@ -9,6 +9,7 @@
 #ifndef _UFS_MEDIATEK_SIP_H
 #define _UFS_MEDIATEK_SIP_H
 
+#include <asm/system.h>
 #include <linux/arm-smccc.h>
 
 /*
@@ -37,6 +38,10 @@ struct ufs_mtk_smc_arg {
 
 static inline void _ufs_mtk_smc(struct ufs_mtk_smc_arg s)
 {
+	/* No secure monitor to call yet, e.g. in SPL before BL31. */
+	if (current_el() == 3)
+		return;
+
 	arm_smccc_smc(MTK_SIP_UFS_CONTROL,
 		      s.cmd,
 		      s.v1, s.v2, s.v3, s.v4, s.v5, s.v6, s.res);

-- 
2.53.0

