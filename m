Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E4FC61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 15:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B19380EFE;
	Wed,  2 Sep 2026 15:53:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHtcHA6dGHIi; Wed,  2 Sep 2026 15:53:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788364408;
	bh=ZhHaWIs5fFDEgmoGYfCAfgdtU0chYvWiTZn46/Klonc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yoMfcdKRCCP8qPbM/VRN9aGQcLuODNLgfs2m+3W2hOoWIPv4eGW0DJt2JhoNGq3pB
	 PM0ZphSdLgcUT0VDVUas9Wye92seXd1yIU1m33wOkR+Dz7jQr9ZDo/DLEEWuuMj/pv
	 vohPVD9ibzecZe18xefOfQU+bI5IOhns+Jxx0X+DNYeKFxV29EQjUpXGjcM3adWZW3
	 ztMZ0FpxIbYiV7AG/qa3NT25/LctW342ODeePwG0sb4mWQOY8NmS7qB3q/lxJKsArQ
	 gSiqvlCaZqFG1FdXdtqujuu6ZKBmQaOCv+pQelU7x+4x6hJeeaZZR5k4yeZGowlGNC
	 H/9Qy45z1AUUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7885680EF8;
	Wed,  2 Sep 2026 15:53:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6396127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CF3A400A6
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5pgBBamh9af9 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 15:53:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=EwGbhQni
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A11F740099
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:53:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D53711CECA; Wed, 02 Sep 2026 17:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1788364399;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ZhHaWIs5fFDEgmoGYfCAfgdtU0chYvWiTZn46/Klonc=;
 b=EwGbhQniO3tMP91YcS9WR6kEq7qL8pGbicq1OLLQxLrPFWTPYDSBhcW+nfq2cPn3rtICbK
 LgfpP3UxRCl5qxlix6DW+9zaAxskDaCSo6U8w5STDFRlecBIhRD1slAqs5bmiKb3U0eTOI
 gvrSD1Uvdw+4ZPEMj/RSq0WISKA2AhZvyFERTLUkYpX2j+XOsXh7zvbvu6hoF2pBn5RovI
 lfUNL+Gxoz/HDldYGWsMYxh0GoukunDv5BJ6dl8+wRBq/nHkt5t4OvGCtQAtkg+KyULNLy
 VEAAOcp4YKW8RFD2DnIL+4fSIYpjxHqsVqGnVyUJz4RL6hagxT9H5LQszb3Peg==
Message-ID: <6ad35fab-5fba-4a79-b5fc-4819cf199938@nabladev.com>
Date: Wed, 2 Sep 2026 17:53:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx: Fix EEPROM address on Data Modul i.MX8M
 Plus eDM SBC
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>
References: <20260816232404.1223819-1-marex@nabladev.com>
 <CAOMZO5AOmyEbHS7tMdLaWuEoGgkOWSiVUG6Ln54ATPCUqWxCkQ@mail.gmail.com>
 <c5a9255d-b56d-4c05-bc75-f1a5688b9ad2@nabladev.com>
 <CAOMZO5A1gbzoFFc9PrvTpNBgz1WV8eb9aabhc7_EM2OqSjRvcA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAOMZO5A1gbzoFFc9PrvTpNBgz1WV8eb9aabhc7_EM2OqSjRvcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 8/18/26 2:04 PM, Fabio Estevam wrote:
> On Sun, Aug 16, 2026 at 8:58 PM Marek Vasut <marex@nabladev.com> wrote:
> 
>>> Does this need to go to main, or can it go to next?
>>
>> main would be nice, since this is a (long overdue) fix.
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> Tom,  at the moment I don't have any outstanding patches queued for main.
> 
> Please apply this one directly, thanks.

I have sent one more fix

[PATCH] arm64: dts: imx: Increase malloc area size on Data Modul i.MX8M 
eDM SBC

This is still not in main, so maybe you could pick both and do a PR ?

Thank you !
