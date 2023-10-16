Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FABCDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1261586EDB;
	Mon, 16 Oct 2023 11:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448184;
	bh=QJZjLxJUV4id4A+H2ENVjj8Fhbf/gmhoAWH0KqdROW4=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=iKhq78/rb/7rbFTo7glGeYtbBxCS7AJrRMar75nNy0vj630eqLKn1EEbCK/AsDTWw
	 SUO7Fr+lK7x6Ghkx7/0+YKiVB9tT6/4UCyw0z/2XE2wCZWWi6BEEmMs/ZxH+KIQFTc
	 8auDG5yuM0m3BgXqHlZCwKqEPiHZuf/HjnGl840uyDeJmZQ6zlDWksY7LA45ACvBEr
	 p9eFeIGIyNmXNqV1HwypaFkf+ELUd9WAwJ+KGtVJcXpXlzZ+o208EF4+lGWHeRlRNj
	 N4oi9cPUZCdlczEu4ieyUtC8IAorvTF8Ailp3M8157HKPYxWR7qEL4eqYUTpZkjWLi
	 8I0zTvjrK8C1g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724A386B1D; Mon, 16 Oct 2023 11:21:36 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7EF86D59
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BSX4lm2z1sClr;
 Mon, 16 Oct 2023 11:21:32 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BSX4SJcz1qqlY;
 Mon, 16 Oct 2023 11:21:32 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id yYC5pViENnXI; Mon, 16 Oct 2023 11:21:32 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:21:32 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1845938
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH] smegw01: Remove misuse of CONFIG_ENV_IS_NOWHERE
In-reply-to: <20231010141412.3681919-1-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092136.724A386B1D@phobos.denx.de>
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

> From: Eduard Strehlau <eduard@lionizers.com>
> When using a list of writeable variables, the initial values come
> from the built-in default environment since commit 5ab81058364b ("env:
> Complete generic support for writable list").
> Remove unnecessary misuse of CONFIG_ENV_IS_NOWHERE as default environment.
> Based on the fix done by commit b16fd7f75f6d ("imx6q: acc: Remove misuse
> of env is nowhere driver").
> Signed-off-by: Eduard Strehlau <eduard@lionizers.com>
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
