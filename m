Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EED9CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0751280EC0;
	Wed, 14 Oct 2026 16:19:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 13e95ZttbGiC; Wed, 14 Oct 2026 16:19:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4359080EB2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791994797;
	b=XwmUq444DeeKCLbaetecWYX2yWY/9PSeHAS3cKhVZwcXvoVmEgB6La0NQOXc2Y1hlm1v
	 8j7DDca/SBNhr+Rkk+It4a9EYfFIikYcKMfMzU8Htc9mXQ/rhP+I1Ne7fNpkmX4Tq6JeV
	 SMK0PHvP0eI+UaP+t+jxCMaxLKNV6KmOQfpBHewaUDotHCkUt3OjW9OSKOECjWAktGBd7
	 zrNt6t7n2Q3LZoWcHeTdrSgA8eFwZVbulCQbx1G77nrqaethwfn/KLQnrVzVQg3UrJJO/
	 YnWK+GRXXcrwZerxMKt7p/UGTSLogUuJlGYti5XvA0KcKDBi1+adOxuNpYcOaDJvIdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994797;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
	 X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J3rbXSZGOatcdugvYaH7+QuseVx3VXHrmNw0rokDuK0=;
	b=B5+nq2Sk8PuiA2U1iWwIAS7TAuDD5dWlv/m7ylD5RjQCXovAqXOV9IYdMh5ZsS/WBbYg
	 rG3n2Xb6Wos9fhjfZteu4jnbVQsJxsTDMaRlqQEoCe7AqWuJE279aTxddi5c8GfITRYOf
	 wt5fDUOu0CKmBYFOUXKZOiEaHcHSQn/d2gNNMemA7JeKoNX+NBDYqPaPz2gyio4JTRIuf
	 dwuJ05YDmuRT3ub6grGiLCdKCHrFFVr61PsNu/KDNLGk6KH2rL3twcgFx9MlWao+KEZFx
	 z7YmCyZCzcYjB3ukeCYVhDtPKRgCgEBfcHQ+fpq7DtPWej4wcLgIA1Mqg0t7OUPnmSA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=nic.cz;
	dkim=pass header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256 header.s=default header.b=lkffcqSa;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994797;
	bh=J3rbXSZGOatcdugvYaH7+QuseVx3VXHrmNw0rokDuK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ybOO3k3PntYQOVmk9khkHKgN9z+grliHBesWkwbaV5mx49S2i0SEOoeL30zHh9P7c
	 F7PJXeSRUnwBb825OQycYFPZ0E58rcpbbBn+RkdnBs/tJBXcDGuUGF8zCnw2zwQHSB
	 TM/Rp9RanFNoIOHCpXuYUA8kc7ggPXkwUzeR+W78B5fXis73vXv+cu2R+P0yFv578T
	 cI3lhb6HiVhEx+pUvEOtwFnZMd0z0rMKnlvfFco0xO4NBFMBv3kP3q2J7PggxJyqwI
	 TOrqQ7w31v6mvjS9mOPDZur7g9G6q4CCTSzdO7iuvK3caogQuc6tvb0Fp1MoQThceu
	 TrFs/z4uiwznQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4359080EB2;
	Wed, 14 Oct 2026 16:19:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FA48769
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6124480EAB
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a8ysWmVa7UjP for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:19:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6935780EB2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=217.31.204.67
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994794;
 b=Rd70RnTQAUw1lu5p2MV1VW5vKAg8M1zmPDMS4cF0G+5+evTlT9oyMR6yHMiE5rZMgMN/
 J3HmhIlt11K+ApxuGjc7l5lirLv7OPaoDRUkLsxCuQvH28mCvYf4FOnPuScY01yuKcfyN
 xwGwH9bjQDMG3DpoaM+NhAL5UsQ0kD/roJ/RpTpWxy1TmjU5q8iio/aFyMCvBIYBnFDYy
 BkBUY+YWcI35SIIuhiyN1+HEaUp5lBXljsNmcOnEgHJLcQsvmtw5SU8LCKnknMAlMr5dz
 gvPebCz9tNABAOpDGuEdr9CYj+Lc2prXwC4MWGO8Jm7mPeC96yi75t68VYYsH3YTfrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994794;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
 X-Spam-Status:X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:
 X-Rspamd-Queue-Id;
 bh=J3rbXSZGOatcdugvYaH7+QuseVx3VXHrmNw0rokDuK0=;
 b=NHGgJJ8nO+McQS5fIh95+YNoBHCFjIBVGh7/NLBbzv5SskXgmBCYwygsXugDRxdR7muN
 nXOtuYlYRY/Ou2h3pmY/uRPZd63uo59sfa18xpqvHg/r+ZRT0nZteOh6cEjbkCUgV4/iV
 qxkKJCuf0zPI3+Csfy5xbbC9CY3Fo7O8go/w75+QQKX6HduL2TyllgKgfGcByAFUcrGCK
 bfFgPc8UI9YheLZhgFkW7gQGH1wzTaFASQsiRRhu9P/pX7jYXucj+Bv/Y6umBL75vucax
 uRPVjU9ZNtLU/PqoYRlOvstc81DIT/88QeMIYLZf+X4w5vPOSnxO43oFMlUrftyikfQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nic.cz;
 dkim=pass header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=lkffcqSa; 
 arc=none smtp.remote-ip=217.31.204.67
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.31.204.67;
 helo=mail.nic.cz; envelope-from=marek.mojik@nic.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=lkffcqSa
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6935780EB2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:52 +0000 (UTC)
Received: from marcharch.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:8:8f8a:daa8:a10e:7064])
 by mail.nic.cz (Postfix) with ESMTPSA id ACDB01C063B;
 Wed, 14 Oct 2026 18:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nic.cz; s=default;
 t=1791994790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3rbXSZGOatcdugvYaH7+QuseVx3VXHrmNw0rokDuK0=;
 b=lkffcqSayTfizxgpMrGcehBqggBI2dpDzYCyUcQ1NSPUTZt3/3xbHkI249xbY3A0RFEEo0
 QqRmjgc3J+tHUe1h9UjQtFd1MslvCp6ABtULbEsHVt6SBEn/e0brzmoCnYbmld3j9vIBwa
 zJ9uOyveC72OEoGV76Eig/4G7cny+cA=
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
Subject: Re: [PATCH next 10/13] mtd: rawnand: fsl_elbc: Select NAND_ECC_BCH
Date: Wed, 14 Oct 2026 18:18:20 +0200
Message-ID: <20261014161829.28404-4-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260928110434.70686-11-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-11-pepe.schlehofer@gmail.com>
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
X-Rspamd-Queue-Id: ACDB01C063B
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

On Mon, Sep 28, 2026 at 01:04:31PM +0200, Josef Schlehofer wrote:

> The CZ.NIC Turris 1.x device tree asks the eLBC FCM NAND driver for
> software BCH. Without CONFIG_NAND_ECC_BCH, nand_scan_tail() reaches
> BUG() while probing the NAND chip and the board resets:
> 
>   BUG at drivers/mtd/nand/raw/nand_base.c:5074/nand_scan_tail()!
> 
> This broke with commit b182816c1fb4 ("turris_1x: Normalize Kconfig
> usage"), which moved the board Kconfig defaults to the defconfigs.
> NAND_ECC_BCH has no prompt, so a defconfig cannot set it.
> 
> Make NAND_FSL_ELBC_DT select NAND_ECC_BCH and NAND_ECC_BCH select BCH,
> and drop the now redundant CONFIG_BCH=y from the turris_1x and
> kmcoge5ne defconfigs. This comes after enabling LTO on the Turris 1.x:
> without LTO, the turris_1x_sdcard u-boot.bin with the BCH code would
> exceed the 1 MiB its SPL loads from the card.
> 
> Tested on CZ.NIC Turris 1.1.
> 
> Fixes: b182816c1fb4 ("turris_1x: Normalize Kconfig usage")
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> Cc: Priyanka Jain <priyanka.jain@nxp.com>
> Cc: Marek Mojík <marek.mojik@nic.cz>

Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
