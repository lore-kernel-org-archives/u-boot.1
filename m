Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85A0C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8590A607CA;
	Mon, 17 Aug 2026 15:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSXUAUvAwll8; Mon, 17 Aug 2026 15:44:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EE25607AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981462;
	bh=J2rnSpLOJ3xGNKuGYnsoNnvAtu/G/POvmVqbQlpAFKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qzrUNqqAUO98jgkcmiRZtInboye5P4qcGMBTEXjRvMNtlH3VaIja2DvDvmueZ6icv
	 LxI3Ruin6wiXU31XNjI4CoBWD/vzO6ZUsR+4Nzsc7ENpF1+m9ri151SdBSoKqn6qVW
	 GQG7Vn1WUjeaF2riZGZhCyng0SNIXCLhGhSBVeAXViTB8YGr4l9Z3d6j/JQeqQryW2
	 +57c5bQkthz0Xs4kew65L1YYBsErb4oYUwxzKbL1liU+vYLVTGLQvTdJkNN9aXo9/M
	 ujyCmtGW85xn7L23wpuQKpfbOW/VCcQfePiF2M8GaefoyJsHmheQtXe5uoLh+5i6N+
	 JCjIRXUyMEcnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EE25607AF;
	Mon, 17 Aug 2026 15:44:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 55F23337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47D05809CE
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRW73OYDK58e for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:44:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3B291809AD
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B291809AD
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=JORM5Gm4
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B291809AD
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786981447; x=1787586247; i=xypron.glpk@gmx.de;
 bh=J2rnSpLOJ3xGNKuGYnsoNnvAtu/G/POvmVqbQlpAFKs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JORM5Gm49cBB1ckuVwx7cmFi+UL2c2isCiDmSBapVsH/APiJbtk6HGVAoN7JeOQq
 774xv8uPKjWfMmytmFUrIlMZ6bqhJyRkZJXrQ73aT8kV9qnOyEqnkqXaPNnIk8aes
 D6BOfFKSZEX2qBiP5Pt+6KyKj13ZG8zXy6ULdzoDE4TF9BLMvZuz3B9qC2o02qLAe
 R4wr2U5zlwPASdnmi6ICBheY2QJ8botxTohZbR9I9U/hJXwWss261DGXfJFHbdNXK
 V1Qa2AgDunP4vFsKq7CfGpSUpym+5aLGEe4XuuQctYoaobZft0Ishc1gtu+1/OLoj
 g5f5SUaCppdutn/+ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSt8Q-1xPA9A4B9q-00O5eR; Mon, 17
 Aug 2026 17:44:07 +0200
Message-ID: <214c4ebc-5d7b-453d-9f39-b1befe48305d@gmx.de>
Date: Mon, 17 Aug 2026 17:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: gadget: f_mass_storage: Remove useless rc
 variable
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
 <20260817-move_schedule_inside_sleep_thread-v1-1-0023194e8c47@foss.st.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260817-move_schedule_inside_sleep_thread-v1-1-0023194e8c47@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LeD4ervvE91eUvEVB3AvQH7exRNF1ZpsPYEFR8029T6HLGT6dOI
 mByZJwtLPHOASyJp9cqcOcd/LaXsbzAC1jLrJ53J86mp9elNE3zK0kbAmi90zimZS+/SAho
 HSsV7b91JKQoL07Oi1lZgG9fmgmuAhzN+wQxhrWh1rkCQqHFVGRWatGjU66e5JC00ozzfzX
 nX5L6GJPY//jA35SMuW3w==
UI-OutboundReport: notjunk:1;M01:P0:d9UDL4CGa/w=;Lb8/cjimkUv7pFERtki2hxHNYUb
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/17/26 17:41, Patrice Chotard wrote:
> rc variable is used as sleep_thread() return value.
> It's initialized to 0 and never updated inside sleep_thread(),
> remove it and return 0.
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   drivers/usb/gadget/f_mass_storage.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_=
mass_storage.c
> index 7eb667c130d..621852080e2 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -650,7 +650,6 @@ static void busy_indicator(void)
>  =20
>   static int sleep_thread(struct fsg_common *common)
>   {
> -	int	rc =3D 0;
>   	int i =3D 0, k =3D 0;
>  =20
>   	/* Wait until a signal arrives or we are woken up */
> @@ -684,7 +683,8 @@ static int sleep_thread(struct fsg_common *common)
>   		dm_usb_gadget_handle_interrupts(udcdev);
>   	}
>   	common->thread_wakeup_needed =3D 0;
> -	return rc;
> +
> +	return 0;
>   }
>  =20
>   /*--------------------------------------------------------------------=
=2D----*/
>=20

