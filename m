Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CB5C54F4D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 16:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66AA9608F5;
	Tue, 28 Jul 2026 16:28:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zd2nHY0asgHx; Tue, 28 Jul 2026 16:28:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82338608E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785256102;
	bh=QprUnIk4JhIbAsxEDDZs8ajqd8a4Nvj/BTv2l4YcsNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v3eiaoWEe9P6T0HB2XllEAYDua/R/if+tGRXd2rKtSNqpK/bH7Zsd24qQLhBykCs4
	 nTUsdb7iymFK5OjMfpiPl2pr6giGGnXcPIlxzSIs6FSjp6oIpozAjepFsVsGXQILZc
	 WHaEXDTksJRjUoikVJq1vxgyCTLEhqYij4sUVlw5GN+pLTDiKkfFbOtBTRBD9eOn8Q
	 eHxue0EQ2H9DxeBe2ua/KArwGw0o1TfIR44Lp3bF1LNl+fsfA2jY9vBvpBM/SajRRZ
	 NL9tv8MCldvkUwozpvat8CijM/mEF5DvFR/Ml93OOxzoN68DbYbS1HYEgYK34rQQu4
	 UdyjqoSvcMVQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82338608E9;
	Tue, 28 Jul 2026 16:28:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 022E726C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7ABC409F1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:28:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3R1DycRVNEDN for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 16:28:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 87EB04094B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87EB04094B
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87EB04094B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:28:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 078A18493F; Tue, 28 Jul 2026 18:28:17 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 370E08404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 18:28:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; t=1785256088; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UU9TyVS9HVbDQ3N9r9l1TwaU3wL3ZfgMN5slXppa7Qd1PwDzsDD+JZ3MOQG87oux8RSyZugjcvfA6Dml5udjNwfFha8teOCBwiuShHZE/GcI8iNa/7c2Vj58C/hAfaotZXpbraRZ+0xdnO0U9CckOdOEkFWktm8TC3nh8EZZxdQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785256088;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QprUnIk4JhIbAsxEDDZs8ajqd8a4Nvj/BTv2l4YcsNU=; 
 b=dCCetHgq6YL67mpRqK4DkvQJ3bJkrYSkcJSXYDl+B7II5nKgVVqegiz6wLUGBFrE+qpjoOG4TPDd4iQ7DWwh0DlpbdtJ/rMW9HfIJPDbpP/EiAdGb/z8Y+L+7goKGnU/baryz7xKmbzRd+v1xBUJPIjHJND9wEDNIjeVKNvoj/s=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785256085860545.8774869734048;
 Tue, 28 Jul 2026 09:28:05 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:27:53 +0000
From: Yao Zi <me@ziyao.cc>
To: Milad <miladh1539@gmail.com>, u-boot@lists.denx.de
Cc: minda.chen@starfivetech.com, rick@andestech.com,
 yunhui.liang@starfivetech.com, Yao Zi <me@ziyao.cc>
Subject: Re: VisionFive 2 eMMC boot issues.
Message-ID: <amjYiTYHlkwQF1RU@pie>
References: <CA+H9utw63z8x2Q+AhjWoq5O+aVW2FKEBCgvVtSzX--HJSJHAVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+H9utw63z8x2Q+AhjWoq5O+aVW2FKEBCgvVtSzX--HJSJHAVA@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.252.37
X-ZohoMailClient: External
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785256088; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=QprUnIk4JhIbAsxEDDZs8ajqd8a4Nvj/BTv2l4YcsNU=;
 b=bTGzw4MgWyCZESUp/QrOw+MMsHgnlpr9CikMr44oEJelB2RPd6DevV3XoSdkstwR
 aSMtIS72j486ejhnUMZosDWYGVbyDig61lsYjdoDS5RE01KSSG6NjRUYmBs9egvPLZi
 HkeA5Vwg6hzOzA4CoLF0D2l0vCbxNpWlK+78wo6E=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=bTGzw4Mg
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=me@ziyao.cc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="bTGzw4Mg"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, Jul 28, 2026 at 04:42:03PM +0200, Milad wrote:
> Hello everyone,
> 
> Little reminder on this thread regarding my VisionFive 2 MMC boot issue.
> 
> Archive link:
> https://lists.u-boot-project.org/pipermail/u-boot/2026-July/624724.html

The last time I tried upstream U-Boot with SD cards is about v2025.10 -
v2026.01 and it works fine on my side. Could you try these two versions,
too, so we know whether it's a new regression or just a bug yet to be
discovered?

Thanks,
Yao Zi

> Just following up to see if anyone has had a chance to look at the details
> in my original message on the link.
> 
> Thanks!
