Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F49FC79FA0
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 07:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3A87808C6;
	Tue,  8 Sep 2026 07:54:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mS3lTZDUGf38; Tue,  8 Sep 2026 07:54:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C3A8A808AF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788854056;
	b=AS/t2Q+Bq7h5oMsDj/n1f2ZquHZYX7pIruMSCfRsUe0CMWl0c7iXerL26Dd11cwbtspl
	 vvdxlHwG6gz5D3hqJZKPndzIAd3TM2FKNlkYa7Q903WaU/fcgOTCMcJexJlrbnFkcNx3H
	 LecFoBGuO75Lgl74aU0siGoZ/TPtigag8JMGxKjGZwXEPYFV8iiMxbkQSMGsryVBMC8yL
	 Uur15FmTZwjol1eaELACAUNZ6HqP3M4WFEws3a7oNjMRtbI6l1Nh3XRvLbhuXNSBjEqzs
	 Y3NG+Pb4GHkFp9eumKCa7QUX8MJEGHArsosMBT2nJMpDxFE5gMO5Omusn47XI88/+6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788854056;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DGAD8pAE6wP4AsSyvdC1dHfeY7zn+w/nWCPhXAy2w2c=;
	b=JQloRn6a72DhKXWx6QneDjK5JD2RMAQlKLg3QsW6V4zMIf3i99HzY0vp0xq9zoZU6oZc
	 CwHIsZ0E1UBjvtRvGQYLA0ctkw/GNii7Jd4gsPJisVu9z1BoyaHvyTUtiJaQiOkvih+jT
	 EjNht+VsYE3VAPHUkxjm5RJSw2N+/Iomy3aQM/DYP8+D1lSScVTud0g/0SftRoGJs9TRu
	 P3jyzcWTizbjbio/Y7zLdtAYkBxzvKb2cvdN2AYF7Uz4MZ+PsU5ZGFxksXjysCFG1uBGO
	 MCbW4CnEzTdxxeTmdjlBAMP404Eoedess+fS4HF05jh0GQAnXIzDWylkxuKxwALBFjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788854056;
	bh=DGAD8pAE6wP4AsSyvdC1dHfeY7zn+w/nWCPhXAy2w2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BuBBkrX2zRUIaPciept6qSO+nOxECcZAC4/+wKc+t40y4xET9uc6SA8iFPiq2l29c
	 GmnZxLIFUeD4Kv6UnSli9GDdI8h6Z7LsBzf21WJHfg6aXHYrXh3AZBBYR/reVjea3l
	 t4kUGaL9ENT2CkZxTQR1H57HOzRk5C215ljS8Xm7M1UL0gkcwv4DuMLB0CwAKH9gd8
	 uAzF8y316nDx74B4u3XdVAAgLTtypwZI/ZjpQJhUsB+QHqqzRScRWQCLNlM836geB9
	 UkZ+2X4gOvzS/NiW9lLe627XiaP2cKRdRHqiwHKM4uiXIs0PB+V7t66OZAk8bR/r0o
	 qbCMtVm/6KnBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3A8A808AF;
	Tue,  8 Sep 2026 07:54:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D89FA48
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FA49400E7
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:54:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TnC7RMaDak1A for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 07:54:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B78024005A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788854054;
 b=XGJilNdG3YRcF9Ejk87sXn/OnwKYJoY7vCFdltJPXYNfur51SqAk2DSvmd5VhYmO5Ihw
 RfbNCQy1pdjUo9AX7hkdludJh4quGcCnp8BovcK1sE4P7jPbco5KzIhn0ijxKo/XBmI3O
 /XxtG69KxHzaB0pYw0AWYZSXmvlpitrNOxbD3Ttfg2lQJvNC4IYmydtg+qqZG12ZnxlQu
 /GUrUCRx1hyl/j6mB8AWsZXaLnuvdGqOthWcdHsqCgjxPsdNqyezSqKtbFWouOkvhZX5Z
 tElWPwxZei6bT9Bk9e74PgorQAVK4u+hsLRJTSGE4sHl2UbazfDqHAdZ3EpDK4HhC/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788854054;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=DGAD8pAE6wP4AsSyvdC1dHfeY7zn+w/nWCPhXAy2w2c=;
 b=tPifYERLhxuYrEAu1gdaBgp3kPLdYLFjP+UlZyR3oQcKCQILcPNAoH0ccvow/kcpKv+U
 55b+JWDctxlbIe0E7uH4NfhxlkEZvbVRnwy5W5NNE1wVPiqc0vk18KLLnA4ImHjri4G5b
 ojs3KhAC5dTPLFNDdeUFckDZqFKlAy/xAosVPi9Kv/x3jONa+EY1GaPJUeL5+okD45uFS
 J2hOxezDWKNQIgRKlFWG0KJW2v361YFCxw7Y8G4xicfHx4LiK2odwOTPPqm714jLYgwpo
 +mJtMQr5vI1Suv9gYHgWRRbppexIgmGgwi1gQrPScjn+jx7DfThRHrwTiTZyaXsFx2A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=xJ0VwqWb; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=thomas.richard@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=xJ0VwqWb
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B78024005A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:54:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 85D5A4E4158A;
 Tue,  8 Sep 2026 07:54:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 500DB603C4;
 Tue,  8 Sep 2026 07:54:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CDBEA11C7A398; 
 Tue,  8 Sep 2026 09:54:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788854048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=DGAD8pAE6wP4AsSyvdC1dHfeY7zn+w/nWCPhXAy2w2c=;
 b=xJ0VwqWbRIPJHpM37Tgy8pWidC7jo689vkEOb6gtaHc9Mhw5OzGPFojCn3ZjeeNdpslxxX
 bgNvGpygANGq5X1qD4FMCMLAehzuJcu8m2Zthr9kJxU+Qu5RqBeORDIgCbw3h0/BFRU8C+
 rMOnyT3AN2ZMAZ7K/pXOq3XEw0qJFJ+vi96ZqManZwPHgJGgpfM9jLQ4EezHC2k7jBoOOd
 PPMaKPBChxzDAij1jNOjo+Z7aaFhqb2KUdCVNDY2GfTs63wr0ayO9Wfv/+iYS36ZvQqiZa
 8h6uKksd4SPVvJ22fF+uVD49F4eVl/HBn1PaBQrXs52nE+qVKpZnLRsT2kIKmA==
Message-ID: <268facdc-83ef-4893-936b-b5b1c738c632@bootlin.com>
Date: Tue, 8 Sep 2026 09:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/21] arm: mach-k3: j784s4: Enable LPM resume flow for
 J784s4/J742s2 SOCs
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.u-boot-project.org
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-17-richard.genoud@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20260828135730.1565643-17-richard.genoud@bootlin.com>
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

On 8/28/26 3:57 PM, Richard Genoud (TI) wrote:
> Add support for resuming from suspend in board_init_f.
> The resume state of the SOC is identified and lpm resume
> sequence is followed accordingly.
> 
> First, add the board specific part of the exit retention sequence for
> k3-ddrss following the DDR resume sequence:
>    - exit DDR from retention
>    - de-assert the DDR_RET pin
>    - restore DDR max frequency
>    - exit DDR from low power
> 
> The self-refresh exit sequence is performed in a loop for each DDR
> controller. (J784S4 has 4 DDR controllers and J742S2 has only 2)
> 
> Select the number of ddr controllers on the basis of
> CONFIG_TARGET_J742S2_R5_EVM build flag.
> 
> Then:
>    - Extract context address from devicetree and send to TIFS.
>    - Power on the rproc cluster.
>    - Replay the certificates attached to saved images of ATF and OPTEE.
>    - Resume sequence for context restore and rproc resume.
>    - Image entry to DM firmware.
> (All those steps are done in do_resume())
> 
> The context address area is firewalled by TIFS to protect it from
> other hosts.
> 
> Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
> Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>

A Co-developed-by is missing.

> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
> Co-developed-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Co-developed-by: Abhash Kumar Jha <a-kumar2@ti.com>
> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Best Regards,
Thomas
