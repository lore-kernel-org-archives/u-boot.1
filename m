Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B278606A31F
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xC05pOcD;
	dkim=pass (2048-bit key, unprotected) header.d=iro.umontreal.ca header.i=@iro.umontreal.ca header.a=rsa-sha256 header.s=mail header.b=GrLXS6xL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BB8D816D5;
	Sat, 24 Oct 2026 16:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dnx7nfYXQc3Y; Sat, 24 Oct 2026 16:13:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 506B88167B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792858397;
	b=nrVnYfIV74OBLhFrgzuLm5xcEYd8JhYulFup5dvLopExaWMyrzeSowAGNYazHp/H/zU2
	 NbB5F76XjbqFn7T6BL5Y/o5Pwh9Ydf7OTQU+mnqEfmBckBHyDFViQzW/RA7b/VXMIpOqy
	 tdpYcipZUMiBiOWGnNbeE1dPtdRQPvtaRgOTPPD5SHqF9u6VYj6l/gfz7Sh3s71/B2M2+
	 9Z4L4cyvtt6r89n1T2WnTB4zjefvgviodiRTIrS47g+ApNe4ibyRP6xlDHDohhaRHBK0v
	 +a5pO+2MMNbXPAKsJltqqw38CAC4rUIUW3xOO0QXvmgcRNuc1wfuY43cvKcz0Nm++8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792858397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:Message-ID:References:Date:User-Agent:MIME-Version:
	 Content-Type:X-Virus-Scanned:X-Virus-Status:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0TkrtQ+c1xJD7Ct34L6tYzAgChRd1jZ7puWQ7/NlxRQ=;
	b=Y8DCW+1lo0mjvT6HSxVH4YC8NuwGzonOQQ1U99n2xdSb6AkITrKWt84SbkDfFvn/weWK
	 9lIl7kegQNNyA9qD5D+WRjytePyOnTbziCkWQc6aQbFxHDkJMWwSxkxXNhzNFw1yLf/HQ
	 LPknosfhT7w4SeR6WYUeEnEFuJxwMAob8RbAmohm3LPOik2HgZI71PAnTOTkfitR2awHj
	 juDqJAkcbMF/5jzfl677iRhj/ItfalV+rcm7rqwdk4Pxp8cMpUtcWLfc6e43Hu02XTByD
	 75eGb06KJxFKCyE/U2VzOWDwumD+Hg6Tcnaptp0j87Rj17q3kIGHhQ7Tfnx461KGbKg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792858397;
	bh=0TkrtQ+c1xJD7Ct34L6tYzAgChRd1jZ7puWQ7/NlxRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xC05pOcDDiG9YMsgP7H2tXLuNZ+XqHWv0TRLWRUOWwjl6PCB4Kbd4RzdwYJ6Q7oaA
	 Ty7+sBhO2PkzOMGCulXzIrTPHZSqnsL4kiT76dGYC4SoIlSKW3XUYD9jtA568eQkp5
	 bMAIMUT2f5dqLpGbPtlV4W+uRBi8aOZKaLbp6xpo5ENHug+ESPEb34LH2bFG7vbQHK
	 c5sCyd5ntZUpm133g+0h463T8+nX+UXrXEQD1x/TwAQ5tW+aUDB6AiOTnAL96JskKp
	 NO4jb5PQuiKfDgkfFY74WEK0WxoErRCFVRcpvVMIIJ32oTFMLycmaBQ/1Bx+U2qhGI
	 ZVF3S+3E8eRfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 506B88167B;
	Sat, 24 Oct 2026 16:13:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 646533AF
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A2DF6064D
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id inCAvCnamtnU for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 15:15:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AAFE46064B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792854906;
 b=MV7HCB+QvVTdq0b3mOawo5LtY7IpQ5F6CZhaS+qJfr41K49uMspC0+q15MzT67enw7cH
 PenIExaGBuO/e5vSVKrLubfX7PbtBUjRYbJHbXuvwMlLERgH89wdfLzdQCBw++psy4hiS
 PyxnkI7LrNjHuuHOftNEwEOD6d7536SEkUqfzPUySteVoG2ydihiHD5pkkURHG99eIatC
 kpN3QQZi+awsmXFYSags/nSeBKfHOtZ50kKNUZRDrPa67gp16dRaMDnkRuVgUIWgcpDVC
 icTfscHFLwyvecJEpz4Q0PUeTC4qX0VIuOEdoqoyTdB6/3djo7gn+b5bqS1Fv0dibkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792854906;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 In-Reply-To:Message-ID:References:Date:User-Agent:MIME-Version:
 Content-Type:X-Virus-Scanned:X-Virus-Status;
 bh=0TkrtQ+c1xJD7Ct34L6tYzAgChRd1jZ7puWQ7/NlxRQ=;
 b=DaGQtYy97tRQiS1vdKSswfAsfR2jp2y7KHYi8VIffd2dUbOvZg4iKH2HtFZDJ/k5fth0
 zrYs5/DzODibvdFpJFELamgOdBgcoMX3vwO98B+O2tJs0qOtxLDTVr/oulYrnoxyClLja
 7Nuy5Ik4YtVEeKOfbeqfHPL2rc+BlRewHN/4uEfgV0NZ7EU1c3jaMeHUpEZ314nKuyQ0E
 cLRI7qQi4IAaRntJz7sq3R5LG1ZkSt+lQZaYJNARQs+QvBx/umF9PBAg5PJQXBb9ulx7W
 yf9PCiUynsSSELe8MnaLj26gNp/1H3Hr3DYu0zO4ujSFRIHukWbFswVC26XUpnHP8UQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=iro.umontreal.ca;
 spf=fail smtp.mailfrom=iro.umontreal.ca;
 dkim=pass header.d=iro.umontreal.ca header.i=@iro.umontreal.ca
 header.a=rsa-sha256 header.s=mail header.b=GrLXS6xL; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=monnier@iro.umontreal.ca;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=iro.umontreal.ca
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iro.umontreal.ca header.i=@iro.umontreal.ca
 header.a=rsa-sha256 header.s=mail header.b=GrLXS6xL
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAFE46064B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:15:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1CCD8404D; Sat, 24 Oct 2026 17:14:58 +0200 (CEST)
Received: from mailscanner.iro.umontreal.ca (mailscanner.iro.umontreal.ca
 [132.204.25.50])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBAD83108
 for <u-boot@lists.denx.de>; Sat, 24 Oct 2026 17:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=monnier@iro.umontreal.ca
Received: from pmg3.iro.umontreal.ca (localhost [127.0.0.1])
 by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id 389154413C9;
 Sat, 24 Oct 2026 11:14:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
 s=mail; t=1792854886;
 bh=HAdwHJtGsMya6yck4CFSRP1XzfsicjUYM8V2t+AvdPQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GrLXS6xLgMWXPfM3E4njBIXvtGguZ9j2a2SgcvD2mZehgr/RxGgyTBy/o7ALV0FuV
 qLJjQCX+a98oxWTxU5aPjI7EFQyNksd3f7WTEfbXrNvwbzV+tDaXnDRvDXDclW4Oom
 uRVMYCdXJh/DnDFcnfhzE/i9jrPFb0OqioCr2MvDMUeADhoWBPjer1F66uYcQvWjm7
 LnRoC6Vnd3lPowV8uxRvejjemTiLQHjXk+ImXBzxdwgbKACvlOeRpcRTiniPtWCMTk
 z/57S+2d0u1NTIQCaD35x6AW7MuhYOA3jQnu2Sj25eqiDFIaQHKe062p6rFoleSE8X
 +4Coj6/X0h8CQ==
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
 by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id 48184440552;
 Sat, 24 Oct 2026 11:14:46 -0400 (EDT)
Received: from pastel (104-195-217-152.cpe.teksavvy.com [104.195.217.152])
 by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id E3171120403;
 Sat, 24 Oct 2026 11:14:45 -0400 (EDT)
From: Stefan Monnier <monnier@iro.umontreal.ca>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, Alexander Koch <akoch@initse.com>, David Lechner
 <dlechner@baylibre.com>, Flaviu Nistor <flaviu.nistor@gmail.com>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Takahiro Kuwano
 <takahiro.kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, Vignesh R
 <vigneshr@ti.com> 
Subject: Re: [PATCH] mtd: spi-nor: Indent SF: just like other boot time
 messages
In-Reply-To: <20260611224544.210172-1-marex@nabladev.com> (message from
 Marek Vasut <marex@nabladev.com> on Fri, 12 Jun 2026 00:45:19 +0200)
Message-ID: <jwv8q3ni16j.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
References: <20260611224544.210172-1-marex@nabladev.com>
Date: Sat, 24 Oct 2026 11:14:44 -0400
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sat, 24 Oct 2026 16:13:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> to the fixed indent:
>
> "
> DRAM:  3.5 GiB
> Core:  310 devices, 34 uclasses, devicetree: separate
> SF:    Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>     ^^^

I'm probably not the targeted audience, but FWIW, I find the meaning of
"SF" non-obvious, so maybe instead of adding spaces, we could use those
3 extra characters to come up with a slightly more
self-explanatory abbreviation?


=== Stefan

