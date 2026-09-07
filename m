Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2C7C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D28B80AFB;
	Mon,  7 Sep 2026 08:24:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bZl_NufX314L; Mon,  7 Sep 2026 08:24:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9964380AEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788769497;
	b=KBHU87fRTl4HhJN6APY0/32wo7MSfMDp78540SKAwn7ucirXRkWz3vSO4+FJ5D1GQ4zz
	 bsjWUsp+EUgm9BWUFdUM5lXJIAb94D9a/IC2I0tS2gZLXAB3W/UCZjrUVZeikHrhWV+o5
	 EyhBH9k1nrXRYqYOGbKau92n8q3vDVODPtoiy43JY/5eFxAhPB6PGchMW/DrxKUDOl8S8
	 lHhYdUav4Cgjf4WkKtioCutbabmGQrI4F17BINOw5D4mld9hPPF9FzMMnoErKvlMRWsq8
	 A+rARemhkg0olHjzSE60eZUusnuLrmSxadiG/kMBYIHaRgjuGtWXPRZA+4czkRZOUxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788769497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Virus-Scanned:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UaWQJZPkRAVIa/QYYwip8mtBu8LYSj1C5uU2vMGzaws=;
	b=tYPjZa1cw0wb6nhsaR/mZNN1HvuvsCO1+RQtCEbiLRQwa2wsjuznncn0S/rnFSk8p2v+
	 Xjr9EJYFL2SWZ1ttQfQKWpl8XSVIKhJ2SL1DUbgW6efBz1XSeeACIvE4H5Xndes+1Y+xh
	 QUaDO4qWlGvSBpBXtGpTFlHJ9HCbCRR584bOvHdWUuJ5HRLFe5mKGQ2opD7bGMXNtVqx/
	 4+Qh+U7MO4dZHhjIJJAY0hcZ8CG1DIhSDD3Xt/wB24KzKt03ujDSDbCMllKzW5XD4gr2A
	 TOU0WUhXVTGIJ1rESeVYE65HdJcM4Qjn4/17UH+SgOy4Hy/VfCXBMjL61dGvE/ryKtg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=E+VleQsL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788769497;
	bh=UaWQJZPkRAVIa/QYYwip8mtBu8LYSj1C5uU2vMGzaws=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GD27MI++N/aKRIIH2bIYueB/GAZ/4Rb0d2i404ud1j8JBeQ545MDgwcCuivsnkXUR
	 jkHemlKh3wq6YkN9HhsV4pBeP5hQHkPHNE1me1yoenTsoGKj+x/bR6XQz3zaGhMtcY
	 nKUJu4irF7AsvDwvxxKnZS0/1U8DBp3k9h176GeJD/oNv+Y93Oe48Cil8xAav9g5sQ
	 k/S2DunfwrcJaNS3A5NR5iPwbh9OEpuYxVUn++w4fd019OMTBHdhUyx2XXIkd/eXcs
	 VPNJ6ZskcQogeUPLU6MZrYfg5JUKnuyDx5qwA1t5xpjvFkKPoOuevGXjWyoaWGoP49
	 vUzg3cFtUqFuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9964380AEA;
	Mon,  7 Sep 2026 08:24:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 94D3172C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82EBC80AEA
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:24:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id doq4CJ1tfDJg for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 786FA80AE8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788769493;
 b=j5ZhsYTBd2Q/Q6dpeQsHeZaTVw/nLqKz4CIdxyUCYqowOeY8OfEAC9BvXbxRTMjhs2Na
 /TDeUmd+m/H/MfVuBl4N4HWh8M5z+qySzGGZgRsPMLNZaZdYwY1VPZs3beTg2dzmEI7CU
 vs1Z/cY048knZOoC9fqhA5mV4QMOaAqjsh7NnP4ovLWgcnr8ly6ltuWL9G5ufhsmqhblq
 yxOCstoMZhZb5+aBeGHVQFs6oXkLwK/gDQTDAXHvn7hng663aFiSNaOiYLdrF1QPvPI9j
 ANXHStmU4ovXKvjHchwWbcn+GHJ9ZGKuTYshxphxXdAmltnYBI9gREC7Z1SClho769w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788769493;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Virus-Scanned;
 bh=UaWQJZPkRAVIa/QYYwip8mtBu8LYSj1C5uU2vMGzaws=;
 b=jbFu7gRngeXgBiRbhCycGrMAEN8yJFAfYHAvOIvlmMsTLA77uuc5kvmIMy1Pf/403F3j
 F7JTQOM5xhAMzxwEg0rFb8D67rq79bh7HIv6Ztqs3MsctpYBRlArEFNBqcCIb3IBLFqaG
 bgjFaUGukHMGg+kuNZpyxGJUCztI2WQJ1tMJk8Wka0FQaAXSefQ+b04bFctH1HCbPXma/
 bNavjF3C17H1znOweQaaJRneFMvM8ZgeBPXbk7wz5yDxfdmFjTwsK0LErAEblTaRawsyz
 ZH6SqKKJ1nx/s2TYaVUkgWAi3+RZeNBblTc1P9iZ5Ifo6swZtPw8uYeic8LM3uNE9yg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=ew.tq-group.com; 
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=E+VleQsL; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=E+VleQsL
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 786FA80AE8
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=UaWQJZPkRAVIa/QYYwip8mtBu8LYSj1C5uU2vMGzaws=; b=E+VleQsLuoSeQn1LDA6I9JqXog
 S3ZwbFxMa2KjRtik0f+rVQxcdmwLj+37XIxsBDOI0JctQfYj9ID+GsP4sSJYRP2PXuKacOZka2btM
 u3MBQLmC19NfdtMJNzqw6ZVFLKzODSuhWt7ct+iTs4urdk9Xe1X0dEUhgQyK7uJBN5tlUtzZam0VO
 ZtQZZhWgSGw3ToWjpSXbij+TI32at8OSMYx7vIu7SPxZRiuc3Lkr2P+068HDenF0h94E/7p0soIfk
 YtwnhA8Z+AR3dgjEZ80MdtgucD3380+Rv4JaPhwAVz/naEXbq7fJyLt+fz6ekruUYIPV73kLPNHj7
 vVF3hiGw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1x3Uek-000Obl-2u; Mon, 07 Sep 2026 10:24:46 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1x3Uek-000D6R-1k; Mon, 07 Sep 2026 10:24:46 +0200
Message-ID: <7b9f9f2f27e8f35a4728a41105ff95d96daed0cb.camel@ew.tq-group.com>
Subject: Re: [PATCH] board: tqma7: imply the DP83867 PHY symbol
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, u-boot@lists.u-boot-project.org
Cc: u-boot@ew.tq-group.com, Alexander Feilke
 <alexander.feilke@ew.tq-group.com>,  Peng Fan <peng.fan@nxp.com>, Fabio
 Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Date: Mon, 07 Sep 2026 10:24:45 +0200
In-Reply-To: <20260904131855.43972-1-pengpeng@iscas.ac.cn>
References: <20260904131855.43972-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28116/Mon Sep  7 08:24:32 2026)
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

On Fri, 2026-09-04 at 21:18 +0800, Pengpeng Hou wrote:
> Kconfig expressions use symbol names without the CONFIG_ prefix. MBA7
> currently implies CONFIG_PHY_TI_DP83867, which is undefined, while the
> driver is controlled by PHY_TI_DP83867.
>=20
> Use the actual Kconfig symbol so the board selection can imply the PHY
> driver as intended.
>=20
> Fixes: d000ce5efee3 ("board: tqma7: add code for u-boot with spl")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>


> ---
>  board/tq/tqma7/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/board/tq/tqma7/Kconfig b/board/tq/tqma7/Kconfig
> index 477ce3f3d53..afda49bea4f 100644
> --- a/board/tq/tqma7/Kconfig
> +++ b/board/tq/tqma7/Kconfig
> @@ -82,7 +82,7 @@ config MBA7
>  	imply CMD_USB
>  	imply USB_STORAGE
>  	imply PHYLIB
> -	imply CONFIG_PHY_TI_DP83867
> +	imply PHY_TI_DP83867
>  	select MXC_UART
>  	select DM_MMC
>  	select DM_SPI

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
