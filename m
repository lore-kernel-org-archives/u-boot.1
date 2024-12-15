Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D33E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 04:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA2B800D2;
	Mon, 16 Dec 2024 05:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=aibrahem.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=aibrahem.com header.i=@aibrahem.com header.b="S7J8z/7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BEE980086; Sun, 15 Dec 2024 21:56:40 +0100 (CET)
Received: from st43p00im-ztbu10073601.me.com (st43p00im-ztbu10073601.me.com
 [17.58.63.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F78B8005D
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 21:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=aibrahem.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@aibrahem.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aibrahem.com;
 s=sig1; t=1734296197;
 bh=wNnmyVUN53ZmFUbII8s2pc0Sknx1oMh0lyxDk/dp3eM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=S7J8z/7JgxN342Jut466W9UaQuNNL6A89mfr0qfHQ82t09riN1mpM+x6WS2A4WX6R
 jGEHt8CynJj+4+GjpFT4jUSd4RH2Nci6//4cRnDmb8whfVzftfoaBHBRrT44kkRf2O
 x2qpYvrlMUb2fy84StB/1WKKOiQpFRlP8ob8Ev6hT0TeeuS8Faiz9icS/3V2krpMSS
 e5a/WtR+fBbXXd0CtMsZqZQqPYufm0YD3GYu1HYr/TzCLr5j/ak7uTE5WxchePOam6
 5p3HS0B3vucN6FIrhU1jtUXjq02fxCZdS8WqfHXruPhkGeorD/F9/1iCOGGCl7vf7I
 ONGP8k1GdPLfQ==
Received: from localhost.localdomain (st43p00im-dlb-asmtp-mailmevip.me.com
 [17.42.251.41])
 by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id 013B9180358;
 Sun, 15 Dec 2024 20:56:35 +0000 (UTC)
From: Abdelrahman Ibrahem <mail@aibrahem.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm: imx: Remove arch_env_get_location to fix env lockdown
Date: Sun, 15 Dec 2024 21:55:53 +0100
Message-ID: <20241215205553.10445-1-mail@aibrahem.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215010518.GA16463@localhost.localdomain>
References: <20241215010518.GA16463@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X4zpcUzUaTiRqU8Erk8QQMAW_layOIO9
X-Proofpoint-ORIG-GUID: X4zpcUzUaTiRqU8Erk8QQMAW_layOIO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-15_09,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1030 mlxscore=0 mlxlogscore=364
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412150183
X-Mailman-Approved-At: Mon, 16 Dec 2024 05:36:45 +0100
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

Thank you for your feedback.

This file is global for all Layerscape Processors, if this function is
needed for a specific board then it needs to be moved to only be included
for that board.

Let me know if you have further suggestions.

Best regards,
Abdelrahman Ibrahem
