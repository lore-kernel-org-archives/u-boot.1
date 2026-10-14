Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57352CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C19A80ED2;
	Wed, 14 Oct 2026 16:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ALcX4FOPe8E3; Wed, 14 Oct 2026 16:20:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 77EB980EA7
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791994803;
	b=DR/hUkbmOpWpd+w64EhBfeVfmFFI4nm3a33tAB7jbnRxGJ+Z05otdBNaOoAbOGttios3
	 Zwwsl7xaMLMBsWzyfcMrNCt8EKHZ0wDNbdGwIJPMnqDYgwdUfUV6XY8IC+LIx6YJefMe2
	 mwHlBjvMqOdmFwAklktqr48+CD5SuWOVnvako8gcaQjv8xwdS9NfeKJM+Stiu6qVl8jWO
	 Owf9BVXre0FQi6u5VVIqacls8+upUtOonAzDtiNg1P2Tdwf19tonM/imBKzrspHR3CUEq
	 SLCxtQVC+a3QYRO+hHW62PPoMFV1U68eShXtifT6HyfNzLqiQ1AAFoeKzVUvWPaUUWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994803;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
	 X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CWYz7dz1o9qvFzxrjfSKXEBLOkRBHx5OdDX61YaSMrs=;
	b=YzEzqChTpUuy7dKgcTIuKbhkJkvat2q4QT57SbyeEhT8MwWQuZ3oirZFe7FulVL8mcPr
	 KS4ORTzGOGtwsEmaip15CWAkU1EjmEebKeqy3InukRU3Qy5gPpJvhuKOXdNXa2UYouTGR
	 tceybGf149rDeDX77HM0DlGoyGDHIJFFOLdISpPIqFcSXkeFQYk6aj0nxZKk3yv8Ktppg
	 Qs2jZxLmI4WNpuoh6tHTcT0mmrgsEVTivffz1mWJh3Q8SmOuoQs+UFeT1StvE98p/IzxQ
	 Kl446CegRKEQix8u45pYDnQjdy6W4aCMQHAn+b7hnoKGvjYdQb7mAYXNyXDsobhBIXQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994803;
	bh=CWYz7dz1o9qvFzxrjfSKXEBLOkRBHx5OdDX61YaSMrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nhP7TDSE4lBpXqac3pzTxBLHTDIouDcsbocyb1Y9riCdGtUyzlBWYz+34VWow0eQr
	 ew6R7rdUQ7stzmPhaZDFulzPYQIgh2Vd6CCAJhi8UEHpv583S4QEweeT678yArupiK
	 0yWz+wteKocr1roTnZB9rn4NFTwZ/505nf+HM4eS1ag5CcMpE3IIPu/xctuzSaLepC
	 YetGgSAupUFFZHnA6S4LVe7qf1B2WjUtlY327YXtcUHMVDm+4PsXekPTdtvDbcolJO
	 rgiYGYHuqYK8YHn5U6RJO6DAD7fWryqNHDX5oZr6YptyLu0YLKnvuJjw8+N8dE3m/q
	 LIhsq/unKex3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77EB980EA7;
	Wed, 14 Oct 2026 16:20:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 808E41DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72096607CF
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:20:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9o7p3YtuSIr for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:20:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ACF65607C3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=217.31.204.67
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994801;
 b=EVP2ticcvXwEnPGrqViQ5DzukvLoJVQXx7/8anUWovVcePyiwmrjBfEOSxE020PB4qEp
 TZFR2Rni5sJgbx7S1dXVm/Y/GNOwd3xfVo3BxFL3ZNm9frkwpEz/uaJ1yjOYQNz8uZonO
 844XK0eQSZnrg3yzTw20wa1zRb5ay5k1u9kCRJmgItQTG7ZVCtzU0XMJDKq9nKOfOUx/w
 +VCcqBL9bhbwYW4uj+R/n5qaYJz+tmZuueZF1n1JvTsUyP7lP0HsWEbIKYv93xp/9SVae
 Y6XPLGjOMAwloZR9LSU2gLegcHLIoN+GgVM8BeVyg3AbIYY+YWpmmqbXgj+W7ohBkPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994801;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
 X-Spam-Status:X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:
 X-Rspamd-Queue-Id;
 bh=CWYz7dz1o9qvFzxrjfSKXEBLOkRBHx5OdDX61YaSMrs=;
 b=s+VmnmNnVGx3g/0Rrgs4bMmITQDpbiBxWTllDRaJiIUUyyQW1WZej5ouivXwbzejA9Fd
 kl5f4WhzK6J/PVU3/j+CkSooULAJTW1tBbJ/24nmoFVIJn3RFA0J9j+vvOuLPMNFbNR/D
 gumDIXMBkBJl2zlZyw8AG84JSQJdalGIXWW8xyBX4Z8QtfqsuagiWbTojH/TMWY0BgkLu
 V8i4dLRPmDCjy+ZwvS0+F1BSSbuIYrvV7BM0KianhpoIFzuZBVDqLmmESakevwE12ubBZ
 3f+ldp3dbe9UdY4nJa9KKx7I94Ufd3PZEIT+5t35FEF4xwwKl85rmC2w5AWAwSmzC/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nic.cz;
 dkim=pass header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=nP5L86aC; 
 arc=none smtp.remote-ip=217.31.204.67
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.31.204.67;
 helo=mail.nic.cz; envelope-from=marek.mojik@nic.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=nP5L86aC
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACF65607C3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:20:00 +0000 (UTC)
Received: from marcharch.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:8:8f8a:daa8:a10e:7064])
 by mail.nic.cz (Postfix) with ESMTPSA id 0ACC01C101E;
 Wed, 14 Oct 2026 18:19:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nic.cz; s=default;
 t=1791994794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWYz7dz1o9qvFzxrjfSKXEBLOkRBHx5OdDX61YaSMrs=;
 b=nP5L86aCEki9oOCW197I+mcCoMR1zkVroUvZvrojFWUWi4aRArQaTWli76VKCYoeE5tXfe
 5FfMiZq9qj5d2qTSWEz72JZKiK1dffrQ/hUuZYu+PcYteGNX3fOyfuLh6HgF/MMjRtPCYq
 f0XeAyOzMqIBapazmF8AWgB5ijW6ND0=
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
Subject: Re: [PATCH next 12/13] configs: turris_1x_nor: Enable CMD_UBI,
 drop NVMe and SCSI
Date: Wed, 14 Oct 2026 18:18:22 +0200
Message-ID: <20261014161829.28404-6-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260928110434.70686-13-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-13-pepe.schlehofer@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.10 / 100.00]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+];
 WHITELISTED_IP(0.00)[2001:1488:fffe:8:8f8a:daa8:a10e:7064];
 DKIM_SIGNED(0.00)[nic.cz:s=default]; ALIAS_RESOLVED(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 LOCAL_OUTBOUND(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FREEMAIL_TO(0.00)[gmail.com]
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
X-Spamd-Bar: /
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: 0ACC01C101E
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

On Mon, Sep 28, 2026 at 01:04:33PM +0200, Josef Schlehofer wrote:

> Enable CMD_UBI so that the NOR build can boot a kernel from a UBI volume
> on the NAND. CMD_UBIFS, which defaults to y with it, stays off; a kernel
> inside a UBIFS volume would need it.
> 
> Even with LTO, the ubi command does not fit into the 768 KiB NOR image
> next to NVMe and SCSI, so drop those from the NOR build. The SD card
> build keeps both boot targets.
> 
> Tested on CZ.NIC Turris 1.1: with the MAX6370 watchdog stopped first,
> the NOR build read the OpenWrt kernel from its UBI volume on the NAND
> and booted OpenWrt.
> 
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Marek Mojík <marek.mojik@nic.cz>

Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
