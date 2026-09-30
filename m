Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B05CA5FC1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 20:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26D3F40B3E;
	Wed, 30 Sep 2026 20:26:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsudWi93JF_x; Wed, 30 Sep 2026 20:26:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6DB3240B43
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790799960;
	b=j3ComQi/gvbZAcA6Bif2Y0mEKv4ZZAT0/6yVMKuOMjhM3ERzqws4cIT0DT8k11CWDj3L
	 4NEw8aQdtcUP+e5Co/5ANNzsOU37l87l5CvmQm+4uLN3z2apyqgiUMSxPu/kJJVgoCaJi
	 7r7C2+AUHOaxdhucZLJqfaVx9vno26zLLKIdPLbyylCzP8FaFRj6j1ZUXK3gmZhmZY8bZ
	 ePKYM4d9cbKs1zg+dmk4e92T5vJhlHXboCk1PWCVYeS2K69gyCYsmiokTwHpL87XpANEp
	 /tFulPkPofEopZ2OEtT6AECaiqWGTHzuMuHkrHKNSyL6lC3pyyhQRIgs9hKRjTBrfTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790799960;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=joHPJb4B3lPmQRYHdtZctVQbElYaoubA/XzGGeSi2wA=;
	b=LQGJgfbMOw22jtWRVpT3siICUlgNWKOng+BoSyfXQwNRap3hVwf5NVqW+juBdpni8s+e
	 8Fn1MBT2lFDxnBLSOS6RwFEhUjzcaF8K1/hRxuXh0tO6nEmJJV9b2hLbjahzuWQ8RzyJf
	 BIK8jsyD41xWCiHt4sAymekLmDcx8xO96Xv6Fk2aZvrfHCAEifj5kYrZus9Zlo3PB55qz
	 rmVaVf8fbUd/RyWk7VPPSiCNDTBPzdOmtaQ63l8DJI3olJY1BvpBHD0S7vEGVmbJAoSh2
	 eXisxW4crxdxhvNaXZUvGcBLQb8z5fYWuFbmlK6xI48RGvVEmnnCb+s3e7er0gP0u+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=rZus+x2M;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ugA8jysT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790799960;
	bh=joHPJb4B3lPmQRYHdtZctVQbElYaoubA/XzGGeSi2wA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Clxx/KrMVEHvn834VFEl4O+k93y4pmPqhoU6AYQdNVTTzlXZNTKBYPVsz3al3h28u
	 ichLNSg0rZXzJzpRQxnD7FtVhupOl0PqsNtLTiQkOYXgQRtkio2WwrCiROv4cwgt6t
	 K8nqaMZuWbtchQ0oICs+Bxpb2HGmz/BtkQs1e1Slj08CxLpZBWpLJ6dmb8sd7fkZus
	 TH72VVHuKjfRx6VBniHYzzDFgL5fsBii0gKeeRmDpdhllvfGOH0tVLhYJLSkb3Net5
	 rlPbH+pZK0BsG7/uloqosUCvNvPfY+ii7C+ale+CRVvNtAZjUdoAzmlr2Vc2J4dqPA
	 JnknxsAyftphA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DB3240B43;
	Wed, 30 Sep 2026 20:26:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C625C4C2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ABE5340B40
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVQvyb9WpPuh for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 20:25:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4540140B3E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790799957;
 b=s6VuH7xjgW48s7qZMy/6wcpMNGyttQDKfxSz/NKQEFk70ZsTqCQvaDFuVGzL8+iO+N1y
 80nJZG+WwFxcbk26RUAfgfi+ZlJGl0ubF1baouRZ3g273cfdFtIoHbOBUG2xXRsBIeA32
 dqfx/lCKYYVKEVjIKfaovXTOzWy2EBqQdnLRcrA3CNSep5Vn2fcHUWi8m0DoNtT9fzshB
 ncim4ywWkkFMCBlbvVVl7he89AZ7xm0ryvUPNdGj9usAT/FnNINxnqYiQL4/8r/j3d326
 9VSAYsNbbQlU22tmOamrW7QWbj3GG/2TSKvKr18Z2ZfmRjw/URASw7AAGHOnmygrxmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790799957;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID:X-Rspamd-Queue-Id;
 bh=joHPJb4B3lPmQRYHdtZctVQbElYaoubA/XzGGeSi2wA=;
 b=WFG6h48qmdqz5S5T1/R/cux8bklmlyXb8C15/01uw+dVcic3hfhCs3mYLssD771KqAIf
 CqFA3Y0cEpms7aAORrYq7UmRVnqgF3eKH6l3lEmqhfDz1NH35tru/BwNoFM7F1SWa9F36
 N44nW94OZNK8xNFW7W+5i9Ae8nkXssuNQ0BDLWl1spNOQEoVhjuYa8wePvTdrx6ozGVhm
 v1dgXLpvJP9VslVobU84JfUKcQeowrE6DxqFBTSO1Sey+CrPUu42+IYpc/cLozw1r7HnI
 0GrURnRa3/99WiyK5T370rr1MSRF1CTUAfQVDVrGal8owkFb0zianmOQYR8B63PAxUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=rZus+x2M; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=ugA8jysT; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=rZus+x2M; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=ugA8jysT
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4540140B3E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:25:56 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hw64f60J9zKnbW;
 Wed, 30 Sep 2026 22:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790799954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=joHPJb4B3lPmQRYHdtZctVQbElYaoubA/XzGGeSi2wA=;
 b=rZus+x2M10K4DpbW2eAuQHOltq+TSKUf6BoUYIwKJV3s1nU/dtB4Z37QJgpZVIPU+OsUPp
 5mZRwHDCw6p4Thewx2c0jnIdzRfTb4tGelKKxUzAYRoXhVr0Dyr+K2RR+Gse1SGARzP87n
 JZ5VZb15GiIEEJkiHLigAQ/aRSWF28RvHxL3ofq5JZGfQC397XT7YzqJOYc7oPVdrjk4Kg
 ea+ouD8mxm+Pw5MrFfy/NEMyie+UI4kB2Ce9pzEzRZ2n2kOqRz6V0cOVVUr7y5eQ5fTdSr
 LIxJvuCLtpUPy+pbnazLe+K/pHBOKm8AcwfV6FW7bM6oM6aewJyWao5C8X/p6Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ugA8jysT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <dd039b89-6351-457f-97eb-4ccb34653af2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790799953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=joHPJb4B3lPmQRYHdtZctVQbElYaoubA/XzGGeSi2wA=;
 b=ugA8jysT+h9LThHSQLFK5M6zzQBhMJ/E9KwhJNmQiy9avlOUdTlwbVjiwWNQKPmiQjZofI
 /1naKaBmN2HSOeGjCvvNhXkT9PQuLX0j7BNwjKkXLGld41QgYhIEWtoVr/3dXXE+zlfxfm
 Bd3t0lpo4CamWa5c2LtB1i63+pQMzjrpwFvgTf3DMDZ7zR+GnaIyNKV3W2ZZ6BFs6yZv18
 8tKNfcA7FijiLO8rvNl7iJwHCJIiMsq6NlbGldC8x5oFyfVRhuETylpKLubfWcw3Ldun/J
 EIqkKEhas7vUmHoHx2Myw0JZU9ViijWK97QvO8F14PQgRR1Fx6RH+OGUBbjt5w==
Date: Wed, 30 Sep 2026 22:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: beacon: Remove Beacon EmbeddedWorks RZ/G2 Dev Kit
 support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Huy Bui
 <huy.bui.pz@bp.renesas.com>, Nguyen Tran <nguyen.tran.pz@bp.renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260913155253.84181-1-aford173@gmail.com>
 <179078865386.467656.9091674646926534530.b4-ty@konsulko.com>
 <60d018d4-fd00-4c26-9b0b-f1ce288d65d2@mailbox.org>
 <20260930173919.GI858934@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260930173919.GI858934@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: y5gfnomqdk8qs5juqap71f1a6acntmhx
X-MBO-RS-ID: cb609a449bd03cf98a9
X-Rspamd-Queue-Id: 4hw64f60J9zKnbW
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

On 9/30/26 7:39 PM, Tom Rini wrote:
> On Wed, Sep 30, 2026 at 07:37:58PM +0200, Marek Vasut wrote:
>> On 9/30/26 7:17 PM, Tom Rini wrote:
>>> On Sun, 13 Sep 2026 10:52:53 -0500, Adam Ford wrote:
>>>
>>>> Remove the Beacon EmbeddedWorks RZ/G2M/N/H SoM and Dev Kit board
>>>> support along with its defconfig, config header, U-Boot device tree
>>>> overlays, the leftover pre-OF_UPSTREAM DTSI files, the Kconfig target
>>>> and the entry in the Renesas board documentation table.
>>>>
>>>>
>>>
>>> Applied to u-boot/main, thanks!
>>>
>>> [1/1] board: beacon: Remove Beacon EmbeddedWorks RZ/G2 Dev Kit support
>>>         commit: 3f31d496ecaa6240f1e578cce389a06798d66c30
>>
>> This is unfortunate, oh well.
> 
> Yes, and I'd like to thank Adam for all the work he put in on these
> platforms over the years.
I second that.
