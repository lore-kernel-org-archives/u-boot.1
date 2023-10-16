Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3ACCDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D5E386F41;
	Mon, 16 Oct 2023 11:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448288;
	bh=Ql9ITD9wfvVq3udERoIdXspyMIYLB2welwIf4a20zeg=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=k/eciX5dGfaWaHYEy1ev4CPTrJ4usd3MSa+CxLunzKRJ6I8Bsts6DCIyr4GOyarZZ
	 ckXzTYdHoQVEr62yIjesZ03qLX4vXVmcD66LKjgk7jwiUCSkkh3P+rHgwYMGSFqzwJ
	 fI/cadVE2vDvstDKlnM7ucWF/w9OhCarRCJhUo7N4iaEh8axMKUAOixkIHGRu0LZwL
	 Vy69qvuR8NtYxiVoBXMr6VWdZssGk08KV7/uLJLFVGDLkQiJSsx9RBkO51XBRGVJ/p
	 OH17UZDLZ2S+VTLkVr5uXOh4mSNUt8W94qeVUFOzOuc5J0YscfRPX/tOGH84xxlZbx
	 hfG4QAuGe48nw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0C886B71; Mon, 16 Oct 2023 11:23:32 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D4AD86F14
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BTz5VMmz1sClr;
 Mon, 16 Oct 2023 11:22:47 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BTz5N81z1qqlS;
 Mon, 16 Oct 2023 11:22:47 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id gwn7H5yBnQPP; Mon, 16 Oct 2023 11:22:47 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:47 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Tim Harvey <tharvey@gateworks.com>
X-Patchwork-Id: 1825577
X-Patchwork-Delegate: sbabic@denx.de
To: Tim Harvey <tharvey@gateworks.com>,u-boot@lists.denx.de
Subject: [PATCH v2 1/3] arm: dts: imx8mm: move firmware/optee node to common
 imx8mm-u-boot.dtsi
In-reply-to: <20230824190144.980883-1-tharvey@gateworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092332.EE0C886B71@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:23:24 +0200 (CEST)
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

> Move the firmware/optee node to the common imx8mm-u-boot.dtsi and
> protect it with an ifdef CONFIG_OPTEE as it is a meaningless node
> without the optee driver enabled.
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
