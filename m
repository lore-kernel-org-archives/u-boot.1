Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43956D11183
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 17:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B5E4889A2;
	Sun,  3 Nov 2024 18:18:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JQyaGlc3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6119388E41; Sun,  3 Nov 2024 18:18:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6892D8899C
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 18:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730654302; x=1731259102; i=xypron.glpk@gmx.de;
 bh=y+yjLkYXZTnQZSYG6qC5zzwcGHVtVGu5RGd08xAuzPI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JQyaGlc3xEcjW5YuuL7cBfnTL6cX/Hyi7HxOxQSXxqefh74QULZ95fV30b30526G
 FOMIuRcwInLi1LhfvWP01mfnkBEKOx1fSLgEt5TMtSYUabnGgaPIuqXk7itWrTmjn
 NtLzVvvHAVKPKRUnGiOhPtuiRyzsdzPNW9kqCRqQp7CPmJf1ymLh8/LVtamALAWZM
 0e9CdS2GSlzk4c1qjTF+v1ClkJE9CS8w6ZXu1OV9246Ui9pouPom7yz+r+Tkhglm5
 YdoZCso7CCCiXzC/Ozwyf6n1w+940WwszkLn59mTlOEHeV2bmSi00fF6zQVa0Cjh9
 u6sgVtAH7UiRy8VV2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1tdN1m2rCG-00kjuT; Sun, 03
 Nov 2024 18:18:22 +0100
Message-ID: <3eff8c78-e005-4ebd-8707-6b36b89f10ee@gmx.de>
Date: Sun, 3 Nov 2024 18:18:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] board_f: Correct stack reservation
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241103002828.624931-1-sjg@chromium.org>
 <20241103002828.624931-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241103002828.624931-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Z5Gc0R+3rHJFznd6g06UOjH6lJ9N+84mhtUjdWsEog6jEnGC/Y
 L/8+RdQoeDS+wmsIpMBScPgLI5dcBSIQSOy07LtKVaBV0wteaC4u2odwBfHtYBV2knrX+qL
 XE8eh5PUvyh4E+odB4LWwQel2bhBBI8RcVVzwovBbwEdJoiYfSeHe9V0ti6h8jwS5wLrcnw
 9V5I0aF9R8cNob3EPa05A==
UI-OutboundReport: notjunk:1;M01:P0:Cqk/ufvz9W8=;7H+Wm8Lgel7MC5oAmtNKmpK431/
 32JUKtCwajil3TK63uI0xqM5U1x1zcG6Xf4rwVKMIhtkzht1b8URQgkSyrzrriUaZJ2S98Yxt
 M2AUOr20wLm7YyO8u2jVqPZn62Mcf9FJsPMBXpcIKm8H4IZp1N750ptGNInKQJAWr+LK5vg+G
 7TTgCvKDGYGZyd87Yo/Digxl1h/e/SkOjm4dCwsE8iz4G+vtgPQvq66Sx0NA1+HfH3MCvX15R
 vd+mpYKG3KVQ6Vis6bR7/50g77ZD8dlA6oFZFVSzICQeMP3gHoLquEOi9Sy0/Xi+8LChykd1/
 sYBRCbcOHquS8WPCqsg9idBDY1lBxM8Y5j/KqNvbPEe6NfuXVKzb8qyIKeRMf5nZN3Zb3n3Ia
 Kty8WEedHcdY+816vIGhdyfYNhpltzqJ6p59fS670+1ETF/UuqeeNSm4JMHnPpHXUzM6+439m
 hwr/qpYHAeoLooO38qUIGRsmKmrI3/KfuuXXQPQErjzttKeQi/jcH8Svi1U7FRvFm9oQoxTVb
 MWer11OKZHsSoRVFJ/4u10hqnBaht3c5Shz+P/R1TXD71Dr0VKG0tIKp0y2Q7RAbxUqyP2vKa
 pLBhikP5HF8G6Lazet84lkza1es5nNUcjf9C9WRHjNNFOZyK0Am5/yLCnwRO5HhVjIUDkU2YH
 pPIRIG3kfay55DqAuG5mb5hSFfv4+E9zJEYrcbB8ESGJUTNmfxDQ0J5JlEfR2K1X0HPpVz9QD
 v+yxi88T83bcWeX40I7fUu9T/aI4n74QVcHM1xACCKfjqvrGd3iFw7snwn0lk2LhUGXokpOhQ
 hQPRUHhvJWAe/JfiXA6MwweA==
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

On 11/3/24 01:28, Simon Glass wrote:
> The reserve_stack_aligned() function already ensures that the resulting
> address is aligned to a 16-byte boundary. The comment seems to suggest
> that 16 is passed reserve_stack_aligned() to make it aligned.
>
> Change the value to 0, since the stack can start at the current address,
> if it is suitably aligned already.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   common/board_f.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index 98dc2591e1d..677e37d93c0 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -601,7 +601,7 @@ __weak int arch_reserve_stacks(void)
>   static int reserve_stacks(void)
>   {
>   	/* make stack pointer 16-byte aligned */
> -	gd->start_addr_sp =3D reserve_stack_aligned(16);
> +	gd->start_addr_sp =3D reserve_stack_aligned(0);

In 1938f4a5b62f ("Introduce generic pre-relocation board_f.c") you wrote:

/* setup stack pointer for exceptions */
gd->dest_addr_sp -=3D 16;
/* leave 3 words for abort-stack, plus 1 for alignment */
gd->dest_addr_sp -=3D 16;

Is that not relevant anymore?

Does all and every U-Boot architecture decrement the stack pointer
before writing values to the stack?

E.g. Microblaze, MIPS, RISC-V, and Super-H do not have a dedicated PUSH
instruction.

Best regards

Heinrich

>
>   	/*
>   	 * let the architecture-specific code tailor gd->start_addr_sp and

