Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2754C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 15:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C49587EB3;
	Tue, 27 Feb 2024 16:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 040EE87E92; Tue, 27 Feb 2024 16:40:19 +0100 (CET)
Received: from 8.mo561.mail-out.ovh.net (8.mo561.mail-out.ovh.net
 [87.98.172.249])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EADE87EE8
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 16:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.2.10])
 by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4TkhWc5mmPz1LRt
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 15:40:12 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-snnsd (unknown [10.110.113.248])
 by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 517FB1FEA3;
 Tue, 27 Feb 2024 15:40:12 +0000 (UTC)
Received: from armadeus.com ([37.59.142.95])
 by ghost-submission-6684bf9d7b-snnsd with ESMTPSA
 id 2Gz5EVwC3mVV3AAAJ0sS3Q
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Tue, 27 Feb 2024 15:40:12 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001b0f27694-9623-4730-8112-df64abaeaaa8,
 6291C1F48E860526C1A48BF1F3918837323A844E)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 2/2] video: mxsfb: add back imx6ul/imx6ull support
Date: Tue, 27 Feb 2024 16:40:02 +0100
Message-ID: <20240227154002.30257-2-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 170010887222520811
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhephfekteeugfeufefhkefhfeelteetffduffdvleeluddvveehgeejtdefhffggeefnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheeiuddpmhhouggvpehsmhhtphhouhht
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

Because of commit bf947d2a4b15 ("imx6ul: synchronise device tree with
linux"), the compatible property of lcdif in imx6ul.dtsi went from

compatible = "fsl,imx6ul-lcdif", "fsl,imx28-lcdif";

to

compatible = "fsl,imx6ul-lcdif", "fsl,imx6sx-lcdif";

without updating the mxsfb driver to match that change.

Add "fsl,imx6sx-lcdif" as a compatible id to fix that.

Fixes: bf947d2a4b15 ("imx6ul: synchronise device tree with linux")
Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 drivers/video/mxsfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 10433949bb80..515363f6a49b 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -387,6 +387,7 @@ static int mxs_video_remove(struct udevice *dev)
 static const struct udevice_id mxs_video_ids[] = {
 	{ .compatible = "fsl,imx23-lcdif" },
 	{ .compatible = "fsl,imx28-lcdif" },
+	{ .compatible = "fsl,imx6sx-lcdif" },
 	{ .compatible = "fsl,imx7ulp-lcdif" },
 	{ .compatible = "fsl,imxrt-lcdif" },
 	{ /* sentinel */ }
-- 
2.43.0

