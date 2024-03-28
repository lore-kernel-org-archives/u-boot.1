Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A3EC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CFBB88199;
	Thu, 28 Mar 2024 16:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711640077;
	bh=eDcK4T+9rPjh8AszrPcA21EiNFQzhYD7XW0h9LDhknM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZX8KcGHAWSDAHmY4+9utIy/PgeZ1+7UlRD95csnuYOKLsBoL97GLuyJ7ytpCoqpQD
	 JXoA/+tY/Y9pzxTzPR7SNlGdr5Ocr93S1u+iaBbV7XOk9zfk9W/YHVDhdUz8eKnZwd
	 uq8kkHFxND0zyigCFmgKr+I2/y7WmY5UNCxk/XUeZcOMKGLuEBj8RfCPtcRcDCwcWP
	 gWwCc+321Ds0ayR3Wxqf4s+lZbR5JaocS4fNllIDKHs37TRVrm+8ZanSk+8w8uzW4Q
	 Gp1CzW1fPWcZHziHRY43sQK//43fHi/Mcb40/u+QM9Kqgw/rUuBtp/p7pvGBM/6d+G
	 T3x77QUyHD7rA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 678DE88172;
 Thu, 28 Mar 2024 16:34:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711640076;
 bh=eDcK4T+9rPjh8AszrPcA21EiNFQzhYD7XW0h9LDhknM=;
 h=From:To:Cc:Subject:Date:From;
 b=Et+5PVJZcHTNGBAQXT/NTW25xpSzSAaClrmNekI0jeQekXvjIfwIkANRnhv0Afg3U
 UZRYDSz9BokacX7LjFCWgyn5iDWlf+VeGfFQefatezrDATGlEuE/EzPmI5/yQB5GOT
 3w5RbC/qM2Gn/Y4QmHPh8f6VBg43FWh+nq6Ot2RLsRRMqs7Jcq7beIcWqmPhetun1/
 9F5AYt8M/gbUwnbqCqonfIfHpKAOq76YX2yFMPZ0MELMcSvOpv3FYsEAVPbybpJYN3
 /02ij04Jk4hBaPYRJkXd5SsPG1hA+OCsvAwPaYB6jTVXZ/yAkwLdX/k3eDmBzmt2Gw
 dfskCe6XvekSA==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/6] arm: xea: Provide enhancements for XEA board
Date: Thu, 28 Mar 2024 16:34:09 +0100
Message-Id: <20240328153415.3706637-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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


This patch series is a preparatory patch for supporting
different versions of XEA board HW (until problem with
Linux kernel support for multiple revisions is resorted).

Moreover, limits for u-boot.sb and u-boot.img has been set
to avoid binary sizes exceeding in the future.


Lukasz Majewski (6):
  arm: spl: xea: Remove I2S pins configuration from early initialization
  arm: xea: Add support for reading SoM (CPU) and base board HW revision
  arm: spl: Add definition for PHY reset GPIO for XEA HW rev. 2
  config: xea: Enable late board initialization to set revision variable
  arm: xea: Print information about XEA's SoM HW revision
  config: xea: Add limits for SPL and u-boot proper sizes

 board/liebherr/xea/spl_xea.c   | 21 ++++++++------
 board/liebherr/xea/xea.c       | 50 ++++++++++++++++++++++++++++++++++
 configs/imx28_xea_defconfig    |  4 +++
 configs/imx28_xea_sb_defconfig |  1 +
 4 files changed, 68 insertions(+), 8 deletions(-)

-- 
2.39.2

