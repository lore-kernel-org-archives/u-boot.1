Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55658606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hAy8Eo2l;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=asaZY1lv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33EA060809;
	Mon,  9 Nov 2026 17:21:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D1668_MbAl6A; Mon,  9 Nov 2026 17:21:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B9BB607FC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244909;
	b=aY/5Y7y0ehD8pctcqUmhIjyoajdvK04j+S4ruYxxSZSRwY9LG/hqCbqBDoLOyyO45P5m
	 v/M0IEJEmnszlmXRJVZy4AdjV+GCAfP8vuy8WmUOS//7jXkKk6UXlQ4+QO9o8eA+45hUF
	 bhpRPawMBRNwy12cXQEVMTWQTnn+PSJnPqWcIjI4isSvRPgyhEofJmHQnXlVucv/Hptnh
	 HaXPpdP02A4kVGCQO3pI+WzeH2Ud8u15/LbjGVtjfBgvaOe7PF5WvNnYN8C1VJNmZc+nu
	 E2u5PIih1wC2zJ2cl76BmPqCahZuwKf+Qt4yC/KldiS+6LYswQ/l8b0A0sMl4VYaUXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244909;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B0b0KkaSrQsCzofOJ7gKknF1x72uGEDQhGoejBG4YhQ=;
	b=KKAuvOqPAvQAD1O8oR2tqmUgGg7ihG/Ex+ox3/ZM4kndpezZaEIxrqGXtKvUf4YoYsla
	 ak8XXhDLGuQxPGd1VI91j+GulXF8vkgoA3TPvqHefjtSDy28Zg1G2yEBOBGOzPGfwlfg8
	 X4V03mi51lq8QMtiox2MhmPcmZu3qzxI1wfAq4GikvdYnCdFpG9cBlsKj3nPIbab0UfAI
	 cur9YOPLdKA5PIWzbTiG58WwZKi8cqF9ontT8r2v26uqTqmW4ipscAdNwFY939B+8EANY
	 aPkpNT49Xi6Ettz/L27YmxIwdnVyzvpxFDrEs2sWYQisu2zyHsg5ZmC6H95F4cqxy0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794244909;
	bh=B0b0KkaSrQsCzofOJ7gKknF1x72uGEDQhGoejBG4YhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hAy8Eo2la4NWfDq5iJuPPrPZlNQS8xZiJ0d6lgEp/uVoSaW3d2Bj0zREptTSl84Ra
	 dkIKg5Z1IUrh7A2pzOqrIK1L4SJjgUPygKi0HZaWKLNWvWrXLCs5brkl0GS6VzmKE2
	 MWFIiHa3ZV+dRob+uTfavqFSNShjXZrraLgIZ5JkQd+5+Vua7lCjbw6S9FGmKbXG4T
	 fcVON9UeA0TayVAAC9jAe8IOSmG08N3fARITZaJYEoalQqtM4tLb3J7P9eL9g3MsvA
	 elTglPGW3ysTOHcEV3zT4v1MEAkBrV7faKus+W5rw42MKK8ZgeplZxn5EbX0FHCGU9
	 CNOulXUy9YXRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B9BB607FC;
	Mon,  9 Nov 2026 17:21:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 04EA1971
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF71E40769
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vq8HHxcTk_BV for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:21:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 19DAC40756
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.4;
 helo=smtp4-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=asaZY1lv
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19DAC40756
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:21:45 +0000 (UTC)
Received: from l3017727.home (unknown
 [IPv6:2a01:e0a:ac2:22b0:7dd8:506f:29aa:45b7])
 (Authenticated sender: vjardin@free.fr)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id 3292719F5A5;
 Mon,  9 Nov 2026 18:21:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794244902;
 bh=VpFrHTfETttvv5ep976f83jauCbth+zl8MaRGrbv7rQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=asaZY1lv5AEfbkqisZSizObY8uO4rDyaTfzEi4VA6+BeuJNxPK4Y7iueCqHaz40SW
 s038V+rGvA/iQlsFewwpNHEJWZgckQye1ODMeeV2K1Gyi99UXl8Wo9CBtRDkQeQys+
 dESCEAj0UHH/mhAyHvL9EvJb7jlr4PpApp8V/X3wIAIJIT/vylPw7sceY+qtaCx76V
 +VO1aioIPqVWmtO+KODs2uzd/LCTZ91Q+FCyzA+u89TaO8NJs7sYdu/nuwTto1ihT0
 Vt0Wx55SC4y0Y6s2Lmv1WuNAjCo9dt6XmpxeGfmgdkjE5HdPkybvA24tnE13kKBnJI
 8P3QLhCXjdzvA==
Date: Mon, 9 Nov 2026 18:21:32 +0100
From: Vincent Jardin <vjardin@free.fr>
To: E Shattow <e@freeshell.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org,
 Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 0/3] dts: build the DTS from a directory outside the
 tree
Message-ID: <avIBHFyUj8mDk6PQ@l3017727.home>
References: <20261108155019.1485598-1-vjardin@free.fr>
 <434743b6-17af-477d-a09f-d110d565f023@mailbox.org>
 <avC2OzAeGxqVsJ2v@L30177.local>
 <fdee1975-8f27-45a7-85a8-2405c29e1dfe@mailbox.org>
 <avDgloDmuQcYP7ec@L30177.local>
 <8229e24f-bc71-4232-b1bb-8cd6c976dd3a@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8229e24f-bc71-4232-b1bb-8cd6c976dd3a@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Le 08/11/26 16:58, E Shattow a écrit :
> Hi Vincent,
> 
> There is a concern that vendors would normalize this and make the
> situation even more fragmented, contrary to the intent of having
> Linux as the device tree upstream in-tree as a 'dts' sub-tree.

I do not want that neither: the DTS of a board SHALL be upstream
in Linux and in u-boot -> "upstream first"

What I (we, I feel I am not alone) want is only to smooth the local
bring-up, the months before the board is upstream, when the .dts
changes several times a day and the build is the Yocto or Buildroot
image of an internal team and its CI.

Compiling u-boot outside of any build system does not help there,
and the copies into arch/<arch>/dts that the layers do today [4][5][6]
are a fragmentation.

So the question could be how to make EXT_DTS_DIR usable for a bring-up and
useless as a permanent home.

For v2, I can explore more upstream "guards" for U-Boot like the one that
already applies to CONFIG_OF_EMBED, which "crept into use":

 - it stays a make variable, like EXT_DTB and DEVICE_TREE: no defconfig
   can set it, no board can depend on it

 - a stderr banner as CONFIG_OF_EMBED whenever it is set: the
   device tree comes from outside the tree, not for boards in mainline
   I mean, https://git.u-boot-project.org/u-boot/u-boot/-/blob/master/Makefile#L1404

 - maybe, an error when a name of the list also exists in dts/upstream or
   arch/<arch>/dts: the directory can add a device tree, never shadow an
   upstream one -> I do not like it because it avoids improving/preparing
   a new DTS before sending. Maybe having an experimental flag.

 - control.rst: a third option in the Configuration section, next to
   arch/<arch>/dts and update-subtree.sh pick, for a board that is not
   in the tree: a board sent upstream must come with its .dts

 - others ?

The SoC .dtsi are still taken from dts/upstream, only the board file
would come from outside, as it does with EXT_DTB today (that was the answer
for the VisionFive 2 question last April [7], with a precompiled blob
because DEVICE_TREE= cannot build a file outside the tree).

best regards,
  Vincent
