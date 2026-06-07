Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776C5CD8C89
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B076847B0;
	Sun,  7 Jun 2026 21:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="byzRiuhf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5417846A3; Sun,  7 Jun 2026 17:46:10 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66ADE846C3
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DD8F600BB;
 Sun,  7 Jun 2026 15:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32DFAC4AF10;
 Sun,  7 Jun 2026 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780847165;
 bh=Zwn7G7pC9YhoADb3OBYiel29QOqNm4BoiPDJjnajRqs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=byzRiuhfkEsNTEigpq5KkRZNBCuxPHc0lCLcUX2Gr1Sh+Y+eOwENBlnbXIILF1A2D
 FGq1kBE8tz5A8hePWpZVMbz9HqLNeB8y9Sy+XFfKddUy0LYCv3FG+bb2sRbNHOEtjY
 Y14nZbsa57gWWw4T/8gQ8/vjPiQu0ReeXNNh5sRdQp2nruEQ396ZgFilhvvOg/Y68z
 yInPQxfzNGi2P7Z6teklalsMY0+b+yqInE6zthrWYtSMMRS40xFxpSDAPEFNj302Uc
 9oRTHYC6OpMEu+0WC0igAAnUZz8UQifEjFaFBgp4CTi0V0joU4vUsoKcAzFIOq7ddi
 SggtzXv665XVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2B08ACD8C8E;
 Sun,  7 Jun 2026 15:46:05 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Sun, 07 Jun 2026 18:45:35 +0300
Subject: [PATCH v2 5/5] MAINTAINERS: Add myself to the list of UFS maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-ufs_tool2-v2-5-f79ff26ab18c@mobileye.com>
References: <20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com>
In-Reply-To: <20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Julien Stephan <jstephan@baylibre.com>, 
 Udit Kumar <u-kumar1@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 briansune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=610;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=Evo/xayXeA+xDd8mrRtcOpcBO0hiTU23xBCrmgriIpk=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqJZI6hPmU96e5xjH2wDhD4ovRC0jp0prVLpd9x
 TZo46BAlayJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiWSOgAKCRCfmumUluiO
 OZ0FD/9/p1oUL5EWmY++j+5OvAgtOfm33qZ7F1Mpn9dQwuP9S+FRJ9u+2JrO0y2En1qsHbqzZNx
 hJ8JhVoR3RxmwdSZIlKeJAZYqn1f+Gy7uidCDun/971Ta8aJfWiQrbRCjlHtGJlTG3W80DbKFAZ
 0rpKVs6ZXs4XB73bZhkdq7MDnz5+68ih+jOVbbcr6N9KP/5gZAfRELWQFfi6qgYtYoYONaeQS8U
 5MOXi2GoedgNos9rFD+e/VVFkFx9G1yoS/h66iea++ur0bSiVC9gWfH17R8lv8GQDBlLg3ZSq/l
 he6eCQHUW7FXdl0gzjVoVVSe3/Cz1A4yUFLPnDlBVjjhl67VHWtsH3yKf582frNPtsF0jFws7TV
 WkgYCfMAGbs6O0L3tnL4HaWJWObddIeDsLCjMYKbOoncyrI/1mcX8ZSXZzWo3QIVFy6cqiHkDpg
 AVfqYtZEORnx8OxxaQdelIAHZBk2XDxZ3et1zVv7l0zAv6aHRNkgsWIlEwWKl+l9o/Zd8SNAhXW
 FFPpDscOD8Awi/MWalf4Wi1CAGqOind2QEIE9IoKUym7Gh6tVZG8fcIZnzt8yL0yMYqDdA5Y0GS
 1HNNCBFfkk2iPQeJKvb5kEz8/JuU6LdJOtI2KeHG5N2Cn7rgj/Aspw2zgHixyr4G0a1CbOsl8tM
 ExfATacJMQpIqmQ==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:17 +0200
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
Reply-To: raz.benyehuda@mobileye.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>

    Adding myself to ufs.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..d2257a8327c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1920,8 +1920,11 @@ UFS
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
 M:	Neha Malcom Francis <n-francis@ti.com>
+R:	Raz Ben Yehuda <raz.benyehuda@mobileye.com>
 S:	Maintained
+F:	cmd/ufs.c
 F:	common/spl/spl_ufs.c
+F:	doc/usage/cmd/ufs.rst
 F:	drivers/ufs/
 
 UPL

-- 
2.43.0


