Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB9ECA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BA8D813C9;
	Fri,  9 Oct 2026 19:54:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XfD3LMmDwT5v; Fri,  9 Oct 2026 19:54:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E7F5812A8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575648;
	b=jCvrTXc8czC0ckiqMIKHl5izBaP4vK5EopKGY4Y4ifDzvWsM5fsTYE1PGHU1O7EBB7Uy
	 /X2OKwHIMNk1FksHhxWzuaPmElteHprgS5X+jbRBjfmXTHmr6DDXZ6sdLh9vzTFPHaSYo
	 YkKZgrYSeJe1kL867tGTHcK7RGHYbDVRLauJ+QmT+8YahXgA2k2bUgqjs+RzAD8G4jVgh
	 +XP1tld19FC7Od7w+K43vIRTqQ5ZhZDA8lHATTcNGzWZyulrkvA8xk0IbqZHOBGkuhnFK
	 +Qgeg4NUHi+SYbdqjGCyOixgz9OJgzdhl2gla2VtAvGoqlb+tMijdZvgMvhHMEheP6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SbR4HZzcOpaPhXXHbxl12J9ufGWqLO1Nzx3Dd03bpSE=;
	b=i5Ds8E3wzMm7ELDwDleg0Dt1J2/0q7ta+jy2DkxlWTYc1NulSZ2JPsCFTlbWMIUTj10R
	 jh8E9HmayM1z9ohDh0gJQl4hWnrztZRQ+lsYPPnGsIlohri7JTxAlJQCGPQ+D7FegSM5f
	 PB8UQ3jI18LZwtNMqDW6jkcKN5tiXZ/CZK8vMihfMjBhhR+5l7OSaCRjbZ0BDtRwgiFWy
	 OYztBHHLC6EfQfEMmmuHE5mg0aHP2SUxgpjbJzu31o5DoW5nGH5VgYcqbCUOViU2mLkGT
	 9qHASYLHjawbAP9XsSGS2UghjPwjhf2wFBpO7oihWCD82mykJo3Kz7wJrBG+ue+xkeg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575648;
	bh=SbR4HZzcOpaPhXXHbxl12J9ufGWqLO1Nzx3Dd03bpSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dXPmb2QHB0GgVDYQYOGaTTkE5WHoz/7MoM8hYOuIFgJPDegRIppxxjhuZXdhMqs0L
	 1hfffsPF8HarZ2/5cPg82grGykuPw2sa1UxDrEHV1FuuNQyXtJ8BtEq574TJmT1D4b
	 YyNaHOodmJik06GxuqIEX3u+PH1aJQz1YAcXzf1lcUio9Jqfj3G9fmANDb/onzZ3HS
	 /AweizBZ+Zv9ARvhVMeEuOoqDAIxneJK4QtPAUv42yjGdlrMk0qHwu7sBkSqkSSgPQ
	 99dXmeK9S6LcX3KtLsRYRZXWW4CXjgnVowE5y3ctHQnrVbzsUJZMGvWv7qbWGGrxVX
	 lPAl6OruuwavA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E7F5812A8;
	Fri,  9 Oct 2026 19:54:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 051FC317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id EB61D40080
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:38:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id TLQvlaogGGy8 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:38:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BDD8840053
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574707;
 b=capdjGyZ7Ne+pApbbdL/6WUlsePdeIDMlGmKjjYhXM14JSUYocOidCMMcvXSzpiP76dZ
 wqF8408JHLn56acBu+pieAD0kCK3TlBmF6f5p+PWkbWteAJRpuAU5JidO/UIZ2wXPe+HE
 MlcMmgmVAVQYnLUHSRSmSB/+ktw1gTfi2ZaMWzkIxl4hDnbsmHo1AHcod2DG4FM11/tQP
 jUqr7mKtQYZA/LpWuekk1BKZupV1ZT1+BooFqEenGTWxvJ8IWd3la7/Ja9pAGZGEvLskZ
 25JFl2vw0HjjFcDf/TLGVnG1tx8uAw5AHUgXE2YSeC6XWR9mGEs24b8i+jS4Hv8/VNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574707;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SbR4HZzcOpaPhXXHbxl12J9ufGWqLO1Nzx3Dd03bpSE=;
 b=WpOjALp0aLvTQ9rVGIinqAwzXLbzL6ldrATp5rLtYkNZY0/VFGTiH8Pz55qDedVCPwpz
 oIQ9EdmGsyg9Un9JToEJQJDuPNw9FeUvaEsbTW4Z0UnPaFUFuMnWavipOt4kb0YH0F+1l
 wnbFkSOCpBBFupJ9w08VmrbY/appj5rVK90l2MVL1zcWT6QPGlb1nUb0YGdpVb7G9psRp
 O4n8NGxQ5WUktRqeksbhpvNg+dIQR+ijrZZfvIO8ZRRf6nreZnJiVoZuXuc4JnunHLLux
 /b+IiIfsnGNmtCCyHGKpvjLh453YOMUaf+IBg/XC0CEtEtBwZhgpweB1VaWpUBy1LYg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=ejgDCwJ8; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=LAcI3ZfW; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=ejgDCwJ8; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=LAcI3ZfW
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id BDD8840053
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574636; bh=SbR4HZzcOpaPhXXHbxl12J9
 ufGWqLO1Nzx3Dd03bpSE=; b=ejgDCwJ83O4YojYuN0ZEDN/MJdSRMYTj7yvZ4nqbVW+AumjZ46
 1aE/PyqhXbg1t9ckV0XOAXHhFstNFKtqUWGJ2BeA9axVSQhltEUo5TGdnAbueMLJxsYr33hE/Ji
 XQbb0MFxikNPQWsgtM9oo4Bn8NTy1UxU42t220qZU7ixCLzpzQePMfEHfXr9JoH95GAwEhkUH3j
 uYvUx5bgHoq91vI7TkuqdEY7CS6qCTOrQFZIupg4qVuM83ZePjqZm3qO/v6GPfj/AGkP30gcJwy
 WNCx/67/v4JbugTYqUtIJPr774uy5NyFFtmfbawF6stR0FqK4c7Ib8/1z2sYWlIt3+w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574636; bh=SbR4HZzcOpaPhXXHbxl12J9
 ufGWqLO1Nzx3Dd03bpSE=; b=LAcI3ZfWJ8K47L47xEQY1TlGqL9vxIXQvn3HG+XU7S7a9CprOg
 udJZsvPAxX789qUt9PlV1izwoqaNYYJPrQBg==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Fabio Estevam <festevam@gmail.com>,
 Gaurav Jain <gaurav.jain@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Mario Six <mario.six@gdsys.cc>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Pengpeng Hou <hppiscas@163.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Torsten Rupp <torsten.rupp@8tronix.de>, Vincent Jardin <vjardin@free.fr>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 26/26] MAINTAINERS: powerpc: Add me as PowerPC maintainer
Date: Fri,  9 Oct 2026 19:37:04 +0000
Message-ID: <20261009193704.13061-27-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009193704.13061-1-brads@mainlining.org>
References: <20261009193704.13061-1-brads@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 19:54:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

PowerPC has been orphaned since 2022. Add me as maintainer.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1f51d9197d..1d331ce92d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1450,7 +1450,8 @@ F:	drivers/power/
 F:	include/power/
 
 POWERPC
-S:	Orphan (Since 2022-10-21)
+M:	Bradley Morgan <brads@mainlining.org>
+S:	Maintained
 F:	arch/powerpc/
 
 POWERPC MPC8XX
-- 
2.47.3

