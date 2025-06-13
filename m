Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230CDC71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 17:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D15E782D18;
	Fri, 13 Jun 2025 19:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SZ+JYAJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B1782E6A; Fri, 13 Jun 2025 19:23:14 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A774B82CE7
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 19:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so2457884f8f.3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749835392; x=1750440192; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=50CAZ1nwXXohebWwr0AtOMYCD7l/eFrtv1zFi45Opeg=;
 b=SZ+JYAJGhZOpYYwSmh8/Az8qMKppw17yaGEatgnC6HL/BLivcFcnrNZSysThXs8qz7
 nGbdh/h1PLmekidm9kXbVRmPAqLwJ1l/tS0jsys3OqxFDmtdzjqOhK94l+bV3pN1zHk8
 QxKfBnMnE6EGxwJp/9W/KpLPHOAHAMgdAvRFuphre4MHsXhIJjO85UgTpDG+cmlBfnsF
 24a00pIjqZxkYqYjciHYMCxn2xY1RrShe1Mn7sHbRwNrYbeR8A9U4K0c4HQlyBlQgYTN
 1LfFIHOQraPwM8IY7wr8u5C8rpmewbKfbrmJZv5DxHHpbfXnKkYpiXwSBY99Ir0WRDGZ
 b1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749835392; x=1750440192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50CAZ1nwXXohebWwr0AtOMYCD7l/eFrtv1zFi45Opeg=;
 b=M1l4rgv59pmZXIMJr+UJwU+iMb32H7ovkK09ItdHR8S5mosRUES80VflPOG19vx0jI
 o61XnTOlAX/CYeTn8OdLCNV/pgKjaq16BVTaSuSelfoSDPR1daZv3AuhDxkJTGtobWDE
 tJ4oz1e84+Xy5Rhopop3xVggaqE/jyRH9v43d1U4WsSHNlNo9lWep2TCD5qx3MEbUkBY
 zmj8DgMbyrNRZqgV5P74lgtGn56VODV5BjR/yczqwH83AxEMH2LunnKgzLLPh9TKyAI7
 p3ICRlDyL/NTXxdjsOkTMCORzbXi6X8nvWtnJQa23PZZWWXhVEbGMdz7CXY0mUJq/ZG+
 0I4Q==
X-Gm-Message-State: AOJu0Yw6Xbz0fx1tuc6dq+tiv5qWRZJvGpXFCTOWUno6Q7ann+DWnTgT
 cd6Gxt9uymReS+U8FjaaBYUnGj/NSGZOp7aiZUtoU/GowqX2iExoi5TRjVRrEt9Cw04=
X-Gm-Gg: ASbGncuk9y+MqbRAn2PU8G1e/CpcvkYZDJlMMz7dAcFZGGl3yXwT4jzQ0c2I7osWiBD
 mZhvwesR9jRA3ELGLDoI+10aRTKtsIdUPPqI9cx2sTXSRqvAPzLouPd9Gg6vtoLIj5udavmTjzw
 pBh59l0H/Yn5fvHB/3nlxq8d/KIMwxN6AU3f3TWtst/66dJ11BVeKCzRsalwowIU35FyJbMYUBY
 pPvVQgbeHPv1gW2bHL0cQRUC7voweb0jMbZM+mmfnFAGOc9z12kvlDQinqU/SmJNmowdZrtxkdg
 Assuhz12FSxpztEyy97SgcsS8UskcJaJdIrzzV4FuZjxlqBVoBEyXoYJp2DkDRPE7pPf
X-Google-Smtp-Source: AGHT+IFUpx1Tvzam89Fwp79h/4T1e8pJAxK00i5WZFGj8fABSC0CCbQnGYp2vvGEDsf+TU2HzhN0tw==
X-Received: by 2002:a05:6000:707:b0:3a4:d5e8:e352 with SMTP id
 ffacd0b85a97d-3a572367deemr589764f8f.7.1749835392057; 
 Fri, 13 Jun 2025 10:23:12 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:19e6:b5d7:f8b4:a927])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c50esm57895015e9.4.2025.06.13.10.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 10:23:10 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 19:23:05 +0200
Subject: [PATCH v4 1/8] binman: add $(srctree)/tools to toolpath
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-b4-qcom-tooling-improvements-v4-1-7ea1c68779fa@linaro.org>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
In-Reply-To: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
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
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTF56Pbrue9ZDavTG6cPL/39O/JqnfxIHpyK44
 t93ZpTwMTCJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExeegAKCRAFgzErGV9k
 tjJfD/9LWfAuXjvCBhEC3XEnaTCqb2yMeQ4au6eTINUAryKQ7SIR3qKNnJkSN1XgfeB/fIiY81r
 VqhF+oOzbmG5GvA0egF84l+s6mTPbr8vPVuebTbM7C2MXIikySKUVhyNmlKE+8R8CEw0Y4FZWBU
 Vnqn02EG2Lx4BmeJzFKlhe5jR9yRZzfaKJK8Zhn/KZsC5xjknhQQPDpE30MQBNIDIhEbD7Vi8pj
 ppuP6Hz8saYJJQCAGzKO4O6DX4Xy7atzT9xqvXKfLoeNrXbuidK8/4Llfb1hVumBWnzvzfbmAT2
 KFeMB+/dA0y2zTRVKRqiUtlVAmNDzO5k6tciH50YeZkO8yEHOkl7VqLGyU1oR44nRUDe+lrlHrG
 pJ0ebqW+8a7DJSZBDVS9t2J5O+e35AFSuxUhIsqejhiU7bhfW3QVDXevDh0BQ9DUZduYBe2Kssj
 DulghKTF6M8dA3BO923RCvXQdp+oQTNZLVpmktg01Dknl8Yy6lEMOHkVHNrH0e7JL2lHHC3foX9
 Rhd59w6/EaRA6rNu6WbkVK8BYcGNblkm57mZ83v9MEapHaZ/h0qPnUoNQXVqK/ltXdMUQABjY/X
 HcOyGkP3IAn5L966Iny/qviF3yC6ADAG7COTkkAgcEXeVCR94jtGSneu73VV9p4qsbktMkUUwwZ
 Yg+O+zILohjoWbw==
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

