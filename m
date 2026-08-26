Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4385EC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9A1A60752;
	Wed, 26 Aug 2026 13:02:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D8VjB_K07rSt; Wed, 26 Aug 2026 13:02:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749324;
	bh=YE7RpPz4p6yIUJsfP4ab1d3oVtE7ljukm2LMBUcwt1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OuFaRK1KqhgGITQeJMrmE/FePSlhOKJIfQaXO8pCHYyAJvMFafdNrD/0045oNJJea
	 7Y4/X+QOtnk/MBg4RjyrW2nArL6CJRpfIsXbvTVgvQdDCXDrNX7iWUM5aeQSwDhJcI
	 CMOSD68LsueV7dB0dKS9d68SZFA1Mw0YU8C3OibwXWaEPiIfAR7/JK4XB9QRCe0eHD
	 soL7ycYPLu1FItTo4GERjNDGyLqSQEW21+B5WfGV6e2iCxusm9+Zmb0pYcbKYQSpl2
	 EHNXsaTA7fhMGhHmCI+kCzhWkhBg6t0FepNOcs+woC9GivNjlg5aCd6zN4uP6DoVbn
	 726nPhvPp7Q1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26DF16067B;
	Wed, 26 Aug 2026 13:02:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C2CA323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2984F40130
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:11:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z9biZEZmM-I2 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 09:11:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.250.0.168;
 helo=mx.adeep.su; envelope-from=v@baodeep.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=baodeep.com
Authentication-Results: smtp2.osuosl.org;
 dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=baodeep.com header.i=@baodeep.com header.a=rsa-sha256
 header.s=dkim header.b=mPQGJyST
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26EA3400F2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:11:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0867063DA0; Wed, 26 Aug 2026 12:11:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baodeep.com; s=dkim;
 t=1787735469; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=YE7RpPz4p6yIUJsfP4ab1d3oVtE7ljukm2LMBUcwt1Q=;
 b=mPQGJyST+SmnMqref0qEqMXrnDqEXARlNIzjTaQ7jJtuI2EOzA7q+8JGbSLHMXiEosXIYC
 2QnXEk7UcJb4BcKtC+VefPgJ9PEag3njOl+t1rstng7vgMvirr3Rj77EB00T81RJOmJPKg
 r5/1inT0ZvxWRAo8g80Tyzjfq+zzukNlrThzkU5U12RXya6nqFHzJ4yZI3A7fSK+sj8B7Q
 wGbEqMq/GMJQ3kRMAizHcPyhPs7qx1y8YL/1ctmW90/LPx7NU/QDhjiWN9mX94HafiDpHI
 vjCi+66zRd8VtXVBQr1okPj1bftAUtaE2m/1VrZj7NO33dXAMRmilOBAt3/4+A==
Message-ID: <c87b16af-5c6f-4e65-86de-39e585b64616@baodeep.com>
Date: Wed, 26 Aug 2026 12:10:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 13/45] doc: board/amlogic: jethub-j80: use redirect
 link directly
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-13-ee7573fe3a4a@cherry.de>
Content-Language: ru
From: Viacheslav <v@baodeep.com>
In-Reply-To: <20260825-linkcheck-v1-13-ee7573fe3a4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:01:55 +0000
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

Hi!

25.08.2026 19:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The product page link redirects permanently to something else, so avoid
> the hop by pointing at that link instead.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/board/amlogic/jethub-j80.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/board/amlogic/jethub-j80.rst b/doc/board/amlogic/jethub-j80.rst
> index 9195df690502..c3800f9588aa 100644
> --- a/doc/board/amlogic/jethub-j80.rst
> +++ b/doc/board/amlogic/jethub-j80.rst
> @@ -3,7 +3,7 @@
>   U-Boot for JetHub J80 (S905W)
>   =============================
>   
> -JetHome Jethub H1 (http://jethome.ru/jethub-h1) is a home automation controller device
> +JetHome Jethub H1 (https://jethome.ru/h1/?variation_id=56) is a home automation controller device

Please, use https://jethome.com/h1/

>   manufactured by JetHome with the following specifications:
>   
>    - Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz
> 


Thanks,

--

Viacheslav
