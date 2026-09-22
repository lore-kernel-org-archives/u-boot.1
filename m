Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F4EC982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 05:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8E9980BFE;
	Tue, 22 Sep 2026 05:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AAOR6bgnBnU7; Tue, 22 Sep 2026 05:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4AB4A80ACC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790055493;
	b=oskVCDbV79ZoBVPC/wQVRSqkJw/vVuSBhSnITJul/8mtiExbtBo9PBJwZmbMWYlkxaWa
	 5IcQbquMzvaT8WO8vaQTJFZkRG4MqOzhsuI5bcMaVpDpXux0gElw++Cq54ocEUZGpMukA
	 y6s9eTP4kpAa0X/5dTy82HbcQPkrmS3tcnmp2dgERVVRGRh9oW8hUQ/HOVuWytzwmiuRq
	 hrZMKs1to5U46ZL2jO/yeDnEcbMOdJiXrPrYZiCK1yKgK5Wvk7GZ8DFjXkMVMXXt0FN9Y
	 p3HDIccSwubLDXo2dOOAIsFMHwAsoXux+VtFOOLVBXP273Fz5KZpSx+qU4XqKTncJ8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790055493;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tUJmelnIiqSa39BEJEhj28hAge7pK4brkpuDVqzeDsM=;
	b=Z4u3rAvFZBKENhGeR8fJ1JjCbhUemOiG+9e03jj0BnfdPm+GlHZikSpMqVAit1gPr2qw
	 uMYoiADk037FUSNyS61cJIbZkWFCFbxZjri0roQ0Gc2nrSAptA1sK/48isNLl6ivt48Cz
	 B0hPGm2OWZClPg3MrxpDyYTJbuOMMUd9uaMiIzh8IqqEhDHR92wrkDVbM0BM46lfUAgyH
	 h1lKvK3uNj0b/pbtTXPerOztSnJtvg/AkE21c1AH9qx9YFSUG9XrJ+WDbefI20qgVPTgC
	 y++qurcQvAb5LHIfW/ouEWnALklRDt350bEf1afWHtjV+QL0B4xtwX6MISfcjp9qxSg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790055493;
	bh=tUJmelnIiqSa39BEJEhj28hAge7pK4brkpuDVqzeDsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y0JAG3b18+ejBNRGgtFmeobgcgUwfOzOYUtPvdbpqWweCfYRPPwntG0wpWRpzpabr
	 x9/bsedEOt9JOycQ4D2xXlTCrTlJZ6JygxGH3/3GIRjZru0l1OLBqohX8rIMxDaCFu
	 tYVsuCr84NZsnBT4o2XcPupNHnMWJj+YeMA6MC4qTEbv/s0qA/Y+w2qNQ98JHPUc3c
	 B3693RQTp1oblOvNjAsTzVfIdoJjpJQe/AoDSG1FFbg4XFV1X5PykQNX8sCT9m7q0G
	 URCrexEBYuWeVBEiJ+R08x1QZy+O7uNzTziqlW5Vdxf8nSDlZ343JIvmt5VSfZrAfI
	 giYJtOSeKiSbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AB4A80ACC;
	Tue, 22 Sep 2026 05:38:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B56EA20
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 520A940090
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:38:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FpmmPSWNdhSw for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 05:38:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DDFC040061
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790055491;
 b=FXYLPXzZIoNRGHGqo4SLTim+vF9mC87GcFESsJverCloRtc80bYZdGhThqybQFvlWjXJ
 MqjVwSYL7OEYTPQSOS67wX6PDz35NzdE3pZx3DQvT68S1t+ntu6QmKLm4453+/c0PwI9p
 gDgX0fLX2QAeSEJTQdnJ8sjZtasblMQae2gwZd66Uu9hBYaEnInjJjA8PX9N6LrdWkFVH
 DleHeR47oSpnlUOeTqs/tghfZonk+acF9L9cuB6Cy1WScq3CQKkFSvuDjNxpxA0jIHu3z
 MQliwyfNJNjdDFZaHAs2LwtOzmnmQ3WD7RqSVYRhEgzUKLP7evFwBhXQhKScVpAw5NA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790055491;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=tUJmelnIiqSa39BEJEhj28hAge7pK4brkpuDVqzeDsM=;
 b=nq/8Ce/Gs1/zxOWFw5xkce7IZlSWDnsNX+ujHUDqW3GSd3Mlq4+P7AWBxPJJz0M2hevt
 3fSrhKcOSqkC3XK4i4r6AxZIwYa8SfUWyxeYOcJChJb1IJP5DXdVK7nlAISLsik5gf8fk
 lohzghVE7Y+J1SFdN57uKYWpkcAStCj0L9xrTL/fuW+iYh/2yFKdeOh34vTUl+due9Not
 oblVLszWf8GNQ+kuZjWegw24qf0+LKXW4fokQ4H1I4GR/dq1LR4PBfkWxZsBcKqRSWeCg
 KVKcw4/22xrJina0AnCYelB5W6rLYZoUShvbQvER1vvepKg43fsaec2Zc13e2SldsMA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=dolcini.it; 
 dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=OOnw+lg7; 
 arc=none smtp.remote-ip=217.194.8.81
X-Greylist: delayed 58036 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 22 Sep 2026 05:38:09 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=OOnw+lg7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDFC040061
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:38:08 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 7F1F91F8DA;
 Tue, 22 Sep 2026 07:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1790055484;
 bh=tUJmelnIiqSa39BEJEhj28hAge7pK4brkpuDVqzeDsM=; h=From:To:Subject;
 b=OOnw+lg79Xv+iAr1SI/IecekGKAI38D30Bchn/PAeiwqxJumeDV5TvSjEdKKZRn7J
 ytDBndGGhfCM+mN8HDtTc42JNbSwM/mVA55bWP1Y9Xn90cA4F9Y2hZYK5XytAqfV/T
 rouke8+iCMEeP+ao1mGkQ9R3aretcCkDHAFBVahivg8gPWIB+k97tUJgSMxI/xPHK6
 3YBODrxkDuPZldMPNiAJsLK7JGo4N9MjSWDINr+zoXIyOE9G6zFgFKj7tSv73ZJQyL
 Eo1mHhAdFYTtuVV7iKn4gkMeokx1/Aedn/Eh8g57qkhGo2PNWdZerd22sGhbowenEB
 eIzCb7+k3oydQ==
Date: Tue, 22 Sep 2026 07:38:00 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: ye.li@oss.nxp.com
Cc: festevam@gmail.com, u-boot@lists.u-boot-project.org, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com,
 qijian.guo@nxp.com, francesco.dolcini@toradex.com,
 emanuele.ghidoli@toradex.com
Subject: Re: [PATCH 0/4] imx95/94/952: Enable early icache/dcache in SPL and
 U-Boot
Message-ID: <20260922053742.GA8706@francesco-nb>
References: <20260922022406.1838737-1-ye.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922022406.1838737-1-ye.li@oss.nxp.com>
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

Hello Ye,

On Tue, Sep 22, 2026 at 10:24:02AM +0800, ye.li@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> This patch series enables icache and dcache at the earliest possible
> point in the SPL and U-Boot boot flow for iMX95, iMX94, and iMX952
> platforms, significantly reducing boot time.
> 

You did not update the Toradex boards (that are the only iMX95 boards
not from NXP currently present in U-Boot). 

Is something that should be done?

> On iMX9x platforms using SCMI, the DDR size is not known until the
> System Manager (SM) is queried via SCMI during DM init.

Emanuele: is this the same also for Toradex boards? I think for us is
different. Any significant implication because of that?

Francesco

