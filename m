Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D414CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 15:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B00A40935;
	Fri,  9 Oct 2026 15:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lqX34G_gkqWl; Fri,  9 Oct 2026 15:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4132940931
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791559002;
	b=qh7uxB7WgNkshek5KPlXWUwiT7mpp6oVuxaBhUX9FK1jfUpecX6TUPcYweVHP8bN/OhA
	 RfoWugNiP2apOXjKxho6UV1eqjFqS29O1JdQUccncTF7w5kFj3zUawnzlVTTNHIjEV6Zp
	 GYa1j/E12IApN1nx3BUDhnxFhi8AVm+zhLax9y74eETE/e+fKGCNW7JJJ6aqISvecyHqH
	 l3S0SVF1y6Ni2jJM0vURGAcfcIG9lpFrmCLNKXT3wEWdnLdC8ndrKEBfZojsFi23efWfL
	 +lJbp+Vsra09+qTyO+UDUGJlez1Nxs2MgkgXG5sYIq+u2quq1R//PP7fyMjHQFzxrbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791559002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vix5XRCWYX6cjt1J4BIuNpT9hXn8at5y/LoBblRlovc=;
	b=Qawmwb4nNs26OPHdgH8dGfEG/tUQDT/SOCCynOdWsBgXWLHDkPGoe/89gyIwO7Tzr79D
	 nIZbRiHLDgLLZ2LAFlIN1xqQAb1sJ9Zx5+4N2EcZVRLtAWusIhLifz2j8nph1syclMCYr
	 6oy92hs+KQYvFtpBuYb50iIYxX75D1HdtNfmFBone2cVGJTZ4Ul4lBQhbK3pf6o5uM10b
	 2MKL3ij8bfaAth1ZzHoR8AKUKQB5Z7n58ipahGS5i1dwaBqLOCizmPP05Nb4ZrjY0Qbef
	 NtikgStdYTsO7UTtG/oNtksuAcjxBwtJBuoiNGjc+WQTKSALw3Ca0US5pbPdiHdNvmw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791559002;
	bh=vix5XRCWYX6cjt1J4BIuNpT9hXn8at5y/LoBblRlovc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jevi9DhHTRfygM/oPHmhEOsNhtm3uxIcBUdOal9CpJlAAaMnghK/6RHkDjaGshAvF
	 YSAt4Iqx3lgaE5KTk7GJrr9iMksTPML74BnIi9Dvwk6Aa8yIx7Sz7w2lQim+tjK4rv
	 AJIw1N9hDAZ5gaZX5qqbuiiuCOfsyoqr4FpN0d8Pz3wRsTSii6C20etCumcYw1Lnks
	 xT0ewM6d6yr8/YAceY26FnzB0FrQfWTZzwi3hAEJnW371Mwo9Y7RkZ6NqoBeoM16/K
	 v9wd6sk/nZ8RtUmdKQKJjU07BPZ2xeOijAkAeRX4ngOLCt64ymL9zpNmmjOCdX6WeW
	 p+EeZBi+ZCAOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4132940931;
	Fri,  9 Oct 2026 15:16:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F3554317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4CF66069F
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mb3rUfz4P44Z for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 15:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69B6860656
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791558999;
 b=DOV81ISmi9ekmcqFRjUkhhP1Ld1T0EceQOQTEmajBkEcxTWWfssbd6dNrsOTtITPExJd
 vGWvhZITkQNSCLIy3OXyvds9YTcXMp+wVTR+xTYly1bmiLt3cDG2mhRaKgUM78b/Hycw5
 PN80DEB0IX+jK7TShdr5VPs8fHudoJ1533Zdujxdy8DOXR1bmAyy3VRaJO/RcTZf3boI/
 /YZCAq0K+//NPEvoZZehnqew8sc0NjgGlnnGCm/6ffTGqkq8qN9I4S5MnhIf5CNowKVJO
 ZZfNIuoUB0QV8kV/rZvIUDsF33etr1KgMOHOX11IJPSUWk5H+e09FjwZoAmE+On2xCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791558999;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-Originating-IP:X-CM-SenderInfo;
 bh=vix5XRCWYX6cjt1J4BIuNpT9hXn8at5y/LoBblRlovc=;
 b=X60y0xW8ykk4gew6zHRntin7xiKG55VtkZgGIDvBU5+lNjdrPHmIpwNBRzCUeKcfkH87
 /Q/T3YmRZY6CiQ8OYlc7Fyt5f6Pp8Wcs9XjdCodHltHI3ZU8Utbv6YhcVyH91J+C1S3eR
 6js5umlPJm/5/+1ISHuPgeaLvDVXsVVZBQUmMDFcHyjDB5U4cAvJv/8fUjowqjPE0gvaa
 Byt6EKGIWUHJsmHm5cKy7xm8BH5lllNLiB0pOm9iL9LajkJ8T0VZHxGycdLbFyB5DMYPT
 Sia2zR5J06Rk3BHC5hSf90Xq2Qrvki4emfJ3gWjxLieqS5+Cb4VWYzZeAFLttGd4pLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=OsPhOc67; 
 arc=none smtp.remote-ip=220.197.31.2
X-Greylist: delayed 144 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 09 Oct 2026 15:16:38 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=OsPhOc67
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.2;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69B6860656
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vi
 x5XRCWYX6cjt1J4BIuNpT9hXn8at5y/LoBblRlovc=; b=OsPhOc67JGHBO8pJ//
 MXRL8yqBxegb9jt8iRI/N0dfajqEyDIdpSjuBakau8LUwyliwHgPGk2YgSeWnLLQ
 WaFRnwwneHcIbMmesCsm8xbQ4Dl/Iul+A/NkzRuOq5gaS4YTy/gn/0lV1tGLVZbL
 LNe2h8JrXU3f0OMti1rrhd22E=
Received: from nh50.. (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wA3Tx6qBMlqYAAGDQ--.8534S2; 
 Fri, 09 Oct 2026 23:13:47 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: Re: [PATCH] bootstd: Add a bootmeth for scripts in raw partitions
Date: Fri,  9 Oct 2026 23:13:46 +0800
Message-ID: <20261009151346.2877875-1-hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009151005.2870671-1-hyyoxhk@163.com>
References: <20261009151005.2870671-1-hyyoxhk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3Tx6qBMlqYAAGDQ--.8534S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYg4SDUUUU
X-Originating-IP: [2409:8a62:2b4:2720:5e30:3963:68a3:91f0]
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC0As4C2rJBKsMqQAA3B
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

Hi,

I would like to add the hardware validation results for this patch:

The raw-partition script boot method has been successfully tested on the
LCKFB Taishan Pi (TSPI), based on the Rockchip RK3566 SoC, using
lckfb-tspi-rk3566_defconfig with CONFIG_BOOTMETH_SCRIPT_RAW enabled.

This confirms successful operation on real RK3566 hardware.

Best regards,
He Yong

