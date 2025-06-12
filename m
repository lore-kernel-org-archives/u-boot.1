Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0617C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E568182C84;
	Thu, 12 Jun 2025 16:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S92aXZdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30BC9828A2; Thu, 12 Jun 2025 16:16:46 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AC782C65
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-450cfb6a794so6194505e9.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749737802; x=1750342602; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=50CAZ1nwXXohebWwr0AtOMYCD7l/eFrtv1zFi45Opeg=;
 b=S92aXZdJIAJy9av1CgXKa40mJHRH2fip841Iq+X8y/S1A7RTmuqxyq4vNOajZAELQs
 QOzhwdw0F068X3CN2ZxdkwocoziaUqZzKHcUeYh+GSkIQRja4XmVr6q0LkCD9aX83JxR
 6fRkDRCARcxspDG9AmNFBLFhy9ycrQ7rgwLlwcnWHpc6qnOCB3Muy9nTCakmi3k0OnJF
 7sZAzuL5QNR/xANtjkham6wge8p/KmDIivqlvILTRqi9FynLczjKXR56WXZvhb5mBe6A
 2n+NnF1UudhhiwZp8HtJyynI13mk9FwdLzh+mX+4KyuRBSJKb+5/Mw7Z4yS7ckEjQ4TI
 BrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749737802; x=1750342602;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50CAZ1nwXXohebWwr0AtOMYCD7l/eFrtv1zFi45Opeg=;
 b=A7lq99ZhrLd66If2a1RRe+6kjBrmNCL45cZ99axoJ3vS9FBy05/uwt5mH8YDqTbL06
 3N2PQnA/GtSJ9KM+me29cw2++I4skDEKJF8iqVTYoCqrcDJp810OyGbp5hYAayFUoeC+
 l/rB6YpmBMTCL2gczl7RYQTCLxqlj69XMmKTXL9Yuab5IAolw6mtHLcNuotuUmd4stsC
 MRwPCeqYduEth8wpI0BPGOycLgdVNPC3BPxlV+EtoGkLHplO3kdvMFAvkztgZ56fFP4y
 Yur8iZzQcnTU39rCino5FHzG4AEI1c5v/s+MxGFot4lXzs/mJ8w4EE1SOVtM893TYktq
 MBxg==
X-Gm-Message-State: AOJu0YzxCs6yIUA15F7mj4c6dFLD8pONJVSxMbSAo21lIBjkH8oS1W8C
 JUyhbpzaRyJE1WJRr2dP+EpciPayu6hESTCAv6ZTcDWobiy0s8qtWJEviE9/HVu9FyI9RmDnroS
 lViIY
X-Gm-Gg: ASbGncsrMObsR5KGT6ScQ2FDwZ8eO1iRIERhZAWW0EGAnTdTNHqhfrkX0WaSqdm+FDf
 iQUs8PlsoV/oqnOplWsknkTSLs8nAn0GhClfDJqVOuHpF1z2TAjO3MEH8PVvq5ck0XURS5rNyUH
 5qWSl8/WJWzi9t5TD9rTkhJQr/wDYAyINFyLXeQ9bPWm+YV7lXkx6J+OAWSNhc7rabc23n/2lTC
 8uFLmD6jmcWEzfxOe5LDSfGA2/WDFa0WgqQ6LQdAumGV0jhBUDPCFB2SHHbmNC4wUWNsZz/jOGu
 b161cFTX4brQzdtJi3VXYkIb0IItTPvVlGTW0e7NHAGOj3zPLFuV5s5FoYWDLbezkgtg1Fny
X-Google-Smtp-Source: AGHT+IHQNKhSxkJsX5+OTLH0wezNFiQEeen44XOvaAmEO7C3dKPzeqELXVedpVvBm92c/0/+O+5RRQ==
X-Received: by 2002:a05:600c:3489:b0:441:d4e8:76c6 with SMTP id
 5b1f17b1804b1-453248dc848mr82262325e9.30.1749737802277; 
 Thu, 12 Jun 2025 07:16:42 -0700 (PDT)
Received: from toyger.local ([2a01:170:117e:fc:1405:203b:89a3:c77a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561b510dfsm2044006f8f.82.2025.06.12.07.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:16:41 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 12 Jun 2025 16:16:37 +0200
Subject: [PATCH v3 1/7] binman: add $(srctree)/tools to toolpath
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-b4-qcom-tooling-improvements-v3-1-76f34cf216e2@linaro.org>
References: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
In-Reply-To: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
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
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSuFGS3/BTs0Ad1Gq7yN7kngcjIWWo+ieoNhRv
 eWz5EEX9qWJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaErhRgAKCRAFgzErGV9k
 ttR1D/9UWuS0MXh9341igub/aLJiM/PDW+fhHvD2c55K3NZlXwktN0ktkLp6idf+TcWvYsKBYv0
 sdTTsyd8LAbXfzQvnIw4UgOE164YqDXUYaLpp8XDOhCjsSnUBgq0R9OoT9IfTNF8k8bWtYvaeEc
 ASasAAGUX5rmGmKXNytLXPkuw08ai7FoHMbV8jOjx8YaVldDcU2Ut6s4Zv+XOeh0ZQRSb9poCBj
 FRlTvFRkohF50hS6NCOsj8zSHRDohE/WwBH5BjabGbd7nry1qfxNclgeaTRIC0WUapRqyXE856S
 80PcNysOLxih8Jpd4lPmJ/QfWlak4KAgLFtlxpSeiI/XWaNi8RwTdDS9GqdZb6d+F2i7enjPKK+
 Zhf7CcSZye1gCjADFQx+Ogt+TuO9OByXG/Gz/MUN16fbzggiep6kC2WAHaYIKB9JFT8K3Arnk0S
 rCvw0AlpKqWYloZNmGMbCo/H7U7H3LJUumoNq2LViAIUBbd/4cJeYE3iVEO3LvCMRIzABTF5EBT
 aNU7vgjOJgkiv2qlP5rRLVtaSe4wnB8S4UfMvWE8hdpZ2iIg+wowoYugj20/fL0dxDgyTWX4vqh
 qBka82ev2CQUv8OdO2zmkyIiNsPhWhNE6xk65QEDoBCKRo/BSdbEHEECkzValYzKAZiZEbTl6/U
 p6aCsfkDmq9lDqQ==
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

