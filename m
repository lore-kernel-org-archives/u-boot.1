Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DCB606A32D
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YVi2QPeH;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx7kMI1q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5534740910;
	Thu, 26 Nov 2026 11:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-y5N9p7yMn9; Thu, 26 Nov 2026 11:07:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 355AF408BA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795691231;
	b=Og1YtAB/mm68sVy7wTC0bfoe+RgiaqT5cNiiAI/T1s8q1MB9FgliZJAwl0T+oF971i1J
	 jdr0MwL05BA9SRzYoIRQr8KvUwcmpXMlfLC6AIpc8J9XKDJ2V9Cri+Wk6VXrRswkRSDFP
	 R8WZI9/9yp2ZKW3Q73VRg75wtuELT8IV4Aib/Qj9T07PNMQ4+1XQ6nMBAxp/DS1gc9UJz
	 YPSZEB/sSRajtWVcOtNq1VwCZvflMKwjciDgDyDFxihF9COpwYiT/4qJS1fWkSL+x+UcB
	 anGB6qZBRx+B4s+C+3DhP7+ut1JeZchUiu18DRUDAPwpfalN9orOrJVQYZzJfVS7cbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795691231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GcntT11A9ReTjmCZRc9pdHEImQw0ByF7V0clEYxa8C8=;
	b=pGC9uRTpXahihRd8M1suLk0dq0X7G1jLDtr+XBbLrlDqG9GCEQWnPgQe4qAva6R50Q2s
	 u+XBLWCe3fzon+s6kYxEUIJpczWL+dWdmOtE+Rldhu3P8wFtqcw5g+KPc8rR5EC7Ilamv
	 6EYrRvc0q0l/+259iED3CGzYUiOkvXqwHdKZ5OWQmxb43rau9gl7PO4jlg2xQhE8PV3ms
	 dNmObf7HuLSYCWTxGto55tojSTbOVAgqh7BymdLhZHIJevbOJk1qvZwTYc0/39nU0ytvZ
	 zrEtp3fEbegupQUAJvdV84EN36ykvNqgXNwRHi4M+Zs4rKHgSc3csqyu3uDi8ynCJKw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx7kMI1q;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795691231;
	bh=GcntT11A9ReTjmCZRc9pdHEImQw0ByF7V0clEYxa8C8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YVi2QPeHBSf9Ek/QYhMgoPqD3gv9J5jLOiGqOEjO59E1zFB4OFlmqs5Ea0GSR0UZX
	 YzH+gKrwdG7lhdE3aGdqJXBAxTi2tI1bWpWI46NBGscKpZyLeqjQCBWx1XNfcak/dv
	 Ae+o1HYkKlu2lMVCBkKaTH8vEb05db8yEWE/5KSKHm6Wgt0RX2UCvjKKO/3Fnk9zph
	 sAnkBUNFAxPCkEcWfmyTfWjF6qQBygyW0GEa6/E7LNKJOqfDpjiDIFFQs6XLFCQMco
	 6wLrQyd/QQbfI2rRh6vVjtgcarLKZ5p/uazFsGIpAEqD0GFvnMxTK5/pBKc2bboSaE
	 +xGNqKb+kn7cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 355AF408BA;
	Thu, 26 Nov 2026 11:07:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A48F043
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1EA0408E4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:07:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id utK35fD8IErN for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 11:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C61F940880
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Vx7kMI1q
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C61F940880
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:07:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E60A54336F;
 Thu, 26 Nov 2026 11:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491591F000C4;
 Thu, 26 Nov 2026 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795691227;
 bh=GcntT11A9ReTjmCZRc9pdHEImQw0ByF7V0clEYxa8C8=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=Vx7kMI1qleLMtqLDnqbyMf60E2avwGar/FXHCul/IExQoqYOw4GLm3GasUUVHZbGT
 O5xl0MF2ue63ETvS7dZk/Y7Xx6WMtJHEImf2X8NYOlGRBqfr9iqwCCL4mUpCtIjXpy
 WgRvm6JLPQ+ONZKWDVBfLHzYf4GD5OgVLyr6YbyaXtN4sEPypuUZVV8OBqCAIur4AZ
 pBYDQEcZFe7m+BPiU84ES6umc7nvAeJiFxhgLDrYjauDhvicZYmcA4IZa5wQz6R3gd
 6yOUMEOvRVeeegAmpiguSGNao33GHCBYTNxV6fOXiXfB/HbqSI4rcgDNv+1Er5omF0
 0/SI6qeS0KSUg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] lib: sparse: call schedule() during image write
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20261119-sparse-schedule-v1-1-bb683a12f268@collabora.com>
References: <20261119-sparse-schedule-v1-1-bb683a12f268@collabora.com>
Date: Thu, 26 Nov 2026 12:07:03 +0100
Message-Id: <179569122370.2141121.9531287338427336357.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=940;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=fpzyF4d082rGVRjKggsLZofQkB1izZb48ptD5+OhTsE=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCBLZSJG/LS+04sLTqEuJke1Uxbl/NaV9EbtTK
 l48DvPO1hyJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawgS2QAKCRAZDR20Zk4Z
 NQ8YCACRO8sTMEhsNo1nQaaZKC/9CY0GXwwwr14m/8L1kfuqboURzZtlXHqJed/Xwf7oypjZ/QA
 RES/5AWoXmOTjA7PtXjgzclv2JEhhC22t9N1/HpZXcSF0nljq0ttv8dixOp7kgWxX+Y3gzmagcW
 /fRnnt3ILzIYNxvPhOHLF0E7IIQNJk2QQzlddU579rk7IX8fed2pF4I1/D19Ti51LkbV8Y48A17
 J/OQWaptnj+swrCHj5kE0TDq+qqierK7DpYY5JMv+NAcXeLpFT6T/S6vbcRAGObfBhbJlr1JP2A
 LyJaURpl29tVuvR/d2vuOuwxUwtOMMhhYgtn4FdTllluNwwb
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Arnaud,

Thank you for the patch.

> On some platforms, with a big enough fastboot buffer, the WDT might
> expire during the write, leaving the system in a broken state.
> 
> Calling schedule() (which in turn services the WDT) after each chunk is
> processed ensures this doesn't happen anymore, without any noticeable
> impact on performance.
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>

> ---
> This was tested by flashing a 1.4GB image over USB on a Genio Pro 5100
> EVK board with a 1GB buffer size, the longest write having taken ~24s,
> well over the 15s WDT timeout.

I think the following should also help with this problem:
https://lore.kernel.org/all/20261117-sparse-bounce-buffer-size-v1-1-bb0c4f7eb99f@baylibre.com/

However, this fix looks reasonable to me, so:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
