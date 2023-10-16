Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32970CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1926086F19;
	Mon, 16 Oct 2023 18:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697474818;
	bh=ge0D7toD7/tzDf0C62VcmHtB/kCf0QJveeE1pjr+CYg=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ZY+t1ieH9Nz65RgHDblBvwcR7I9P4cE4ut++/pGYS2b7K7jmp/5vjrn1o0ZQ9zI6O
	 zT3ipB7getXqJhaqzx+sgaSBqK91ytSmpgFxp3I0lOHEUoKAXcoBmV+fTzzqQvgJOq
	 9AZGfkxiduVMOoeqSmWxfKLs0ad0DzXFKOBZCq/fYre9YkFzO6osgxViC1ENH4kFQr
	 OqV+y9T0dXbBCUWeTgc4Gji8SJcRJapS18n8qyGbVL1z89JVm6Pa+sjrZwVGppVO27
	 3cBAV8yUEfplBcdSd/8fUedMT9+b418t37T7039z3Taxxv439tMlfEBYhqNOpR/063
	 VwnR3vQluMRug==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A41CA86F16; Mon, 16 Oct 2023 18:46:40 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52C8869EB
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8NL63ZCgz1r2Z3;
 Mon, 16 Oct 2023 18:46:38 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8NL63T7wz1qqlS;
 Mon, 16 Oct 2023 18:46:38 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id DwjWFkoi2mvi; Mon, 16 Oct 2023 18:46:37 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:46:37 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1837756
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH 3/5] arm64: dts: imx8mp: Update i.MX8MP DHCOM SoM DT to
 production rev.200
In-reply-to: <20230921184420.45186-3-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016164640.A41CA86F16@phobos.denx.de>
Date: Mon, 16 Oct 2023 18:46:38 +0200 (CEST)
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

> The current imx8mp-dhcom-som.dtsi describes prototype rev.100 SoM,
> update the DT to describe production rev.200 SoM which brings the
> following changes:
> - Fast SoC GPIOs exposed on the SoM edge connector
> - Slow GPIOs like component resets moved to I2C GPIO expander
> - ADC upgraded from TLA2024 to ADS1015 with conversion interrupt
> - EEPROM size increased from 256 B to 4 kiB
> Signed-off-by: Marek Vasut <marex@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
