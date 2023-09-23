Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C494CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF18D869F6;
	Sat, 23 Sep 2023 20:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695495116;
	bh=NT6UhCsQUzFMnnewCPvvZKER99mZzEkbC9t2EQ+FgXs=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=UJEd6LMfa96JPkPQenpDHafxJps4/or3z1Hj/DXwVzS237ffNaqOLnPkwK/CpetT1
	 zggKCnGglmdVKBnkBfmfPGW+la1lOSgMJ5sGwF7npZ02cjOakooGrV9kzAlKCF3UYA
	 9f91Hf6DJPwbyJksxGOCAKBpefZjrddqZWOEJAUi40VxJIlPkbOZobcnHNLSY9ITnG
	 5vROQNu4fXDyVP5tZn9TssLk5/t9qTwXrY9u/Dpg+PI7qwG1FWLJLdZ8x29u4rjoXx
	 ysMu7K5/oLC8cWsTqFdySGlPk5W/hIhc9CwettvUz/yxY3eQD/aWyOjCgnC7zQJfou
	 Jlrzzd1xRNy0w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70B2F86A24; Sat, 23 Sep 2023 20:51:55 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABDE186996
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4RtJCF2WGnz1r2sG;
 Sat, 23 Sep 2023 20:51:53 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4RtJCF2N44z1qqlS;
 Sat, 23 Sep 2023 20:51:53 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id zxgTjzmJJKMD; Sat, 23 Sep 2023 20:51:52 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Sat, 23 Sep 2023 20:51:52 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1830684
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH 1/3] imx: hab: Allow hab_auth_img_or_fail to be called without
 ivt_offset
In-reply-to: <20230907014727.371324-1-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20230923185155.70B2F86A24@phobos.denx.de>
Date: Sat, 23 Sep 2023 20:51:53 +0200 (CEST)
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
> Since commit ea91031b2232 ("imx: hab: extend hab_auth_img to calculate
> ivt_offset"), it is possible to call the hab_auth_img command without the 
> last ivt_offset argument.
> Currently, calling hab_auth_img_or_fail without the last
> ivt_offset parameter causes a failure and the command usage text is shown.
> Fix this problem by adjusting the argc logic to allow
> calling hab_auth_img_or_fail with only the address and size parameters.
> This way, both hab_auth_img and hab_auth_img_or_fail have the same
> behavior with respect to the allowed number of command parameters.
>  
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
