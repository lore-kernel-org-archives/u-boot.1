Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65505606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KtXANXpq;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tTv2ttlM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2B2B409A1;
	Thu, 22 Oct 2026 19:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5Nd0O-08y2B; Thu, 22 Oct 2026 19:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DEE994098B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792696588;
	b=nTMsxylCMJYJIIoNNROei6i4Cjc+i6kig43M0pIm0qz24vQI3+Qc9ZtSh1gG+7gUaXb2
	 fll7uKXQjl96t8yhLxkoorcsqNVl8R370tqTa1/x3fwIf9GV8wgEZeeHicFwQUCxtOAmq
	 SeaaZYZf8eJ/MNN8aDVvC+khslX80fkTeVpXiHYYqAAHMiKCkL6McOSiFj5WLb+R9gmk6
	 gZD17QYlpYeNPF5Wr2mHUiP5rvJnVVtyFECfq5+De63PkwsIgqMzREA4xZNUWVd33zhXu
	 IBBjpbjUyE74af9VN+FeXPc8jn4ZDIwSaDuirJZ9JdsQbrz7PQ13qLam2+jeesQV15Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792696588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dCQluLM0rtBve/dVsADY/1+9Mg7veOaKUkpDOJaQUqk=;
	b=Q7eYnC8hNpO6/8pnLqJAWfsv6+UycB0e+rNIbwy6NcVQMELfOXA86meTDyjKDndRKL2L
	 YCU413QV83qgOJg8pCux8aU7hjlZQ625QEXDmPHAB3ACMPU17TwM6pZqUCYs9+B1L8lJJ
	 +Q9B/3inzgtXV1dGtMduqc7+R7fHUd7su/jmkc2VqzbOwaBdHXpDFl2P/aBhjJ5kgSMS8
	 wmzRCoG+FSu3C0E8Hb2+H1hNFoHv+pLLdaY10qs14rli5vQ/zqJ8jUt6rWDY/6OjMA9PS
	 06tUec1yYdorXPrf3iZ++SofuHqjzboiEXG2W+fb6oca9dyG2biw5awZEvBqmTdb7AA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tTv2ttlM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792696588;
	bh=dCQluLM0rtBve/dVsADY/1+9Mg7veOaKUkpDOJaQUqk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KtXANXpqEu+ke0zZNlBVbr+FCneEePZytyzru13f3iIPJmSiLlqloP5yX0qoKz9sm
	 q8it/o8SP2z3Oy1gCT5Ekj/Kn5FBGvXUtoHPnsHBqnEjs+xcCFKEDH+1GWOy4KJNpW
	 4xx8KXNRjShUIEsAxdK0FQeHYsBn4If/dWiz1YO7SLyr8s3o9V13mxp9ZYJfQZrTtp
	 ef6k3f0iALYeRgDRpVBXP4uIIzKsFUBl3b7VIJjKW5n0BoD3wO3SfC20vjwtD2hAv2
	 Iywimf+v78Dqm1fzg+GbWzde69SG/UBtEDCyfOGiC0DPg4JYrSQ2oCxJ4tAxmzFg7b
	 mLVOX/Zd7ErKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEE994098B;
	Thu, 22 Oct 2026 19:16:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C9C491C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E65AB4098B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ycSuIYQiKkCk for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D9F0D40988
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792696586;
 b=CzwlTM4dBZYQdw1z0uh3Z0Yd6F4WYfbKSxPC0h81daot4AojU3bYRDXRA8gJaNLlxOaA
 owNcpq8Mco3JCAP6KBAPNx9Sy5beUtxK5Lc/Wr45McP+B4PYqAhEGpAaSHOayVKzM3/ay
 kUBa/vscfWKiVaaFntvSBurmUUgkrXJI/LJUxnhl7N2ybrYkxgUq/SKl1L53aruaNonWT
 FlPM3qDcqO/aJE8zb/jxxSOKUSvpoMTVGj9qUEuojbMMgLkY15WOSZ0jLULY8mFlHeh+2
 7KpMTI3U936758YFJzJKphunkr60Cmga+l+GF2kkJBWb1WQYEer1knLAvg88UoNZjrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792696586;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:From:
 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=dCQluLM0rtBve/dVsADY/1+9Mg7veOaKUkpDOJaQUqk=;
 b=O4u3gZIcAlesW/TP8FPelRm1MzyK5SVgv9WhbdzK+fdweWCme+xVZXaWCd+NnjfdReXQ
 DzULFNRneCF/wm0H5T5gM4hllKOsAi4unQYX109x/9zbrQOu5+tMSMyFI8/ErmIGiPNoF
 BrdbiBCFxNjcvjFFwSkfpjDnRx4a/z8EnOd9v5DIEwXd+od2JM1a6/lVrQgLztmk2EqmF
 jtUkNjpbgRy6JA/Xak9RQuLbklHb8PjO5LalHnTRdjBMidczaBbXOU0ZURx7IjiHOBefS
 39cOWB/AF1gnrbHp9MmubCwiTasCwnulxiOXctBCftDRv2Htzl5Jcf1VKJ13iHp8DzQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=tTv2ttlM; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=107d=in=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tTv2ttlM
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9F0D40988
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: Subject: From: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1792696583;
 bh=dCQluLM0rtBve/dVsADY/1+9Mg7veOaKUkpDOJaQUqk=;
 b=tTv2ttlMSARD2Syx0v2sozhDc4C8c7T0lz6wXldexwuZbkQSs0AeGdV91BGpWlt6CO8++NTf4
 xVdluZwdY5osKsFKPjiUEcEc5MnTb73mWIFYRF99imVQb7b6QQr9PiR90DzpgVgFOvrbSpq9SwK
 v0FcnyfHBSDiZiiUFHwx/qgz2QVi7CTd0H/LWBHzSSVSiC9D8MuZmGObeNYRkgOptp00kbj5gkN
 8TyM4NAsryUByuqjOp0+3YJ17huI8nC0z7tR+tqeOheKaITB8YqpCrggnhkwWSHouT//n6nCBze
 KLA4LMlo7BIIPEGPFSRAIeo9zEi+aB9YWHfcML87PZtA==
X-Forward-Email-ID: 6ada6106fab43371f3694a60
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.9
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <eb5ff808-d165-44f4-8620-48d68028ff71@kwiboo.se>
Date: Thu, 22 Oct 2026 21:16:20 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonas Karlman <jonas@kwiboo.se>
Subject: Re: RK3572 / OK3572-C support on top of your rk3562 branch
To: Cunhao Lu <1579567540@qq.com>
Cc: u-boot <u-boot@lists.u-boot-project.org>
References: <tencent_907535C1D3F4C91824948CA407902292FA0A@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_907535C1D3F4C91824948CA407902292FA0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cunhao,

On 10/19/2026 9:49 AM, Cunhao Lu wrote:
> Hi Jonas,
> 
> I've been working on U-Boot support for the Forlinx OK3572-C board, which
> uses the FET3572-C module. After finding your RK3572 support, I rebased my
> work onto your rk3562 branch and now use your SoC, clock, pinctrl and RAM
> drivers.
> 
> I have three follow-up patches:
> 
> - Add optional RBOOT + DDR + SPL three-stage image support to mkimage.
> - Add optional RBOOT firmware support to binman.
> - Add the OK3572-C device tree, defconfig and build documentation.
>   (With Forlinx OK3572-C BSP Alpha1)
> 
> I have verified the complete boot flow from eMMC on the OK3572-C. The
> bootloader, kernel and root filesystem are all stored on eMMC, and the
> board boots into a minimal Debian 13 system.
> 
> Do you have a submission plan for the RK3572 support in your branch?
> Would you prefer me to send these changes as a separate RFC series based
> on your branch, or coordinate them with your SoC support series?

For Rockchip platform we typically require device tree for new SoCs and
boards to be picked from upstream Linux (the devicetree-rebasing tree).

So the first step is usually to upstream dt-bindings, device tree and
core drivers to Linux before patches for the SoC are submitted to U-Boot.

My rk3562 branch contains a long queue of new RK SoC support, some are
waiting on Linux upstream support, others are waiting on open U-Boot RK
refactoring series and/or other mailing list discussions. eMMC/SD-card,
Ethernet, RNG, OTP, SARADC and USB2 should be fully working for all the
pending SoCs in the rk3562 branch. All (or most) patches in rk3562
should eventually hit the mailing list, at least that's the goal.

Please note that for RK3572 e.g. the reset header, pinctrl dtsi, usb2phy
and other DT nodes have been adjusted/corrected for mainline purposes,
likely some other parts to make it more consistent with existing SoCs.

I am currently using [1] with boot_merger to get dboot/rboot merged as
part of my generic-rk3572_defconfig build and test workflow [2][3].

[1] https://github.com/Kwiboo/scripts/blob/main/u-boot/RK3572MINIALL-ramboot.ini
[2] https://github.com/Kwiboo/scripts/blob/main/u-boot.sh#L66-L68
[3] https://github.com/Kwiboo/scripts/blob/main/u-boot.sh#L99-L101

Regards,
Jonas

> 
> I'd be happy to share the patches and help test further changes on this
> board.
> 
> Thanks for your work on this.
> 
> Best regards,
> Cunhao Lu


