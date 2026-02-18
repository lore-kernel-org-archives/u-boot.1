Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95481E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 13:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C81D83D77;
	Wed, 18 Feb 2026 14:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=NVSoft.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="eoV7X9qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 572F083C19; Wed, 18 Feb 2026 11:44:01 +0100 (CET)
Received: from sonic311-13.consmr.mail.bf2.yahoo.com
 (sonic311-13.consmr.mail.bf2.yahoo.com [74.6.131.123])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1804683AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=NVSoft.net
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=val@NVSoft.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1771411437; bh=Ekdq1SowSMY4pGVYdDHXoQ7DwuwtONMd7n4BRoy54aM=;
 h=Date:From:To:Subject:References:From:Subject:Reply-To;
 b=eoV7X9qiJDl6EqrsDOzkUIhFNhycprsoCe0gyxFoHUiDboS/0BEcXaScIVF1THzxqHjc6bFZmHL5g9NTC945MB606C4d8w84zU1CM7Am3KDW4YvjlNP1qPGFIYXJ3KdsPz0lwJhILeADY0TTJtjVD6AhLWdDvuSG2MR4jR61j6w9+jVOlgl5RlEmuo0z5zOSpH/asjr/utoAcbzwlH5hWtirnYkCX5WRfJDMoGU0zclNUVhRx5/ELNTI1gZJwpphi1QMM5DFzLUhGYfV3ZDQO9u+kLYem7zfVZNqBS5+26sdn/SySYxJVDdA5ItP36s4ZBprcgbY8ksMEqhvk5IYJw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1771411437; bh=Oq8nS7zERC9g7ZCM3xNsSRTuxdt7D4tg2Gohhr0gssn=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=rO36q5GT5SG1ehpZkIJ32DftJxtRRoazQkpxD8prO1xsgmrozPnJhfdnfs7bz0YjMvDOP/aRblBfOu2NQOgHsNSD2N+XLiS3Kg1knTLmuxiiP3vEOU00gSuXVkHI1wp/OlR19ouHLmXzO/3hAwGsBWwYBftSC+R342tJW099HDXnu9WhA+gZyN4jv1uxYWayVRRgJOabLHQ+DxD5lewxfjQuX5nc2ZyaiXRsjOxdpzAvt1DWil3zTZEmOl7hg2RdxbP/ok3Byu7x3MXrUQl3SQNXAa5+1qu/j4ItwJExWpLpSk/z/TznboFojd/PszXup1a4UhogNl4ozjqkfZy/kg==
X-YMail-OSG: 0yIaFHoVM1nNVUnG.lVDb69HqmLVsJJRRHPnztZHFsRXEvKRJrQNzplhGWdT4lR
 e871EjPwJyEE7RRjJXVn9TpfokotblP4VvAqna7E6rFbuyowrTe5j6dc.vqFl_RboW3MMtte7yCj
 X5rgW07RKUf53LASRL8R2zOgB0RgMiSI8pWPmALBPBCRpI2_O.ZEhb6vZmZ2.bbIRGLCzWL0GxFV
 Qs5jNliml2LwsJlzTs8j6.Tt8lbojreIybTM.w0doThfklY1XSYxih0dU9DhalURW5Xq1wrxtIJz
 8_Zu8iJkiHaekfPZzq_uOWqztRVHv1G1rhxhw_CCjYDXhgkpTrA.fnLZ1UtDBoy_HgfLiEh5l1zd
 bEz2iS_Gry6eiM_yjoUMm59wUKYMeVCyKwIbkQPzuIazy.Exmw5U_H0RM_KQW0Mr.qWpnq20ULVl
 JSuLbsrAMlBbEMUD.FqPFqkarKrivRc4267w35LAfhrBi5lKisndUcJMJY9XrkNdCHesbTQ6Nj1W
 k4JbgJu_pHiv1oienEvZ6MwWHJYVmqDFKXEqfddKuJrOagCLXVrFT__9CYbvNQ7M7m95kfD70uhB
 XAYjAJ_vyNC1SetQOMUZv9CzMYRS7qrTMb4haurJKr9NunMpGzgxomfHi1yahp_qwfhi_RwdY44m
 0VsQ5l6wi.e9rrMkLL5D10SUdV2JAjTFqMAIkzjFVMob8qI8XNIXQ37a6YrmgmR.ApWV69yEkBeK
 9Ze3dbS0nDkZB7lS._ro2Sj0Dr2HNTdQkIWw5UoGFuPQowaKu_1zy.wT4MHCQOyVjPpnr1HDvBVt
 9Pg17HUVzfxN3.PicZJ0bNxDqj66Z1tc8x4xdXMbfd3n1vs_9g2f2pbfFEHYzGymTHVS4WWZdovv
 i4sqLzSxN3bWltUhfOsIvThIgnoy3eRB6eege.IKOLH9GresBtXFQ1KqlGBfo0D2NZXjGSDS04py
 XChyWrr2jFjA8bgifD06ubAUTGmcFHwb6eJJEOdu0KTFcRhrnPVDuHKTTrfxVjXdvKVwV79nIfg.
 z2YzlW5Tpi88TAdpqlXfuche_bLR3NE6nc2.nl4ZccniypdcOML55rOP_pl4ADSHo6vwAm14QnuP
 E15gWVgiDThinhDoJ3yRH_JlMAEUH7bCwnu6hz1nrgjFoPH.DMxG5j7fuFBvy_4XXAi0inZ2cTdu
 AKd_IRaFzGiWiD3usmVzFG9VF5UvKdVq2l1RV_IujPzoZkt09lVBoVEwU8ayVZQa7sxjk2lU1kdQ
 zv0Hk0kC7BRJgV4jyPDquJwO.8pgKqOTHk9RgvICYygPO50tOh0mLydS7Ee3KJF2bW2Ohn983Rf3
 i3S8skKdcJudpfgh7SfG7j9ap7cTPKKAqj.acDouJDf5GkjqDyT..Q6jLPQbCRxF_nMO_XvOVnL3
 90_jI.LRutcYpAzvb2XHp5RRvFNTYtg3g1VfjLHTyQgd2a_6OJVqsijy83Ec4aX87XNUsV8CyNZB
 .XD1.5fzzZpHMOwNDJhogC7gSs.1iwwW4Vfeh33aWrt4.IhoKE61dt5lBu8tVBlXu83.ludhzLyS
 SQvNnVQOg.Bl6N607UGJWLCvm1yboT73ozYcmUbVlK_QnXXXWhLRJlSRDvvh6ZH5Mpr2Szk4CYCI
 _QjKpPWP3jkcsoxE7bFOT4CEWlsULkEf4HatBXsbOFvrzdK2XoJFvQ0XlCIW4DXl5ZUeu3gCZZxD
 _eNYbYyNwytgp6n9k.rsKR0a.UG_clmC34yfpVAeJv0Ni4S6oZNTq9FkC0yW6Hgn9dqLCbvVj6m2
 Pta6DtNgWxBLvbQiOTsc.ye5woCugGSUE4uaALTiZaqkwZ.qPd2klfbCEqRg8r7tgUDNl9mVXkSP
 PzvKaUP0v_b6.TQrG6Wh6w76E5Aw.sRrVWTb2hQjNzH_C.sgrydaTaGkjkFnNecuAp3iC50Ywh8q
 aV_22JZTJCFlXKAso7FNWNvaJIOCPvUMY.CFCKNmcJrbneB7b8IfE04BgAIK.t878Im9PmU.M9ee
 GUxRR1QWoHtd3vjFR3bwdHfsBqpNxFUiWOuGODXBMdNtJoVeRYy1.RKOhR..PCj2XJz1XYq6JK0q
 e6I3P7SOww3vKLSBQwNmaOvz99W5kqi6.eCfA72LXRO_UKqWd7FkBCp35ZXnwPX.Int.8M4j_aK8
 8VKsFdxjR1POuv5bwZZlplPmpqXivqE0bAYozDftl73ECpPpNBfbzaTMvHIwQVXmwS1h35RZRzA-
 -
X-Sonic-MF: <val@NVSoft.net>
X-Sonic-ID: 8dd45ee3-a8ad-4b88-ab17-cfae92d27b44
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.bf2.yahoo.com with HTTP; Wed, 18 Feb 2026 10:43:57 +0000
Received: by hermes--production-bf1-697f88457-zqdkn (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 0aaf16e6cc9c29e6709d9246dadf7c98; 
 Wed, 18 Feb 2026 10:43:55 +0000 (UTC)
Message-ID: <f2aa0ce9-432a-44f9-a00f-511ff2579bb8@NVSoft.net>
Date: Wed, 18 Feb 2026 02:43:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Val Shkolnikov <val@NVSoft.net>
Content-Language: en-US
To: u-boot@lists.denx.de
Subject: u-boot top makefile
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <f2aa0ce9-432a-44f9-a00f-511ff2579bb8.ref@NVSoft.net>
X-Mailer: WebService/1.1.25198
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Mailman-Approved-At: Wed, 18 Feb 2026 14:32:30 +0100
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

Hello,
I would like to modify the top Makefile target scripts_dtc recipe. 
Currently, it's a long shell command. I'd like to separate it into a 
script in the scripts directory. The scripts of this length should not 
be coded directly in the makefile. In this particular case if $Q is 
unset (vebose mode), the whole recipe is echoed. Also echoed an "Error: 
" string coming from the scripts/dtc-version.sh called in the recipe. 
This confuses error detection tools used in our organization.
Regards,
/Val
