Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2603606A32F
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jRJfbquZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=WqMvWF24
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E60880D2C;
	Mon,  2 Nov 2026 18:47:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kaVbO6n-b2os; Mon,  2 Nov 2026 18:47:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD53B80D29
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793645261;
	b=k+xTax6qde4ZggKTbEYjZ52H2UofGBI5M3VEykpfG0JR8fQdO7m2dXghPYmKTuMPQjPE
	 Z2L0OXXdv6aptAATWm65Ir5jQg0xhtQIa79lXpitj5yBGkKIDyjc86TNUk6XSwYYQ/s/n
	 S74ZqZYVaPGIfLVceZIIyXZJ+McWX+cU3CXBBGh3/uTw5CLkVAarGIk1pUcVsPGkAclV6
	 EvqnK7devGi9StkxGDCumGQGq/h6ifKoNvfwSiKOWMPCwZu7A2Q28tee9V1+WGJ1c2s3q
	 mqcwkk+Zlc6ehO8XZjY6vmuIliMPZOkbcMnWCl4IMlfpDtqTcMB6RREuC5YT8FvXXKA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793645261;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+O43jwQOFNKqQPftUbPhuighJegA3xljVlStdqLxMSU=;
	b=lJC3UV/nYlda5qB5CxDrqcvPInoo2JczAmjOE7MY2nbPWGD7OBVUeN3wJ4z+kQ7SHeo9
	 JI5AGqAXo6FXX3EC4ghPJgSP1ofsYUxHqR3nXEwys2Pp/ObtjhY0xmGfZwsrtY5esK4+O
	 UjCbUrfl0Rk9PzLECT+x7xow/lCxwjij/miDMHAU23dcyCMxzRyUspzy237mVqPlKk8k4
	 VmYcHO/sf9xXY6yu5+T58P9ptE8nJ/gvEJm1bcFX5EeaKEwZ0+H+PpGskH8v/xi47kSbw
	 E1JxVky14f0PJprKcfZokrVgkAeQbXSFTiu0TcsQwTXakMIRRQAhw9J+ZIasqstbJRw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793645261;
	bh=+O43jwQOFNKqQPftUbPhuighJegA3xljVlStdqLxMSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jRJfbquZIkYHj6nry4IpVVhwoij+aJg+TKgmWjEs61Dn7oOd57iQGk3Qc9kDlCpIz
	 QoTyJ/I4MwRzNmkXB6E72IOw1v+PpTqRC/lUCE3jFlNUTPFSSozXrZ3l3g2Yly0w/U
	 9ItZvlaCZvpa+Aw2ghZqbDSwgUVP539xeCpDqUIs7PoDuDNz8GK4GD8aglYUioFERh
	 RgyMt8L0MxMQnFVKGTDq2DFTlumYpaGSUt5Ej6lEXCSD5HKs/e17dGHgf3ohfS/LJp
	 +NUg5EW6CRzGrEdW/dslyUTGqHZyhU8ZWp1vEZ0gvtcyTJe1jVnAHRDfe6C2jlzmOk
	 B6SJicTDZURdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD53B80D29;
	Mon,  2 Nov 2026 18:47:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B45722AC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C53940556
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:47:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T0LrHxJFQN-N for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 18:47:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1302340552
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793645258;
 b=XjBiTeY8tX31EGflrHuL2OBNpMOZ/Jw2A0ImzrGFg1Y6iRZOMwrfEDU3ET3RPdcpsRxS
 F1LxjNv9eiRrXq6xrZfGqaew76jUiFS4tBH0Vo07d8X11bplmpDBZgZ30kTTmukgrCGfL
 xZYFPTaJQ2Zmj3b/w7e5Oow8cI3m/38ZTtYDMGe32U1OXmTZ5DRlQWaA+OkQXPPIdraaa
 d7GNK5AeCuHL0lN6u7MYhJGdUdZ0XVse2iYBVTRc6+r+4IzornY4sz6Xtw3UVNmcG+evo
 J5gzQTYB6zKdtC9/G7CzFIXu17eVi2DsrH5vM8ZEEug85gMuq+lHKNMKu4Xao6WR9xA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793645258;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=+O43jwQOFNKqQPftUbPhuighJegA3xljVlStdqLxMSU=;
 b=N6ZA+4VbPPfXvB4hLsnb3xDV7WyNzKANZ57fUaPNGo1YV+HIvfVjBhlLSMeB/mAOOLZ+
 nuUcZL87dgV9uG6k3bJf5E0y+LM/zfevFuuh57s1D3sC0ZCr77uXAFdYbOJoXH38zjeVf
 Ybn1k7cxI6ElKTMgmxZ6+o6Ve3YkHiDWVXW8oomIZZi48xIQI52evfp7A25Q4uQ95PXsi
 C0LZKombxmVqHAEMWi9RAs1WICqSJGtDPYrlAwe6T0lALDXzmmy1qzO/eWdm6SMdK/S+s
 JzjGmGVnSxv2/ZimTt5n9fLM8wc8aUGFuojHtQ0ZUyljcZPfvRW/hyT6gq8wXGRP80Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=iav.lv;
 dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho
 header.b=WqMvWF24; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.15;
 helo=sender-op-o15.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=WqMvWF24
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1302340552
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793645236; cv=none; d=zohomail.eu; s=zohoarc; 
 b=PQQwueqEV+lv+67CdXm54XyDvLiIaP4MujAEwYWma0/J9mLsrVYgHrNygRLHyOxA17FhlvdV/5FHXrDJ/Li4Y2VLAxoq34J8jGqnhC0XJzbKNNR/OKvsHrgwzwimPupSjoPU9pB0iIqqKbTmGiNnp6GY1s6MNMMfFIK8mV8xYWw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1793645236;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=+O43jwQOFNKqQPftUbPhuighJegA3xljVlStdqLxMSU=; 
 b=leuOlufuvotRARevsIpsV1+Di4MWkf4pyGYc9/ToYBHFeI+05DGwT/oXbPDZUZnmCkaJZBvZlCJSjQMd0CkKLoSHQJAgIVQR7IB3GAMvdC1jXfZVdtx2JDr0UaxQbtV7y/98X7SuXOktoLmRAp7EVjujHuVmw8hOUjEaCv9sJ3I=
ARC-Authentication-Results: i=1; mx.zohomail.eu; dkim=pass  header.i=iav.lv;
 spf=pass  smtp.mailfrom=iav@iav.lv;
 dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256;
 b=WqMvWF24vx+3BhOgmNdcnW8NIG7IZ8s+OQcleFlx7uT2H5FR2TTuf4e8aNnKLpbcOcfrW+hu3+zdzx2xSbh516P1b+di7WzmaHphjhb8lEI/8xxg/a5StIFOzAQU9OPQJBX0tKOeXUT1L7uu9vWrzj+WhGiy7ZJVerHfglhXWv0=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=+O43jwQOFNKqQPftUbPhuighJegA3xljVlStdqLxMSU=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793645234119815.6813427569205;
 Mon, 2 Nov 2026 19:47:14 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Aaron Williams <awilliams@marvell.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Chris Packham <judge.packham@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Baruch Siach <baruch@tkos.co.il>,
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH 0/2] ata/mvebu: set up each Armada 388 AHCI controller
Date: Mon, 02 Nov 2026 20:20:03 +0200
Message-ID: <20261102-ping-ahci-1@iav.lv>
In-Reply-To: <20261003-ahci-mvebu-windows-v1-0-e382f73fc299@iav.lv>
References: <20261003-ahci-mvebu-windows-v1-0-e382f73fc299@iav.lv>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stefan,

Gentle ping: you reviewed both patches on Oct 5.
Could you pick them up?
