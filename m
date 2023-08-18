Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F8DEE498D
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 18:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FBA386EEA;
	Fri, 18 Aug 2023 20:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="RASo8Vfz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C1E86EEC; Fri, 18 Aug 2023 20:45:35 +0200 (CEST)
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F37B586EE9
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 20:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
 by mxout2.routing.net (Postfix) with ESMTP id 6576E5FA81;
 Fri, 18 Aug 2023 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=20200217; t=1692384332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJngmntwUPiKPYcBI1jTwWP7/FZ79j1CkpN9inS6iQA=;
 b=RASo8VfzEJWvKtdVxfLPfTvoPNtSYOhgSIEpwGAejnTYzUCXTlp+fnTSRsz5ZP7an3C0FS
 SRg8GB1XnknCbQvIg1ElGU2RLsLNxVh1fGJCQlJzI4KilM9+VZb2iFMVnFCf6D4xqUFDRQ
 0S7rVayD/4zpk0HmNBmOa5zNpqlck0Y=
Received: from [IPv6:::1] (unknown [IPv6:2a01:598:c826:d2e1:1:0:1ee0:d539])
 by mxbox2.masterlogin.de (Postfix) with ESMTPSA id B9E57100065;
 Fri, 18 Aug 2023 18:45:31 +0000 (UTC)
Date: Fri, 18 Aug 2023 20:45:33 +0200
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de, Frank Wunderlich <frank-w@public-files.de>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_arm=3A_dts=3A_mediatek=3A_conve?=
 =?US-ASCII?Q?rt_gmac_link_mode_to_2500base-x_for_r3?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230818174945.GF1515023@bill-the-cat>
References: <20230803165258.14744-1-linux@fw-web.de>
 <20230818174945.GF1515023@bill-the-cat>
Message-ID: <7791C49C-F782-4802-B396-B1A5F922EAC0@fw-web.de>
MIME-Version: 1.0
X-Mail-ID: 2834033f-ffc1-4b80-a479-453a0850c420
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Am 18=2E August 2023 19:49:45 MESZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>On Thu, Aug 03, 2023 at 06:52:58PM +0200, Frank Wunderlich wrote:
>
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Ethernet on Bananapi-r3 is broken after
>>=20
>> commit bd70f3cea353 ("net: mediatek: add support for SGMII 1Gbps auto-n=
egotiation mode")
>>=20
>> because changes from this commit were not applied to bpi-r3 devicetree =
too:
>>=20
>> commit aef54ea16cac ("arm: dts: medaitek: convert gmac link mode to 250=
0base-x")
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> Reviewed-by: Weijie Gao <weijie=2Egao@mediatek=2Ecom>
>
>Applied to u-boot/next, thanks!
>
>--=20
>Tom

Thx,but this leaves ethernet broken on 2023=2E10 for r3=2E=2E=2Ecould this=
 be added to this release too?

regards Frank
