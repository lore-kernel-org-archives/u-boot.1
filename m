Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5C0CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:11:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 863658084A;
	Wed, 14 Oct 2026 16:11:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NB9oU3O6Th_Z; Wed, 14 Oct 2026 16:11:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AC11980851
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791994273;
	b=ZHsuUhw9DjjR2jWp1fSg1QodiM5d877CVqJ8kpnnd/kpmTe3kcP1GkmmMmhhn6aXrTUh
	 hIYLQ1cD4xCCmIcHQCmalSRSaSwl4bEzQRkPiUnQFXo8wDs7gDpbrTV1I+01gNKCY/kEd
	 V73MtJG4fAZb2Ke70+SyFGVbuOMS9vM/BjKPPMgrgzaTJv4ugEbPH3m4E878u2YWdGrwP
	 CbzMIXRxurT0NKMLTyGxHiV4mk6i38Q0iSkqWrKLaNMVsqaeWh6u0Cx6qn6OuSALHhlnd
	 YNcPqJrpby0kOhmrPbSrv/+b2Z8fzsxunKke+YG2nO6JlACrcSqPXVv2zYgG6ILfe4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994273;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
	 X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B7o4FWpQ0/bpBQLjwmnP42i5rcmV1K3Kora/kyghp1Y=;
	b=SpqTRwicnCnpW3QB3Ej8nxll1Wk9bLutY86JhH6lBS0nlY8Vua7NGEBjr/8YoT+54jw9
	 MCCccNMtuDhorIWKnl5X9+ZDM4D/HgdyosSQSb2K+bPn54clJ0lP5Wk8S7lvM9p/BJLpD
	 kAuYcTH0wlVVNF2r/MV3ZhLg/hMcptopQP9oc3O6a95Bm5HOVA4wZhrGn2U867NbgLD3n
	 0mJsJqy4GsRI0OKlJAuVBDdMifnGhsgTa59+JVTmtite49acPh1rdm9apOqPJeTm75Iag
	 QmMgQ9ArlZfkLfWQKdnxAG2KsHDTm6X9NsfLbybvfOZG+kfnJTbY+Jf0gmMutsVWbDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994273;
	bh=B7o4FWpQ0/bpBQLjwmnP42i5rcmV1K3Kora/kyghp1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hXHiT2+XSROjw3yjlHnP3+rOTnknFoCsABAyK370pKM9VUk0LojwBi7krovfSu5Ki
	 wblsPt2K4acToEno9tOfCLySHv7p80gNfuib3IzqJ7BQfDFh/BBjhxTOrE8zd2nPg3
	 e2aJqTby46PwovWGAz5WbFugplZp5tFlL+fVbeW6ayeyjJjtznOGjTmrOcIQGn91WC
	 TBDSjS+KoUrwb9gf+0+mfil+8eziSVrDp3VdioTf8qZogjY3oEd/mlkjWOWPrXm88Q
	 ZfAKUb/wU69UFNqxqnE5ChX0YETyIEzb0Dc7NVBiqa+fPMxducF+1bbrYc+C13Dbn6
	 0JPr+vvhs0/sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC11980851;
	Wed, 14 Oct 2026 16:11:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B60844DD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A78C5605D6
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:11:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tvsMuAjdQ3-f for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:11:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 72AE9605B0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=217.31.204.67
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994271;
 b=B+h/RnCb/MAWdYTlb3PxKiYTeID/Ic7z8oPIZdTQUkjDHu4GVhdzDb07w/PZ9S6Rorm2
 FfetXKdoN9e+rDr5J8RsOTA34HrUHxfC4B/eY1nKYNNWmOEjJ7lMAaXW4BhsZ5gQpZLNK
 FqghBlo93BXnzxLHY1v71X/mPyTqK3NQbdl0CSI6WOjUNpyP4Dwiz23aSpnZiJ72Keedz
 CbDnaEq95Udp9aMNL3oHIQs98ek6caBLhh2612b5GoCykGNnDToCt2w3u4aedi9rBF5m0
 NhNqpnLKHivrEA4R+BdPZ0sEnK0+5ECi30/fSyMGtJzJmhLEVggQRHrSDHQ2159AFCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994271;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:Content-Type:
 MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:
 X-Rspamd-Pre-Result:X-Spam-Status:X-Rspamd-Action:X-Spamd-Bar:
 X-Rspamd-Server:X-Rspamd-Queue-Id;
 bh=B7o4FWpQ0/bpBQLjwmnP42i5rcmV1K3Kora/kyghp1Y=;
 b=VxT3xTCoAjJBTfWqHZHfzoasnUXyBSkB1xKkzPzXlKH3bMJCh7u1XL5Xu+f8jxdMSZn6
 4nrVZaZUwbyt4bTZMMk046oir1FU2QJsA84ydWm40VfyYBE3/DalRsVp7aVXtqFFacDOF
 /EWiUUGk7acYAA4/DuUxWrU7V/Bh2Mj70iukOtlOwGHYKXWMa0VgVvLrkOy8l8JnWF8xU
 GLIS9Ay6HB6epnhTb7vHesFduZv2NPgqmBhoTWrMxstBOPHmjCfEn4gzkC2pJd7ZkYLLp
 QfuvhWq4akaQv9TO5cLk58zR02p423tzUfmKKX9H6SPBJ/koZCKXGN7oOCle16iixOw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nic.cz;
 dkim=pass header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=gsptnOG8; 
 arc=none smtp.remote-ip=217.31.204.67
X-Greylist: delayed 573 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 14 Oct 2026 16:11:10 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=gsptnOG8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.31.204.67;
 helo=mail.nic.cz; envelope-from=marek.mojik@nic.cz; receiver=<UNKNOWN> 
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 72AE9605B0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:11:09 +0000 (UTC)
Received: from marcharch.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:8:8f8a:daa8:a10e:7064])
 by mail.nic.cz (Postfix) with ESMTPSA id AD0061C063B;
 Wed, 14 Oct 2026 18:01:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nic.cz; s=default;
 t=1791993693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B7o4FWpQ0/bpBQLjwmnP42i5rcmV1K3Kora/kyghp1Y=;
 b=gsptnOG80cYoy9NNFe0XLfLcswfo3Re/oktuA10RhZCvhtt+PHUFvmv3jrA3oi1hpFayBz
 tmnCm871tuzfDqU1MZYeCaaDRTFgRjSbv6bEv0ggZFBPhqP8UcygR3HnAhBdcBjD072u/9
 dm0isfUwDFOYokuaDeAkXHpdh85k9/8=
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.mojik@nic.cz smtp.mailfrom=marek.mojik@nic.cz
From: =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH next 00/13] powerpc: Enable LTO on mpc85xx
Date: Wed, 14 Oct 2026 18:01:29 +0200
Message-ID: <20261014160130.25799-1-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.10 / 100.00]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 WHITELISTED_IP(0.00)[2001:1488:fffe:8:8f8a:daa8:a10e:7064];
 ALIAS_RESOLVED(0.00)[]; LOCAL_OUTBOUND(0.00)[];
 DKIM_SIGNED(0.00)[nic.cz:s=default]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+]
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
X-Spamd-Bar: /
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: AD0061C063B
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

On Mon, Sep 28, 2026 at 01:04:21PM +0200, Josef Schlehofer wrote:

> This series allows LTO on mpc85xx and enables it for the CZ.NIC
> Turris 1.x, whose NOR image has a 768 KiB limit. LTO, together with
> dropping NVMe and SCSI from the NOR build, makes room for the ubi
> command and the BCH ECC code that the Turris NAND needs.

Tested on a Turris 1.1, built with kernel.org GCC 14.2:

- turris_1x_sdcard: the SPL loads the LTO u-boot from sdcard, NAND
  probes without BUG() and UBI attaches and boots.
- turris_1x_nor: the LTO u-boot boots from NOR, NAND probes without
  BUG() and UBI attaches.
- After an environment reset the OTP MAC and serial number are inserted
  into device tree in both builds.

I will test the v2 again once it's in.

Tested-by: Marek Mojík <marek.mojik@nic.cz> # Turris 1.1, NOR and SD card
