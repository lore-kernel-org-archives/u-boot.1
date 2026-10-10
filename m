Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50B7CA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 04:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40EEA8142A;
	Sat, 10 Oct 2026 04:34:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3rS8NrrlNKpi; Sat, 10 Oct 2026 04:34:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 441CD811FC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791606886;
	b=EP+98/7bO0km8RV5OGn49p2VAc+NGwi7c80R8BYTT0Nd7TeEY9tCxdtFvtpIiCX8MwI3
	 Sp9JyfxwThXLKM3pyrJEbon9mCqJHGUILtHE2IviFxZPKdB6MY1cx+KAN6BNS23EMnJWb
	 4tT35sC6bXxXS37doj+fCgCHuyE7/q21/iHfdOtlSwdWWWtbgGMqv5WNXD3DIIl4Sq7jE
	 phz6BUMF9dxtJbXEx+lEWlhaSX/oaIIAqjIWSNqju/mjbHOomKfwSVV/XBYWjgGb9A8CO
	 pRLinwT38G9rXpA5ql27lSKsCbCqZYE5enB75G5MjwbY91D3BUn/CNfGnr+ruaVJ3dA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791606886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:DKIM-Signature:Received:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NTYkRtEWfes4dFyQvUMjenGQ7ebULeeYZf/FtENEYbk=;
	b=aQCB4XXcYRj5TZSQfIiK4CHqkwI7Rlb/LvmCqq8RRTS5rFa26NOWETq9RgVGjHN0YFtM
	 0kfhnrtQD3ig7Rrx9DwtIwbFEk/BfGR+ae4JX8NF2uQvDnZBIgajXrEqrBGDnhF2qOORT
	 J/XkhmRuj2HbSexCdjH3z9hf6vQ7wr6Py96DmYBj25duPQkxBIWirJSpyEzxQIxsZ/E6m
	 lDvXflGv5xHHPL7Pk6SKHIjnsvWLEBu+nViseqmsFZGcajrZv4I1R8h1qvrbRYIqwm6GM
	 TD3ekZvuYwzUuD0uy9u+SOi4seyd7cSWQASNc/w6sUUCESxiJwpvjMPqHfksswCBDRw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791606886;
	bh=NTYkRtEWfes4dFyQvUMjenGQ7ebULeeYZf/FtENEYbk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A+5aBkbckfmbtoFeK89G61HR/YkCbgOcGJIR47MMsyWDp5hFzZ4Gk3oNvJfTPFIt/
	 KS0a886crV7zK5uwmDA7jy+o9m92rGytQLg/e1oC4lwkAsd/YsylWR9VoAiJX81DLZ
	 iCGaK1uqZO9W2uUy4oV0QOoT/G8hvZDqi7kPyhEiN/jeXrDwm0gc/ftPbXTJfntnmm
	 ufk3jSNT89we77Y8sNRT4QAW8Oy7UiDpx0ZfA3MBAgPazOSNAmQE3F7gWHWf1KcXkP
	 cx0dwH+h2cZEwmeXsfcRGRaL0e0eUR5bFIKiC5M9y9kQ4nt5EfGB6A/hr9OyYwyOqN
	 IkLwdnEgO+Q1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 441CD811FC;
	Sat, 10 Oct 2026 04:34:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB78C1DE
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 01:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9195D4009C
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 01:41:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lGroNlEhNiyh for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 01:41:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7833B4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=153.128.190.141
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791596510;
 b=XZtPsJS2a+SpgE1FXE/JDnszzRok4QtOBMS9SpCsgawGukeqd3dcWD8cebfxF1YLEX0J
 HUPoYbCuagR/mTMp0RUmsuqVu69A3oWvLNBKXuv1Go+RQxazyv7r2AlI2rq8BuB6gsDBb
 eoYlEp96w1erLRaAw4y6tnSdTlos5Uhtz+ZKfHkSkHdda83WicE69nqATAVBeK+YlfCNa
 hYA6AjFmC4jy00fRGhINPR6mmrqtKkDYHF3AnDrMV/je6OmLGom//m3sEom0+MHokF94D
 ZRvDNlZre4X21iCt68HoZv0D34JAuc1YcDwlDKl8bxy4EB9VMDMtxA7wlPyB6Tx11QA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791596510;
 h=X-Greylist:Received-SPF:Received:Received:DKIM-Signature:Received:
 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=NTYkRtEWfes4dFyQvUMjenGQ7ebULeeYZf/FtENEYbk=;
 b=MPyfPg98Ykgh9t34DXTghWw783hF9arckOolYUczFA+At1YsV4dNtA2rZPRHSouUGu0Q
 ApGb4jIUP1M80xDVS0rm+XNSUSuI5FY2LJvB0Bchl3OIB4/iCJWd5hdeaw8C+TPMB38Ra
 rMzDArA59TP4QQ/TMwKsHnpkDBuJV67MRaLl2wzAoIq1pWsEk35MqzbLapFVeG/WglG/L
 FZYkIT5VlVTJ157bSG16ySH+x+tKdmFWdFDDtuJVYDQbTCYi6azWaX6ixQKxm4VmbkrXl
 8TYH6hhe5RRtFuNM+J2cVr6S2KeaTfYcw/+oC8oA69kRYgFS9ozrb73TepyNlZNwqnQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=docomonet.jp;
 dkim=pass header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=D+1pBK6e; 
 arc=none smtp.remote-ip=153.128.190.141
X-Greylist: delayed 450 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 10 Oct 2026 01:41:49 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=docomonet.jp
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=D+1pBK6e
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=153.128.190.141;
 helo=ocn-dfr-mts-118c2.ocn.ad.jp; envelope-from=y-asai.0816@docomonet.jp;
 receiver=<UNKNOWN> 
Received: from ocn-dfr-mts-118c2.ocn.ad.jp (ocn-dfr-mts-118c2.ocn.ad.jp
 [153.128.190.141])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7833B4006F
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 01:41:48 +0000 (UTC)
Received: from ocn-ckd-mts-115c39.ocn.ad.jp (ocn-ckd-mts-115c39.ocn.ad.jp
 [122.28.97.104])
 by ocn-dfr-mts-118c2.ocn.ad.jp (Postfix) with ESMTP id 61FB41C001720
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:34:16 +0900 (JST)
Received: from ocn-spm-mts-105c1.ocn.ad.jp (ocn-spm-mts-105c1.ocn.ad.jp
 [153.128.190.234])
 by ocn-ckd-mts-115c39.ocn.ad.jp (Postfix) with ESMTP id 8EAC644002CAB;
 Sat, 10 Oct 2026 10:34:09 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=docomonet.jp;
 s=20240125; t=1791596049;
 bh=T1SEkfnk5BAw0EHaHLkDuh0O6sQqfyzow3f57G+ciNU=;
 h=From:To:Cc:Subject:Date:From;
 b=D+1pBK6e5zOvuGhQptqDP58LrGpiwYUFpXE1EJTuP3MkhXCnFQLlHiWch7z0W+2mq
 PoH7hQlbe5h+bz4dbyWq1pdC5/3DHc+Q/QCJY/IDWRH/QRl+llXSg3U5i5Ge5PbvBe
 piipdyF1PhiYcUNb76Y/yeSyVz3x72jyKMxs4waw=
Received: from ocn-vc-mts-110c1.ocn.ad.jp ([153.149.236.162])
 by ocn-spm-mts-105c1 with ngmta
 id 6bb6c4ef-18dd071d5f0d365a; Sat, 10 Oct 2026 10:34:09 +0900
Received: from ocn-sdpx-mts-109c1.ocn.ad.jp ([153.128.117.199])
 by ocn-vc-mts-110c1 with ngmta
 id ddccb461-18dd071d4399c043; Sat, 10 Oct 2026 10:34:09 +0900
Received: from X870E-AORUS-MASTER.kkp-group.com (p3688129-ipoe.ipoe.ocn.ne.jp
 [153.238.101.128])
 by ocn-sdpx-mts-109c1.ocn.ad.jp (Postfix) with ESMTPA;
 Sat, 10 Oct 2026 10:34:08 +0900 (JST)
From: Shigeaki Asai <y-asai.0816@docomonet.jp>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, neil.armstrong@linaro.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com,
 u-boot@0leil.net, sjg@chromium.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, Shigeaki Asai <y-asai.0816@docomonet.jp>
Subject: [PATCH 0/2] odroid-go-ultra: fix SD boot after a reboot from Linux
Date: Sat, 10 Oct 2026 10:32:35 +0900
Message-ID: <20261010013237.2269021-1-y-asai.0816@docomonet.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Oct 2026 04:34:44 +0000
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

On the ODROID-GO Ultra, booting from the SD card fails after a reboot
from Linux. Linux sets vddio_c (the SD card vqmmc supply, RK818 LDO9)
to 3.0V, the value is kept across the warm reboot, and with U-Boot
running the card at 40 MHz, reads fail on some cards. The board then
stops at the U-Boot prompt. A cold boot is fine.

Patch 1 adds the missing RK818 LDO9 to the rk8xx regulator driver, and
patch 2 uses it to set vddio_c to 3.3V on the ODROID-GO Ultra.

Tested on an ODROID-GO Ultra with v2026.07 and a SanDisk Ultra A1 64GB
card: 9 reboots from Linux in a row, all booting from SD. The series
is rebased on current main and builds with
odroid-go-ultra_defconfig.

The patches were written with the help of Claude (claude-opus-5-5).

Shigeaki Asai (2):
  power: regulator: rk8xx: add RK818 LDO9 support
  arm: dts: meson-g12b-odroid-go-ultra-u-boot: set vddio_c to 3.3V

 .../meson-g12b-odroid-go-ultra-u-boot.dtsi    |  8 ++++
 drivers/power/regulator/rk8xx.c               | 46 +++++++++++++++----
 2 files changed, 44 insertions(+), 10 deletions(-)

-- 
2.43.0

