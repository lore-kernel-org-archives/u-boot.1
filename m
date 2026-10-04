Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA5ACA5FF0
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 18:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D738D60711;
	Sun,  4 Oct 2026 18:54:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M4x6SjGSoEZ6; Sun,  4 Oct 2026 18:54:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0475860705
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791140088;
	b=mFUi2k/LV0Sd5fypE4IvlXcAP4MRhtiusyAz6zLEEpP7bgB1uFfAYGUiFxSNNgUT6qE4
	 ITxwZoI4hPHL/ElO/PMiO38/o7aeG/XXPWLkM0IPaR7Mtd36K9mR/ZHtKxsltvhbQmsFI
	 gZ4n9PHhWdxwxHgmUclQgC4xNZBgPDBS+BqCDUNp8cbTneSzKucQkc1coxFDQ8883j2j6
	 OWB2lLbmBmvtJ7ziOQ1qQ0wryl37xFAFEwxyp1V6q6g5/Y8bpSoIsP62BZjdtSgGWNEQn
	 9dN5LYBtZqNPGqi6jCRztXn+V550eOdLZ2fCRduUb/5iM27YyLViZhllgnWoU47x57Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791140088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0Bjv3ge0Bhv2CgUT0Rs4FsoMlGJ15Uf6F1qthMQf8y0=;
	b=cNvXjx7Ovt7hyoM6xfFcCjBd20G1/BqyJ+Kf4bD/qrIDBfXxuhLKfAQLVtzRbJkYOSin
	 WAiuAjEgoLB4+OZ8CI2gvQuSUDxIVA2WLbBQzGCYWOboo+viCvrtBArpoVpWR0ozJH6Tj
	 5+IVdS0LYydpkuYDdBt3AlLyn3T+u4Wy/0s45QSA4ZuVDq8F2o0/z6+J4nKdfkzQb584d
	 +Ldqj2bqYTAsPuAOg7Ph5iGXqxSCPPW0mOug+P0iwwus1I/BtWsgWmp8BC7y48JgijIka
	 a/w7jVl4BUbkh93bqwrymzdAVYC3OSUqpGFG9fzBZ5dBlw/6rtiWn1Yknb5l4+KBCCg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791140088;
	bh=0Bjv3ge0Bhv2CgUT0Rs4FsoMlGJ15Uf6F1qthMQf8y0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/rnpVFhuU1FNOfIMFtbBgS5pQpH2VFaE22j1NK57ssHtxY26QOYCAJhMAh9NFbUV
	 pjCZ6JFY+aeWOfsTW7YapbZYfujug7miqJsAarylHGBUv0z82Bch216J/UQADlL0W8
	 0bC21D23CGknSJPC0DaNFFmwxKJjH9Et6sdSvIneIxxWYhQ0Fk1mE/CWPc+NVD1JoQ
	 pDErYrS80p92Ua3uB02UMKAw2a4TD4OzgzXDuGqH9lkldlrJgkHGdvkaT8axHfd1tX
	 1XckqcpWmy9NP2jL/24SKgw6pmYv4QnJKnqXtu9w6WTGLdhFOHh/j630IK3lYQHxXF
	 AesqVM7L3KMGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0475860705;
	Sun,  4 Oct 2026 18:54:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BDC60335
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 18:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A455340049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 18:54:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R8iWeg1tsUAj for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 18:54:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D8EB84002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791140086;
 b=IeEjh5s41pNrbO3/5ibxijnNUXKuBXcudugB4tHDQYJpYcSsXeswbmJClpAsfzS3FtXu
 ju6icfe+PV6yVtu2JBpGogameULJHLTMBNHLWrmSgD6gS8ueVBLm85MWCeFbcOu/9KUGx
 tqUg89DYGZu+OKxK8i4sMjXgeIcLsWWdM0a+WBpsXVpLTj8opDsNhHIrH3paeOJDKPiIS
 uKb/Rg2t9p1RNhL0SVUSxdc4JaAcgp+m5lpoDf9o6MMBB2NuwDfVPVwjdNxOEEHGdgawf
 XqPb7qbfwPXxQAjYZllxmEhTLPlP1tjuu8M2W2+w5u7tGxvI7SMXvz1f1FrprGQa9Ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791140086;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=0Bjv3ge0Bhv2CgUT0Rs4FsoMlGJ15Uf6F1qthMQf8y0=;
 b=AjIFGc7Ot7kzuNY3ukmb3xlCqI290yn4oHiSDy1/+43AimDKqr3sXMpOTM0qzfdSEAnW
 BwB/ifWnI86T+pFXt2aWf0VrPkT8p4PJIBVbNP9hi1DONHfGlX77yd1AChUgle+zzbWAb
 DEpLkbNH3bo9KM4Q5sH4pwGitfMg+0KMocNCOeOJfjh10lW71KwSUnqMS9blvCCTUJ2Zs
 3kuQj8s85ZdkOJ+Njv/RWKr1mf07Doirbks7bQO8sBXuxOnzTvX0Ll2L6jVMtIkpS7ct1
 ugfe0Wc4AYxSuU7jgA95tmgvMdSI9oc0sveev2CYKYEotfB4JcpijV27XGPxowSZOug==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=HIqkD9Cr; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=HIqkD9Cr
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8EB84002B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 18:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791140084;
 bh=0Bjv3ge0Bhv2CgUT0Rs4FsoMlGJ15Uf6F1qthMQf8y0=;
 b=HIqkD9CrSlUFxdeeLW+1PqQHpR8Kl9dSTeIaZ/Se7ml6r4qyu5LoFv8PVsGqkfvaevxVsrAWH
 T9BVSauUDa3nq/peN8KSQ7U9tYWGXKa1+2WQV0wPAb9OKPGMeVg7Clrvt/QPX6GfCvpJZRrYpY7
 0mCLkIQPnVB+Jjx0WczIAc03ZEKvDnbhQ/RyYa3nR6a7vTLVCpMG2gAMVl6RySB2Pl/kCHilZK7
 bTM2AMFnskftfcL/L6ALDLOxlU27SugVBcs3fyskUh0TkMP94g+Z8DYQchbe2PfGsesH/ArVzNb
 J/9tJxAUXzvQ8S5XOuxMUfiVnJSglnB6wrtJdDKnoOlw==
X-Forward-Email-ID: 6ac2a0efae0725cde34e973c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d4dd19c0-2243-4f31-8693-02a25bd4a6c5@kwiboo.se>
Date: Sun, 4 Oct 2026 20:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm: rockchip: Avoid BSS SPL config options when
 unneeded
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Quentin Schulz <u-boot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-3-11bb20983682@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20261002-config-v1-3-11bb20983682@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Massimo,

On 10/2/2026 6:36 PM, Massimo Pegorer wrote:
> The configuration options SPL_BSS_START_ADDR and SPL_BSS_MAX_SIZE are
> guarded by SPL_HAS_BSS_LINKER_SECTION and SPL_BSS_LIMIT options in the
> common/spl/Kconfig file where they are originally defined. Addition of
> a second config statement without 'depends on' guard causes these two
> options to be put in the configuration even when the guard is not
> selected, which is unneeded and sounds wrong.
> 
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>  arch/arm/mach-rockchip/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 1a2e7847c9e..5ed774159be 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -836,11 +836,13 @@ config SPL_HAS_BSS_LINKER_SECTION
>  	default y if ARM64
>  
>  config SPL_BSS_START_ADDR
> +	depends on SPL_HAS_BSS_LINKER_SECTION

This change is causing make to prompt for SPL_BSS_MAX_SIZE when building
e.g. tinker-s-rk3288_defconfig.

  Maximum size in memory allocated to the SPL BSS (SPL_BSS_MAX_SIZE) [] (NEW)

>  	default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
>  	default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
>  	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
>  
>  config SPL_BSS_MAX_SIZE
> +	depends on SPL_BSS_LIMIT
>  	default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
>  	default 0x8000 if SPL_BSS_START_ADDR = 0x43f80000
>  	default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000

Possible adding something like following?

	default 0x8000 if !SPL_HAS_BSS_LINKER_SECTION

Regards,
Jonas
