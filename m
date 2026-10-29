Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCFD606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xO02dmo0;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=TDdEjRxR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 864EF407CD;
	Thu, 29 Oct 2026 10:09:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jl2vPRxtr1eR; Thu, 29 Oct 2026 10:09:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7ED0340740
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268577;
	b=ZdltHcRcJjunOJewEBpx3qOl3miUSawcFROLHeWmFUd2RJTOZWG0DTD6ez/DH/rabaNa
	 k3DrOtvidla/Y6GAsdCHMW9PkQUFNPT4eV41zf/rSa2eMzcuEf3HEjomBr537hXUd7eqi
	 AII8Cwekwfo2/KikG/gjPLi9XJ7vz8kATdY9eYGUwfjkxIOP87MvNvh8eI6n5Oz3TsE63
	 nFWCgSGSEopkCt6KG4aum5Ph+z0fZMzMpBvJr3XW4msA5DC62FOauZdrITZ52JZNIgo/d
	 R6lNxM60kqr6WO6LAoMDIuBQs+pKiWu7qroJOO85G0vtnvk5S+pxp+f78rlx3BDdFzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Virus-Scanned:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zN8/HmNWCVs0b2TQ7riF32r1BrltxELkGR+pHgerNXA=;
	b=lIu/1d7ortsiXtCjmath8nQxj7xtX+mEa4rY6oK9DAp3iqTx1dh47wGnxKkDkT0b3UV9
	 Y2yLIeuWxxBiINwqRhSnFbBdRU1yc867ttvgAHlKlI82jgrgqg/m5p83i/eG0iBQvgf70
	 qGAMtRJXRGZxqcL41kykdWernnP8yKbGo2ztPhRByKRF4LjUnnGh5dUZ2r6IWb+lvm222
	 4OgJfx0LG/6NpQvpX3nuWDC78zKU6oB25LerpFyV3w3fkn2hmWBNdsN6086l3l0tAShrN
	 tbWsZ+RIcVSGJkSVFBQegmN+8eMOL4t7odWhPpGlVlz7CL0iadSminBrhz4jJ6kVp8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=TDdEjRxR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793268577;
	bh=zN8/HmNWCVs0b2TQ7riF32r1BrltxELkGR+pHgerNXA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xO02dmo0yK1UwfWN7teZSUzLJ0neWL9v5uV8KD1c5ciuwGejeWV0eD1NpQtuZfKLG
	 c+qkFatOkD61lLm36H36UxY2A7LkT4+gxdKKpJUeXAJBLM9PrLUwfFdpNF/A4ZwE/L
	 pOIe2MEPBt0zn5AvajmkQ4bsLw2qo+UEmwl4T7oV/OQyGO3+KFko6pUTLIbtMg4/Xz
	 q/HmUafsQzexNCelsbiM0074miE1fqWSNQSj3YwBU9ryOtdXTgle22rjV7ZYJKVnTF
	 Xn/5PsSjCBfVZEdsUS0EF5T7SAR/yu8vXT+BMZ6gHer+uMQSStXgrFFXM61Q46w3jv
	 5WLpLgYlbaUMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ED0340740;
	Thu, 29 Oct 2026 10:09:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BDAA4E89
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADA544075F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:09:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Otm1tC3mkhn5 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:09:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2668540738
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268574;
 b=gRjK/BPi0yEwnxVRJHnlbJeXNY/U2+5XDRyvpLd8oVs7+j2nOvPb38TjzyXVbWFBp/qi
 u02bFnVQpaCsPw7CSTZi9HxcNYMP0TNyJhgno8DyX0FaTgkZb+csGru1VhoAz8Di5QO3L
 aaCoWaUnRI82KICScll5XC28pefUnJHrWHOgb2BV8JgRY1NVqhC27V3+orPoGMJ8aSgqj
 HxEXKDDrOxxk4E2XfXztS4mAq/s/VSPfAI+PF1g5Z/fWxkuKgkgpsj1QMnSJ5sGTCGhml
 eGwCSb/nUPWQRmIW1TiIWB9KSHfKxElOrqOquPTuoqWiyVnjbSc1AIpMJFp49NAP9iA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268574;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Virus-Scanned;
 bh=zN8/HmNWCVs0b2TQ7riF32r1BrltxELkGR+pHgerNXA=;
 b=B2IyICP12xu5KO4Mg9oVrEGiwUFjZR6T5yveydLe0mS77MyuPFNgge5s+6CyHB582uRs
 eXaukacNIhNCmnRNVu6pIqOp7uSGZ44LC2PFqUD9XvNN3kD9Se0zXD23LLobgtAI2JZ5o
 tHPtqHzoQh3MaQjqeM6BmCdSjUvFUsLuvHlsEcDrvLP5f80SRtus1g/0Cod7aoO6vUpcn
 rR8kkmSSDGB4ZaCEV81g+Rmu5w/0ZHHrDAj2Ei975TVO3nZxDtja1tHPYlhs2auvn3lIc
 Y49uNgmTHRnk2e/juVuCzPnOM5oHzofhZadxR8tgdTU/ZcCXpNGl9jb4riU4ZbMrweQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=TDdEjRxR; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=TDdEjRxR
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2668540738
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=zN8/HmNWCVs0b2TQ7riF32r1BrltxELkGR+pHgerNXA=; b=TDdEjRxR9xJTrSgtjeG8Wst2aA
 MAMrG85giPwNYNG4/z96LvpEmqkYWV2wXhHgBI0YB9qapzzEOReldka2xuYiQ4Ghfu0cVavlsO0Bh
 Bz/Y+YgcZpfaeKjtOl+t+6Nr7Cx9JpzqzSU8FJ8oT2sU3tFjNuV8FmrQ+RqNIXUzKqsMSUOl9HwJg
 d6PdlEC5DQU1lY3R3U1/yRJG7MYHOs9g7bMvRiwTgldOP6v+YuoCr0RmxsJ0FSiE0JbDBDvHwBwgI
 CMM0XtMWlKgLHdiCm+ViXpPqWMMGAu9rHjc2kYxv7kNSWiZAb3BYi53lkjATqnGRjSVzdEj85z7Uq
 UdGKuK1w==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xMN4Z-0008pA-16; Thu, 29 Oct 2026 11:09:27 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xMN4Y-000CZB-23; Thu, 29 Oct 2026 11:09:26 +0100
Message-ID: <3cdcaff197b59c6b9e3b376f0e2c15e1d6902973.camel@ew.tq-group.com>
Subject: Re: [PATCH 09/16] usb: ehci-mx6: set up i.MX7D misc registers
 regardless of CONFIG_PHY setting
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Marek Vasut <marex@nabladev.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>,  Tom Rini <trini@konsulko.com>
Date: Thu, 29 Oct 2026 11:09:26 +0100
In-Reply-To: <a0e9aeac-0c20-460a-897d-b2b9163739d4@nabladev.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
 <bd8f810425b7d3f8d1d78fc699b232da5a7ea60a.1793091394.git.nora.schiffer@ew.tq-group.com>
 <a829d462-e139-4905-b2c7-f8140a6cb2f2@nabladev.com>
 <b94621f8cc783f5f1e97578ad7bed3405862574f.camel@ew.tq-group.com>
 <a0e9aeac-0c20-460a-897d-b2b9163739d4@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.6/28168/Thu Oct 29 07:24:16 2026)
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-28 at 16:16 +0100, Marek Vasut wrote:
> On 10/28/26 11:40 AM, Nora Schiffer wrote:
> > On Tue, 2026-10-27 at 18:24 +0100, Marek Vasut wrote:
> > > On 10/27/26 10:39 AM, Nora Schiffer wrote:
> > > > While a separate usbmisc driver could be added, no such driver curr=
ently
> > > > exists, and it would not necessarily be part of the PHY subsystem. =
Rather
> > > > than making the misc setup conditional on CONFIG_PHY, make it depen=
d on
> > > > the existence of a fsl,usbmisc property. This will allow enabling
> > > > CONFIG_PHY on the i.MX7D for the NOP PHY driver's power domain supp=
ort.
> > > >=20
> > > > Also update the code that reads the usbmisc address to use the mode=
rn
> > > > ofnode API and fix the portnr to be determined from the usbmisc pha=
ndle
> > > > arg instead of the alias seqno.
> > > It seems this patch does multiple things, can you please split it up =
?
> >=20
> > Okay, I can split this into two parts:
> >=20
> > - Make the setup independent of CONFIG_PHY
> > - Use address/portnr from ofnode
> Yes please, the clearer the separation of changes is, the better=20
> (=3Deasier to review). Also, please split the series by subsystems, so th=
e=20
> maintainers can pick it up through their trees. Thank you.

I get that these will need to go through different trees eventually, but I =
think
in the current stage having the full series to show the whole picture and h=
ave
something testable makes sense.

Will the ehci-mx6 patches go through the USB or the i.MX tree? I feel like
pushing them through i.MX would be less of a pain due to the dependencies
between the patches.

Best,
Nora


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
