Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740EEC61CE2
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 09:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2592A606B4;
	Tue, 25 Aug 2026 09:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cizJ1P_BySVl; Tue, 25 Aug 2026 09:48:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787651319;
	bh=rRb/G2eiIHcf1zQAwPFNkzR220xvpQfe+u5eQmKck+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IAMhO94BRhZS0u5kIhlgGt8rtdw0PcL0Rz2UwdqdJL9z2sUuD4e7leE1De8/2TGTU
	 i+jpjY24knfmCsUFvQffguADLLpfdDSE6nHM1R3jvKEYErjwYKrJ7T/Nq0ad48pX/R
	 krrzgF4BjXJZ0xLTR8KBn2x2XVu3eJhGyXRovriUll+yUzhdKuMtoYh6JQ996Q0t9o
	 gPMRORmJ+nbOkIu34KmhZcT78Fi87t3Nvg3Lbc77i0Ajmzec2Em4dbWpmBJXozLRz0
	 vSPaHF1E2jxKxQ0npvfpLHgRzckIoc0wkkmXsZxrhfHKUHg6XjdkTV1cgBt72TC/st
	 c+x1UMc3fcKBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1862960614;
	Tue, 25 Aug 2026 09:48:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8559396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEC3140055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:48:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aqUaVnSAuh3N for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 09:48:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=xO4Ry2ZL; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=vM05ZnlK
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2822B400EC
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:48:36 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hTjdt5tRQz8tyv;
 Tue, 25 Aug 2026 11:48:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787651314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRb/G2eiIHcf1zQAwPFNkzR220xvpQfe+u5eQmKck+s=;
 b=xO4Ry2ZL1gXY7+PhoLG9QdzVV9uTIHgixb/7SdpBg0MQZ23Mjnvun26DhrZ6hBgoHJZ4cK
 y0Y7bfT1H+QU9/Yt5vLLm9Tz2MPkaAB1iAAPVEHiY20NjilQPLlgFG1h2pIg7F+jzHIH8j
 hDHREpbvkJ4bTImwWKmbsygPSQ17teEWPUr6ufWOlXQUZkhyfJUhE5kIshaJhUwhT72HxT
 RuxabSjtmnwsprcVW8ntQZCg+f83Nx4vwydOZHN3EGgQj7FCwXNNdzkeG2gseX7F8cSg6Q
 nelWerVLp9JZsBJzKKlLC8PLE2PRMNfkx/B4OCYrjI/03PHRS+X4H3a4kajEKQ==
Message-ID: <36d72877-ab8c-4338-b34a-dc85c82c039f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787651313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRb/G2eiIHcf1zQAwPFNkzR220xvpQfe+u5eQmKck+s=;
 b=vM05ZnlKvINAO47Endcdk+qGv6fSpIgp/JBoNggyqLr/6D0nJH+K4p2QnHwYBthgHHzo36
 oGnLja4/aLZI1ld2tV9oZfwGwvIKE3VWMPlPFoajHkYbfJLFGGU1e/KvdsKHCC+NyEPtOg
 czsqdAjyfyZIb3NIG7GmdIrHvaZPpx9f1q2IWDf9byHjUgH90pXOCmNi8JoTJ/Zmv6jIzb
 8bHg7OfsWIG1HohI7RPZtW3X1vIPwoLZ+qDVCPt4whl7aJyxU3s4HwkMzE3fiQebktEKKy
 6tJcsUEf+NrUvRCQuelT0fZUHeYFtcoSIL0c3PQnFFd0sai7qgcNHGPkeHIzvA==
Date: Tue, 25 Aug 2026 01:45:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/6] usb: skip host-only devices when picking the ehci
 gadget controller
To: Stefan Eichenberger <eichest@gmail.com>, francesco.dolcini@toradex.com,
 trini@konsulko.com, ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, marek.vasut+usb@mailbox.org,
 alice.guo@nxp.com, antoine.gouby@toradex.com,
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com,
 franz.schnyder@toradex.com, balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com
Cc: u-boot@lists.u-boot-project.org
References: <20260824183048.419198-1-eichest@gmail.com>
 <20260824183048.419198-4-eichest@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260824183048.419198-4-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 86abf1128ede479ab94
X-MBO-RS-META: 4xpd5qakienuncafkuyidwac7ffpi1yk
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

On 8/24/26 8:29 PM, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The i.MX95 SoC has two USB controllers, a DWC3 host-only controller and
> a ChipIdea OTG controller. The latter is the one that can be used for
> USB gadget functionality.

Both DWC3 and CI HDRC controllers are dual-role on MX95, are they not ?

[...]
