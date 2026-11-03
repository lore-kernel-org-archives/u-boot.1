Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7A608360F
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ktgsTdGD;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYzi2pyJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FB7F6070D;
	Tue,  3 Nov 2026 10:09:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xor8hD9WvKSs; Tue,  3 Nov 2026 10:09:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC5F3606A2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700587;
	b=NEh2gif37Lnb0g1B5qFkHWR4wUIBgTgt5FhSCAdfy3z/59SeQ42w0W8PhhY0uM54n+Dk
	 SgkcLS2At36age3m6xD4zNqCsiXIR256V8nI+xRbacPd9Z5T1qLgd3n4xkN2AncsFnrFP
	 R5+SGwU3Ca0Plc++JWD/s5Ti/+QnlQ2LVqd4sCUa9/TaSUgylxtdVW7iPMaam8GHNK9I4
	 idz6yO3RGu+54FfC3ES1OTmiRzP9qJ9JEgmLaut3Pj/L5WtF1uUCG/noIm1a/B4pPZuZi
	 uYbUZZE0qlskg7j/J3yBFllQ7mK3bhTI19/3MFF/FwTAmB3vfL+bXII4ZNTISDkDY9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700587;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Vgo8bEXSCd2nc/viZo4xEoip1FNnzFUr0dIbdc2ze/Q=;
	b=OHY2PFvDzNXlBW0IwHXQFELEXJf2CVw2m0QTTZlyF/vMSqp0ciGwQfWz46zNineJM9YX
	 m8Xv5uVcsZsi/N+6viTvTTKZ05bFPG098zsxfDZBX8xB2kVDEuQYd+r5+4+4SJSW5GZu1
	 Fm2WzYl10NigKONdef3DcoEPUHhFGEXqJ7Rw+hCFXqKJPFYriKIXUU4mhP+n1J1lu+C3x
	 SAKeAVlg+G8NtKK0dqoQqVwH7ydYvnAnivx5haRixpaxYvR2uOf+jiiFTjmUcjhVZsFjN
	 SuZT/gY6aIDqe2AlYNoyuQneBZ0ngfkFDcWVhePq2wqz7an3A58ghBLM06FH+k2GtaQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793700587;
	bh=Vgo8bEXSCd2nc/viZo4xEoip1FNnzFUr0dIbdc2ze/Q=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ktgsTdGDKpwNEzE2LITvZwGyrexSfVDXL40rEqKRF0KuFkMSZv2DO+Wy+/ocw08yj
	 xemkZrpKLn97OWNc1lOGNQWIBC8c5fcBECxGCN2RnRXjxM7nxUhoCYOeKgWLBwjkxD
	 nVt0WuDZrwO3WKQP6Mv02oLYFCpEI0KRvzyZ7zpVDqvyUi49qWBorWXigOIjFgwV8N
	 chjUTEa1OLOvbbVMspWDQCKeiYQpOgy/4OLUDW3ZPZCrQMsnI4Mke/SzJGUzvlyqaD
	 xHZBv4VH8taPQQLiJrZ2/RGG46CBe+6xtvUglDLMVyxuGxBV/Spmbe3ztvvMYtSTeU
	 blm+H1xcWxigw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC5F3606A2;
	Tue,  3 Nov 2026 10:09:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 254C3356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17A014005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6t04LjNPlIa5 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:09:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7CB6A40080
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700585;
 b=BFqzPXfdokkBfjwb7hHgLDkiYZ4fJwnHyO+SDywfEsjQZ+eFfti/RqDRQc+5LuNR7UX3
 b5z2ADkq2OzxWMhEQSYLzu4xMoSGcvh3tw364t75gTPpHOUD8xwMYHhZ8C+9rgBvbUzkB
 2LH2AoIWLzAVL5LAB7mACD+C09umGNVIXwuX+QjBklDmCNHfroN9EAeilnxM3i+Hlvdhz
 bFaUaih9fr40/6yYrrILjbM7dS4aB4t0EcVMQlV0Nt2h0iMbPz5jzSKSqF3M7bNWbjEpQ
 jaaJyPC4F3Rv/VHtAQzRKXJguTQWjPfTQa1fpafjo4oQJ2zCwSVUwU/lYwKvZMH/pjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700585;
 h=Received-SPF:Received:Received:DKIM-Signature:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Vgo8bEXSCd2nc/viZo4xEoip1FNnzFUr0dIbdc2ze/Q=;
 b=Yj8y1EIvcFx2VNFAHOj05T27fA4OznDSRpBVpfuCsqVZMWkbd+NSpmVJ2Umsb4K1c9Mk
 nOMh2Egp3bMQs3FbvVK1jeqOXsWU0m653S/xsOKQG7hcVSQEvVmejNfsEGG90ZPZn2WFW
 zwYYnxGpj+oMn8E62HJvzFJoThYwabJw5KXv8i8DDy25W65BzZE3DxjeDSEjOsXz6sPZ/
 CrQjaMlIxTZ3THXrMRnQrqbBHDlqs8c/Yp5IerTj/pWQ8mgBW3D+HEOmPowBO9yQd64CH
 F70gBMJ7wNbXMwHaHgGuMq7YFv/DgwlYYLdGSARPaVPO2HTe2sfNmsknxWUugzVnswg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WYzi2pyJ; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=WYzi2pyJ
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CB6A40080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0FF0F40AAB;
 Tue,  3 Nov 2026 10:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759DA1F000C1;
 Tue,  3 Nov 2026 10:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793700583;
 bh=Vgo8bEXSCd2nc/viZo4xEoip1FNnzFUr0dIbdc2ze/Q=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=WYzi2pyJ9FMP1YpGN5Bntd+ySKVeOsdhbob3qLeu1gsd5e+n/CQjzzC1NlOFyJqia
 4oP1J6hRh5UnT/J1lSqu4wN1jx/JaXydZKd3fvOTowVuzjtqdqH0lLnreoQgZLS7Vp
 lxrhv7rwc8UffxgJ3QE5suB9d/dG+/Su6oNHpnl3PShN5K8TJpA2kFif5xSNBUBPG0
 302SwhWYFbKf0c2A60pFkUhp4pNxTZ3ZiJKqkwsHywLkd9i3rjFhWbeaB8VQE4/QJD
 yLAVOny0vR9d79IhmrmCaddBoweAgRlfyxW9S1k5fecTrDXAiaiWSQ1BVcUmLBBm8Y
 qY72yAozaLPWA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/6] fastboot: invalidate stale and incomplete
 downloads
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-2-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-2-d29df15fb9b8@baylibre.com>
Date: Tue, 03 Nov 2026 11:09:31 +0100
Message-Id: <179370057187.349126.10680863693161023170.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=445;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=UGdJejAXSTFXdap1r9NJGTwqXYoLi/O2BSJL/s16ohM=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq6bLivXtS1+FI9ItTlCnwUf7OaEArj0v51Muvb
 6R97ur0mIGJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaumy4gAKCRAZDR20Zk4Z
 NTwbB/wJIB9oL/81eBzDmAnwXysTVDu2POOJjDFWNUU9/B+OFBvLef7XcQfyvDHmmhPFmMIeX1u
 Ap7KzsNTK40SrK7hI/EJHF4gkbw29mxow2Bs1SXRLQAi37t6qYf0f942HuoSgRjXFU2LISzfCUl
 4uLR6sBcf/kSXJGwF+A5P0yx/GxVV5xC8DW1P1aYMFZaicEfaZLBeFWVjaA5H+Hci734zajr9B0
 wsVTdcXktSVYyK/wjBlq+7gojZMVMg/UuYXPHGeTbou3/oMG1plgRFXh4inea8z3/Xa7Nx/2YkR
 jRnPbXtKgJUO1g53d/B3bw9GSpKjgLaQpTD0VkpCvXsE9Br2
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
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 14 Oct 2026 14:24:30 +0200, Carlo Caione <ccaione@baylibre.com> wrote:
> A new session or download must not retain the size of an earlier image.
> Otherwise a failed transfer can leave commands operating on stale or
> partially overwritten data. Only mark a download complete once all
> expected bytes have arrived.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
