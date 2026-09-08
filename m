Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7F3C79FAA
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 07:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24B61808BD;
	Tue,  8 Sep 2026 07:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E56RGLktrdcW; Tue,  8 Sep 2026 07:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 96D5B808BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788853404;
	b=lvcqFh2h6zONJl8R845GgbvLkJ6dRFrGVcnUXFh1vJv7owwxo4oA++hBg0i0/vhrt0AO
	 NYPY+bbI7vKujLS74VmE9FlpuvXRMHmPUt+2n1GmVQrfyCkCSioNrNQ93abR+THFfbv65
	 HeYICOJQ40aXUKk6nLKB3ciwUSCpxjdLfd/sh8sW31O7afQnwBuJ4aPK0RCheQ0BgDK8f
	 gqedgn/BUIbpV3A1P86wbaG5PjJA6NLL0INTFtxCaH1DbzzjGI35XosnypM/DK35+Zg8+
	 UCCP3bcuWnpV8/HIL/G9cfQN3D/En8w8noyYkZCHcd/8e+Nen2jNoVif29QxpGmgLKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788853404;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LR+PfEHqnBm2ymeZT91nRoPlWbn+Z5hzorbdtcDvvDo=;
	b=La7GZfVoVeb72MDNrLUZaNYqh/uvmSGWkL2/q3cXofz9aM7EllW6MMLiwgo+gRrS7GOz
	 qnjMCZ0Ezvd0g5oRj10ULak1FGrJNdw0vrnCNiaWVa79mJHB/d4cXcjwprk7BzQ10Eb+i
	 767MtCNUzH7tCHFw0MiDanyy1yKrZL0/9vXbKQjhpCqpJ9nFU+Ovv5PRMHEgijBNIj9Wl
	 weSyS84E57ljQH0CMXTPiRvj6x4q6gU3M65cjnfaFP/HMQm3eD/oN/1BC611MinyVoiC2
	 acIdgjiqweWyQF+EBCZZgHpoVEeMRQMCeJy1nF8xW9+wSX5DReJSex9riYrG9QvASXQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788853404;
	bh=LR+PfEHqnBm2ymeZT91nRoPlWbn+Z5hzorbdtcDvvDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AqFhgQ2HllLe1NJqYdAE4vs/pTk+7jWRblE+LPDbYvex3Bv3894RZnmsWdblPWQDy
	 GWBvvOtKaSJZ2KC5l8XZvJnhuDTkflUIYMY+9ViY7G9rN0CR4Fq22cen0Yher+w8Km
	 le/w9VD44vmwJ1l48Fmf11t9H+g0lC7FU+sWs394vnQMZJCGxxlOjYP13UTaSiSFde
	 hi6ZfUEn44t4WOoSCOuY/130RHI3FSWrQeRU50k6V25lnlleePQBAi+8Gjv2mCu5d7
	 ek10+v6EVMTdNTQYz6TsvBoYMquLLtYfFrtQR329ex8n9RBEV4ci5sD5iVog7O2e3C
	 msCxJSSozwxOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96D5B808BB;
	Tue,  8 Sep 2026 07:43:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 04B6D72C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D910A400E7
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CKrnZxzVhVHB for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 07:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DAC274005A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788853401;
 b=S1ZNnJQxqhTUopUdk9mGwWRjXI0Q9jw+XZq/sW3q9okps+U8zSBE26wwofc5HTLkHWZQ
 obbK0v8yZdPotmO3nHtZYlBacGOjJoXu/scmQKqIpOf4mUwWqhmGKgq869ANDeZE/3OBZ
 JkZy1v0SWmYshdBKCbqqgNiN0MeJQHa4wAAKvnnuQRbbDMY+levXO/2h1tP8iUyD/CkQw
 6Bra9LX/2y3QvOVAgqQ514Qvljn9z2ErGCyNsBCsWr6nxEVZ4w+9nDbJRJWiWCcyWF72S
 mC0V8lXySau3NBUsN7cdzsQ2z+zm8gzIioqawibSNyHPnSL3D2QrCxxG55Y0ZoReZAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788853401;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=LR+PfEHqnBm2ymeZT91nRoPlWbn+Z5hzorbdtcDvvDo=;
 b=T2aydmTeIXqLTLLmmWT+X/19ujOqgZhIJR38fFx04U5uFmEvM4kJU5TKevwC1jm9L+FS
 CDiTcx1uc2o4LiL60YSP3xqgdVLmdrCZyDCBGjKZ1NazPG9ntUHwDFlBaVPm6Tg3Dj65I
 xDB4ZMCxIUYYod/xb0aHZKRSR5S8Ocy6vaorBInsew+2OHfwh/J5AS/r6K3tWqikk9w/p
 BbI0voRUSpDp1VWD44NPa7/GyZHSIj7/IMBOgDz4uqiSvOLCoisSZ/XPF52nalZ+a378R
 4KAAxuErqiGO0sVJ97KP2zzSptcsNGsUXxEcJq5J0pG/0fmUbP0Z5E57qqLJxsThcrQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=2UBSUIlp; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=thomas.richard@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=2UBSUIlp
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAC274005A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:43:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0A30C4E4158C;
 Tue,  8 Sep 2026 07:43:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CFC55603C4;
 Tue,  8 Sep 2026 07:43:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 47C4B11C79B27; 
 Tue,  8 Sep 2026 09:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788853391; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=LR+PfEHqnBm2ymeZT91nRoPlWbn+Z5hzorbdtcDvvDo=;
 b=2UBSUIlpvba3JgjHJa34lprB+WYzwbIImx9JwxAMu+cWP5265tagBcx6jGMoF0xNVZngTN
 Sjsm/HBajvimlI47/i2li2cTvdnzobZWJy+QQnutOniF1VVov8AwymvdubPJ60A9ERPPt6
 LwWqSFhR1bpEPfAmB6sLbfprhFFR2qdW5JfIfYmf5AAg/LiAfLi85Qh8Uin13s9dw9D6f8
 09t6fdWJgDD+sPUC4LOenjLnOhRPtqudvKMywoc0D4nsHWs3X7zkFVOjqGJhvwoEcNUwmV
 /iBbSiQhNC0J+rIY2luE7gOtAkZ0GAnFDPnUF99pYIq6bh1G9dVgvMrplvjXPg==
Message-ID: <84bc51c9-2d65-4ba7-8a5a-b142812f4e34@bootlin.com>
Date: Tue, 8 Sep 2026 09:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/21] board: mach-k3: r5: common: Set PMIC NSLEEP
 triggers bits at resume
To: "Kumar, Udit" <u-kumar1@ti.com>,
 "Richard Genoud (TI)" <richard.genoud@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.u-boot-project.org
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-12-richard.genoud@bootlin.com>
 <c3711f46-a1a6-4ea0-b54b-73759165a479@ti.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <c3711f46-a1a6-4ea0-b54b-73759165a479@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/7/26 10:14 AM, Kumar, Udit wrote:
> 
> 
> On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
>> If we are resuming NSLEEP triggers bits of PMIC-A and PMIC-B shall be set
>> to prevent transition to S2R state while clearing interrupts.
>> For example PMIC RTC Linux driver accesses to interrupt registers, in this
>> case if NSLEEP triggers bits are not set it triggers a S2R transition.
>>
> 
> do you mean, if nsleep is not clear, then linux driver will fail to resume ?
If NSLEEP is not clear, accessing interrupt registers (like PMIC Linux
drivers do) causes automatically a transition to S2R state. So SOC is
powered-off by the PMIC in the middle of resume sequence.

Best Regards,
Thomas
