Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAF0C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 17:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1F768135D;
	Tue, 28 Jul 2026 17:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xznm0W2UPcED; Tue, 28 Jul 2026 17:15:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27134812AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785258929;
	bh=uyB0hLMqjDz6Cfwwe10skd3Sv9QU4rZNK21KpxA9Ulc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zqc1U3+8S+W4IoJzKMe13UmaMdlZWUOFRJO43PC5kAPiyrSTbV0LBwa2kdjBUfrXn
	 dL8NNqeJiZ301TK2aQJf5C2de5pLP3JIhsVYSFz3VHgp3xr9XDUzjeDGzMCJSNXS2H
	 mxqP6zTB4lwXQjf/TT828hzlq1wt91/jDhfBz6RCXtlmDKBuI+MSXqyOynB7b1T7za
	 +uyAbup0RTPYZrT902UpZIfpJ05bFiLjmfgOfADd3n+pa37mvQGDhgn1J1GU/pEKCN
	 gJgL72WyqogWNifyQOUFsvFlkQ+O+YbZXrDENzVQgWT8XmL1oNixLTpiAp2LJqnzs0
	 JKXC4WYi4V6wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27134812AB;
	Tue, 28 Jul 2026 17:15:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F033A788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5F13409DA
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:15:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mJElWNSITtxr for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:15:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E48D940A09
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E48D940A09
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E48D940A09
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:15:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D38F58494B; Tue, 28 Jul 2026 19:15:21 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 616918404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:15:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; t=1785258914; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=crhGFqrqdlq9MRDjhQtoBGurhSoP6O+gE1Q7U+OCDOqI8pYoPvuoM9v2C/VqIZRUbRwsS7cDbZ6uZ3qKCLCB1AdbY1Im73lJiA/hH1wMr98ny6BbxXrGmJ9AUfnRY65zVR/miruwRUfuYSTjg0+TZhaA9WofhlUNmv5LmmDW6ao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785258914;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uyB0hLMqjDz6Cfwwe10skd3Sv9QU4rZNK21KpxA9Ulc=; 
 b=NR5goOJEp3xOjYSHfG8mrcBkpwdsp+3u+kxIk/SqCx25SB0m576nEHgfWNGdb1TaSb7HJMHbF5EQrW4Jpq82kyzvAj+tbapOSoANQHq9VEepoqgdY246GWOkfbIiwpIV3G9Vqi6xkonGJJRJHvp8IhLWd3y9nd77q0SQJCmLEPo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
Received: by mx.zohomail.com with SMTPS id 1785258911024373.04739067174785;
 Tue, 28 Jul 2026 10:15:11 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>,
 Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v6 04/11] pinctrl: k1: add IO power domain configuration
 support
Date: Wed, 29 Jul 2026 01:15:01 +0800
Message-ID: <20260728171501.160770-1-junhui.liu@pigmoral.tech>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727-m4-v6-4-2f58566d48ca@riscstar.com>
References: <20260727-m4-v6-4-2f58566d48ca@riscstar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785258914; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=uyB0hLMqjDz6Cfwwe10skd3Sv9QU4rZNK21KpxA9Ulc=;
 b=SOF4Tp5qYZDh+IS2nJCqsWqFsLauhU1MIURLJUthgyIB5/j3VYCBOP9OZpo1xBtP
 gv8nPHHHNvfoCqXRrtLuOzqlzKBCt3FQq8pW2DjLl889u2TBCot5Kd90sOgY93EVmip
 TX5Y4z/1f8QecXhsIFT9QU0+igt/+e8hDd5s2sYs=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=pigmoral.tech
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=fail
 smtp.mailfrom=pigmoral.tech
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=SOF4Tp5q
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=pigmoral.tech
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=junhui.liu@pigmoral.tech
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.b="SOF4Tp5q"; 
 dkim-atps=neutral
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

Hi Eric,=0D
=0D
I wasn't included in the To/Cc list, and lore has not been working=0D
properly recently, so I had some difficulty replying to this thread.=0D
=0D
> -	depends on PINCTRL_GENERIC && DM=0D
> +	depends on PINCTRL_GENERIC && DM && SYSCON=0D
=0D
Since v6 uses dev_read_phandle_with_args() followed by=0D
regmap_init_mem(), the driver no longer uses the syscon uclass or any=0D
syscon_* API. Therefore, the SYSCON dependency is unnecessary.=0D
=0D
> +#include <regmap.h>=0D
> +#include <syscon.h>=0D
=0D
This include is unnecessary as well.=0D
=0D
Best regards,=0D
Junhui=0D
