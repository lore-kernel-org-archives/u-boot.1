Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E3AC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C44B382102;
	Mon,  2 Jun 2025 18:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cX7l+Eye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 165CA81F32; Mon,  2 Jun 2025 18:11:04 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19FEE81FFC
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so49881395e9.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748880661; x=1749485461; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=50CAZ1nwXXohebWwr0AtOMYCD7l/eFrtv1zFi45Opeg=;
 b=cX7l+Eye2t13S070zYLlyyr5LcXuJk6dakIFb+CRFJ0Uq+rGTAJmQQlJB7ZRZPmaoO
 Nlhy6f7B9p+QjJ3Bm4/6wMVOhwOSOvZB3fV0tYyMvRz2WVHW/MbDRmll1eNunl63tlV+
 mmIbFY9Npqk/vc+xFQdiPZrAgKJMWyh1LS/u+6PJz5jlIDV046zTRmA+RygstzkAy6sr
 VZbduo+MvsGf9e4f/NfkzkTALLug5UWUupIzBwKK0tvrjqpS7ZTZi+CGS97s6V7TLG6K
 jpSYSDoIQV9fCdBAEdx3hs+tOFpF0GOCwgGM7yA/OyljyvjBl74VwOAm57OhiBaBiLyx
 F5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748880661; x=1749485461;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50CAZ1nwXXohebWwr0AtOMYCD7l/eFrtv1zFi45Opeg=;
 b=Ce0lvV+X2zH9um8V7GiS/1FKsQkxAKY4+hN4N/PMyxGnN//0uTuFEUPiv0fFO5v5Qz
 HDDbKORahC9Uh+vjbdOAxE27Ny6Aj+YliIvEFo3Pc30jTIdC8YHFbr9Q0PRkejrB/0AJ
 MysN9LA4aLKzAIc+fLQi0NnmOd/y+g0uv3sGlJAqUvsSnOtvfsrt+crVwMbITwL2Cq+N
 z4DahuPv93cgdulOL/L66ej8EiGMY4DBo/ZC/pajr1rhfiMP1nApAbuHhfwSvrC6xFTM
 iy6aaycYEfDpkS8CMD2mj1j1EjnFv0BQv22OQbEvGzCk0B7WZPEvm5J6lmUvH29mtbdb
 obiA==
X-Gm-Message-State: AOJu0YyK6LQw4/sikUlBsPQms5eZ8SPmQ+yS1adCO2Jv2kZEAYtsinEQ
 vIf/olkwV4zM1PKJr66DPpoTidvh6fmTvrsmSkcOKQM80rkltmULo+s4JiFJuWKpFxY=
X-Gm-Gg: ASbGncvNGSuwbhgpwNn1GbXwuVLEdNh74hJHVjGrFtahisdTiODoNfOXk/c8ln4e/wv
 7nu0anks8DxqiQRduOXyfYTSdDpsOMULKHUkMrMA8WOWE+YCG54LB0udXaYQ/l2OQMtC21jTrB5
 sDZLslGb+OJB5uxrFTFOzOo33g4n1mY5fRdlCbdmC9vARztPtf+Q8Mg5Q5Q6YGhB9LFW59ZkRdj
 C3sgvHEBURgt2r0802gHhJ2ilSOou9yoK4vA0yHSI8/jJnZUlpSRKcu4Uh6LC1lSFZS6oKtDXLa
 5HOR5FR2/SxqqI7N+zCazw2NddxFDXStOXzoRSrwUUeVekgx0QVgJr9dahYIF5uxCJaFPhAVL4Y
 0FA==
X-Google-Smtp-Source: AGHT+IHfBmR8RMaH7+w7HXhS+A7/LCrTnrX2WZzLCETUDQLFrJYetaQ5bLFTSOtIH1Wp0swgOhal1A==
X-Received: by 2002:a05:6000:3105:b0:3a4:d722:5278 with SMTP id
 ffacd0b85a97d-3a4f7a9d552mr12538826f8f.39.1748880661365; 
 Mon, 02 Jun 2025 09:11:01 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:3688:a9e2:523f:a049])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b962sm15212138f8f.7.2025.06.02.09.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 09:11:00 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 02 Jun 2025 18:10:52 +0200
Subject: [PATCH v2 1/7] binman: add $(srctree)/tools to toolpath
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-qcom-tooling-improvements-v2-1-c7d19c0d4a8b@linaro.org>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
In-Reply-To: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=825;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=6D15FNpAk5uavzJSwe+BXnfnrFpizR4Xo+uL6UaCRfQ=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoPc0RuWfzJtPuIBJFFf3I7jnwegp0FZnsmkgNa
 TwkfVQ5IqCJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaD3NEQAKCRAFgzErGV9k
 tnzDD/0QpoCMeZu5Wh5X6L5Vj26+f2/Jd7lrqLZmV1XqmiwEtDab7fbl9SBFtUILhatH8M/n1ic
 1iZiSvQEbPFJLPaJf8lQ/OFOA7kN6liNcxFnkj/Ul81zIwCW0MmYSZf9VnbXE7HgORaKd8s/yyX
 9ELGQH0J3oxT0r9LQqOo9qatqIU6ck8kSmPlPjea3QZnuavkD0uEzx4lGb/SGPQQCB32Vp0d2/a
 zsfHKEI1lyFGXDHVIQpwPgRLVMY4toIHgkInUfdpzVG+dzqj1n/VA7FmEljWRwwEO/jmufKcovS
 8MeN9Aoj72Z0PtIyB9ohDYgAthxnVQjKBsOcsA7oWHPOOiuJ4hzNAwxFyMmjthhPVhJ9jxz7faX
 El0l5U8J0MDLtlcVHTRSw6Aq6Gh8E1mehmLy3ChoPpWPLTFaiV2CDq0smeQ0mPoG4R6yuny3Mif
 R+sU506FPBYKFe87DLqSKOgbICPGV1XN4HMfnvUoT8pLkKy0aMIa+oO6EBsEu+Z1sOmSi8DRk80
 wY0hx+aclTlLMtbMQ4BG1/4D8XY7ztxxgA47NLWmdbHjq6trUNZDKXGuYDlG1C39kYeZ9K/Wg2S
 HZasN+KVsz5m8C6sIB8quRyVIUUh9kjkBkeAE8oblYq6nZLISAuuTyuCHTBzYJ5X8Q2KQQ4emqE
 IwFVcPvVNzYy1tg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Not all tools need building, look in the srctree toolpath as well as
the objtree.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index f88684947ee55fbc28768eeae159432649cc9ec6..719f7f6ba5161f9ae08fcfeec21b45629ef4bb3e 100644
--- a/Makefile
+++ b/Makefile
@@ -1402,8 +1402,13 @@ else
 binman_dtb = ./u-boot.dtb
 endif
 endif
 
+# Not all tools are in the output dir, use the srctree toolpath as well
+ifneq ($(srctree),$(objtree))
+BINMAN_TOOLPATHS += $(srctree)/tools
+endif
+
 quiet_cmd_binman = BINMAN  $@
 cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		$(foreach f,$(BINMAN_TOOLPATHS),--toolpath $(f)) \
                 --toolpath $(objtree)/tools \

-- 
2.49.0

