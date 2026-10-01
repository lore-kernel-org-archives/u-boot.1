Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94843CA5FC4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A39E811DA;
	Thu,  1 Oct 2026 01:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D8hYVR9uGCQo; Thu,  1 Oct 2026 01:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 880A281205
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790816905;
	b=jDkZVnqVrSxyfS36xKjAgW4Zcyse3F3fz2xtgvve0YNWvZ8fdWt9tQ37mfFem8t3fdoU
	 ZSv+g3wQDVlN8iHSR9Tcg+3U2BMSamFxtvbBGCRxIB9YCvCfN7GyzbknBc9x9ar44hhe+
	 xXEzkPQnLRN17EwPAe6t8yEF9hqXcqNX9mobVt91m/PlmfwkVp5pnoQXd8b7IUEEfeZWY
	 /OZAwRLItFHV0J5S7iYdGjvls+xL1DGhq2OSzqfbG3N8JSvUSDWE/0l2T3k6sRR6rsM1G
	 9Ppn6yx5TSnRrGBX/1Bg0tCEuVj8MqtssjOqd2VgHC9IfjeElmtDSrG9O76g+je9Zeg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790816905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BTwPKJYwo2OYRLeZgUgxnbPLDrclP7Mj+Pyj8KFcmCU=;
	b=Oj0IhBgu2sE7XtfRuJpPDNBGSxnTQMyZ0c5TATjfYbDf+owihWdcDNyEZHUoisdLbbu+
	 6+TO2zyzltoDqn59iOEyMVdmDx2JGuRoLdunrlGaMNOGvVJfw8+/Z/O04J4IM7GS/Ry0r
	 Icg04lKktCVqaFVpaBxOPNRkYOF3Vy1VjEFSqAcaH0wYyzlBVL586TNG2eGejM648W+58
	 aihlX1umtWEuTYgE80SZCWaCUPUax01ZXM35sI1gqA3rB6N0hIUpxgJ4QR8fLvaF5Ly3y
	 o3qPRHQ6BhE9LgfOhSmqoSPDXQP5g9DcZ4Jh0FOuB3hjmJ6zbQjYsysnJCAfIS6CwNg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NYBDKAys;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790816905;
	bh=BTwPKJYwo2OYRLeZgUgxnbPLDrclP7Mj+Pyj8KFcmCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T82AYDPl7FVisxRwq8O0LtlNxYTZ8E4SU6HrMaTQFDIN4erKaKwNaQ0nSm2gQy9Rk
	 cB24ybCeEMISzCLime6/kJZeXgowJsEvwjiYBXGHRUo1KJEXKmZLj0n8xQXlGu5FCY
	 Jp5HlKyfudLOMFdApnJkzmrvGW3W0FtBo7kMWcjrYnTUFFA7gbdXl+Vxv+Aok7t5iV
	 sALOjAmxe0WLDcuijVXdT/Q++htanouDxBGbDjVTQwenUe6Oes7xWfHm1v00DNKKrf
	 9sufW/S6/J3Dc6EZaBPqhldiSXs1TlxG4aFAabJ5Sbb9vzSRP0L1rRRYW7F05lSPw6
	 VQzmmqQq0EeXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 880A281205;
	Thu,  1 Oct 2026 01:08:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D9B8E1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFE1681205
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U_bygqmD9Yz8 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:08:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 319A2811DA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790816904;
 b=K3WhO+aZ3z2SUFLpL3edCRnpqqyT+5e6/rm3XXX5Pe3o9LvLXspgiI7r2N2i1gTFo7rB
 px2vYLuoNldHqI5IhlFIcjRq1DKXWXc7lkAzp56xI12tjK1u4O/fTio5e8F7tfYArH+AT
 jo9guwARE1kt3DoL3eG1/1/dENytl/AcTdmmZuGs35Qnf0iIokcCtlt+DQBSzb+8eDX82
 Fb7jUqv9QsZV/VeDiyps19cKmZpPsM7IeLdOAtKdVpc5th69Hhc1B6+7FwTkcbQ97s4jP
 7uIRmzUReQY4h5c6i6W1p/LfOy0xpn1r6gYPzNaNJstiNkCbMj9AqmfVT/vrr0lq1rA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790816904;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=BTwPKJYwo2OYRLeZgUgxnbPLDrclP7Mj+Pyj8KFcmCU=;
 b=DDS+cv0fpElAAtIztkgDfDhLBz5iiGtnKIF2WDBHh39zgT8H1T2gjORIgdo4lUTa1QGo
 41rnmjM6DudcuvM8keokHfmWMQatVy0I9KYt18lRdzU2MYSFcVTDpTDIaNn9Z4XO0yl9b
 Np9qBWLdDvEjSUR+mi3YZtWOUg5oP8pPENPJbYmCGWNSbC/JCBKwTwgUaIZAjD79cJTEP
 s3TWvjhqXrkyA2odi0iDLnfBYiV+asb03VzbWqvZAbJC3zaMWhlHQpv5FmlveGr57Irsd
 uHrdTctUeA0MCIQu/7t4+7hx89cP76IOatVNMm/wBU3eOMgOJot1X168Gk31ieppJtg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NYBDKAys; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::2a; helo=mail-pj2-x2a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=NYBDKAys
Received: from mail-pj2-x2a.google.com (mail-pj2-x2a.google.com
 [IPv6:2607:f8b0:4864:39::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 319A2811DA
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:23 +0000 (UTC)
Received: by mail-pj2-x2a.google.com with SMTP id
 d9443c01a7336-2e2d58a3b05so17796615ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790816903; cv=none;
 d=google.com; s=arc-20260327;
 b=m6nKOC4OWbE27SKjBLdsdz2RcCK26z96lBxtpG/iS5/XR8fKnZ92xWspwhPfgQSGel
 6+HVdIv3x9xkFr1hJxmrAdHSMLD6gE9GAdvke8jk0GxdmYzWzjvipZh7qSn1Xlsyxz+m
 me8fDOlp3phG+QHRvhC5ykOoG+gtnvxUkwwa1/B9sxW/SeuR4E37cOFGeqIK8Z0y8eIS
 t4+h2HphakCF4xaHvHLHxsDMYF/tXfQWW/hFWPSZ6yGC99nEzSoV65SQjlgcuWaSl1XT
 tbVbAhN2IaE6JdQFA5A14qx92KTcVBXct+YBXViXPyYy5TVOas5ErEQd1OSDySH3/6WQ
 TegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BTwPKJYwo2OYRLeZgUgxnbPLDrclP7Mj+Pyj8KFcmCU=;
 fh=eUfWL0B6YQVWBAj9F+91NST2RD1YPZwcB1AfxgpFHXk=;
 b=V4LewIBnNF2PLxjTWtVc3IQ9NYMAwyqQmIBnpiGtaMShaz4M2zIjMF8HP82bTeBnrP
 KLQekoddpUYUfBFti1ngFerrd5f5iONHWZkodfZrZEJJcMhLob1NcFVqEeRjdvBhcFu8
 jueIoDlj9Yb8q2CpH0PwD7EblWvrVuOMhTKO1UU6dgodwTBvzWlnEKHlwSH8iQOtLHr/
 6VikblXSchtkSi+R86hq6FfRaRzEIqpRgmKxSUviJPSCongwIR4lBtPTYB7uQniSt6yi
 /bgpZbUzhC6iI5YsPsgkRFdZqF5uLLwe2I/XsBlnXMzxkEM2OBbCoKvwS2MqYZN84Jm/
 tWVw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790816903; x=1791421703;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BTwPKJYwo2OYRLeZgUgxnbPLDrclP7Mj+Pyj8KFcmCU=;
 b=NYBDKAys5pQt/DXSHeMEC589ZQgUuLafz8vv+qRc7ppgz0P+ONKcEHX2uYKq7bR2Xu
 VDkZIvk2Ww8BPoRhVQ8Ko1MSSho2PnPoqomI7nJf3I/bh0/s0u0ONSiAe+Tx0wcN34TV
 bLdwUicOexhaRQAKA6Wj+p/vQ6F/5Yl/6M4TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790816903; x=1791421703;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BTwPKJYwo2OYRLeZgUgxnbPLDrclP7Mj+Pyj8KFcmCU=;
 b=soUpPE5oExhQNIsRsLIToNXpP7FHu5eCJmf2qmQEzZppbSBxWVvT/rLlOD4foCj7Kh
 1HBt2mx5YICiZbRIY889CJDC2OLUQFiJ+ehxggWnU+pfUTChPCJKcetjPBpEcJWE83sW
 Vg0Bp7xI7XII5I4XB9cDKyIj0MAU2lkDf4gXiZULurwVcR+xIoZE7st7z5YP0LvrnKvB
 OC3IOwykE395niZOaAaOyGtuk7uaPmxNafAxZRsy7phdMC2slzhCWN0X9CwIk+62jfQL
 Plw3VDVsxNvBY4SnvNZK9uZg01tLtg8+41hPyuJlycb4txc0HRuKsBA79pMm2YUYeaRr
 AYyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUf/VVfjkvZkeETTiDXC9DpsZQmhfpO4dmgddWtdYlZAPDvRZrvEKLZNVo0U1p9v9JerVUKz4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJKWF9PsP8y2e47+MMRLl3zvwPZMxu7OqOkAS2UPRHvF9Q76US8
 AhOTHmeZxhyjJQLc1FoR7UG7TGsXncEwXQAMD25tUfIqO3k4Vwjh7+egKTZbPeGI4fEARrCrXkW
 05PbYucWwrbMVdsCFjfKCFmI86uk/gMrQZ/z8HdCZfgyGV8DULEZbRg==
X-Gm-Gg: AYBFou3Ti0vYEtvDb4qvHgqZ/fiRdYd8PEnZfFezWA0RjwVGOh/6NKs+/o0g0KNFxvK
 wK5L+pacY4RleZ2NTVdG3ZIgJSXRZ2yRnD/OMDaLLm6o6W5btq1s4J3jQQlKqpFeEOpHjlGE7mK
 MqYQ89naviF2FxZfAFonI3EG+ea9bteAVlAcj5oT2Kmrc4lChzZ94E4uIBzBSrTZs2pNMDjFzCx
 GbY0eZei3rROU5AJjiyHkIYTsgM17TFjnbLXBnCYiyI9MJHVCcWF+5xB+JaKuShHFBqyTsQsduZ
 fI6NJrYT5+pye2Uko995iUQJWjmfxo2GNjwU8GRj1ptLTOyv04PHOUmt
X-Received: by 2002:a17:903:19cd:b0:2e2:d83d:5004 with SMTP id
 d9443c01a7336-2e2e4b2552fmr22979625ad.58.1790816903174; Wed, 30 Sep 2026
 18:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
 <20260930-imx93-secureboot-v4-7-f968a1b14dc5@bootlin.com>
In-Reply-To: <20260930-imx93-secureboot-v4-7-f968a1b14dc5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:07:57 +0100
X-Gm-Features: AclHuK9xQfQpL15sGsiKWXAbSfC8EBfoibLJIU0-fomfh0CgS0_QfHCkKqCoJ-g
Message-ID: <CAFLszTgF8AXoduXB_A_qxrQXA4a_OsWG36WBm5iKKr5m2TgDag@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] binman: test: add a helper to mock the cst bintool
 run_cmd()
To: jeremie.dautheribes@bootlin.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Lei Xu <lei.xu@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 2026-09-30T13:42:33, J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric)
<jeremie.dautheribes@bootlin.com> wrote:
> binman: test: add a helper to mock the cst bintool run_cmd()
>
> Add a _MockCstRunCmd() helper which fakes the cst invocation so that
> the signing path can be tested without the real tool.
>
> This will be used by the nxp_imx8mcst and nxp_imx93cst tests in the
> following commits.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> tools/binman/ftest.py | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
