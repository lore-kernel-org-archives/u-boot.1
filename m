Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A8ECDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC96486E2F;
	Mon, 16 Oct 2023 11:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448111;
	bh=vmPTwnJDCgXDaC6FfQkeFlUsE+MSSyCKOBcu6kBjmZk=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=XPu9X05WNlwHWcjvgWk7/vMw7q+eANJ1wxXC/oEomCxqGQASC1p3GFBNMDVQJRIhF
	 gGrWykZFmjSpkqumcK/PYiP0RW9GKHJI434FSvv9QRBU6YC+cq/3Yh9xVveFw7JDe3
	 Sm0x7vfhT381rKkChvbEAZ44oiYSuBFL6w1mak7J1b9UBpVYfIRhdN/e4p31tgOCK0
	 SMb7CJEbymCA9YFPWCrvt86A2e+RN3Qom61wJ5Yc31F/G30l07NmeBS+FH+iU01Iw5
	 0S/jxtj4trdGz+seV7KJt1P533A03HbTEbIR3vV2Nza2X9nz9FBcLjQ3t2vkDztrdi
	 kF5mltFQfZxrg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5A8186B71; Mon, 16 Oct 2023 11:21:33 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EE2886CFE
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BSS6q15z1sCJ3;
 Mon, 16 Oct 2023 11:21:28 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BSS6cZZz1qqlY;
 Mon, 16 Oct 2023 11:21:28 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id GpjTpCU2lAwD; Mon, 16 Oct 2023 11:21:28 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:21:28 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1828413
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH] imx: hab: Use CONFIG_SPL_LOAD_FIT_ADDRESS in the CSF example
In-reply-to: <20230831145603.80139-1-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092133.E5A8186B71@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:21:32 +0200 (CEST)
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

> The SPL authenticates image starting from CONFIG_SPL_LOAD_FIT_ADDRESS
> address, update the csf_fit.txt to match.
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Fabio Estevam <festevam@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
