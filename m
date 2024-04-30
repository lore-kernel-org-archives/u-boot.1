Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69743C10F16
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 07:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C13718899F;
	Tue, 30 Apr 2024 09:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="jNikEasG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01EC5885B5; Tue, 30 Apr 2024 09:42:29 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8365889A2
 for <U-Boot@lists.denx.de>; Tue, 30 Apr 2024 09:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id A47B01FA9E;
 Tue, 30 Apr 2024 09:42:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1714462946;
 bh=5Zc1DQw8USwxnifFISPgPWWw9BokJPGqFehF8ke+Qj8=; h=From:To:Subject;
 b=jNikEasGsMBtGCsVgts/1xUcbsL9QrtL4bZj4ipf0P98b+oD+C/HpIkfq/irSXlw/
 PAYstH/QP4HlgJQZC106kiUei9hIa450AgyvRbjoN79Ad4PqGTnzZCuKJ7dAo4vK1q
 Kh3ATmLw0D+/vBfM+EYX/wwhU41GyxVw57XQcpCRlNAQCp/3CWdvD/lrclIoslNk8s
 KjarIWibMXWOLUHYHk9rypfcM2hB2RsCmT6Pp0fTADVxzL56jM+eRtdFLiKy/BhlyF
 Q6eM7NzgEMcoxtjjKCTHU4lEzfxaSlWYICTi1s8yw9O0ZK4iVS8AGhqkonCmzx2cJF
 mWvgENXI+ajcA==
Date: Tue, 30 Apr 2024 09:42:21 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>, Jae hoon Chung <jh80.chung@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 U-Boot Mailing List <U-Boot@lists.denx.de>,
 maximilian.brune@9elements.com, curtis.machida@intel.com,
 Jonas Karlman <jonas@kwiboo.se>, greg.malysa@timesys.com,
 "ian.roberts@timesys.com Peng Fan" <peng.fan@nxp.com>,
 sheng.tan@9elements.com
Subject: Re: [GIT PULL] Please pull u-boot-mmc master
Message-ID: <20240430074221.GA10438@francesco-nb>
References: <CGME20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b@epcas1p3.samsung.com>
 <e6c74bd0-de66-42ef-a6af-0d5c058b12a0@samsung.com>
 <20240426155154.GK1054907@bill-the-cat>
 <33db14f4-f3f0-4e5f-a256-2ce9b5c505fd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33db14f4-f3f0-4e5f-a256-2ce9b5c505fd@ti.com>
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

On Mon, Apr 29, 2024 at 03:39:53PM -0500, Judith Mendez wrote:
> On 4/26/24 10:51 AM, Tom Rini wrote:
> > On Fri, Apr 26, 2024 at 07:38:30PM +0900, Jaehoon Chung wrote:
> > > Please pull u-boot-mmc master into u-boot master branch.
> > > If there is any problem, let me know, plz
> > Applied to u-boot/master, thanks!
> A patch in this series caused a regression for AM62x SK with the
> following error:

+1, this affects also Verdin AM62.

```
Trying to boot from MMC1
mmc_load_image_raw_sector: mmc block read error
Partition 1 invalid on device 0
spl_register_fat_device: fat register err - -1
spl_load_image_fat: error reading image u-boot.img, err - -1
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###
```

Francesco

