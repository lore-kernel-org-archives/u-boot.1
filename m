Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93862E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 12:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B557E8025C;
	Wed, 11 Dec 2024 13:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HgvK3rIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1AF88023A; Wed, 11 Dec 2024 13:20:50 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BF4080214
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 13:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so1068885966b.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 04:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733919648; x=1734524448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDYmb7xoQI0ORJu/89CRUYgX155ARGqx2YlBZZ38lRc=;
 b=HgvK3rIxl1xb4t8tX2rgaDTYp072yyBpQIQ6f7w2Wxq/lboneGph+doR2b8klSbj8N
 N6DicXU/y1/y8FfbLizGgN9vdnhzWLpcwmLuH647B0zdOjCW9BsXouVChRb3HjjFPQip
 G+KGxW1p65ZM5pSGWyE8Go9nTDGx/sB3mO2754NF1vWsQvuXeTTLobJbBG++lsHvsWgl
 cxx/qMwVxAGvsY9VV0BQfhUzPiKLwFyP7hUBRJHQ5B6N2gyZFoVwJyWi+8gcuiWcGYlI
 3cA38fgoA9XjGnXOtZXYiD3N0gczTR9EE4exvpdg9pNFHTrC06VlPwKCvBHwtydDSZN6
 l5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733919648; x=1734524448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDYmb7xoQI0ORJu/89CRUYgX155ARGqx2YlBZZ38lRc=;
 b=WZqG8G0GVOVvmkQUo9DwCEJyhRYdEZNmydlelG0+FUqw6gm+zYSC06UgCQrMj9iG2j
 bvuA3yurLP0YN0Au15Y67xxOZUi+AHNDE7eJ25xRq63BvWQ8lf/qp8H946rSoPTWPO/7
 6HiiIrDY7kEPQRZzCe6fRpF9n1rVPCZ6UtDg72Jj8rHSWBC88E+p/t/L0SDq3y1KW/yZ
 /OZPjl+m74pVHs+M9+/Os3rk5Rda/nspeFr/xqg/q+al3fRsJuypVQlEWo/zVi3j7YxC
 J7bNyXEyKL2Y9YvHI+06kAPHP1PKGF3/4pDUUDLHajag1Yk6FEr4Y0HS9yWFeleI60cx
 dk9w==
X-Gm-Message-State: AOJu0YwgjVyO40916Z1byGDSmTotYvKW2uBDIG+MoFlsk7JkQnHOyelq
 UWggaoWaXdXkGSxk6u8h1R5sNXi+4JcGWGfdTEp88g0+C7MSa/bH
X-Gm-Gg: ASbGncv9fERrlftQMVHh03zX04BdqVvtQewgdRWMxdoeBHd0D/JThhjC4dyhD7dNML1
 BWLzEE9CeHSJJ1efPbju18HZg6DDsS9ru+dHTe1ebGgIHD/Zqq/Osf+k0Ye8j41wcdG5cK2nVpW
 saK9xUQcJu3JGHgkYlJjbdOWHJK9Ayou/wxU1J/tf0kcQFiPg6f5IMbfVGngkBDAbOUhkBrjp4b
 deNMFnSe1BO0sYmiMBaUs0yvrgjjTCkCFZLZqyvJfEa7ftcPzYC3mXeJJrUQVv79q9KpF3u1pyk
 lQv/rWI3WF9wMbOsymWR3OGcAE6i
X-Google-Smtp-Source: AGHT+IH5YbiceidDjjgKvmXjWUvTZF0nRoFpvEr71xUgroVO1la8n5igJ/Yxodj7GdtSWSHxFL+PAw==
X-Received: by 2002:a17:906:3ca9:b0:aa6:1e9a:e45a with SMTP id
 a640c23a62f3a-aa6b1394688mr219944466b.46.1733919647722; 
 Wed, 11 Dec 2024 04:20:47 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6a23ad9c1sm256530266b.48.2024.12.11.04.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 04:20:47 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 francesco.dolcini@toradex.com, stefan.eichenberger@toradex.com,
 peng.fan@nxp.com, emanuele.ghidoli@toradex.com, joao.goncalves@toradex.com,
 vitor.soares@toradex.com, igor.opaniuk@foundries.io
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/5] toradex: tdx-cfg-block: increase indentation for
 longer defines
Date: Wed, 11 Dec 2024 13:18:52 +0100
Message-ID: <20241211122036.103383-3-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211122036.103383-1-eichest@gmail.com>
References: <20241211122036.103383-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Dec 2024 13:50:55 +0100
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

This preparation step ensures that the first column has sufficient space
to handle longer defines. This is necessary for the new Apalis iMX8
defines.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 178 +++++++++++++--------------
 1 file changed, 89 insertions(+), 89 deletions(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 4ef71c721f1..6508fe8108a 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -70,95 +70,95 @@ struct toradex_hw tdx_car_hw_tag;
 #define TARGET_IS_ENABLED(x) IS_ENABLED(CONFIG_TARGET_ ## x)
 
 const struct toradex_som toradex_modules[] = {
-	{ 0,                                 "UNKNOWN MODULE",                       0                                  },
-	{ COLIBRI_PXA270_V1_312MHZ,          "Colibri PXA270 312MHz",                0                                  },
-	{ COLIBRI_PXA270_V1_520MHZ,          "Colibri PXA270 520MHz",                0                                  },
-	{ COLIBRI_PXA320,                    "Colibri PXA320 806MHz",                0                                  },
-	{ COLIBRI_PXA300,                    "Colibri PXA300 208MHz",                0                                  },
-	{ COLIBRI_PXA310,                    "Colibri PXA310 624MHz",                0                                  },
-	{ COLIBRI_PXA320_IT,                 "Colibri PXA320IT 806MHz",              0                                  },
-	{ COLIBRI_PXA300_XT,                 "Colibri PXA300 208MHz XT",             0                                  },
-	{ COLIBRI_PXA270_312MHZ,             "Colibri PXA270 312MHz",                0                                  },
-	{ COLIBRI_PXA270_520MHZ,             "Colibri PXA270 520MHz",                0                                  },
-	{ COLIBRI_VF50,                      "Colibri VF50 128MB",                   TARGET_IS_ENABLED(COLIBRI_VF)      },
-	{ COLIBRI_VF61,                      "Colibri VF61 256MB",                   TARGET_IS_ENABLED(COLIBRI_VF)      },
-	{ COLIBRI_VF61_IT,                   "Colibri VF61 256MB IT",                TARGET_IS_ENABLED(COLIBRI_VF)      },
-	{ COLIBRI_VF50_IT,                   "Colibri VF50 128MB IT",                TARGET_IS_ENABLED(COLIBRI_VF)      },
-	{ COLIBRI_IMX6S,                     "Colibri iMX6S 256MB",                  TARGET_IS_ENABLED(COLIBRI_IMX6)    },
-	{ COLIBRI_IMX6DL,                    "Colibri iMX6DL 512MB",                 TARGET_IS_ENABLED(COLIBRI_IMX6)    },
-	{ COLIBRI_IMX6S_IT,                  "Colibri iMX6S 256MB IT",               TARGET_IS_ENABLED(COLIBRI_IMX6)    },
-	{ COLIBRI_IMX6DL_IT,                 "Colibri iMX6DL 512MB IT",              TARGET_IS_ENABLED(COLIBRI_IMX6)    },
-	{ COLIBRI_T20_256MB,                 "Colibri T20 256MB",                    TARGET_IS_ENABLED(COLIBRI_T20)     },
-	{ COLIBRI_T20_512MB,                 "Colibri T20 512MB",                    TARGET_IS_ENABLED(COLIBRI_T20)     },
-	{ COLIBRI_T20_512MB_IT,              "Colibri T20 512MB IT",                 TARGET_IS_ENABLED(COLIBRI_T20)     },
-	{ COLIBRI_T30,                       "Colibri T30 1GB",                      TARGET_IS_ENABLED(COLIBRI_T30)     },
-	{ COLIBRI_T20_256MB_IT,              "Colibri T20 256MB IT",                 TARGET_IS_ENABLED(COLIBRI_T20)     },
-	{ APALIS_T30_2GB,                    "Apalis T30 2GB",                       TARGET_IS_ENABLED(APALIS_T30)      },
-	{ APALIS_T30_1GB,                    "Apalis T30 1GB",                       TARGET_IS_ENABLED(APALIS_T30)      },
-	{ APALIS_IMX6Q,                      "Apalis iMX6Q 1GB",                     TARGET_IS_ENABLED(APALIS_IMX6)     },
-	{ APALIS_IMX6Q_IT,                   "Apalis iMX6Q 2GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
-	{ APALIS_IMX6D,                      "Apalis iMX6D 512MB",                   TARGET_IS_ENABLED(APALIS_IMX6)     },
-	{ COLIBRI_T30_IT,                    "Colibri T30 1GB IT",                   TARGET_IS_ENABLED(COLIBRI_T30)     },
-	{ APALIS_T30_IT,                     "Apalis T30 1GB IT",                    TARGET_IS_ENABLED(APALIS_T30)      },
-	{ COLIBRI_IMX7S,                     "Colibri iMX7S 256MB",                  TARGET_IS_ENABLED(COLIBRI_IMX7)    },
-	{ COLIBRI_IMX7D,                     "Colibri iMX7D 512MB",                  TARGET_IS_ENABLED(COLIBRI_IMX7)    },
-	{ APALIS_TK1_2GB,                    "Apalis TK1 2GB",                       TARGET_IS_ENABLED(APALIS_TK1)      },
-	{ APALIS_IMX6D_IT,                   "Apalis iMX6D 1GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
-	{ COLIBRI_IMX6ULL,                   "Colibri iMX6ULL 256MB",                TARGET_IS_ENABLED(COLIBRI_IMX6ULL) },
-	{ APALIS_IMX8QM_WIFI_BT_IT,          "Apalis iMX8QM 4GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)     },
-	{ COLIBRI_IMX8QXP_WIFI_BT_IT,        "Colibri iMX8QXP 2GB WB IT",            TARGET_IS_ENABLED(COLIBRI_IMX8X)   },
-	{ COLIBRI_IMX7D_EMMC,                "Colibri iMX7D 1GB",                    TARGET_IS_ENABLED(COLIBRI_IMX7)    },
-	{ COLIBRI_IMX6ULL_WIFI_BT_IT,        "Colibri iMX6ULL 512MB WB IT",          TARGET_IS_ENABLED(COLIBRI_IMX6ULL) },
-	{ COLIBRI_IMX7D_EPDC,                "Colibri iMX7D 512MB EPDC",             TARGET_IS_ENABLED(COLIBRI_IMX7)    },
-	{ APALIS_TK1_4GB,                    "Apalis TK1 4GB",                       TARGET_IS_ENABLED(APALIS_TK1)      },
-	{ COLIBRI_T20_512MB_IT_SETEK,        "Colibri T20 512MB IT SETEK",           TARGET_IS_ENABLED(COLIBRI_T20)     },
-	{ COLIBRI_IMX6ULL_IT,                "Colibri iMX6ULL 512MB IT",             TARGET_IS_ENABLED(COLIBRI_IMX6ULL) },
-	{ COLIBRI_IMX6ULL_WIFI_BT,           "Colibri iMX6ULL 512MB WB",             TARGET_IS_ENABLED(COLIBRI_IMX6ULL) },
-	{ APALIS_IMX8QXP_WIFI_BT_IT,         "Apalis iMX8QXP 2GB WB IT",             0                                  },
-	{ APALIS_IMX8QM_IT,                  "Apalis iMX8QM 4GB IT",                 TARGET_IS_ENABLED(APALIS_IMX8)     },
-	{ APALIS_IMX8QP_WIFI_BT,             "Apalis iMX8QP 2GB WB",                 TARGET_IS_ENABLED(APALIS_IMX8)     },
-	{ APALIS_IMX8QP,                     "Apalis iMX8QP 2GB",                    TARGET_IS_ENABLED(APALIS_IMX8)     },
-	{ COLIBRI_IMX8QXP_IT,                "Colibri iMX8QXP 2GB IT",               TARGET_IS_ENABLED(COLIBRI_IMX8X)   },
-	{ COLIBRI_IMX8DX_WIFI_BT,            "Colibri iMX8DX 1GB WB",                TARGET_IS_ENABLED(COLIBRI_IMX8X)   },
-	{ COLIBRI_IMX8DX,                    "Colibri iMX8DX 1GB",                   TARGET_IS_ENABLED(COLIBRI_IMX8X)   },
-	{ APALIS_IMX8QXP,                    "Apalis iMX8QXP 2GB ECC IT",            0                                  },
-	{ APALIS_IMX8DXP,                    "Apalis iMX8DXP 1GB",                   0                                  },
-	{ VERDIN_IMX8MMQ_WIFI_BT_IT,         "Verdin iMX8M Mini Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
-	{ VERDIN_IMX8MNQ_WIFI_BT,            "Verdin iMX8M Nano Quad 1GB WB",        0                                  },
-	{ VERDIN_IMX8MMDL,                   "Verdin iMX8M Mini DualLite 1GB",       TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
-	{ VERDIN_IMX8MPQ_WIFI_BT_IT,         "Verdin iMX8M Plus Quad 4GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
-	{ VERDIN_IMX8MMQ_IT,                 "Verdin iMX8M Mini Quad 2GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
-	{ VERDIN_IMX8MMDL_WIFI_BT_IT,        "Verdin iMX8M Mini DualLite 1GB WB IT", TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
-	{ VERDIN_IMX8MPQ,                    "Verdin iMX8M Plus Quad 2GB",           TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
-	{ COLIBRI_IMX6ULL_IT_EMMC,           "Colibri iMX6ULL 1GB IT",               TARGET_IS_ENABLED(COLIBRI_IMX6ULL) },
-	{ VERDIN_IMX8MPQ_IT,                 "Verdin iMX8M Plus Quad 4GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
-	{ VERDIN_IMX8MPQ_2GB_WIFI_BT_IT,     "Verdin iMX8M Plus Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
-	{ VERDIN_IMX8MPQL_IT,                "Verdin iMX8M Plus QuadLite 1GB IT",    TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
-	{ VERDIN_IMX8MPQ_8GB_WIFI_BT,        "Verdin iMX8M Plus Quad 8GB WB",        TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
-	{ APALIS_IMX8QM_8GB_WIFI_BT_IT,      "Apalis iMX8QM 8GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)     },
-	{ VERDIN_IMX8MMQ_WIFI_BT_IT_NO_CAN,  "Verdin iMX8M Mini Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
-	{ VERDIN_AM62Q_WIFI_BT_IT,           "Verdin AM62 Quad 1GB WB IT",           TARGET_IS_ENABLED(VERDIN_AM62_A53) },
-	{ VERDIN_IMX8MPQ_8GB_WIFI_BT_IT,     "Verdin iMX8M Plus Quad 8GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
-	{ VERDIN_AM62S_512MB,                "Verdin AM62 Solo 512MB",               TARGET_IS_ENABLED(VERDIN_AM62_A53) },
-	{ VERDIN_AM62S_512MB_WIFI_BT_IT,     "Verdin AM62 Solo 512MB WB IT",         TARGET_IS_ENABLED(VERDIN_AM62_A53) },
-	{ VERDIN_AM62D_1G_ET,                "Verdin AM62 Dual 1GB ET",              TARGET_IS_ENABLED(VERDIN_AM62_A53) },
-	{ VERDIN_AM62D_1G_IT,                "Verdin AM62 Dual 1GB IT",              TARGET_IS_ENABLED(VERDIN_AM62_A53) },
-	{ VERDIN_AM62D_1G_WIFI_BT_IT,        "Verdin AM62 Dual 1GB WB IT",           TARGET_IS_ENABLED(VERDIN_AM62_A53) },
-	{ VERDIN_AM62Q_2G_WIFI_BT_IT,        "Verdin AM62 Quad 2GB WB IT",           TARGET_IS_ENABLED(VERDIN_AM62_A53) },
-	{ COLIBRI_IMX6S_NOWINCE,             "Colibri iMX6S 256MB",                  TARGET_IS_ENABLED(COLIBRI_IMX6)    },
-	{ COLIBRI_IMX6S_IT_NOWINCE,          "Colibri iMX6S 256MB IT",               TARGET_IS_ENABLED(COLIBRI_IMX6)    },
-	{ COLIBRI_IMX6DL_NOWINCE,            "Colibri iMX6DL 512MB",                 TARGET_IS_ENABLED(COLIBRI_IMX6)    },
-	{ COLIBRI_IMX6DL_IT_NOWINCE,         "Colibri iMX6DL 512MB IT",              TARGET_IS_ENABLED(COLIBRI_IMX6)    },
-	{ COLIBRI_IMX7D_NOWINCE,             "Colibri iMX7D 512MB",                  TARGET_IS_ENABLED(COLIBRI_IMX7)    },
-	{ APALIS_IMX6D_NOWINCE,              "Apalis iMX6D 512MB",                   TARGET_IS_ENABLED(APALIS_IMX6)     },
-	{ APALIS_IMX6Q_NOWINCE,              "Apalis iMX6Q 1GB",                     TARGET_IS_ENABLED(APALIS_IMX6)     },
-	{ APALIS_IMX6D_IT_NOWINCE,           "Apalis iMX6D 1GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
-	{ APALIS_IMX6Q_IT_NOWINCE,           "Apalis iMX6Q 2GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
-	{ VERDIN_IMX8MMDL_2G_IT,             "Verdin iMX8M Mini DualLite 2GB IT",    TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
-	{ VERDIN_IMX8MMQ_2G_IT_NO_CAN,       "Verdin iMX8M Mini Quad 2GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
-	{ AQUILA_AM69O_32G_WIFI_BT_IT,       "Aquila AM69 Octa 32GB WB IT",          TARGET_IS_ENABLED(AQUILA_AM69_A72) },
-	{ VERDIN_IMX95H_16G_WIFI_BT_IT,      "Verdin iMX95 Hexa 16GB WB IT",         TARGET_IS_ENABLED(VERDIN_IMX95)    },
-	{ VERDIN_IMX8MMQ_4G_WIFI_BT_ET,      "Verdin iMX8M Mini Quad 4GB WB ET",     TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
+	{ 0,                                     "UNKNOWN MODULE",                       0                                  },
+	{ COLIBRI_PXA270_V1_312MHZ,              "Colibri PXA270 312MHz",                0                                  },
+	{ COLIBRI_PXA270_V1_520MHZ,              "Colibri PXA270 520MHz",                0                                  },
+	{ COLIBRI_PXA320,                        "Colibri PXA320 806MHz",                0                                  },
+	{ COLIBRI_PXA300,                        "Colibri PXA300 208MHz",                0                                  },
+	{ COLIBRI_PXA310,                        "Colibri PXA310 624MHz",                0                                  },
+	{ COLIBRI_PXA320_IT,                     "Colibri PXA320IT 806MHz",              0                                  },
+	{ COLIBRI_PXA300_XT,                     "Colibri PXA300 208MHz XT",             0                                  },
+	{ COLIBRI_PXA270_312MHZ,                 "Colibri PXA270 312MHz",                0                                  },
+	{ COLIBRI_PXA270_520MHZ,                 "Colibri PXA270 520MHz",                0                                  },
+	{ COLIBRI_VF50,                          "Colibri VF50 128MB",                   TARGET_IS_ENABLED(COLIBRI_VF)      },
+	{ COLIBRI_VF61,                          "Colibri VF61 256MB",                   TARGET_IS_ENABLED(COLIBRI_VF)      },
+	{ COLIBRI_VF61_IT,                       "Colibri VF61 256MB IT",                TARGET_IS_ENABLED(COLIBRI_VF)      },
+	{ COLIBRI_VF50_IT,                       "Colibri VF50 128MB IT",                TARGET_IS_ENABLED(COLIBRI_VF)      },
+	{ COLIBRI_IMX6S,                         "Colibri iMX6S 256MB",                  TARGET_IS_ENABLED(COLIBRI_IMX6)    },
+	{ COLIBRI_IMX6DL,                        "Colibri iMX6DL 512MB",                 TARGET_IS_ENABLED(COLIBRI_IMX6)    },
+	{ COLIBRI_IMX6S_IT,                      "Colibri iMX6S 256MB IT",               TARGET_IS_ENABLED(COLIBRI_IMX6)    },
+	{ COLIBRI_IMX6DL_IT,                     "Colibri iMX6DL 512MB IT",              TARGET_IS_ENABLED(COLIBRI_IMX6)    },
+	{ COLIBRI_T20_256MB,                     "Colibri T20 256MB",                    TARGET_IS_ENABLED(COLIBRI_T20)     },
+	{ COLIBRI_T20_512MB,                     "Colibri T20 512MB",                    TARGET_IS_ENABLED(COLIBRI_T20)     },
+	{ COLIBRI_T20_512MB_IT,                  "Colibri T20 512MB IT",                 TARGET_IS_ENABLED(COLIBRI_T20)     },
+	{ COLIBRI_T30,                           "Colibri T30 1GB",                      TARGET_IS_ENABLED(COLIBRI_T30)     },
+	{ COLIBRI_T20_256MB_IT,                  "Colibri T20 256MB IT",                 TARGET_IS_ENABLED(COLIBRI_T20)     },
+	{ APALIS_T30_2GB,                        "Apalis T30 2GB",                       TARGET_IS_ENABLED(APALIS_T30)      },
+	{ APALIS_T30_1GB,                        "Apalis T30 1GB",                       TARGET_IS_ENABLED(APALIS_T30)      },
+	{ APALIS_IMX6Q,                          "Apalis iMX6Q 1GB",                     TARGET_IS_ENABLED(APALIS_IMX6)     },
+	{ APALIS_IMX6Q_IT,                       "Apalis iMX6Q 2GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
+	{ APALIS_IMX6D,                          "Apalis iMX6D 512MB",                   TARGET_IS_ENABLED(APALIS_IMX6)     },
+	{ COLIBRI_T30_IT,                        "Colibri T30 1GB IT",                   TARGET_IS_ENABLED(COLIBRI_T30)     },
+	{ APALIS_T30_IT,                         "Apalis T30 1GB IT",                    TARGET_IS_ENABLED(APALIS_T30)      },
+	{ COLIBRI_IMX7S,                         "Colibri iMX7S 256MB",                  TARGET_IS_ENABLED(COLIBRI_IMX7)    },
+	{ COLIBRI_IMX7D,                         "Colibri iMX7D 512MB",                  TARGET_IS_ENABLED(COLIBRI_IMX7)    },
+	{ APALIS_TK1_2GB,                        "Apalis TK1 2GB",                       TARGET_IS_ENABLED(APALIS_TK1)      },
+	{ APALIS_IMX6D_IT,                       "Apalis iMX6D 1GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
+	{ COLIBRI_IMX6ULL,                       "Colibri iMX6ULL 256MB",                TARGET_IS_ENABLED(COLIBRI_IMX6ULL) },
+	{ APALIS_IMX8QM_WIFI_BT_IT,              "Apalis iMX8QM 4GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)     },
+	{ COLIBRI_IMX8QXP_WIFI_BT_IT,            "Colibri iMX8QXP 2GB WB IT",            TARGET_IS_ENABLED(COLIBRI_IMX8X)   },
+	{ COLIBRI_IMX7D_EMMC,                    "Colibri iMX7D 1GB",                    TARGET_IS_ENABLED(COLIBRI_IMX7)    },
+	{ COLIBRI_IMX6ULL_WIFI_BT_IT,            "Colibri iMX6ULL 512MB WB IT",          TARGET_IS_ENABLED(COLIBRI_IMX6ULL) },
+	{ COLIBRI_IMX7D_EPDC,                    "Colibri iMX7D 512MB EPDC",             TARGET_IS_ENABLED(COLIBRI_IMX7)    },
+	{ APALIS_TK1_4GB,                        "Apalis TK1 4GB",                       TARGET_IS_ENABLED(APALIS_TK1)      },
+	{ COLIBRI_T20_512MB_IT_SETEK,            "Colibri T20 512MB IT SETEK",           TARGET_IS_ENABLED(COLIBRI_T20)     },
+	{ COLIBRI_IMX6ULL_IT,                    "Colibri iMX6ULL 512MB IT",             TARGET_IS_ENABLED(COLIBRI_IMX6ULL) },
+	{ COLIBRI_IMX6ULL_WIFI_BT,               "Colibri iMX6ULL 512MB WB",             TARGET_IS_ENABLED(COLIBRI_IMX6ULL) },
+	{ APALIS_IMX8QXP_WIFI_BT_IT,             "Apalis iMX8QXP 2GB WB IT",             0                                  },
+	{ APALIS_IMX8QM_IT,                      "Apalis iMX8QM 4GB IT",                 TARGET_IS_ENABLED(APALIS_IMX8)     },
+	{ APALIS_IMX8QP_WIFI_BT,                 "Apalis iMX8QP 2GB WB",                 TARGET_IS_ENABLED(APALIS_IMX8)     },
+	{ APALIS_IMX8QP,                         "Apalis iMX8QP 2GB",                    TARGET_IS_ENABLED(APALIS_IMX8)     },
+	{ COLIBRI_IMX8QXP_IT,                    "Colibri iMX8QXP 2GB IT",               TARGET_IS_ENABLED(COLIBRI_IMX8X)   },
+	{ COLIBRI_IMX8DX_WIFI_BT,                "Colibri iMX8DX 1GB WB",                TARGET_IS_ENABLED(COLIBRI_IMX8X)   },
+	{ COLIBRI_IMX8DX,                        "Colibri iMX8DX 1GB",                   TARGET_IS_ENABLED(COLIBRI_IMX8X)   },
+	{ APALIS_IMX8QXP,                        "Apalis iMX8QXP 2GB ECC IT",            0                                  },
+	{ APALIS_IMX8DXP,                        "Apalis iMX8DXP 1GB",                   0                                  },
+	{ VERDIN_IMX8MMQ_WIFI_BT_IT,             "Verdin iMX8M Mini Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
+	{ VERDIN_IMX8MNQ_WIFI_BT,                "Verdin iMX8M Nano Quad 1GB WB",        0                                  },
+	{ VERDIN_IMX8MMDL,                       "Verdin iMX8M Mini DualLite 1GB",       TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
+	{ VERDIN_IMX8MPQ_WIFI_BT_IT,             "Verdin iMX8M Plus Quad 4GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
+	{ VERDIN_IMX8MMQ_IT,                     "Verdin iMX8M Mini Quad 2GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
+	{ VERDIN_IMX8MMDL_WIFI_BT_IT,            "Verdin iMX8M Mini DualLite 1GB WB IT", TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
+	{ VERDIN_IMX8MPQ,                        "Verdin iMX8M Plus Quad 2GB",           TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
+	{ COLIBRI_IMX6ULL_IT_EMMC,               "Colibri iMX6ULL 1GB IT",               TARGET_IS_ENABLED(COLIBRI_IMX6ULL) },
+	{ VERDIN_IMX8MPQ_IT,                     "Verdin iMX8M Plus Quad 4GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
+	{ VERDIN_IMX8MPQ_2GB_WIFI_BT_IT,         "Verdin iMX8M Plus Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
+	{ VERDIN_IMX8MPQL_IT,                    "Verdin iMX8M Plus QuadLite 1GB IT",    TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
+	{ VERDIN_IMX8MPQ_8GB_WIFI_BT,            "Verdin iMX8M Plus Quad 8GB WB",        TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
+	{ APALIS_IMX8QM_8GB_WIFI_BT_IT,          "Apalis iMX8QM 8GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)     },
+	{ VERDIN_IMX8MMQ_WIFI_BT_IT_NO_CAN,      "Verdin iMX8M Mini Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
+	{ VERDIN_AM62Q_WIFI_BT_IT,               "Verdin AM62 Quad 1GB WB IT",           TARGET_IS_ENABLED(VERDIN_AM62_A53) },
+	{ VERDIN_IMX8MPQ_8GB_WIFI_BT_IT,         "Verdin iMX8M Plus Quad 8GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)   },
+	{ VERDIN_AM62S_512MB,                    "Verdin AM62 Solo 512MB",               TARGET_IS_ENABLED(VERDIN_AM62_A53) },
+	{ VERDIN_AM62S_512MB_WIFI_BT_IT,         "Verdin AM62 Solo 512MB WB IT",         TARGET_IS_ENABLED(VERDIN_AM62_A53) },
+	{ VERDIN_AM62D_1G_ET,                    "Verdin AM62 Dual 1GB ET",              TARGET_IS_ENABLED(VERDIN_AM62_A53) },
+	{ VERDIN_AM62D_1G_IT,                    "Verdin AM62 Dual 1GB IT",              TARGET_IS_ENABLED(VERDIN_AM62_A53) },
+	{ VERDIN_AM62D_1G_WIFI_BT_IT,            "Verdin AM62 Dual 1GB WB IT",           TARGET_IS_ENABLED(VERDIN_AM62_A53) },
+	{ VERDIN_AM62Q_2G_WIFI_BT_IT,            "Verdin AM62 Quad 2GB WB IT",           TARGET_IS_ENABLED(VERDIN_AM62_A53) },
+	{ COLIBRI_IMX6S_NOWINCE,                 "Colibri iMX6S 256MB",                  TARGET_IS_ENABLED(COLIBRI_IMX6)    },
+	{ COLIBRI_IMX6S_IT_NOWINCE,              "Colibri iMX6S 256MB IT",               TARGET_IS_ENABLED(COLIBRI_IMX6)    },
+	{ COLIBRI_IMX6DL_NOWINCE,                "Colibri iMX6DL 512MB",                 TARGET_IS_ENABLED(COLIBRI_IMX6)    },
+	{ COLIBRI_IMX6DL_IT_NOWINCE,             "Colibri iMX6DL 512MB IT",              TARGET_IS_ENABLED(COLIBRI_IMX6)    },
+	{ COLIBRI_IMX7D_NOWINCE,                 "Colibri iMX7D 512MB",                  TARGET_IS_ENABLED(COLIBRI_IMX7)    },
+	{ APALIS_IMX6D_NOWINCE,                  "Apalis iMX6D 512MB",                   TARGET_IS_ENABLED(APALIS_IMX6)     },
+	{ APALIS_IMX6Q_NOWINCE,                  "Apalis iMX6Q 1GB",                     TARGET_IS_ENABLED(APALIS_IMX6)     },
+	{ APALIS_IMX6D_IT_NOWINCE,               "Apalis iMX6D 1GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
+	{ APALIS_IMX6Q_IT_NOWINCE,               "Apalis iMX6Q 2GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
+	{ VERDIN_IMX8MMDL_2G_IT,                 "Verdin iMX8M Mini DualLite 2GB IT",    TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
+	{ VERDIN_IMX8MMQ_2G_IT_NO_CAN,           "Verdin iMX8M Mini Quad 2GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
+	{ AQUILA_AM69O_32G_WIFI_BT_IT,           "Aquila AM69 Octa 32GB WB IT",          TARGET_IS_ENABLED(AQUILA_AM69_A72) },
+	{ VERDIN_IMX95H_16G_WIFI_BT_IT,          "Verdin iMX95 Hexa 16GB WB IT",         TARGET_IS_ENABLED(VERDIN_IMX95)    },
+	{ VERDIN_IMX8MMQ_4G_WIFI_BT_ET,          "Verdin iMX8M Mini Quad 4GB WB ET",     TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 };
 
 struct pid4list {
-- 
2.45.2

