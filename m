Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F18C87FD3
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 18:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCC288D0C;
	Thu, 29 Aug 2024 20:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qTOvTpi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 764C888C60; Thu, 29 Aug 2024 20:56:09 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2A388C67
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 20:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6b0c5b1adfaso9176657b3.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724957766; x=1725562566; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CZv4+ryWIzi9GrLmQdEJULP+JGXhYd12KQe2Vw6xGrk=;
 b=qTOvTpi4iyBzcYiWBFMJqSWCDjVs4A87lZYgzAGYNPbmA0SCc61Y0z12NXVljuWINj
 HHz10wnxEre3xSiKyy5WfvATCwH+smDMH87v+6C9VdvWRO494Fd/dPIlcP5EToDrWSOj
 azAEOy7ey7Iapyn+YDEKAtw0AyIzu5PaelARo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724957766; x=1725562566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZv4+ryWIzi9GrLmQdEJULP+JGXhYd12KQe2Vw6xGrk=;
 b=d23pPGqKKtuRL6Mf3WQx0goIz65gb9dFyzTSxLuhGN31YAN980ShXBoq5BXzHcnFdd
 uqSNvH589r5K3g8X16UXeCe/V5W6qKG0NH9LkV6Mai55Dg0u2hWoSxwo8wq2/9rskOo3
 ec94USjC3VYToknGpU2csJX++IN+Fayr3x+Uot868pFdrW71Fy9T+6XrD8BG/RuCbYM6
 57AHBo3GQhjtr1B4avNtOrQi04PRrXqXa8H5mAJ23sY97gB1s9XI0JpviWLqitWT0zYs
 GyuvtykZAdpCTFWtl3wx/kR0RiKCTJPliDp6K/WG3ODnwdLU+YcynDGcptHp5JuRCRDU
 Coig==
X-Gm-Message-State: AOJu0Yxlf84XCOq0/beJeMk//KQhtUJp39mHxjH24AANfffh3DnutOWi
 T5Hmwy7FqZgZcpTUWs1jk23MpjuUbeZfq6PSNjcJy6iul3yQCwgceyWXCN0ZgT4YF8sDIEw3/Ad
 T
X-Google-Smtp-Source: AGHT+IFFtRSIS7WJsCC9DC/6K8mvuThQxJzTlVK/AonhaH3U5RemJwKvaacZMpDW33Kl0iasTkB17w==
X-Received: by 2002:a05:690c:6204:b0:6bd:7eb:7192 with SMTP id
 00721157ae682-6d2765f2142mr46636497b3.25.1724957766125; 
 Thu, 29 Aug 2024 11:56:06 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340ca68b1sm7887866d6.111.2024.08.29.11.56.05
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 11:56:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [u-boot-test-hooks][PATCH 2/2] bin/flashair.rpi: Use kernel= and
 simplify logic
Date: Thu, 29 Aug 2024 12:56:02 -0600
Message-Id: <20240829185602.3179812-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829185602.3179812-1-trini@konsulko.com>
References: <20240829185602.3179812-1-trini@konsulko.com>
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

Rather than guess what we need to name our u-boot.bin file as for it to
boot make use of the kernel= option to always call it u-boot.bin and
then on 64bit platforms (and since future platforms use rpi_arm64 this
list should not grow) also pass in arm_64bit=1.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 bin/flashair.rpi | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/bin/flashair.rpi b/bin/flashair.rpi
index 874c41f76a07..2c2756c73087 100644
--- a/bin/flashair.rpi
+++ b/bin/flashair.rpi
@@ -27,34 +27,18 @@
 # ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 # POSSIBILITY OF SUCH DAMAGE.
 
-flashair_rmlist=`mktemp`
-
-case "${board_type}" in
-rpi)
-    kernel_dst=kernel.img
-    ;;
-rpi_2)
-    kernel_dst=kernel7.img
-    ;;
-rpi_3)
-    kernel_dst=kernel8.img
-    ;;
-rpi_3_32b)
-    kernel_dst=kernel8-32.img
-    ;;
-*)
-    echo Unknown Pi \""${board_type}"\"
-    exit 1
-    ;;
-esac
-
-echo 'kern*.img' > "${flashair_rmlist}"
-
-cp "${U_BOOT_BUILD_DIR}"/u-boot.bin "${UL_DIR}"/"${kernel_dst}"
+cp "${U_BOOT_BUILD_DIR}"/u-boot.bin "${UL_DIR}"/u-boot.bin
 
 touch "${UL_DIR}/config.txt"
 
 echo "enable_uart=1" >> "${UL_DIR}/config.txt"
+echo "kernel=u-boot.bin" >> "${UL_DIR}/config.txt"
+
+case "${board_type}" in
+rpi_3|rpi_3b|rpi_3_b_plus|rpi_4|rpi_arm64)
+    echo "arm_64bit=1" >> "${UL_DIR}/config.txt"
+    ;;
+esac
 
 case "${board_ident}" in
 3-32-pl011)
-- 
2.34.1

