Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77360C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8330A80EAF;
	Sun,  9 Feb 2025 22:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FNiW89Pl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEAC080EB5; Sun,  9 Feb 2025 22:16:17 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F003080EC0
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d0465a8d34so33405155ab.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135773; x=1739740573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tD9z0L6Pvp3TMKWJ1XhIzQXYCjOeUe5yQrZgMOyg1lQ=;
 b=FNiW89PlCgWKswDzv4gWAcBDIsHHQuw9u7vYLkkTt39fpVFwAYd1ZywKJqrQOsd9JV
 pmiHPzKGRhdnr2p1akAS1Iynn047818aemylgZEWu4BdCFuDfwTkgk2RiYGBTA4vqxXN
 vjJUxJ3WN4OO/qFcx5WtWzNHWYKxCLKF/4gBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135773; x=1739740573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tD9z0L6Pvp3TMKWJ1XhIzQXYCjOeUe5yQrZgMOyg1lQ=;
 b=WZAkxWwUbBTxM9HrJeV4b+TPDBsfdBi7+jJo7gl4Bpi5udPjX8LqZabhS+JC6j+mJq
 fei5m9SlZiMNGhahkZCtscMO728f7HWAM1WOXxZYwqO1f3PGBY4u+O+krqUod/9F1lbA
 Qp64+6YhBRc//dh7pzgDvNGnmEHoj6wBGQGXXLfDreVcHAutQSmzZaL/YDqPzBHaJ9Xx
 wXWnu8icrjcZE46LkdneVWdrwuur89Kj6Kxcst9V0gwA330pFtSbYPgcT3Cc84HZdLcN
 N08OoBWpwHjNRERwU1ABBfpGKpY40SpxOu3v/Rhp56d+Io2lIyoWTUoZQwZ++nosXh9g
 naFw==
X-Gm-Message-State: AOJu0YzyYJ3Jvr4ly0VuDrhimR0Ojz/bk1ACnN7KHEdHdIGYBnLfRNE8
 B2Yxs1SsezWTW8+596pVv858mTnSOg8gJFCU1XpD/aLLrUi54BJ5s4SL0uiilBFc10Fr/Owwww8
 =
X-Gm-Gg: ASbGnctU7kzcPHCtwX3Kr2phBKWB/I48ljgm1dqENUsD0FdH9L4VtcD296CTJ/swSGL
 5QeTzcmv/AJCCakE64eSgW5TEAB06CHz0DcwFZ3d7DzBwCHDXNW2c3aiYKpAS722mn7gpvmV8kj
 nCMevUz7+atiOwIalgF1L6gG9hFsJRco2ZAaKBy/n6xavy5nA2tnzsK4AkSq8EabYVFj/Uckpqk
 n9Bo346sJ4CyPuUM8MqVlr5zt25iNzkv3fG+6V/uLQf2N5Bxn9GuDWs107qMb7gZJOPFLRUphno
 kmPuZnzX+b3WjCjoi/iYu7vyCSte4gbA8XezxkyUcOCDjiT75xSX
X-Google-Smtp-Source: AGHT+IHtF43C3mxn7qq3m7Drir3SewwWRxOPXJufzpBrWWqdK9iEQdzFaDB652Wyy72ZTsNVDThVKw==
X-Received: by 2002:a05:6e02:b49:b0:3d0:4bce:cfa8 with SMTP id
 e9e14a558f8ab-3d13dd0a69amr93732005ab.3.1739135772389; 
 Sun, 09 Feb 2025 13:16:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 20/35] rockchip: Add a VPL image
Date: Sun,  9 Feb 2025 14:14:41 -0700
Message-ID: <20250209211502.2299245-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

The VPL image is immutable and has a single VPL binary plus a devicetree
for each board we need to support.

The devicetree is run through fdtgrep to remove unwanted nodes and
properties and reduce its size.

Changes in v2:
- Move VPL things into a separate file

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 91 +++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 325c15f9fef..a02f44d27d2 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -57,4 +57,95 @@
 			};
 		};
 	};
+
+	simple-bin {
+		vpl {
+			type = "fit";
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
+			description = "FIT image for U-Boot TPL";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+			fit,align = <512>;
+			fit,external-offset = <0>;
+			images {
+				image-vpl {
+					description = "U-Boot VPL";
+					type = "firmware";
+					os = "u-boot";
+					arch = ARCH;
+					compression = "lz4";
+					load = <CONFIG_VPL_TEXT_BASE>;
+					entry = <CONFIG_VPL_TEXT_BASE>;
+					section {
+						compress = "lz4";
+						u-boot-vpl-nodtb {
+							symbols-base = <0>;
+						};
+						u-boot-vpl-bss-pad {
+						};
+					};
+				};
+				@fdt-SEQ {
+					description = "fdt-NAME";
+					compression = "none";
+					type = "flat_dt";
+					fit,fdt-phase = "vpl";
+				};
+			};
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "NAME.dtb";
+					fdt = "fdt-SEQ";
+					fit,firmware = "image-vpl";
+					fit,loadables;
+					fit,compatible;
+				};
+			};
+		};
+# ifdef CONFIG_BOOTMETH_VBE_ABREC
+		vbe-a {
+			type = "section";
+			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			spl-a {
+				insert-template = <&spl_template>;
+				size = <0x100000>;
+			};
+
+			u-boot-a {
+				insert-template = <&common_part>;
+			};
+		};
+		vbe-b {
+			type = "section";
+			offset = <0x1000000>;
+			spl-b {
+				insert-template = <&spl_template>;
+				size = <0x100000>;
+			};
+
+			u-boot-b {
+				insert-template = <&common_part>;
+			};
+		};
+		vbe-recovery {
+			type = "section";
+			offset = <0x1800000>;
+			spl-recovery {
+				insert-template = <&spl_template>;
+				size = <0x100000>;
+			};
+
+			u-boot-recovery {
+				insert-template = <&common_part>;
+			};
+		};
+# else /* CONFIG_BOOTMETH_VBE_SIMPLE */
+		vbe {
+			type = "fit";
+			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			insert-template = <&common_part>;
+		};
+# endif /* VBE method */
+	};
 };
-- 
2.43.0

