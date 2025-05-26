Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DEAC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 08:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F4882C57;
	Mon, 26 May 2025 10:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nXZj7WoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9295782C57; Mon, 26 May 2025 10:49:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E94382B7C
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 10:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748249381; x=1748854181; i=xypron.glpk@gmx.de;
 bh=95WCVJNwpVSR6O5kgNtrjG2oVIk4lit7+aFeDfyLzaw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nXZj7WoWF0Ft2Kgc24TA3gQEY5DPv5snyh2HPa9W50SWOxxg5xmXnlZBCeoxIE79
 EpG4oZEcsvfo6Zv3ZTgvmzJ7mQ83+5VNR5+kdQOaUh4jUG+epA+Yp94zKE7qFumJS
 Si1DIlFuL46kCvq40YeGrAK+O/wsj4dUqGO2ofCSzVKdTy+3oZI0bXBXtR8W0JUBP
 UJjA6ea/3nLZBv1Aujecm/agKT4rNt2iWQgXqqRp96j3IJ2lWJckclXv5NwoE16If
 M2W5N1g35q9Qm548jc78c/Nsd5IRKGg3mfI5in/8VIkiPo37Bm0Ys7uQEJbb3kB42
 E0cF42+MwRxlie0hVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU0k-1uriPh2riO-00b38w; Mon, 26
 May 2025 10:49:41 +0200
Message-ID: <696ce81c-7390-4e9b-95e0-2fe7f289537a@gmx.de>
Date: Mon, 26 May 2025 10:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] lib/efi_loader: Move EFI network files into
 /lib/efi_loader/net/
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
 <20250516081839.28587-2-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250516081839.28587-2-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KvHs0Ubg3VfGxeYGDi6jm9AhMruKG/XcPAFkxIHUZOqGPRgKEfl
 eO4ftc1Emds4/wQD4EgiGN8cKnhPyPq2ghfGzVKiM6vc6KAflA9/67HglGk4HuHYkorm+yP
 MuDHQHB/y8xRs5RDa1R0snT2bq1FyiNlPMKrjoCXTC6OLhkabXNB6QbRhswOG2v5x+Y8D/i
 B25gn3ElC9TanG5fN6iSQ==
UI-OutboundReport: notjunk:1;M01:P0:Id0jy27m8uI=;M7fRY1VRBx7XgewdCYtxXRnAxls
 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
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

On 16.05.25 10:18, Adriano Cordova wrote:
> Created/lib/efi_loader/net/ and moved efi_net.c, efi_http.c, and
> efi_ipconfig.c into it. Previously, efi_net.c contained implementations
> for all supported EFI network protocols, which made the file bloated
> and hard to maintain.
>=20
> Now, each protocol has its own file under net/. efi_net.c is responsible
> only for installing and uninstalling these protocols on EFI network
> devices.
>=20
> Signed-off-by: Adriano Cordova<adriano.cordova@canonical.com>

Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
