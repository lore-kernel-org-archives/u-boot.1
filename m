Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D72FC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 14:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E191D40585;
	Tue, 15 Sep 2026 14:32:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nz3tndlqNIvs; Tue, 15 Sep 2026 14:32:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1DC0840581
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789482767;
	b=dPExnyKVV3mtTByJMmcCjS1aBLHdP9DBXoJARq+EKZoTEObLRZze+mphUDyYuH343Y6/
	 2ku2k7ZVpewk5uIdk49k8vjWJpRkl0Ct9B7AcQBdV/Oe3O4ecz9WN5R20ckq+pviei1eS
	 62PxByKdmh0J7ZYA1waES7uaGa8KkbcleO0IvO3yjCiJKzUAXOICWVa6a9DIGljOQFo8R
	 48RedXsuLDNnzE2UKL/yM+UgI6mRAwxw02UDQab3ZTqDTS1F+kbv7AVuVK8FuGCKWNYiU
	 8yaqXSblzF2kKAVWkn2wiIiwtjF7lhXdTvRu0c874eVVnxCOenZqFZjU+KqYD2wQzuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789482767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=maLVQgdrhFtce7nSNr/LVniSseQpfNVhzrg29IEi2lk=;
	b=XUsbFm4nwvD5cVcfDcQkJv0qyvR50rWBMsWAjLmKepkbEcQMX3KjesLmaYcdjN6uCc6f
	 w2LIze6PLlMrnYrKkcgaMfOZyhqyDBGwsNepErLjjp7G3a+kf8HpocWgkTi0070icgGk8
	 fVRfZ4uy32cu6/ynK8RjW410P1JVoVWRD77axa7Vl5QCD2PKO3QmAKQL/500Qwwztwc4n
	 b3XUYD4xie+VLoiE+LulngQslERnTRLKSbPx2i7/vBGc+l0TTuju5RE/iirrxnG+SRSO/
	 jqd7ya8S7xnGkXmu0HrFv+nPqidRHUCSH3dN8edO6rsauGq0jcxw+myyTTGjSvcbsBQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WcFLPGsX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789482767;
	bh=maLVQgdrhFtce7nSNr/LVniSseQpfNVhzrg29IEi2lk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JX2IvyqxqGFMp2qKcA/vzSttAhgYSsSxQnehxP9qjCdpQk+GZTVVg/HaQLJ5XBPOI
	 7q7Pzyld1obBzm8kmPcJjwULsdBR070VYjeFQxJNnUFdT0qg0U38j+FjaoB1y/25c5
	 wMdWWc43mPt3j8QKWcQU8iDG/5OUV2PxkW/heW6mXiVDvtGewCTyGMe//PZL/xyj5y
	 RJi3T70kiL/7e43lmskTY6t7ohXbvwVNo7lWlOeJQb4Nl5XJxRWsWkuLSW/rxtcvfO
	 Hv20NYDou9+a/0uIoCM6axOayAbFZL4b7xg1OYRLo8zOwItDPa+jt0tKHbyotoQKki
	 xQbWvj89nHfdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DC0840581;
	Tue, 15 Sep 2026 14:32:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CE01EB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4AE2B40581
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:32:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zy6EGTkWamoV for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 14:32:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C65A940573
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789482765;
 b=FlPLWMa/I8KX7RfGOwvibRO+8lJt6qiqbnD+Cn/xEv+deBqj5DpDHHrHOA5i0oocVjl1
 ig8e+zVCrD67oJyDOIHYl4i9KyHCZoU+SrClFG80f04wOcggx0DH1IAAT7/VkAE3nzgPh
 UjGrPTN2cQkKLVH5cmyZAlEoJJTJDpWwynh0S0VJmlCGi83EhzxJ81sPRDbCLSf9jVkAW
 CySgnry2n69wIIFKJny0Cjb8hVPO09PYySuaeD0L9CgwG6UBSYjfdUGpheR45dFzF9flr
 VMai6oJBKZMUMfQCLE3lAQWauQJ5gD9gauRlx/Lgt+Y4vjm70uEsouWWUj2eBpMEWhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789482765;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=maLVQgdrhFtce7nSNr/LVniSseQpfNVhzrg29IEi2lk=;
 b=gS184nZXxqtR4qc8lpXY0dbQp5REnzKz1FIPlZG6NTcljEPwTgBIKreCEpxcnF8aYEGs
 aJJ4qYNOEk7fhAUKkVito4gAenFrVIyKxDDJBERKYvv+3iUR6Fl5NQMmH+E7Lap2ZyP4n
 EVkaDO0XvscS4fZLyYoL5urBhBElCL/kIZE+WLwMo53dj07unQj/lngal8LT5R9tTCSb+
 OtQtDCG1KG1ciZG0fJ5WEz3LuWoGRSzAx86YFIFaVz90qIhzHYOYxfz6fnUVGw77K9aCM
 X9pK4oEqdnSWEmJNSieUVqEmrJp+zkzIgg8VPRNIgwhnJMUwZ+sDVLo4RQ21zfq/uoA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=WcFLPGsX; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=kory.maincent@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=WcFLPGsX
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C65A940573
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:32:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 55C21C5CD50;
 Tue, 15 Sep 2026 14:33:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C5E7B602B0;
 Tue, 15 Sep 2026 14:32:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EE18011C7AFDA; 
 Tue, 15 Sep 2026 16:32:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789482761; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=maLVQgdrhFtce7nSNr/LVniSseQpfNVhzrg29IEi2lk=;
 b=WcFLPGsXa56bXmMl1iiUuEPxVYOMmlCl7qfuubveJWTaFL00tOcRlLPfNN1O+4ca2vP/o/
 cI/WaQJUa0kS2zhMkms0CGgktJfWN3JI/XXvqPssJYv88pWQzKCUS20mHUSbsoeQMW74xd
 71y/Qcun/D8NqX2+W4reZvt8dPKNKLkoXWiOU439fHd93CMWU1FXrck71ITDVKWftlC9Mr
 JJPJ8mRcD1MVf43wLS4GiAXNqnamS+L45Y0nkz4QQzKTr1st5rnx0VEvWCENH4tRj10Db6
 IbHdhmhxUu9cb7LAYIKm5+BdvtEnwzZ4NqgBsiHUPt514mfXRwd/4nVbtTS/3g==
Message-ID: <4c01c2e2-fa76-49fe-b33c-e3df9d569159@bootlin.com>
Date: Tue, 15 Sep 2026 16:32:39 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] fwu: fix read buffer size
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, u-boot@lists.u-boot-project.org
Cc: Etienne Carriere <etienne.carriere@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260915-fwu-v1-1-cc1fe9640334@arm.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260915-fwu-v1-1-cc1fe9640334@arm.com>
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



On 9/15/26 16:29, Vincent Stehlé wrote:
> When the trial_counter_read() function reads its counter from the
> TrialStateCtr UEFI Variable, it erroneously computes the return buffer
> size to be the size of a pointer instead of a u16.
> 
> As the UEFI Variable is always created by trial_counter_update() with
> the right size before any read attempt, overflow cannot happen in
> practice, but fix the size computation for correctness.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

