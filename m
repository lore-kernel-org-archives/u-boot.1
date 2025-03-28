Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37E4C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40CFF81F4E;
	Fri, 28 Mar 2025 16:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lDT+Wohy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D788081E60; Fri, 28 Mar 2025 16:36:11 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B3481ED8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85b41281b50so65188439f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176167; x=1743780967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wV09Zh2HJ1La6dOzn/VBBjZdNd/uEMUrQLj2gJMw+A8=;
 b=lDT+Wohy7drAp5i7nogyE0r+sq57upLYL/svSkkrG8TK4hbTfrLW2JEILfIHGTbO6V
 LsROYNg6r0VGMWDcxjwvwJ+kA/CMCCuDICjNe2WqEnNhF44tnFosNEDYx61SyRxJi/SC
 3cq3U7tznoTYkRXc1SZ+Of8vzDJmrlkEeR020=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176167; x=1743780967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wV09Zh2HJ1La6dOzn/VBBjZdNd/uEMUrQLj2gJMw+A8=;
 b=eV23lXJ/DP1O8Quau1x3d+jvEu9QIGMgiYLJ1fKhrgJfzdYjjoFtMoJ7RQJIJ+FPLA
 D5mutyVBnC5ECqK5vs77bBb7blUHoXf+iZu+0KuI5srizgG78fpDsxvWspuUinyRO9o8
 Ol7PKVV8ofIVCQTlxV+u8ubu0SP007KhtE1gWaS8qaDALKX+6G8Spw3DpJEWPtN7t/G8
 BbPPnaBRWx2/qJI7Kl9swz6UCkTvhSsP49aDuTxTl8jMEkaIHNj28evsLeFqQGP1/AeJ
 TM9dzemE3VQHVzrdsGwT7wCX3vHa9Mxiofowk13PVp8e0p2Mxa0AqvZPWs0q5BfJoODZ
 y3zA==
X-Gm-Message-State: AOJu0Yz7UwhyNYdXgIrSGU88Gg1LzMEUg39cQRtNpxLuzKOeP55KBnhW
 XvAbp49pCl2hjCkY+aFooLGgHmxxXU34h69Ee1yt6sX/QF3PL6MaBAy0p23tDw/ZdeYA1EDykPo
 =
X-Gm-Gg: ASbGnctNw0XN0VPcsm8tR3t2XQmL9cWt9qtqkV85s2zJ4Ou0cQOxpIen4Kkkz1qZVok
 2ToeJ6MBMiXQFL4m9+rKABRW7cQhC2sP0P9s/l76xcE6fFIfGrbs/5kYG9j+TPLVSrfpS629T82
 5xriscsxKdS5jVeCUN2642HDquv+cC5E5c6mQ3b39ZVi3noplwTEx12sbrsSS7/IJhi3Jp8OknH
 3xBuiA+iLZVpQao09+3cqChf6i9Cs6TbNBav52oWi+rEmdHWZ+KcdJhxO+o+yQJHYbR7jOGjjpF
 Hqdgkc2vs5N3wJUlo/Mmh6pP0RbQX/rWaBAOJ5kpWhWFgWK+W8HFByJ6Wr3shuoN2LTwZZvOvmM
 bgaqtJw==
X-Google-Smtp-Source: AGHT+IGUN0jhDuBqHtz2DFMexTPjaXXS4jwNShN3GCKj65p+vnju2vfLhbCUxuTPN+HeOk+oR2DO8A==
X-Received: by 2002:a05:6602:b90:b0:85e:2eba:20ad with SMTP id
 ca18e2360f4ac-85e82045b3amr949268239f.2.1743176166813; 
 Fri, 28 Mar 2025 08:36:06 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 13/31] rockchip: Add SPL into the main FIT
Date: Fri, 28 Mar 2025 09:34:53 -0600
Message-ID: <20250328153522.3555472-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

VBE may want to load the SPL image from the same FIT as contains U-Boot,
if there is enough memory, so add it.

Changes in v2:
- Move VPL things into a separate file

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 475dbc53796..b3759b88db5 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -38,3 +38,32 @@
 		};
 	};
 };
+
+&binman {
+	template-1 {
+		images {
+			spl {
+				description = "U-Boot SPL";
+				type = "firmware";
+				os = "u-boot";
+				arch = ARCH;
+				compression = "lz4";
+				load = <CONFIG_SPL_TEXT_BASE>;
+				entry = <CONFIG_SPL_TEXT_BASE>;
+				phase = "spl";
+				section {
+					compress = "lz4";
+					u-boot-spl-nodtb {
+					};
+					u-boot-spl-bss-pad {
+					};
+				};
+			};
+		};
+		configurations {
+			@config-SEQ {
+				fit,firmware = "atf-1", "u-boot", "spl";
+			};
+		};
+	};
+};
-- 
2.43.0

