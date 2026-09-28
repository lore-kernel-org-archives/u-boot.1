Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D06C98328
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 05:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62D1E80D35;
	Mon, 28 Sep 2026 05:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_8ijKCr1Bda; Mon, 28 Sep 2026 05:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A180880D05
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790571721;
	b=DdosBQuqcWJM38ByYM60vu+p3lk66+0oDfE/Eqj/5Er1pzaAsKZy+gP389oHTvx1L6Cf
	 Y+FH7C7OstlC0R9ZWdzj8ZQ/vcVIhgiO3/MOx+kr3k00jGSc3NtmrS/Z/IttnlSU9Jwj3
	 5MqqySk01IvLiBmol/z1PKHWWkKLlq9fAayDy7Kz7Ij5/l7ai7T73FEffgQNJKnpFTaLb
	 t+vJBJ52N/l23fiK4ehFP/gPsGygmlrhxo+a7KkKDp+q6kJ+InC/v1SFBjfG9FB0g7qSQ
	 LrbSO133O1jrRlPYh35QnvKm4P4kGGWHrduA0JITfI3cztRB1BGWLSnxOD9mNHms5Ng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790571721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=afy9CkBGLnmLkpaymBUGliuHs4/1XA7fBAyODrBpXTQ=;
	b=Kr3BG2s4tmggpMtvoQt2AZBJfBpzn61u6Ibx3wfWc6aQQ38JrYiU1yzjGB/60itwVmJy
	 +vK25dRxHTabnRoGO1muowCeVVuD3Zvvv4ZgD3EIs0rXzbOa3OjYiSIUXtpibV1ZlB4ut
	 HsXYJ/rR43u/56JcPpUmazh9ojkw3CGNtfWEpLE8OqAZ5PeeRExH2az2/2FkPpidsaFNJ
	 VddyCtMX5iz6b0eQWbfGB+4qEnTd+y0xyQD0iKakPGD3xMKWzUxsgFjSaSte9O0sr9930
	 RMscvSRH4fam7d/fmf+lA7Fdmsi1MTm/+kkHvPo19Mm5seL8k7XBo/t5OkJhko5f8DQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790571721;
	bh=afy9CkBGLnmLkpaymBUGliuHs4/1XA7fBAyODrBpXTQ=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y9HI9ggbuyOS5oyPQxIOeVItmdN447ui8H7iLMGodu5S6O4LNoQKX2uzhgo/ts/Iq
	 SH4UrhUTCA1/O+aGd9QmdtcJNifJyrBHDeIYK6BMpC6XSrozuca68c6M2ROkpYxZWt
	 XqBO+UklxhOhfmR53pR5Sy/heVGtHthDL6jmEUojayRlYNDWm/fktoHHkdZE9dK8QJ
	 t9Mrk3ztlJxjZota/ddA57ucNeQkkJV2IlC760gIF6vOPRvPw8Lc4q5JcoZ4f+3htn
	 nOKP/lY0S9WPtFN7x8Ju+GJ81JK+OeE+jEHlJWTS65oyo+33pcKeIvwHf7XNVFGwRv
	 ntHhuFoc8Xxwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A180880D05;
	Mon, 28 Sep 2026 05:02:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 79A583D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AAE6400F9
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rKoYuaONC-Xw for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 05:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 72EDA400E0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790571719;
 b=JujS5yszU4J/HLW4Ee6mIAvauCm797m64lg+33nAECM/eBza4j7Pi2kmD2l2UoYabfkj
 LXaYfkcCHnPoaven9syqIhjYMOJaKNtaGmS/HNyHvWmNkIgLisVH53dMCSQg7ZuKuyG+p
 IfYHfg5Jwq47pHtnphnaDtrGnbyjUqnKiPZ6ypvP/M31Q6vS61kb6u4tFpKu9XTJM6mTc
 cCJKvOvk7KxpK1D3hZ6upjzMGvkmiylqzflQ1g3PLmllutLkaIloz3xZblaLZ9YtnPIXM
 B5GXPhdXtgxVldS/u4aSX1HehopsI07OdEkpQ+Eab34CJlQFIugevXHSGWmEzOASbBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790571719;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=afy9CkBGLnmLkpaymBUGliuHs4/1XA7fBAyODrBpXTQ=;
 b=QrWThnos8jgGREaMXrOdxikBEeMz1iFmD3jzj5UqXX8M1FSMQ5iqRiMsrFvRiSRcuT8y
 D7dS3Y1xZgwojQ2E+AZS2vHj82DMimBxLPLWYdlR3n6md6yDX0wGj3WXEqOdgGUn/hWbD
 gkB1F3tXBVfoBmxe9zL7bRMYtO1e2nIK2tpIpKo8qtf4TOzH6XQ6L0n5Xcq15JwUQEs7v
 jEPdG4v5c8wH62Q4Z/6hvFRtDOmG4SRs4FHtEY5pLDpj7XvqWFVPBX9AzAKNTipAA6YjS
 CHW5Oo2uMCrgGyX2eWtdu/hBhAHfaziE3AbcANmbyp3v7vr7PmQZf00ZsNigSbjKb4g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=PpEed+b7; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=PpEed+b7
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 72EDA400E0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:01:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1DC6D106411; Mon, 28 Sep 2026 07:01:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790571712;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=afy9CkBGLnmLkpaymBUGliuHs4/1XA7fBAyODrBpXTQ=;
 b=PpEed+b7hNpRbotzmTsbmvXQWhKx1mIq+usbiB+pBtufZ/Nt2p50v1gAubZb2yDF+bbIy+
 bhtH4ZGgPQFrlSefloUaVgTg6HIU4v8O11VyFv+efgntWAF+prDKgCFbwo+TZ8/ZSD0O53
 thwTdhFHvnHMrKxEPsqbczRacOKqysPtb9c9AjjFgZPfM+gFKm1BgmqqA5A6qJWYyPNTtH
 gwY55lcd1ERQkbUxQ2hgb/umL64wWojMr/kF/x3JIM9rDozGb3Q3o1AFtZD9T/y3INmhVc
 Sz9B3sZBwWFuYpw0sN7vz3YZoZadZDx7LbVf5KMSVgxgpKUcFbSyc4wWT3YKzQ==
Message-ID: <ff7025de-4efd-cbd5-28bb-c78d2f302b43@nabladev.com>
Date: Mon, 28 Sep 2026 07:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Gaurav Jain <gaurav.jain@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Peng Fan <peng.fan@nxp.com>, Stefan Bigler <stefan.bigler@securiton.ch>,
 Tom Rini <trini@konsulko.com>, Utkarsh Gupta <utkarsh.gupta@nxp.com>,
 Ye Li <ye.li@nxp.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Simone CIANNI <simone.cianni@bticino.it>,
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>
References: <20260922052700.528451-1-hs@nabladev.com>
 <CAOMZO5A25F+JPPPYgCSUOV27=auCbrsdHqCJ+6PVvzV9SPx-pw@mail.gmail.com>
 <3286955f-614f-5238-b1c3-1c5807dc21e5@nabladev.com>
 <CAOMZO5C0oaKnmOpnZF-NwMV=HyZUvdYTMbxqKZyYdAp9xVYAnw@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v1 0/2] imx: deal with the RNG self test of the i.MX6 boot
 ROM
In-Reply-To: <CAOMZO5C0oaKnmOpnZF-NwMV=HyZUvdYTMbxqKZyYdAp9xVYAnw@mail.gmail.com>
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

Hello Fabio,

On 27.09.26 12:41, Fabio Estevam wrote:
> Hi Heiko,
> 
> On Sun, Sep 27, 2026 at 6:01 AM Heiko Schocher <hs@nabladev.com> wrote:
> 
>> Ouch, I missed the gitlab Email... sorry!
> 
> No problem.
> 
>> Okay, SPL gets to big for board imx6dl_mamoj
>>
>> What can we do? Simply disable the new Kconfig option for this board?
> 
> Does enabling LTO help for this board?

LTO is already active for that board

configs/imx6dl_mamoj_defconfig
  15 CONFIG_LTO=y

builded without it locally, and LTO saves 3328 bytes.

I builded locally with another toolchain (Fedora-provided ARM Linux
cross-toolchain), no size problem.

I see only 2 options:

make the new Kconfig option not default on, or disable it for this board
in configs/imx6dl_mamoj_defconfig

bye,
Heiko
> 
> Regards,
> 
> Fabio Estevam
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
