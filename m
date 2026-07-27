Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BDAC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3754460730;
	Mon, 27 Jul 2026 17:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hcib3q-JMmP1; Mon, 27 Jul 2026 17:42:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AEA760712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785174121;
	bh=Ua/LOe/B1rxJTgn9NOWjYY9IlafJcoNzCq4YD8YJxC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TXRqK6E+R0MkLHqkKbk7i0xX87Z97UvaUfq+JJ3PRsImh7YkpvWrrULov50ytKs2z
	 TzdHiPCyFxqlZsK02yfpf1JkC6ytvUs+U2ChionUDigfNjIBs5C52ARiVr5071gSXo
	 qDCBXq9JCQvdQXqC9ZRn6h3UO572GeLfnD84W/SvzMowG4FXiwRRHSa+Phv0jMn1GN
	 /O7rJ/rW71uBR2cRJ9hcXNX0hTGVzAr+yU2Pj3htnv9WwfJD/poDFPgYyl6KSOEVzt
	 Vu9u5V0QnqL2uPFAP5dMgdd2Rr150DsXdhO/Fvf+qFw3kC/qu8M8rDrCOcjBfValY4
	 U2gQF4LQ3S2eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AEA760712;
	Mon, 27 Jul 2026 17:42:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22921350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0354960712
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:42:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w6WR1sWfOuf1 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:41:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 016296068A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 016296068A
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 016296068A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785174102; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fL015Bmomx2kWolSC7yzQbEYeCY5XjpfjnaGPCwSiSaajlzHARiRcYMbzhDFlre0STGjpn6bbL60u2rSFmy5Jh10FkVYt/iwb8L44ZrzaEO6aPhhuRzoOlYRdGaaT+OXVuUkfHoXC7z+AfIV1+mQFHa6ErKyZ3xovjejcrOKzgI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785174102;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ua/LOe/B1rxJTgn9NOWjYY9IlafJcoNzCq4YD8YJxC4=; 
 b=OalpKmhV1ulk/GEe8Pk6ekVwKmyl/HZSOyKQjuu4IC0sOI3oPfZP3Qcah3ls9jTPfJuYne3/bgPXS1ft0XZIDkSTvu0pzT/2OKTpgbuFsHaI9/iZj9qggUNDXXKS4A5RL36xCJOS3jMG5biZFRt4OhMUPd78AkmdSbu83UPr2WY=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785174098501348.94837070900894;
 Mon, 27 Jul 2026 10:41:38 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:41:29 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v6 11/11] spacemit: k1: load product name from
 environment variable
Message-ID: <ameYSWjELnlovONB@pie>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-11-2f58566d48ca@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-m4-v6-11-2f58566d48ca@riscstar.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.167.77
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785174102; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=Ua/LOe/B1rxJTgn9NOWjYY9IlafJcoNzCq4YD8YJxC4=;
 b=Uz6UzHYDvYNOOhqWp/5qup9MBPGG7d2X4YFEDHDOGuRcAZFES37l7XUaUjbFuQ5k
 s0qLCdyOk8N4jvBPK/XRrjmMECO0GRvFkklOpnwyvSLr4PP632L9zeOQX9vxUoAiSBM
 n95tWWL0w56Za+tuaRX04xQvrD730Q5PF5dTlBf4=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Uz6UzHYD
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 27, 2026 at 02:59:13PM +0800, Eric Chung wrote:
> Read the product name from the environment instead of EEPROM,
> as the EEPROM may not be programmed and the environment always
> contains this information.

Please explain why the environment "always contains this information".
This sounds strange since the environment variable is placed on MMC,
and there should be no "product_name" environment variable in the
environment partition if U-Boot is flashed to a completely new and
empty MMC.

The EEPROM should be the most robost way to distinguish board types. If
you do have devices with unprogrammed EEPROMs, please provide a guide to
program it correctly.

Furthremore, this doesn't seem to fit the subject of the series,
"spacemit mmc driver", since I don't think these changes are required
for MMC to work. So I think this patch should be split out even if you
do want to change the board detection logic.

> Signed-off-by: Eric Chung <eric.chung@riscstar.com>

Best regards,
Yao Zi
