Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CE4C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD5488112D;
	Wed, 29 Jul 2026 09:34:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RjS24LLSC19v; Wed, 29 Jul 2026 09:34:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0E8B810FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785317697;
	bh=Vde6dBgrBBidRm2wN/aSCoolbF39G9qh6fD3qg2kQkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ols86eLPhwAgQ6ytzB4nb2qDBBFtQRIP8Rt/FAS+W7+U2giSqoqcMK2GySHg2aczj
	 og3zzr42XkgaRBFpsLD/1DtmGDBoIxLmBeQPoe0He3zAfHFJGddE1+wDjPN+mku4v3
	 7IIJbLb+GLWDd4KImM7Jjlw5O6BCBoAn10DnbQbqERW6u1LAQx7/1/PBZw1G1cnLsJ
	 dRq7QO0D3WKCGwpg+bK+dMynsouN+MyrCY4Lb4UBuelBm+y/HgrtIAaKV+nbfseTkV
	 2PBGgICDGePdBhGb7DIkylrcCIdODB53fKs1O/qPHMfaDWhfMKFBIOr5VV8D9qwhCl
	 9g6n+9uiK8qkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0E8B810FE;
	Wed, 29 Jul 2026 09:34:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3A29490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA71E400AC
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:34:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6z7ZJ5jfCrYN for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:34:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 82BDC4004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82BDC4004B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82BDC4004B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:34:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6F748494B; Wed, 29 Jul 2026 11:34:52 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60B48404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:34:50 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 45C3760A6C;
 Wed, 29 Jul 2026 09:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664231F000E9;
 Wed, 29 Jul 2026 09:34:48 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v5 61/75] usb: host: re-import xhci-ext-caps.h from
 kernel v6.16
In-Reply-To: <20260716134305.614278-62-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-62-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:34:46 +0200
Message-ID: <87y0euxhop.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785317689;
 bh=Vde6dBgrBBidRm2wN/aSCoolbF39G9qh6fD3qg2kQkQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=eEi/5/VOF6883rShiALaam1KyTNjZa4lPsVHF6qFkr5Z2UK63Y9BiUvCEt6dPyzd0
 hCwwxsVrE97fZ/yNsbB4BlFFiT9eZ24j6JqEq05RwukhdiK5rWP/Waq0os2o0DYYGM
 F3kpvWJdE/dR/CzbcLRwiqK6DE1vPnJWHhhn/xD6/o068b5mzUr5Gv9l4jqsq/pa6i
 swwFVE9kI2EhfDRZBpuApNzXtMOmpc0u2FcC1OagMfE8+ANUy6MSGZ1Rp1xFg81xxI
 Nhfz0V2Avmlc45EWGwHDP/wdKypeEyMGB30eDCWL2jQEFmub+kbf0uhNcJDopJm7Lg
 X3fSEdmJYEWsQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eEi/5/VO
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="eEi/5/VO"; 
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

Hi Anders,

Thank you for the patch.

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jerome Forissier <jerome.forissier@linaro.org>
>
> Import drivers/usb/host/xhci-ext-caps.h from Linux v6.16. The file
> is needed by the updated DWC3 code.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>


