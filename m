Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC19BC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 13:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE6D8876FF;
	Tue,  2 Jan 2024 14:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gRxT9J/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16ED877FC; Tue,  2 Jan 2024 14:59:52 +0100 (CET)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E998743A
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 14:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EC8C240006;
 Tue,  2 Jan 2024 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1704203989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEv29tfjuSe76bRj9UzpZ05lSNA042DiUKDwWCe6QLg=;
 b=gRxT9J/EhMaXuuP9lXe17/uCEz0eEPMHKRmSlWzQ28i0Ht9oqe/RI3LKeQWiNLsYZiPFTt
 kn2RQ6hA3s/+78MWStfIRkuP7+eLGwiaYW8sNtpRkB+GgoXZ6VQzNrlKjYJukV7L+aBtk2
 kdqgx0/1mPwBtzCFcugyRZ0i85x1zwE8vLU7pui0L/6x4AmvaYCK+i2QitoezW2mE2K3+s
 2Ng9G7US6rFMiOT+LlCutPZyEFJXNckRbK7VS8uO9XmDxgOmgingDLnChAh+tg0GrXRN+S
 WE+K7lgTc6IOD2FFy2TCQ2tbv53lXKsBtm3GoruFNTIA39vB73yFjviMzRuwEQ==
Message-ID: <3104f73b-b550-469c-a1c8-274d20c8579d@bootlin.com>
Date: Tue, 2 Jan 2024 14:59:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] arm: dts: k3-j7200-binman: Add firewall
 configurations
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>,
 Praneeth Bajjuri <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Nishanth Menon <nm@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>
References: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
 <20231229-binman-firewalling-v7-7-47ed4af303fe@ti.com>
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231229-binman-firewalling-v7-7-47ed4af303fe@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/29/23 11:46, Manorit Chawdhry wrote:
> The following commits adds the configuration of firewalls required to
> protect ATF and OP-TEE memory region from non-secure reads and
> writes using master and slave firewalls present in our K3 SOCs.
> 

Tested with the following configuration:
- SoC: J7200 SR2.0 HS-SE
- TIFS: v09.01.02

Tested-by: Thomas Richard <thomas.richard@bootlin.com>

-- 
Thomas Richard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

