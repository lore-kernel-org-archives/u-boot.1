Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3946CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 17:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF1D803C6;
	Thu, 30 Apr 2026 19:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sxJD0GA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8801584099; Thu, 30 Apr 2026 19:33:59 +0200 (CEST)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09E5E80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 19:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-42fdab683b7so676560fac.3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777570436; x=1778175236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lujBlIi2V4oEWgTmh5cSm1iIqksApfBCLqLNyDY42Es=;
 b=sxJD0GA3RDUz0gaZXps8Utp8r1yM1YIFwwsnekHcE+GS+4ONDlqKjyWj0QRWHbAyl8
 ctHvZ7+mMHL8uaDRPfB28ts8UcFih1t4QeV5mIkd1VUALZTnBdTkYvCUKtKv3Ir+OWqY
 3ZK+5POp+IxiRD9bSAb/k/TyndCCVoTSlOPX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777570436; x=1778175236;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lujBlIi2V4oEWgTmh5cSm1iIqksApfBCLqLNyDY42Es=;
 b=Wq/brexBD2VbB+GnZGreN8sScL5C8XmWcTkgOM/+WT+HQPLSm8SJt5wPEM0zp4GHvL
 Qlo2cKNkrxWS6HBZFSCE5/UsIDAY5A8lcXgwpos9gr73HJN63EwfxIVeUOqmCJfFp6cf
 UBWE99ln/3idAIkuMx2uf3M22mHWRVbtDhPY9FgIeOr3fIKmBKRss4iv06V0yOD4qKiq
 WD9Fg21VXEA7l+fKDb4m1HDOk9SRbEV0Hb48ibzSit9jBEMvlnznVZ/iArn5LHpIZy+7
 xQv0mKU1GqISeS0RkAWIrNEmsx++6W06AEet55dwLFUYy962MKHfUdfdiEGIGpCO9Xnx
 vrDA==
X-Gm-Message-State: AOJu0YzqgYRYMYUl98M1yIwHY3iQhx2BWUtG8PuLCSJaezJU8DFVHNfU
 F2ihFRP94bDHneExKB6OX+vAZfVIpQ14/dCvdBLfXRPy18BN1KqbxAD3BSTlG7z8ZE0=
X-Gm-Gg: AeBDieth7YBbr+GJBY1shNrDkUWEZ/O7bZZEC/oC2voYFwyk15mwhUY0sGFExowSuql
 tISxCpPAbdiWQoHArp2lZCZDNOxg3pJ/6dE2lghXSpxZORP/iyWtzBWRU86HFoPv7wtu00JtWXo
 Qi2LWBS7R7NsncsuB927fFQ+Co1J523vHChalccjS9T7N5AQTlaVmbkkF5ywQp5mx1RmL7tFCEi
 5Oox8DMBigcmY2gC+HXP4I5jgepMsjlT8tFarfi8F6waK7qxgPoX0DDYw4IoHJ7Qp7+RG+rC/vK
 VQE7uXzDZKNCrZIpU2uTyPLYWr31bRmd/bB7VsH64CFEZ83WyL0BXnV0lJufh88z0YD4Hj7kk5N
 1jWOySPfoViwytFOvCbUD/B9uHGOPzrJwAOTS5z7MBZ+VrNnU+WnH2ytHxRr0EY8UObNPnWPRJd
 GMgP9Qk77PAXTQN2Qr3pi+BP8qCDWcMA5SNXtmPoptd+3KUpT48Ikv/T670r1Xn0ntG1KKPmce7
 xxRkXAfBCPQMix5bQBnfZWByO47SBCeGyzAPvIvUDt4TkM3bai8RN146wQv
X-Received: by 2002:a05:6871:314b:b0:42c:ebc:7f53 with SMTP id
 586e51a60fabf-43434052febmr2524488fac.37.1777570435753; 
 Thu, 30 Apr 2026 10:33:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454d324e2sm220272fac.13.2026.04.30.10.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:33:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <b595bf2b-7076-48dc-adbf-c77349f4e250@foss.st.com>
References: <b595bf2b-7076-48dc-adbf-c77349f4e250@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2026.07 =
 u-boot-stm32-20260430
Message-Id: <177757043486.1667054.18361415668119134829.b4-ty@konsulko.com>
Date: Thu, 30 Apr 2026 11:33:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 30 Apr 2026 17:08:10 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related patches for u-boot/master, v2026.07 = u-boot-stm32-20260430
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/29940
> 
> !!! Regarding the CI status, for socfpga_vining_fpga, spl/u-boot-spl.bin exceeds size limit
> 
> I noticed that you recently encountered the same issue which lead you to submit the patch
> 13b3502157ea ("socfpga: vining: Enable LTO")
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


