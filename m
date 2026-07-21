Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BD7C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 14:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 116AB80E88;
	Tue, 21 Jul 2026 14:45:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kI9yT3hsM3MN; Tue, 21 Jul 2026 14:45:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3BFD380E89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784645143;
	bh=dLvRxJzWyJAbT+JzKOUmRgz2lOx/X/v+nIOb6fYlJ/Q=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NSxDJBFDE37gg/8hgUjQwE0eCHVYyNx7bybOmE4HHY9K17SUgHnbScwQHP/j2wTb4
	 Yjn+eOJnPJBlwuNLH6iW8UAJgBZpxRLjKguqYipU3shhN01OowgkHQzOWOT4xF1SG2
	 VRQrt/vLvIDdpiR0M+CcDwlXKYSTLa6s0YlTmaytODrZgN/fS4VGJ0+KwwTSVg/MaO
	 ypa2tJT4K0obrxTbNSkjPSs/KvNU9RApYIccB5cNv31kdurUYyjdLu/iWjkUds1YyV
	 I9LcUuKPz4MWaL7AS0Y/V/SmLMM5uZFN7SQcMYmOYkVBdR47rERs4XrujNIgUu2Tm6
	 liMuFboccZMLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BFD380E89;
	Tue, 21 Jul 2026 14:45:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E71F313
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:45:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1082A40911
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:45:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Se__nspLEOEA for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 14:45:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=153.92.25.143;
 helo=mail-d14.seohost-mail.eu; envelope-from=krzysztof@kd-solutions.pl;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5B71C4090E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B71C4090E
Received: from mail-d14.seohost-mail.eu (mail-d14.seohost-mail.eu
 [153.92.25.143])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B71C4090E
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:45:40 +0000 (UTC)
Received: from 83-168-76-203.static.ipv4.korbank.pl ([83.168.76.203]
 helo=[192.168.1.202])
 by h74.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.3) (envelope-from <krzysztof@kd-solutions.pl>)
 id 1wmBiz-0000000FKDD-44oa; Tue, 21 Jul 2026 16:45:37 +0200
Content-Type: multipart/mixed; boundary="------------20vK0FmOYvEGZBHh9vEliJ8L"
Message-ID: <57257091-5b3e-4249-b7ba-b7d0a7699d51@kd-solutions.pl>
Date: Tue, 21 Jul 2026 16:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] power: regulator: ADD PMIC PF9453 support
To: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org
References: <20240930035531.27079-4-peng.fan@oss.nxp.com>
 <b80b20b3-1d30-4a2e-81c0-d974f91f48c7@kd-solutions.pl>
 <CAOMZO5D-8Ti+j3fUBAztkFY7wYZJsLcDQaFmcvH6cSgPXB23tQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOMZO5D-8Ti+j3fUBAztkFY7wYZJsLcDQaFmcvH6cSgPXB23tQ@mail.gmail.com>
X-Authenticated-Id: krzysztof@kd-solutions.pl
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=kd-solutions.pl; s=x; h=In-Reply-To:From:References:Cc:To:Subject:
 MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dLvRxJzWyJAbT+JzKOUmRgz2lOx/X/v+nIOb6fYlJ/Q=; b=Wla3tB++VBLrkGRbPeNqniIjyN
 obUFNCr8+kYl5IuFee0XonhURPgTTmtva7k5JAP9nRIQfa9qw0apIcVLL9U856kXuZ58BbkzbgBYZ
 s/NsMq7Ai2QboQa/r86T1SgsfClD8yOWzHKzGxA38vZV9hDYk7qdIod2IrMRpgh5sqVeIXg6/i7gR
 84qDz9/TldoMLKqRYfBLgLrcbCJQfHFw3QqrQ8/vylbG73q9r3bP1l2DgQx7OBqZShPq9y290+4nT
 Zsw3QIfeFiCNn1eJ+i4ObgiUbHvTvdZ1BbcSTdYOUClNStDMfyweFca+TMfYPJRfGrSrpMberDjnx
 uactwfww==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kd-solutions.pl
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kd-solutions.pl header.i=@kd-solutions.pl
 header.a=rsa-sha256 header.s=x header.b=Wla3tB++
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
From: =?utf-8?q?Krzysztof_Drobi=C5=84ski_via_U-Boot?=
 <u-boot@lists.u-boot-project.org>
Reply-To: =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This is a multi-part message in MIME format.
--------------20vK0FmOYvEGZBHh9vEliJ8L
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Fabio,

W dniu 21.07.2026 o 13:47, Fabio Estevam pisze:
> Hi Krzysztof,
>
> On Tue, Jul 21, 2026 at 7:59 AM Krzysztof Drobiński via U-Boot
> <u-boot@lists.u-boot-project.org> wrote:
>> [1] is required to fix PMIC access on u-boot 2026.07 then both [2] and
>> [3] works fine for me.
>>
>>
>> [1]
>> https://github.com/kd-solutions-pl/rozalin/blob/main/meta-rozalin/recipes-bsp/u-boot/u-boot-rozalin/imx91sfrdm/0011-power-Fix-access-to-LDO-SNVS.patch
>>
>> [2]
>> https://lists.u-boot-project.org/pipermail/u-boot/2024-September/566287.html
>>
>> [3]
>> https://lists.u-boot-project.org/pipermail/u-boot/2024-September/566288.html
> Care to resend these patches?
>
> Thanks
Sure, will do

--------------20vK0FmOYvEGZBHh9vEliJ8L
Content-Type: text/vcard; charset=UTF-8; name="krzysztof.vcf"
Content-Disposition: attachment; filename="krzysztof.vcf"
Content-Transfer-Encoding: base64

QkVHSU46VkNBUkQNClZFUlNJT046NC4wDQpOOkRyb2JpxYRza2k7S3J6eXN6dG9mOzs7DQpF
TUFJTDtQUkVGPTE7VFlQRT13b3JrOmtyenlzenRvZkBrZC1zb2x1dGlvbnMucGwNClVSTDpo
dHRwczovL2tkLXNvbHV0aW9ucy5wbA0KRU5EOlZDQVJEDQo=

--------------20vK0FmOYvEGZBHh9vEliJ8L--
