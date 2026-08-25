Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52840C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 21:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECE7A80C4E;
	Tue, 25 Aug 2026 21:58:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b6taBr7GE2uw; Tue, 25 Aug 2026 21:58:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787695091;
	bh=9xvzSzZDu85dOZeMfE3YpD94UNsTylyMyJNDMBwPkyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oiu2YthhTvTSXpJSsLhIeMhaKZ7plOlqfv4jkvg3FqgcSoeuNvbz9aGCMvPrGRhQv
	 digVFW6Vw12/wV7M8F6pEqBGP8B2mK28NTQmCg5FlCjNNG2rjaGvTzTQgY8z9u7uVb
	 RziUo0iKIk3k7Wz7Glc1IH22vZJTjoT4uCaODLn6y3B03DGMLE31r6YLWPjA/UoTN1
	 vUKGVBvXcQSKROxx3KNpiI6OT5sCoKJpPQM8LXKJHRrzfGFrQlr1jJ4XntL2CWegop
	 9khgwE6J120E90Yx6AgwDYOv3w04kcMKI8bg6vEtZNNJGEKQz78LNJgxyV313iAYZQ
	 IVrRK6NqOWU1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E006F80C9D;
	Tue, 25 Aug 2026 21:58:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 33D6F334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19E6C4008D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aBoR6JCExE_7 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 21:58:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=VBBIducS
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA69040055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 21:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787695083; x=1788299883; i=xypron.glpk@gmx.de;
 bh=9xvzSzZDu85dOZeMfE3YpD94UNsTylyMyJNDMBwPkyU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VBBIducSxiK9yFic+KWk8+sO84L6wtg4RnWVzub7ywRVsva6SGSHcQoBaJaRvsFw
 BIu7HGIg5tX3JQpLfDLwhC+II0P5fxFNJpn3lK0bgKTyUCtsPN7PGUXE4LuXI6f/z
 8wMXLLhmlly0jlPE57r8dtLCfsCOq4hK++zI0ZEIYfH2cUDMNcpHgdYxBcsPWnSNG
 C+C6W62l7rsMjrmmORuju61FQPwIEcSz9tHCnrO1CyH65r7zwqCNUmxJk3mDIOZQ9
 EUkZcYMVsImDiGb4b87a/bsGleXR4sWMD0DQ42kXNRWwe+m5VuRvqeldgPjFHK9iO
 AUCbXYvhYcbssQaxCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Rm-1xCmua2jVe-00Y3x4; Tue, 25
 Aug 2026 23:58:02 +0200
Message-ID: <2ea4e4a0-960d-467a-bde1-4792e83086ed@gmx.de>
Date: Tue, 25 Aug 2026 23:57:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 09/45] doc: arch/x86: update link to ACPI
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-9-ee7573fe3a4a@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260825-linkcheck-v1-9-ee7573fe3a4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v9rQrmCSWOch5A+J+IB9RZeu/UHAIMleM+Ae3UXIhlezR7iwPNx
 VQCY4U8R27HvDb63v5f9mNtspHB2T437sQWWHSrmbmQvY75WDmIfZ2NSqL3JLOighhO6SCn
 CuXjRhAi0SENtltEoWpELhwPrVtbXzDlv21gQxXuDuaO2CKxKXZXMb4n+72mrwCevdynp3h
 MYZKQcPeXpCa1212KWEtQ==
UI-OutboundReport: notjunk:1;M01:P0:AVbrf3Q5+hA=;/i/hhC+V4HQr8+blNXXOi7n7n+k
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/25/26 18:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> acpi.info doesn't expose anything anymore.
>=20
> One of the last archives of that link on the Wayback Machine states[1]
> that the ACPI spec is now hosted on uefi.org, so let's update the link
> to something that actually is interesting to the user.
>=20
> [1] https://web.archive.org/web/20190522071820/http://www.acpi.info/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/arch/x86/x86.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
> index 13d2b2ea9af3..28726f717f6e 100644
> --- a/doc/arch/x86/x86.rst
> +++ b/doc/arch/x86/x86.rst
> @@ -486,4 +486,4 @@ TODO List
>   .. _SFI: https://en.wikipedia.org/wiki/Simple_Firmware_Interface
>   .. _MP: https://en.wikipedia.org/wiki/MultiProcessor_Specification
>   .. _SeaBIOS: https://www.seabios.org/
> -.. _ACPI: http://www.acpi.info
> +.. _ACPI: https://uefi.org/acpi/specs

This is just a list of outdated ACPI specs.

The current specs are listed at

https://uefi.org/specifications

Best regards

Heinrich

