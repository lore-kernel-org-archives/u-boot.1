Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCEAF4180E
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 16:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B80083F20;
	Mon,  9 Mar 2026 17:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KepglBuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA38783F6D; Mon,  9 Mar 2026 17:38:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C4FF83952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 17:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773074290; x=1773679090; i=xypron.glpk@gmx.de;
 bh=GC0yFUlvwjbnqBgfxQlk9HBTwwXCapcP9U6zKF/+h3Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KepglBuU06jL4aJKsDZNgtp0wkY6H8m3vfMxX5VxZQMx/ZuerJmU1izQekmOVM6g
 y+ilg4wW7LFz+Y5kHtdQecpYdzKS4MybA1/sNrjugLyVlpWYx/ESiX0P1FfVe8Pm4
 9GekAluqoLNy/Iz15ffOY5EBl5Z9Vepr2163PhHoi36ISWkzqnKUomiO1FFmxJ4Xo
 nbmvhuLBTfEiBC0GDU71MtCxrNykeP4kJ5pYwM/DFA1PhsMbh4l8XusHyQZ/e0QR1
 D32cZWE/nRjghw0qgcU6cNy+JG1vf+I7sq1ku1k9TT4JnCErH6BpOipcen0/Ba0fN
 nZhGOn5jgsqciMVK7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1vbSqu3gxV-00rZTe; Mon, 09
 Mar 2026 17:38:09 +0100
Message-ID: <46dd8179-b0b4-4ece-b133-abb35e19db22@gmx.de>
Date: Mon, 9 Mar 2026 17:38:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] lib: uuid: add EBBR 2.1 conformance profile GUID
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260309163638.2340548-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260309163638.2340548-1-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eVn8pA5OUBekqKYIe0i0ayUdUapy5vrD3WzuupdOVB29wFmaWgt
 ElrO6Jrafu4eb/3VrXOe/INFOszzh1Qlr+O234DTZc2CdP6LXN1A4sy6Ger6XCwlfNH3t2z
 WPuJye9+EC8VKjLw33MMyvQ7VrDntuLApH1QHc0YviOM5dAARaBZBuAPqmnlISezbxXGxQ1
 GgCncWdYk59qoyIYzbISA==
UI-OutboundReport: notjunk:1;M01:P0:KyS34ScIgiM=;dhzq4SaNBWAy9fx+eT3BBg91HGp
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

On 3/9/26 17:36, Vincent Stehl=C3=A9 wrote:
> Add support for printing the EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID as hu=
man
> readable text.
>=20
> This is compiled in only when CONFIG_CMD_EFIDEBUG and CONFIG_EFI_EPCT ar=
e
> set.
>=20
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>=20
> Changes in v2:
> - Gate with CONFIG_EFI_ECPT (suggested by Heinrich)
>=20
>   lib/uuid.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 0a166320e07..3a666d0430d 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -254,6 +254,12 @@ static const struct {
>   		NULL, "EFI Conformance Profiles Table",
>   		EFI_CONFORMANCE_PROFILES_TABLE_GUID,
>   	},
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +	{
> +		NULL, "EFI EBBR 2.1 Conformance Profile",
> +		EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
> +	},
> +#endif
>   #ifdef CONFIG_EFI_RISCV_BOOT_PROTOCOL
>   	{
>   		NULL, "RISC-V Boot",

