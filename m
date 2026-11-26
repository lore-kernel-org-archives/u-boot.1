Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA7606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zuWov4dv;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=nWY9azKJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09E8160A5C;
	Thu, 26 Nov 2026 12:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gBsH80GSRTe0; Thu, 26 Nov 2026 12:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2EACE60A55
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795696427;
	b=JcLEJ8Ok1dMgZVma1Q7gLDzWbDMe+cwSqg+FREkqe1YlEqodrwJdOG/FlEJaLECWgrsJ
	 Co49Br0rI3jvTnumgJ42ai1fQvtzoDnMJzC/0Axpm9xne+XCFQZxmzreWB1qMHNYbrhzA
	 ryd8GkSgPDFGtacOsxCarzdEC6M9dM8sIccWlg5kGR1qn9SYWXxP74xVgPulqrXsg64T0
	 hfNx+qi+abHstUlNLSrPO387zBKfldcsSdlIz4Fbb3AAO3plkvLhYUx3YWo50IckNGHMZ
	 xjPee0lfwF4ptmlFtZZHMT6NWvWDuXmwOY7zETo7/NZTR16afMi8mOcWATYCK/QpGDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696427;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KOC3ODdxHam+Wc84ZAuKbfT1+hCmJx+oy8FMarMVkQM=;
	b=Y0GVR60mLN3EJaBiqkkfEb1ers7EUBQK0LI62lFZzn8CEM5UvvQpnEg3sLrOdRHjCxGE
	 V6fVpo1umhhDSzH39uMPi/WdRB/FdChpU16fbcjqGJaE1HIR3nmk5i7n7r6iSICHsCbCD
	 V2TS4vShh/cIp320xb7870DB4Lbkcsp6Ld/bBmbYX52sTFWIaZkGtYr6GMXOK79KmornG
	 TuiPBeD8tDe3ijIiaHhEx3PaBUWV0mVRXYwv+/TyNHqUTJloHFhA3sYRiLXSVKZfRrjkA
	 xcpaezh3jlK0fAqWV2N+hzPhGun6iBzEEbX7ajzPFHDvLj9bgM6OdroZP5KILQRXewQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=nWY9azKJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795696427;
	bh=KOC3ODdxHam+Wc84ZAuKbfT1+hCmJx+oy8FMarMVkQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zuWov4dvbetLOrzPNIvnImSxq/YO5+k40Y1GCv74ZsaFwiIFEPVzuMpZB6Pap7Y7e
	 aZ0+y5+a0KeJJlz4O/H0UWHk2lFp6vQF4BwrFyQba570nvv+6zNkEBM+CeaQKafa+Q
	 asv8wTsckmqY6c5Fochs6a5pt1p4XuaKxncjz+iJ615qAoZqK0qIG928tyaBaHSq17
	 s4DQ6Aeh5My8D+GkNOn1W7NeiQIj2K9HZwNHJThYf3Y5YLc2jMdE+CByma/vkt2IKs
	 pmKt4WitswzYayQ4wsUT1RCtCZF7/VEIX61W/K8IZjeRNk2Wpdp9eqalcC3FN+Ul8A
	 HioduFSoQKcPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EACE60A55;
	Thu, 26 Nov 2026 12:33:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED515325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D33D260A55
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HtonLQHCh_dB for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B81A360A54
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=nWY9azKJ
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B81A360A54
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=KOC3ODdxHam+Wc84ZAuKbfT1+hCmJx+oy8FMarMVkQM=; b=nWY9azKJK814PqDso0nKMLF9rR
 7FfyK7qlTe+eusQEm9YX6X/kVgQw71AShwx+r26JJDILnWEJYgR+g6ispI+vd+vvVZE2ktZ0Mm77E
 x7nADmvvby3BJGWocm+Rcfb4ma0F21VVyc/BOUcTxHIvhFWwjliGssRd2IbwmTn0uCEVxibbgMJ7k
 VjUq9ceThiCf3pyHawrQR+/f2ZejKsJzKF62pQHeaneEudosQ8otbzFhpNVUlHl8vzeKpUY8PzJfZ
 tTMhGGY+yM5OnlXmP/IMp/Oe9aKjiBcjV2ANxyf3T/COrEyM2RvqkgnKrGtkJ5ARx4JHasuIP4LKx
 YYrz9XUw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1xWYfK-000JwG-2a; Thu, 26 Nov 2026 13:33:30 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1xWYfJ-000FxM-2a; Thu, 26 Nov 2026 13:33:30 +0100
Message-ID: <ed76d2b0-44e6-4dca-9f66-0d91957e8fde@ew.tq-group.com>
Date: Thu, 26 Nov 2026 13:33:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] configs: tqma6: rename .defconfig to .config
To: Fabio Estevam <festevam@gmail.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Paul Gerber <Paul.Gerber@tq-group.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Adam Ford <aford173@gmail.com>, Nora Schiffer
 <nora.schiffer@ew.tq-group.com>, Johan Jonker <jbx6244@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Paul Gerber <Paul.Gerber@ew.tq-group.com>
References: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
 <20261126-update-tqma6-v1-1-a105aba78868@ew.tq-group.com>
 <CAOMZO5CV=BV07naQgYG=0f330Und_haW856-S2tuMpPBX0W7EQ@mail.gmail.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <CAOMZO5CV=BV07naQgYG=0f330Und_haW856-S2tuMpPBX0W7EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
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

On 11/26/26 11:50, Fabio Estevam wrote:
> Hi Max,
>
> On Thu, Nov 26, 2026 at 7:47 AM Max Merchel <Max.Merchel@ew.tq-group.com> wrote:
>> Change name from *.defconfig to *.config
> Please explain the motivation for doing this.
>
> I understand after reading the full series, but each patch needs to
> provide its own rationale.

The renaming is done to make shared configuration parts easily recognizable.



In the next version of this series, I will change the description to the following:

Change name from *.defconfig to *.config.This makes it easier to 
distinguish between usable board configurationsand shared configurations 
used by different board configurations.
-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

