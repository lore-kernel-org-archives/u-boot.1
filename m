Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A09ACA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECFC58107C;
	Thu,  8 Oct 2026 12:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5THVqUmUIv6C; Thu,  8 Oct 2026 12:52:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B8CF18105B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463958;
	b=A9uFP9Nk+ixDx9zEqnpPUAArPRzUZlNu5cauYc29NeELeofZhawiFHg6zFXMNl3g3y38
	 tMtI8qcuf6FoSOSDPuqGvpYTK3AYwmwyGyjuAEg/pw1PLdQIVTvYRO/y25DLZFl0q9q8a
	 Vw9FbEASq3XHsKGdRYRT1QUm9G5uInT6z+05BPSl0dEp4TmSHxL0icPLnniHMevgMswhK
	 bpnppyxt6kKvcUOBn9uXLz9oaq9unbwvIFGwraDt4GfMflisMyLvPcfpXuTP8QEAeE84S
	 TCPl4JTNiea6G2e7vJBtYdtcUKASUV0gU0Jnp4bMU8RF8P6VHksU/SpsDsAvFlQ23BQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463958;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Virus-Scanned:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ASH4GJZJMW7WoPFxv0s28fVUP8+l2Umnuq/2dHELp8Y=;
	b=lX8XhwU89apJDVtJZ9p1p95bP7RGDUWo/PN5MjGnCyNWjxcS3E3Ofj+d+vxtk9vS0NnP
	 snZ49MXccQy+v5Ep0RdLJaMHKTtTUhg5lcNJvkfwuE85qIQBfZTSIboCFTD9THBoZTIm1
	 CcAaosX78wtuRgqRTmrG4IoI/5LNnTU6X0cVlTmdDpRMw7Bq4PDbEAoC3KK4iKsVin+Ty
	 4e05d/ukFe9bYgYxpbl7jSSVBVj6hlc/IxJ2Y6Ctykz9m+sTQ4hT3LhF66TxQ9A78P80L
	 BYBgMJx6dEEW2HqnHkM/Y/0kiz0twoahn6ZfUouOz8kjMxAXgjZUV9dsLyP+gHvorHQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463958;
	bh=ASH4GJZJMW7WoPFxv0s28fVUP8+l2Umnuq/2dHELp8Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ArzlLdR8cPyRyhIL4IKxk06VRY1PnWLIKh/h0COjVf8NqnX2cFmr9z5u2HKR43k86
	 tUEYYVNdOUp0O6/qGRqHJHKMNKOV2U6N2EmwW5oIa8pY7ZqxBM/CAv5mzDDMyA+/aN
	 BqIHxplCJRMPxXl13id6c6C6b2VaLzRna9HA7gIsEWFZG+W83KMfJeAPdC4ajR3JjG
	 tBB/W/1wNGO7UzeZTHxLOiXC3V8erTzDwGUXlU03xkq2kA/ztko3ka5YCD0UTFMMCk
	 /wf1gWLqBATs0fQIOb9kMylggkZwCP+8gn/PyBeIjQG8yTktoLW9p6WswmeZWzzzVO
	 b36Qqs5oHmObA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8CF18105B;
	Thu,  8 Oct 2026 12:52:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3326338
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7552A6076D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BGEmMu7oYZ-x for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 12:52:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DB133605E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791463955;
 b=bcZnsEfcQfo2xGLjQS03b9cmnltn14LSQupWYWGkQATrsfMbV9dZCdGftJpHkTSbc8xP
 V2wTE99uWl0FO2lNI7eWjuUWIs51j5je1m+/73EH2ugYauA837seIXGDOpqtWWlCOmvRe
 77w/o8OqYSoekCpArqCF6yHbfQT7ki7WEUqvLce6j0cBf0gku8/wk2g89ursXhuwbRvfM
 3mcd6oaQ5B/kFGSeBwvAuRZCfyS8lxraHBWCqp8kpOwoEcDJn48290AtJiVf4mCzbRBBI
 W6t18t1CrBiI1O3HcWAiT/WfUCbGpvImtcWWPL6XfbRPCukFcXY9OPBWYAPI0bbV8TA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791463955;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Virus-Scanned;
 bh=ASH4GJZJMW7WoPFxv0s28fVUP8+l2Umnuq/2dHELp8Y=;
 b=oGMJxGnmmZXf9Z6EpVE4FQESaQF7IX/Hbbthy1P30D1XHayQxJsaT/Gc65/hKSXVZHOF
 hV52D1+xkd35RfRmRd/XMOjZogoDDc7Ql5eGAloeQNIGAsSLcTOO6KkneF/AYPnqiCgon
 K6Ug1jeRfTGFy/Z/KV0jiiO6+0ZHecp/mH/IxDM3E9QzUY5iKnJDw+8vDij1jPrGIEdUe
 4glhMFzAvk2qLIN996In/VztAKbBM5+3v/bQZTgt9S9wAoChsVVSi0i7Asne7OY0zHJLu
 XL/6jp5ZROhy9xJ/IdkIyA98wxoyewtXdEZn/LPjdyBP12CQeTu2RpNLgKLTAjiLiCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=ew.tq-group.com; 
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=EvWRBOAJ; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=EvWRBOAJ
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB133605E7
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ASH4GJZJMW7WoPFxv0s28fVUP8+l2Umnuq/2dHELp8Y=; b=EvWRBOAJUM3RCAS5CQUcidR55H
 WRw8STZctwfkFLLeV02pKmvudLmiJGL42Nt5CoE0SVgQ4WkMA4SehvvvbMAua8z8YZg+kN0o0GFJB
 rtJI4aJijeuLHDpIJ1WLEbrae+SV1eUON0DOL0HD5ssh5Hk1J/7OWwz/LC/iUZ0plhJH9RoupYhJk
 5JpGepx8Hpi6eqh8X8pyeQpUjTtWznXVNM6DVpZid/pqLZqMRPM+XZZQmojYHBIxeDBLH8weUKvPP
 +5NGKKD6MoTlkCd8bpeneI/D7wIMfhs7DU6pWkdNbIBgt1O+xAwEcKSjW8FWf1rbY9drs6XadHxm2
 anA0/iqg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xEnbr-000KAl-2f; Thu, 08 Oct 2026 14:52:32 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xEnbr-000OWY-2f; Thu, 08 Oct 2026 14:52:31 +0200
Message-ID: <15761cd8fffe404a66dabba49421685f275a97a3.camel@ew.tq-group.com>
Subject: Re: [PATCH] net: phy: dp83867: fix register number for extended
 read/write
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@ew.tq-group.com, u-boot@lists.u-boot-project.org
Date: Thu, 08 Oct 2026 14:52:30 +0200
In-Reply-To: <20260907095641.28754-1-nora.schiffer@ew.tq-group.com>
References: <20260907095641.28754-1-nora.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28147/Thu Oct  8 08:24:12 2026)
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

On Mon, 2026-09-07 at 11:56 +0200, Nora Schiffer wrote:
> Actually pass the register number and not the PHY address to
> phy_[read,write]_mmd.
>=20
> Fixes: 614ebea14bfc ("net: phy: dp83867: enable extended read / write for=
 driver")
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>


Hi,

can we get this patch applied?

Best,
Nora


> ---
>  drivers/net/phy/dp83867.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index 34c871857e1..f100ef35a43 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c
> @@ -131,7 +131,7 @@ static int dp83867_phy_extread(struct phy_device *phy=
dev,
>  {
>  	if (devad !=3D DP83867_DEVADDR)
>  		return -EINVAL;
> -	return phy_read_mmd(phydev, devad, addr);
> +	return phy_read_mmd(phydev, devad, reg);
>  };
> =20
>  static int dp83867_phy_extwrite(struct phy_device *phydev, int addr,
> @@ -139,7 +139,7 @@ static int dp83867_phy_extwrite(struct phy_device *ph=
ydev, int addr,
>  {
>  	if (devad !=3D DP83867_DEVADDR)
>  		return -EINVAL;
> -	return phy_write_mmd(phydev, devad, addr, (u32)val);
> +	return phy_write_mmd(phydev, devad, reg, (u32)val);
>  };
> =20
>  static int dp83867_config_port_mirroring(struct phy_device *phydev)

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
