Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A00CC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 08:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83FE84084E;
	Thu, 15 Oct 2026 08:28:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eTMnm_U3S129; Thu, 15 Oct 2026 08:28:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D670A406E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792052899;
	b=K4BoZKaL/DjBVlBui0BopJNLeEjTyTF2pCi/B+Q64TqOXtghMOpg8+IGFQfEtBaHl1g8
	 kJkPkFaoRt2IKwqXzIzACKVDBwFRUxbGarlZbPF59j24MXKCR19mBcBuBHhvv8AWnCrHu
	 e7ZWLQsWCy19jvwJJN9KXkZWtJfF/84aACg7TMG2Y+JD5jwMQ3TSVxamQtpsl+/h5xJiu
	 gv6upkdEW5NfaBuW7/JqARWLMfzL5f9cSqWFkwjK4BtAAiVlqD8I6CMka0x+Y06+Mnu/l
	 LgpX1gQ4Y5VqD3XawMt8ShIaTSJPEb9QgPFXKtczibDtcLMJZ11TkmAGZ/howA1/6Lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792052899;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VJH7RIHYyrrMKtWpwmn8M3VaNnFS7gxZzt0M439ZUTs=;
	b=GOFTcWNwfpNcHNsfz+z7qx9svXAIBm/5B28L1Ph1fB8psmk0PLict6U4bKSmbGuch0D+
	 u1fNpluSYdTLdDSBmkcwfo88fHxQWYFyNxzApuLjGOxBIUCE+cH7jHQY/u8fra/apKDLX
	 ibCQaIvXBGp56PhegfkMMajhDUn3Xx4TWjaKQ85r5nG8PVzpdw9OdmNyen+AjXovGzlBM
	 M8Xmagvj4N15D2q9c04aqylij2c4Wm/5qBGqm9jOV+kXkG5osYMeNb9OQE7Vp6ODo580u
	 ZtwSruPJt1DKGt7ujRGMrPh7wx6LvA3mdZaVel/AdURUzwk2T9WOhhmAahrf2LI37HA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792052899;
	bh=VJH7RIHYyrrMKtWpwmn8M3VaNnFS7gxZzt0M439ZUTs=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6db+wSvJKWQy2owyUliGtFog4UzcnspIaecbhxQTOxHk39vNUgC1wqx8sqSvTjVo
	 we02NHj4ki5Cf6TDPtgQ3wqfGPoKv71TrworUNOdVBGWhC6/2ho9VEwmVp476WGxof
	 trIhPaNEyliHWb73nQol0NFS3A+Nfl8WxkP9DIBcATvb9apBDlouYbiClu04CCkUT3
	 NFM8Zl07JbxFJQ/415uhpyJw1QKsHptScXq6BGMumR/5K01iOeC/tjYfwaVyW70uG+
	 qC2OMzTsdj+Sf7I6BCGeXECNDubMbvFC2hNdoj1iZH3o4gwSTZUegNJy1mgH8j17Q9
	 7xjVc5/h/yRAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D670A406E2;
	Thu, 15 Oct 2026 08:28:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 735591DE
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59A4740053
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XkFw9DhLPAwv for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 08:28:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 94D404009C
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792052896;
 b=rWlMTnqodYzfsCq6cc6Ren+cq2T97B8PWg8iHqk4qxyugxw67/nJcvG9gShQ1Ledw7ff
 7ORQKzwPHL+F8SXxqnbmXeImzhpBa7brdpHFas+HHR9Q2cUdzZR/IFIWftjE9qfFv+vEc
 dhv/17xZZv1rjv7P/46AVrQpN6CgTYVTAHHVqxr9+BdU+jK1qkb94pGqNEFF/rmCbWHVl
 UJWt7HerGIByH7x8Xrt9C4KBOsgYv+q1GL3r+p3cN68QQIR1wBtXEHfZS17bI8p7MkXU1
 5G3aN7T8vP20ERtF2MpkawaHaGOnByYzH5hjeGqCqGWpGZnXbLeaL3YyxfMjCRNV0qA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792052896;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=VJH7RIHYyrrMKtWpwmn8M3VaNnFS7gxZzt0M439ZUTs=;
 b=qVFfJdeHJl7ErxuS2++GADJXjuMiaylTJ1DNFfvBFlKSugSwUw4bjWz4yXxlouH9/fYE
 Fn2Am6rFPf09lD2n0TGdogQMrNM9vUkkVcbStecxsSbYkib8Tp/72Ldn1lCNpHHzxYev3
 TFX9KG5AzDoyxp1OPRKBVR4pjnej1CaF62F+El4J8qc9JFP220CMyAzP/e24a1fr5ZLBR
 nnlpJhGuepN7xo9DX+scXr5IffWn5pk1wuRSQisgvf4ibCmNmmTmRolcdBueFu5JIiwy4
 tDUg8SbJqn+7LlTy8lMog2NVw+ORGBasC15sHynhxdh7UBy6tWkccFMSmckPI3twsnA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=IpQw24iv; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=IpQw24iv
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94D404009C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:28:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2FE7410776B; Thu, 15 Oct 2026 10:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792052890;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=VJH7RIHYyrrMKtWpwmn8M3VaNnFS7gxZzt0M439ZUTs=;
 b=IpQw24ivg9QgETPbS2RJ8zdnw46r35VuxXTas7PFQyE5ulSXRGepJtf59SecgEtHQoDVTe
 hoLOqyGLEuoMvnTIlEUmZYtYICGbBzNDf9OGg3ej79wuCcvLwu5tXzcnqbU1B5x0pajnQV
 W9IowIvLDtVgUMNZhu07N/fbTOSnyI5js9gcnm7ig9wC/m6lu/bU9HX28AOi3tUDLUEj4Z
 K4KFIC+KFlG7KfOeXjNUApPxVn1tXyNZ3TSO6bMuBv/K0XVFbzSXte+25NWXhUX1jeE1R0
 xIVtZ1PwDPbx8gBG1R8H7ciNFLrSJ1Zgpc2Co12/dcicPtvsAUjut1FnLp7NYQ==
Message-ID: <c6fbc1cb-462f-2b25-2765-1fd4cb3d03dd@nabladev.com>
Date: Thu, 15 Oct 2026 10:27:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 5/5] configs: ipq5424: Enable GENI I2C support
Content-Language: en-US
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@nabladev.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
References: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
 <20261007174151.2590649-6-gurumoorthy.santhakumar@oss.qualcomm.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20261007174151.2590649-6-gurumoorthy.santhakumar@oss.qualcomm.com>
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

Hello Gurumoorthy Santhakumar,

On 07.10.26 19:41, Gurumoorthy Santhakumar wrote:
> Enable I2C, driver-model I2C, the U-Boot I2C command, and the GENI I2C
> driver for IPQ5424. Enable GENI minicore support so the GENI serial
> engines can load their minicore configurations at runtime.
> 
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
> ---
>   configs/qcom_ipq5424_mmc_defconfig | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
