Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D26C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CA30881A5;
	Thu, 28 Mar 2024 16:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711640084;
	bh=FwC1JtE9ApwacCNkX37BMZwO1WlJ7sEx1XwQc7CvXXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a022JNIYmJ5w/W/a07tr9Y1hoB91MRiqhJjBky1Z398jG6SQiWC7TpVp1wpLursoO
	 Mf/aDW6TtW7hVWlpHIkUj8Io33joE8cKjG5NxNT23D++qUkavX+Yez/1JP96AUt+ic
	 tozE5P1TE0c00GZyNxpx+w03wwNp89RrzVVKTM8qbXLbjp2ykWEs1AFfN88Ypytji7
	 6sy6O0L/xfULYug2vWdEJjwhq2QudHMoPuAUA1HqTRXvT739GkPAC0Ip0dnBmfgbVp
	 9AdiOlPt63ev89eGoQZm+vR8JnTic7vJhgKHEfgDsTkFf8yfkrrWciWs9SM0RrKjgw
	 RnNt3prk/I5CA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 17514881AB;
 Thu, 28 Mar 2024 16:34:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711640079;
 bh=FwC1JtE9ApwacCNkX37BMZwO1WlJ7sEx1XwQc7CvXXg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jAMRDphCb8eNkrcNDUFaEHZbxhebhIXgRI0dr17HxOXeo6IKYp1TGj4JtAsflaHDf
 pfq1PuYU3OW3Ns/NaRrmUoVbhKqD09Phm3jA7vOqJOGNoWQ0DbAVj/FTtMREuKiDBi
 iILqJc9KDk2DkzpVUaK3tzECoz2jnYV6tMHIHo+BvWWQruJtydLT0ir8xNrT5UdUcX
 QAwakFambxXMyaxnl0nkYlpXuYm+C2wW44nYTq0/Re4UwYK151KJ5yMJOL8gsTbsGK
 CL30p4UObKufNo7RQSCybpzXo1KQQdTODqCVAEhhQTh+XdvbFjBb7PP7XCQZH+1o7E
 RkE53qO3ecjVw==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] config: xea: Add limits for SPL and u-boot proper sizes
Date: Thu, 28 Mar 2024 16:34:15 +0100
Message-Id: <20240328153415.3706637-7-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328153415.3706637-1-lukma@denx.de>
References: <20240328153415.3706637-1-lukma@denx.de>
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

The XEA board has following hard constraints regarding size of binaries:
- u-boot.sb < 48 KiB
- u-boot.img < 448 KiB

Added values are supposed to avoid exceeding size of binaries during
future u-boot development.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---

 configs/imx28_xea_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 6098c1f3be..822a329187 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -21,12 +21,15 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x20000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SPL_SIZE_LIMIT=0xa000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x90000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_SPL_PAYLOAD="u-boot.img"
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=458752
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
 # CONFIG_BOOTMETH_EXTLINUX is not set
-- 
2.39.2

