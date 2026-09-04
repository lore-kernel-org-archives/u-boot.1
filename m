Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C810FC61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AEC440BC9;
	Fri,  4 Sep 2026 13:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9BoCrmfwBltW; Fri,  4 Sep 2026 13:50:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 96E6440B38
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529813;
	b=qdp031dKhyKlj1qgPNPqj2F32gDzfj+orMaSLlgqnfeLk4kw72clUJK/nth/x5JSkumv
	 JidTfL1NtiQiBAJ9ubXceJ3Xw0014flWj1bMWRlIwvfzV65432EIPkcD0e2M/soood96O
	 v4kGyxAVeFBlLHBzebS8iadKhowojGkcyeCYVAfA1ZEI6sIdc/5uW8y08hnMa+Jw8WQTh
	 CE6thrBnVlmOaduXd03ts/uUOUjtkCQ7c78JWocEA/3QKbm4SjTqzIgc6pL7qg88Qn3X0
	 orFKNL55yFUnwhg4rYnZk1Ud9UnTBCh6/A7paF8gI/bTQcs8O3oPO47w75U/WMvvpNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
	b=HlyvFnGpFvf7RYEONvtm69Ycgd8RBbWn9pvnGxi4XDABfORjroOO1mGR/vihVGgg00DP
	 quY4z6iq6ts39ALcQxU/FsqKpmich7l66WVXOJEv5OdrB/oI+dj9u7BbnCFtHocpPQgq3
	 zW3XsVEplC4VM2YJjrEIWkH5rN7BsIZyBia9wAVkua59vLPLpv24D34/NrzYt28jGOD4w
	 HskntXuoroqQM5Vf+j3htfNFhN/9IiWq4rihQttY1C/9o6W0HervbhLhU4XT1vTbX2fOL
	 afhdxbx43hJyEhvynNwhFbYS6gL47tfsES8VJXCbvpxXAW/5VsBvolF+7J9JpfQVuuQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788529813;
	bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QtMi418bCPffRz0w3dQa1SCNz8porXlCTQh81QZHfQZSdTsDHn7iqxsRc2T5yePoV
	 XKNg94g7QwWzkIFe/fr+lr8LGKMd1mbT5WY26yHV3bRIGeMNad5IV9wMkCvFVi6Wrl
	 gHQw5YZVNGF3Ztt/8UEchtsjDRSw8009an0IlB553EkCmIZMJBrIu9aSR93t/tx+YC
	 nEQ4EGHByqannnyhOMtS1eFYNbMkwITcclLEO8jiOfs5pKSykdcgamw5UA2xB3L2A2
	 u8QWLeoOXjF8JdDz2FCOh6zHtQteiTPOyz1zThQ4aaGVBdAjG1g7MFpHKYPFKBGYt2
	 aK5LfwtANANvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96E6440B38;
	Fri,  4 Sep 2026 13:50:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90FE377F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76B0260BD6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wRu8TE3KOdy for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:50:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5A78960BBD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788529811;
 b=lOMiVjQSNjve9rXFayekhzSxVkoPwXf1+LCueKEvj99+XQPidBbAhVIOPkFBJjtoPMoz
 c+SLkzxRxt6vUfaPGbLHJPqnX+VTqliK6lGFBhP/NK8dcaPT8yxxem+EU57fRG5XRbFOc
 jyTqnKJS9ugcHG31+dM7TxGTgtTXTyiXhkJsULi1jQb2vvJm9rzZJVz80DHBcfZ3Wobhy
 HXNFaRMMj1M1S6DeWbsB5oq8vA7UnkuCBFXeHojCOUeGrC9Yk6XEX6ZBr0CG7GBKg2Iz7
 Sq1VklAPiD9gR6LrFMnrX16iaZQUeZ9gMjNc2jwK78+2EhNSetkIvWlj4U4V8XAVYRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529811;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=iKFNATMbjWMi/PsHFRH+zY8o1LebYdEH3WKA1DDTf+anQnmnNAPZG5eAbrVhhMBocoyQ
 aCH/ChICbF+sjG2iQhw8oTN0vSlpzkI+jFfxv2ZeYVxCTiKzrDGgATfcfayA81pKHlfJs
 tOREcDX0VoC+3lqARgHj6mntDWG1Gz5QlK1yoacbxEeIOY1fkLX1RhgNhq9FFZzfKsOTD
 ULypAzZK1tuq5/PkktgG0PPad+VGPQVXFz+V35DFupZVIXaRdi5crruFTfiT7C/SJeoSa
 DohZapdbuw9Mz7GhaBOZboXqfsvOWJQnbCO5Rqu0bFWkIMgXA/LOcVuBnHI0hNyBCPw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Wkzr5L4a; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Wkzr5L4a
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A78960BBD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:10 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-482e067e908so924888f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788529809; x=1789134609;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=Wkzr5L4aXizvdUa6WpWDUE3Ma7F1SKfx/LcWR/hL61a/VtvkSh43/N8O/mdkk0hqKf
 pGrzi8JvHKGNhm/ubUyEMnM1ApAXFeazTk5pRvv91k4w4AGQYc66ROEZEielbgF2n6Hu
 vFKbg5en8nBf1jzg5cmHlrvwNrllYuOx9SJ2CUs4Z9SvhrCn6s65c5jwhyoFn6OagOJl
 S2AX4q0ne9rEFuMhqfLN66h8z0RbjwUo+LVjOWnivZbB4K3fHsvWtNpQhbyW7vgnZOiA
 DRmLTITknF1LACAkF/1G4ATukrw7PSMwAbH+MQirgf7tAgMNjZKBgN/itRqHQhkl81t3
 XtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529809; x=1789134609;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=UXup11YWvx7N7onvzEOOJ2xP5wv3i9e1YGvrbKO5sjHthkLAyrHMRBJD9LkM5CPOcK
 1GdUAzFeyJA8FFZ5brhywxpJXwW1M+3ctEP8xGIS4ps4/yO1CjwiffcUc6WiVtqG0RBE
 Zg4HztfsLfrSRHqRfnX1sXIuU+kRn2rdJPp8Yv7G/amftBpSzqWUzl9qn9bJqWX3PM4R
 XHVs5+r2vnHqCPBey1ECeMeUXVO14PBP5u2/02oRD/W1L8YfGuFOcAWf324PukEBche5
 Jokr3x7WLOW7tqImAVyZL162OWxyuh22OnYg1c9jRsOCHfzVZ2zGk4S4aX7FG8S0MZ46
 6uOQ==
X-Gm-Message-State: AFuF++lOgLdc9/r+hqlRQ570qNXceW1qK2lDbJcgSPHD+uHe25LfOYJ3
 HuB6MBt8/my/IrJwJ6ZOB9Y3NHAypJvyd6UCfYtVb+DAHuCZ481JOHDRiFv1d8xypIk=
X-Gm-Gg: AYBFou277K2V59aHYABsN0AjLJ/oi/SsvwWmv/EsG5NxZOZtRGIEIJYLFtLoNx7bn/g
 amSL87XigiUErz/lvyvf0o3jkHT6AQF5CGdA6J63EhaYdcTY2hmSI7nGjZ46YeaBGGcS+kkSe4k
 cAoii9M6ybnGSqPPsbf1NHxOYjUk1yaxQnoSSHOR0Z+1fFpcph5pZEul2P8qluXfoWjHu44vJP6
 y4Ocnp5iekEeOOdH4IXqWT6aED6wE6O0SJ6Ts91ShsC4ES2cMvJBYK454mvCFgr/gxcQb6Ngrjz
 Vek9QiHpO4jpAraO38udCp228nakNSoMeqdm95S1Rh7LN65GwvVW0UyUQzjbI0Z3/Qe3s+abh0H
 4yNDiZBNr0pLutwo/hsa54KwcYZcVK5TP8DdPSltB/oN9XwGxOktobPuEjrpVFYJtLo0BuEvbYM
 15WRmmfFwAGJFUhK7OtRUphQSVslFcfRZtE22JkiEUHAvdXjv58twKTb5u+H7OV+q9bxm5pNsHc
 nDsL3FHYR53HQfxtlmhU3kGldRVPimxWwqm+fHWOUmC0XewPP5JOGyGL+eaKuBvTblknowobRoV
 63VefTFIpszY3C/kKQdHdhFIogzi
X-Received: by 2002:a05:6000:420f:b0:484:f26c:b9f3 with SMTP id
 ffacd0b85a97d-485872ebd4emr7906509f8f.28.1788529808786; 
 Fri, 04 Sep 2026 06:50:08 -0700 (PDT)
Received: from [192.168.1.60]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm6708786f8f.1.2026.09.04.06.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:50:08 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 04 Sep 2026 15:50:07 +0200
Subject: [PATCH v5 01/13] memory: sort the Makefile alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-add-genio-510-and-genio-700-hdmi-v5-1-dd9dde2f972e@baylibre.com>
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

