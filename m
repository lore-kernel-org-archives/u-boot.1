Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEC5CCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 17:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FE0838AE;
	Thu, 30 Oct 2025 18:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="fQ8gKRwi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B40983887; Thu, 30 Oct 2025 18:13:17 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F11836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=igor.belwon@mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=fQ8gKRwiuNUE7N7XCrtMvl5/dg87yQ8/+R5YFomoePa5/7aVNTVNwprUmq/5VckFieeU865feXIsDXNX1IeJEvkvtuxOxV21Q771SM2CtTy8fKywS6Euw8UKb6p2IHP8bCQGTAnUQVZIFRKmrSmQ8CQx4QiI48vfy9FrS9IidB6nkUcviisN1FVuJdBlgfN3s9ZEeKjg0MU6KFBSPKNQxyZWv4yK0afx54Ff2MJqjExl7o4C4X+g2AprrvbxvZ1Cl8sxlv7lvBAPoqVtEiWWUMZuBeselKPcwGImJRHYG4bGUmBPyHvvqeS4BNFey005LsyNYoSL3hkYvuMv1IkLlw==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=UNY2gMckNk0xibnS+z+qdbPu1RiqyhQFOogEhIaBmeM=;
 h=Feedback-ID:Received:Date:To:Subject:From; 
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1523034140; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 30 Oct 2025 17:12:53 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 18:12:50 +0100
Message-Id: <DDVTPE7HADMW.I3XHZV2XBIZD@mentallysanemainliners.org>
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
Cc: "Bhupesh Sharma" <bhupesh.linux@gmail.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "Neha Malcom Francis"
 <n-francis@ti.com>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Shawn
 Lin" <shawn.lin@rock-chips.com>, "Tom Rini" <trini@konsulko.com>, "Tuyen
 Dang" <tuyen.dang.xa@renesas.com>, "Yoshihiro Shimoda"
 <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] ufs: Keep Makefile and Kconfig sorted one more time
From: "Igor Belwon" <igor.belwon@mentallysanemainliners.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251029201435.215966-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251029201435.215966-1-marek.vasut+renesas@mailbox.org>
X-Mailman-Approved-At: Thu, 30 Oct 2025 18:36:24 +0100
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

On Wed Oct 29, 2025 at 9:14 PM CET, Marek Vasut wrote:
> Sort the Makefile and Kconfig alphabetically again. No functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/ufs/Kconfig  | 28 ++++++++++++++--------------
>  drivers/ufs/Makefile |  4 ++--
>  2 files changed, 16 insertions(+), 16 deletions(-)

Hi Marek,

Maybe for the future we could use the consistent naming scheme, like in
the Kernel, UFS_MANUFACTUER. It would make it more clear.=20

However for now,

Reviewed-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>

Best regards,
Igor
