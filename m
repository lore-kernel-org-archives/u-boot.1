Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369CEC61D99
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 16:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27BD687606;
	Wed, 22 Nov 2023 17:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ovn2bzHV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IL6TLZia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D89863FD; Wed, 22 Nov 2023 17:15:54 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C3286F28
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 17:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Sb5vX1g6fz9spZ;
 Wed, 22 Nov 2023 17:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700669752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmnGnEUcFmglUvMRr6HND4w4G74XXGGU6bDFfAn4oVI=;
 b=Ovn2bzHV7ShzBRpTHZNrI+Ds7tcOj9djY4T7zbzjjvZNPI3BZkotHSGHOclNfnxfG84A99
 SvtOaQpgwF++9FTbgGscp9xlJBV7z11wLsYb3SXNONeK9CZvRppr+act38ASRVhmg90COU
 1K+QK+4gwQUcWCPniLcQO5TiY235UQ6lids93Ut1VZOzoOostnOeWlGLGC0+zeUhErU69E
 NzcFWDNcdSP/OZRfeHJhhz79w77iSCSXJtn64lpGRPBBHMuxJblf4OlBsbbZ/S9u2ba9JY
 0TrhIPaPqJ1zceOfHhSnN/Mh0XHrbUdq5c/N10peAscgF6HE3zU6+QgiPX2WlQ==
Message-ID: <88445be5-4d52-4995-91c2-e666fae47cb0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700669750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmnGnEUcFmglUvMRr6HND4w4G74XXGGU6bDFfAn4oVI=;
 b=IL6TLZia8hwJ6V/iQ0XTwpOwtIsU2aeqXtC+0UVUTr/wi6O+oquxeMpcG+5SuP5XxgIM0p
 EnMxYewiWvy1KOpNLEnG1zDiHEnpwwuGJcwkg72VoxpWeso1yFk0+h+/rNCKGdAw0WAZG0
 Ia118qOZ1DLbgVJH0R0FaJeJY9dMcfd19U/TP4OBN8xGBNBpcBvM2gt0Fiz0TM6Httywob
 LeVbfSXsBg5eh/0JY4xbx6Cwne1bPRMfpuHF1euP/ZnANn1LQ3j7a/7JXjsFtmMClIthHN
 YIyWA60uhGHSgCDKOIX5YijVzq3qwL1ZNwScIwQY8XNwD98eSsJ7iyrs2odreQ==
Date: Wed, 22 Nov 2023 17:15:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 07/11] rmobile: Add <mach/rmobile.h> to cpu_info-rzg2l.c
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-7-trini@konsulko.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231122131154.2444690-7-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: afq7t7c5wf67epxjmrogcuojx8fb1och
X-MBO-RS-ID: a6329ba6b0abaa08831
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

On 11/22/23 14:11, Tom Rini wrote:
> In order for RMOBILE_CPU_TYPE_R9A07G044L to be defined we need to
> include <mach/rmobile.h> here.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
