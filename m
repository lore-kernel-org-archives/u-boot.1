Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA82C83F2C
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 07:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC0086932;
	Tue,  5 Sep 2023 09:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693899551;
	bh=a+CUZKg4aE+bZzAlIMzP4p5LeLxhcmzGw2JqUkThMgA=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=qXow0AKMixVzkHI5tBxislAckg/XPH4WZ9zDGxvqKVMbf0nxh8aQiFZPALKwpj4FR
	 yzXGr1qZRRUgKsxBXmEYyPu2R0jfqJLXZehxzgSQ5OHKHaXcQwOm3Dfx3jOjwl6zAu
	 flZZ+xxmMUJz/WuxJj/sdZ9DPxD1+b2uCn4+2IOIHjoJO18FDDbqsor0Y8Vkum0WpG
	 xwtbD2YZiI6Gn6qa3s1GffVqTzavRISplr4Wv89X2i1YK5CaMMcDavzL0M5EWE0dXb
	 uqpC+TcBlSEL3ywlV2eGh+msCfXxmewP3ILC22BOwy9dz8dY/XCPjYcDYJGOilKbnf
	 +lGB0inZBM7uQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB9D86569; Tue,  5 Sep 2023 09:39:10 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 138CD86960
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 09:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4Rfy7H6Mg2z1r1gZ;
 Tue,  5 Sep 2023 09:39:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4Rfy7H64l6z1qqlS;
 Tue,  5 Sep 2023 09:39:07 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 8ae7taK5Zqy0; Tue,  5 Sep 2023 09:39:07 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Tue,  5 Sep 2023 09:39:07 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1824877
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH v2 5/5] thermal: imx_tmu: Increase the polling interval
In-reply-to: <20230823175911.319414-5-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20230905073910.7FB9D86569@phobos.denx.de>
Date: Tue,  5 Sep 2023 09:39:08 +0200 (CEST)
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

> From: Fabio Estevam <festevam@denx.de>
> Polling every second to check whether the CPU has cooled down is
> too frequent.
> Allow more time for the CPU to cool down by increasing the polling
> interval to 5 seconds by defaut.
> This value is used in the absence of the 'polling-delay' devicetree
> property.
> Signed-off-by: Fabio Estevam <festevam@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
