Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6E0C624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 22:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D2EB60603;
	Sat,  5 Sep 2026 22:21:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GSCRx-HQrpar; Sat,  5 Sep 2026 22:21:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 670D2605D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788646904;
	b=qYaaGrtxlRZWYPxM/dmCpOcFOCUosnV4kjU4khRHH2JyxehwlDJumXiklnCkAjuMReUf
	 Ae9JblAf31o1ilcPuaisZmyAXF/Q8+koMhziIFJ2mZtw2k5tiu8BYh32hXiIoDNHTYOk9
	 6YDAh1PJLUrT+1mFSgAfJ1riqBlfD5gEa/JfWeqGLkPI4tH4TaJ+JEzY8a42+uo5NHYWM
	 F94Uza9tcGvCOzS2wgTWPz0GqsvxeakLpmkt/wJhE83t3XRUB6fa3/mp9y6/DSwXZ1CU4
	 DW+f6ZmKF7b3H+cdEeYkGa6pXO1HZjdvwQUdv1mc1a7AYqMvwOJozQyHSSUf+PMk76A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788646904;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WuSt8g4Dmx+aQvKaBEptdIWjXGZUMY4qtl0VicMHhFs=;
	b=YWLPzY3/mMN97Own1c+9Zk+e+91yUrypWRRXFOjJoYEf5GObnUbO2Tp+4sztO/q6nEPc
	 6N0pQcZLrXri65yOjM7tVbcCxnNhnwu1LKq3dOsd4tKuLkjniSWlBBnh9/xuc2mz24q0E
	 M9n7qt2t7LoWlNe1s/CG90ENScT2jK22XAsoKOg5mdd1LtQZam7/PU4aGSGrRsrlH4lMG
	 t2AhR0chr6MfmhqPpOL7fGFnbSgUZdaU3cOEALKlGLWJKv+Xr7M4rKDqUMBGq5ngdeB0Y
	 P03ivX5TY9VVcyG+vKvknaGfYYTvW/3gg0Iyo1imPkTHDN2yJa7QSvKOtaHCnsfukFw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788646904;
	bh=WuSt8g4Dmx+aQvKaBEptdIWjXGZUMY4qtl0VicMHhFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AnH2Fx3+uW808pKSRmjll5lYaG6sNhxiIi5Q2veaaQAo/IBI05CIOE111CI+nO0Ka
	 o5a8wlq8WxgMl2C8xePfIR0bgv3yEV2HOQJAJGDRp6k5vER9zvrVFj1xs5ugDUtVK5
	 zCpsJo3QnSCXE1tLgzCPPO8QOWvGIyNAckyfQdXvTEnJu76jVMizv5a/ygLWko5Fr4
	 ohtYqLE+//R1LKudVFGb8tXUPJOwotV98qykrn4R9RKUvf8Nu1tFpNYEtTThTmK3cq
	 HlUqlWu5hlqIjs4cSEFIF/dxdTS5uPmT6nBNu6AdiADsr2QOhWfPtLoosCMXBymd1u
	 CO0sYzyu5oJww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 670D2605D6;
	Sat,  5 Sep 2026 22:21:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C0A821134
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 22:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B24214062F
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 22:21:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sDHGY-wICvSe for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 22:21:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7B96E405E7
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788646902;
 b=EE1ieP+xY+h4ZOEh5Kb4hOvXr7p7CNmreV73OW8FDkHd1sGObA41QVm910q8H4bJwOeJ
 /MTtJgV0vZ3RsgwXBOGA9hk7NuvXkAzXpu2SR4cGxry1xG2iB5g+ognhTIMEKkDyeodWy
 LuM4tk58BP1axDHq81URT/Ge2nQttjNDr4X0QttjIyCSQn3MJgftwVkVxaJylPf3vVXW3
 ZKGkXnlmuYZIWD6xxwCu6AG0yogvTYvBKb9ofH3NDL+PgzyRBmxTy3bWl33VoYpfpy3g0
 4dTro4NB2h+pFezfp/t5iUrEm/+/wRXfzgKUywnV93M1RUgGV8V2/HFOx4RYrWlUAhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788646902;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=WuSt8g4Dmx+aQvKaBEptdIWjXGZUMY4qtl0VicMHhFs=;
 b=DkuRmZF6B7Y9vLrKp/s2+kfo/ENVhP5Bg0d0buJjjVwux2OZSOjDiKIE/aaafL/5ft5P
 +eO6pQ152JeOGNyOGFKyMPeNjq5fjuMgwHthG6Ku10QqPt5l4nJTYNel4izQbfSFzm/WK
 AduEYOQt14dIbayThvF4RPhphcNihhBQPrdf1KMuq6OSYtJaCJW8lgROyIIIJ99SgXCgF
 yTk9vfdIKTsHGdMPtEL5QBx6E2FS5kmAAC2mQLODQwssNsT7GvEF4KwpKJFx2lV2RZjM2
 uIYjXm+Ik2qQdDfEVzsb+fRZpgrD+CqRW71FGOA5c8F4C2IEtsNjxM59Ylb0G3hnTqw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=KR5vrYix; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=KR5vrYix
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B96E405E7
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 22:21:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6FE3D11D949; Sun, 06 Sep 2026 00:21:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1788646894;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=WuSt8g4Dmx+aQvKaBEptdIWjXGZUMY4qtl0VicMHhFs=;
 b=KR5vrYixsJi3zSTM7IogHUxH1LHPZZcdffpwziASJkFBeExsA7hkoMBwQ1K/H+pPLwcC+d
 XuiXsFOdFpmnG3sg9pihvEfQHIOvTQOoL/F/2VuuxSDiXYMjGwbNvVdykLk19YPwtdm/M0
 dN2wRYZSLG5oRLAnP/RtLRNuPFa/8xcZFmlauJHwlsJTNzB2BZ4mgSq9wDajrx3Y60wsgR
 nkKaKaorAh5PldP/pa/20RdHu3N0PotgeV/Kj1iBrCJpUXcsVxlyCQjmbo4p5thZS4Y6qL
 qZA6YP6NUoG8H/b7wtqyYxK5XtSklhtpEV0uFJEpg4EHeIzENg8YGkmWPqJLcQ==
Message-ID: <b65aacf7-15bd-4f5d-983d-8f1175406410@nabladev.com>
Date: Sun, 6 Sep 2026 00:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx: Fix EEPROM address on Data Modul i.MX8M
 Plus eDM SBC
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>
References: <20260816232404.1223819-1-marex@nabladev.com>
 <CAOMZO5AOmyEbHS7tMdLaWuEoGgkOWSiVUG6Ln54ATPCUqWxCkQ@mail.gmail.com>
 <c5a9255d-b56d-4c05-bc75-f1a5688b9ad2@nabladev.com>
 <CAOMZO5A1gbzoFFc9PrvTpNBgz1WV8eb9aabhc7_EM2OqSjRvcA@mail.gmail.com>
 <6ad35fab-5fba-4a79-b5fc-4819cf199938@nabladev.com>
 <CAOMZO5C-PVy31xtQkwU++0VVMxNWFqqF7sLsf+S67tY5CvS-iA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAOMZO5C-PVy31xtQkwU++0VVMxNWFqqF7sLsf+S67tY5CvS-iA@mail.gmail.com>
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

On 9/6/26 12:06 AM, Fabio Estevam wrote:

Hello Fabio,

> On Wed, Sep 2, 2026 at 12:53 PM Marek Vasut <marex@nabladev.com> wrote:
> 
>> I have sent one more fix
>>
>> [PATCH] arm64: dts: imx: Increase malloc area size on Data Modul i.MX8M
>> eDM SBC
>>
>> This is still not in main, so maybe you could pick both and do a PR ?
> 
> Yes, I'll pick both soon.

Thank you !

> Patchwork is down at the moment, which does not help. I'll pick them up soon.

AI scraper bots ...
