Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7DDC53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 13:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C193E80E38;
	Mon, 27 Jul 2026 13:04:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lb6cJBj-Bc4s; Mon, 27 Jul 2026 13:04:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2826A80E2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785157444;
	bh=9bUF/nLfWMrDB5hgsQlRNgBJcMV7xHNbWBQytMW9KbU=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KGpJq97yYyfl6e8hJSVLSV/mLWOb0uNc+9YlvLe+LnGYIdLgWZpTuHtGW11hh1hrs
	 BrAlkBWg1+/aICWAuEzYwnp7WZ0DSVZi5iQGCYf9fg6oU+0UU5qMqXSOr5e9DXGLGr
	 BgBkxYofw7v8j7mlYLX64zt/Exjy0D93yb4Q/cUbJhSG5KFP8mlEYj/UyxTgz9Ni8w
	 jRV4nXvqD2BbKMnAWUxWkGzLHr2dMY1wDAjZjndrtavUuQU7u71LiW3wjX7xognt92
	 xl0vLUC57SveMDcRleRvUbpwfS2Ej3dT9xmIxznVECxyRXb1MbwOBpC/0QCPprKTQB
	 OgITwk+JDmDwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2826A80E2C;
	Mon, 27 Jul 2026 13:04:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B9757350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E33A80E0D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERV1go6Hot73 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 13:04:01 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DACC880E38
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DACC880E38
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DACC880E38
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:04:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C641C84671; Mon, 27 Jul 2026 15:03:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34B782991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 15:03:55 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1wZ7Wt09Pb-00P93h; Mon, 27
 Jul 2026 15:03:40 +0200
Message-ID: <effdad0f-40d0-478f-9607-6c5e8ca5101a@gmx.de>
Date: Mon, 27 Jul 2026 15:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: give SimpleTextInputEx its own WaitForKeyEx
 event
To: Daniel Golle <daniel@makrotopia.org>
References: <141397f1be56cf730a3222263c091347fa4cda4e.1784408712.git.daniel@makrotopia.org>
Content-Language: en-US
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Gregor Herburger <gregor.herburger@linutronix.de>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <141397f1be56cf730a3222263c091347fa4cda4e.1784408712.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D192jN6wn6kktygTXUhFLGY/UnnmfCvNSST1/17vY/SCR+C3Fr1
 Zm2jjbUFEPkGrGKUlSz1PBXDddFPaXQ8xrMH0hblentTkMS5Mn8Le1QTWHksoxLtyelIj4B
 m+wYVCtoG4f64dMSkMgxSN8LG8qOuqV2hwRftBXaIVpagNQtEd6bgLAyrqyj7jCC0Oz2AED
 0o8tP3XoLALO+Lsa1KtYQ==
UI-OutboundReport: notjunk:1;M01:P0:8czIg3sxODI=;FV9nWPBfLSbRX1IVR0KLyra6VcE
 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
 cT+ygiPN2hcrWOR3ZDppE
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1785157420; x=1785762220; i=xypron.glpk@gmx.de;
 bh=9bUF/nLfWMrDB5hgsQlRNgBJcMV7xHNbWBQytMW9KbU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=j/aoFiWzGfmSmp4TdfmO85M6aG89ezDShlkFkNozKvo9Zv8gHtP7hXaVnDVEz4nJ
 rfU/c1e0R0mg4ncgnPL4KS1fd392z3vzLieiqu1QHoLwt80E8gc8+D12wbMDJDiOc
 dWtFmhV+/NLWdjNB1ty6BIJIVfXilChkxL7SrUZMs+XWUo+UbFykcBirXTBF3lYaR
 F6HQXqOapjj9iKIPbsI3xFb4TTqsDTwvCMpyGuGCIctRG9tA1mwGEsVhnTEP7tFj6
 GT2c8q2adiPDtf1KcBugwbslXrXtlwPE+gc3if+485iFbLJLcynT6JTweHBOQvIbV
 JJ4fq6LGnETeGjl9pA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=j/aoFiWz
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=xypron.glpk@gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j/aoFiWz"; 
 dkim-atps=neutral
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

On 7/18/26 23:11, Daniel Golle wrote:
> The console input used a single wait event for both the
> EFI_SIMPLE_TEXT_INPUT_PROTOCOL and the EFI_SIMPLE_TEXT_INPUT_EX_PROTOCOL
> by aliasing wait_for_key_ex to wait_for_key. The UEFI specification
> describes these as separate events, and a client that opens ConInEx and
> drives WaitForKeyEx independently of the base protocol (the Windows Boot
> Manager does this) can then desynchronise against the shared object and
> never observe a keystroke, even though GRUB and systemd-boot, which lean
> on the base wait event, work.
>=20
> Create a distinct WaitForKeyEx event, and signal and clear both events
> together when a key becomes available or is consumed, so every client
> sees a consistent wait event regardless of which protocol it uses.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Hello Daniel,

Thank you for addressing this issue.

Could you, please, create a test case in lib/efi_selftest/ that fails=20
without the patch and succeeds with it.

Best regards

Heinrich

> ---
>   lib/efi_loader/efi_console.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index 8d076058280..2c8adfcb2d1 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -681,6 +681,7 @@ struct efi_cin_notify_function {
>   static bool key_available;
>   static struct efi_key_data next_key;
>   static LIST_HEAD(cin_notify_functions);
> +static struct efi_simple_text_input_ex_protocol efi_con_in_ex;
>  =20
>   /**
>    * set_shift_mask() - set shift mask
> @@ -937,6 +938,7 @@ static void efi_cin_check(void)
>  =20
>   	if (key_available) {
>   		efi_signal_event(efi_con_in.wait_for_key);
> +		efi_signal_event(efi_con_in_ex.wait_for_key_ex);
>   		return;
>   	}
>  =20
> @@ -949,8 +951,10 @@ static void efi_cin_check(void)
>   			efi_cin_notify();
>  =20
>   			/* Queue the wait for key event */
> -			if (key_available)
> +			if (key_available) {
>   				efi_signal_event(efi_con_in.wait_for_key);
> +				efi_signal_event(efi_con_in_ex.wait_for_key_ex);
> +			}
>   		}
>   	}
>   }
> @@ -1058,6 +1062,7 @@ static efi_status_t EFIAPI efi_cin_read_key_stroke=
_ex(
>   	*key_data =3D next_key;
>   	key_available =3D false;
>   	efi_con_in.wait_for_key->is_signaled =3D false;
> +	efi_con_in_ex.wait_for_key_ex->is_signaled =3D false;
>  =20
>   out:
>   	return EFI_EXIT(ret);
> @@ -1259,6 +1264,7 @@ static efi_status_t EFIAPI efi_cin_read_key_stroke
>   	*key =3D next_key.key;
>   	key_available =3D false;
>   	efi_con_in.wait_for_key->is_signaled =3D false;
> +	efi_con_in_ex.wait_for_key_ex->is_signaled =3D false;
>   out:
>   	return EFI_EXIT(ret);
>   }
> @@ -1351,7 +1357,12 @@ efi_status_t efi_console_register(void)
>   		printf("ERROR: Failed to register WaitForKey event\n");
>   		return r;
>   	}
> -	efi_con_in_ex.wait_for_key_ex =3D efi_con_in.wait_for_key;
> +	r =3D efi_create_event(EVT_NOTIFY_WAIT, TPL_CALLBACK, efi_key_notify,
> +			     NULL, NULL, &efi_con_in_ex.wait_for_key_ex);
> +	if (r !=3D EFI_SUCCESS) {
> +		printf("ERROR: Failed to register WaitForKeyEx event\n");
> +		return r;
> +	}
>   	r =3D efi_create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
>   			     efi_console_timer_notify, NULL, NULL,
>   			     &console_timer_event);

