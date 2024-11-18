Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B898FD5E396
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF35689432;
	Mon, 18 Nov 2024 07:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911248;
	bh=3pjJB4jc0TpU9r2W5teCYV581lsSMzO7f3G1bRHs5t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MvEpGsvbn8ISsA6AWe0kyZZkeuBavwO8N0xGqAoiGt6F16G1SwvqWnJWefqxy+TM+
	 ae3cRUI9QJKPzCjB7mMYQ/bxhDHqz0zjppd4Jkunou8Kro6a8ysoDzujsk/71aemuj
	 omqgSRrFxz9kClK6aMizdJTb1Dby4Szh6hlUf/VEFD9kRQuZap/zH9u/R86lgPGRs9
	 UKdtFMiFIxklQupD2+jpRaB5AMFqInjNwk6FyYMTIszdGvP7H301dzDn6OpoePxcN0
	 VcPpQtkCkBHGy+a09oKqxRn/WD/bKtJ+3AYhlO6G0TRf4llEshjOcVbRS/4CXzogbB
	 xzjqDq19ZK4xQ==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BE56A89426;
 Mon, 18 Nov 2024 07:27:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911247;
 bh=3pjJB4jc0TpU9r2W5teCYV581lsSMzO7f3G1bRHs5t0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xbDpKT0ja++Bj4VJ6uWQnaAc2eDURdjglr1VdzzqaG+f5AIUxdCwqaibXcOsHwijo
 z9pETsT/4LqEJQzkRF++8e23O2hZ0LWLSVQEuLH6TuK5C4+ApC9iGntf5/UIgGC22B
 wOA2AULyVtu5T3wtnHaQccp4M2O2sIJvllQzfyQYrX8l/blF1C1JQENR24BKPvVaq1
 r7kM8sdiqwsWs7kHibNDvXpG9xXPaeoutWrExoUdcGBaIhhl/jzmpqEydJqaDIwtFn
 ESiuGAGrnNL+mCNGky7kdnK2wnSkz/XxsSezVxpl1gDuXSnnFiCpwQkfO8klWd3LpC
 JH0x+XZw55neQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Gary Bisson <bisson.gary@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/20] tools: imx8image: Improve error message
Date: Mon, 18 Nov 2024 07:26:57 +0100
Message-Id: <20241118062715.32989-4-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241118062715.32989-1-hs@denx.de>
References: <20241118062715.32989-1-hs@denx.de>
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

Improve error message "header tag mismatched"
Add filename to error message to see, which file
is wrong.

Signed-off-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

---

Changes in v2:
add Reviewed-by from Alexander

 tools/imx8image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx8image.c b/tools/imx8image.c
index 96ece28bd6c..b22e8b21c47 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -733,7 +733,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 			fclose(fd);
 
 			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched \n");
+				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
 				exit(EXIT_FAILURE);
 			} else {
 				file_off +=
-- 
2.20.1

