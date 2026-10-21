Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFC606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qsFAyfQc;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=GTTsnjXO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89BD88106A;
	Wed, 21 Oct 2026 12:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zNKBn7oO4pS3; Wed, 21 Oct 2026 12:07:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C3C2D80E04
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792584453;
	b=thHmypNCTgBkgxDRzNa5ys3v0OET9wGHzHH3sk2w5MgSsoPA4EcWqUzIrAW/ADYQDcfh
	 Sc3xk0wJLhxOHeBBO19hmGJiVRv5X19cmjlAkWzQq7es1kowZTk/Oe784+M2xIUBZ2iCg
	 oRtiEe3VII5aHrWyu3S8llW6WnJuBpyK5iGbG8eGWT7n8RuxkG5alhqReIkA8TaM97hH2
	 OiCQr0f86BlVcyVuFN6hvHsOhfAMCCFW+4pLmaoHJhVcMGNC/2G6/QZJHSuQqoi3oiCcE
	 LIsh9do2+Q/i/saXADE5r5fVr/77bRcGruIssYmAQwoBvBw+ln7qmKt4rAl6zpFOq8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792584453;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NVw0apxlly1O+nMDRIPAlOdm7rTdGm4sJqlfHDBW7YI=;
	b=h4v8rdlh7SzAt8RWEsFwCDmra/rek57DTZbhYa+yReFmTCUtIWjsq0stWy0un5YcccSc
	 Cm/gHLqnjfwImn/AyJ2RzXzdezqC8HGUCSoXYNq11FaXSHVo4i7DZVrwNEwFR1hy5aMab
	 jjMHWC/0yys1U/Uqn3cpOfoP4rIC8mLjJc8qNSwgog/R/Q/BTiI+s0TdlPpVIamZ7zv49
	 kssvm1CeBNGXQqayTzPCH05lLjcuJ4e8UzqK2RW50gnSZwZyUvi2Nd2PijHmLxKOIjTou
	 1QIA+tlrKHcw1HgFDI3sp1XRcJfMcEMlkZ42REWbED8mdHnkKiKtqDbf2hV2E9T8HpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=GTTsnjXO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792584453;
	bh=NVw0apxlly1O+nMDRIPAlOdm7rTdGm4sJqlfHDBW7YI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qsFAyfQcvBZuGDisAyqFGevvuWctIzcZnqha6xINfYI1ewlK4E7zQJfflpVcHkDaT
	 ICRm5dOVYtDkK00l4BRD2jZcej3U/Ft84foq+zhJUth+l68rKwhevYBjOeIEKkWnjg
	 HjZquODgV8sa6HrsX/aRVZFq6QTn94qNVdvrTNVUdSP6viW9Pvb5zPA0RNx1BW3N/u
	 9C5K3qBIpefurMWu6/vQL30TcJFucKhNpOhqUJp3tkr24UOx9CPF37KiUy3T2BnGAg
	 e7Wm1c+3geqs8uU2PQyXE9b1z55LgesbAzqIlet/1D49SoIMjmppHVtr0TJuwLmkMC
	 DEXjCvU8ig5oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3C2D80E04;
	Wed, 21 Oct 2026 12:07:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D2A83AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 230DE80E04
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4mYHqSFV3HxO for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0C96280DFC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792584451;
 b=NhJERP/gTQvssEcIerFejUzPWRX5j31UxpOFndvA4E+fDnw7keek+jhNzcaRyR2ZS02B
 +qMMp8tE7TKcgNR2dEEtF2kKTnak8xbJ8KBsfHgiZIO2LY3JVzt4YMY7TTCAsG7vEP4dl
 myteBmpT0+ATwZuvSu9a/9ldain8q2R/vyqkHXYUfCUrf2MywM4HKPT+kaY/1b+i0AiNf
 jdsuq5WuO0ObHCWGESJoxjntnt27nRyFxwJFCHB/X2lJgTEor6S8q44VFUQRz6ECXvmcX
 Cubug6EqajMxITYcmW5ROCkKG1fIosTzCFkqi0DW4PVHNDnvq1MWlxtEG9fVBoWz3+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792584451;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=NVw0apxlly1O+nMDRIPAlOdm7rTdGm4sJqlfHDBW7YI=;
 b=RuH+zzgMns6adf1Ec717yMkKHYIymo2u31fHOJ6VJs2Kim5htEIitDLLNmKv9HxaDKCS
 GA66K+uvhngigBMNSJ/sHWYZMaqnxJTK52VDa/gyYWH4p/0sl+qlmcNLNsHcrcw7RoDUC
 8akVIQWGnNM0N6r5G9A7tRqxdXnZlxJy/oEcNesBipH4+ItneSlSRtdzzfsQ751jmd5yB
 aWIjFo5Duzi7SxE41svV3GnDyFh8MxvUygnFvUDGm7Y57km6/zh9+nVjKrQjtIPf4axEH
 ys+EOvOaoPT3JY9dghLrjdQeHfvK515GeLARQHJXu7nxVc6MPCRaoa2BTyn3wSXp/uw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=GTTsnjXO; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=GTTsnjXO
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C96280DFC
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:07:30 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j8p1p5rK7zMlbQ;
 Wed, 21 Oct 2026 14:07:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792584446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NVw0apxlly1O+nMDRIPAlOdm7rTdGm4sJqlfHDBW7YI=;
 b=GTTsnjXOrQMdTvK80JSjeRTSxmLc6JoTMdE5SztH0BWKO7MT+jT2IuGpuJ1Gph8Got/yu/
 whwqORN5PnbypUD3YfAzONcrv9pWKi0QL6dtcTIiw42XqKRJ1Ry1LbmU5vwmRBIyAKg09j
 xBTeBQIYv6zmGz7n7ZqFwK/5nmtwrqjtJvS8/yV263+c2DgdYMov4GHPdj8p+qin3cVlCl
 c256vVpPdwhxyg6I4rGAoU5Dm5Bh6VxTaeuVpFy1z38g8ehq30VNMVAmjQZbOWsz+0odaQ
 YuglnKhQAOJWTgnaB9osRqb7zJZUvbJZrPibtJjjnmy55K2WCJXwgZPI0juiGw==
Message-ID: <477ecb2a-3738-44ce-a563-4b029f5e6d39@mailbox.org>
Date: Wed, 21 Oct 2026 14:07:24 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/9] usb: ehci-vf: use usb_get_dr_mode()
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261021115934.4136992-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261021115934.4136992-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: c9o7wisgndnp9s41gftsn9j6hqougzwj
X-MBO-RS-ID: 75fec676f9e078755d1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 1:59 PM, Mehmet Fide wrote:
> Hi Marek,
> 
> On 2026-10-21, Marek Vasut wrote:
>>> +	if (ofnode_read_string(dev_ofnode(dev), "dr_mode")) {
>>> +		priv->dr_mode = usb_get_dr_mode(dev_ofnode(dev));
>>
>> usb_get_dr_mode(dev_ofnode(dev))
> 
> I am not sure what you mean here. Could you say a bit more?
You probably don't need the ofnode_read_string(...) above, it is part of 
the usb_get_dr_mode(dev_ofnode(dev)) already.
