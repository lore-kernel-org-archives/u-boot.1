Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72651CD98CC
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB4B08498C;
	Wed, 10 Jun 2026 14:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pzOD2kVg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Sg4agxop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D085A84954; Wed, 10 Jun 2026 14:21:52 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C428F84932
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gb4dk4XB4z9sx3;
 Wed, 10 Jun 2026 14:21:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzWd1g8w/DJZThy70WoQSfeTYnwvunLJF7mgvK2H9QU=;
 b=pzOD2kVgps6C/FvNSxYX47WBZtZkt2NIwlswszli1U8N3Yp0R8xHdA4YFTIH5EnB90+e9X
 h1eLRY6pJlm6hp29N69OOJBHQWVXa0Qfj8ifDTP6ZCmiBdF/W2NGer5n5hp16tf2sMVG+B
 9UjsKLgUcI85cfbWcubJUv7lmyiSamWTh3TjJHcC+zmcalupkRzF68XOEjoW0pas+oOnD1
 Nr3ksBPHhlIyX9ZuP/2bCs29UKB0Vd8rs1czfsW5FlDOXi5sn1LVbL4rF19jhRPOj2pTme
 dRY5fRDoecIIOW31Y6eCp9qdllqfJsDILTpN3e5tjxI1lAFKPpTGfF74DYi/FQ==
From: Stefan Roese <stefan.roese@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzWd1g8w/DJZThy70WoQSfeTYnwvunLJF7mgvK2H9QU=;
 b=Sg4agxopYtCHuTBODSk+BGlQIJ9LwASOYGSx0DNVxHi7R+PP7m73Pu8gPwsS2qz/MKEpDT
 PkooF3kHtkiCiP5L1o5lunfrNdST96hvF4h5g+kmQMtLBDHU8GgLpSSlzl6MmYE09MLmUX
 XUFQ+IQDmQUMTJs7wgLBmy6DDLk7pq6qgCb2axKgwYUNhpYkQUf3Hv1dx8QL/bgZe05dxy
 wjwdr0VNXGpI5OcySk3WoIYhCriE23vgZWCjhOdFfTxtMMmhALoW3vHiTW8L8KsHm9LIln
 xShU8K9XPUZVwq/oFEMJsAJoO35XmzwoJd+8PyjfTagQyANRcnkZj1LZgI6Bqw==
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] pinctrl: armada-38x: Staticize and constify driver ops
Date: Wed, 10 Jun 2026 14:21:26 +0200
Message-ID: <20260610122132.2674311-10-stefan.roese@mailbox.org>
In-Reply-To: <20260508122201.512840-1-marek.vasut+renesas@mailbox.org>
References: <20260508122201.512840-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y9at3nytx4nsnz7prgymwrrtgnpbxm1z
X-MBO-RS-ID: b2d8e647230d6ce348f
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/8/26 14:21, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot-marvell/next

Thanks,
Stefan
