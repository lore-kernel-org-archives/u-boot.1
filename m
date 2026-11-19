Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC69606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gn3I1/q0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQFb7Iy/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD61781371;
	Thu, 19 Nov 2026 15:25:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0YOmIRQOAOi5; Thu, 19 Nov 2026 15:25:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 34BB380C95
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101907;
	b=MVatbOLvkiRwHZKOMDCspD3dkjwU/cTij/n+uzcHOiN0P5gUN5y4Ts2LDNk0+xb4qjr1
	 Cc847rJaVqlbB/CKKUbaOi5yQA/+ffNU4H5oknUgIhZIckPK7vSAQIZ2v4MRQGzWp1y/c
	 UI5ZQPVDtvwflLgycoS0Fhtms1ju9cptallUxuiIx4osFvivDx2H0oQvKcK9+x8q893/H
	 +5EL3H8fhUgoGHjj3Ra1MUo3l8AQtWVY0KWbg5Hrlit1hAe7rny4aECqfc9qIYeCLhQ5y
	 zciajsSAgmnPYnjoxNVTjaObCKpEOhKm6jo/XcAaZ7kr2qcsx+nORVjQ7AFB2t4ZQ3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101907;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zKJh/ERj2g7cjHzvf0Sb7DxhPAO6kj9h7Eu4Y2C7ph0=;
	b=NZsSnqQegf1yBtOBuXtTLG4g7wm7mM3qA+60qyZ4+43MkkW5HvXhDh1AekUfIS6Pwe8R
	 IHZpHEZi/YMAKXMu2Q+JQ/kBPksWRJsO93rv09JBLypFCp2j7c+EKHwrt1hwVZsHlTBrO
	 XyTK22Yr3BcU9s/ScFEljEZk54pQSJufL33fSsTUsP/D+vmYfkgkkaSsjeN+pwL4CL7PI
	 AtHvN6LG3sYjy8shodAV3PY6Qeg2sTccQ/9TCo+duG4tkegemP3Yuk0r/kABma/DLBBdy
	 ZkUcoUMQ52U+trp4J8DcEUH61QaOj6zJO9oQ7PhTCVa+E+jt/wvR6iBVspe6bxnE+lQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101907;
	bh=zKJh/ERj2g7cjHzvf0Sb7DxhPAO6kj9h7Eu4Y2C7ph0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gn3I1/q03Stv9SHaf4ysDkbDN43Ht2H3MtCu3kmh0OymUgrOL4Aoo/LarVBUxev40
	 ElBoLqNUCRN18o2/s6DzAWhjMLwCB3sv0nqFGV0vOq/C9+/0haf8mkys6HpaAR4AAg
	 GziaFMl+3MhvlfZyMOcN7d5OSZf0p0WhmuZM3/RR+z83+n8PGOjeKslTvrUzSG0q3L
	 1PxjnN6Kpn3xtdK/XStHO+PH/HcclO/nG3k0Cm4+Hy9fYv1EQ+DdSUAk1a5hPkFfD4
	 wCTcmVkd1iGuIHTTF6xeBDbTQwDED+uSFQgpPiVq4eGfHsV+sc482i/PrsKlZJuuqf
	 8R+BrGr6cy22A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34BB380C95;
	Thu, 19 Nov 2026 15:25:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9161F465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8355F60ADF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:25:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T8odGVvrYMby for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:25:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E948160686
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=IQFb7Iy/
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E948160686
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:25:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 30E674434C;
 Thu, 19 Nov 2026 15:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F29E1F000C4;
 Thu, 19 Nov 2026 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795101900;
 bh=zKJh/ERj2g7cjHzvf0Sb7DxhPAO6kj9h7Eu4Y2C7ph0=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=IQFb7Iy/K8MgMKP0YJs4/KJsHYxaVfMD6vxU6riHuzUZUsDamjzJF3eg61u1+WHKx
 n+Lex0I2c0UwGKtenPngAWYsY8116D2ZR9Eeri8kAIyo6f0YXN8wpTd0gwKQVbuauc
 xCmsn+JRuxvP+vaaqABIO+Nx56U6X7R1NJtz1Z5B8iryHijWhywtyF4AedPLoxum3v
 17kyPI9KLMvY1nwMfKjLxmg8BBZJJs/mz8lGo4u9tAK/Cw9I/A3eVsX5K/+1Lx7toD
 ATyVqfiH7e+j+ApVfHQJS3bbTtaGrxbMDFDvBjDTABEn5enTX1lMq0bv/m3de1bMG8
 XeLd/mxkVvo0w==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 03/14] usb: gadget: firehose: add the program command
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Johan Jonker <jbx6244@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Simon Glass <sjg@chromium.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Vincent Jardin <vjardin@free.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
In-Reply-To: <20261106-firehose-v1-v1-3-e7591c12fc65@oss.qualcomm.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
 <20261106-firehose-v1-v1-3-e7591c12fc65@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:46 +0100
Message-Id: <179510188628.516692.592955474225364606.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=272;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=NLxl4GJRwFg+g2f7U4NFv3NlXiHKtBtVirWj50X1bPc=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/xTF1QZPf2ZJDU/6bZgxykOOnoCr7WzSozBd8
 tRjDoX1W5CJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav8UxQAKCRAZDR20Zk4Z
 NSoyB/4i19/BNeaP1ehOpfoBtBh5zffsLLPyLk/6UlxLC9Ae4N2JLH/Gip+Y4bW8kwA7bIKahAO
 6vQdUwV/hruSjHcz1ZoPhr+aSBapWYu2JbxysAhRLsZurWBxSd59M3q+5h7CaZSe+SKHm8CRLjH
 8931Xj+PzmgfubqlSDG5S5vL8cIqjLWmyJQcsiHy0RGy4a7AXfJg1LxLJysjqV0Pvo9Yhp4+3/R
 6vIgm3NPanYoI8bPrwT5yfnHoSqU0T3x3HQku/DduYzy6uSZm/okII5K/QpAvYOyqY2gvcDeZM3
 3PKIm5E2UTmTr6n/lEoi/JEmxjhhpSxjc9NDxGrpCvGWjjHM
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

On Fri, 06 Nov 2026 10:42:35 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> Write the raw sector data the host sends after the rawmode ACK.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
