Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83797C54F52
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 395D940B53;
	Wed, 29 Jul 2026 09:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fyPmPmHCEQcH; Wed, 29 Jul 2026 09:40:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BA4440B41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785318004;
	bh=rK9eCGHMstV9me6RkpXo4Rz1Ukvk1hwRj7CyOXA1ECk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NqipYHxySlEvhvTyHl6gi1MdI6LnUwU8utUleT0ZC+F8nHqZwNBkqZXlFuA1cAlkH
	 4dnUizxAv9FB7MlU7+j+smViI+SjRRidi243mzx8Md4Md7ZVrxL19Ll/HW+ZQLGXQ9
	 qXtNDBxBNTIPkfrX+5wt5/GWen7kFMMJIPZ47vT+vwQNjMk2B5Zw7UWAixcpzcCHv2
	 WqXBcUqe+jxT0Ka2kaLlyr5O39wgo8ttJnO2FICFU/3vtz8/dbYK7Goqq4gZWJNqRi
	 ayJrmNI8AAl1Oj6eRgveMQbOQWy6NADp+xkiw7e28SKoT7t2g5km0mIpkVzG7IE1R9
	 rreFM3eWz7hDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BA4440B41;
	Wed, 29 Jul 2026 09:40:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 03AEA490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDA7740B51
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:40:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TZn9ASvEbs1k for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:40:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2034340B41
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2034340B41
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2034340B41
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:40:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FFC08494B; Wed, 29 Jul 2026 11:39:59 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCF498404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:39:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; t=1785317988; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=N2DklkJcO4hQf69Gd2qOvHzRJ0K6OqsaUnA1G+1YZWDBY4GyiiP6wQA/luCz9cxSXU8CynM5VNJYga5IHR47oHxFxJ7HrLBffO39k+8jWG7pzvtX/TYVzXCatSqu0F5ZnZowqQudDYaR0n5ZKUWVen14g6a9shRtJZeGjgDw8z0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785317988;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rK9eCGHMstV9me6RkpXo4Rz1Ukvk1hwRj7CyOXA1ECk=; 
 b=DRnksUXaM6v/iduUcdmULg3GAmr+HtYMUkjaNm6rcI3ZCTmMcnwIOBYhWqOGBJCyaeptv47cyi2Y55Y/M56mM2CiOpgB1LPztNV1pJUFj2uGMPr48cQmQy1NuXtPwmF293YANnSFdel61+AlTS8Zw7lfWIBhu9F4p4mcVMqBq2o=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 17853179850321002.2076474931296;
 Wed, 29 Jul 2026 02:39:45 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:39:39 +0000
From: Yao Zi <me@ziyao.cc>
To: Conor Dooley <mail@conchuod.ie>, Milad <miladh1539@gmail.com>,
 u-boot@lists.denx.de
Cc: minda.chen@starfivetech.com, rick@andestech.com,
 yunhui.liang@starfivetech.com, Yao Zi <me@ziyao.cc>
Subject: Re: VisionFive 2 eMMC boot issues.
Message-ID: <amnKW1qbQeux5UCD@pie>
References: <CA+H9utw63z8x2Q+AhjWoq5O+aVW2FKEBCgvVtSzX--HJSJHAVA@mail.gmail.com>
 <7ec9c425-53c5-41a2-95e7-f185e8d340c5@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ec9c425-53c5-41a2-95e7-f185e8d340c5@conchuod.ie>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.299.17
X-ZohoMailClient: External
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785317988; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=rK9eCGHMstV9me6RkpXo4Rz1Ukvk1hwRj7CyOXA1ECk=;
 b=Zf5gZf6yIEvpYAH5kLoHeYnUZxv4DhWisuPVpVCdecCHMEJM7vLTKaRJiJQ2JJZ8
 pPEy32YzjbiVMJ1WLkllLfsGXQcT6odfDwaVL6+aOwyhOQKHW7JiUwnbtRShW1ag9qV
 upfNhjQYpdv7EQGU7U+Taw2R9A3pPTlaEtL9riMo=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Zf5gZf6y
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=me@ziyao.cc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Zf5gZf6y"; 
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

On Tue, Jul 28, 2026 at 07:02:02PM +0100, Conor Dooley wrote:
> On 28/07/2026 15:42, Milad wrote:
> > Hello everyone,
> > 
> > Little reminder on this thread regarding my VisionFive 2 MMC boot issue.
> > 
> > Archive link:
> > https://lists.u-boot-project.org/pipermail/u-boot/2026-July/624724.html
> > 
> > Just following up to see if anyone has had a chance to look at the details
> > in my original message on the link.
> > 
> > Thanks!
> 
> I don't think you CCed anyone that cares about the platform on that
> patch so that's probably the problem there.
> 
> Is this the same issue that Ilya attempted to fix in the upstream version
> of the devicetree for this platform?
> https://lore.kernel.org/all/20260306171939.84568-1-k0tran@altlinux.org/

Quoting logs in the link,

> SD card (mmc1) fails to initialize in U-Boot. Full serial output:
>
> Card did not respond to voltage select! : -110
> ** Booting bootflow '<NULL>' with efi_mgr
> Loading Boot0000 'usb 0' failed
> Error reading cluster
> Loading Boot0001 'mmc 1' failed
> EFI boot manager: Cannot load any image
> Boot failed (err=-14)
> Card did not respond to voltage select! : -110
> Card did not respond to voltage select! : -110
> Card did not respond to voltage select! : -110
> Card did not respond to voltage select! : -110

The problem happens in U-Boot shell instead of SPL stage, so it probably
has nothing to do with the bootph-pre-ram change. Even if the pinctrl
isn't available at SPL stage, it should still be picked by the proper
U-Boot.

> My subsequent PR for that lead to issues and it never got applied.
> https://lore.kernel.org/soc/4dd4ffe6-307a-442b-ae99-50c88d4e5b84@freeshell.de/
> 
> This happened back in March, and I just have not had the time nor
> inclination to actually sort it out, and nobody else has stepped up.
> 
> I think I will just pick that one patch back up again and resubmit
> it for this cycle. After all, it doesn't change the configuration, just
> the point at which the configuration should be done.
> 
> If you could let me know if that patch helps, then it would be another
> argument for actually (finally) getting it merged.
> 
> Thanks,
> Conor.

Best regards,
Yao Zi
