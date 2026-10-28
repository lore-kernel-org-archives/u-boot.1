Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FC6606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rA7OZd7d;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=cO1CYLGM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5651060600;
	Wed, 28 Oct 2026 10:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t-LGVPz07AHm; Wed, 28 Oct 2026 10:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 63D3C605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793184036;
	b=lOjIfGNZsO9Mt/f3K+NJ7tUWoveyRp5+4vnL28gjJL3qy/xqgQ1wdEroUl8iQ0KpS8AS
	 uiCvU2JR9uaGeB34IY+YPBZCKD0iWc1TJbq+nIRnJpBslykcTHBlUSB/2lQ+x/dU/xDbB
	 hjUhuvhQVzQg5iVjN8fQnv/kwvbS7KsmrDHwXuqvK03c1LlOguEtFY27w3vGivGTYlzYq
	 snpObFYunqREejtL/jmOhW3+zkuh+81+cBwclM5+LJuZZVWlD/Lzy07M3qFMeo5C4baZ7
	 1ffzPjxuNoMuJVE7STgc2OUSPStqxX1r5GRkmI7EFurSx7BFmOnVLMYN4ERtHFq1NGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793184036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Virus-Scanned:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zZwI8cbfeRo4mVNIaKAMEB6tPK+6Df5AU8X4FjC1cvc=;
	b=jvByWFQS+WMRjzRE0jGDs/M/r3sZaaIHpsIEs8MDCEjjit+1DnL/ol+BgYyR56YcN7TB
	 NkaXJTU3aCYso929+AM8BZEaGe4NA5A/vQJ/3A7wRs/lnn08a1ZlaF+uNkiVxI2LwBwpV
	 BrNaRQfTwEqY88knzIqrJGaUzAjT+nS43ALla4h1e3MG3NOY7hx3lxiFrXdXK8kpoONmY
	 PLzetHVqaakmv1NS0m3/W4AEMgUM+3k5ZQMlapIYw9AXDRxXXvJnlXclY6ec6k7Xe+Q/v
	 xTQdLqHGMKw2a5M2MomS/hEjB7MjVvJSDaDaWgY0RUBNGwE4Ez5gI7YQauzPHCu5f9Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793184036;
	bh=zZwI8cbfeRo4mVNIaKAMEB6tPK+6Df5AU8X4FjC1cvc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rA7OZd7d0AwO+oekQGnelidiLmX6MO8pPqJU8TS+rBI1jcfD2DU2FSZbcMV5/CYcT
	 dZ41sBA/ujsXwhX2QHIrokW3L4TCC/S2saFtRlpZF2eIrKdK2LI1mjdb3WwUTwK+dv
	 LssDJxHqMpGRjE/uuR6/wseML2Ia9UOzjYz0Gk3M88/riJl/RyFLvFAjf85ZKxFvCO
	 WPfs6JUrpaueszJIWodKLLRYGk+lhLvZdjBYNrrQNbtJeCw0+Hri3u9crRre9Tz+pp
	 EPonK24umEz7HzLa0PQd8pLxIbZPQRLADFJvsQltMsIa5+QMWA40wozDBZ0fQ2GdmA
	 /RRlbQLwUuP6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63D3C605EA;
	Wed, 28 Oct 2026 10:40:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E332356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1ED3240574
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HPVXFrEw4unm for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:40:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C996D4047C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793184034;
 b=FQEl8tCEIm4hmKD5w7CUB5ivTkkkqwUgn6xQ3SXOozN9Pi+u9P4nm537y5qQBX2S+XmZ
 b7mWehqio8xivb1xyxsfxFmeok4vjMwLRaVI5MwuiRyDfdoxwebsTSl8rDEhJbMgdM6Ai
 DLRfXaQxJ6+fDoZEueU2/EawB7bRAi/a+f3EqoCkquInsG9TWIVxeuwPTPLxvUlvFUo7a
 CSYKoCR+ctlzxkVSUBgOYgFbdy8BNY+TsJdbmWNToqv0ElSyZAYhxS31ppMFbRtfm7g8C
 t2Yl5Iy1vDVJB/qHTtr3S8Gu4p5c2ACiXVVIAbX8lvGhg6pCtQHigBQ9+U3vAvvURHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793184034;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Virus-Scanned;
 bh=zZwI8cbfeRo4mVNIaKAMEB6tPK+6Df5AU8X4FjC1cvc=;
 b=CSRgR2iGixSWRhdFCCZ/YITttOyDaO29EHC4Lth61d7yydeA8EumA1wYYryHGcySY5ph
 xbn53fBH9P/TCli2UxR/SY3G76tnKfN0k/V2s6r2HUt04OQ7cXRCfX3zWTBDhjHIulBvm
 mg16GCLBjMcQ66ELzWNz/BtfFfi8XxNduuV+5pEzEvMBfLbkAwU03Nwx7bOm+Y+0R+EoN
 F2IF2yaVWT3Ah09MCvHZomsO1XJRtmIUSdm8wajssAzWLjrZJh0q2vBXOElVXIO14ywOu
 46CDmxG85r5v0pQzplD/eqd5eX12QbSflRJ/K82Fd/1jJycgtBM6VVFNYAMm56na6YQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=cO1CYLGM; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=cO1CYLGM
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C996D4047C
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=zZwI8cbfeRo4mVNIaKAMEB6tPK+6Df5AU8X4FjC1cvc=; b=cO1CYLGM+zteyDBTH8vdlK6Fhx
 1U+U9UoYTbxqL/glJqaW04I16mAx56pT5FwUsdbqZPM7/pzG4xp79vji1r6jN/DFxSeTpBg1utdgF
 TRJWD1xaD+ntoKhsRkoiULnkPRaz67mTvHEwHgJTZ+EWlKsaRhUQV+fNVYKqSUl4KUBDUG0yDMsMO
 4Mwe9XRA8wHm7YAoeVV2AoYYlKLYoTL114GT/oikrgTwAct4J1/FbxmVSeXmAd5aAVP3/55sqiAEp
 xLD6LNXkpDF90lRBGPEXv08g1AurQqbCNjGK9RHvJuR1Bo2f5pcNIVYkpM826Xuf8WmMtW1JSXzb8
 9VvYPhkg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xM151-000L4k-0e; Wed, 28 Oct 2026 11:40:27 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xM150-000Jdz-2J; Wed, 28 Oct 2026 11:40:26 +0100
Message-ID: <b94621f8cc783f5f1e97578ad7bed3405862574f.camel@ew.tq-group.com>
Subject: Re: [PATCH 09/16] usb: ehci-mx6: set up i.MX7D misc registers
 regardless of CONFIG_PHY setting
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Marek Vasut <marex@nabladev.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>,  Tom Rini <trini@konsulko.com>
Date: Wed, 28 Oct 2026 11:40:25 +0100
In-Reply-To: <a829d462-e139-4905-b2c7-f8140a6cb2f2@nabladev.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
 <bd8f810425b7d3f8d1d78fc699b232da5a7ea60a.1793091394.git.nora.schiffer@ew.tq-group.com>
 <a829d462-e139-4905-b2c7-f8140a6cb2f2@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.6/28167/Wed Oct 28 07:24:17 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-10-27 at 18:24 +0100, Marek Vasut wrote:
> On 10/27/26 10:39 AM, Nora Schiffer wrote:
> > While a separate usbmisc driver could be added, no such driver currentl=
y
> > exists, and it would not necessarily be part of the PHY subsystem. Rath=
er
> > than making the misc setup conditional on CONFIG_PHY, make it depend on
> > the existence of a fsl,usbmisc property. This will allow enabling
> > CONFIG_PHY on the i.MX7D for the NOP PHY driver's power domain support.
> >=20
> > Also update the code that reads the usbmisc address to use the modern
> > ofnode API and fix the portnr to be determined from the usbmisc phandle
> > arg instead of the alias seqno.
> It seems this patch does multiple things, can you please split it up ?

Okay, I can split this into two parts:

- Make the setup independent of CONFIG_PHY
- Use address/portnr from ofnode


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
