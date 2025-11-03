Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E8DCCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 08:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35E0B836D1;
	Mon,  3 Nov 2025 09:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="N56P5tpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47FE683700; Mon,  3 Nov 2025 09:56:01 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA2CC8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 09:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AA6D110836E; Mon,  3 Nov 2025 09:55:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762160157;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ZexfqHEkE2XTz7opq7LXuAWQ0z6PFq9sMa3uBJCk50A=;
 b=N56P5tpnKLK11Dhy9SQZT5EOXPBuu8VKuHNrAolxWxfLbJ95Cfq2+y19QF9Jv3zIRfxl5I
 MaK4TQibtK9dSColIH5kJTzV3glpt286VtBo6kIS1tUFosgftKfSaKAxWOFTwNAu4WnyGX
 pcnejAyYJ+plfSzNePla/eHnbSqVSKRNBOOi+jfDuOjdGmvtg5iNBnoTZjSAQ9+mFMXPeg
 7r6RNr+9lGx3FQj+AB/owkkbPqd3XRM0uFbysglPJeWGhJxLl/gGrlLv9ZAPzR6snX+Xcv
 qNlo5DC/urqMsOvC4L/c5GZIZXR3N8LUAGpJ9Z9e4LX0xE0DX8pKiiLO5FU77Q==
Message-ID: <076c5537-3613-38cb-8d7c-e56a89f903aa@nabladev.com>
Date: Mon, 3 Nov 2025 09:56:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/5] lib: implement SM3 secure hash
Content-Language: en-US
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 =?UTF-8?Q?Duje_Mihanovi=c4=87?= <duje@dujemihanovic.xyz>,
 Greg Malysa <malysagreg@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
References: <20251101064907.5037-1-hs@nabladev.com>
 <20251101064907.5037-3-hs@nabladev.com>
 <CAMDkj5w4uwKFJwoSdM2CnG4-ewH3V5X0ZW3jk1MCNH+Bdg+j3A@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAMDkj5w4uwKFJwoSdM2CnG4-ewH3V5X0ZW3jk1MCNH+Bdg+j3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Raymond,

On 01.11.25 18:11, Raymond Mao wrote:
> Hi Heiko,
> 
> On Sat, Nov 1, 2025 at 2:49 AM Heiko Schocher <hs@nabladev.com <mailto:hs@nabladev.com>> wrote:
> 
>     Implement SM3 secure hash algorithm, as specified by
>     OSCCA GM/T 0004-2012 SM3 and described
>     at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
>     <https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02>
> 
>     code is based on linux commit
>     f83a4f2a4d8c: ("Merge tag 'erofs-for-6.17-rc6-fixes' of
>     git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
>     <http://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs>")
> 
>     Signed-off-by: Heiko Schocher <hs@nabladev.com <mailto:hs@nabladev.com>>
>     ---
>     This patch drops a lot of checkpatch warnings, ignored them
>     as tried to stay as close as possible with linux code.
> 
> MbedTLS also supports SMx, can you turn on the SM3 option in MbedTLS and make it selectable between 
> lib/sm3 and MbedTLS via Kconfig? Just like what we have for other algorithms.

I must admit, I have never used MbedTLS ...

[u-boot]$ find lib/mbedtls/ -name '*sm3'
[u-boot]$

So there is no sm3 header or c file...

[u-boot]$ find lib/mbedtls/ -name 'sha*'
lib/mbedtls/sha256.c
lib/mbedtls/sha512.c
lib/mbedtls/sha1.c
lib/mbedtls/port/sha512_alt.h
lib/mbedtls/port/sha1_alt.h
lib/mbedtls/port/sha256_alt.h
lib/mbedtls/external/mbedtls/library/sha256.c
lib/mbedtls/external/mbedtls/library/sha3.c
lib/mbedtls/external/mbedtls/library/sha512.c
lib/mbedtls/external/mbedtls/library/sha1.c
[...]

But I find for sha* ... so I am unsure what you mean now, what I
should do/change?

May this can be added in a follow up patch?
Maybe you can add this part?

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
