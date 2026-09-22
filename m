Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC10C982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 05:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E36E80987;
	Tue, 22 Sep 2026 05:27:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QKRVe3cYweK; Tue, 22 Sep 2026 05:27:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8232C80B5F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790054841;
	b=KjaB89QRTFbK5mrnyNzf7OlDoDtQ9/IfIdGiLP7D8ULBsKwD5mAIpr8ycDbqecj/9pDS
	 oRYbbdBzgA00xa2XE/7vPTBZxUxUoiiDXoSS3SAsHuWBmI11KVHHoqUXEeIYkbUVSk8Sn
	 VgS7ZfXMV750/71Imw6i5K/iZf1x9sUUf8wUPj8OsJ+nKX1unLWLN5WrXq49le6eMCjQK
	 Sv5bDKaynR+LCBbofjeDSXBSKk/qvGIe0Pgq2r8xZijw3sLe1eLFY1a+3Kw6O0WBgvPqP
	 4YE7IWDlDdQAvH3fi/oz1I4WtpI4C1mIcxVIxrql02xiItm9KYFo+ZJVbrNyg2x9OrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790054841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qDDKMoXQyplR1dRhC85cVgGdi4ghUgmeTP/MaEBEFe4=;
	b=ZSufcgKz9AQvQT/m7Rozf1PN8tR7PmmC1Gf3CuRxmCxrY4z0735/57HneOrKzVBqe98G
	 HFo4h2qetWCOfX3Yba2KFGkAJeB0BfcRSHdmCoOTUhkDxeyyjuErITesHHtMy2dc95fVz
	 kU3/RPlqD5CRXIlOd2x8g9WmuUbohB7Jp9tQdXfxp7fPCORfdJ5VLu/ca+og/1iEZMyUS
	 HCwqz256XsXlClX2ia3ykeX/dE+z1U0k6gslu0dMdPfG29nrGvXnqu+BQF4jwJZqWIGvN
	 HAOndzJn+AjRvV24Hz4Depxb1l4xE85+wwpr9T/NbyePwgfllm41C/MmLn4/+dPYG+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=CIm+J+IU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790054841;
	bh=qDDKMoXQyplR1dRhC85cVgGdi4ghUgmeTP/MaEBEFe4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uklLVkT4cROhseYY8LABRgMO4ORtDqbA08XtqdR8QeglBtgaerc1Amt4u9SIAhf73
	 5JQOe6yqQIBXouc/ir2VMzknIKaGTIoAZIh7QKXLUz05+zNGQSvKOnk4oprlbYnCFY
	 3pkY61pxSQjjjo7DRYdi4cyezOdkR+EX0GF//WAWNLnhejupRBxb1x2vw3eu/JzOr8
	 PwBy7VlOsQ6qheHzrhdMfeXQZPc2VbcTV3uNTNmqomYPdqN5YxKk9uq9hrOD0qSCni
	 jcrsInrVuj3QPzT5w0XQKBeY+3193Dkp8Nt2NzB2xchIDf7BsUwrpQnp2pfwUQaDVq
	 wm0JlfneM5IBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8232C80B5F;
	Tue, 22 Sep 2026 05:27:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76D23194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68C7580B5F
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m-5U_xGRRh-0 for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 05:27:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8350380987
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790054839;
 b=HuI0QRNUx9kOkTXqa4S4x/jzKu+dSJRcLx6B2xPZ23b/0hgRksYODB23FzoYlC42Br1l
 xnYCtJkpnbf/T7mOi36XSCHyEZ+KfrIK1b06JVNkFDbxilRs6uppb7/TYM85o/Clp2S9A
 i3bjQMFWDsZQpfp0D934BaL5BjJ4prX1vV8UcMxjYyFoyQ5GCRo/kXt6MEZhKIevPuDfv
 RNjzvo/wWIU1BDEaQQO3dYaPy3iRmmLaNdLqinVduKhKcAB4cAEcXi0SKFkl3MIeXomFS
 gV8ph3UlVjBLwgn76H6rSAtQhLACTFACAO6Ol79gUSPvMiug/4D/1jqAymyLrgbnYBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790054839;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=qDDKMoXQyplR1dRhC85cVgGdi4ghUgmeTP/MaEBEFe4=;
 b=HOGo9f00zRjG2R8H5/QN7L3U2cDqtp9zLX0yFxThN4BoUUbpudA/x5MFx+GwVwmxmria
 6VfXs+GGy6kwfCiARnrgLoQgVfu54yAMexOBAM41v+A2ldPHcIXqRhD6iFY5SvK9MLTyl
 lb4xJxbYlzGBGhGb1GzNv9/EL8KCLv2JS4cJQEFlwNQPsepchOXIYVr3GxatQFU0YCGdb
 AP2YkswP46cJ6LA5u9bMXsXY34hVKj2CzbVn4LFcDX0qvJyZuZuoUbE/LCs5YDiILRShd
 a/+ZDqZUTUTL2d1AR1R6zIF4AK9GdEZd5HnFKuw0kXl4dC3Nz5pUuPbcptLGwz5B66g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=CIm+J+IU; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=CIm+J+IU
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8350380987
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:27:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 889E9105591; Tue, 22 Sep 2026 07:27:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790054832; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=qDDKMoXQyplR1dRhC85cVgGdi4ghUgmeTP/MaEBEFe4=;
 b=CIm+J+IURJKb/Ic2m+XDMD10dgSmRjOUeYBnfVvs/VADpIfgIEvIK1YwncEgYkhIaKOBoh
 sP5X0Uh/ufaE3Dm+SrV9tb5IQes9V+BMTBjUfsgIP8OT8kRNKkappmTVN4BmfvDF+PAWyN
 MDageQWU+j6X1q2Q5zNNHlzEOTYhGGpZLk4Mhdw6qdhpD2wUjeHojbxFTJ5695kyh7+8V3
 PXji04cskDmBKPzrq99/Rb4ECL+Etn2legbfEio8ElWXkMlQJK9Ts3LQt5Cpt6eqfOAMz5
 HuDfmQSPrQTkwpqj+yy6yOACpr0R+/NdBYPCJ4wuJFaY37W3Ph6z+wpb7jxvfQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Gaurav Jain <gaurav.jain@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Peng Fan <peng.fan@nxp.com>, Stefan Bigler <stefan.bigler@securiton.ch>,
 Tom Rini <trini@konsulko.com>, Utkarsh Gupta <utkarsh.gupta@nxp.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v1 0/2] imx: deal with the RNG self test of the i.MX6 boot ROM
Date: Tue, 22 Sep 2026 07:26:46 +0200
Message-ID: <20260922052700.528451-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The boot ROM of a few i.MX6 revisions runs its RNG self test
incorrectly, which leaves a HAB warning behind on every boot and says
nothing about the state of the RNG.

The first patch runs the test correctly, before anything else uses the
RNG. The second one makes hab_status name the leftover event, so that
the warning stops sending people looking for a fault in their own
image.

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=214&view=results
is fine.



Heiko Schocher (2):
  crypto: fsl: run the CAAM RNG self test on affected i.MX6 chips
  imx: hab: name the event left behind by the boot ROM RNG self test

 arch/arm/include/asm/arch-imx/cpu.h |   2 +
 arch/arm/mach-imx/hab.c             |  16 +++
 drivers/crypto/fsl/Kconfig          |  22 ++++
 drivers/crypto/fsl/Makefile         |   1 +
 drivers/crypto/fsl/jr.c             |   3 +
 drivers/crypto/fsl/jr.h             |   1 +
 drivers/crypto/fsl/rng_self_test.c  | 157 ++++++++++++++++++++++++++++
 7 files changed, 202 insertions(+)
 create mode 100644 drivers/crypto/fsl/rng_self_test.c

---
base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
branch: hab-rng-v1

-- 
2.55.0

