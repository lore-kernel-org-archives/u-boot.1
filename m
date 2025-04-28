Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B184EC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A0782A33;
	Mon, 28 Apr 2025 15:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QVUTOBxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12CE82A53; Mon, 28 Apr 2025 15:58:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84CB082A31
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745848710; x=1746453510; i=xypron.glpk@gmx.de;
 bh=leXJLRg3FkNQKhf8999F1Kk5mJeDbCqjdYD9CIXpOLY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QVUTOBxa/Ua4sMElIPKb7Fa30x4KVc+0fFxMk3gLTaMkF/4qRSQWZugoagQfNzPC
 ZYpsrA8GQzl12bl0BvhNNhpEmM55sVjQ9wgfjIvV1ExCAJH/ZBtHkNJZPIX+b0bwZ
 WjmTsXNcQev9hbD4WO4gGKuvDsGLlSmFkZ5Gi0Ks2x7CQJP1VkAL7iEv/hGAbnKR4
 6FSq6ckOtUehTWuFbUTo6N+CSRSrSE2sZzje/6tI7cpJJ9NNGziiFLkrUK2ps8a6s
 Z+sgfLg1cZjx0qELWpDKdrro72s8r9Sp3U8v6dz4Q+sPr6siLWQn3HfmOTVto5pfq
 xEHZdwFu7OWXf9hkqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1uviGE1qG8-00jYBs; Mon, 28
 Apr 2025 15:58:30 +0200
Message-ID: <4883b282-0c35-45be-8483-aacf03a6c8c2@gmx.de>
Date: Mon, 28 Apr 2025 15:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] efi: add EFI_DEBUG_IMAGE_INFO for debug
To: Paul Liu <paul.liu@linaro.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250423213145.1959046-1-paulliu@debian.org>
 <20250423213145.1959046-4-paulliu@debian.org>
 <f9010568-6a52-4486-9c29-794107f2e840@gmx.de>
 <CALG-KHyi4R7q1Qb6OnMmZCGVySA5dg-pD9yNEnf7SQ8VJyobwA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CALG-KHyi4R7q1Qb6OnMmZCGVySA5dg-pD9yNEnf7SQ8VJyobwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LBMPZkUSZbcmuMWSxPOKAEfgfy2qzcuX+oJPCKsbANTdKxMi9CR
 e94yzQuncz36cmWyCV26+tzaIHPN4/e+enYy1I4y6Ol/UTan6wj6b3QcgMTvctilAbuf6Tw
 xNh2HhG8H6z1b9sfxm5yABxzTgx+lttZUmJxbJJ4nYuou2NECFFFfMTOl5ejjS+0imr7Z9y
 NfO5xU/kqQuujVJC+8KqA==
UI-OutboundReport: notjunk:1;M01:P0:cRM5DIQLyt8=;jQB4NqB7YLkAfQuCAPd4/LQi5Bv
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

On 28.04.25 14:14, Paul Liu wrote:
> Hi Heinrich,
>=20
> Yes. I just copied the code from EDK2. Seems this is incorrect. I'll try=
=20
> to ask some help from EDK2 people.
> Actually I'm working on Android (AOSP)'s GBL project. It is an EFI=20
> application, used as a bootloader for loading and booting Android images=
.
> So some people=C2=A0are asking how to debug that EFI application on real=
=20
> hardwares. And since GBL runs on both U-boot and EDK2, the debug method=
=20
> should
> follow the standard so that the downstream people can have a unified way=
=20
> to debug the application.
>=20
> I'll ask EDK2 people for help and then continue working on this patch.

I have created https://github.com/tianocore/edk2/pull/11019

Best regards

Heinrich

